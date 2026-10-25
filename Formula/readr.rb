class Readr < Formula
  desc "Track daily reading across bookokrat, Preview and Apple Books"
  homepage "https://github.com/shaunwen/readr"
  url "https://github.com/shaunwen/readr/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "7f6117e2426ae2f4d03949bf5fb9c98a4ce67f857eb8df3bf2bd07a9ec59260f"
  license "MIT"

  depends_on :macos

  on_intel do
    depends_on "rust" => :build
  end

  resource "readr-arm64-binary" do
    url "https://github.com/shaunwen/readr/releases/download/v0.1.0/readr-v0.1.0-aarch64-apple-darwin.tar.gz"
    sha256 "77fa4bb90888f85c4a4649db574bd33ec56f46d0f38c4a73c1293c9a300982af"
  end

  def install
    if Hardware::CPU.arm?
      resource("readr-arm64-binary").stage do
        bin.install "readr"
      end
    else
      system "cargo", "install", *std_cargo_args(path: "crates/readr")
    end
  end

  def caveats
    <<~EOS
      Start the tracker at login and check the setup:
        readr daemon install
        readr doctor

      Grant Accessibility, and Full Disk Access for Apple Books, to
        #{opt_bin}/readr
      in System Settings > Privacy & Security.

      After `brew upgrade readr`, run `readr daemon install` again to restart the tracker.
    EOS
  end

  test do
    ENV["XDG_CONFIG_HOME"] = testpath/"config"
    ENV["XDG_DATA_HOME"] = testpath/"data"
    assert_match version.to_s, shell_output("#{bin}/readr --version")
    assert_match "daily_goal_minutes = 20", shell_output("#{bin}/readr config")
  end
end
