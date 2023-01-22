use <smooth-prim/smooth_prim.scad>

$fa = 1;
$fs = 0.2;

holeSize = 17;
holeDepth = 90;
mountLength = 57;
mountDepth = 5;

translate([0, 0, mountDepth])
  cylinder(holeDepth, holeSize / 2, holeSize / 2);
translate([-(mountLength / 2), -(mountLength / 2), 0])
  SmoothXYCube(size = [mountLength, mountLength, mountDepth], smooth_rad = 10);
