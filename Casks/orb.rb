cask "orb" do
  arch arm: "aarch64", intel: "x64"

  version "1.1.0"
  sha256 arm:   "b60fd08c04f0c3870151ca8ecd58a920935506dedc7672cac4f4524009feba6c",
         intel: "1a681392049a5a486e2b764a808db26ee88e31048993117f306bcbb4acd47ef2"

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
