🔍 Building My Own Git Repo Auditor - Now Brew-Ready, Fork-Friendly, and Actually Useful

🧠 Born from a real need, brewed with care, and designed to flex.
🤔 Why I Built This

Let me be honest - I was tired of forgetting what was inside my own folders.

I had directories filled with half-baked scripts, abandoned side-projects, and Git repos with questionable commit hygiene. Every once in a while, I'd rediscover one and wonder, "Wait, when did I last touch this?" or worse, "Did I even commit the README?"

Sure, tools like gh repo list or GitHub's UI can give you an overview. But nothing gave me the local view, the flexibility, or the insight I needed - especially for large nested folder structures. I wanted a tool that could:
 • 🔍 Audit all repos in a parent folder at once
 • 🧪 Or just quickly inspect one child repo on the fly
 • 📄 Generate rich, clean Markdown, CSV, or JSON reports
 • 🧾 Give me a summary I could glance at - or collapse into details
 • 💡 Help me spot missing docs, uncommitted changes, orphaned repos

And so, repository_audit was born.

⸻

🛠️ What It Does (v1.0.3)

With a single command or an interactive wizard, the CLI gives you:

Feature Description
🧠 Smart Decision Tree Walks you through auditing a parent folder or single repo
📁 Parent Mode Scans all children in a directory, detecting Git status and key metadata
🧒 Child Mode Audits a single Git repo with quick glance info
📄 Format Options Markdown (default), CSV, and JSON reports supported out of the box
🧪 Dry Run Simulate audits without writing any files
🧾 Markdown Summary Block Optional: Add summary tables at the bottom of .md reports
🧩 Template-Driven Reports Uses tpl/ folder so you can fully customize output structure
🍺 Homebrew Installable Brew it, use it anywhere, update it like a pro

⸻

💻 How It Works

It's a Bash CLI. But not your average if [ "$1" == " - help" ] Bash script.

Under the hood:
 • ✅ Strict Bash mode with proper error handling
 • 🔗 Modularized logic split into lib/ and bin/
 • 📂 Smart path detection (works whether installed via brew or used in dev)
 • 🧠 Interactive wizard logic lives in decision_tree.sh
 • 🧰 Core logic lives in audit_utils.sh and handles:
 • Tag detection
 • Commit counts
 • Branch tracking
 • Dirty working tree checks
 • README / LICENSE presence
 • Timestamping

It's clean, it's modular, and it's built to be used by humans and scripts alike.

⸻

📦 Install via Homebrew

Yup - it's fully packaged and distributed through my own tap.

brew tap raymonepping/repository-audit-cli
brew install repository-audit-cli

Or upgrade anytime:

brew upgrade repository-audit-cli

Pro tip: Set the environment variable below if you want to override report locations or templates:

export REPOSITORY_AUDIT_HOME=/your/custom/path

⸻

🧪 Example Output: Markdown

The CLI will generate reports like this by default:

# 🧾 Repository Audit Report

| Repo. | Latest Tag | Commits | Dirty | README | LICENSE | Last Commit |
| -  -  -  -  -  -  -  - -| -  -  -  -  -  - | -  -  -  - -| -  -  - -| -  -  -  - | -  -  -  - -| -  -  -  -  -  - -|
| radar_love_cli. | v2.7.0. | 118. | No. | ✅. | ✅. | 2025–07–10. |
| sanity_tools. | (none) | 8. | Yes. | ❌. | ❌. | 2025–06–22. |

But if you're feeling fancy, you can tweak the Markdown templates to wrap every repo in <details> blocks. Collapse less important details, highlight errors, or create a GitHub-friendly export - it's all powered by the tpl/ system.

The templates are decoupled from the logic - meaning the tool is as flexible as you need it to be.

⸻

🎯 Why "Parent" vs "Child" Mode Matters

