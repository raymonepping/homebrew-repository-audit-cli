class RepositoryAuditCli < Formula
  desc "CLI toolkit for auditing Git repositories and folders with markdown/csv/json reports"
  homepage "https://github.com/raymonepping/repository_audit_cli"
  url "https://github.com/raymonepping/homebrew-repository-audit-cli/archive/refs/tags/v1.0.11.tar.gz"
  sha256 "d641b9e3c8017c5de0a128cb9c0df0a988bbecc30540fc9058583649e7232d97"
  license "MIT"
  version "1.0.11"

  depends_on "bash"

  def install
    bin.install "bin/repository_audit" => "repository_audit"
    pkgshare.install "lib", "tpl"
    doc.install "README.md"
  end

  def caveats
    <<~EOS
      To get started, run:
        repository_audit --help

      If you want to customize or extend templates/configs,
      set this variable in your shell:
        export REPOSITORY_AUDIT_HOME=#{opt_pkgshare}

      All shared scripts and templates are available in:
        #{opt_pkgshare}/lib
        #{opt_pkgshare}/tpl
    EOS
  end

  test do
    assert_match "repository_audit", shell_output("#{bin}/repository_audit --version")
  end
end
