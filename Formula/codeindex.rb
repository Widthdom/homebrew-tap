class Codeindex < Formula
  desc "CLI code indexing, MCP search, and LSP lookup for local repositories"
  homepage "https://github.com/Widthdom/CodeIndex"
  version "1.36.1"
  license "FSL-1.1-ALv2"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/Widthdom/CodeIndex/releases/download/v1.36.1/CodeIndex-osx-arm64.tar.gz"
      sha256 "35050fc008437f7e139287ac5eab5a4ec83264ebf19d4b3494cf907bbf98cea6"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/Widthdom/CodeIndex/releases/download/v1.36.1/CodeIndex-linux-arm64.tar.gz"
      sha256 "7ae03b0e27a94ebb3a62fa739068321c3c90caa7316b7e16429e2f00de2285b7"
    else
      url "https://github.com/Widthdom/CodeIndex/releases/download/v1.36.1/CodeIndex-linux-x64.tar.gz"
      sha256 "618368df5490c97ede68905b084663d6fa68388b4287b02f914a6af0214f43c9"
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
