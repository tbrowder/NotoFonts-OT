use MacOS::NativeLib "*";
use PDF::Font::Loader::HarfBuzz;
use PDF::Font::Loader :load-font;
use PDF::Content;
use PDF::Content::FontObj;
use PDF::Lite;
use FontConfig;

use NotoFonts-OT::Download;
use NotoFonts-OT::Registry;
use NotoFonts-OT::Vars;
#use NotoFonts-OT::FontPaths;

# Initialization

my %fonts;
my %loaded-fonts;
my %font-paths;
my Bool $initialized = False;

sub initialize(--> Nil) {
    return if $initialized;

    # Locate resources and populate %font-paths here or in lower modules
    %fonts = get-font-paths-hash;
}

=begin comment
has IO::Path $.registry-dir;
has %!fonts;
has %!docs;
has $!debug;
=end comment

sub get-ofl-path( --> IO::Path    ) { return %?RESOURCES<text/OFL.txt>.IO; }
sub get-faq-path( --> IO::Path    ) { return %?RESOURCES<text/OFL-FAQ.txt>.IO; }
sub get-sha256-path( --> IO::Path    ) { return %?RESOURCES<text/SHA256SUMS.txt>.IO; }
sub get-font-licenses-path( --> IO::Path    ) { return %?RESOURCES<text/FONT-LICENSES.rakudoc>.IO; }

=begin comment
sub list-font-names(
    %fonts,
    :$debug,
) {
    my %names;
    for %fonts.values.sort -> $name is copy {
	next if $name ~~ /raku | OFL /;
	next unless $name ~~ /\S/;
	#$name .= basename;
	
	next if %names{$name}:exists;
	%names{$name} = 1;
	say $name if $debug;
    }
    for %names.keys.sort -> $name {
	say $name if 1 or $debug;
    }
}
=end comment

sub list-font-codes(
    %fonts,
    :$debug,
    --> List
) {
    my @codes;
    #for %!fonts.keys.sort -> $code {
    for %fonts.keys.sort -> $code {
	next if $code ~~ /raku | OFL /;
	next unless $code ~~ /\S/;
	#$name .= basename;
	
	say $code if $debug;
	@codes.push: $code;
    }
    say() if $debug;
    return @codes;
}

