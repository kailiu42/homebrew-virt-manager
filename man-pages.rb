class ManPages < Formula
  desc "Linux man pages"
  version "5.13"
  homepage "https://www.kernel.org/doc/man-pages/download.html"
  url "https://mirrors.edge.kernel.org/pub/linux/docs/man-pages/man-pages-#{version}.tar.xz"
  sha256 "614dae3efe7dfd480986763a2a2a8179215032a5a4526c0be5e899a25f096b8b"

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
