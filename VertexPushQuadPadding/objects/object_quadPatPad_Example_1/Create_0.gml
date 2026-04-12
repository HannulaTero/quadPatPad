/// @desc SET THE SHADER.

debug = [ 0, 0, 0, 0 ];
count = infinity;
layerFirst = layer_create(0);
layerLast = layer_create(-room_height);


// Apply the effect.
// -> As objects use "depth = -y", 
layer_script_begin(layerFirst, function()
{
  // Cached arrays.
  static offsets = [
    -1, -1, +0, -1, +1, -1, 
    -1, +0,         +1, +0, 
    -1, +1, +0, +1, +1, +1, 
    
    -2, -2, +0, -2, +2, -2, 
    -2, +0,         +2, +0, 
    -2, +2, +0, +2, +2, +2, 
  ];
  
  static outline = [ 
    0, 0, 0, 1.0 
  ];
  
  // Apply the shader.
  quadPatPadSet({
    threshold : 0.0,
    padding : 2,
    offsets : offsets,
    outline : outline,
    debug : debug,
    count : count,
  });
});



// Disable the effect.
layer_script_end(layerLast, function()
{
  quadPatPadEnd();
});

