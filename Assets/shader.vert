
attribute vec3 position;
attribute vec2 surfacePosAttrib;
varying vec2 surfacePosition;

vec3 newpos;
float angle;

void main() {
	angle = atan(position.y, position.x);
	surfacePosition = surfacePosAttrib;
	newpos = vec3(cos(angle)*position.y, sin(angle)*position.y, 1);
	//newpos = vec3(position.x, position.y, 1);
	gl_Position = vec4( newpos , 1.0 );
}