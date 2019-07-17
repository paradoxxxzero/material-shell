uniform int height;
uniform sampler2D tex;
uniform int width;
uniform float intensity;

vec2 resolution = 1 / vec2(width, height);
vec2 direction = vec2(1.0);

float SCurve (float x) {
	x = x * 2.0 - 1.0;
	return -x * abs(x) * 0.5 + x + 0.5;
}

vec4 Blur(sampler2D source, vec2 size, vec2 uv, float radius) {
  if (radius >= 1.0) {
		vec4 A = vec4(0.0);
		vec4 C = vec4(0.0);
		float width = 1.0 / size.x;
		float divisor = 0.0;
    float weight = 0.0;
    float radiusMultiplier = 1.0 / radius;

		for (float x = -radius	; x <= radius	; x++) {
			A = texture2D(source, uv + vec2(x * width, 0.0));
    	weight = SCurve(1.0 - (abs(x) * radiusMultiplier));
    	C += A * weight;
			divisor += weight;
		}

		return vec4(C.r / divisor, C.g / divisor, C.b / divisor, 1.0);
	}
  return texture2D(source, uv);
}

void main(void) {
  cogl_color_out = Blur(tex, vec2(width, height), cogl_tex_coord_in[0].xy, intensity);
  cogl_color_out.a = 1.0;
}
