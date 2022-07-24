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
    letter("K");
  }
  translate([0.1 * size, 0, 0.5 * height]) {
    letter("K");
  }
  translate([size, 0, 0]) {
    letter("A");
  }
  translate([1.8 * size, 0, 0.5 * height]) {
    letter("T");
  }
  translate([2.6 * size, 0, 0]) {
    letter("Y");
  }
}
