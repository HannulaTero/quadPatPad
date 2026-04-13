/// @desc DRAW THINGS.
  
var _padding = dsin(current_time * 0.05) * 16 + 10;


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
  

  // Draw text.
  var _ord = 32 + (floor(current_time / 500) mod 96);
  draw_set_font(font_quadPatPad_big);
  draw_set_halign(fa_center);
  draw_set_valign(fa_middle);
  draw_text_transformed(_xs, _ys, chr(_ord), 1, 1, 0);
}
quadPatPadEnd();