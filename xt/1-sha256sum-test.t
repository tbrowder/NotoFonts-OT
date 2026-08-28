use v6.d;
use Test;

use Digest::SHA256::Native;
use NotoFonts-OT;

my IO::Path $sums-file = get-sha256-path;

ok $sums-file.f,
    "SHA256SUMS file exists";

my %expected-shas;

for $sums-file.lines -> $line is copy {
    $line .= trim;

    next unless $line.chars;
    next if $line.starts-with('#');

    my @words = $line.words;

    unless @words.elems >= 2 {
        flunk "Malformed SHA256SUMS line: '$line'";
        next;
    }

    my $sha = @words.head.lc;
    my $file = @words.tail.IO.basename;

    unless $sha ~~ /^ <[0..9a..f]> ** 64 $/ {
        flunk "Invalid SHA-256 value for '$file': '$sha'";
        next;
    }

    %expected-shas{$file} = $sha;
}

for 1..10 -> $code {
    my IO::Path $font-path = get-font-path($code);
    my $basename = $font-path.basename;

    ok $font-path.f,
        "font $code exists: $basename";

    unless %expected-shas{$basename}:exists {
        flunk "SHA256SUMS contains an entry for $basename";
        next;
    }

    pass "SHA256SUMS contains an entry for $basename";

    my $actual-sha = sha256-hex(
        $font-path.slurp(:bin)
    );

    is $actual-sha,
        %expected-shas{$basename},
        "SHA-256 matches for $basename";
}

done-testing;
