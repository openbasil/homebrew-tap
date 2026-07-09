class Basil < Formula
  desc "Basil is a host-local secrets broker: your app never touches the key. Unified broker daemon, operator tool, and client CLI."
  homepage "https://github.com/openbasil/basil"
  version "0.7.1"
  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/openbasil/basil/releases/download/v0.7.1/basil-bin-aarch64-apple-darwin.tar.xz"
    sha256 "4e758a8487d777360dd3ef76f3c0f46db755a1700024fb7ea5dea9bb154b6868"
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/openbasil/basil/releases/download/v0.7.1/basil-bin-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "1a288712758e179559de43715113a2c7afbbf7d55eb94f11b50e01f829b791ae"
    end
    if Hardware::CPU.intel?
      url "https://github.com/openbasil/basil/releases/download/v0.7.1/basil-bin-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "897e828ddb9eb46f1eb64cb5155951fd4294c431da07197383a145cda336d8b5"
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
