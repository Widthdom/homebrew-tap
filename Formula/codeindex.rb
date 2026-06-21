class Codeindex < Formula
  desc "CLI code indexing, MCP search, and LSP lookup for local repositories"
  homepage "https://github.com/Widthdom/CodeIndex"
  version "1.33.0"
  license "FSL-1.1-ALv2"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/Widthdom/CodeIndex/releases/download/v1.33.0/CodeIndex-osx-arm64.tar.gz"
      sha256 "8edd35bd914d0cf636c7c98118d72493aad27b1eac3ea5a38df54fd5bc86b5c5"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/Widthdom/CodeIndex/releases/download/v1.33.0/CodeIndex-linux-arm64.tar.gz"
      sha256 "2628bc13ee5cdd254dc8948c7dc134a50ce69d62ac5a65868e4ee9923c2da52b"
    else
      url "https://github.com/Widthdom/CodeIndex/releases/download/v1.33.0/CodeIndex-linux-x64.tar.gz"
      sha256 "1ccf48b085ad05326309fc74955104a014c336225ed81a198b91e603f93a160d"
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
