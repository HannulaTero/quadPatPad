/// @desc MOVE.

x += 2 * (
  keyboard_check(vk_right) - 
  keyboard_check(vk_left)
);

y += 1 * (
  keyboard_check(vk_down) - 
  keyboard_check(vk_up)
);