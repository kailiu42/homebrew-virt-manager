class ManPages < Formula
  desc "Linux man pages"
  version "6.03"
  homepage "https://www.kernel.org/doc/man-pages/download.html"
  url "https://mirrors.edge.kernel.org/pub/linux/docs/man-pages/man-pages-#{version}.tar.xz"
  sha256 "5f7f289d30b296b78116a08e7703df9375aa846b332b57dca47ddcbb7809fbbd"

  depends_on "coreutils" => :build

  resource "man-pages-posix" do
    url "https://mirrors.edge.kernel.org/pub/linux/docs/man-pages/man-pages-posix/man-pages-posix-2017-a.tar.xz"
    sha256 "ce67bb25b5048b20dad772e405a83f4bc70faf051afa289361c81f9660318bc3"
  end

  keg_only "Some files conflict with files from other formula, such as perl."

  def install
    system "make", "install", "prefix=#{prefix}", "INSTALL=ginstall"
    resource("man-pages-posix").stage {
      system "make", "install", "prefix=#{prefix}", "INSTALL=ginstall"
    }
  end
end
