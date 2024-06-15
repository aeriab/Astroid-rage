shader_type canvas_item;

uniform float explosiveValue : hint_range(0,1);

void fragment() {
	vec4 current_color = texture(TEXTURE,UV);
	current_color.b -= explosiveValue;
	current_color.r += explosiveValue;
	current_color.g += explosiveValue;
	COLOR = current_color;
}
