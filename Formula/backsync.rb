class Backsync < Formula
  desc "One-way mirror backup of a source folder to a target folder"
  homepage "https://github.com/shaunwen/backsync"
  url "https://github.com/shaunwen/backsync/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "7f1d88b35493b7b1359eeee78b5235984606adda5032e27cc38614b219ba8e4f"

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
