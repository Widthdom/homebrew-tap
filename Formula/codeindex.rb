class Codeindex < Formula
  desc "CLI code indexing, MCP search, and LSP lookup for local repositories"
  homepage "https://github.com/Widthdom/CodeIndex"
  version "1.42.0"
  license "FSL-1.1-ALv2"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/Widthdom/CodeIndex/releases/download/v1.42.0/CodeIndex-osx-arm64.tar.gz"
      sha256 "8d71db8e2b4658ae429d5ab50d5ec2c936be02f46b278e501b4e75953a4cf6ed"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/Widthdom/CodeIndex/releases/download/v1.42.0/CodeIndex-linux-arm64.tar.gz"
      sha256 "f1e9ddc3dc9d3f85733308892db586e8d2f26a6077c69e205c1149139cfa4eb0"
    else
      url "https://github.com/Widthdom/CodeIndex/releases/download/v1.42.0/CodeIndex-linux-x64.tar.gz"
      sha256 "46ec4527a4a0155b12bf7c806f18ac8a930a0eec5d3774268115159ade4d3ea7"
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
