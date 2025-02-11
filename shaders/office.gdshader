shader_type canvas_item;

uniform sampler2D mask_tex;   // the texture from the TileMapLayer
uniform float threshold : hint_range(0.0, 1.0) = 0.1;  // how opaque a pixel must be to show the sprite
uniform vec2 mask_offset = vec2(0.0);
uniform vec2 mask_scale = vec2(1.0);

void fragment() {
	vec4 sprite_color = texture(TEXTURE, UV);
	vec2 mask_uv = UV * mask_scale + mask_offset;
	vec4 mask_color = texture(mask_tex, mask_uv);
	// If the mask pixel is too transparent, discard (or set alpha to 0)
    if (mask_color.a < threshold) {
        discard;
        // Alternatively, you could do:
        //sprite_color.a = 0.0;
    }
    COLOR = sprite_color;
}
