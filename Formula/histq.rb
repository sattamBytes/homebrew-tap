class Histq < Formula
  desc "Project-aware shell history for zsh: an up-arrow that knows your repo"
  homepage "https://github.com/sattamBytes/histq"
  version "0.3.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/sattamBytes/histq/releases/download/v0.3.0/histq-aarch64-apple-darwin.tar.xz"
      sha256 "421df85880dd869abb109e8d6d741f8a4bea6c434fc21ed9942220e171783780"
    end
    if Hardware::CPU.intel?
      url "https://github.com/sattamBytes/histq/releases/download/v0.3.0/histq-x86_64-apple-darwin.tar.xz"
      sha256 "64da2cec4ed5ff5b5398f1bb83b9d51793fe25acc8370d4cb70b4c6b82caf588"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/sattamBytes/histq/releases/download/v0.3.0/histq-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "8053e590aaaa7ae167f1d25aadb1d8eee1c8cc33fe10d35bde43d72a4a84a1ba"
    end
    if Hardware::CPU.intel?
      url "https://github.com/sattamBytes/histq/releases/download/v0.3.0/histq-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "4e2e50fa34a49b5ad71db481a1356854f20e73c87610c42916285a9bdef532f5"
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
    bin.install "histq" if OS.mac? && Hardware::CPU.arm?
    bin.install "histq" if OS.mac? && Hardware::CPU.intel?
    bin.install "histq" if OS.linux? && Hardware::CPU.arm?
    bin.install "histq" if OS.linux? && Hardware::CPU.intel?

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
