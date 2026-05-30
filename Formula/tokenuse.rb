class Tokenuse < Formula
  desc "Track and analyze Claude Code usage"
  homepage "https://tokenuse.ai"
  version "0.4.0"
  license "MIT"

  on_macos do
    on_intel do
      url "https://github.com/tokenuse/tokenuse/releases/download/v#{version}/tokenuse_#{version}_darwin_amd64.tar.gz"
      sha256 "e6aca991e17d8200b719cb18c97cf7ec76f76c7e165112eef20fd47c22712ce5"
    end

    on_arm do
      url "https://github.com/tokenuse/tokenuse/releases/download/v#{version}/tokenuse_#{version}_darwin_arm64.tar.gz"
      sha256 "6be0f6ee01e32a0148fe999ac1f3c20f8ce6f5b21e53f8f6c733cf4afafdbad8"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/tokenuse/tokenuse/releases/download/v#{version}/tokenuse_#{version}_linux_amd64.tar.gz"
      sha256 "88b29b04fce4b0a08fbec02e2b98dc0e245356367602ad1f185b7ead2b1125d7"
    end

    on_arm do
      url "https://github.com/tokenuse/tokenuse/releases/download/v#{version}/tokenuse_#{version}_linux_arm64.tar.gz"
      sha256 "15dee44c56069f2aa14ef0b1f12f07ce7384718a5f4bca8c5b5b10e484425804"
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
