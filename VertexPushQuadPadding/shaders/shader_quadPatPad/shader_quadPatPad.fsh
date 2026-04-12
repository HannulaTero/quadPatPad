//==========================================================
//
#region INFORMATION.
/*
  
  Shader allows checking neighbours at arbitrary positions,
  given by uniform array. But up to MAX_NEIGHBOURS amount.
  
  If the position is empty space, and has neigbour,
  then it is considered outline.
  
  The debug color is added to padding area,
  this can be just empty color to have no visual effect.
  
*/
#endregion
// 
//==========================================================
//
#region DECLARE: VARYINGS.


varying vec2 vCoord;
varying vec4 vColor;
varying vec2 vCorner;
varying vec2 vPositionOriginal;
varying vec2 vPositionModified;


#endregion
// 
//==========================================================
//
#region DECLARE: UNIFORMS.


#define MAX_NEIGHBOURS 32 // Match with GML function.

uniform vec4  FSH_colorOutline;
uniform vec4  FSH_colorDebug;
uniform float FSH_threshold;
uniform vec2  FSH_offsets[MAX_NEIGHBOURS];
uniform int   FSH_offsetCount;


#endregion
// 
//==========================================================
//
#region DECLARE: HELPER METHODS.


/**
* Find out what is extended area, the padding.
* -> Corner values should always be 0 to 1. 
* -> If it's outside, then pixel is inside padding.
*/
bool IsPadding(vec2 corner)
{
  return (
    (corner.x < 0.0) || (corner.x > 1.0) || 
    (corner.y < 0.0) || (corner.y > 1.0)
  );
}


/**
* Returns whether color is considered non-empty space.
* This is based on provided threshold value.
*/ 
bool IsNotEmpty(vec4 color)
{
  return (color.a > FSH_threshold);
}



#endregion
// 
//==========================================================
//
#region MAIN FUNCTION.


void main()
{
  //==========================================================
  //
  #region FIND VISUALLY CORRECT COORD & CORNER.
  
  
  // Calculate mapping ratios (Change in Varying / Change in World Position)
  float dxCoord = dFdx(vCoord.x) / dFdx(vPositionOriginal.x);
  float dyCoord = dFdy(vCoord.y) / dFdy(vPositionOriginal.y);
  
  float dxCorner = dFdx(vCorner.x) / dFdx(vPositionOriginal.x);
  float dyCorner = dFdy(vCorner.y) / dFdy(vPositionOriginal.y);
  
  
  // Differences between interpolated values of padded and original positions.
  vec2 positionDiff = (vPositionModified.xy - vPositionOriginal.xy);
  

  // Extrapolate the true, un-stretched coordinates
  // -> These are the "visually correct" UV and corner coordinates.
  // -> 
  vec2 trueCoord = vec2(
    vCoord.x + (positionDiff.x * dxCoord),
    vCoord.y + (positionDiff.y * dyCoord)
  );

  vec2 trueCorner = vec2(
    vCorner.x + (positionDiff.x * dxCorner),
    vCorner.y + (positionDiff.y * dyCorner)
  );
  
  
  #endregion
  // 
  //==========================================================
  //
  #region GET OUTPUT COLOR.
  

  // Select output color.
  vec4 sample = texture2D(gm_BaseTexture, trueCoord) * vColor;
  vec4 debug  = vec4(0.0);
  
  
  // If it's padding, then it can contain garbage data
  // -> Force empty area.
  if (IsPadding(trueCorner))
  {
    sample = vec4(0.0);
    debug  = FSH_colorDebug;
  }
  
  
  // Check whether non-empty space.
  // -> If so, do an early quit.
  if (IsNotEmpty(sample))
  {
    gl_FragColor = sample;
    return;
  }
  
  
  #endregion
  // 
  //==========================================================
  //
  #region CHECK WHETHER SHOULD BE OUTLINE.
  
  
  // Get distances for neighbour checks.
  vec2 texel  = vec2(dxCoord, dyCoord);
  vec2 corner = vec2(dxCorner, dyCorner);
  
  
  // Iterate through neighbours.
  for(int i = 0; i < MAX_NEIGHBOURS; i++)
  {
    // Do early quit if actual count is lesser.
    // -> This check is not in loop-condition for WebGL support.
    if (i >= FSH_offsetCount)
    {
      break;
    }
    
    // Get corner information for neighbour.
    vec2 offsetCorner = (FSH_offsets[i] * corner);
    vec2 currCorner   = (trueCorner + offsetCorner);
    
    // Check whether it's in padding,
    // -> Skip if yes, as it can't contain neighbour.
    if (IsPadding(currCorner))
    {
      continue;
    }
    
    // Read the neighbouring pixel.
    vec2 offsetCoord  = (FSH_offsets[i] * texel);
    vec2 currCoord    = (trueCoord + offsetCoord);
    vec4 neighbour    = texture2D(gm_BaseTexture, currCoord);
    
    // Check whether neighbour is non-empty.
    // -> If so, do an early quit.
    if (IsNotEmpty(neighbour))
    {
      gl_FragColor = FSH_colorOutline;
      return;
    }
  }
  
  
  // Otherwise just empty space.
  gl_FragColor = debug;
  return;
  
  
  #endregion
  // 
  //==========================================================
}


#endregion
// 
//==========================================================

