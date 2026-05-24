class Codeindex < Formula
  desc "CLI code indexing and MCP search for local repositories"
  homepage "https://github.com/Widthdom/CodeIndex"
  version "1.25.0"
  license "FSL-1.1-ALv2"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/Widthdom/CodeIndex/releases/download/v1.25.0/CodeIndex-osx-arm64.tar.gz"
      sha256 "7386ba799d90d7892429452d997b62ed0b7a8f9b3af6dc8e448c075896f6f952"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/Widthdom/CodeIndex/releases/download/v1.25.0/CodeIndex-linux-arm64.tar.gz"
      sha256 "70924b70c89ede07bc0a9b125549ed7a196c3f14671a2ebabc76b5b9932fc5de"
    else
      url "https://github.com/Widthdom/CodeIndex/releases/download/v1.25.0/CodeIndex-linux-x64.tar.gz"
      sha256 "2336598cc201e64864b65a2f814a4cdf8681179613b27b785ad5d91f8982c56c"
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
