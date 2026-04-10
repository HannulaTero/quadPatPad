/// @desc SET THE SHADER.


display_set_gui_maximise(-1, -1);
window_set_size(480 * 3, 270 * 3);
window_center();

debug = [ 0, 0, 0, 0 ];
count = infinity;


var _layerFirst = layer_create(0);
layer_script_begin(_layerFirst, function()
{
  // Cached arrays.
  static offsets = [
    -1, -1, +0, -1, +1, -1, 
    -1, +0,         +1, +0, 
    -1, +1, +0, +1, +1, +1, 
    
    -2, -2, +0, -2, +2, -2, 
    -2, +0,         +2, +0, 
    -2, +2, +0, +1, +2, +2, 
  ];
  
  static outline = [ 
    0, 0, 0, 1.0 
  ];
  
  // Apply the shader.
  quadPatPatSet({
    threshold : 0.0,
    padding : 2,
    offsets : offsets,
    outline : outline,
    debug : debug,
    count : count,
  });
});



var _layerLast = layer_create(-room_height);
layer_script_end(_layerLast, function()
{
  quadPatPatEnd();
});

