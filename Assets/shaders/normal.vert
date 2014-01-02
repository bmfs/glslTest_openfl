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
	gl_Position = vec4( position.x, position.y, 0.0 , 1.0 );
}