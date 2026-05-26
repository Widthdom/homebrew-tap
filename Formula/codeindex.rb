class Codeindex < Formula
  desc "CLI code indexing and MCP search for local repositories"
  homepage "https://github.com/Widthdom/CodeIndex"
  version "1.26.3"
  license "FSL-1.1-ALv2"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/Widthdom/CodeIndex/releases/download/v1.26.3/CodeIndex-osx-arm64.tar.gz"
      sha256 "885716b76850874e5d8f079e35fe9f51783366af2d9ce56c13d0a8361d1206b4"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/Widthdom/CodeIndex/releases/download/v1.26.3/CodeIndex-linux-arm64.tar.gz"
      sha256 "94741bf3ac5fe451b5d579289b2437563a449a32803644134a2cd65ced653ce7"
    else
      url "https://github.com/Widthdom/CodeIndex/releases/download/v1.26.3/CodeIndex-linux-x64.tar.gz"
      sha256 "ecc3e8d3cf1f365c7b5145198b3d60ec5bbf6f55b4c5ab8e7752f33b8fe4bd06"
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
