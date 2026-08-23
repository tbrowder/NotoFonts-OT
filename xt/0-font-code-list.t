use v6.d;

use Test;

use NotoFonts-OT;

my $debug = 0;

my @nums;
my %pairs; # number | font name

my %fonts = get-font-paths-hash;
for %fonts.kv -> $k, $v {
    # the key is a code
    # the value is a path

    # we want the keys that are the a digits 1..10
    next unless $k.Int;
   
    my $code = $k.Int;
    say "k,v: |$code|, |$v||" if $debug;

    # we want the value as a font name
    my $fnam = $v.basename;
    $fnam ~~ s/:i '.otf' $//;
    say "k,v: |$code|, |$fnam|" if $debug;

    %pairs{$code} = $fnam;
    @nums.push: $code;
}

@nums .= sort({$^a <=> $^b});

if $debug { say $_ for @nums }

for 1..10 -> $num {
    my $fnam = %pairs{$num};
    my $n = 2; # space between columns 
    printf "%2d" ~ (" " x $n) ~ "%-10s\n", $num, $fnam;
}

done-testing;

