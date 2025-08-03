shader_type canvas_item;

uniform vec4 base_tones[8] : source_color;

uniform vec4 output_tones[8] : source_color;

void fragment() {
	vec4 og_color = COLOR;
	vec3 output_color;
	
	for (int i = 0; i < 9; i++){
		if (abs(og_color.r - base_tones[i].r) < 0.0001 && abs(og_color.g - base_tones[i].g) < 0.0001 && abs(og_color.b - base_tones[i].b) < 0.0001){
			output_color.rgb = output_tones[i].rgb;
			break;
		}
		output_color.rgb = og_color.rgb;
	}
	
	COLOR.rgb = output_color;
}