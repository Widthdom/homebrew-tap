class Codeindex < Formula
  desc "CLI code indexing and MCP search for local repositories"
  homepage "https://github.com/Widthdom/CodeIndex"
  version "1.24.5"
  license "FSL-1.1-ALv2"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/Widthdom/CodeIndex/releases/download/v1.24.5/CodeIndex-osx-arm64.tar.gz"
      sha256 "7f8f656625d5bdd16480c9474d434a959242cccf516b0bc08be638bb6cee156e"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/Widthdom/CodeIndex/releases/download/v1.24.5/CodeIndex-linux-arm64.tar.gz"
      sha256 "4ee0ba6841e4ade7a73d6899aa67201e1066145a5d34a41f48d7981d164e949b"
    else
      url "https://github.com/Widthdom/CodeIndex/releases/download/v1.24.5/CodeIndex-linux-x64.tar.gz"
      sha256 "63f7c17b8696d16eb5d6e03e658dfc74dcb7713a8f6de9b7065a034397c8f813"
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
