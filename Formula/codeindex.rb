class Codeindex < Formula
  desc "CLI code indexing, MCP search, and LSP lookup for local repositories"
  homepage "https://github.com/Widthdom/CodeIndex"
  version "1.27.2"
  license "FSL-1.1-ALv2"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/Widthdom/CodeIndex/releases/download/v1.27.2/CodeIndex-osx-arm64.tar.gz"
      sha256 "6e7585951edadf15e7d462d0d96288809fcd22b6ae2817ee2e11f9fd721042ea"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/Widthdom/CodeIndex/releases/download/v1.27.2/CodeIndex-linux-arm64.tar.gz"
      sha256 "9abe88fecd1555e82b5ab3e2c1f96f45a3df842bf859f1200fe2f198e66270b1"
    else
      url "https://github.com/Widthdom/CodeIndex/releases/download/v1.27.2/CodeIndex-linux-x64.tar.gz"
      sha256 "6201bab53da9671d22336398f94ddf8acf2fb748bbd70182811e069597f023ad"
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
