$fa=1;
$fs=0.4;
font = "Inknut Antiqua:weight=900";
size = 18;
height = 5;

module letter(character, x_offset, y_offset) {
  translate([size * x_offset, 0, y_offset ? 0.5 * height : 0])
    linear_extrude(height = height)
    text(character, font = font, size = size);
}

module nametag(characters, ring_offset) {
  translate([ring_offset[0] * size, ring_offset[1] * size, 0])
    linear_extrude(height = height)
    difference() {
      circle(5);
      circle(2);
    }
  for (character_index = [0: len(characters) - 1]) {
    letter(characters[character_index][0], characters[character_index][1], character_index % 2 == 0);
  };
}
