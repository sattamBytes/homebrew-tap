class Flowgraph < Formula
  desc "Static code-flow analysis for Go (REST + Temporal aware)"
  homepage "https://github.com/sattamBytes/flowgraph"
  url "https://github.com/sattamBytes/flowgraph/archive/refs/tags/v0.2.1.tar.gz"
  sha256 "88adecf71894c27dbe8473256589a2740e71937280e2cb90f63ecdb954400aad"
  license "MIT"
  head "https://github.com/sattamBytes/flowgraph.git", branch: "main"

  # go is also a RUNTIME dependency: flowgraph drives `go list` (go/packages)
  # to type-check the project it analyzes.
  depends_on "go"

  def install
    system "go", "build", "-trimpath", "-ldflags", "-s -w", "-o", bin/"flowgraph", "./cmd/flowgraph"
  end

  test do
    assert_match "Available Commands", shell_output("#{bin}/flowgraph --help")
    (testpath/"go.mod").write "module example.test\n\ngo 1.23\n"
    (testpath/"main.go").write "package main\n\nfunc main() {}\n"
    assert_match "nodes", shell_output("#{bin}/flowgraph build #{testpath}")
  end
end
