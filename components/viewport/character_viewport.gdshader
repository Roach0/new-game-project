shader_type canvas_item;

uniform float pixel_size : hint_range(1.0, 32.0) = 6.0;

void fragment() {
    vec2 texture_size = vec2(textureSize(TEXTURE, 0));
    vec2 uv_pixel_size = pixel_size / texture_size;

    vec2 snapped = floor(UV / uv_pixel_size) * uv_pixel_size + uv_pixel_size * 0.5;

    COLOR = texture(TEXTURE, snapped);
}