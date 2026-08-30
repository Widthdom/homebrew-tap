class Codeindex < Formula
  desc "CLI code indexing, MCP search, and LSP lookup for local repositories"
  homepage "https://github.com/Widthdom/CodeIndex"
  version "1.45.1"
  license "FSL-1.1-ALv2"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/Widthdom/CodeIndex/releases/download/v1.45.1/CodeIndex-osx-arm64.tar.gz"
      sha256 "93e5ab61fc07c0edba5e50a6f939bd7286a35398b41ab729c6d1c9b92c20eb55"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/Widthdom/CodeIndex/releases/download/v1.45.1/CodeIndex-linux-arm64.tar.gz"
      sha256 "b1d1b7e0c9c8e0adb41f6e11e3c14896c6167312c46bfc2994cbfcdf0fec149e"
    else
      url "https://github.com/Widthdom/CodeIndex/releases/download/v1.45.1/CodeIndex-linux-x64.tar.gz"
      sha256 "9c76c1c841517596cd9f88ce60195563c39f81079071e55690bd03315d3d8eaa"
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
