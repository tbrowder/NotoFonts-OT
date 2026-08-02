use Test;

my @modules = [
    "NotoFonts-OT",
    "NotoFonts-OT::Registry",
    "NotoFonts-OT::Vars",
    "NotoFonts-OT::Download",
    "NotoFonts-OT::FontPaths",

#   "NotoFonts-OT::Samples",
#   "NotoFonts-OT::Subs",
];

plan @modules.elems;

for @modules -> $m {
    use-ok $m, "Module '$m' used okay";
}
