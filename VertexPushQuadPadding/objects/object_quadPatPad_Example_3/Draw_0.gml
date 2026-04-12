/// @desc DRAW THINGS.
  
var _padding = dsin(current_time * 0.1) * 12 + 6;


quadPatPadSet({
  debug   : [ 1.0, 0.0, 0.0, 0.25 ],
  padding : _padding,
  offsets : offsets,
});
{
  // Set initials.
  var _len    = 128;
  var _count  = array_length(sprites);
  var _start  = (current_time * 0.003);
  var _xs     = (room_width   * 0.50);
  var _ys     = (room_height  * 0.50);
  
  // Draw circle of thngs.
  for(var i = 0; i < _count; i++)
  {
    var _rate = (i / _count);
    var _dir  = (_start + _rate * 360);
    var _x    = _xs + lengthdir_x(_len * 1.0, _dir);
    var _y    = _ys + lengthdir_y(_len * 0.5, _dir);
    draw_sprite(sprites[i], i + image_index, _x, _y);
  }
}
quadPatPadEnd();