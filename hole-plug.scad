use <smooth-prim/smooth_prim.scad>

$fa = 1;
$fs = 0.1;

cover_diameter = 8;
cover_height = 1;
plug_diameter = 2.8;
plug_height = 4;
smooth_rad = 0.4;

SmoothCylinder(radius = cover_diameter / 2, height = cover_height, smooth_rad = smooth_rad);
translate([0, 0, smooth_rad]) {
  SmoothCylinder(radius = plug_diameter / 2, height = plug_height + smooth_rad, smooth_rad = smooth_rad);
}
