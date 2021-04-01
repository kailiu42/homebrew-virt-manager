class ManPages < Formula
  desc "Linux man pages"
  homepage "https://www.kernel.org/doc/man-pages/download.html"
  url "https://mirrors.edge.kernel.org/pub/linux/docs/man-pages/man-pages-5.11.tar.xz"
  sha256 "3eda5dce5184599ec37dae3494cf964c550362e9a41fb724792da610bdb13caa"

  resource "man-pages-posix" do
    url "https://mirrors.edge.kernel.org/pub/linux/docs/man-pages/man-pages-posix/man-pages-posix-2017-a.tar.xz"
    sha256 "ce67bb25b5048b20dad772e405a83f4bc70faf051afa289361c81f9660318bc3"
  end

  keg_only "Some files conflict with files from other formula, such as perl."

  def install
    system "make", "install", "prefix=#{prefix}"
    resource("man-pages-posix").stage {
      system "make", "install", "prefix=#{prefix}"
    }
  end
end
