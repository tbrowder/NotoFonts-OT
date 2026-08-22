use Test;

my $debug = 0;

use MacOS::NativeLib "*";
use PDF::Font::Loader::HarfBuzz;
use PDF::Font::Loader :load-font;
use PDF::Content;
use PDF::Content::FontObj;
use PDF::Lite;

# testing the file path getter:
use NotoFonts-OT;

for 1..10 -> $n {
    my $font = get-loaded-font $n;
    isa-ok $font, PDF::Content::FontObj;

    my $font-path = get-font-path $n;
    isa-ok $font-path, IO::Path;
}

say "DEBUG: got valid loaded fonts" if $debug;
say "DEBUG: got valid font paths" if $debug;

done-testing;
