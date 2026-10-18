cask "idraw" do
  version "0.3.1"
  sha256 "8983d7cedc58573681b2cbb50cd0c2bfbffa265c48bfab1366b0d14948e81bd2"

  url "https://github.com/sattamBytes/idraw/releases/download/v#{version}/idraw-v#{version}-macos-universal.zip"
  name "idraw"
  desc "Diagramming app for system design with animated request flows"
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
