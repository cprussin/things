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
  translate([0.2 * size, 0.7 * size, 0]) {
    linear_extrude(height = height) {
      difference() {
        circle(5);
        circle(2);
      }
    }
  }
  translate([0, 0, 0.5 * height]) {
    letter("A");
  }
  translate([size, 0, 0]) {
    letter("I");
  }
  translate([1.4 * size, 0, 0.5 * height]) {
    letter("D");
  }
  translate([2.3 * size, 0, 0]) {
    letter("E");
  }
  translate([3.2 * size, 0, 0.5 * height]) {
    letter("N");
  }
}
