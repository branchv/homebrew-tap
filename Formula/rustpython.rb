class Rustpython < Formula
  desc "Python Interpreter written in Rust"
  homepage "https://rustpython.github.io"
  url "https://github.com/RustPython/RustPython/archive/refs/tags/0.5.0.tar.gz"
  sha256 "6fa2bfd6d3a6c0ecb2aae216552ba24ad263546198c8a7b0c03c8111b6389d9c"
  license "MIT"
  version_scheme 1
  head "https://github.com/RustPython/RustPython.git", branch: "main"

  livecheck do
    url :stable
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  bottle do
    root_url "https://github.com/branchv/homebrew-tap/releases/download/rustpython-2025-08-18"
    sha256 cellar: :any, arm64_sequoia: "396684926b0322f7eae17b3c9b3991f7298e1102f10440e9d47037a4e01407c3"
    sha256               x86_64_linux:  "3d1ee5a8260c980b801fef1d9f86d0f96fb8072ac837c5d00e6a973dcd2061f4"
  end

  depends_on "rust" => :build
  depends_on "openssl@3"

  uses_from_macos "zlib"

  def install
    # Avoid references to Homebrew shims
    inreplace "crates/vm/build.rs", "std::env::vars_os()",
                                    'std::env::vars_os().filter(|(k, _)| k != "PATH" && k != "RUSTC_WRAPPER")'

    ENV["OPENSSL_DIR"] = Formula["openssl@3"].opt_prefix
    system "cargo", "install", "--features=ssl", *std_cargo_args
    (lib/"rustpython").install buildpath.glob("Lib/*")
    bin.env_script_all_files libexec/"bin", RUSTPYTHONPATH: lib/"rustpython"

    # TODO: Install pip
    # system bin/"rustpython", "--install-pip" if OS.mac?
  end

  test do
    system bin/"rustpython", "-c", "print('Hello, RustPython!')"
    # system bin/"rustpython", "-m", "pip", "list", "--format=columns" if OS.mac?
  end
end
