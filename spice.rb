class Spice < Formula
  homepage "https://www.spice-space.org/"
  version "0.15.0"
  url "https://www.spice-space.org/download/releases/spice-server/spice-#{version}.tar.bz2"
  sha256 "b320cf8f4bd2852750acb703c15b72856027e5a8554f8217dfbb3cc09deba0f5"
  license "GPL-2.0-only"

  head do
    url "https://gitlab.freedesktop.org/spice/spice.git"

    depends_on "autoconf" => :build
    depends_on "autoconf-archive" => :build
    depends_on "autogen" => :build
    depends_on "automake" => :build
    depends_on "gobject-introspection" => :build
    depends_on "intltool" => :build
    depends_on "libtool" => :build
    depends_on "pkg-config" => :build
    depends_on "vala" => :build
  end

  depends_on "atk"
  depends_on "cairo"
  depends_on "gdk-pixbuf"
  depends_on "gettext"
  depends_on "glib"
  depends_on "gst-libav"
  depends_on "gst-plugins-bad"
  depends_on "gst-plugins-base"
  depends_on "gst-plugins-good"
  depends_on "gst-plugins-ugly"
  depends_on "gstreamer"
  depends_on "gtk+3"
  depends_on "jpeg"
  depends_on "json-glib"
  depends_on "libusb"
  depends_on "lz4"
  depends_on "openssl@1.1"
  depends_on "opus"
  depends_on "pango"
  depends_on "pixman"
  depends_on "spice-protocol"
  depends_on "usbredir"

  def install
    args = %W[
      --prefix=#{prefix}
      --disable-debug
      --disable-dependency-tracking
      --disable-silent-rules
    ]

    system "./autogen.sh" if build.head?
    system "./configure", *args
    system "make", "install"
  end

end
