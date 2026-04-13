/// @desc DRAW.

var _padding = 5 + dsin(current_time * 0.1) * 12;


quadPatPadSet({
  debug   : [ 1, 0, 0, 0.25],
  padding : _padding,
  offsets : offsets,
});
{
  part_system_drawit(self.parts);
}
quadPatPadEnd();