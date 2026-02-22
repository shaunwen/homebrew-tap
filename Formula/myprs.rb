class Myprs < Formula
  desc "Terminal UI for viewing your authored Bitbucket pull requests"
  homepage "https://github.com/shaunwen/myprs"
  url "https://github.com/shaunwen/myprs/archive/refs/tags/v0.1.2.tar.gz"
  sha256 "b7410739e0c755b38b3a07e9d8b70134da28a7c266328116eb740142cdfcb06a"
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
    url "https://github.com/shaunwen/myprs/releases/download/v0.1.2/myprs-v0.1.2-aarch64-apple-darwin.tar.gz"
    sha256 "3c661a3b9032daa3206dd47592f3e5545e8f51ec59267a7919e1e4df8fd4466c"
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
