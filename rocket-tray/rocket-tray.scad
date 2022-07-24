use <smooth-prim/smooth_prim.scad>

$fa=1;
$fs=0.4;

rocket_OD = 13.3;
spacing = 28;
peg_radius = 5;
peg_height = 40;
num_rockets_x = 2;
num_rockets_y = 4;

enable_rockets = false;

module rocket() {
  import("rocket.stl");
}

module peg(rocket_color) {
  color("grey") SmoothCylinder(radius = peg_radius, height = peg_height, smooth_rad = peg_radius);
  if (enable_rockets)
    color(rocket_color)
      rocket();
}

module pegs() {
  translate([peg_radius, peg_radius, 0])
    for (i = [0 : num_rockets_x - 1])
      for (j = [0 : num_rockets_y - 1])
        translate([i * spacing, j * spacing, 0])
          peg(i < 2 ? "red" : "blue");
}

module base() {
  width = num_rockets_x * spacing + peg_radius * 2;
  depth = num_rockets_y * spacing + peg_radius * 2;

  color("grey") SmoothXYCube(size = [ width, depth, peg_radius ], smooth_rad = peg_radius);
}

module stand() {
  base();
  translate([ spacing / 2, spacing / 2, 0 ]) pegs();
}

stand();
