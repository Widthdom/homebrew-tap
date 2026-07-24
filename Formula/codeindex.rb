class Codeindex < Formula
  desc "CLI code indexing, MCP search, and LSP lookup for local repositories"
  homepage "https://github.com/Widthdom/CodeIndex"
  version "1.40.1"
  license "FSL-1.1-ALv2"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/Widthdom/CodeIndex/releases/download/v1.40.1/CodeIndex-osx-arm64.tar.gz"
      sha256 "266f2722888dda913ed8b90c255f240c01676791c6712529f6437e5a1451bcb0"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/Widthdom/CodeIndex/releases/download/v1.40.1/CodeIndex-linux-arm64.tar.gz"
      sha256 "e87f26e6bbc6339e92fdac0aacf90ce42e5d0a68c3ec82cf29df5894f1d7d544"
    else
      url "https://github.com/Widthdom/CodeIndex/releases/download/v1.40.1/CodeIndex-linux-x64.tar.gz"
      sha256 "dc5ad007630af7b22ecf91576e0dd6d3e4ab42843385a81f0abfe5eda7fa19bc"
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
