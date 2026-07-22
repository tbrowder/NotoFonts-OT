use OO::Monitors;

use Test;

my $debug = 1;

use MacOS::NativeLib "*";
use PDF::Font::Loader::HarfBuzz;
use PDF::Font::Loader :load-font;
use PDF::Content;
use PDF::Content::FontObj;
use PDF::Lite;

use NotoFonts-OT;
use NotoFonts-OT::FontPaths;

my ($font-path, $font-path2);
my ($font, $font2, $code);

my $ff = NotoFonts-OT.new;
isa-ok $ff, NotoFonts-OT, "good NotoFonts-OT object";

my %fonts = get-font-file-paths-hash;
isa-ok %fonts, Hash, "good Hash of font paths";

my @k  = %fonts.keys.sort;
my $nk = @k.elems;
is $nk, 56, "must have 56 elements";

isa-ok %fonts{@k.head}.IO, IO::Path, "valid path";
$code = "t";
$font-path = %fonts<t>.IO;
isa-ok $font-path, IO::Path, "valid path";

$font = PDF::Font::Loader.load-font: :file($font-path);
is $font.font-name, "NotoSerif-Regular", "FontObj knows its name";

my $file = %fonts<hob>; #$ff.get-font-path: "hob";
	
$font = load-font :$file;
isa-ok $font, PDF::Content::FontObj;

$file = %fonts<1>;
$font = load-font :$file;
isa-ok $font, PDF::Content::FontObj;

$code = "NotoSerif-Regular";
$file = %fonts{$code};
$font = load-font :$file;
isa-ok $font, PDF::Content::FontObj;

done-testing;
=finish

# test the sharing of the same font
if not $debug {
    is $font, $font2;
}
else {
    say "WARNING: This test MUST pass in order to publish";
}


=finish

isa-ok $font, PDF::Content::FontObj;
isa-ok $font2, PDF::Content::FontObj;

# test the sharing of the same font
if not $debug {
    is $font, $font2;
}
else {
    say "WARNING: This test MUST pass in order to publish";
}

$font   = $ff.fonts<h>;
$font2  = $ff.fonts<se>;
isa-ok $font, PDF::Content::FontObj;
isa-ok $font2, PDF::Content::FontObj;

# test the sharing of the same font
if not $debug {
    is $font, $font2;
}
else {
    say "WARNING: This test MUST pass in order to publish";
}

$font  = $ff.fonts<c>;
$font2 = $ff.fonts<m>;
isa-ok $font, PDF::Content::FontObj;
isa-ok $font2, PDF::Content::FontObj;

# test the sharing of the same font
if not $debug {
    is $font, $font2;
}
else {
    say "WARNING: This test MUST pass in order to publish";
}

done-testing;
