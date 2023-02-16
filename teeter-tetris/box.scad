use <smooth-prim/smooth_prim.scad>

$fa=1;
$fs=0.4;

WITH_BOX = true;
WITH_LID = true;
WITH_PARTS = true;
SELECTED_COLOR = "ALL";
SHOW_LID_DESIGN = true;

base_width = 40.0;
base_depth = 39.999996185302734;
base_height = 11.097000122070297;
base_center_x = 1.2000007629394531;
base_center_y = -53.69999885559082;
base_center_z = 5.548500061035164;

tower_width = 150.0;
tower_depth = 52.729736328125;
tower_height = 10.0;
tower_center_x = 75.0;
tower_center_y = 29.0013427734375;
tower_center_z = 5.0;

box_wall_thickness = 6;
cutout_scale = 1.05;
finger_hole_radius = 8;
piece_box_depth = 65;
piece_box_height = 26;

base_cutout_width = base_width * cutout_scale;
base_cutout_depth = base_depth * cutout_scale;
base_cutout_height = base_height * cutout_scale;

tower_cutout_width = tower_width * cutout_scale;
tower_cutout_depth = tower_depth * cutout_scale;
tower_cutout_height = tower_height * cutout_scale;

base_and_tower_depth =
  max(base_cutout_depth, tower_cutout_depth) +
  finger_hole_radius +
  2 * box_wall_thickness;

box_depth = base_and_tower_depth + piece_box_depth + box_wall_thickness;
box_width = base_cutout_width + tower_cutout_width + 3 * box_wall_thickness;
box_height =
  max(base_cutout_height, tower_cutout_height, piece_box_height) +
  box_wall_thickness;

lid_tolerance = 1;
lid_thickness = box_wall_thickness / 3;

box_cutout_width = box_width + lid_tolerance;
box_cutout_depth = box_depth + lid_tolerance;

lid_width = box_cutout_width + 2 * lid_thickness;
lid_depth = box_cutout_depth + 2 * lid_thickness;
lid_height = box_height + lid_thickness;

module multicolor(color_) {
  if (SELECTED_COLOR == "ALL" || SELECTED_COLOR == color_) {
    color(color_) children();
  }
}

module tower() {
  x = tower_width / 2 - tower_center_x;
  y = tower_depth / 2 - tower_center_y;
  z = tower_height / 2 - tower_center_z;

  translate([tower_width, tower_depth, 0]) rotate(180)
    translate([x, y, z]) import("tower.stl");
}

module base() {
  x = base_width / 2 - base_center_x;
  y = base_depth / 2 - base_center_y;
  z = base_height / 2 - base_center_z;

  translate([x, y, z]) import("base.stl");
}

module pieces() {
  import("pieces.stl");
}

module finger_hole_cutout() {
  scale([1, 1, 1.25]) sphere(finger_hole_radius);
}

module base_cutout() {
  SmoothXYCube(
    size = [base_cutout_width, base_cutout_depth, base_cutout_height + 1],
    smooth_rad = 7
  );

  translate([base_cutout_width / 2, base_cutout_depth, base_cutout_height])
    finger_hole_cutout();
}

module tower_cutout() {
  // Add some extra height to avoid floating-point precision issues
  linear_extrude(tower_height + 1) projection()
    scale(cutout_scale) hull() tower();

  translate([tower_cutout_width / 2, tower_cutout_depth, tower_height])
    finger_hole_cutout();
}

module piece_box_cutouts() {
  piece_box_width = (box_width - 5 * box_wall_thickness) / 4;

  for (i = [0 : 3])
    translate([i * (piece_box_width + box_wall_thickness), 0, 0])
      SmoothXYCube(
                   size = [piece_box_width, piece_box_depth, piece_box_height + 1],
                   smooth_rad = box_wall_thickness
      );
}

module box() {
  base_cutout_z = box_height - base_cutout_height;
  tower_cutout_x = 2 * box_wall_thickness + base_cutout_width;
  tower_cutout_z = box_height - tower_cutout_height;
  piece_box_cutout_z = box_height - piece_box_height;

  color("darkgrey") difference() {
    SmoothXYCube(
      size = [box_width, box_depth, box_height],
      smooth_rad = box_wall_thickness
    );

    translate([box_wall_thickness, box_wall_thickness, base_cutout_z])
      base_cutout();

    translate([tower_cutout_x, box_wall_thickness, tower_cutout_z])
      tower_cutout();

    translate([box_wall_thickness, base_and_tower_depth, piece_box_cutout_z])
      piece_box_cutouts();
  }
}

module parts() {
  base_x = box_wall_thickness + (base_cutout_width - base_width) / 2;
  base_y = box_wall_thickness + (base_cutout_depth - base_depth) / 2;
  base_z = box_height - base_height * cutout_scale;

  tower_x =
    2 * box_wall_thickness + base_cutout_width +
    (tower_cutout_width - tower_width) / 2;
  tower_y = box_wall_thickness + (tower_cutout_depth - tower_depth) / 2;
  tower_z = box_height - tower_height * cutout_scale;

  color("red") {
    translate([base_x, base_y, base_z]) base();
    translate([tower_x, tower_y, tower_z]) tower();
  }
}

module lid_design() {
  translate([lid_width / 2, lid_depth - 40, lid_height - lid_thickness / 2]) {
    multicolor("blue") linear_extrude(lid_thickness / 2) {
      text(text = "Teeter Tetris", font = "Bungee", halign = "center", valign = "bottom", size = 15);
    }
    translate([tower_width / 2 - 20, tower_depth / 2 - 90, 0]) {
      multicolor("grey") linear_extrude(lid_thickness / 2) projection()
        rotate(160)
        tower();
      multicolor("red") linear_extrude(lid_thickness / 2) projection() {
        translate([-12.75, 8.75, 0]) rotate(23)
          import("pieces/piece3.stl");
        translate([-14.2, 30.4, 0]) rotate(-69.5)
        import("pieces/piece7.stl");
      }
      multicolor("green") linear_extrude(lid_thickness / 2) projection()
        translate([3, 10, 0]) rotate(-67)
        import("pieces/piece4.stl");
      multicolor("blue") linear_extrude(lid_thickness / 2) projection()
        translate([-31.5, 18.85, 0]) rotate(19)
        import("pieces/piece6.stl");
    }
  }
}

module lid() {
  multicolor("darkgrey") difference() {
    SmoothXYCube(
      size = [lid_width, lid_depth, lid_height],
      smooth_rad = box_wall_thickness
    );

    translate([lid_thickness, lid_thickness, -0.5])
      SmoothXYCube(
        size = [box_cutout_width, box_cutout_depth, box_height + 1],
        smooth_rad = box_wall_thickness
      );

    translate([0, 0, 0.1]) lid_design();
  }

  if (SHOW_LID_DESIGN) lid_design();
}

lid_offset_x = WITH_LID ? lid_thickness + lid_tolerance / 2 : 0;
lid_offset_y = WITH_LID ? lid_thickness + lid_tolerance / 2 : 0;
lid_offset_z = WITH_LID ? 0.1 : 0;

if (WITH_LID) translate([0, 0, $t * 200]) lid();
if (WITH_BOX) translate([lid_offset_x, lid_offset_y, lid_offset_z]) box();
if (WITH_PARTS) translate([lid_offset_x, lid_offset_y, lid_offset_z]) parts();
