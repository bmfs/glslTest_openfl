import aze.display.*;
import openfl.display.Shader;
import flash.display.BitmapData;
import flash.display.Sprite;

import flash.Lib;

class TileShaderGroup {
	
	public var view:Sprite;

	private var shaderList:Array<Shader>;

	private var _tilelayer:TileLayer;

	public function new()
	{
		shaderList = new Array<Shader>();
		view = new Sprite();
	}

	public function setLayer(tilelayer:TileLayer):Void
	{
		_tilelayer = tilelayer;
	}

	public function addShader(shader:Shader):Void
	{
		shaderList.push(shader);
	}

	public function render():Void 
	{
		_tilelayer.render();
		var bd = new BitmapData( Lib.stage.stageWidth, Lib.stage.stageHeight );
		bd.draw(_tilelayer.view);

		view.graphics.clear();
		for (i in 0...shaderList.length ) {
			if (i>0) {
				bd.draw(view);
			}
			view.graphics.attachShader(shaderList[i]);
			view.graphics.beginBitmapFill(bd);
			view.graphics.drawRect(0,0,bd.width,bd.height);
			view.graphics.endFill();
		}
	}
}