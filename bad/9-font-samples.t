use Test;

use NotoFonts-OT; 
use NotoFonts-OT::Subs; 

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
    do-pdf-language-samples $font-ref, :ofile($outfile);

    is $outfile.IO.r, True, "outfile $outfile exists";

}, "test the routine...";
 
my $min-size = 10_000; # bytes
ok $outfile.IO.s > $min-size, "Output PDF size {$outfile.IO.s} > {$min-size}";

