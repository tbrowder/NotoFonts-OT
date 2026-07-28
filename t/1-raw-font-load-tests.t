use OO::Monitors;

use Test;

my $debug = 1;

use MacOS::NativeLib "*";
use PDF::Font::Loader::HarfBuzz;
use PDF::Font::Loader :load-font;
use PDF::Content;
use PDF::Content::FontObj;
use PDF::Lite;

# testing the file path getter:
use NotoFonts-OT;
my $nf = NotoFonts-OT.new;
isa-ok $nf, NotoFonts-OT;
say $nf.list-font-codes;
say $nf.list-font-names;

for 1..10 -> $n {
    my $font = $nf.get-font: 1;
    isa-ok $font, PDF::Content::FontObj;
}

say "DEBUG: got valid loaded fonts";

done-testing;
