$fa=1;
$fs=0.4;
font = "Inknut Antiqua:weight=900";
size = 18;
height = 5;

module letter(character) {
  linear_extrude(height = height) {
    text(character, font = font, size = size);
  }
}

color("blue") {
  translate([0.1 * size, 0.5 * size, 0]) {
    linear_extrude(height = height) {
      difference() {
        circle(5);
        circle(2);
      }
    }
  }
  translate([0, 0, 0.5 * height]) {
    letter("R");
  }
  translate([size, 0, 0]) {
    letter("E");
  }
  translate([1.9 * size, 0, 0.5 * height]) {
    letter("E");
  }
  translate([2.7 * size, 0, 0]) {
    letter("C");
  }
  translate([3.6 * size, 0, 0.5 * height]) {
    letter("E");
  }
}
