class Littlecheck < Formula
  include Language::Python::Virtualenv

  desc "Command-line tool tester"
  homepage "https://github.com/ridiculousfish/littlecheck"
  url "https://github.com/ridiculousfish/littlecheck/archive/c44c157d3666b9a447e20977eec6eb4bd2a0c304.tar.gz"
  version "0.1.2"
  sha256 "de92d27430e1649366952363c7606e390a04d53961b1ca30c68d4e1ab18d1179"
  head "https://github.com/ridiculousfish/littlecheck.git", branch: "master"

  bottle do
    root_url "https://github.com/branchv/homebrew-tap/releases/download/littlecheck-0.1.2"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "a2c515a43a078f33fabdd8819b9825c00dcc630b70a12884c79b9bc842e02b9b"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "4ea454414b6ad99bb2c52faa1d6d5b5d02260f89481ad254295d7f13eb96b53e"
  end

  depends_on "python@3.14"

  def install
    virtualenv_install_with_resources
  end

  test do
    assert_match "littlecheck: command line tool tester.", shell_output("#{bin}/littlecheck --help")
  end
end
