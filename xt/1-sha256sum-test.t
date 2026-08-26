use v6.d;

use Test;

use File::Find;

use NotoFonts-OT;

my $debug = 0;

=begin comment
my $dir = "./resources/fonts";

my %known = %(
'4790a85213b1d4f81072b1c09b850c05525def8d6613f44b54962237bf5e24e2' => 'NotoSansMono-Regular.otf',
'848c9e5b7ef9d2d5e7dc7a971166359193c60bae35dcb00ed27666dcf923af2e' => 'NotoSansMono-Bold.otf',
'ab7c44556910a64386932d25bf7eaed6c66f84390aaebeedffdea0c5bf8cf565' => 'NotoSerif-Regular.otf',
'889f587cbf86284fb48a7cc17bc1273dd8ba9d73770be8f19d75a0264fc8ccc5' => 'NotoSerif-Italic.otf',
'58c8542f67b66c0b5fa76084819adbf07265f348053daa4d07eda947998ac1ce' => 'NotoSerif-Bold.otf',
'beefb2a93a693587242f2838f8b6adf66ca14dcd5d9b4b7503ba24642a6d838d' => 'NotoSerif-BoldItalic.otf',
'a98da79cd9ac5b515b0b66096d85aa9a26aa665a6f0b5d2a6ec930fdaa64ddc6' => 'NotoSans-Regular.otf',
'bc9fa92fa3c5e09752ed82cd05c9485ade5ac182658169f9311d70a1a0a56a26' => 'NotoSans-Italic.otf',
'028a3b481c07aa0f068a14c7883362c91e453d50c8322a768c7d5f94eb64dfa4' => 'NotoSans-BoldItalic.otf',
'2cd45446ef6d6b96272c48a90467c56cdbccfed5d9632df2239b8369bd9f1e0a' => 'NotoSans-Bold.otf',
);

my %fils = %known.invert;

if not @*ARGS {
    say qq:to/HERE/;
    Usage: {$*PROGRAM.basename} <inputs>

    Use this program to get sha256sums for a set of input files
      and, optionally, to check against a known set for
      the input files.

    HERE
    exit;
}

=end comment

my $fdir = "./resources/fonts/";
my $sfil = "./resources/text/SHA256SUMS.txt";
my @pairs = $sfil.IO.slurp.lines;
my %fil-sha;
for @pairs -> $pair {
    my $fil = $pair.words.tail;
    my $sha = $pair.words.head;
    %fil-sha{$fil} = $sha;
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




done-testing;

