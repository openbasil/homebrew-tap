class Basil < Formula
  desc "Unified Basil operator and client binary."
  homepage "https://github.com/openbasil/basil"
  version "0.7.0"
  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/openbasil/basil/releases/download/v0.7.0/basil-bin-aarch64-apple-darwin.tar.xz"
    sha256 "4045f418d80d526d45e9ac62f14833b0ed0506ee741dad97f5e63b542fd7005e"
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/openbasil/basil/releases/download/v0.7.0/basil-bin-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "7efbad68bbd4000ed8530bde4790c358abf07c09181ba34fcd0d112fdad5a689"
    end
    if Hardware::CPU.intel?
      url "https://github.com/openbasil/basil/releases/download/v0.7.0/basil-bin-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "00fb86daf337cf41dee33711f10343695c3acd6d30f8a192b6dd8505f220d899"
    end
  end
  license "Apache-2.0"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":      {},
    "aarch64-unknown-linux-gnu": {},
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
    bin.install "basil" if OS.mac? && Hardware::CPU.arm?
    bin.install "basil" if OS.linux? && Hardware::CPU.arm?
    bin.install "basil" if OS.linux? && Hardware::CPU.intel?

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
