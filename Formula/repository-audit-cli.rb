class RepositoryAuditCli < Formula
  desc "CLI toolkit for auditing Git repositories and folders with markdown/csv/json reports"
  homepage "https://github.com/raymonepping/repository_audit_cli"
  url "https://github.com/raymonepping/homebrew-repository-audit-cli/archive/refs/tags/v1.0.12.tar.gz"
  sha256 "104a18da21376e453c79a6bd02075b9c4792f59db02a0e647a66326c3f0f4873"
  license "MIT"
  version "1.0.12"

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
