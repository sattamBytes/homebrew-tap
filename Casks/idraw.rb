cask "idraw" do
  version "0.1.0"
  sha256 "3818d0832a27b162f6f7da66528cc8813c889cea5bad0c2067f1c6dcda4cc394"

  url "https://github.com/sattamBytes/idraw/releases/download/v#{version}/idraw-v#{version}-macos-universal.zip"
  name "idraw"
  desc "Diagramming app for system design with animated request flows"
  homepage "https://github.com/sattamBytes/idraw"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: ">= :big_sur"

  app "idraw.app"

  # Not notarized yet: clear the download quarantine so macOS opens it without a warning.
  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-dr", "com.apple.quarantine", "#{appdir}/idraw.app"]
  end

  zap trash: "~/Library/Application Support/idraw"
end
