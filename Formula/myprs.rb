class Myprs < Formula
  desc "Terminal UI for viewing your authored Bitbucket pull requests"
  homepage "https://github.com/shaunwen/myprs"
  url "https://github.com/shaunwen/myprs/archive/refs/tags/v0.1.1.tar.gz"
  version "0.1.1"
  sha256 "2ef4a1b297afa17e5425f6319e82b11952077733fe7a687573e92a5f5c871237"
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
    url "https://github.com/shaunwen/myprs/releases/download/v0.1.1/myprs-v0.1.1-aarch64-apple-darwin.tar.gz"
    sha256 "2a19f61d1d860ab14227f76be26c9d9a426e720e66e9d8cd61ce2c6993fcc5df"
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
