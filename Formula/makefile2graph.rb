class Makefile2graph < Formula
  desc "Create a graph of dependencies from GNU-Make"
  homepage "https://github.com/lindenb/makefile2graph"
  url "https://github.com/lindenb/makefile2graph/archive/2021.11.06.tar.gz"
  sha256 "5be8e528fa2945412357a8ef233e68fa3729639307ec1c38fd63768aad642c41"
  license "MIT"
  head "https://github.com/lindenb/makefile2graph.git", branch: "master"

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "5eb90095c4579d7d8616732bec7f266164f7b5f7665ef15fd3272720a4577cae"
    sha256 cellar: :any_skip_relocation, monterey:      "6010cadf93231ec03033a5248ad53ff57b099915ec8a72aa847a9a80a401257f"
    sha256 cellar: :any_skip_relocation, big_sur:       "7018264b838135807ab0a5e062a6315cf20b8de88b8dcff3f71afa03251eb8a2"
    sha256 cellar: :any_skip_relocation, catalina:      "58d4ab28a477688fb01b4db124c5d7deda3d7c2076e94e4c303ea1e8ab9a65c8"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "073d9b3b0eb9ff852a6f3f12aba6e3e2547d84e0d1257382b423a176df567299"
  end

  depends_on "graphviz"

  def install
    system "make"
    system "make", "test"
    bin.install "make2graph", "makefile2graph"
    man1.install "make2graph.1", "makefile2graph.1"
    doc.install "LICENSE", "README.md", "screenshot.png"
  end

  test do
    (testpath/"Makefile").write <<~EOS
      all: foo
      all: bar
      foo: ook
      bar: ook
      ook:
    EOS
    system "make -Bnd >make-Bnd"
    system "#{bin}/make2graph <make-Bnd"
    system "#{bin}/make2graph --root <make-Bnd"
    system "#{bin}/makefile2graph"
  end
end
