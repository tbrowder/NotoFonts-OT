use OO::Monitors;

#unit monitor NotoFonts::OT;
unit module NotoFonts::OT;

use MacOS::NativeLib "*";

use PDF::Font::Loader::HarfBuzz;
use PDF::Font::Loader :load-font;
use PDF::Content;
use PDF::Content::FontObj;
use PDF::Lite;
use FontConfig;

use NotoFonts::OT::Download;
use NotoFonts::OT::FontPaths;
use NotoFonts::OT::Registry;

# warning: the Subs module is NOT usable with this module
#use NotoFonts::OT::Subs;
use NotoFonts::OT::Vars;

monitor NotoFontsOT {

has IO::Path $.registry-dir;
has %.fonts;

submethod TWEAK {
    my $env-name = "NOTO_FONTS_DIR";

    say "Environment variable $env-name is not defined"
        unless %*ENV{$env-name}:exists;

    say "Environment variable $env-name is empty"
        unless %*ENV{$env-name}:exists;

    $!registry-dir = %*ENV{$env-name}.IO;
}

method list-fonts(
    --> Nil
) {
    for %!fonts.keys.sort -> $name {
        say $name;
    }
    say();
    say "Registry directory: $!registry-dir";
}

method 
get-font(
    $code,
#   --> PDF::Content::FontObj
) {
    # given a "code", return a FontObj
    ; # ok
}

}

#sub get-font(

