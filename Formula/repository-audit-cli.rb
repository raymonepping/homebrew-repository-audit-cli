class RepositoryAuditCli < Formula
  desc "CLI toolkit for auditing Git repositories and folders with markdown/csv/json reports"
  homepage "https://github.com/raymonepping/repository_audit_cli"
  url "https://github.com/raymonepping/homebrew-repository-audit-cli/archive/refs/tags/v1.0.2.tar.gz"
  sha256 "d27b063a8179653ae9690453b1372dda4e54ada3918df0b906ef9869a7ff4437" 
  license "MIT"
  version "1.0.2"

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

      If you use templates or configs from the repo, export:
        export REPOSITORY_AUDIT_HOME=#{opt_pkgshare}
    EOS
  end

  test do
    assert_match "repository_audit", shell_output("#{bin}/repository_audit --version")
  end
end
