class Tokenuse < Formula
  desc "Track Claude Code and OpenAI Codex usage and costs"
  homepage "https://tokenuse.ai"
  version "0.4.5"
  license "MIT"

  livecheck do
    url :stable
    strategy :github_latest
  end

  on_macos do
    on_intel do
      url "https://github.com/tokenuse/tokenuse/releases/download/v#{version}/tokenuse_#{version}_darwin_amd64.tar.gz"
      sha256 "9637a89a6f85023792162e50ddd57771866aae7ce1fd7a412dc7846ca50e1276"
    end

    on_arm do
      url "https://github.com/tokenuse/tokenuse/releases/download/v#{version}/tokenuse_#{version}_darwin_arm64.tar.gz"
      sha256 "65cfaf39c49e9f8067575b3d8368812ef8f36197d9fcfb3a9d71b7b7c82fca1c"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/tokenuse/tokenuse/releases/download/v#{version}/tokenuse_#{version}_linux_amd64.tar.gz"
      sha256 "9a255d73604a0eff9b108a23da936b764ee10fd1f68483216249f65d00da2d87"
    end

    on_arm do
      url "https://github.com/tokenuse/tokenuse/releases/download/v#{version}/tokenuse_#{version}_linux_arm64.tar.gz"
      sha256 "09b8d1f94d44975ce529e4b3dff1398044d7b83ac91a40c4a4b31a3cd015682d"
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
