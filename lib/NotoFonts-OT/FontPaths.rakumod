unit module NotoFonts-OT::FilePaths;

=begin pod

This module is not intended to be called by the distribution's parent
class. It is meant for use by other modules, such as C<App::FontSample>.

Exported subroutines:

=item get-font-path
=item get-loaded-font
=item list-font-names
=item list-font-codes
=item get-font-paths-hash

=end pod

use MacOS::NativeLib "*";
use PDF::Font::Loader::HarfBuzz;
use PDF::Font::Loader :load-font;

# These values are safe to precompile because they are resource names,
# not absolute installation paths.
my constant %FONT-RESOURCE = (
    t   => 'fonts/NotoSerif/NotoSerif-Regular.otf',
    tb  => 'fonts/NotoSerif/NotoSerif-Bold.otf',
    ti  => 'fonts/NotoSerif/NotoSerif-Italic.otf',
    tbi => 'fonts/NotoSerif/NotoSerif-BoldItalic.otf',

    h   => 'fonts/NotoSans/NotoSans-Regular.otf',
    hb  => 'fonts/NotoSans/NotoSans-Bold.otf',
    ho  => 'fonts/NotoSans/NotoSans-Italic.otf',
    hbo => 'fonts/NotoSans/NotoSans-BoldItalic.otf',

    c   => 'fonts/NotoSansMono/NotoSansMono-Regular.otf',
    cb  => 'fonts/NotoSansMono/NotoSansMono-Bold.otf',
);

# Every accepted code or name maps to one primary code.
my constant %FONT-ALIAS = (
    # Primary PostScript-style codes
    t   => 't',
    tb  => 'tb',
    ti  => 'ti',
    tbi => 'tbi',

    h   => 'h',
    hb  => 'hb',
    ho  => 'ho',
    hbo => 'hbo',

    c   => 'c',
    cb  => 'cb',

    # Numeric aliases
    1  => 't',
    2  => 'tb',
    3  => 'ti',
    4  => 'tbi',
    5  => 'h',
    6  => 'hb',
    7  => 'ho',
    8  => 'hbo',
    9  => 'c',
    10 => 'cb',

    # Serif aliases
    se   => 't',
    seb  => 'tb',

    to   => 'ti',
    sei  => 'ti',
    seo  => 'ti',

    tbo  => 'tbi',
    tob  => 'tbi',
    tib  => 'tbi',
    sebi => 'tbi',
    sebo => 'tbi',
    seob => 'tbi',
    seib => 'tbi',

    # Sans aliases
    sa  => 'h',
    sab => 'hb',

    hi  => 'ho',
    sai => 'ho',
    sao => 'ho',

    hbi  => 'hbo',
    hob  => 'hbo',
    hib  => 'hbo',
    sabi => 'hbo',
    sabo => 'hbo',
    saob => 'hbo',
    saib => 'hbo',

    # Monospace aliases
    m  => 'c',
    mb => 'cb',

    # Full font-name aliases
    NotoSerif-Regular    => 't',
    NotoSerif-Bold       => 'tb',
    NotoSerif-Italic     => 'ti',
    NotoSerif-BoldItalic => 'tbi',

    NotoSans-Regular    => 'h',
    NotoSans-Bold       => 'hb',
    NotoSans-Italic     => 'ho',
    NotoSans-BoldItalic => 'hbo',

    NotoSansMono-Regular => 'c',
    NotoSansMono-Bold    => 'cb',
);

sub build-font-paths(
    --> Hash
) {
    my %paths;

    for %FONT-ALIAS.kv -> $alias, $primary-code {
        my $resource-name = %FONT-RESOURCE{$primary-code};

        unless $resource-name.defined {
            die "No resource is defined for primary font code "
              ~ "'$primary-code'";
        }

        my $font-path = %?RESOURCES{$resource-name};

        unless $font-path.defined {
            die "Font resource '$resource-name' is not present in "
              ~ 'the installed distribution';
        }

        my IO::Path $path = $font-path.IO;

        unless $path.f {
            die "Font resource '$resource-name' does not resolve "
              ~ "to a file: '$path'";
        }

        %paths{$alias.Str} = $path;
    }

    return %paths;
}

sub font-paths(
    --> Hash
) {
    # Constructed only on first use and retained thereafter.
    state %font-paths = build-font-paths;

    return %font-paths;
}

sub get-font-path(
    Str:D $code
    --> IO::Path
) is export {
    my %paths := font-paths;

    unless %paths{$code}:exists {
        die "Unknown font code or name '$code'";
    }

    return %paths{$code};
}

sub get-loaded-font(
    Str:D $code
) is export {
    my IO::Path $file = get-font-path($code);

    return load-font :$file;
}

sub list-font-codes(
    Bool :$debug = False
    --> List
) is export {
    my @codes;

    for %FONT-ALIAS.keys.sort -> $code {
        @codes.push: $code;
        say $code if $debug;
    }

    return @codes.List;
}

sub list-font-names(
    Bool :$debug = False
    --> List
) is export {
    my @names;

    for %FONT-RESOURCE.values.sort -> $resource-name {
        my $name = $resource-name.IO.basename;
        $name ~~ s/\.otf$//;

        @names.push: $name;
        say $name if $debug;
    }

    return @names.List;
}

sub get-font-paths-hash(
    Bool :$debug = False
    --> Hash
) is export {
    my %paths := font-paths;

    if $debug {
        for %paths.keys.sort -> $code {
            say "$code => %paths{$code}";
        }
    }

    # Do not allow callers to alter the module's cached hash.
    return %paths.clone;
}
