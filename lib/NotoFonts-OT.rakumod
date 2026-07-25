#use OO::Monitors;

#unit monitor NotoFonts-OT;
unit class  NotoFonts-OT;

use MacOS::NativeLib "*";
use PDF::Font::Loader::HarfBuzz;
use PDF::Font::Loader :load-font;
use PDF::Content;
use PDF::Content::FontObj;
use PDF::Lite;

use NotoFonts-OT::Download;
use NotoFonts-OT::FontPaths;
use NotoFonts-OT::Registry;
use NotoFonts-OT::Subs;
use NotoFonts-OT::Vars;

#=begin comment

has IO::Path $!registry-dir;
has %!fonts;

submethod BUILD {
    my $env-name = "NOTO_FONTS_DIR";

    die "Environment variable $env-name is not defined"
        unless %*ENV{$env-name}:exists;

    die "Environment variable $env-name is empty"
        unless %*ENV{$env-name}.exists;

#    $!registry-dir = %*ENV{$env-name}.IO;
}

method list-fonts(
    --> Nil
) {
    for %!fonts.keys.sort -> $name {
        say $name;
    }
    say();
    say "Registry directoru: $!registry-dir";
}


method 
get-font(
    $code,
#   --> PDF::Content::FontObj
) {
    # given a "code", return a FontObj
}
#=end comment

