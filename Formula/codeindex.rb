class Codeindex < Formula
  desc "CLI code indexing, MCP search, and LSP lookup for local repositories"
  homepage "https://github.com/Widthdom/CodeIndex"
  version "1.34.0"
  license "FSL-1.1-ALv2"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/Widthdom/CodeIndex/releases/download/v1.34.0/CodeIndex-osx-arm64.tar.gz"
      sha256 "44ba4dc908427fc89b3f356dcb56ed54764655bcb2f93e715a45edb640322c49"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/Widthdom/CodeIndex/releases/download/v1.34.0/CodeIndex-linux-arm64.tar.gz"
      sha256 "376423c971996f47f00c8ef6d4c193739f5f411248aa4ee36a68228c8fecb495"
    else
      url "https://github.com/Widthdom/CodeIndex/releases/download/v1.34.0/CodeIndex-linux-x64.tar.gz"
      sha256 "30038add9546b9a439f77b3424049ec2cb3a13ca07b2c263c6ba56b5fb17f74b"
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
