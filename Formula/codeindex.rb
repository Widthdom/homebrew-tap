class Codeindex < Formula
  desc "CLI code indexing, MCP search, and LSP lookup for local repositories"
  homepage "https://github.com/Widthdom/CodeIndex"
  version "1.39.4"
  license "FSL-1.1-ALv2"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/Widthdom/CodeIndex/releases/download/v1.39.4/CodeIndex-osx-arm64.tar.gz"
      sha256 "873e17f13601fdaa565777c3b5687ebaf800ff06edc63b90652eb59c67895450"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/Widthdom/CodeIndex/releases/download/v1.39.4/CodeIndex-linux-arm64.tar.gz"
      sha256 "f8d1f32ce8e9a7679b811f42915db7c69f782934519ea0cd357c55d06fd97089"
    else
      url "https://github.com/Widthdom/CodeIndex/releases/download/v1.39.4/CodeIndex-linux-x64.tar.gz"
      sha256 "4046088f3947cb5e52c73f3f9ccd64be5d7781f91a4353f42e2784f4a4f24e2d"
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
