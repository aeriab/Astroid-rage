shader_type canvas_item;

uniform float slow_by_mult : hint_range(0.1, 20.0);

void fragment() {
	float slider_valr = cos(TIME/(slow_by_mult * 0.8));
	float slider_valg = sin(TIME/(slow_by_mult * 1.13));
	float slider_valb = cos((TIME - (PI/3.0))/(slow_by_mult * 0.95));
	vec2 uv = vec2(UV.x + TIME, UV.y);
	
	COLOR.r = (slider_valr * COLOR.r * 0.2) + (0.8 * COLOR.r);
	COLOR.g = (slider_valg * COLOR.g * 0.2) + (0.8 * COLOR.g);
	COLOR.b = (slider_valb * COLOR.b * 0.2) + (0.8 * COLOR.b);
}
