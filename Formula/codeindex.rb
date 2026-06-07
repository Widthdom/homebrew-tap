class Codeindex < Formula
  desc "CLI code indexing, MCP search, and LSP lookup for local repositories"
  homepage "https://github.com/Widthdom/CodeIndex"
  version "1.29.1"
  license "FSL-1.1-ALv2"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/Widthdom/CodeIndex/releases/download/v1.29.1/CodeIndex-osx-arm64.tar.gz"
      sha256 "c0933aaff4a47b0cc4f6bef69ffcd41ea529022e33abad050090d88de6e0a6c8"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/Widthdom/CodeIndex/releases/download/v1.29.1/CodeIndex-linux-arm64.tar.gz"
      sha256 "ea3a993b92d742436bf8bc899a0c7b91ab124615163fd83dc2a888500d5c1a87"
    else
      url "https://github.com/Widthdom/CodeIndex/releases/download/v1.29.1/CodeIndex-linux-x64.tar.gz"
      sha256 "4cdb54db6f359315586cbcb9e4faf1ff280005d16cf9f7bf4a32e1d5c34936fa"
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
