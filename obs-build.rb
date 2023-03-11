class ObsBuild < Formula
  desc "A Script to Build SUSE Linux RPMs"
  version "20230228"
  homepage "https://www.github.com/openSUSE/obs-build"
  url "https://github.com/openSUSE/obs-build/archive/refs/tags/#{version}.tar.gz"
  sha256 "be126b4dbe32c207ca586df1d6685f8cd1d5afe948bd1e0f636373521c7529a0"

  def caveats
    "This formula needs $HOMEBREW_TEMP to be set to a case sensitive filesystem!"
  end

  def install
    system "make", "install", "prefix=#{prefix}"
  end
end
