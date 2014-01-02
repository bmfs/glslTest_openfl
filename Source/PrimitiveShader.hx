import openfl.gl.*;

class PrimitiveShader {

	public var program:GLProgram;

	public function new(inVertSource:String, inFragSource:String)
	{
		program = GL.createProgram ();

		var vs = createShader (inVertSource, GL.VERTEX_SHADER);
		var fs = createShader (inFragSource, GL.FRAGMENT_SHADER);
		
		if (vs == null || fs == null) return;

		GL.attachShader (program, vs);
		GL.attachShader (program, fs);
		
		GL.deleteShader (vs);
		GL.deleteShader (fs);
		
		GL.linkProgram (program);

		if (GL.getProgramParameter (program, GL.LINK_STATUS) == 0) {
			
			trace (GL.getProgramInfoLog (program));
			trace ("VALIDATE_STATUS: " + GL.getProgramParameter (program, GL.VALIDATE_STATUS));
			trace ("ERROR: " + GL.getError ());
			return;
			
		}
		
	}

	private function createShader (source:String, type:Int):GLShader {
		
		var shader = GL.createShader (type);
		GL.shaderSource (shader, source);
		GL.compileShader (shader);
		
		if (GL.getShaderParameter (shader, GL.COMPILE_STATUS) == 0) {
			
			trace (GL.getShaderInfoLog (shader));
			return null;
			
		}
		
		return shader;
		
	}
}