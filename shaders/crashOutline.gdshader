shader_type canvas_item;

uniform float crash_progress : hint_range(0.0,6.3);
uniform float radius;

void fragment() {
    // Texture coordinates (normalized)
	vec2 uv = vec2(UV.x - 0.5, UV.y - 0.5);
	float theta = 0.0;
	float hypotenuse = sqrt((uv.x * uv.x) + (uv.y * uv.y));
	
	if (uv.y < 0.0) {
		theta = acos(uv.x / hypotenuse);
	} else {
		theta = 2.0 * PI -  acos(uv.x / hypotenuse);
	}
    
    // Check if the fragment is inside the visible part of the circle
    bool insideCircle = crash_progress > theta;
    
    // Sample the texture color
    vec4 current_color = texture(TEXTURE, UV);
    
    // If inside the visible part, set the color to white
    if (insideCircle) {
        COLOR.a = current_color.a - 0.3; // White color
    } else {
        COLOR.a = 0.0; // Use the original texture color
    }
}