uniform mat4 uTransform;
attribute vec4 aVertex;
attribute vec2 aTexCoord;
varying vec2 vTexCoord;

vec4 position;
vec3 newpos;
float angle;

void main() {
	vTexCoord = aTexCoord;
	position = aVertex * uTransform;
	angle = atan(position.y, position.x);
	newpos = vec3(cos(angle)*position.y, sin(angle)*position.y, 1);
	gl_Position = vec4( newpos , 1.0 );
}