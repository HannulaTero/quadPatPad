//==========================================================
//
#region INFORMATION.
/*
  Shader used to push vertices to give padding to drawn quads.
  
  Corner ID must be enabled! 
  -> Check manual "shader_enable_corner_id".
  -> Stores corner ID in lowest bits of Red and Blue channels.
  
  
  Vertex shader has following assumptions: 
  -> Triangles represent sprites or other quads.
  -> Triangles are not not from custom vertex buffer.
  -> Sprites are non-rotated (image_angle = 0)
  -> Sprites are non-flipped (image_xscale = -1)
  -> Sprites are therefore axis-aligned.
  
  
*/
#endregion
// 
//==========================================================
//
#region DECLARE: ATTRIBUTES.


attribute vec3 in_Position;
attribute vec4 in_Colour;
attribute vec2 in_TextureCoord;


#endregion
// 
//==========================================================
//
#region DECLARE: VARYINGS.


varying vec2 vCoord;
varying vec4 vColor;
varying vec2 vCorner;
varying vec2 vSpacePosOriginal;
varying vec2 vSpacePosModified;


#endregion
// 
//==========================================================
//
#region DECLARE: UNIFORMS.


// How large padding quads will have.
uniform float VSH_vertexPadding;



#endregion
// 
//==========================================================
//
#region MAIN FUNCTION.


void main()
{
  // Extract corner ID from color bits.
  // -> The index walks in clockwise-order (not in zigzag).
  // -> So can't directly use bits as corners.
  vec2 colorBytes = floor(0.5 + in_Colour.rb * 255.0);
  vec2 colorBits  = mod(colorBytes, 2.0);
  vec2 corner;
  {
    int cornerID = int(dot(vec2(1.0, 2.0), colorBits));
         if (cornerID == 0) { corner = vec2(0.0, 0.0); }
    else if (cornerID == 1) { corner = vec2(1.0, 0.0); }
    else if (cornerID == 2) { corner = vec2(1.0, 1.0); }
    else                    { corner = vec2(0.0, 1.0); }
  }
  
  
  // Get normalized color and alpha.
  // -> One bit was used for corner ID, so pure white is not pure white.
  vec4 normalizedColor;
  normalizedColor.rb = (colorBytes - colorBits) / 254.0;
  normalizedColor.ga = in_Colour.ga;
  
  
  // Get space position and push away vertices by given amount.
  vec4 spacePosOriginal = vec4(in_Position, 1.0);
  vec4 spacePosModified = spacePosOriginal;
  vec2 paddingDirection = (corner * 2.0 - 1.0);
  spacePosModified.xy += (paddingDirection * VSH_vertexPadding);
  
  
  // Set the clip-space position with padded position.
  gl_Position = gm_Matrices[MATRIX_WORLD_VIEW_PROJECTION] * spacePosModified;
  
  
  // Set the varyings.
  vColor = normalizedColor;
  vCoord = in_TextureCoord;
  vCorner = corner;
  vSpacePosOriginal = spacePosOriginal.xy;
  vSpacePosModified = spacePosModified.xy;
}


#endregion
// 
//==========================================================