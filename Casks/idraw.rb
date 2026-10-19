cask "idraw" do
  version "0.4.3"
  sha256 "d4d598523b43694d1ad7cc339929ad2e345c2547f07cca5214f0d563b3737bda"

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
