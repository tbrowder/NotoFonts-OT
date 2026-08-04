unit module NotoFonts-OT::FontPathsOld;
=finish

sub get-path(
    $code	
    --> IO::Path
) {
    # given a "code", return a font path
    my $font-path = %fonts{$code} // 0;
    if $font-path.IO.f {
        return $font-path;
    }
    else {
        say "ERROR: Unknown font code '$code'";
    }
}

