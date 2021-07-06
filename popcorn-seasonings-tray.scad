use <smooth-prim/smooth_prim.scad>
$fa=1;
$fs=0.4;

shaker_radius = 19;
shaker_spacing = 1;
num_shakers_wide = 4;
num_shakers_deep = 2;
height = 30;
wall_width = 1.5;

block_size = 2 * (shaker_radius + wall_width + shaker_spacing);
depth = block_size * num_shakers_deep + 2 * wall_width;
width = block_size * num_shakers_wide + 2 * wall_width;

for (i = [0 : num_shakers_deep - 1]) {
  for (j = [0 : num_shakers_wide - 1]) {
    offset_depth = block_size * (i + 0.5 - (num_shakers_deep / 2));
    offset_width = block_size * (j + 0.5 - (num_shakers_wide / 2));

    translate([offset_width, offset_depth, 0]) {
      HollowCylinder(outer_rad = shaker_radius + wall_width, inner_rad = shaker_radius, height = height);
    }
  }
}

translate([-width / 2, -depth / 2, 0]) {
  SmoothHollowCube(size = [width, depth, height], wall_width = wall_width);
  SmoothXYCube(size = [width, depth, 2 * wall_width], smooth_rad = wall_width);
}
