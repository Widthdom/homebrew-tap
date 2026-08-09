class Codeindex < Formula
  desc "CLI code indexing, MCP search, and LSP lookup for local repositories"
  homepage "https://github.com/Widthdom/CodeIndex"
  version "1.41.2"
  license "FSL-1.1-ALv2"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/Widthdom/CodeIndex/releases/download/v1.41.2/CodeIndex-osx-arm64.tar.gz"
      sha256 "ef9bea60cef3dde11a7c1ae4d7f12953a556641445780a808b8fddb3d7aea973"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/Widthdom/CodeIndex/releases/download/v1.41.2/CodeIndex-linux-arm64.tar.gz"
      sha256 "db3a2c740660978f312941fd418147e1c2fd54d4a4c0d879d5519a763ac1992e"
    else
      url "https://github.com/Widthdom/CodeIndex/releases/download/v1.41.2/CodeIndex-linux-x64.tar.gz"
      sha256 "caf58e714fbc35b9ee21fa07531ad3288ba0bf7632c1d3453bebdca22932ca18"
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
