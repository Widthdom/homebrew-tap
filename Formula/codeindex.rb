class Codeindex < Formula
  desc "CLI code indexing, MCP search, and LSP lookup for local repositories"
  homepage "https://github.com/Widthdom/CodeIndex"
  version "1.44.3"
  license "FSL-1.1-ALv2"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/Widthdom/CodeIndex/releases/download/v1.44.3/CodeIndex-osx-arm64.tar.gz"
      sha256 "21d5cffb935a1643b9391d04f3ff55fdd05dbde22c9159b4a00e9f0364a9910f"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/Widthdom/CodeIndex/releases/download/v1.44.3/CodeIndex-linux-arm64.tar.gz"
      sha256 "11507484234e3952fa0e52890a3b31f7ebfed0bec954df48a9b9658dff3e40c2"
    else
      url "https://github.com/Widthdom/CodeIndex/releases/download/v1.44.3/CodeIndex-linux-x64.tar.gz"
      sha256 "45b7ea7e3b1f8de508450905612f88a094051640e47d115a8fcd19fb1ecdccf6"
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
