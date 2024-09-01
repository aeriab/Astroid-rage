shader_type canvas_item;

uniform float wave_progress : hint_range(0.0,101.0);

void fragment() {
	vec2 uv = vec2(UV.x + TIME, UV.y);
	vec4 current_color = texture(TEXTURE,UV);
	
	if(UV.x < wave_progress / 100.0) {
		current_color.a = current_color.r * 0.25;
	} else {
		current_color.a = 0.0;
	}
	
	if(wave_progress >= 99.0 && wave_progress <= 100.5) {
		current_color.r -= (sin(TIME * 6.0) + 1.0)/5.0;
	} else if (wave_progress >= 100.5) {
		current_color.a = current_color.r * 0.25;
	}
	
	COLOR = current_color;
}