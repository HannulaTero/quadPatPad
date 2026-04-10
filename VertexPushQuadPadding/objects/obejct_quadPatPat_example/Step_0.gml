/// @desc SET DEBUG COLOR.

debug = keyboard_check(vk_space)
  ? [ 1, 0, 0, 0.25 ]
  : [ 0, 0, 0, 0.00 ];
