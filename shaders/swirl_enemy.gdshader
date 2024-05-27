shader_type canvas_item;

uniform float damage_value : hint_range(0,1);
uniform float alpha_value : hint_range(0,1);
const float startBiasR = 0.8;

void fragment() {
	vec4 current_color = texture(TEXTURE,UV);
	current_color.r += damage_value;
	current_color.a = current_color.a * alpha_value;
	COLOR = current_color;
}
