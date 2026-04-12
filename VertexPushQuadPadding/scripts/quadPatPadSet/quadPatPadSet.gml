

/**
* This shader will push padding around drawn quads.
* This allows using outline (or other) effect with sprites etc. quads, 
* which normally is cropped right to the edges.
* 
* Parameters:
* {
* - padding   : Real          How many pixels quads is padded with.
* - theshold  : Real          What is considered empty pixel for outlines.
* - outline   : Array<Real>   What is outline color [ 0, 0, 0, 1 ] for black.
* - debug     : Array<Real>   What is debug color for padding [ 0, 0, 0, 0 ] to non-visible.
* - offsets   : Array<Real>   List of neighbour xy-checks for outline [ 1, 0 ] for single check.
* - count     : Real          If larger array of offsets, can get smaller slice 
* }
* 
* OBS!
* This will use "shader_enable_corner_id(true)" !
* -> This is required, otherwise effect doesn't work.
* -> Supports only quads with corner ID support (sprites etc.)
*
* Sidenote, calculating offset and getting correct information
* is pretty heavy, so sually better just add padding to 
* sprite itself while turning off automatic cropping.
*/ 
function quadPatPadSet(_config={ })
{
  // Get shader uniforms.
  static shader = shader_quadPatPad;
  static VSH_vertexPadding  = shader_get_uniform(shader, "VSH_vertexPadding");
  static FSH_colorOutline   = shader_get_uniform(shader, "FSH_colorOutline");
  static FSH_colorDebug     = shader_get_uniform(shader, "FSH_colorDebug");
  static FSH_offsets        = shader_get_uniform(shader, "FSH_offsets");
  static FSH_offsetCount    = shader_get_uniform(shader, "FSH_offsetCount");
  static FSH_threshold      = shader_get_uniform(shader, "FSH_threshold");
  
  
  // Neighbours - contains list of vec2's.
  static MAX_NEIGHBOURS = 32 * 2; // Match with shader.
  static offsetUniforms = array_create(MAX_NEIGHBOURS, 0);
  
  
  // Defaults.
  static defaultPadding       = 1; // Only allows 1 thick outline at edges.
  static defaultOffsets       = [ 1, 0, -1, 0, 0, 1, 0, -1 ]; // 4 neighbours.
  static defaultColorOutline  = [ 0, 0, 0, 1 ]; // Black outline.
  static defaultColorDebug    = [ 0, 0, 0, 0 ]; // Not visible
  static defaultThreshold     = (1.0 / 255.0);
  
  
  // Read parameters.
  var _padding      = _config[$ "padding"]    ?? defaultPadding;
  var _threshold    = _config[$ "threshold"]  ?? defaultThreshold;
  var _colorOutline = _config[$ "outline"]    ?? defaultColorOutline;
  var _colorDebug   = _config[$ "debug"]      ?? defaultColorDebug;
  var _offsets      = _config[$ "offsets"]    ?? defaultOffsets;
  var _count        = _config[$ "count"]      ?? infinity;
  
  
  // Resolve the count, and copy offsets.
  _count = floor(_count / 2) * 2;
  var _offsetCount = min(MAX_NEIGHBOURS, array_length(_offsets), _count);
  array_copy(offsetUniforms, 0, _offsets, 0, _offsetCount);
  
  
  // Update GPU settings.
  shader_enable_corner_id(true);
  shader_set(shader);
  
  
  // Vertex shader uniforms.
  shader_set_uniform_f(VSH_vertexPadding, _padding);
  
  
  // Fragment shader uniforms.
  shader_set_uniform_f_array(FSH_colorOutline,  _colorOutline);
  shader_set_uniform_f_array(FSH_colorDebug,    _colorDebug);
  shader_set_uniform_f_array(FSH_offsets,       offsetUniforms);
  
  shader_set_uniform_i(FSH_offsetCount, _offsetCount div 2);
  shader_set_uniform_f(FSH_threshold,   _threshold);
}




