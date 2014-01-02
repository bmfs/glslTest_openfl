import openfl.gl.*;
import openfl.display.OpenGLView;
import flash.geom.*;

class Before extends OpenGLView{
    var framebuffer : GLFramebuffer;
 
    public function new(fr : GLFramebuffer){
        super();
        this.framebuffer = fr;
    }
 
    override public function render(rect : Rectangle) {
        GL.bindFramebuffer(GL.FRAMEBUFFER, this.framebuffer);

        GL.viewport (0,0, 800,600);
        GL.clearColor (1.0, 1.0, 1.0, 1.0);
        GL.clear (GL.DEPTH_BUFFER_BIT |GL.COLOR_BUFFER_BIT);
    }
}