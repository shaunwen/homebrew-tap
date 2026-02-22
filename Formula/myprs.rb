class Myprs < Formula
  desc "Terminal UI for viewing your authored Bitbucket pull requests"
  homepage "https://github.com/shaunwen/myprs"
  url "https://github.com/shaunwen/myprs/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "eeeec110ed4e2ad3b2417a3510668e98352b316c3f5a94cdde5d15d22c247b30"
  license "MIT"

  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args
  end

  test do
    assert_match "myprs", shell_output("#{bin}/myprs --help")
  end
end
