class Codeindex < Formula
  desc "CLI code indexing and MCP search for local repositories"
  homepage "https://github.com/Widthdom/CodeIndex"
  version "1.26.2"
  license "FSL-1.1-ALv2"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/Widthdom/CodeIndex/releases/download/v1.26.2/CodeIndex-osx-arm64.tar.gz"
      sha256 "df33a8ded363262d4509115b8c50bd893b8f6f954884ba29e509dcb92be298f1"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/Widthdom/CodeIndex/releases/download/v1.26.2/CodeIndex-linux-arm64.tar.gz"
      sha256 "2f31e73302a3cbeb927efc5e05f6e41c5d1ff410c668aae81c59a919cbc931cd"
    else
      url "https://github.com/Widthdom/CodeIndex/releases/download/v1.26.2/CodeIndex-linux-x64.tar.gz"
      sha256 "eea319a6a924bd9574de9bdb709c581209143069bd376cdc10e87d1dbe27dc8a"
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
