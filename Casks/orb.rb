cask "orb" do
  arch arm: "aarch64", intel: "x64"

  version "1.0.0"
  sha256 arm:   "e89ba8d554da1ab31c8775c90a857438459bb6710cf97950775917f2910b3c63",
         intel: "8e5c0a8277a9ee73645a5995a2a4ef94fb3be1141aaef14a405581a1d8d0e05c"

  url "https://github.com/josetseph/Orb/releases/download/desktop-v#{version}/Orb_#{version}_#{arch}.dmg"
  name "Orb"
  desc "Local-first knowledge base: notes, knowledge graph and chat over your vault"
  homepage "https://github.com/josetseph/Orb"

  livecheck do
    url :url
    regex(/^desktop[._-]v?(\d+(?:\.\d+)+)$/i)
    strategy :github_latest
  end

  depends_on macos: :monterey

  app "Orb.app"

  # Orb is not notarized; without this macOS reports the app as damaged.
  postflight_steps do
    run "/usr/bin/xattr",
        args:  ["-dr", "com.apple.quarantine", "Orb.app"],
        chdir: ".",
        base:  :appdir
  end

  # Caches only: the knowledge base in ~/Library/Application Support/Orb and
  # your vault folders are never touched by uninstall or zap.
  zap trash: [
    "~/Library/Caches/com.josetseph.orb",
    "~/Library/WebKit/com.josetseph.orb",
  ]
end
