class Histq < Formula
  desc "Project-aware shell history for zsh: an up-arrow that knows your repo"
  homepage "https://github.com/sattamBytes/histq"
  version "0.1.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/sattamBytes/histq/releases/download/v0.1.0/histq-aarch64-apple-darwin.tar.xz"
      sha256 "6b86806710b0ec0fb5970bb31c21c1d776f0068ec03ec0bfbca436d4676f6dcb"
    end
    if Hardware::CPU.intel?
      url "https://github.com/sattamBytes/histq/releases/download/v0.1.0/histq-x86_64-apple-darwin.tar.xz"
      sha256 "8a8a1bebbdf44af8caeb6be4a1694718fd1a150c74d5e735ccc7edefff1edb5f"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/sattamBytes/histq/releases/download/v0.1.0/histq-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "d5cf9db98e02fc3063ac885a57db84ff7db1561059a2db38ab376b63abcea3f2"
    end
    if Hardware::CPU.intel?
      url "https://github.com/sattamBytes/histq/releases/download/v0.1.0/histq-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "6148f29ddd3b545ecdf6a2bb63c76e8cdc88b6fd30621341a0ccfd36b45fa64e"
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
