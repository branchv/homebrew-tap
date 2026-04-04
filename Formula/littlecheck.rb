class Littlecheck < Formula
  include Language::Python::Virtualenv

  desc "Command-line tool tester"
  homepage "https://github.com/ridiculousfish/littlecheck"
  url "https://github.com/ridiculousfish/littlecheck/archive/c44c157d3666b9a447e20977eec6eb4bd2a0c304.tar.gz"
  version "0.1.2"
  sha256 "de92d27430e1649366952363c7606e390a04d53961b1ca30c68d4e1ab18d1179"
  head "https://github.com/ridiculousfish/littlecheck.git", branch: "master"

  bottle do
    root_url "https://github.com/branchv/homebrew-tap/releases/download/littlecheck-0.1.1"
    sha256 cellar: :any_skip_relocation, big_sur:      "303c75552ffce77099957a8f6ae4bb0b26d43cb988f10d29556c40ed424f7a08"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "9bcc160474db487ba31107f614ce227e9aee627126d25b180b7b9a28704fab72"
  end

  depends_on "python@3.14"

  def install
    virtualenv_install_with_resources
  end

  test do
    assert_match "littlecheck: command line tool tester.", shell_output("#{bin}/littlecheck --help")
  end
end
