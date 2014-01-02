import openfl.gl.*;
import openfl.display.OpenGLView;
import flash.geom.*;
import openfl.utils.Float32Array;

class After extends OpenGLView{
    var texture : GLTexture;
    var shader: PrimitiveShader;

    private var buffer:GLBuffer;
    private var texCoordBuffer:GLBuffer;

    private var positionAttribute:Int;
    //private var vertexPosition:Int;
    private var mVertexSlot:Int;

    private var imageUniform:Int;
    private var texCoordAttribute:Int;

    public function new(texture : GLTexture, shader:PrimitiveShader)
    {
        super();
 
        this.texture = texture;
        this.shader = shader;

        //vertexPosition = GL.getAttribLocation (this.shader.program, "position");
        //GL.enableVertexAttribArray (vertexPosition);


        mVertexSlot = GL.getAttribLocation (this.shader.program, "aVertex");
        texCoordAttribute = GL.getAttribLocation (this.shader.program, "aTexCoord");
        //mTransformSlot = GL.getAttribLocation (this.shader.program, "uTransform");
        imageUniform = GL.getUniformLocation (this.shader.program, "uImage0");

        createBuffers();
    }

    public function createBuffers():Void 
    {
        var vertices = [
        -1.0, -1.0,
         1.0, -1.0, 
        -1.0, 1.0,
         1.0, -1.0,
         1.0, 1.0, 
        -1.0, 1.0
        ];

        buffer = GL.createBuffer ();
        GL.bindBuffer (GL.ARRAY_BUFFER, buffer);
        GL.bufferData (GL.ARRAY_BUFFER, new Float32Array (cast vertices), GL.STATIC_DRAW);
        GL.bindBuffer (GL.ARRAY_BUFFER, null);

        var texCoords = [
            
            0, 0, 
            1, 0, 
            0, 1, 
            1, 0,
            1, 1,
            0, 1 
        ];
        
        texCoordBuffer = GL.createBuffer ();
        GL.bindBuffer (GL.ARRAY_BUFFER, texCoordBuffer);
        GL.bufferData (GL.ARRAY_BUFFER, new Float32Array (cast texCoords), GL.STATIC_DRAW);
        GL.bindBuffer (GL.ARRAY_BUFFER, null);
    }
 
    override public function render(rect : Rectangle) {
        GL.bindFramebuffer(GL.FRAMEBUFFER, null);
        //var modelViewMatrix = Matrix3D.create2D (positionX, positionY, 1, 0);

        GL.clearColor (1.0, 1.0, 1.0, 1.0);
        GL.clear (GL.COLOR_BUFFER_BIT | GL.DEPTH_BUFFER_BIT );

        if (shader.program == null) return;
        
        
        GL.useProgram(this.shader.program);
       
        GL.enableVertexAttribArray (mVertexSlot);
        GL.enableVertexAttribArray (texCoordAttribute);

        GL.activeTexture (GL.TEXTURE0);
        GL.bindTexture (GL.TEXTURE_2D, this.texture);
        GL.enable (GL.TEXTURE_2D);

        GL.bindBuffer (GL.ARRAY_BUFFER, buffer); 
        GL.vertexAttribPointer (mVertexSlot, 2, GL.FLOAT, false, 0, 0);

        GL.bindBuffer (GL.ARRAY_BUFFER, texCoordBuffer);
        GL.vertexAttribPointer (texCoordAttribute, 2, GL.FLOAT, false, 0, 0);

        GL.uniform1i (imageUniform, 0);

        GL.drawArrays (GL.TRIANGLES, 0, 6);
        
        GL.bindBuffer (GL.ARRAY_BUFFER, null);
        GL.disable (GL.TEXTURE_2D);
        GL.bindTexture (GL.TEXTURE_2D, null);
        
        GL.disableVertexAttribArray (mVertexSlot);
        GL.disableVertexAttribArray (texCoordAttribute);
        GL.useProgram (null);

        //Check gl error. 
        if( GL.getError() == GL.INVALID_FRAMEBUFFER_OPERATION ){
            trace("INVALID_FRAMEBUFFER_OPERATION!!");
        }
    }
}