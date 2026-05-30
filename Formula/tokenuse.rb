class Tokenuse < Formula
  desc "Track and analyze Claude Code usage"
  homepage "https://tokenuse.ai"
  version "0.4.1"
  license "MIT"

  on_macos do
    on_intel do
      url "https://github.com/tokenuse/tokenuse/releases/download/v#{version}/tokenuse_#{version}_darwin_amd64.tar.gz"
      sha256 "b8d85e176726f73ea4d0c38fadc92b2017973014cfb504b0e7b019ea30aa4ef7"
    end

    on_arm do
      url "https://github.com/tokenuse/tokenuse/releases/download/v#{version}/tokenuse_#{version}_darwin_arm64.tar.gz"
      sha256 "1be26fd34c56183ce7425074d40a0fbf211c958e8af4c718c1e2c4e2e5f4be03"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/tokenuse/tokenuse/releases/download/v#{version}/tokenuse_#{version}_linux_amd64.tar.gz"
      sha256 "8e6236b8ff973811d8a817a0229c64d666a574ef3742cdffb12cfa38bf00dcc2"
    end

    on_arm do
      url "https://github.com/tokenuse/tokenuse/releases/download/v#{version}/tokenuse_#{version}_linux_arm64.tar.gz"
      sha256 "b8a1d67047da0453f014ee37b0fe059ee5da4f801df0cdab2d28a0d0bdb28770"
    end
  end

  def install
    bin.install "tokenuse"
  end

  def post_install
    ohai "TokenUse installed!"
    ohai "Run 'tokenuse' to start tracking (auto signs in if needed)."
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/tokenuse version")
  end
end
