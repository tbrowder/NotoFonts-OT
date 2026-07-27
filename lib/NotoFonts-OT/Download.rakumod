use v6.d;

unit module NotoFonts-OT::Download;

use NotoFonts-OT::Registry;

my constant $BASE-URL =
    'https://notofonts.github.io/latin-greek-cyrillic/fonts';

my NotoFonts-OT::Registry $REGISTRY = NotoFonts-OT::Registry.new;

sub font-url(Str:D $family, Str:D $face = 'regular' --> Str:D) is export {
    my $directory = $REGISTRY.family-directory($family);
    my $filename  = $REGISTRY.filename($family, $face);

    return "$BASE-URL/$directory/unhinted/otf/$filename";
}

sub curl-program(--> Str:D) {
    my $proc = run 'curl', '--version', :out, :err;
    return 'curl' if $proc.exitcode == 0;

    die "The 'curl' executable is required to download Noto fonts.";
}

sub download-font(
    Str:D $family,
    Str:D $face = 'regular',
    IO::Path:D :$directory = 'fonts'.IO,
    Bool:D :$force = False,
    Bool:D :$verbose = True,
    --> IO::Path:D
) is export {
    my $family-key = $REGISTRY.normalize-family($family);
    my $family-dir = $directory.add($REGISTRY.family-directory($family-key));
    my $filename   = $REGISTRY.filename($family-key, $face);
    my $output     = $family-dir.add($filename);
    my $temporary  = $family-dir.add("$filename.part");
    my $url        = font-url($family-key, $face);

    $family-dir.mkdir(:parents);

    if $output.e and $output.s > 0 and not $force {
        my $name = $output.basename;
        #say "Already present: $output" if $verbose;
        say "Already present: $name" if $verbose;
        return $output;
    }

    $temporary.unlink if $temporary.e;
    say "Downloading: $filename" if $verbose;

    my $curl = curl-program();
    my $proc = run $curl,
        '--fail',
        '--location',
        '--retry', '3',
        '--retry-delay', '2',
        '--show-error',
        '--output', $temporary.Str,
        $url;

    unless $proc.exitcode == 0 {
        $temporary.unlink if $temporary.e;
        die "Unable to download $url";
    }

    unless $temporary.e and $temporary.s > 0 {
        $temporary.unlink if $temporary.e;
        die "The downloaded file is empty: $filename";
    }

    $temporary.rename($output);
    return $output;
}

sub download-default-fonts(
    IO::Path:D :$directory = 'fonts'.IO,
    Bool:D :$force = False,
    Bool:D :$verbose = True,
    --> List:D
) is export {
    my @downloaded;

    for $REGISTRY.records -> %record {
        @downloaded.push: download-font(
            %record<family>,
            %record<face>,
            :$directory,
            :$force,
            :$verbose,
        );
    }

    return @downloaded.List;
}
