# repository_audit_cli 🧠

> “You can’t improve what you don’t know you have.” — *Someone wise (probably during a Git cleanup)*

[![brew install](https://img.shields.io/badge/brew--install-success-green?logo=homebrew&style=flat-square)](https://github.com/raymonepping/repository_audit_cli)
[![status](https://img.shields.io/badge/ci-auto--generated-blue?style=flat-square)](./sanity_check_report.md)
[![badge](https://img.shields.io/badge/git--audit-wizard🧙‍♂️-critical?logo=github&style=flat-square)](https://medium.com/continuous-insights/from-git-repo-chaos-to-clean-insights-repository-audit-aa4c8696794e)

---

## 🎯 What Is This?

`repository_audit_cli` is a **templated, Homebrew-installable Git audit CLI** that scans a single repo or a whole folder of repositories — then exports a Markdown, CSV, or JSON report you’ll actually want to read.

---

## 🧰 How to Use

```bash
brew install raymonepping/tap/repository-audit-cli
repository_audit
```

---

## 📂 Structure

``` 
.
├── bin/                        # CLI entrypoint (repository_audit)
├── lib/                        # Modular logic and audit utils
│   ├── decision_tree.sh        # Interactive mode wizard
│   └── audit_utils.sh          # Git audit logic
├── tpl/                        # Templates for markdown, csv, json
├── repository_audit_cli.rb     # Homebrew formula
├── README.md                   # This file
└── .brewinfo                   # Optional brew metadata
```

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

## 🧠 Philosophy
Born from a real mess of forgotten Git repos, repository_audit was built to make sense of chaos — without needing a dashboard, token, or setup. It’s:

🔍 Smart enough to know when a repo is stale

🧼 Clean enough to drop into CI/CD

💡 Flexible enough to make it your own (just edit the .tpl files)

⚡ Fast enough to feel native

> "Control is clarity. Clarity is confidence." — *repository_audit*

---

© 2025 Raymon Epping

🧠 Powered by repository_audit.sh — 📚 Related Articles

📖 [Blog: "From Git Repo Chaos to Clean Insights"](https://medium.com/continuous-insights/from-git-repo-chaos-to-clean-insights-repository-audit-aa4c8696794e)  