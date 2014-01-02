package;

import aze.display.*;

import flash.display.Sprite;

import flash.events.Event;
import openfl.Assets;
import flash.events.KeyboardEvent;
import flash.ui.Keyboard;
import flash.display.BitmapData;



import flash.Lib;

import openfl.display.Shader;

class Main extends Sprite {
	
	public var piecesLayer:TileLayer;
	
	public var bluredPieces:Sprite;
	public var bluredPieces2:Sprite;

	public var specialSprite:SpecialSprite;

	public var piecesGroup:TileGroup;

	private var movingDown:Bool;
	private var movingLeft:Bool;
	private var movingRight:Bool;
	private var movingUp:Bool;


	private var piece1:TileSprite;
	private var piece2:TileSprite;

	private var piecesShaderGroup:TileShaderGroup;

	private var shader:Shader;
	private var shader2:Shader;
	private var shader3:Shader;

	private var shader4:PrimitiveShader;

	private var startTime:Int;

	public function new () {
		
		super ();
		
		shader = new Shader(Assets.getText ("shaders/normal.vert"), Assets.getText ("shaders/texture.frag"));

		shader2 = new Shader(Assets.getText ("shaders/normal.vert"), Assets.getText ("shaders/vertblur.frag"));

		shader3 = new Shader(Assets.getText ("shaders/normal.vert"), Assets.getText ("shaders/blur.frag"));
		shader4 = new PrimitiveShader(Assets.getText ("shaders/heroku2.vert"), Assets.getText ("shaders/texture.frag"));


		var sheetData = Assets.getText("assets/pieces.xml");
		var tilesheet = new SparrowTilesheet(Assets.getBitmapData("assets/pieces.png"), sheetData);
		
		piecesLayer = new TileLayer(tilesheet);
		bluredPieces = new Sprite();
		bluredPieces2 = new Sprite();

		piece1 = new TileSprite(piecesLayer, "target");	

		piecesGroup = new TileGroup(piecesLayer);
		piecesGroup.addChild(piece1);

		piecesLayer.addChild(piecesGroup);

		//addChild(piecesLayer.view);
		//piecesShaderGroup = new TileShaderGroup();
		//addChild(piecesShaderGroup.view);
		//addChild(bluredPieces);
		//addChild(bluredPieces2);

		specialSprite = new SpecialSprite(piecesLayer, shader4);
		addChild(specialSprite);

		//piecesShaderGroup.setLayer(piecesLayer);
		//piecesShaderGroup.addShader(shader);
		//piecesShaderGroup.addShader(shader3);
		//piecesShaderGroup.addShader(shader2);
		


		startTime = Lib.getTimer();

		stage.addEventListener (KeyboardEvent.KEY_DOWN, stage_onKeyDown);
		stage.addEventListener (KeyboardEvent.KEY_UP, stage_onKeyUp);
		addEventListener(Event.ENTER_FRAME, this_onEnterFrame);
	}

	public function update():Void
	{
		shader.setUniformValue("uTimer", (Lib.getTimer() - startTime) / 1000);

		if (movingDown) {
			piece1.y += 20;
		}

		if (movingUp) {
			piece1.y -= 20;
		}

		if (movingLeft){
			piece1.x -= 20;
		}

		if (movingRight){
			piece1.x += 20;
		}
	}

	public function render():Void
	{
		//piecesShaderGroup.render();

		

		/*bluredPieces.graphics.attachShader(shader2);*/
		piecesLayer.render();
		//piecesLayer.view.graphics.attachShader(shader2);

		/*var bd = new BitmapData( stage.stageWidth, stage.stageHeight );
		bd.draw(piecesLayer.view);

		bluredPieces.graphics.clear();
		
		bluredPieces.graphics.beginBitmapFill(bd, null, false);
		bluredPieces.graphics.drawRect(0,0,bd.width,bd.height);
		bluredPieces.graphics.endFill();

		bluredPieces2.graphics.attachShader(shader3);
		piecesLayer.render();
		var bd2 = new BitmapData( stage.stageWidth, stage.stageHeight );
		bd2.draw(piecesLayer);

		bluredPieces2.graphics.clear();
		bluredPieces2.graphics.beginBitmapFill(bd);
		bluredPieces2.graphics.drawRect(0,0,bd.width,bd.height);*/


	}

	private function stage_onKeyDown (event:KeyboardEvent):Void {
		switch (event.keyCode) {
			case Keyboard.DOWN: movingDown = true;
			case Keyboard.LEFT: movingLeft = true;
			case Keyboard.RIGHT: movingRight = true;
			case Keyboard.UP: movingUp = true;

		}

	}


	private function stage_onKeyUp (event:KeyboardEvent):Void {

		switch (event.keyCode) {

			case Keyboard.DOWN: movingDown = false;
			case Keyboard.LEFT: movingLeft = false;
			case Keyboard.RIGHT: movingRight = false;
			case Keyboard.UP: movingUp = false;

		}	
	}
	private function this_onEnterFrame (event:Event):Void {
		
		update();
		
		render();
	}

	
	
}