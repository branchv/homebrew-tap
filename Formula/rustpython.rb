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
    root_url "https://github.com/branchv/homebrew-tap/releases/download/rustpython-0.5.0"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "c845ceed9733e052e38a7769cde86669a1fd8cba36f79c6f62cbfd3506379156"
    sha256                               x86_64_linux:  "05fddefe63b2e018883935a6beb8c232cd17fb25b3129fa85f25ee8022cfd9db"
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
