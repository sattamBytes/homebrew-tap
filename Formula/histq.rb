class Histq < Formula
  desc "Project-aware shell history for zsh: an up-arrow that knows your repo"
  homepage "https://github.com/sattamBytes/histq"
  version "0.4.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/sattamBytes/histq/releases/download/v0.4.0/histq-aarch64-apple-darwin.tar.xz"
      sha256 "a372916d59f77ed084a83aabfeb10edaa539725db32dedcb900c43e2e3ef1f97"
    end
    if Hardware::CPU.intel?
      url "https://github.com/sattamBytes/histq/releases/download/v0.4.0/histq-x86_64-apple-darwin.tar.xz"
      sha256 "4c176a441c7b45969d32c26d082db8e1a6fa9a269434f44bfc28abc282176047"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/sattamBytes/histq/releases/download/v0.4.0/histq-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "d8f9fc485537e0e2dbefb4d423e3b8148d5ace85e59ec568477092e53ef95ba1"
    end
    if Hardware::CPU.intel?
      url "https://github.com/sattamBytes/histq/releases/download/v0.4.0/histq-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "54bdd12966784e392aa65e0ae5f8242bea46c528251cba0d688d832699a712f4"
    end
  end
  license "MIT"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":      {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-apple-darwin":       {},
    "x86_64-unknown-linux-gnu":  {},
  }.freeze

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    if OS.mac? && Hardware::CPU.arm?
      bin.install "histq"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "histq"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "histq"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "histq"
    end

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
