use <smooth-prim/smooth_prim.scad>
$fa=1;
$fs=0.4;
SmoothHollowCube(size=[80, 90, 20],wall_width=2.5);
SmoothXYCube(size=[80, 90, 5], smooth_rad=2.5);
