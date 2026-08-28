use v6.d; 
use Test;

use MacOS::NativeLib "*";
use PDF::Font::Loader::HarfBuzz;
use PDF::Font::Loader :load-font;
use PDF::Content;
use PDF::Content::FontObj;
use PDF::Lite;

use Digest::SHA256::Native;
use File::Find;
use NotoFonts-OT;

# sub get-font-path $code #  

# the embedded font files paths
my $debug = 0;

# the sha256sums and font file basenames
for 1..10 -> $code {
    my $path = get-font-path $code;
    if not $path.IO.f {
        note "path $path is NOT a path";
        next;
    }
    note "path: $path";
    do-sha256 $path;
    next;

    my $sha2 = calc-sha256sumB $path;
    note "sha2:  $sha2";
#   my $sha  = calc-sha256sum $path;
#   note "sha:  $sha";
    last;
}


=finish

my $dir = "./resources/fonts/";
my @bfils = find :$dir, :type<file>, :name(/:i '.otf' $/);

my $fdir = "./resources/fonts/";

my $sfil = "./resources/text/SHA256SUMS.txt";
my @lines = $sfil.IO.slurp.lines;
my %file-sha;

for @lines -> $line is copy {
    $line .= Str;
    my $fil = $line.words.tail;

    my $dir = "./resources/fonts/";
    my @fils = find :$dir, :type<file>, :name(/:i '.otf' $/);
    my $sha = $line.words.head;
    %file-sha{$fil} = $sha;
}

my %new-fil-sha;
for %file-sha.kv -> $fil is copy, $sha {
    my $sha2 = calc-sha256sum $fil;
    is $sha2, $sha;
}

=begin comment
for @fils ->  $f is copy {
    say "Inspecting file:";
    say "  '$f'";
    my $fb = $f.basename;
    say "  '$fb'";

    # get the precalculated sha256sum
    my $precalc-sha = (%fils{$fb}).Str;

    # calculate it anew
    my $proc = run "sha256sum", $f, :out;
    my $res = $proc.out.get; # shasum filename
    my @w = $res.words;
    my $sha = @w.head;
    say "  current sha '$sha'";
    is $sha, $precalc-sha, "the two shasums should be the same";
}
=end comment
    
done-testing;

