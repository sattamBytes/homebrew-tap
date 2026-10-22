cask "idraw" do
  version "0.5.1"
  sha256 "f8f397e9b09957023bf96401853cbd3d4cbbab13ecccdc320f328bfb99131e87"

  url "https://github.com/sattamBytes/idraw/releases/download/v#{version}/idraw-v#{version}-macos-universal.zip"
  name "idraw"
  desc "AI-first diagramming app for system design with animated flows"
  homepage "https://github.com/sattamBytes/idraw"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on :macos

  app "idraw.app"
  # command line: idraw render / check / icons / skill install
  binary "#{appdir}/idraw.app/Contents/MacOS/idraw"

  # Not notarized yet: clear the download quarantine so macOS opens it without a warning.
  postflight_steps do
    run "/usr/bin/xattr",
        args:         ["-dr", "com.apple.quarantine", "{{appdir}}/idraw.app"],
        must_succeed: false
  end

  zap trash: "~/Library/Application Support/idraw"
end
