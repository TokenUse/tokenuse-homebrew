class Tokenuse < Formula
  desc "Track Claude Code and OpenAI Codex usage and costs"
  homepage "https://tokenuse.ai"
  version "0.4.4"
  license "MIT"

  livecheck do
    url :stable
    strategy :github_latest
  end

  on_macos do
    on_intel do
      url "https://github.com/tokenuse/tokenuse/releases/download/v#{version}/tokenuse_#{version}_darwin_amd64.tar.gz"
      sha256 "8c8345bc27bd7024032e29ef4448bcfbe7dc6432739aaa3c2a156db829981809"
    end

    on_arm do
      url "https://github.com/tokenuse/tokenuse/releases/download/v#{version}/tokenuse_#{version}_darwin_arm64.tar.gz"
      sha256 "5b41647c4dbfb439f8009a5acd3b7462832b8a645ed5423498e8b42416cd2ffd"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/tokenuse/tokenuse/releases/download/v#{version}/tokenuse_#{version}_linux_amd64.tar.gz"
      sha256 "3fbedb6d25316352d992c33405b4d4c2797aebb1b6fc82eb59f3ce68bec3d08e"
    end

    on_arm do
      url "https://github.com/tokenuse/tokenuse/releases/download/v#{version}/tokenuse_#{version}_linux_arm64.tar.gz"
      sha256 "9cda306ec02c1d3f281ad30050b867118842c0d488bc3a7ebedcdb53133ab41f"
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
      does not have the uninstall command yet, run `tokenuse logout` first and
      type `delete` when prompted. If the tokenuse command is already gone,
      remove these paths manually:
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
