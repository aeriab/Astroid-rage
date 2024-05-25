shader_type canvas_item;

uniform float alpha_value: hint_range(0.0,1.0);

void fragment() {
	vec4 current_color = texture(TEXTURE,UV);
	current_color.a = current_color.a * alpha_value;
	current_color.r = 0.0;
	current_color.g = 0.0;
	current_color.b = alpha_value;
	COLOR = current_color;
}
