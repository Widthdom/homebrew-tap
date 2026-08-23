class Codeindex < Formula
  desc "CLI code indexing, MCP search, and LSP lookup for local repositories"
  homepage "https://github.com/Widthdom/CodeIndex"
  version "1.43.1"
  license "FSL-1.1-ALv2"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/Widthdom/CodeIndex/releases/download/v1.43.1/CodeIndex-osx-arm64.tar.gz"
      sha256 "3b5afc3f7bb7e8877c186a395059a7454ed00f6b7eee5428e7b2c1023ee9e82e"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/Widthdom/CodeIndex/releases/download/v1.43.1/CodeIndex-linux-arm64.tar.gz"
      sha256 "d2bdd6a9d07cd090dc27d7dab8719c8a6f97bb11e15f5675eb06795d579ed7f1"
    else
      url "https://github.com/Widthdom/CodeIndex/releases/download/v1.43.1/CodeIndex-linux-x64.tar.gz"
      sha256 "d447fdf14f8ccdfefdd267e21afc4e92dff4a0c520afbccf32b8fa25d2b276fd"
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
