[![Actions Status](https://github.com/tbrowder/NotoFonts-OT/actions/workflows/linux.yml/badge.svg)](https://github.com/tbrowder/NotoFonts-OT/actions) [![Actions Status](https://github.com/tbrowder/NotoFonts-OT/actions/workflows/macos.yml/badge.svg)](https://github.com/tbrowder/NotoFonts-OT/actions) [![Actions Status](https://github.com/tbrowder/NotoFonts-OT/actions/workflows/windows.yml/badge.svg)](https://github.com/tbrowder/NotoFonts-OT/actions)

NAME
====

**NotoFonts-OT** - Provides a collection of Google's Noto OpenType fonts for use in Raku PDF creation

In order to use the fonts, they must be downloaded by the user or by the system administrator to a location defined in environment variable `NOTO_FONTS_DIR`. In directory `./sbin` is a bash script to download the 10 fonts that are the equivalent of the original Adobe fonts.

Note that there are many more fonts available and more weight variations may be added later.

SYNOPSIS
========

```raku
use Test;
use PDF::Content;
use NotoFonts-OT;

# Use the provided class to create individual font objects
# of the desired font face:
my $nf = NotoFonts-OT.new;

# Now the $nf object can provide the desired loaded fonts.

# Select the Noto font 'NotoSerif-Regular' to be loaded
# as a PDF font object to be used to print text on a PDF page:
my $font = $nf.get-font: "Serif";
isa-ok $font, PDF::Content::FontObj;
# OUTPUT:
ok 1 - The object is-a 'PDF::Content::FontObj'
1..1
```

DESCRIPTION
===========

**NotoFonts-OT** is a package that p

Table 1
-------

<table class="pod-table">
<caption>The Noto Fonts Collection</caption>
<thead><tr>
<th>Noto Font</th> <th>Code</th> <th>Code2</th> <th>Reference No.</th>
</tr></thead>
<tbody>
<tr> <td>Noto Serif Regular</td> <td>se</td> <td>t</td> <td>1</td> </tr> <tr> <td>Noto Serif Bold</td> <td>seb</td> <td>tb</td> <td>2</td> </tr> <tr> <td>Noto Serif Italic</td> <td>sei</td> <td>ti</td> <td>3</td> </tr> <tr> <td>Noto Serif Bold Italic</td> <td>sebi</td> <td>tbi</td> <td>4</td> </tr> <tr> <td>Noto Sans Regular</td> <td>sa</td> <td>h</td> <td>5</td> </tr> <tr> <td>Noto Sans Bold</td> <td>sab</td> <td>hb</td> <td>6</td> </tr> <tr> <td>Noto Sans Italic</td> <td>sai</td> <td>ho</td> <td>7</td> </tr> <tr> <td>Noto Sans Bold Italic</td> <td>sabi</td> <td>hbo</td> <td>8</td> </tr> <tr> <td>Noto Sans Mono Regular</td> <td>m</td> <td>c</td> <td>9</td> </tr> <tr> <td>Noto Sans Mono Bold</td> <td>mb</td> <td>cb</td> <td>10</td> </tr>
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
<tr> <td>Times</td> <td>se</td> <td>t</td> <td>1</td> </tr> <tr> <td>Times Bold</td> <td>seb</td> <td>tb</td> <td>2</td> </tr> <tr> <td>Times Italic</td> <td>sei</td> <td>ti</td> <td>3</td> </tr> <tr> <td>Times Bold Italic</td> <td>sebi</td> <td>tbi</td> <td>4</td> </tr> <tr> <td>Helvetica</td> <td>sa</td> <td>h</td> <td>5</td> </tr> <tr> <td>Helvetica Bold</td> <td>sab</td> <td>hb</td> <td>6</td> </tr> <tr> <td>Helvetica Oblique</td> <td>sai</td> <td>ho</td> <td>7</td> </tr> <tr> <td>Helvetica Bold Oblique</td> <td>sabi</td> <td>hbo</td> <td>8</td> </tr> <tr> <td>Courier</td> <td>m</td> <td>c</td> <td>9</td> </tr> <tr> <td>Courier Bold</td> <td>mb</td> <td>cb</td> <td>10</td> </tr>
</tbody>
</table>

AUTHOR
======

Tom Browder <tbrowder@acm.org>

COPYRIGHT AND LICENSE
=====================

© 2026 Tom Browder

This library is free software; you may redistribute it or modify it under the Artistic License 2.0.

