use Test;

my $debug = 1;

use MacOS::NativeLib "*";
use PDF::Font::Loader::HarfBuzz;
use PDF::Font::Loader :load-font;
use PDF::Content;
use PDF::Content::FontObj;
use PDF::Lite;

# tests independent, non-class subs
use NotoFonts-OT::FontPaths;

for 1..10 -> $n {
    my $font = get-loaded-font $n;
    isa-ok $font, PDF::Content::FontObj;

    my $font-path = get-font-path $n;
    isa-ok $font-path, IO::Path;
}


done-testing;
