class Tokenuse < Formula
  desc "Track and analyze Claude Code usage"
  homepage "https://tokenuse.ai"
  version "0.4.3"
  license "MIT"

  on_macos do
    on_intel do
      url "https://github.com/tokenuse/tokenuse/releases/download/v#{version}/tokenuse_#{version}_darwin_amd64.tar.gz"
      sha256 "ed17a06596dc0a6f544834d067f506a2d0666db2f2c9ee249d5cf09eb49e81b9"
    end

    on_arm do
      url "https://github.com/tokenuse/tokenuse/releases/download/v#{version}/tokenuse_#{version}_darwin_arm64.tar.gz"
      sha256 "0faec29113e220b0c08204dcc3dcc2a60ad6eef70668f9b56e4972dbc4794988"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/tokenuse/tokenuse/releases/download/v#{version}/tokenuse_#{version}_linux_amd64.tar.gz"
      sha256 "d0f86dcad81eb2144316efbfa2b655e6170f9b92abd0b45805c4201c11a16f86"
    end

    on_arm do
      url "https://github.com/tokenuse/tokenuse/releases/download/v#{version}/tokenuse_#{version}_linux_arm64.tar.gz"
      sha256 "acc6b949c1e85c05aead0fb4dee806f1b702df8a5fdc851d1e6748403c08a306"
    end
  end

  def install
    bin.install "tokenuse"
  end

  def post_install
    ohai "TokenUse installed!"
    ohai "Run 'tokenuse' to start tracking (auto signs in if needed)."
  end

  def caveats
    <<~EOS
      TokenUse runs a per-user background tracker after login.

      Before uninstalling the package, run:
        tokenuse uninstall

      That stops and removes the tracker service, removes the managed daemon
      binary, and offers to delete local TokenUse data. If the tokenuse command
      is already gone, remove these paths manually:
        macOS:  ~/Library/LaunchAgents/ai.tokenuse.tracker.plist
        Linux:  ~/.config/systemd/user/tokenuse-tracker.service
        binary: ~/.local/share/tokenuse/bin/tokenuse
        data:   ~/.config/tokenuse ~/.local/share/tokenuse ~/.cache/tokenuse
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/tokenuse version")
  end
end
