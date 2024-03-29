shader_type spatial;
uniform float corner_radius : hint_range(0.0, 0.5); // Adjust the radius of the rounded corners
void fragment() {
	if (UV.y > .9) {
		if (UV.x < .1) {
			ALPHA = 0.0;
		}
		if (UV.x < .9) {
			ALBEDO = vec3(0.2);
		}
	}
}

//void light() {
	// Called for every pixel for every light affecting the material.
	// Uncomment to replace the default light processing function with this one.
//}
