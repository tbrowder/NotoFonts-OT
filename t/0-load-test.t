use Test;

my @modules = [
    "NotoFonts-OT",
    "NotoFonts-OT::Registry",
    "NotoFonts-OT::Vars",
    "NotoFonts-OT::Download",
];

plan @modules.elems;

for @modules -> $m {
    use-ok $m, "Module '$m' used okay";
}
