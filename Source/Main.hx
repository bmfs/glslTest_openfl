package;

import aze.display.*;

import flash.display.Sprite;

import flash.events.Event;
import openfl.Assets;
import flash.events.KeyboardEvent;
import flash.ui.Keyboard;



import flash.Lib;

import openfl.display.Shader;

class Main extends Sprite {
	
	public var piecesLayer:TileLayer;
	public var piecesGroup:TileGroup;

	private var movingDown:Bool;
	private var movingLeft:Bool;
	private var movingRight:Bool;
	private var movingUp:Bool;


	private var piece1:TileSprite;
	private var piece2:TileSprite;

	private var shader:Shader;
	private var shader2:Shader;
	private var shader3:Shader;
	private var startTime:Int;

	public function new () {
		
		super ();
		
		shader = new Shader("	uniform mat4 uTransform;
		                        attribute vec4 aVertex;
		                        void main() { gl_Position = aVertex * uTransform; }",
		                        "uniform float uTimer;
		                        void main() { gl_FragColor = vec4(sin(uTimer), 0, 0, 1); }");

		shader2 = new Shader(Assets.getText ("shaders/blur.vert"), Assets.getText ("shaders/vertblur.frag"));

		shader3 = new Shader(Assets.getText ("shaders/blur.vert"), Assets.getText ("shaders/blur.frag"));


		var sheetData = Assets.getText("assets/pieces.xml");
		var tilesheet = new SparrowTilesheet(Assets.getBitmapData("assets/pieces.png"), sheetData);
		
		piecesLayer = new TileLayer(tilesheet);

		piece1 = new TileSprite(piecesLayer, "z");	
		piece2 = new TileSprite(piecesLayer, "line");

		piecesGroup = new TileGroup(piecesLayer);
		piecesGroup.addChild(piece1);
		piecesGroup.addChild(piece2);

		piecesLayer.addChild(piecesGroup);

		addChild(piecesLayer.view);
		

		/*graphics.beginFill(0xFFFFFF);
		graphics.drawRect(0, 0, 50, 50);
		graphics.endFill();*/

		/*graphics.attachShader(shader);
		graphics.beginFill(0xFFFFFF);
		graphics.drawRect(50, 0, 50, 50);
		graphics.endFill();*/
		/*
		graphics.beginFill(0x0f0f0f);
		graphics.attachShader(shader2);
		graphics.drawRect(100, 0, 50, 50);

		graphics.attachShader(); // detach
		graphics.drawRect(150, 0, 50, 50);
		graphics.endFill();*/

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
		piecesLayer.render();
		piecesLayer.view.graphics.attachShader(shader3);

		piecesLayer.render(null, false);
		piecesLayer.view.graphics.attachShader(shader2);		
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