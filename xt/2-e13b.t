use Test;

use MacOS::NativeLib "*";
use PDF::Font::Loader::HarfBuzz;
use PDF::Font::Loader :load-font;
use PDF::Content;
use PDF::Content::FontObj;
use PDF::Lite;

use NotoFonts-OT;

# Test for E13B characters

my $font = get-loaded-font 1;

my @required = (
    |('0' .. '9'),
    chr(0x2446),
    chr(0x2447),
    chr(0x2448),
    chr(0x2449),
);

for @required -> $character {
    my $encoded = try {
        $font.encode($character);
    };

    my Str $code-point =
        'U+' ~ $character.ord.fmt('%04X');

    if $encoded.defined and $encoded.chars {
        say "$code-point '$character' ENCODED";
    }
    else {
        say "$code-point '$character' NOT ENCODED";
    }
}

done-testing;
