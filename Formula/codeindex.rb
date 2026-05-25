class Codeindex < Formula
  desc "CLI code indexing and MCP search for local repositories"
  homepage "https://github.com/Widthdom/CodeIndex"
  version "1.26.1"
  license "FSL-1.1-ALv2"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/Widthdom/CodeIndex/releases/download/v1.26.1/CodeIndex-osx-arm64.tar.gz"
      sha256 "9705736bd288275f4ac245d45ec3291ca5a8382c4ede53aba4657f5f28213552"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/Widthdom/CodeIndex/releases/download/v1.26.1/CodeIndex-linux-arm64.tar.gz"
      sha256 "73f4709732f7da85b9f7a8882d28cea4874e8a410b3043e6a84969b4c07b2f44"
    else
      url "https://github.com/Widthdom/CodeIndex/releases/download/v1.26.1/CodeIndex-linux-x64.tar.gz"
      sha256 "9057a96d564a454fc5466182d73d6d033e262497364b396d0f194811cb8c4a18"
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
