/// @desc SET DEBUG COLOR and COUNT

debug = keyboard_check(vk_space)
  ? [ 1, 0, 0, 0.25 ]
  : [ 0, 0, 0, 0.00 ];

if (keyboard_check_pressed(vk_enter) == true)
{
  count = (count == 0) ? infinity : 0;
}