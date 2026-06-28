class Fg < Formula
  desc "Static code-flow analysis for Go (REST + Temporal aware)"
  homepage "https://github.com/sattamBytes/flowgraph"
  url "https://github.com/sattamBytes/flowgraph/archive/refs/tags/v0.2.0.tar.gz"
  sha256 "e412de70228cdcd7cd85815893c06a9c977331e6e487e78568f774d914f296dc"
  license "MIT"
  head "https://github.com/sattamBytes/flowgraph.git", branch: "main"

  # go is also a RUNTIME dependency: fg drives `go list` (go/packages) to
  # type-check the project it analyzes.
  depends_on "go"

  def install
    system "go", "build", "-trimpath", "-ldflags", "-s -w", "-o", bin/"fg", "./cmd/fg"
  end

  test do
    assert_match "Available Commands", shell_output("#{bin}/fg --help")
    (testpath/"go.mod").write "module example.test\n\ngo 1.23\n"
    (testpath/"main.go").write "package main\n\nfunc main() {}\n"
    assert_match "nodes", shell_output("#{bin}/fg build #{testpath}")
  end
end
