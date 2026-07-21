class Codeindex < Formula
  desc "CLI code indexing, MCP search, and LSP lookup for local repositories"
  homepage "https://github.com/Widthdom/CodeIndex"
  version "1.39.3"
  license "FSL-1.1-ALv2"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/Widthdom/CodeIndex/releases/download/v1.39.3/CodeIndex-osx-arm64.tar.gz"
      sha256 "a8052592fdfc984bd375aa6a1ecfcbe5ad237c1485b7191ef24f16beaa591d0a"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/Widthdom/CodeIndex/releases/download/v1.39.3/CodeIndex-linux-arm64.tar.gz"
      sha256 "034b30ad261a3e52d0e35201714c8dc1a6329bc8031acff17329b7bd1a07840e"
    else
      url "https://github.com/Widthdom/CodeIndex/releases/download/v1.39.3/CodeIndex-linux-x64.tar.gz"
      sha256 "894a5f9cf80e22ccf732cc69902698e6bd10e987daea3e7ea785a833b9cf2e90"
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
