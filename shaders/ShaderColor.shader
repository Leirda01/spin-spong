shader_type canvas_item;

uniform vec4 targ_color : hint_color = vec4(1,1,1,1) ;

void fragment() {
	float curr_color_alpha = texture(TEXTURE,UV).a;
	COLOR.rgb = targ_color.rgb;
	COLOR.a = curr_color_alpha;
}