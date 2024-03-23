class Osc < Formula
  include Language::Python::Virtualenv

  desc "Command-line interface to work with an Open Build Service"
  homepage "https://openbuildservice.org"
  version "1.6.1"
  url "https://github.com/openSUSE/osc/archive/refs/tags/#{version}.tar.gz"
  sha256 "da8d0317271335c91780ed397fd61b8d4bafff0e4e8b41f6bf88441e87c78bc8"
  license "GPL-2.0-or-later"
  head "https://github.com/openSUSE/osc.git", branch: "master"

  depends_on "rust" => :build # for cryptography
  depends_on "cffi"
  depends_on "openssl@3"
  depends_on "pycparser"
  depends_on "python@3.12"
  depends_on "pyyaml"

  uses_from_macos "curl"

  resource "cryptography" do
    url "https://files.pythonhosted.org/packages/13/9e/a55763a32d340d7b06d045753c186b690e7d88780cafce5f88cb931536be/cryptography-42.0.5.tar.gz"
    sha256 "6fe07eec95dfd477eb9530aef5bead34fec819b3aaf6c5bd6d20565da607bfe1"
  end

  resource "rpm" do
    url "https://files.pythonhosted.org/packages/8c/15/ef9b3d4a0b4b9afe62fd2be374003643ea03fc8026930646ad0781bb9492/rpm-0.1.0.tar.gz"
    sha256 "0e320a806fb61c3980c0cd0c5f5faec97c73c347432902ba2955a08a7b1a034f"
  end

  resource "urllib3" do
    url "https://files.pythonhosted.org/packages/7a/50/7fd50a27caa0652cd4caf224aa87741ea41d3265ad13f010886167cfcc79/urllib3-2.2.1.tar.gz"
    sha256 "d0570876c61ab9e520d776c38acbbb5b05a776d3f9ff98a5c8fd5162a444cf19"
  end

  resource "progressbar2" do
    url "https://files.pythonhosted.org/packages/41/7b/42c1cec1218b8b9289d6c84bc9d874df1f06db642ad3350d01a4116de834/progressbar2-4.4.2.tar.gz"
    sha256 "3fda2e0c60693600a6585a784c9d3bc4e1dac57e99e133f8c0f5c8cf3df374a2"
  end

  resource "distro" do
    url "https://files.pythonhosted.org/packages/fc/f8/98eea607f65de6527f8a2e8885fc8015d3e6f5775df186e443e0964a11c3/distro-1.9.0.tar.gz"
    sha256 "2fa77c6fd8940f116ee1d6b94a2f90b13b5ea8d019b98bc8bafdcabcdd9bdbed"
  end

  resource "keyring" do
    url "https://files.pythonhosted.org/packages/ae/6c/bd2cfc6c708ce7009bdb48c85bb8cad225f5638095ecc8f49f15e8e1f35e/keyring-24.3.1.tar.gz"
    sha256 "c3327b6ffafc0e8befbdb597cacdb4928ffe5c1212f7645f186e6d9957a898db"
  end

  resource "argparse-manpage" do
    url "https://files.pythonhosted.org/packages/fe/0d/8b343214e65ae5e50d3de88706197e2351224b0cc52dde63e621c038d5fa/argparse-manpage-4.5.tar.gz"
    sha256 "213c061878a10bf0e40f6a293382f6e82409e5110d0683b16ebf87f903d604db"
  end

  def install
    # Fix path as we install to /usr/local instead of /usr
    inreplace "osc/conf.py", "/usr/lib/build", "/usr/local/lib/build"
    inreplace "osc/commandline.py", "/usr/lib/build", "/usr/local/lib/build"
    inreplace "osc/build.py", "/usr/lib/build", "/usr/local/lib/build"

    virtualenv_install_with_resources

	# Build man page
    ENV["PYTHONPATH"] = "."
    args = %W[
      --output=osc.1
      --format=single-commands-section
      --module=osc.commandline
      --function=get_parser
      --project-name=osc
      --prog=osc
      --description=OpenSUSE\ Commander
      --author=Contributors\ to\ the\ osc\ project.\ See\ the\ project's\ GIT\ history\ for\ the\ complete\ list.
      --url=https://github.com/openSUSE/osc/
    ]

    system "#{libexec}/bin/argparse-manpage", *args

    # Install man page
    man1.install "osc.1"
  end

  test do
    system bin/"osc", "version"
  end
end
