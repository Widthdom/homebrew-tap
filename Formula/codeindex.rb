class Codeindex < Formula
  desc "CLI code indexing, MCP search, and LSP lookup for local repositories"
  homepage "https://github.com/Widthdom/CodeIndex"
  version "1.37.0"
  license "FSL-1.1-ALv2"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/Widthdom/CodeIndex/releases/download/v1.37.0/CodeIndex-osx-arm64.tar.gz"
      sha256 "25914e3098ad769b9337abc3b52179c8a907a871556cb09c0f2f9c48fcc11fd4"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/Widthdom/CodeIndex/releases/download/v1.37.0/CodeIndex-linux-arm64.tar.gz"
      sha256 "e2fc6239b6a2ae5e5f5400f043fd0ce6c78ded10d1b6804381419f9595b83492"
    else
      url "https://github.com/Widthdom/CodeIndex/releases/download/v1.37.0/CodeIndex-linux-x64.tar.gz"
      sha256 "73c306bc6e91733d78f6d6eae224ef3687c18dd4529721c86e67fbfcd0598b4f"
    end
  end

  def install
    bin.install "cdidx"
    bin.install "version.json"
    native_sqlite_asset = OS.mac? ? "libe_sqlite3.dylib" : "libe_sqlite3.so"
    bin.install native_sqlite_asset
    prefix.install "LICENSE", "COMMERCIAL_LICENSE.md", "INTEGRATION_POLICY.md", "TRADEMARKS.md"
    prefix.install "LICENSES" if File.directory?("LICENSES")
  end

  test do
    native_sqlite_asset = OS.mac? ? "libe_sqlite3.dylib" : "libe_sqlite3.so"
    assert_predicate bin/native_sqlite_asset, :exist?
    assert_match "cdidx v#{version}", shell_output("#{bin}/cdidx --version")
    (testpath/"Sample.cs").write "class Sample { static void Main() { } }\n"
    system "#{bin}/cdidx", testpath.to_s
    assert_match "\"files\":", shell_output("#{bin}/cdidx status --json")
  end
end
