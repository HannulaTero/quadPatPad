/// @desc CHANGE PADDING ETC.


image_angle += (
  real(keyboard_check(vk_left)) - 
  real(keyboard_check(vk_right))
);

padding += 0.2 * (
  real(keyboard_check(vk_up)) - 
  real(keyboard_check(vk_down))
);