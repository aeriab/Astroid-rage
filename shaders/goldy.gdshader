shader_type canvas_item;

uniform float damage_value : hint_range(0,1);

void fragment() {
	vec4 current_color = texture(TEXTURE,UV);
	current_color.r += damage_value;
	current_color.g -= damage_value;
	current_color.b -= damage_value;
	COLOR = current_color;
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