sub get-path(
    $code,
    :%fonts,
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

sub get-font(
    $code,
    --> PDF::Content::FontObj
) {
    # given a "code", return a FontObj
    #my $font-path = %!fonts{$code} // 0;
    my $font-path = %fonts{$code} // 0;
    if $font-path.IO.f {
        return load-font(:file($font-path));
    }
    else {
        say "ERROR: Unknown font name or code '$code'";
    }
}

=begin comment

submethod TWEAK {
    %!fonts = get-font-paths-hash(:$!debug);
    %!docs  = get-docs-hash(:$!debug);
}
=end comment

sub get-docs-hash(:$debug --> Hash) is export {
    my $faq          = %?RESOURCES<text/OFL-FAQ.txt>.IO;
    my $font-license = %?RESOURCES<text/OFL.txt>.IO;
    my $doc          = %?RESOURCES<text/FONT-LICENSES.rakudoc>.IO;
    my $sha256sums   = %?RESOURCES<text/SHA256SUMS.txt>.IO;

    my %docs;
    %docs<faq>     = $faq;
    %docs<license> = $font-license;
    %docs<doc>     = $doc;
    %docs<sha256>  = $sha256sums;

    return %docs;
}

sub get-font-paths-hash(:$debug --> Hash) is export {
    # from the Google Noto fonts collection
    # only OpenType fonts wanted

    # Use codes reflecting the Adobe parentage of its class PostScript fonts 
    # I grew up with in the PS days: # # Times-Roman family and font files
    my $fft   = %?RESOURCES<fonts/NotoSerif/NotoSerif-Regular.otf>.IO;
    my $fftb  = %?RESOURCES<fonts/NotoSerif/NotoSerif-Bold.otf>.IO;
    my $ffti  = %?RESOURCES<fonts/NotoSerif/NotoSerif-Italic.otf>.IO;
    my $fftbi = %?RESOURCES<fonts/NotoSerif/NotoSerif-BoldItalic.otf>.IO;

    # Helvetica family and font files
    my $ffh   = %?RESOURCES<fonts/NotoSans/NotoSans-Regular.otf>.IO;
    my $ffhb  = %?RESOURCES<fonts/NotoSans/NotoSans-Bold.otf>.IO;
    my $ffho  = %?RESOURCES<fonts/NotoSans/NotoSans-Italic.otf>.IO;
    my $ffhbo = %?RESOURCES<fonts/NotoSans/NotoSans-BoldItalic.otf>.IO;

    # Courier family and font files
    my $ffc   = %?RESOURCES<fonts/NotoSansMono/NotoSansMono-Regular.otf>.IO;
    my $ffcb  = %?RESOURCES<fonts/NotoSansMono/NotoSansMono-Bold.otf>.IO;

    # no Noto Sans equivalent to itlaic version

    # create a font hash with font code as key and its font file
    # name as value 
    my %fonts;
    # get paths, don't load

    # Times-Roman
    %fonts<t>   = $fft;   # deb 12, :subset;
    %fonts<tb>  = $fftb;  # deb 12, :subset;
    %fonts<ti>  = $ffti;  # deb 12, :subset;
    %fonts<tbi> = $fftbi; # deb 12, :subset;

    # Helvetica
    %fonts<h>   = $ffh;   # deb 12, :subset;
    %fonts<hb>  = $ffhb;  # deb 12, :subset;
    %fonts<ho>  = $ffho;  # deb 12, :subset;
    %fonts<hbo> = $ffhbo; # deb 12, :subset;

    # Courier
    %fonts<c>   = $ffc;   # deb 12, :subset;
    %fonts<cb>  = $ffcb;  # deb 12, :subset;
# total 10 (10)

    # "aliases" for the real names
    %fonts<se>   = %fonts<t>;
    %fonts<seb>  = %fonts<tb>;
    %fonts<sei>  = %fonts<ti>;
    %fonts<sebi> = %fonts<tbi>;

    %fonts<sa>   = %fonts<h>;
    %fonts<sab>  = %fonts<hb>;
    %fonts<sao>  = %fonts<ho>;
    %fonts<sabo> = %fonts<hbo>;

    %fonts<m>    = %fonts<c>;
    %fonts<mb>   = %fonts<cb>;
# total 10 (20)

    # TODO: put ALL of the aliases here
    #       ...
    # add some extra keys called "aliases" # Time-Roman/NotoSerif
    %fonts<se>   = %fonts<t>; # "NotoSerif-Regular";     # 1
    %fonts{1}    = %fonts<t>; # "NotoSerif-Regular";     # 1

    %fonts<seb>  = %fonts<tb>; # "NotoSerif-Bold";       # 2
    %fonts{2}    = %fonts<tb>; # "NotoSerif-Bold";       # 2

    %fonts<to>   = %fonts<ti>; # "NotoSerif-Italic";     # 3
    %fonts{3}    = %fonts<ti>; # "NotoSerif-Italic";     # 3
    %fonts<seo>  = %fonts<ti>; # "NotoSerif-Italic";
    %fonts<sei>  = %fonts<ti>; # "NotoSerif-Italic";

    %fonts<tbo>  = %fonts<tbi>; #"NotoSerif-BoldItalic"; # 4
    %fonts{4}    = %fonts<tbi>; #"NotoSerif-BoldItalic"; # 4
    %fonts<tob>  = %fonts<tbi>; #"NotoSerif-BoldItalic";
    %fonts<tib>  = %fonts<tbi>; #"NotoSerif-BoldItalic";
    %fonts<sebi> = %fonts<tbi>; #"NotoSerif-BoldItalic";
    %fonts<sebo> = %fonts<tbi>; #"NotoSerif-BoldItalic"; #;
    %fonts<seob> = %fonts<tbi>; #"NotoSerif-BoldItalic";
    %fonts<seib> = %fonts<tbi>; #"NotoSerif-BoldItalic";
# total 16 (36)

    # Helvetica/NotoSans
    %fonts<sa>   = %fonts<h>; #"NotoSans-Regular";      # 5
    %fonts{5}    = %fonts<h>; #"NotoSans-Regular";      # 5

    %fonts<sab>  = %fonts<hb>; #"NotoSans-Bold";        # 6
    %fonts{6}    = %fonts<hb>; #"NotoSans-Bold";        # 6

    %fonts<hi>   = %fonts<ho>; #"NotoSans-Italic";     # 7
    %fonts{7}    = %fonts<ho>; #"NotoSans-Italic";     # 7
    %fonts<sai>  = %fonts<ho>; #"NotoSans-Italic";
    %fonts<sao>  = %fonts<ho>; #"NotoSans-Italic";

    %fonts<hbi>  = %fonts<hbo>; #"NotoSans-BoldItalic"; # 8
    %fonts{8}    = %fonts<hbo>; #"NotoSans-BoldItalic"; # 8
    %fonts<hob>  = %fonts<hbo>; #"NotoSans-BoldItalic";
    %fonts<hib>  = %fonts<hbo>; #"NotoSans-BoldItalic";
    %fonts<sabi> = %fonts<hbo>; #"NotoSans-BoldItalic";
    %fonts<sabo> = %fonts<hbo>; #"NotoSans-BoldItalic";
    %fonts<saob> = %fonts<hbo>; #"NotoSans-BoldItalic";
    %fonts<saib> = %fonts<hbo>; #"NotoSans-BoldItalic";
# total 16 (52)

    # Courier/NotoSansMono
    %fonts<m>   = %fonts<c>;  #"NotoSansMono-Regular";   # 9
    %fonts{9}   = %fonts<c>;  #"NotoSansMono-Regular";   # 9
    %fonts<mb>  = %fonts<cb>; #"NotoSansMono-Bold";      # 10
    %fonts{10}  = %fonts<cb>; #"NotoSansMono-Bold";      # 10
# total 4 (46)

    # now add the actual names to the hash
    # These are the fonts from Google Noto Font
    #   with their primary codes (from their Adobe heritage)
    %fonts<NotoSerif-Regular>    = %fonts<t>;                              # 1
    %fonts<NotoSerif-Bold>       = %fonts<tb>;                             # 2
    %fonts<NotoSerif-Italic>     = %fonts<ti>;  # also to                  # 3
    %fonts<NotoSerif-BoldItalic> = %fonts<tb>;  # also tbo, tob, tib       # 4
    %fonts<NotoSans-Regular>     = %fonts<h>;                              # 5
    %fonts<NotoSans-Bold>        = %fonts<hb>;                             # 6
    %fonts<NotoSans-Italic>      = %fonts<ho>;  # also hi                  # 7
    %fonts<NotoSans-BoldItalic>  = %fonts<hbo>; # also hbi, hob, hib       # 8
    %fonts<NotoSansMono-Regular> = %fonts<c>;                              # 9
    %fonts<NotoSansMono-Bold>    = %fonts<cb>;                             # 10
# total 10 (56)

    # the final hash:
    return %fonts; # hash of font file paths
}
