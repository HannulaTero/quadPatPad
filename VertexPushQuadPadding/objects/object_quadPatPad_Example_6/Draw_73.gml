/// @desc 
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_font(font_quadPatPad_small);
draw_text(
  8, 8, "Asset can't deal rotations."
);
draw_text(
  8, 20, "-> There is no usable angle-information in vertex shader."
);
draw_text(
  8, 32, "-> UP/DOWN to change padding ."
);
draw_text(
  8, 44, "-> LEFT/RIGHT to change angle."
);
draw_text(
  8, 56, $"padding : {padding}"
);
draw_text(
  8, 68, $"angle :   {image_angle}"
);