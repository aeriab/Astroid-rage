shader_type canvas_item;

uniform float alpha_value: hint_range(0.0,1.0);
uniform sampler2D noise_img;

void fragment() {
	vec2 uv = vec2(UV.x + TIME, UV.y);
	
	COLOR.rgb = texture(noise_img,uv).rgb;
	COLOR.a = texture(TEXTURE,UV).a;
}
