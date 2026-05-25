class Codeindex < Formula
  desc "CLI code indexing and MCP search for local repositories"
  homepage "https://github.com/Widthdom/CodeIndex"
  version "1.25.1"
  license "FSL-1.1-ALv2"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/Widthdom/CodeIndex/releases/download/v1.25.1/CodeIndex-osx-arm64.tar.gz"
      sha256 "d4a6d5f95be204bd4ed370e4b88ebca862cff801db086fbc2c22e1442783043f"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/Widthdom/CodeIndex/releases/download/v1.25.1/CodeIndex-linux-arm64.tar.gz"
      sha256 "c2bd5404d782bd7e11f88f57ed2d141a59edf6cc80a285cc0b36359309ba217b"
    else
      url "https://github.com/Widthdom/CodeIndex/releases/download/v1.25.1/CodeIndex-linux-x64.tar.gz"
      sha256 "40e0984ba3e4f78839334af0a7c9c72722a375b369ae6e7c4748b95d87cbbaa0"
    end
  end

  def install
    bin.install "cdidx"
    prefix.install "version.json"
    prefix.install "LICENSE", "COMMERCIAL_LICENSE.md", "INTEGRATION_POLICY.md", "TRADEMARKS.md"
    prefix.install "LICENSES" if File.directory?("LICENSES")
  end

  test do
    assert_match "cdidx v#{version}", shell_output("#{bin}/cdidx --version")
  end
end
