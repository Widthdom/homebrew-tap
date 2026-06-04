class Codeindex < Formula
  desc "CLI code indexing, MCP search, and LSP lookup for local repositories"
  homepage "https://github.com/Widthdom/CodeIndex"
  version "1.28.4"
  license "FSL-1.1-ALv2"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/Widthdom/CodeIndex/releases/download/v1.28.4/CodeIndex-osx-arm64.tar.gz"
      sha256 "8525f7c48ca42a0b108bc9b22d7148fdef3dd44c05c1927de172a21cca1ec43a"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/Widthdom/CodeIndex/releases/download/v1.28.4/CodeIndex-linux-arm64.tar.gz"
      sha256 "df32779c33cd144bb4c27bae2505994c92da8bc2526b0ce3dac5e02c1936f250"
    else
      url "https://github.com/Widthdom/CodeIndex/releases/download/v1.28.4/CodeIndex-linux-x64.tar.gz"
      sha256 "bd8f1256c6fa4cce20f6fd2b4bc5abf64c5ffe0ea0e283e5446a1bbc0a061115"
    end
  end

  def install
    bin.install "cdidx"
    bin.install "version.json"
    prefix.install "LICENSE", "COMMERCIAL_LICENSE.md", "INTEGRATION_POLICY.md", "TRADEMARKS.md"
    prefix.install "LICENSES" if File.directory?("LICENSES")
  end

  test do
    assert_match "cdidx v#{version}", shell_output("#{bin}/cdidx --version")
  end
end
