class Codeindex < Formula
  desc "CLI code indexing, MCP search, and LSP lookup for local repositories"
  homepage "https://github.com/Widthdom/CodeIndex"
  version "1.36.3"
  license "FSL-1.1-ALv2"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/Widthdom/CodeIndex/releases/download/v1.36.3/CodeIndex-osx-arm64.tar.gz"
      sha256 "36e0fdde4e0e40cf39568997313157c0f23d57d9b6afbabf577f10fa1868b46a"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/Widthdom/CodeIndex/releases/download/v1.36.3/CodeIndex-linux-arm64.tar.gz"
      sha256 "2dc520bdf2f7fce1b40dd51b7d7694cde724a6e8bf9192b60e92d01b2939c1c5"
    else
      url "https://github.com/Widthdom/CodeIndex/releases/download/v1.36.3/CodeIndex-linux-x64.tar.gz"
      sha256 "4ba57f6d678193d41d07af2ae766c836d1dc2193320ff3706fd062a6319904ca"
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
