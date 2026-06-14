class Codeindex < Formula
  desc "CLI code indexing, MCP search, and LSP lookup for local repositories"
  homepage "https://github.com/Widthdom/CodeIndex"
  version "1.31.2"
  license "FSL-1.1-ALv2"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/Widthdom/CodeIndex/releases/download/v1.31.2/CodeIndex-osx-arm64.tar.gz"
      sha256 "fc2bfd410ec57870c05229b0a6b025bb6746cd39269a8f4df4f79aed9efebf8b"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/Widthdom/CodeIndex/releases/download/v1.31.2/CodeIndex-linux-arm64.tar.gz"
      sha256 "6a2db7dfde1c05509442d2ec3a0fdaba68c16ec2fc45c7ace150de2a42a88b09"
    else
      url "https://github.com/Widthdom/CodeIndex/releases/download/v1.31.2/CodeIndex-linux-x64.tar.gz"
      sha256 "75539360e15417cb6c72022903eabd1a4ea4c2f0ba6d58d81bd953c1740c668c"
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
