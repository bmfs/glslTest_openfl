import flash.display.Sprite;
import openfl.gl.*;
import openfl.display.*;
import aze.display.*;
import flash.Lib;
import openfl.Assets;
import flash.display.Bitmap;
import flash.geom.*;

class SpecialSprite extends Sprite{
	public var framebuffer1:GLFramebuffer;
	public var texture1:GLTexture;
	public var renderbuffer1:GLRenderbuffer;

	public var framebuffer2:GLFramebuffer;
	public var texture2:GLTexture;
	public var renderbuffer2:GLRenderbuffer;

	public function new( tilelayer:TileLayer){
		super();

 		addChild(tilelayer.view);

 		setupFBO(800,600);

 		GL.enable( GL.DEPTH_TEST );
 	
		GL.bindFramebuffer(GL.FRAMEBUFFER, null);
 	
		this.addChildAt(new Before(framebuffer1), 0);
		this.addChild(new RenderToTextureLayer(	texture1,
												framebuffer2,
												new PrimitiveShader(Assets.getText ("shaders/heroku2.vert"), 
																		Assets.getText ("shaders/blur.frag"))
											));
		this.addChild(new RenderToTextureLayer(	texture2,
												framebuffer1,
												new PrimitiveShader(	Assets.getText ("shaders/heroku2.vert"), 
																		Assets.getText ("shaders/vertblur.frag"))
											));

		this.addChild(new After(texture1, new PrimitiveShader(	Assets.getText ("shaders/heroku2.vert"), 
																Assets.getText ("shaders/texture.frag"))
											));
	}

	public function setupFBO(width:Int, height:Int):Void 
	{
		framebuffer1 = GL.createFramebuffer();
		renderbuffer1 = GL.createRenderbuffer();

		texture1 = GL.createTexture();
		GL.bindTexture(GL.TEXTURE_2D, texture1);
		GL.texImage2D(	GL.TEXTURE_2D,
						0,
						GL.RGB, 
						width,
						height, 
						0, 
						GL.RGB,
						GL.UNSIGNED_SHORT_5_6_5,
						null);
		

		GL.texParameteri( GL.TEXTURE_2D , 
						  GL.TEXTURE_WRAP_S,
						  GL.CLAMP_TO_EDGE );
		GL.texParameteri( GL.TEXTURE_2D , 
						  GL.TEXTURE_WRAP_T,
						  GL.CLAMP_TO_EDGE );		
		GL.texParameteri( GL.TEXTURE_2D , 
						  GL.TEXTURE_MIN_FILTER ,
						  GL.LINEAR );
		GL.texParameteri( GL.TEXTURE_2D , 
						  GL.TEXTURE_MAG_FILTER,
						  GL.LINEAR );

		//Bind renderbuffer and create depth buffer. 
		GL.bindRenderbuffer( GL.RENDERBUFFER, renderbuffer1 );
		GL.renderbufferStorage( GL.RENDERBUFFER,
								GL.DEPTH_COMPONENT16,
								width,
								height);
 		
 		// bind the framebuffer
 		GL.bindFramebuffer(GL.FRAMEBUFFER, framebuffer1);

 		//specify texture as color attachment
		GL.framebufferTexture2D(GL.FRAMEBUFFER, GL.COLOR_ATTACHMENT0, GL.TEXTURE_2D, texture1, 0);


		//Specify depthRenderbuffer as depth attachement.
		GL.framebufferRenderbuffer( GL.FRAMEBUFFER , 
									GL.DEPTH_ATTACHMENT,
									GL.RENDERBUFFER,
									renderbuffer1);

		// -- second framebuffer 
		framebuffer2 = GL.createFramebuffer();
		renderbuffer2 = GL.createRenderbuffer();

		texture2 = GL.createTexture();
		GL.bindTexture(GL.TEXTURE_2D, texture2);
		GL.texImage2D(	GL.TEXTURE_2D,
						0,
						GL.RGB, 
						width,
						height, 
						0, 
						GL.RGB,
						GL.UNSIGNED_SHORT_5_6_5,
						null);
		

		GL.texParameteri( GL.TEXTURE_2D , 
						  GL.TEXTURE_WRAP_S,
						  GL.CLAMP_TO_EDGE );
		GL.texParameteri( GL.TEXTURE_2D , 
						  GL.TEXTURE_WRAP_T,
						  GL.CLAMP_TO_EDGE );		
		GL.texParameteri( GL.TEXTURE_2D , 
						  GL.TEXTURE_MIN_FILTER ,
						  GL.LINEAR );
		GL.texParameteri( GL.TEXTURE_2D , 
						  GL.TEXTURE_MAG_FILTER,
						  GL.LINEAR );

		//Bind renderbuffer and create depth buffer. 
		GL.bindRenderbuffer( GL.RENDERBUFFER, renderbuffer2 );
		GL.renderbufferStorage( GL.RENDERBUFFER,
								GL.DEPTH_COMPONENT16,
								width,
								height);
 		
 		// bind the framebuffer
 		GL.bindFramebuffer(GL.FRAMEBUFFER, framebuffer2);

 		//specify texture as color attachment
		GL.framebufferTexture2D(GL.FRAMEBUFFER, GL.COLOR_ATTACHMENT0, GL.TEXTURE_2D, texture2, 0);


		//Specify depthRenderbuffer as depth attachement.
		GL.framebufferRenderbuffer( GL.FRAMEBUFFER , 
									GL.DEPTH_ATTACHMENT,
									GL.RENDERBUFFER,
									renderbuffer2);
		//Check framebuffer.
		var status = GL.checkFramebufferStatus( GL.FRAMEBUFFER );
		switch( status ){

			case GL.FRAMEBUFFER_INCOMPLETE_ATTACHMENT:
				trace("FRAMEBUFFER_INCOMPLETE_ATTACHMENT");

			case GL.FRAMEBUFFER_UNSUPPORTED:
				trace("GL_FRAMEBUFFER_UNSUPPORTED");

			case GL.FRAMEBUFFER_COMPLETE:
				trace("GL_FRAMEBUFFER_COMPLETE");

			default:
				trace("Check frame buffer:", status);
		}
	}
}