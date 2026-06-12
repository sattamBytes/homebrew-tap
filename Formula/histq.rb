class Histq < Formula
  desc "Project-aware shell history for zsh: an up-arrow that knows your repo"
  homepage "https://github.com/sattamBytes/histq"
  version "0.2.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/sattamBytes/histq/releases/download/v0.2.1/histq-aarch64-apple-darwin.tar.xz"
      sha256 "e2e94306fc552ef230ad042cc4c88ef7701325c45d0298c4782a9d85379ef2f3"
    end
    if Hardware::CPU.intel?
      url "https://github.com/sattamBytes/histq/releases/download/v0.2.1/histq-x86_64-apple-darwin.tar.xz"
      sha256 "158da9c3ce7f2fddd79ff9c3f164fabb2ba71b1ee119925f098fea53fd77a35c"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/sattamBytes/histq/releases/download/v0.2.1/histq-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "8c46482bcce8111b04f2ea5d590e5e846cb407d8b47dbd0f40074ccdb78b4eb9"
    end
    if Hardware::CPU.intel?
      url "https://github.com/sattamBytes/histq/releases/download/v0.2.1/histq-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "6dcd27efa808a7fb2e13e9ac4f4e1743b03dc1a9f0fac1bb423f5db4aaee9d69"
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
