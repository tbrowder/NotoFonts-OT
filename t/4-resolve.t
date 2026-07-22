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
use NotoFonts-OT::Subs;
use NotoFonts-OT::Vars;

my ($font-path, $font-path2);
my ($font, $font2, $code);

# test the resolve-fontref sub

my $ff = NotoFonts-OT.new;
isa-ok $ff, NotoFonts-OT, "good class object";

#my %h = $ff.font-file-paths;
my %fonts = font-paths;
isa-ok %fonts, Hash, "good Hash of font paths";

my @k  = %fonts.keys.sort;
my $nk = @k.elems;
is $nk, 56, "must have $nk elements";
isa-ok %fonts{@k.head}, IO::Path, "valid path";

isa-ok %fonts{@k.head}.IO, IO::Path, "valid path";
$code = "t";
isa-ok %fonts{$code}.IO, IO::Path, "valid path";

$font = load-font :file(%fonts{$code}); 
is $font.font-name, "NotoSerif-Regular", "FontObj knows its name";

$code = "hob";
$font = load-font :file(%fonts{$code}); 
isa-ok $font, PDF::Content::FontObj;

$code = 1;
$font = load-font :file(%fonts{$code}); 
isa-ok $font, PDF::Content::FontObj;

$code = "NotoSerif-Regular";
$font = load-font :file(%fonts{$code}); 
isa-ok $font, PDF::Content::FontObj;

$font2 = load-font :file(%fonts{$code}); 
isa-ok $font2, PDF::Content::FontObj;

# test the sharing of the same font
if not $debug {
    is $font, $font2;
}
else {
    say "WARNING: This test MUST pass in order to publish";
}

isa-ok $font, PDF::Content::FontObj;
isa-ok $font2, PDF::Content::FontObj;

# test the sharing of the same font
if not $debug {
    is $font, $font2;
}
else {
    say "WARNING: This test MUST pass in order to publish";
}

$code = "h";
$font = load-font :file(%fonts{$code}); 
$code = "se";
$font2 = load-font :file(%fonts{$code}); 
isa-ok $font, PDF::Content::FontObj;
isa-ok $font2, PDF::Content::FontObj;

# test the sharing of the same font
if not $debug {
    is $font, $font2;
}
else {
    say "WARNING: This test MUST pass in order to publish";
}

$code = "c";
$font = load-font :file(%fonts{$code}); 
$code = "m";
$font2 = load-font :file(%fonts{$code}); 

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


