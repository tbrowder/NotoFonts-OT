[![Actions Status](https://github.com/tbrowder/NotoFonts-OT/actions/workflows/linux.yml/badge.svg)](https://github.com/tbrowder/NotoFonts-OT/actions) [![Actions Status](https://github.com/tbrowder/NotoFonts-OT/actions/workflows/macos.yml/badge.svg)](https://github.com/tbrowder/NotoFonts-OT/actions) [![Actions Status](https://github.com/tbrowder/NotoFonts-OT/actions/workflows/windows.yml/badge.svg)](https://github.com/tbrowder/NotoFonts-OT/actions)

NAME
====

**NotoFonts-OT** - Provides an embedded collection of 10 of Google's Noto OpenType fonts for use in Raku PDF creation.

The 10 fonts closely match 10 of the original Adobe Type 1 fonts but in OTF format, and thousands of glyphs instead of only 256.

Tables 1 and 2 below list several ways to refer to the desired font and get it in one of two forms: a PDF font object or a font path to its location.

There also two ways of accessing the fonts: (1) through a class object or (2) through an exported subroutine. Both ways are illustrated below.

Note that there are many more fonts available, and more weight variations of the 10 fonts may be added here later. Please file an issue if you are interested.

SYNOPSIS
========

```raku
use Test;
use PDF::Font::Loader::HarfBuzz;
use PDF::Font::Loader :load-font;
use PDF::Content;
use PDF::Content::FontObj;
use PDF::Lite;

use NotoFonts-OT;

# Use the provided class to create individual font objects
# of the desired font face:
my $nf = NotoFonts-OT.new;

# Now the $nf object can provide the desired loaded fonts
# using C<$nf.get-font: X> where X is any of the code
# references in Tables 1 and 2 below.

# Select the Noto font 'NotoSerif-Regular' to be loaded
# as a PDF font object to be used to print text on a PDF page.
# Use a code reference from Table 1:
my $font = $nf.get-font: 1;
isa-ok $font, PDF::Content::FontObj;
# OUTPUT:
ok 1 - The object is-a 'PDF::Content::FontObj'
1..1
```

That font object, `$font`, should be able to be used by all the Raku PDF modules requiring a font object. File an issue if you find a problem.

DESCRIPTION
===========

The following tables show the font family name, weight, and slant of the 10 fonts approximating the original Adobe Type 1 fonts. The desired font can be selected by using the appropriate Name, Code, Code2, or Reference Number as the input to class method `get-font` which returns a PDF font object.

One can also get the font path by using class method `get-path`.

Note the names and codes are not case sensitive.

Table 1
-------

<table class="pod-table">
<caption>The Noto Fonts Collection</caption>
<thead><tr>
<th>Noto Font Name</th> <th>Code</th> <th>Code2</th> <th>Reference No.</th>
</tr></thead>
<tbody>
<tr> <td>NotoSerif-Regular</td> <td>se</td> <td>t</td> <td>1</td> </tr> <tr> <td>NotoSerif-Bold</td> <td>seb</td> <td>tb</td> <td>2</td> </tr> <tr> <td>NotoSerif-Italic</td> <td>sei</td> <td>ti</td> <td>3</td> </tr> <tr> <td>NotoSerif-BoldItalic</td> <td>sebi</td> <td>tbi</td> <td>4</td> </tr> <tr> <td>NotoSans-Regular</td> <td>sa</td> <td>h</td> <td>5</td> </tr> <tr> <td>NotoSans-Bold</td> <td>sab</td> <td>hb</td> <td>6</td> </tr> <tr> <td>NotoSans-Italic</td> <td>sai</td> <td>ho</td> <td>7</td> </tr> <tr> <td>NotoSans-BoldItalic</td> <td>sabi</td> <td>hbo</td> <td>8</td> </tr> <tr> <td>NotoSansMono-Regular</td> <td>m</td> <td>c</td> <td>9</td> </tr> <tr> <td>NotoSansMono-Bold</td> <td>mb</td> <td>cb</td> <td>10</td> </tr>
</tbody>
</table>

Table 2
-------

<table class="pod-table">
<caption>The Equivalent Adobe Type 1 Fonts</caption>
<thead><tr>
<th>Adobe Type 1 Name</th> <th>Code</th> <th>Code2</th> <th>Reference No.</th>
</tr></thead>
<tbody>
<tr> <td>Times</td> <td>se</td> <td>t</td> <td>1</td> </tr> <tr> <td>Times-Bold</td> <td>seb</td> <td>tb</td> <td>2</td> </tr> <tr> <td>Times-Italic</td> <td>sei</td> <td>ti</td> <td>3</td> </tr> <tr> <td>Times-BoldItalic</td> <td>sebi</td> <td>tbi</td> <td>4</td> </tr> <tr> <td>Helvetica</td> <td>sa</td> <td>h</td> <td>5</td> </tr> <tr> <td>Helvetica-Bold</td> <td>sab</td> <td>hb</td> <td>6</td> </tr> <tr> <td>Helvetica-Oblique</td> <td>sai</td> <td>ho</td> <td>7</td> </tr> <tr> <td>Helvetica-BoldOblique</td> <td>sabi</td> <td>hbo</td> <td>8</td> </tr> <tr> <td>Courier</td> <td>m</td> <td>c</td> <td>9</td> </tr> <tr> <td>Courier-Bold</td> <td>mb</td> <td>cb</td> <td>10</td> </tr>
</tbody>
</table>

Alternative use by subroutine
-----------------------------

The font or font path can also be obtained with a subroutine if need be. To do that you must only use one child module alone: `NotoFonts-OT::FontPaths`.

AUTHOR
======

Tom Browder <tbrowder@acm.org>

COPYRIGHT AND LICENSE
=====================

© 2026 Tom Browder

This library is free software; you may redistribute it or modify it under the Artistic License 2.0.

