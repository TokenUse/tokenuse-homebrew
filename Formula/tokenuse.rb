class Tokenuse < Formula
  desc "Track Claude Code and OpenAI Codex usage and costs"
  homepage "https://tokenuse.ai"
  version "0.4.7"
  license "MIT"

  livecheck do
    url :stable
    strategy :github_latest
  end

  on_macos do
    on_intel do
      url "https://github.com/tokenuse/tokenuse/releases/download/v#{version}/tokenuse_#{version}_darwin_amd64.tar.gz"
      sha256 "0b0a8c92fba8002c28496540d7a6a8af8cb25fb82bc74523be810c25c09cc635"
    end

    on_arm do
      url "https://github.com/tokenuse/tokenuse/releases/download/v#{version}/tokenuse_#{version}_darwin_arm64.tar.gz"
      sha256 "38a6d59b53db28097e9bbe31d0afb039085b52cc4a7dadf0fd4b1352762893e4"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/tokenuse/tokenuse/releases/download/v#{version}/tokenuse_#{version}_linux_amd64.tar.gz"
      sha256 "1d0867df890a16fe5f54b62d50df067acf345cdcae1db7d2b1bd267ddff6bbef"
    end

    on_arm do
      url "https://github.com/tokenuse/tokenuse/releases/download/v#{version}/tokenuse_#{version}_linux_arm64.tar.gz"
      sha256 "e69fb2421d933a3b41cbb2cfa93a0fd79a9d53905e9adb7bc2ed51cbc24121e4"
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
