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
      sha256 "61b6f2ea681716ae99578322244f98b35c6729731bc95ed0d89cdfdc529a52d4"
    end

    on_arm do
      url "https://github.com/tokenuse/tokenuse/releases/download/v#{version}/tokenuse_#{version}_darwin_arm64.tar.gz"
      sha256 "69358d39747efb6557a90002609be0472eeabc7abc2dacce6198dd39349f1341"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/tokenuse/tokenuse/releases/download/v#{version}/tokenuse_#{version}_linux_amd64.tar.gz"
      sha256 "04f7d9f3ca6869165474b845c633be4d1963bc860c2603ac5697505539232b59"
    end

    on_arm do
      url "https://github.com/tokenuse/tokenuse/releases/download/v#{version}/tokenuse_#{version}_linux_arm64.tar.gz"
      sha256 "1767702f0f84e95e699bb440e12d74c743cbd2b8a45918f38019ab15859ebc51"
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
