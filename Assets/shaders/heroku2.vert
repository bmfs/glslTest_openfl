
attribute vec4 aVertex;

attribute vec2 aTexCoord;
varying vec2 vTexCoord;

void main() {
	vTexCoord = aTexCoord;
	gl_Position = vec4( aVertex.x, aVertex.y, 0.0, 1.0 );
	
}