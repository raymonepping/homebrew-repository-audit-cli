#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

# Color codes (unused for now)
RED=$'\e[31m'
GREEN=$'\e[32m'
YELLOW=$'\e[33m'
BLUE=$'\e[34m'
RESET=$'\e[0m'

EMOJI_WARN="⚠️"
EMOJI_INFO="🔍"
EMOJI_SAVE="💾"
EMOJI_DONE="✅"
EMOJI_FAIL="❌"

TEMPLATE_DIR="./tpl"
template_file="$TEMPLATE_DIR/audit_report_md.tpl"
header_template="$TEMPLATE_DIR/audit_report_header.tpl"
footer_template="$TEMPLATE_DIR/audit_report_footer.tpl"

escape_md() {
  local input="$1"
  printf "%s" "$input" | sed -e "s/\`/\\\`/g"
}

render_row() {
  local name="$1" tag="$2" tag_count="$3" status="$4" url="$5" author="$6" readme="$7" license="$8" tracked_readme="$9" tracked_license="${10}" commits="${11}" branches="${12}" last_commit="${13}" uncommitted="${14}" dirty="${15}"
  printf "| \`%s\` | %s | %s | %s | %s | %s | %s | %s | %s | %s | %s | %s | %s | %s | %s |\n" \
    "$(escape_md "$name")" "$tag" "$tag_count" "$status" "$url" "$author" "$readme" "$license" "$tracked_readme" "$tracked_license" "$commits" "$branches" "$last_commit" "$uncommitted" "$dirty"
}

render_missing_row() {
  local name="$1" miss_readme="$2" miss_license="$3"
  [[ -z "$miss_readme" ]] && miss_readme="-" # If not missing, show "-"
  [[ -z "$miss_license" ]] && miss_license="-"
  echo "| \`$name\` | $miss_readme | $miss_license |"
}

collect_git_metadata() {
  name=$(basename "$(pwd)")
  url=$(git config --get remote.origin.url || echo '-')
  author=$(git log -1 --pretty=format:'%an <%ae>' || echo '-')
  tag=$(git describe --tags --abbrev=0 2>/dev/null || echo '-')
  tag_count=$(git tag | wc -l | tr -d ' ')
  status=$(git status --porcelain | wc -l | tr -d ' ')
  readme=$(ls -1 README* 2>/dev/null | grep -iq '^README' && echo '✅' || echo '❌')
  license=$(ls -1 LICENSE* 2>/dev/null | grep -iq '^LICENSE' && echo '✅' || echo '❌')
  IFS='|' read -r tracked_readme tracked_license < <(check_tracked_files)
  commit_count=$(git rev-list --count HEAD 2>/dev/null || echo '0')
  branch_count=$(git branch --list | wc -l | tr -d ' ')
  last_commit=$(git log -1 --pretty=format:'%cd' --date=iso 2>/dev/null || echo '-')
  has_uncommitted=$([[ "$status" -gt 0 ]] && echo "yes" || echo "no")
  dirty=$([[ -n "$(git diff --shortstat)" ]] && echo "yes" || echo "no")
}

