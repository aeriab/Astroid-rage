shader_type canvas_item;

uniform float speedScale : hint_range(0,5);

void fragment() {
	
	vec2 uvr = vec2(UV.x + sin(0.04 * TIME * speedScale + 0.4) - cos(0.08 * TIME * speedScale + 0.5), UV.y + cos(0.06 * TIME * speedScale + 0.5) - sin(0.04 * TIME * speedScale + 0.4));
	if (uvr.x * uvr.y > 0.5) {
		COLOR.r -= 0.1 + 0.05 * sin(TIME);
	}
	
	vec2 uvg = vec2(UV.x - cos(0.05 * TIME * speedScale + 0.4) + cos(0.06 * TIME * speedScale + 0.5), UV.y - cos(0.07 * TIME * speedScale + 0.45) + sin(0.03 * TIME * speedScale + 0.43));
	if (uvg.x * uvg.y > 0.5) {
		COLOR.g -= 0.1 + 0.05 * cos(TIME);
	}
	
	vec2 uvb = vec2(UV.x - cos(0.065 * TIME * speedScale + 0.5) + sin(0.05 * TIME * speedScale + 0.4), UV.y + sin(0.08 * TIME * speedScale + 0.45) - cos(0.04 * TIME * speedScale + 0.47));
	if (uvb.x * uvb.y > 0.5) {
		COLOR.b -= 0.1 + 0.05 * sin(TIME + 0.2);
	}
	

}
