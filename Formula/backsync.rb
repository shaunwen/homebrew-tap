class Backsync < Formula
  desc "One-way mirror backup of a source folder to a target folder"
  homepage "https://github.com/shaunwen/backsync"
  url "https://github.com/shaunwen/backsync/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "7f1d88b35493b7b1359eeee78b5235984606adda5032e27cc38614b219ba8e4f"

  bottle do
    root_url "https://github.com/shaunwen/homebrew-tap/releases/download/backsync-0.1.0"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "229b3da2189b44fe01463586f60dddcec794cef11def577fd647060e49408d96"
    sha256 cellar: :any,                 x86_64_linux: "e890e94fb0613f7000906439c27e28bc49e7f5e01d07b1df5207c1f7f50fa93b"
  end

  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args
  end

  test do
    (testpath/"source/docs/a.txt").write "hello"
    (testpath/"target").mkpath
    (testpath/"target/stale.txt").write "old"
    ENV["BACKSYNC_SOURCE"] = testpath/"source"
    ENV["BACKSYNC_TARGET"] = testpath/"target"
    ENV["XDG_CONFIG_HOME"] = testpath/"config"

    assert_match "1 new, 0 updated, 1 removed", shell_output(bin/"backsync")
    assert_equal "hello", (testpath/"target/docs/a.txt").read
    refute_path_exists testpath/"target/stale.txt"
  end
end
