shader_type canvas_item;

uniform float mask_value : hint_range(0.0,100.0);

void fragment() {
	vec4 current_color = texture(TEXTURE,UV);

	if(UV.x > mask_value / 100.0) {
		current_color.a = 0.0;
	}
	COLOR = current_color;
}
