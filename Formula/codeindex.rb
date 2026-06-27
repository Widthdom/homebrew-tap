class Codeindex < Formula
  desc "CLI code indexing, MCP search, and LSP lookup for local repositories"
  homepage "https://github.com/Widthdom/CodeIndex"
  version "1.34.2"
  license "FSL-1.1-ALv2"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/Widthdom/CodeIndex/releases/download/v1.34.2/CodeIndex-osx-arm64.tar.gz"
      sha256 "fc591af43cdf3597b2ce472d38106ca5e528d64bcaf1fa7945a8dc4febc5f055"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/Widthdom/CodeIndex/releases/download/v1.34.2/CodeIndex-linux-arm64.tar.gz"
      sha256 "a8bcfebf55185649ca0319057844b5de08a458090409bdf0ea246d859c73f4ae"
    else
      url "https://github.com/Widthdom/CodeIndex/releases/download/v1.34.2/CodeIndex-linux-x64.tar.gz"
      sha256 "2dfaef479ea3bce9b4b7e55778b983678dd430c4d53e0945cc0e01bdb3d077e2"
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
