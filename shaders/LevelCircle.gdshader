shader_type canvas_item;

uniform float level_progress : hint_range(0.65,0.88);

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	vec4 current_color = texture(TEXTURE,UV);
	if(current_color.g < level_progress) {
		current_color.a = 0.0;
	}
	COLOR = current_color;
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
