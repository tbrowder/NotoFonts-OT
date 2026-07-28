use Test;

my @modules = [
    "NotoFonts-OT",
    "NotoFonts-OT::Registry",
    "NotoFonts-OT::Vars",
    "NotoFonts-OT::Download",

#   "NotoFonts-OT::Subs",
#   "NotoFonts-OT::FontPaths",
];

plan @modules.elems;

for @modules -> $m {
    use-ok $m, "Module '$m' used okay";
}
