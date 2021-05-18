class Qemu < Formula
  desc "Emulator for x86 and PowerPC"
  homepage "https://www.qemu.org/"
  version "6.0.0"
  url "https://download.qemu.org/qemu-#{version}.tar.xz"
  sha256 "87bc1a471ca24b97e7005711066007d443423d19aacda3d442558ae032fa30b9"
  license "GPL-2.0-only"
  head "https://git.qemu.org/git/qemu.git"

  option "with-docs", "Build and install man pages and HTML manual"

  depends_on "libtool" => :build
  depends_on "pkg-config" => :build
  depends_on "ninja" => :build
  depends_on "glib"
  depends_on "gnutls"
  depends_on "jpeg"
  depends_on "libpng"
  depends_on "libssh"
  depends_on "libusb"
  depends_on "lzo"
  depends_on "nettle"
  depends_on "pixman"
  depends_on "snappy"
  depends_on "vde"
  depends_on "spice"
  depends_on "spice-protocol"
  depends_on "openssl@1.1"
  depends_on "libgcrypt"
  depends_on "lzfse"
  depends_on "zstd"
  depends_on "libusb"
  depends_on "sphinx-doc" if build.with? "docs"

  # 820KB floppy disk image file of FreeDOS 1.2, used to test QEMU
  resource "test-image" do
    url "https://dl.bintray.com/homebrew/mirror/FD12FLOPPY.zip"
    sha256 "81237c7b42dc0ffc8b32a2f5734e3480a3f9a470c50c14a9c4576a2561a35807"
  end

  def install
    ENV["LIBTOOL"] = "glibtool"

    args = %W[
      --prefix=#{prefix}
      --cc=#{ENV.cc}
      --host-cc=#{ENV.cc}
      --disable-bsd-user
      --disable-guest-agent
      --enable-libssh
      --enable-vde
      --disable-sdl
      --disable-gtk
      --enable-spice
      --enable-gcrypt
      --enable-lzfse
      --enable-zstd
      --enable-libusb
      --enable-avx2
      --enable-avx512f
      --extra-cflags=-mfma
    ]

    args << "--enable-docs" if build.with? "docs"

    # Sharing Samba directories in QEMU requires the samba.org smbd which is
    # incompatible with the macOS-provided version. This will lead to
    # silent runtime failures, so we set it to a Homebrew path in order to
    # obtain sensible runtime errors. This will also be compatible with
    # Samba installations from external taps.
    args << "--smbd=#{HOMEBREW_PREFIX}/sbin/samba-dot-org-smbd"

    on_macos do
      args << "--enable-cocoa"
    end

    # Only build this targets
    args << "--target-list=aarch64-softmmu,arm-softmmu,i386-softmmu,x86_64-softmmu"

    system "./configure", *args
    system "make", "V=1", "install"
  end

  test do
    expected = build.stable? ? version.to_s : "QEMU Project"
    assert_match expected, shell_output("#{bin}/qemu-system-aarch64 --version")
    assert_match expected, shell_output("#{bin}/qemu-system-arm --version")
    assert_match expected, shell_output("#{bin}/qemu-system-i386 --version")
    assert_match expected, shell_output("#{bin}/qemu-system-x86_64 --version")
    resource("test-image").stage testpath
    assert_match "file format: raw", shell_output("#{bin}/qemu-img info FLOPPY.img")
  end
end
