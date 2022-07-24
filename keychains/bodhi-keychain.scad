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
  translate([0.05 * size, 0.55 * size, 0]) {
    linear_extrude(height = height) {
      difference() {
        circle(5);
        circle(2);
      }
    }
  }
  translate([0, 0, 0.5 * height]) {
    letter("B");
  }
  translate([0.8 * size, 0, 0]) {
    letter("O");
  }
  translate([1.8 * size, 0, 0.5 * height]) {
    letter("D");
  }
  translate([2.7 * size, 0, 0]) {
    letter("H");
  }
  translate([3.9 * size, 0, 0.5 * height]) {
    letter("I");
  }
}
