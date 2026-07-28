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

my $nf = NotoFonts-OT.new;

isa-ok $nf, NotoFonts-OT;

if 0 and $debug {
    say "WARNING: This test MUST pass in order to publish";
}

my @codes = 't', 'se', 1;
for @codes.kv -> $i, $code {
    my $f = $nf.get-font: $code;
    isa-ok $f, PDF::Content::FontObj;
    my $fnam = $f.font-name;
    is $fnam, "NotoSerif-Regular", "font knows its name";
}

done-testing;
=finish

#=begin comment
# check ALL fonts load;
for $nf.list-font-codes.sort -> $code {
    my $f = $nf.get-font: $code;
    isa-ok $f, PDF::Content::FontObj;
    say $f.font-name if $debug;
}
#=end comment

done-testing;
