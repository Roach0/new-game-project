shader_type canvas_item;

uniform float pixel_size : hint_range(1.0, 32.0) = 6.0;
uniform vec2 base_resolution = vec2(512.0, 512.0); // match your SubViewport size

void fragment() {
    vec2 current_size = vec2(textureSize(TEXTURE, 0));
    float scale_factor = current_size.x / base_resolution.x;
    float effective_pixel = max(1.0, pixel_size * scale_factor);

    vec2 uv_pixel_size = effective_pixel / current_size;
    vec2 snapped = floor(UV / uv_pixel_size) * uv_pixel_size + uv_pixel_size * 0.5;
    COLOR = texture(TEXTURE, snapped);
}