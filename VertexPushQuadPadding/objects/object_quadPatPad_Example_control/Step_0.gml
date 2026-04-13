/// @desc CHANGE EXAMPLE.

if (keyboard_check_pressed(vk_anykey) == true)
{
  switch(keyboard_key)
  {
    case ord("1") : room_goto(room_quadPatPad_Example_1); break;
    case ord("2") : room_goto(room_quadPatPad_Example_2); break;
    case ord("3") : room_goto(room_quadPatPad_Example_3); break;
    case ord("4") : room_goto(room_quadPatPad_Example_4); break;
    case ord("5") : room_goto(room_quadPatPad_Example_5); break;
    case ord("6") : room_goto(room_quadPatPad_Example_6); break;
  }
}