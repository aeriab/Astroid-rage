shader_type canvas_item;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	vec4 current_color = texture(TEXTURE,UV);

	current_color.g = current_color.r;
	current_color.r = 0.0;
	
	COLOR = current_color;
}
