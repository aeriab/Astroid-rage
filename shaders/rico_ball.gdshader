shader_type canvas_item;

uniform float expected_bounces : hint_range(2.0,12.0);
uniform float rico_bounces : hint_range(0.0,12.0);
uniform float player_damage : hint_range(0.0,15.0);
uniform float opacity_value : hint_range(0.0,100.0);
uniform float speedScale;

void fragment() {
	vec4 current_color = texture(TEXTURE,UV);
	if (current_color.r > 0.7) {
		current_color.r = 0.0;
		current_color.g = 0.0;
		current_color.b = 0.0;
	}
	current_color.r = COLOR.r + ((1.0/17.0) * ((player_damage-4.0)*(player_damage-4.0)) / 7.0);
	current_color.g = COLOR.r + ((-1.0/10.0) * ((player_damage-8.0)*(player_damage-8.0)) / 6.0) + 0.4;
	current_color.b = COLOR.r + ((-1.0/10.0) * ((player_damage-4.0)*(player_damage-4.0)) / 6.0) + 0.4;
	current_color.a = current_color.a * (opacity_value / 100.0);
	current_color.a = current_color.a * ((rico_bounces/expected_bounces) + 0.1);
	
	COLOR = current_color;
}
