class Tokenuse < Formula
  desc "Track Claude Code and OpenAI Codex usage and costs"
  homepage "https://tokenuse.ai"
  version "0.4.6"
  license "MIT"

  livecheck do
    url :stable
    strategy :github_latest
  end

  on_macos do
    on_intel do
      url "https://github.com/tokenuse/tokenuse/releases/download/v#{version}/tokenuse_#{version}_darwin_amd64.tar.gz"
      sha256 "6007ea04defdda5fb8ffff40d468bf90086824c050abeca9f3fc0c44e04160a1"
    end

    on_arm do
      url "https://github.com/tokenuse/tokenuse/releases/download/v#{version}/tokenuse_#{version}_darwin_arm64.tar.gz"
      sha256 "7f22ec557dbc19c25bf4cabb3bc62bb399587c93e131b136a555e5d0771b414e"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/tokenuse/tokenuse/releases/download/v#{version}/tokenuse_#{version}_linux_amd64.tar.gz"
      sha256 "b21288ad7ba35174b9040f1ab4037dea1e45c698670269a06b2f6829a8f7167f"
    end

    on_arm do
      url "https://github.com/tokenuse/tokenuse/releases/download/v#{version}/tokenuse_#{version}_linux_arm64.tar.gz"
      sha256 "0d9b6411f4f40967d1c475e791b20973be68d3aa598ce646b554be16b91c33d9"
    end
  end

  def install
    bin.install "tokenuse"
    pkgshare.install "LICENSE" if File.exist?("LICENSE")
    pkgshare.install "THIRD-PARTY-NOTICES.txt" if File.exist?("THIRD-PARTY-NOTICES.txt")
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
