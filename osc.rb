class Osc < Formula
  include Language::Python::Virtualenv

  desc "Command-line interface to work with an Open Build Service"
  homepage "https://openbuildservice.org"
  version "1.0.0b5"
  url "https://github.com/openSUSE/osc/archive/refs/tags/#{version}.tar.gz"
  sha256 "6a299e66c45abdda5c17349ef7eed75df5cbad87e0b5624bc2fce02562318533"
  license "GPL-2.0-or-later"
  head "https://github.com/openSUSE/osc.git", branch: "master"

  depends_on "rust" => :build
  depends_on "openssl@3"
  depends_on "python@3.10"

  uses_from_macos "curl"

  resource "cryptography" do
    url "https://files.pythonhosted.org/packages/fa/f3/f4b8c175ea9a1de650b0085858059050b7953a93d66c97ed89b93b232996/cryptography-39.0.2.tar.gz"
    sha256 "bc5b871e977c8ee5a1bbc42fa8d19bcc08baf0c51cbf1586b0e87a2694dde42f"
  end

  resource "urllib3" do
    url "https://files.pythonhosted.org/packages/21/79/6372d8c0d0641b4072889f3ff84f279b738cd8595b64c8e0496d4e848122/urllib3-1.26.15.tar.gz"
    sha256 "8a388717b9476f934a21484e8c8e61875ab60644d29b9b39e11e4b9dc1c6b305"
  end

  resource "progressbar2" do
    url "https://files.pythonhosted.org/packages/7c/1b/c9f6ae95599a071500ff9c8ead4381ff8691362c272e567c12a1c5fe94b2/progressbar2-4.2.0.tar.gz"
    sha256 "1393922fcb64598944ad457569fbeb4b3ac189ef50b5adb9cef3284e87e394ce"
  end

  resource "distro" do
    url "https://files.pythonhosted.org/packages/4b/89/eaa3a3587ebf8bed93e45aa79be8c2af77d50790d15b53f6dfc85b57f398/distro-1.8.0.tar.gz"
    sha256 "02e111d1dc6a50abb8eed6bf31c3e48ed8b0830d1ea2a1b78c61765c2513fdd8"
  end

  resource "keyring" do
    url "https://files.pythonhosted.org/packages/55/fe/282f4c205add8e8bb3a1635cbbac59d6def2e0891b145aa553a0e40dd2d0/keyring-23.13.1.tar.gz"
    sha256 "ba2e15a9b35e21908d0aaf4e0a47acc52d6ae33444df0da2b49d41a46ef6d678"
  end

  resource "argparse-manpage" do
    url "https://files.pythonhosted.org/packages/03/cd/0598f30544d602eeb11cbc0d5c5d09cb48bd805ef884e7c56ff1239db7ce/argparse-manpage-4.tar.gz"
    sha256 "612506e63a1b9bed5d39d5392ac2656104a46cc3f4a086334850b6d170aef107"
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

    system "/usr/local/Cellar/osc/#{version}/libexec/bin/argparse-manpage", *args

    # Install man page
    man1.install "osc.1"
  end

  test do
    system bin/"osc", "version"
  end
end
