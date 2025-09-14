use <./nametag.scad>

nametag(
  // selected_color = "red",
  ring_offset = [0.05, 0.55],
  ring_color = "blue",
  characters = [
    ["B", 0, "red"],
    ["O", 0.8, "yellow"],
    ["D", 1.8, "green"],
    ["H", 2.7, "blue"],
    ["I", 3.9, "purple"]
  ]
);
