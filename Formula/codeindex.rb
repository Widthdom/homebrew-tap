class Codeindex < Formula
  desc "CLI code indexing, MCP search, and LSP lookup for local repositories"
  homepage "https://github.com/Widthdom/CodeIndex"
  version "1.51.1"
  license "FSL-1.1-ALv2"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/Widthdom/CodeIndex/releases/download/v1.51.1/CodeIndex-osx-arm64.tar.gz"
      sha256 "05df766ebaf17527ff5f6df1dc02ebb6648ad213ecd57dcdeaaf51d44b769ab4"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/Widthdom/CodeIndex/releases/download/v1.51.1/CodeIndex-linux-arm64.tar.gz"
      sha256 "cb228a47bdcb1cb28de05b635ce978cbe439b727290fd3cc7311a34417b9e431"
    else
      url "https://github.com/Widthdom/CodeIndex/releases/download/v1.51.1/CodeIndex-linux-x64.tar.gz"
      sha256 "55edb437027618ebc9056f0b1097e794ef3fbc780fea44edabaeb58be8e55fde"
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
