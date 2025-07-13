#!/usr/bin/env bash

run_decision_tree() {
  tput bold; echo "🧠 Welcome to the Repository Audit Wizard"; tput sgr0

  # 1. Mode selection (numbered menu, with 'q' to quit)
  while true; do
    echo
    echo "📁 What do you want to audit?"
    select mode in "Parent folder" "Child repo" "Quit"; do
      case $REPLY in
        1) MODE="parent"; break 2 ;;
        2) MODE="child";  break 2 ;;
        3) echo "👋 Goodbye!"; exit 0 ;;
        *) echo "❌ Invalid. Please choose 1 or 2."; continue ;;
      esac
    done
  done

  # 2. Path selection (auto-default for parent/child)
  if [[ "$MODE" == "parent" ]]; then
    read -e -p "📂 Enter parent folder path to scan [$(pwd)/]: " parent
    parent="${parent:-$(pwd)}"
    child=""
  else
    read -e -p "📂 Enter single repository path to audit [$(pwd)]: " child
    child="${child:-$(pwd)}"
    parent=""
  fi

  # 3. Output format (numbered, default=1)
  echo
  echo "📝 Select output format:"
  select fmt in "Markdown" "CSV" "JSON"; do
    case $REPLY in
      1|"") format="markdown"; break ;;
      2)     format="csv";     break ;;
      3)     format="json";    break ;;
      *) echo "❌ Invalid. Please select 1, 2, or 3."; continue ;;
    esac
  done

  # 4. Output directory (auto-default)
  read -e -p "📦 Output directory [default: $(pwd)]: " outdir
  outdir="${outdir:-$(pwd)}"

  # 5. Dry run (single-key, default=N)
  read -n 1 -p "🔍 Enable dry run (no file creation)? [y/N]: " dry; echo
  [[ "$dry" =~ ^[Yy]$ ]] && dryrun="true" || dryrun="false"

  # 6. Include summary (single-key, default=N, only shown for markdown)
  summary_flag=""
  if [[ "$format" == "markdown" ]]; then
    read -n 1 -p "🧾 Include summary block at the end (markdown only)? [y/N]: " summary; echo
    [[ "$summary" =~ ^[Yy]$ ]] && summary_flag="--summary"
  fi

  # 7. Confirm + option to Go Back
  echo
  tput bold; echo "📋 You chose:"; tput sgr0
  echo "  Mode       : $MODE"
  echo "  Path       : ${parent:-$child}"
  echo "  Format     : $format"
  echo "  Output Dir : $outdir"
  echo "  Dry Run    : $dryrun"
  echo "  Summary    : $summary_flag"
  echo

  read -n 1 -p "🚀 Execute audit now? [Y/n/B to go back]: " go; echo
  if [[ "$go" =~ ^[Nn]$ ]]; then
    echo "❌ Aborted."
    exit 0
  elif [[ "$go" =~ ^[Bb]$ ]]; then
    echo "🔄 Going back to start..."
    run_decision_tree
    return
  fi

  # 8. Build + run command
  cmd="./bin/repository_audit"
  [[ -n "$parent" ]] && cmd+=" --parent \"$parent\""
  [[ -n "$child" ]] && cmd+=" --child \"$child\""
  cmd+=" --outdir \"$outdir\" --format \"$format\""
  [[ "$dryrun" == "true" ]] && cmd+=" --dryrun"
  [[ -n "$summary_flag" ]] && cmd+=" $summary_flag"

  tput bold; echo "▶️  Running: $cmd"; tput sgr0
  eval $cmd
}
