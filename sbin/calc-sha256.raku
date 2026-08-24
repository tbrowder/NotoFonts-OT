#!/usr/bin/env raku

use File::Find;
my $dir = "../resources/fonts/";

my @fils = find :$dir, :type<file>, :name(/'.' otf/);

for @fils ->  $f {
    my $proc = run "sha256sum", $f, :out;
    my $res = $proc.out.get; # shasum filename
    my @w = $res.words;
    my $sha = @w.head;
    my $fil = @w.tail.IO.basename;
    say "$sha  $fil";
}

