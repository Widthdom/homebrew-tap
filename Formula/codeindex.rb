class Codeindex < Formula
  desc "CLI code indexing, MCP search, and LSP lookup for local repositories"
  homepage "https://github.com/Widthdom/CodeIndex"
  version "1.30.2"
  license "FSL-1.1-ALv2"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/Widthdom/CodeIndex/releases/download/v1.30.2/CodeIndex-osx-arm64.tar.gz"
      sha256 "3654b529213c97f4ffdef437245921a4d99e49bff89d2fad6446cc00438714d8"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/Widthdom/CodeIndex/releases/download/v1.30.2/CodeIndex-linux-arm64.tar.gz"
      sha256 "c88ac8f29c958cf11bb0f45d587666aba48ed79b9b0e251661d59b4f701033d2"
    else
      url "https://github.com/Widthdom/CodeIndex/releases/download/v1.30.2/CodeIndex-linux-x64.tar.gz"
      sha256 "133a294fd4ba5f7a9d6fe84948f049c14b95c10f7ec138e0b62554a0c67b00b7"
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
