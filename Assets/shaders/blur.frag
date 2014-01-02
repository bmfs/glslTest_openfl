varying vec2 vTexCoord;
uniform sampler2D uImage0;

const float blurSize = 1.0/512.0;
void main(void)
{
	vec4 sum = vec4(0.0);

	sum += texture2D(uImage0, vec2(vTexCoord.x - 4.0*blurSize, vTexCoord.y )) * 0.05;
	sum += texture2D(uImage0, vec2(vTexCoord.x - 3.0*blurSize, vTexCoord.y)) * 0.09;
	sum += texture2D(uImage0, vec2(vTexCoord.x - 2.0*blurSize, vTexCoord.y)) * 0.12;
	sum += texture2D(uImage0, vec2(vTexCoord.x - blurSize, vTexCoord.y)) * 0.15;
	sum += texture2D(uImage0, vec2(vTexCoord.x, vTexCoord.y)) * 0.16;
	sum += texture2D(uImage0, vec2(vTexCoord.x + blurSize, vTexCoord.y)) * 0.15;
	sum += texture2D(uImage0, vec2(vTexCoord.x + 2.0*blurSize, vTexCoord.y)) * 0.12;
	sum += texture2D(uImage0, vec2(vTexCoord.x + 3.0*blurSize, vTexCoord.y)) * 0.09;
	sum += texture2D(uImage0, vec2(vTexCoord.x + 4.0*blurSize, vTexCoord.y)) * 0.05;
 

	gl_FragColor = sum;
}