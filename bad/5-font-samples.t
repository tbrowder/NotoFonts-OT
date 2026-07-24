use Test;

use NotoFonts-OT; 
use NotoFonts-OT::FontPaths; 
use NotoFonts-OT::Subs; 
use NotoFonts-OT::Registry; 

my $reg = NotoFonts-OT::Registry.new;
for $reg.records -> $rec {
    my $file = $rec<filename>;
    say "file: ", $file;
    my $face = $file;
    $face ~~ s/'.' otf $//;
    say "face: '$face'";
}
say "DEBUG: early exit";
exit;


my $debug = 1;

plan 3;

my $ofil = "NotoFonts-OT-samples.pdf";

# Temp workspace so we don't clutter repo
my $tdnam = "noto-ff";
my $tmpdir = "$*TMPDIR/$tdnam";

mkdir $tmpdir unless $tmpdir.IO.d;

my $outfile = "$tmpdir/$ofil";

try { $outfile.IO.unlink if $outfile.IO.e; CATCH { } }

lives-ok {

    my $font-ref = "NotoFonts-OT";
    my @faces;
    push @faces, "NotoSerif-Regular";
    is @faces.elems, 1;
    do-pdf-language-samples $font-ref, 
         :@faces, 
         :ofile($outfile),
         :$debug;

    is $outfile.IO.r, True, "outfile $outfile exists";

}, "test the routine...";
 
my $min-size = 1000; # bytes
ok $outfile.IO.s > $min-size, "Output PDF size {$outfile.IO.s} > {$min-size}";

done-testing;

