use Test;

my @modules = [
    "NotoFonts-OT",
    "NotoFonts-OT::FontPaths",
    "NotoFonts-OT::Subs",
    "NotoFonts-OT::Vars",
];

plan @modules.elems;

for @modules -> $m {
    use-ok $m, "Module '$m' used okay";
}
