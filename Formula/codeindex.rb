class Codeindex < Formula
  desc "CLI code indexing, MCP search, and LSP lookup for local repositories"
  homepage "https://github.com/Widthdom/CodeIndex"
  version "1.28.5"
  license "FSL-1.1-ALv2"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/Widthdom/CodeIndex/releases/download/v1.28.5/CodeIndex-osx-arm64.tar.gz"
      sha256 "623df3f98976de3021370ac6b80fd191db30f52d95867d364bba01f9aa033df3"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/Widthdom/CodeIndex/releases/download/v1.28.5/CodeIndex-linux-arm64.tar.gz"
      sha256 "3e7ba5966d65475af7b3f2fe316dc7ed1b35af0933ab8acdae9dff426baf1d3b"
    else
      url "https://github.com/Widthdom/CodeIndex/releases/download/v1.28.5/CodeIndex-linux-x64.tar.gz"
      sha256 "00c4c039db3a34a40d09ed9d4987ba2219bf95378add73e3d2ae5a61c223e43e"
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
