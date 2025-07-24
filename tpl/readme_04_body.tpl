## 🧭 What Is This?

repository-audit-cli is a Homebrew-installable, wizard-powered CLI for auditing your Git repositories and folder structures. It’s designed to help you quickly surface the health, compliance, and organization of your codebases—across teams or solo projects.

It’s especially useful for:

- DevOps engineers and SREs managing large codebases or multiple projects
- Teams who need to ensure all repos have proper documentation, licensing, and CI setup
- Anyone wanting a snapshot of repo health, commit history, and common issues—fast

---

## 🔑 Key Features

- 🧠 Smart decision tree mode (wizard)
- 👴🏻 Parent mode: audit all repos in a folder
- 👶🏼 Child mode: inspect a single repo
- 📄 Markdown, CSV, and JSON report support
- 💾 Timestamped report files for tracking
- 🧾 Optional Markdown summary block
- 🧩 Fully templated output via tpl/ folder
- 🍺 Brew-installable and versioned

---

### How to Audit

```bash
repository_audit --parent .
```

---

## ✨ Example Scenarios

# Wizard mode (recommended)
repository_audit

# Audit single repo with JSON output
repository_audit --child ./myrepo --format json

# Full audit on a folder with summary table
repository_audit --parent ~/Projects --format markdown --summary

# Dry run (no file writes)
repository_audit --parent ./test --dryrun

---

## 🚧 Flags Reference
Use --help to view all flags:

repository_audit --help

You can also set this to override where reports and templates are read from:

export REPOSITORY_AUDIT_HOME=/your/custom/path

---

### ✨ Other CLI tooling available

✅ **brew-brain-cli**  
CLI toolkit to audit, document, and manage your Homebrew CLI arsenal with one meta-tool

✅ **bump-version-cli**  
CLI toolkit to bump semantic versions in Bash scripts and update changelogs

✅ **commit-gh-cli**  
CLI toolkit to commit, tag, and push changes to GitHub

✅ **folder-tree-cli**  
CLI toolkit to visualize folder structures with Markdown reports

✅ **radar-love-cli**  
CLI toolkit to simulate secret leaks and trigger GitHub PR scans

✅ **repository-audit-cli**  
CLI toolkit to audit Git repositories and folders, outputting Markdown/CSV/JSON reports

✅ **repository-backup-cli**  
CLI toolkit to back up GitHub repositories with tagging, ignore rules, and recovery

✅ **repository-export-cli**  
CLI toolkit to export, document, and manage your GitHub repositories from the CLI

✅ **self-doc-gen-cli**  
CLI toolkit for self-documenting CLI generation with Markdown templates and folder visualization

---

