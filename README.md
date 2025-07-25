# repository_audit 🌳

> "Structure isn't boring – it's your first line of clarity." — *You (probably during a cleanup)*

[![brew install](https://img.shields.io/badge/brew--install-success-green?logo=homebrew)](https://github.com/raymonepping/homebrew-repository_audit)
[![version](https://img.shields.io/badge/version-1.2.0-blue)](https://github.com/raymonepping/homebrew-repository_audit)

---

## 🧭 What Is This?

repository_audit is a Homebrew-installable, wizard-powered CLI.

---

## 🚀 Quickstart

```bash
brew tap 
brew install /repository_audit
repository_audit
```

---

Want to customize?

```bash
export FOLDER_TREE_HOME=/opt/homebrew/opt/..
```

---

## 📂 Project Structure

```
./
├── bin/
│   ├── CHANGELOG_repository_audit.md*
│   └── repository_audit*
├── Formula/
│   └── repository-audit-cli.rb
├── lib/
│   ├── audit_utils.sh*
│   └── decision_tree.sh*
├── tpl/
│   ├── audit_report_csv.tpl
│   ├── audit_report_footer.tpl
│   ├── audit_report_header.tpl
│   ├── audit_report_json.tpl
│   ├── audit_report_markdown.tpl
│   ├── audit_report_md.tpl
│   ├── readme_01_header.tpl
│   ├── readme_02_project.tpl
│   ├── readme_03_structure.tpl
│   ├── readme_04_body.tpl
│   ├── readme_05_quote.tpl
│   ├── readme_06_article.tpl
│   └── readme_07_footer.tpl
├── .backup.yaml
├── .backupignore
├── .version
├── LICENSE
├── README.md.old
├── reload_version.sh*
├── sanity_check.md
└── update_formula.sh*

5 directories, 26 files
```

---

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

## 🧠 Philosophy

repository_audit 

> Some might say that sunshine follows thunder
> Go and tell it to the man who cannot shine

> Some might say that we should never ponder
> On our thoughts today ‘cos they hold sway over time

---

## 📘 Read the Full Medium.com article

📖 [Article](..) 

---

© 2025 Your Name  
🧠 Powered by self_docs.sh — 🌐 Works locally, CI/CD, and via Brew
