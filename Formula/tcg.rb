class Tcg < Formula
  desc "Static analysis for Temporal Go projects: connect-by-name graph and linter"
  homepage "https://github.com/sattamBytes/temporal-code-graph"
  url "https://github.com/sattamBytes/temporal-code-graph/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "7ac7935e61d106489d8d2ebe1cca8763041e096e3547c634fd532cc812e20aea"
  license "MIT"
  head "https://github.com/sattamBytes/temporal-code-graph.git", branch: "main"

  # `go` is also a RUNTIME dependency: tcg drives `go list` (go/packages) to
  # type-check the project it analyzes, so the toolchain must be present.
  depends_on "go"

  def install
    system "go", "build", "-trimpath", "-ldflags", "-s -w", "-o", bin/"tcg", "./cmd/tcg"
  end

  test do
    assert_match "static analysis", shell_output("#{bin}/tcg --help")

    # Analyze a trivial module end-to-end and confirm a JSON graph is emitted.
    (testpath/"go.mod").write "module example.test\n\ngo 1.23\n"
    (testpath/"main.go").write "package main\n\nfunc main() {}\n"
    assert_match "nodes", shell_output("#{bin}/tcg build #{testpath}")
  end
end
