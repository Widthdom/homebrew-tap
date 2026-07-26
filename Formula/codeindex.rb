class Codeindex < Formula
  desc "CLI code indexing, MCP search, and LSP lookup for local repositories"
  homepage "https://github.com/Widthdom/CodeIndex"
  version "1.40.3"
  license "FSL-1.1-ALv2"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/Widthdom/CodeIndex/releases/download/v1.40.3/CodeIndex-osx-arm64.tar.gz"
      sha256 "d2814f7dda08b06689397768105814edd7b9a840983455bb3a5a8840aac47053"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/Widthdom/CodeIndex/releases/download/v1.40.3/CodeIndex-linux-arm64.tar.gz"
      sha256 "c9abab1ff9d61e779db7b3b4e2c250ce08dd462cbbde8f9b9f69d01d71d5ce31"
    else
      url "https://github.com/Widthdom/CodeIndex/releases/download/v1.40.3/CodeIndex-linux-x64.tar.gz"
      sha256 "1f2a7262b132a7cad7510671b44d8863f5c1ab28dda7aa15922070c7a51c9a75"
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