generate_badges_block() {
  local format="$1"
  local count="$2"
  local version="$3"
  cat <<EOF
[![Audit Version](https://img.shields.io/badge/audit-v${version}-purple.svg)](#)
[![Format](https://img.shields.io/badge/format-${format}-orange.svg)](#)
[![Repos Scanned](https://img.shields.io/badge/repos-${count}-blue.svg)](#)
[![Audit Date](https://img.shields.io/badge/date-$(date +%Y--%m--%d)--$(date +%H%3A%M)-green.svg)](#)
[![Automated](https://img.shields.io/badge/powered--by-Sally-ff69b4.svg?logo=github)](#)
EOF
}

generate_summary_counts_block() {
  local -n entries_ref="$1"
  local total="${#entries_ref[@]}"
  local issues=0 dirty=0 notag=0

  for row in "${entries_ref[@]}"; do
    [[ "$row" == *"❌"* ]] && ((issues++))
    [[ "$row" == *"yes"* && "$row" == *"Dirty"* ]] && ((dirty++))
    [[ "$row" == *"| - |"* ]] && ((notag++))
  done

  printf "**Total Repos:** %d | **With Issues:** %d | **Dirty Trees:** %d | **No Tags:** %d\n" \
    "$total" "$issues" "$dirty" "$notag"
}


render_template() {
  local report_file="$1"
  local entries_block="$2"
  local summary_block="$3"
  local badges_block="$4"
  local template_file="$5"
  local missing_git_block="${6:-}"
  local summary_counts_block="${7:-}"
  local header_block="${8:-}"
  local footer_block="${9:-}"

  local template
  if [[ -f "$template_file" ]]; then
    template=$(<"$template_file")
  else
    echo "❌ Template not found: $template_file"
    exit 1
  fi

  # Replace all placeholders
  template="${template//\{\{ entries \}\}/$entries_block}"
  template="${template//\{\{ summary \}\}/$summary_block}"
  template="${template//\{\{ summary_counts \}\}/$summary_counts_block}"
  template="${template//\{\{ missing_git \}\}/$missing_git_block}"
  template="${template//\{\{ header \}\}/$header_block}"
  template="${template//\{\{ footer \}\}/$footer_block}"
  template="${template//@@BADGES@@/$badges_block}"

  printf "%s\n" "$template" >"$report_file"
}

render_csv() {
  local report_file="$1"
  shift
  local -a rows=("$@")
  echo "Repo,Latest Tag,Tag Count,Status,Remote URL,Last Committer,README,LICENSE,Git-tracked README,Git-tracked LICENSE,Commit Count,Branch Count,Last Commit Timestamp,Uncommitted Files,Dirty Working Tree" >"$report_file"
  for row in "${rows[@]}"; do
    local trimmed="${row#| }"
    trimmed="${trimmed% |}"
    IFS="|" read -r name tag tag_count status url author readme license tracked_readme tracked_license commits branches last_commit uncommitted dirty <<<"$trimmed"
    name="$(echo "$name" | sed -e 's/^ *\`//' -e 's/\` *$//' -e 's/^ *//' -e 's/ *$//')"
    tag="$(echo "$tag" | xargs)"
    tag_count="$(echo "$tag_count" | xargs)"
    status="$(echo "$status" | xargs)"
    url="$(echo "$url" | xargs)"
    author="$(echo "$author" | xargs)"
    readme="$(echo "$readme" | xargs)"
    license="$(echo "$license" | xargs)"
    tracked_readme="$(echo "$tracked_readme" | xargs)"
    tracked_license="$(echo "$tracked_license" | xargs)"
    commits="$(echo "$commits" | xargs)"
    branches="$(echo "$branches" | xargs)"
    last_commit="$(echo "$last_commit" | xargs)"
    uncommitted="$(echo "$uncommitted" | xargs)"
    dirty="$(echo "$dirty" | xargs)"
    echo "$name,$tag,$tag_count,$status,$url,$author,$readme,$license,$tracked_readme,$tracked_license,$commits,$branches,$last_commit,$uncommitted,$dirty" >>"$report_file"
  done
}

render_json() {
  local report_file="$1"
  shift
  local -a rows=("$@")
  {
    echo "["
    local first=1
    for row in "${rows[@]}"; do
      local trimmed="${row#| }"
      trimmed="${trimmed% |}"
      IFS="|" read -r name tag tag_count status url author readme license tracked_readme tracked_license commits branches last_commit uncommitted dirty <<<"$trimmed"
      [[ $first -eq 0 ]] && echo ","
      name="$(echo "$name" | sed -e 's/^ *\`//' -e 's/\` *$//' -e 's/^ *//' -e 's/ *$//')"
      tag="$(echo "$tag" | xargs)"
      tag_count="$(echo "$tag_count" | xargs)"
      status="$(echo "$status" | xargs)"
      url="$(echo "$url" | xargs)"
      author="$(echo "$author" | xargs)"
      readme="$(echo "$readme" | xargs)"
      license="$(echo "$license" | xargs)"
      tracked_readme="$(echo "$tracked_readme" | xargs)"
      tracked_license="$(echo "$tracked_license" | xargs)"
      commits="$(echo "$commits" | xargs)"
      branches="$(echo "$branches" | xargs)"
      last_commit="$(echo "$last_commit" | xargs)"
      uncommitted="$(echo "$uncommitted" | xargs)"
      dirty="$(echo "$dirty" | xargs)"
      echo "  {"
      echo "    \"repo\": \"$name\","
      echo "    \"latest_tag\": \"$tag\","
      echo "    \"tag_count\": \"$tag_count\","
      echo "    \"status\": \"$status\","
      echo "    \"remote_url\": \"$url\","
      echo "    \"last_committer\": \"$author\","
      echo "    \"readme\": \"$readme\","
      echo "    \"license\": \"$license\","
      echo "    \"tracked_readme\": \"$tracked_readme\","
      echo "    \"tracked_license\": \"$tracked_license\","
      echo "    \"commit_count\": \"$commits\","
      echo "    \"branch_count\": \"$branches\","
      echo "    \"last_commit_timestamp\": \"$last_commit\","
      echo "    \"uncommitted_files\": \"$uncommitted\","
      echo "    \"dirty_working_tree\": \"$dirty\""
      echo -n "  }"
      first=0
    done
    echo ""
    echo "]"
  } >"$report_file"
}

render_report() {
  local format="$1"
  local report_file="$2"
  local -n entries="$3"
  local -n summary="$4"
  local template_file="$5"
  local badges_block="${6:-}"

  case "$format" in
  markdown)
    render_template "$report_file" "$(printf "%s\n" "${entries[@]}")" "$(printf "%s\n" "${summary[@]}")" "$badges_block" "$template_file"
    ;;
  csv)
    render_csv "$report_file" "${entries[@]}"
    ;;
  json)
    render_json "$report_file" "${entries[@]}"
    ;;
  *)
    echo "❌ Unknown format: $format"
    exit 1
    ;;
  esac
}

print_summary() {
  local report="$1"
  local count
  local commits branches
  count=$(awk '/^### 📋 Summary/ { exit } /^\|/ { n++ } END { print n }' "$report")
  commits=$(awk -F'|' '/^\|/ && !/Repo/ && !/^###/ { gsub(/ /, "", $12); sum += $12 } END { print sum }' "$report")
  branches=$(awk -F'|' '/^\|/ && !/Repo/ && !/^###/ { gsub(/ /, "", $13); sum += $13 } END { print sum }' "$report")
  echo -e "\n## 🧾 Summary Block (Tail)\n- Total repositories audited: $count" >>"$report"
  echo "- Total commits across all repos: $commits" >>"$report"
  echo "- Total branches across all repos: $branches" >>"$report"
}

# Reads .auditignore (if present in scan root) and checks if $1 matches any line (case-insensitive)
is_auditignored() {
  local dir="$1"
  local ignorefile="$2"
  [[ ! -f "$ignorefile" ]] && return 1
  shopt -s nocasematch
  while IFS= read -r pattern; do
    [[ -z "$pattern" || "$pattern" == \#* ]] && continue
    [[ "$dir" == "$pattern" || "$dir" == */"$pattern" || "$dir" == "$pattern"/* ]] && return 0
  done <"$ignorefile"
  shopt -u nocasematch
  return 1
}

check_tracked_files() {
  local tracked_readme="❌" tracked_license="❌"
  git ls-files | grep -i -q '^README' && tracked_readme="✅"
  git ls-files | grep -i -q '^LICENSE' && tracked_license="✅"
  echo "$tracked_readme|$tracked_license"
}

audit_parent() {
  local parent="$1" report="$2" format="$3" dryrun="$4" header_template="$5" footer_template="$6"

  echo "$EMOJI_SAVE Auditing repositories under: $parent"
  parent="${parent%/}"

  local ignorefile="$parent/.auditignore"
  local -a ignored_dirs=()

  # Parse .auditignore if it exists
  if [[ -f "$ignorefile" ]]; then
    while IFS= read -r line; do
      [[ -z "$line" || "$line" == \#* ]] && continue
      ignored_dirs+=("$line")
    done <"$ignorefile"
    echo "$EMOJI_INFO Using .auditignore: $ignorefile"
    [[ ${#ignored_dirs[@]} -gt 0 ]] && echo "$EMOJI_INFO Ignoring folders: ${ignored_dirs[*]}" || echo "$EMOJI_INFO No folders ignored (empty .auditignore)."
  fi

  # Get all immediate subdirs and .git dirs
  mapfile -t all_dirs < <(find "$parent" -mindepth 1 -maxdepth 1 -type d | sort)
  mapfile -d '' -t gitdirs < <(find "$parent" -name .git -type d -prune -print0 | sort -z)

  # Build map of git repos
  declare -A git_repos=()
  for gitdir in "${gitdirs[@]}"; do
    local repo="${gitdir%/.git}"
    git_repos["$repo"]=1
  done

  # Init result arrays
  local -a audit_entries=()
  local -a missing_entries=()
  local -a missing_git_rows=()

  for dir in "${all_dirs[@]}"; do
    local repo_base
    repo_base=$(basename "$dir")

    if is_auditignored "$repo_base" "$ignorefile"; then
      echo "$EMOJI_INFO Skipping ignored folder: $repo_base"
      continue
    fi

    if [[ -d "$dir/.git" ]]; then
      pushd "$dir" >/dev/null || continue
      git rev-parse --is-inside-work-tree >/dev/null 2>&1 || { popd >/dev/null; continue; }

      # Collect metadata
      local name url author tag tag_count status readme license tracked_readme tracked_license
      local commit_count last_commit branch_count has_uncommitted dirty

      name="$repo_base"
      collect_git_metadata

      audit_entries+=("$(render_row "$name" "$tag" "$tag_count" "$status" "$url" "$author" "$readme" "$license" "$tracked_readme" "$tracked_license" "$commit_count" "$branch_count" "$last_commit" "$has_uncommitted" "$dirty")")

      if [[ "$readme" == "❌" || "$license" == "❌" ]]; then
        missing_entries+=("$(render_missing_row "$name" "$([[ $readme == "❌" ]] && echo '❌')" "$([[ $license == "❌" ]] && echo '❌')")")
      fi

      popd >/dev/null || continue
    else
      missing_git_rows+=("| \`$repo_base\` | ❌ Not a git repo |")
    fi
  done

  if [[ "$format" == "markdown" ]]; then
    local badges_block
    badges_block="$(generate_badges_block "$format" "${#audit_entries[@]}" "$VERSION")"

    local summary_counts_block
    summary_counts_block="$(generate_summary_counts_block audit_entries)"

    local header_block footer_block
    header_block="$(<"$header_template")"
    footer_block="$(<"$footer_template")"

    local missing_git_block=""
    if [[ "${#missing_git_rows[@]}" -gt 0 ]]; then
      missing_git_block+=$'\n### 🚫 Folders Missing Git Repo\n'
      missing_git_block+="| Folder | Status |\n|--------|--------|\n"
      missing_git_block+=$(printf "%s\n" "${missing_git_rows[@]}")
    fi

    render_template \
      "$report" \
      "$(printf "%s\n" "${audit_entries[@]}")" \
      "$(printf "%s\n" "${missing_entries[@]}")" \
      "$badges_block" \
      "$template_file" \
      "$missing_git_block" \
      "$summary_counts_block" \
      "$header_block" \
      "$footer_block"

  else
    render_report "$format" "$report" audit_entries missing_entries "$template_file" ""
  fi
}

audit_child() {
  local child="$1" report="$2" format="$3" dryrun="$4" header_template="$5" footer_template="$6"

  # Validate that the child is a git repo
  if ! git -C "$child" rev-parse --is-inside-work-tree >/dev/null 2>&1; then
    echo "❌ Not a git repository: $child"
    return 1
  fi

  local name url author tag tag_count status readme license tracked_readme tracked_license
  local commit_count last_commit branch_count has_uncommitted dirty
  local -a child_entries=()
  local -a child_missing=()

  # Collect metadata using git -C to avoid pushd/popd
  name="$(basename "$child")"
  url="$(git -C "$child" config --get remote.origin.url || echo '-')"
  author="$(git -C "$child" log -1 --pretty=format:'%an <%ae>' || echo '-')"
  tag="$(git -C "$child" describe --tags --abbrev=0 2>/dev/null || echo '-')"
  tag_count="$(git -C "$child" tag | wc -l | tr -d ' ')"
  status="$(git -C "$child" status --porcelain | wc -l | tr -d ' ')"
  has_uncommitted=$([[ "$status" -gt 0 ]] && echo "yes" || echo "no")
  dirty=$([[ "$status" -gt 0 ]] && echo "yes" || echo "no")
  readme=$(ls -1 "$child"/README* 2>/dev/null | grep -iq '^README' && echo '✅' || echo '❌')
  license=$(ls -1 "$child"/LICENSE* 2>/dev/null | grep -iq '^LICENSE' && echo '✅' || echo '❌')
  commit_count="$(git -C "$child" rev-list --count HEAD 2>/dev/null || echo '0')"
  last_commit="$(git -C "$child" log -1 --pretty=format:'%cd' --date=iso 2>/dev/null || echo '-')"
  branch_count="$(git -C "$child" branch --list | wc -l | tr -d ' ')"

  # Git-tracked files (reuse function if possible, or inline)
  local tracked_readme="❌" tracked_license="❌"
  git -C "$child" ls-files | grep -i -q '^README' && tracked_readme="✅"
  git -C "$child" ls-files | grep -i -q '^LICENSE' && tracked_license="✅"

  child_entries+=("$(render_row "$name" "$tag" "$tag_count" "$status" "$url" "$author" "$readme" "$license" "$tracked_readme" "$tracked_license" "$commit_count" "$branch_count" "$last_commit" "$has_uncommitted" "$dirty")")

  if [[ "$readme" == "❌" || "$license" == "❌" ]]; then
    child_missing+=("$(render_missing_row "$name" "$([[ "$readme" == "❌" ]] && echo '❌')" "$([[ "$license" == "❌" ]] && echo '❌')")")
  fi

  # Blocks for rendering (same as parent)
  local badges_block summary_counts_block
  badges_block="$(generate_badges_block "$format" "${#child_entries[@]}" "$VERSION")"
  summary_counts_block="$(generate_summary_counts_block child_entries)"

  local header_block footer_block
  header_block="$(<"$header_template")"
  footer_block="$(<"$footer_template")"

  # Consistently write to the correct $report, as with parent
  if [[ "$format" == "markdown" ]]; then
    render_template \
      "$report" \
      "$(printf "%s\n" "${child_entries[@]}")" \
      "$(printf "%s\n" "${child_missing[@]}")" \
      "$badges_block" \
      "$template_file" \
      "" \
      "$summary_counts_block" \
      "$header_block" \
      "$footer_block"
  else
    render_report "$format" "$report" child_entries child_missing "$template_file" ""
  fi
}
