use OO::Monitors;

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
my $nf = NotoFonts-OT.new;

isa-ok $nf, NotoFonts-OT;
#my @clist = $nf.list-font-codes.words;
#my @nlist = $nf.list-font-names.words;

for 1..10 -> $n {
    my $font = $nf.get-font: $n;
    isa-ok $font, PDF::Content::FontObj;
    my $font-path = $nf.get-path: $n;
    isa-ok $font-path, IO::Path;
}

say "DEBUG: got valid loaded fonts" if $debug;
say "DEBUG: got valid font paths" if $debug;

done-testing;
