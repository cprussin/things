use <smooth-prim/smooth_prim.scad>

$fa = 1;
$fs = 0.4;

pm_width = 123;
pm_depth = 20;
pm_mount_depth = 20;
pm_mount_wall_width = 4;
phone_width = 166;
phone_height = 81;
phone_depth = 13;
phone_grip_post_width = 15;
phone_grip_offset = 40;
phone_grip_jaw_height = 5;
phone_grip_wall_width = 4;

module phone_grip_jaw_nub() {
     SmoothCube(
          size = [
               phone_grip_post_width,
               phone_grip_wall_width,
               phone_grip_wall_width
               ],
          smooth_rad = phone_grip_wall_width / 2
     );
}

module phone_grip_post(depth, height) {
     rotate([90, 0, 90]) {
          difference () {
               SmoothHollowCube(size = [depth, height, phone_grip_post_width], wall_width = phone_grip_wall_width);
               translate([-1, phone_grip_jaw_height, 0]) {
                    cube(size = [phone_grip_wall_width + 2, height - (2 * phone_grip_jaw_height), phone_grip_post_width]);
               }
          }
     }

     // Supports
     translate([0, phone_grip_wall_width / 2, phone_grip_jaw_height]) {
          cube(size = [phone_grip_post_width, 0.5, height - (2 * phone_grip_jaw_height)]);
     }

     translate ([0, 0, height - (phone_grip_wall_width / 2) - phone_grip_jaw_height]) {
          phone_grip_jaw_nub();
     }

     translate ([0, 0, phone_grip_jaw_height - (phone_grip_wall_width / 2)]) {
          phone_grip_jaw_nub();
     }
}

function phone_grip_width() =
     phone_width + (phone_grip_post_width * 2) - (phone_grip_offset * 2);

module phone_grip() {
     depth = phone_depth + (2 * phone_grip_wall_width);
     height = phone_height + (2 * phone_grip_wall_width);

     phone_grip_post(depth, height);
     translate ([phone_width + phone_grip_post_width - (2 * phone_grip_offset), 0, 0]) {
          phone_grip_post(depth, height);
     }
     translate([phone_grip_wall_width / 2, phone_depth + phone_grip_wall_width, (phone_height - phone_grip_wall_width) / 2]) {
          cube(size = [phone_grip_width() - (phone_grip_wall_width * 2), phone_grip_wall_width, phone_grip_post_width]);
     }
}

function pm_mount_width() = pm_width + (2 * pm_mount_wall_width);

module pm_mount() {
     width = pm_mount_width();
     depth = pm_depth + (2 * pm_mount_wall_width);
     height = pm_mount_depth + pm_mount_wall_width;

     translate([0, depth, height]) {
          rotate([180, 0, 0]) {
               SmoothHollowCube(size = [width, depth, height], wall_width = pm_mount_wall_width);
               SmoothXYCube(size = [width, depth, pm_mount_wall_width], smooth_rad = pm_mount_wall_width);
          }
     }
}

pm_mount();
translate([(pm_mount_width() - phone_grip_width()) / 2, 0, pm_mount_depth]) {
     phone_grip();
}
