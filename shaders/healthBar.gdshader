shader_type canvas_item;

uniform float health_value : hint_range(0.0,100.0);

void fragment() {
	vec4 current_color = texture(TEXTURE,UV);

	if(UV.x < health_value / 100.0) {
		current_color.g = current_color.r;
		current_color.r = 0.0;
	}
	COLOR = current_color;
}
