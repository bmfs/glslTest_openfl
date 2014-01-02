varying vec2 vTexCoord;
uniform sampler2D uImage0;

void main(void)
{
	gl_FragColor = vec4(1.0, 0.0, 0.0, 1.0) + texture2D(uImage0, vTexCoord);
}