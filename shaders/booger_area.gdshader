shader_type canvas_item;

uniform float player_damage : hint_range(0.0,15.0);
//uniform float alpha : hint_range(0.0, 1.0);

void fragment() {
	vec4 current_color = texture(TEXTURE,UV);
	if (current_color.r > 0.7) {
		current_color.r = 0.0;
		current_color.g = 0.0;
		current_color.b = 0.0;
	}
	current_color.r = current_color.r - (player_damage / 20.0);
	current_color.g = current_color.g - (player_damage / 20.0);
	current_color.b = current_color.b + (player_damage / 20.0);
	//if (current_color.a >= 0.1) {
		//current_color.a = alpha;
	//}
	COLOR = current_color;
}
