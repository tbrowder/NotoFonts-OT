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

my ($font, $font2, $code);

my $nf = NotoFonts-OT.new;

isa-ok $nf, NotoFonts-OT, "good NotoFonts-OT object";

$font = $nf.get-font: 1;
isa-ok $font, PDF::Content::FontObj;
is $font.font-name, "NotoSerif-Regular", "FontObj knows its name";

$code = "NotoSerif-Regular";
$font2 = $nf.get-font: $code;
isa-ok $font2, PDF::Content::FontObj;

$font   = $nf.get-font: <h>;
$font2  = $nf.get-font: <se>;
isa-ok $font, PDF::Content::FontObj;
isa-ok $font2, PDF::Content::FontObj;

$font  = $nf.get-font: <c>;
$font2 = $nf.get-font: <m>;
isa-ok $font, PDF::Content::FontObj;
isa-ok $font2, PDF::Content::FontObj;

done-testing;
