shader_type canvas_item;

uniform float explosiveValue : hint_range(0,1);
uniform float blandness = 0.6;

void fragment() {
	vec4 current_color = texture(TEXTURE,UV);
	current_color.b -= explosiveValue;
	current_color.r += explosiveValue;
	current_color.g += explosiveValue;
	
	current_color.r -= blandness * 1.2;
	current_color.g -= blandness * 1.2;
	current_color.b -= blandness;
	
	COLOR = current_color;
}
