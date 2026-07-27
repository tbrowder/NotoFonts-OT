use v6.d;

unit class NotoFonts-OT::Registry;

my constant %FONT-DATA = (
    'serif' => {
        display-name => 'Noto Serif',
        directory    => 'NotoSerif',
        scripts      => <Latin Greek Cyrillic>,
        faces        => {
            regular     => 'NotoSerif-Regular.otf',
            bold        => 'NotoSerif-Bold.otf',
            italic      => 'NotoSerif-Italic.otf',
            bold-italic => 'NotoSerif-BoldItalic.otf',
        },
    },
    'sans' => {
        display-name => 'Noto Sans',
        directory    => 'NotoSans',
        scripts      => <Latin Greek Cyrillic>,
        faces        => {
            regular     => 'NotoSans-Regular.otf',
            bold        => 'NotoSans-Bold.otf',
            italic      => 'NotoSans-Italic.otf',
            bold-italic => 'NotoSans-BoldItalic.otf',
        },
    },
    'mono' => {
        display-name => 'Noto Sans Mono',
        directory    => 'NotoSansMono',
        scripts      => <Latin Greek Cyrillic>,
        faces        => {
            regular => 'NotoSansMono-Regular.otf',
            bold    => 'NotoSansMono-Bold.otf',
        },
    },
);

method normalize-family(Str:D $family --> Str:D) {
    my $name = $family.lc.trim;

    given $name {
        when 'serif' | 'noto serif' | 'times' {
            return 'serif';
        }
        when 'sans' | 'noto sans' | 'helvetica' {
            return 'sans';
        }
        when 'mono' | 'noto sans mono' | 'courier' {
            return 'mono';
        }
        default {
            die "Unknown Noto family '$family'. Expected serif, sans, or mono.";
        }
    }
}

method normalize-face(Str:D $face --> Str:D) {
    my $name = $face.lc.trim.subst('_', '-', :g).subst(' ', '-', :g);

    given $name {
        when 'regular' | 'roman' | 'normal' {
            return 'regular';
        }
        when 'bold' {
            return 'bold';
        }
        when 'italic' | 'oblique' {
            return 'italic';
        }
        when 'bolditalic' | 'bold-italic' | 'boldoblique' | 'bold-oblique' {
            return 'bold-italic';
        }
        default {
            die "Unknown font face '$face'.";
        }
    }
}

method families(--> List:D) {
    return %FONT-DATA.keys.sort.List;
}

method faces(Str:D $family --> List:D) {
    my $key = self.normalize-family($family);
    return %FONT-DATA{$key}<faces>.keys.sort.List;
}

method display-name(Str:D $family --> Str:D) {
    my $key = self.normalize-family($family);
    return %FONT-DATA{$key}<display-name>;
}

method family-directory(Str:D $family --> Str:D) {
    my $key = self.normalize-family($family);
    return %FONT-DATA{$key}<directory>;
}

method scripts(Str:D $family --> List:D) {
    my $key = self.normalize-family($family);
    return %FONT-DATA{$key}<scripts>.List;
}

method filename(
    Str:D $family,
    Str:D $face = 'regular',
    --> Str:D
) {
    my $family-key = self.normalize-family($family);
    my $face-key   = self.normalize-face($face);
    my %faces      = %FONT-DATA{$family-key}<faces>;

    unless %faces{$face-key}:exists {
        my $name = %FONT-DATA{$family-key}<display-name>;
        die "$name has no native $face-key OTF face.";
    }

    return %faces{$face-key};
}

method records(
    --> List:D
) {
    my @records;

    for self.families -> $family {
        for self.faces($family) -> $face {
            @records.push: {
                family       => $family,
                display-name => self.display-name($family),
                directory    => self.family-directory($family),
                scripts      => self.scripts($family),
                face         => $face,
                filename     => self.filename($family, $face),
            };
        }
    }

    return @records.List;
}
