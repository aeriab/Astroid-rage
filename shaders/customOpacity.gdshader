shader_type canvas_item;

uniform float opacity_value : hint_range(0.0,100.0);

void fragment() {
	vec4 current_color = texture(TEXTURE,UV);
	current_color.a = current_color.r * (opacity_value / 100.0);
	COLOR = current_color;
}