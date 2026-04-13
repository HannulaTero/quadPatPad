/// @desc PARTICLE SYSTEM.

self.parts = part_system_create(parts_quadPatPad_Example_5);
part_system_automatic_draw(self.parts, false);
part_system_position(
  self.parts, 
  room_width * 0.5,
  room_height * 0.5
);


offsets = [
  -1, -1, +0, -1, +1, -1, 
  -1, +0,         +1, +0, 
  -1, +1, +0, +1, +1, +1, 
    
  -2, -2, +0, -2, +2, -2, 
  -2, +0,         +2, +0, 
  -2, +2, +0, +2, +2, +2
];