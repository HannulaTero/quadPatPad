/// @desc DRAW THINGS.
  

// If you just single-pixel outline,
// then you don't need to add any parameters to quadPatPad.
quadPatPadSet();
{
  // Set initials.
  var _len    = 128;
  var _count  = sprite_get_number(sprite_index);
  var _start  = (current_time * 0.03);
  var _xs     = (room_width   * 0.50);
  var _ys     = (room_height  * 0.50);
  
  // Draw circle of thngs.
  for(var i = 0; i < _count; i++)
  {
    var _rate = (i / _count);
    var _dir  = (_start + _rate * 360);
    var _x    = _xs + lengthdir_x(_len * 1.0, _dir);
    var _y    = _ys + lengthdir_y(_len * 0.5, _dir);
    draw_sprite(sprite_index, i, _x, _y);
  }
}
quadPatPadEnd();