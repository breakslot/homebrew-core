class Fig2dev < Formula
  desc "Translates figures generated by xfig to other formats"
  homepage "https://mcj.sourceforge.io/"
  url "https://downloads.sourceforge.net/project/mcj/fig2dev-3.2.6a.tar.xz"
  sha256 "5e61a3d9a4f83db4b3199ee82dd54bb65b544369f1e8e38a2606c44cf71667a7"

  bottle do
    sha256 "31feda2231f672f7c15c2a74f9b392e0fa8378a0b7598010ed04e4a532f7a079" => :sierra
    sha256 "ab4631a22c7d46b00f5271c390e64cf07f7acd54cd382937b153d0507c7d568f" => :el_capitan
    sha256 "f144d58e99b3fa4b3798c30ba6c70b35b28c9840193357d89b748928200a4a48" => :yosemite
  end

  depends_on :x11
  depends_on "ghostscript"
  depends_on "libpng"

  def install
    system "./configure", "--prefix=#{prefix}",
                          "--disable-dependency-tracking",
                          "--disable-silent-rules",
                          "--enable-transfig"
    system "make", "install"

    # Install a fig file for testing
    pkgshare.install "fig2dev/tests/data/patterns.fig"
  end

  test do
    system "#{bin}/fig2dev", "-L", "png", "#{pkgshare}/patterns.fig", "patterns.png"
    assert_predicate testpath/"patterns.png", :exist?, "Failed to create PNG"
  end
end
