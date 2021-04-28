class ObsBuild < Formula
  desc "A Script to Build SUSE Linux RPMs"
  version "1.4.1"
  homepage "https://www.github.com/openSUSE/obs-build"
  url "https://github.com/openSUSE/obs-build/archive/refs/tags/20210120.tar.gz"
  sha256 "070c493720490d8bee9d43dfac673027a7a06485cd0d2f0ab9be2105fe3b8584"

  def caveats
    "This formula needs $HOMEBREW_TEMP to be set to a case sensitive filesystem!"
  end

  def install
    system "make", "install", "prefix=#{prefix}"
  end
end
