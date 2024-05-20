shader_type canvas_item;

uniform float player_damage : hint_range(0.0,15.0);

void fragment() {
	vec4 current_color = texture(TEXTURE,UV);
	current_color.r = player_damage / 15.0;
	current_color.g = (15.0 / player_damage) - 1.0;
	current_color.b = (7.5 / player_damage) - 0.5;
	COLOR = current_color;
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
