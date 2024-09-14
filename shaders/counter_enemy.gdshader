shader_type canvas_item;

uniform float anger_value : hint_range(0,1);
uniform float damage_value : hint_range(0,1);
uniform float alpha_value : hint_range(0,1);
const float startBiasR = 0.8;

void fragment() {
	vec4 current_color = texture(TEXTURE,UV);
	current_color.b += damage_value;
	current_color.r = current_color.r + ((current_color.r+0.1) * anger_value);
	current_color.a = current_color.a * alpha_value;
	COLOR = current_color;
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
