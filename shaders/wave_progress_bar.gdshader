shader_type canvas_item;

uniform float wave_progress : hint_range(0.0,100.0);

void fragment() {
	vec4 current_color = texture(TEXTURE,UV);
	
	if(UV.x < wave_progress / 100.0) {
		current_color.g = 0.0;
		current_color.r = 1.0;
	} else {
		current_color.r = 0.0;
	}
	COLOR = current_color;
}