Let's talk real use cases:
 • 🗃 Parent Mode: You've got a directory like ~/Projects with 20+ subfolders. Some are full repos, some aren't. You forgot what's in half of them. repository_audit tells you which ones:
 • Are valid Git repos
 • Have recent commits
 • Are still on main or tracking remote branches
 • Are missing documentation
 • Are dirty and probably deserve a push (👀)
 • 🧒 Child Mode: You're working on a single repo and want a quick overview - tag status, commit count, is it dirty, etc. Great for quick checks or integrating into a pre-release checklist.

Both modes are useful. That's why they both exist.

⸻

🧩 The Power of Templates

Most tools hardcode their output.

Not this one.

The CLI ships with template files:
 • audit_report_md.tpl
 • audit_report_csv.tpl
 • audit_report_json.tpl

You can:
 • 📦 Replace them to customize the layout
 • 🔧 Extend them to include new fields
 • 🧪 Preview formatting changes without touching the core logic

Template-based reporting means anyone can fork the tool and make it their own - without breaking the CLI.

⸻

🌍 Forkability & Extendability

This project was designed from day one to be fork-friendly. You can:
 • 🍴 Clone or fork the GitHub repo
 • ✏️ Tweak the tpl/ templates to your own liking
 • 🔄 Extend the core audit logic with your own lib/*.sh functions
 • 🍺 Package and tap your own version via Homebrew (brew tap myname/mycli)

And since the official templates and logic are versioned separately, your version won't interfere with mine.

⸻

🧑‍🎨 UX Plans for the Future

While v1.0.3 is already solid, I have big plans for polishing the experience.

Here's what's coming next:

✅ 1. Group Columns Logically

Prioritize the most useful fields: Repo, Tag, Commits, Dirty.

✅ 2. Collapse "Yes/No" Fields

Instead of verbose columns like README, LICENSE, Docs, compress them into a single "📄 Docs Status" column with emojis.

✅ 3. Add Markdown <details> Sections

Hide extended details for each repo in collapsible blocks - perfect for large audits.

✅ 4. Compact Table, Verbose Details Mode

Let users pick between a minimal table + detailed block style vs. full-table layouts.

All made possible by our template-first architecture.

⸻

🧠 Final Thoughts

This isn't just a fun side project.

It's a real, usable, brew-installable CLI - designed to audit your Git repos, detect red flags, and generate beautiful, exportable reports.

It helps you:
 • Keep track of what you own
 • Avoid neglected or misconfigured projects
 • Document what matters
 • Automate better with Bash

⸻

🚀 Try it Yourself

brew tap raymonepping/repository-audit-cli
brew install repository-audit-cli
repository_audit  - help

Or just run:

repository_audit

And follow the wizard. It's friendly. Promise. 🤖

⸻

🧭 Next Steps

I'm planning to:
 • Add test coverage for more edge cases
 • Polish the CSV/JSON report formatting
 • Add GitHub Actions support to auto-run audits on PRs
 • Possibly ship it as part of a broader repo hygiene toolkit

⸻

🧠 Born from How I Use AI as My DevOps Copilot

🤖 Powered by Sally  -  my AI DevOps copilot
🚀 Because automation should automate itself

📘 Journey recap: Turning From 50 Shades of Red into Blue

⸻
🧠 From Forgotten Repos to Auditable Gold: Why I Built repository_audit

"You ever open a folder and think… wait, what was this project again? Yeah. Same."

That realization - mixed with some healthy shame and curiosity - led me down a rabbit hole that became repository_audit. A Homebrew-installable CLI tool that helps you quickly understand, document, and track the state of your Git repositories - whether it's one, or an entire forgotten family tree of them.

⸻

🧩 Why I Built It

I've lost count of how often I ended up in a local folder with 30+ projects and no idea what's still active, which ones are dirty, which have a README, or whether they've been updated in the last year.

Yes, I could've written a throwaway Bash loop - but that's not the point.

I wanted something:
 • That anyone can install and run
 • That looks good in Markdown
 • That supports CSV/JSON exports for tracking
 • That I could share, use, and forget - until I need it again

Enter repository_audit.

⸻

🛠️ What It Does - and What Makes It Shine

While tools like the gh CLI and git plumbing commands can give you raw data, they don't:
 • Give you clean, human-readable reports
 • Bundle output into shareable .md, .csv, or .json
 • Provide summary blocks or allow toggling verbosity
 • Include a decision tree wizard to guide the UX
 • Ship via Homebrew so you can brew install and go

That's where this shines. It's opinionated. But flexible. And installable with a single line.

⸻

🧪 Key Features
 • ✅ Parent Mode: Scan a whole folder full of Git repos
 • 📦 Child Mode: Audit a single repository quickly
 • 📄 Export Formats:  - format markdown, csv, or json
 • 🔍 Dry Run support: simulate before writing files
 • 🧾 Summary Block: markdown footer with key stats
 • 🧠 Interactive Wizard: no need to memorize flags

Whether you're curating a GitHub portfolio, auditing a codebase, or just trying to clean up your ~/projects, this CLI helps you see what's what in seconds.

⸻

💡 UX That Asks, Not Assumes

Not everyone wants to remember flags. Sometimes you just want to run:

repository_audit

…and be guided.

So that's what it does. If no flags are passed, the CLI starts an interactive decision tree, asking you:
 • What you want to scan
 • What format to export
 • Whether to simulate or write files
 • Whether to include a summary

Power users can still go full CLI with  - parent,  - outdir, and  - format, but the wizard mode makes it friendly for casual use too.

⸻

📊 Example Use Case: Audit All Projects in a Folder

repository_audit  - parent ~/Documents/Git  - outdir ~/Desktop  - format markdown

You'll get a timestamped Markdown report like:

## 📁 Repo Audit - 2025–07–13

| Repository. | Commits | Branches | Dirty | README | License | Last Commit |
| -  -  -  -  -  -  -  -  - -| -  -  -  - -| -  -  -  -  - | -  -  - -| -  -  -  - | -  -  -  - -| -  -  -  -  -  - -|
| repository_audit. | 146. | 2. | No. | ✅. | ✅. | 2025–07–13. |
| radar_love_cli. | 378. | 3. | Yes. | ✅. | ✅. | 2025–07–10. |

Yes - it's going to get prettier. More on that soon.

⸻

🛣️ The Road Ahead

We're just getting started.

Here's what's cooking for upcoming versions:
 • ✨ Collapsible <details> sections in Markdown
 • 🧠 Grouped columns and compact visual layout
 • 📛 Badge support for README, LICENSE, Tests, etc.
 • 📊 Cross-repo summaries like most stale, most active
 • ☁️ Optional GitHub API support (for public repos)

Oh - and of course, all of this is driven by templating. Meaning every format (.md, .csv, .json) is tweakable via tpl/ so you can customize, override, or extend it yourself.

⸻

🧪 Dev-friendly, Brew-installable

This was never meant to stay locked to my local machine.

brew tap raymonepping/repository-audit-cli
brew install repository-audit-cli

Or update via:

brew upgrade repository-audit-cli

The formula handles paths correctly and supports REPOSITORY_AUDIT_HOME overrides if you're developing locally.

⸻

🤝 In Closing: It's For You. And Me.

Whether you're:
 • Auditing legacy code
 • Preparing a compliance snapshot
 • Cleaning your repo graveyard
 • Or just making peace with the chaos of your dev folders…

This tool gives you clarity, fast.

And for me? It's become a habit. A simple way to reconnect with code I forgot I wrote, and start owning it again.

⸻

🚀 Want to Contribute?

PRs welcome. Ideas welcome. Feedback welcome. This is just v1.0.x - the real fun begins now.

And remember:

"You can't improve what you don't know you have."

⸻
🚀 Bringing Git Repository Audits into the Future

Have you ever looked at a massive folder filled with numerous Git repositories and thought: "Do I even remember what's in here? Are they up-to-date? Which of these still lack proper documentation or licenses?" I sure have. As a DevOps engineer and automation enthusiast, I love structure, clarity, and above all - automation.

Let me introduce you to a tool that brings all these things neatly together: repository_audit.

⸻

🌟 The Problem: The Chaos of Git Management

I often found myself facing two recurring challenges:
 • Parent-level audits: Navigating folders with dozens (sometimes even hundreds!) of Git repositories, and quickly understanding their overall health.
 • Child-level audits: Needing a lightning-fast overview of just one single repository's status, especially when I'm about to hand it off, archive it, or start working on it again.

Sure, there are tools like git status and various GitHub integrations that can handle isolated pieces of the puzzle. But there wasn't a straightforward, flexible tool that could swiftly provide clear insights - especially not in multiple formats.

So I decided to create my own, streamlined CLI toolkit to fill that gap.

⸻

🛠 My Solution: Meet repository_audit

With repository_audit, you get a single, unified CLI that's flexible enough to adapt to both broad and narrow scopes of audits - depending on your needs.

What makes it special?
 • 📂 Flexible Audit Scopes: Audit entire parent directories with ease, or zero in on a specific repository. Sometimes you just forget about your 'children', and having the ability to audit them all at once feels like parenting done right.
 • 📋 Multi-Format Reporting: JSON, CSV, and Markdown support out-of-the-box. JSON and CSV make data integrations effortless, and Markdown provides beautiful, readable documentation for human reviewers.
 • 🎛 Template-driven Reports: The Markdown format is entirely driven by flexible templates (tpl files). That means your reports evolve alongside your needs, and customization is limitless.
 • 💎 Brew Integration: It's not just a script - it's now a Homebrew CLI! One brew install command, and your entire audit toolkit is installed. I love convenience, and I bet you do too.
 • 🌟 Interactive Decision Tree: No need to remember cryptic flags. Just type repository_audit and let the intuitive, interactive wizard guide you step-by-step. Simplicity meets power, wrapped in a smooth UX.

⸻

🎨 An Elegant User Experience

Here's the real magic: UX and clarity. Let me give you a taste of how straightforward it feels:

$ repository_audit
🧠 Welcome to the Repository Audit Wizard

📁 What do you want to audit?
1) Parent folder
2) Child repo
3) Quit
#? 1

📂 Enter parent folder path to scan [default: current]: ./projects

📝 Select output format:
1) Markdown
2) CSV
3) JSON
#? 1

📦 Output directory [default: current]: ./audits

🔍 Enable dry run (no file creation)? [y/N]: n
🧾 Include summary block at the end (markdown only)? [y/N]: y

🚀 Execute audit now? [Y/n]: y

And just like that, you get a beautiful, structured report clearly summarizing the critical aspects of your Git repositories.

⸻

🎯 Future Roadmap & Suggestions for Enhanced Experience

Great tools never sit still. I'm continually thinking about the next wave of enhancements, especially around how our Markdown reports could become even more intuitive and informative. Here's a preview of some upcoming enhancements:
 • Logical Column Grouping: Clarity is key - group columns logically, collapsing similar metadata into clear categories.
 • Single-Column "Docs" Status: Reduce clutter. Combine README, LICENSE, and other yes/no fields into one concise visual indicator.
 • Collapsible Sections: Leveraging Markdown's collapsible <details> sections, we'll soon provide compact high-level summaries, with hidden verbose detail accessible just one click away.
 • Compact Table & Verbose Details: Quick-glance summary tables backed by detailed per-repository deep dives. Perfect for overviews and detailed reviews alike.
 • Dynamic Emoji Indicators: Bring intuitive visualization with clear emoji indicators - at a glance, understand your repo's health status (✅, ⚠️, 🚫).
 • Interactive HTML Report: Generate interactive HTML-based summaries with collapsible details, filters, and search capabilities directly from CLI output.

⸻

🎖 Why Use repository_audit?

Here's the wow-factor clearly spelled out:
 • Automation-First Mindset: No more manual checkups - automate your audits and spend your valuable time on impactful development tasks.
 • Clarity at a Glance: Quickly understand the state of your repositories without diving into each manually.
 • Customization: Report layouts adapt to your specific needs. Need extra detail? Done. Want it cleaner? Easy.
 • Convenience & Integration: Easy installation via Homebrew and seamless integration with your existing scripts and CI/CD pipelines.
 • Beautiful & Intuitive: Friendly UX, intuitive CLI wizards, and polished reports. It's a tool you'll genuinely enjoy using.

⸻

🧠 Final Thoughts & Next Steps

I started this project from a personal need - to simplify and automate what was previously tedious and manual. Now, after polishing and packaging it up into an easy-to-install Homebrew formula, I believe it's ready for others to benefit from.

And yet, it's only the beginning. More enhancements are coming - interactive HTML reports, dynamic template generation, and smarter decision logic to name just a few.

The best part? It's entirely open, flexible, and driven by real-world use cases. I'd love your feedback, suggestions, or feature requests to make repository_audit even more powerful.

Give it a try:

brew tap raymonepping/repository-audit-cli
brew install repository-audit-cli

repository_audit  - help

Let me know your thoughts - together, let's make Git repository audits painless and powerful.

🧠 Born from How I Use AI as My DevOps Copilot
🤖 Powered by Sally - my AI DevOps copilot
🚀 Because automation should automate itself.
-
Automating Git Repository Audits with Repository Audit CLI

Managing multiple Git repositories, either as a developer or within enterprise teams, often becomes cumbersome. I realized this pain point personally while juggling various GitHub projects and local repositories. Tracking down individual repository health, checking documentation presence, or ensuring standardized metadata across repositories quickly becomes an overwhelming chore.

Why Another Audit Tool?

Sure, plenty of auditing tools already exist. The GitHub API can provide repository details, git CLI scripts can run simple checks, and custom Python scripts can flexibly generate various reports. However, they lacked ease of use, user-centric design, and the ability to provide quick insights without manual coding or API handling each time.

I wanted something:
 • Interactive & intuitive for quick everyday use.
 • Capable of handling both individual repos (child) and entire directories of repositories (parent).
 • Generating reports in multiple formats (Markdown, CSV, JSON) for diverse needs.
 • Easy to distribute and manage via Homebrew.

That's why I created Repository Audit CLI.

Introducing Repository Audit CLI

This CLI tool effortlessly audits Git repositories, providing detailed yet readable reports. The interactive decision tree allows intuitive, error-free inputs.

UX & User-Centric Design

The decision to integrate an interactive wizard was intentional:
 • Reducing Cognitive Load: By offering numbered menus, users have fewer opportunities for input errors.
 • Flexibility & Clarity: Users effortlessly choose the parent or child mode, select output formats, and specify output directories.

The interactive approach made the tool much more approachable and reduced barriers, especially for users less comfortable with complex CLI arguments.

Real-World Use Cases
 • Enterprise Teams: Quickly audit numerous repositories for missing README or LICENSE files for compliance purposes.
 • Personal Developers: Rapid overview of personal GitHub or local repositories, identifying neglected repositories at a glance.
 • Open Source Maintainers: Easy checks across many repositories for documentation presence and codebase consistency.

Imagine managing 50+ microservices as separate Git repositories. Running individual manual checks would be time-consuming. Repository Audit CLI scans all child repositories from the parent folder effortlessly, producing clear, actionable reports.

Technical Architecture & Decisions

Several technical choices shaped the tool:
 • Modular Bash Scripts: Lightweight, fast, and highly compatible.
 • Template-Based Reports: .tpl files for each report format offer flexible and customizable outputs.
 • Homebrew Distribution: Simplifies installation, updates, and management, making it accessible even to less technical users.

The choice of Homebrew significantly streamlined user adoption and version management.

Comparative Analysis

Feature GitHub API git CLI Scripts Custom Python Scripts Repository Audit CLI
User-Friendly UX ❌ ❌ ⚠️ ✅ Intuitive Wizard
Speed ⚠️ ✅ ⚠️ ✅ Fast & Efficient
Output Formats JSON Manual Coding Custom ✅ MD, CSV, JSON
Flexibility ⚠️ ❌ ✅ Complex ✅ Highly Customizable

This comparison clarifies Repository Audit CLI's distinct advantages in ease of use, flexibility, and quick adoption.

Future Roadmap

As powerful as it already is, I envision even more improvements:
 • Enhanced Markdown Reports: Collapsible sections, clearer formatting, grouped logical columns.
 • Automated Scheduled Audits: Integrate with cron jobs or CI/CD pipelines.
 • Advanced GitHub Integration: Leveraging GitHub Actions for event-driven audit automation.
 • Web-Based UI Dashboard: A visual and interactive repository analytics platform.

Community & Open Source Engagement

Open-source at its core, Repository Audit CLI thrives on community contributions:
 • Contribute new templates for reporting.
 • Report bugs, request features, or submit PRs on GitHub.
 • Provide feedback to shape future development.

The GitHub repository actively welcomes contributions and collaboration, ensuring the CLI evolves to meet user needs.

Lessons Learned & Reflections

Creating Repository Audit CLI taught me valuable lessons:
 • UX Matters: Simple design changes drastically reduced friction.
 • Flexibility Through Templates: Supporting multiple output formats greatly increased utility.
 • Homebrew Advantage: Simplifying distribution vastly improved accessibility.

These insights continue to influence my approach to future tool development.

Conclusion & Next Steps

Repository Audit CLI is a powerful, intuitive, and flexible auditing tool designed explicitly with user experience in mind. It simplifies auditing at scale, generates clear reports, and offers unmatched flexibility through its template system.

Next, I aim to refine report readability further, introduce automated scheduling, and expand community engagement. I invite you to explore the tool, contribute your ideas, and help shape its future.

Because auditing Git repositories should be as effortless as committing code.

Explore Repository Audit CLI on GitHub: https://github.com/raymonepping/repository_audit_cli
 - 
Perfect - here's how we can inject that "wow" reflection directly into the article, without sounding boastful or breaking the narrative flow.
🧠 Dev-First by Design: Why This Tool is Different
Let's be honest - there are other tools that parse Git, export logs, or even generate CSVs. But here's why this little CLI punches way above its weight:
 • 🌳 Parent & Child Mode:
Most tools audit a single repo. We built both:
 • Parent Mode to crawl and rediscover long-forgotten projects in bulk.
 • Child Mode for fast diagnostics in one specific repo.
It's a lifeline for developers juggling too many folders and side quests.
 • 🧪 Multi-Format Reports:
Markdown for humans. CSV for spreadsheets. JSON for pipelines.
Choose your output with a flag - no reformatting needed.
 • 📦 Templated Output with tpl/:
You don't like the report? Tweak the template.
We separated logic from rendering so anyone can tailor the output without rewriting logic.
 • ☕ Instant Value - No Setup:
No tokens. No .gitconfig. No onboarding.
You can run it right after install and get value within 10 seconds.
 • 🍺 Brew-Ready and Portable:
The CLI installs via Homebrew and plays nicely with version bumps,  - help,  - version, and even dry runs - making it feel more like a polished open-source package than a throwaway Bash script.
This isn't just another utility script. It's the beginning of a self-healing Git hygiene habit - the kind of tool that makes sense on a Friday afternoon, and shines on a Monday morning.