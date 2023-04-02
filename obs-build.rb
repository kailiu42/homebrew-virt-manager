class ObsBuild < Formula
  desc "A Script to Build SUSE Linux RPMs"
  version "20230314"
  homepage "https://www.github.com/openSUSE/obs-build"
  url "https://github.com/openSUSE/obs-build/archive/refs/tags/#{version}.tar.gz"
  sha256 "e7b19902b6c68ef27644c6e96d9e44a6738b4ed446324d83723bdab3c07b30ce"

  def caveats
    "This formula needs $HOMEBREW_TEMP to be set to a case sensitive filesystem!"
  end

  def install
    system "make", "install", "prefix=#{prefix}"
  end
end
