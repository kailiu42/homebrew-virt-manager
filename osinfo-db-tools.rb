class OsinfoDbTools < Formula
  desc "Tools for managing the libosinfo database files"
  homepage "https://libosinfo.org"
  url "https://releases.pagure.org/libosinfo/osinfo-db-tools-1.8.0.tar.xz"
  sha256 "e9811a936e74dc262ce297ea7b8addeb111c782de500c9e285d3cdd5fe1b180d"

  depends_on "pkg-config" => :build
  depends_on "meson" => :build
  depends_on "ninja" => :build

  depends_on "gettext"
  depends_on "glib"
  depends_on "json-glib"
  depends_on "libarchive" # need >= 3.0.0
  depends_on "libsoup"
  depends_on "libxml2"
  depends_on "libxslt"

  def install
    args = %w[
    ]

    mkdir "build" do
      system "meson", *std_meson_args, ".."
      system "ninja", "-v"
      system "ninja", "install", "-v"
    end
  end

  test do
    system "#{bin}/osinfo-db-path"
  end
end
