class ImagemagickPango < Formula
  desc "Tools and libraries to manipulate images in many formats"
  homepage "https://www.imagemagick.org/"
  # Please always keep the Homebrew mirror as the primary URL as the
  # ImageMagick site removes tarballs regularly which means we get issues
  # unnecessarily and older versions of the formula are broken.
  url "https://dl.bintray.com/homebrew/mirror/ImageMagick-7.0.8-40.tar.xz"
  mirror "https://www.imagemagick.org/download/ImageMagick-7.0.8-40.tar.xz"
  sha256 "8b7bb75fdac3fbe8f847eb127d471989d505e44ac6664fa030ef86992c12f26d"
  revision 1
  head "https://github.com/ImageMagick/ImageMagick.git"

  bottle do
    sha256 "b1f061daafa5864eb83dbaf8935dbb0af8d9fd4866347b68ace9c6312cf2e5d9" => :mojave
    sha256 "8829e22ddc6dbe5ede81729b85070e78a1d2aa589dda6553bd699358c9687b0f" => :high_sierra
    sha256 "b06a132ac5a78657d81dad35ca74e80178ca11379a91a4495b9ac667746e3d1e" => :sierra
  end

  depends_on "pkg-config" => :build

  depends_on "freetype"
  depends_on "jpeg"
  depends_on "libheif"
  depends_on "libomp"
  depends_on "libpng"
  depends_on "libtiff"
  depends_on "libtool"
  depends_on "little-cms2"
  depends_on "openexr"
  depends_on "openjpeg"
  depends_on "webp"
  depends_on "xz"
  depends_on "pango"
  depends_on "harfbuzz"

  skip_clean :la

  def install
    args = %W[
      --disable-osx-universal-binary
      --prefix=#{prefix}
      --disable-dependency-tracking
      --disable-silent-rules
      --disable-opencl
      --enable-shared
      --enable-static
      --with-freetype=yes
      --with-modules
      --with-openjp2
      --with-openexr
      --with-webp=yes
      --with-heic=yes
      --without-gslib
      --with-gs-font-dir=#{HOMEBREW_PREFIX}/share/ghostscript/fonts
      --without-fftw
      --with-pango=yes
      --without-x
      --without-wmf
      --enable-openmp
      ac_cv_prog_c_openmp=-Xpreprocessor\ -fopenmp
      ac_cv_prog_cxx_openmp=-Xpreprocessor\ -fopenmp
      LDFLAGS=-lomp
    ]

    # versioned stuff in main tree is pointless for us
    inreplace "configure", "${PACKAGE_NAME}-${PACKAGE_VERSION}", "${PACKAGE_NAME}"
    system "./configure", *args
    system "make", "install"
  end

  test do
    assert_match "PNG", shell_output("#{bin}/identify #{test_fixtures("test.png")}")
    # Check support for recommended features and delegates.
    features = shell_output("#{bin}/convert -version")
    %w[Modules freetype jpeg png tiff].each do |feature|
      assert_match feature, features
    end
  end
end