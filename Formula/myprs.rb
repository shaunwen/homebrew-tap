class Myprs < Formula
  desc "Terminal UI for viewing your authored Bitbucket pull requests"
  homepage "https://github.com/shaunwen/myprs"
  url "https://github.com/shaunwen/myprs/archive/refs/tags/v0.2.0.tar.gz"
  sha256 "386f5b7b22ec8cae4039dde024d6812f6ce3c8aacb1ca3afb692606b3c445002"
  license "MIT"

  on_macos do
    on_intel do
      depends_on "rust" => :build
    end
  end

  on_linux do
    depends_on "rust" => :build
  end

  resource "myprs-arm64-binary" do
    url "https://github.com/shaunwen/myprs/releases/download/v0.2.0/myprs-v0.2.0-aarch64-apple-darwin.tar.gz"
    sha256 "fb4ecf616bdd04f1552e602d96fbd0c3f59c51ab0139c83561c700f96976e91a"
  end

  def install
    if OS.mac? && Hardware::CPU.arm?
      resource("myprs-arm64-binary").stage do
        bin.install "myprs"
      end
    else
      system "cargo", "install", *std_cargo_args
    end
  end

  test do
    assert_match "myprs", shell_output("#{bin}/myprs --help")
  end
end
