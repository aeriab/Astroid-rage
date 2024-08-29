shader_type canvas_item;

uniform float boost_value : hint_range(0.0,6.3);
uniform bool gaining_boost;

void fragment() {
	vec4 current_color = texture(TEXTURE,UV);
	float origRed = current_color.r;
	
	if(UV.x < boost_value / 6.3 && gaining_boost) {
		current_color.r = current_color.r * 1.0;
	} else if (UV.x < boost_value / 6.3 && !gaining_boost) {
		current_color.g = origRed * 0.6;
		current_color.b = origRed * 0.0;
		current_color.r = origRed * 1.0;
	}
	
	if (boost_value >= 6.3) {
		current_color.g = origRed * 0.6;
		current_color.b = origRed * 0.0;
		current_color.r = origRed * 1.0;
	}


	
	if(UV.x > boost_value / 6.3) {
		current_color.g = 0.0;
		current_color.r = 0.0;
	}
	
	COLOR = current_color;
}
