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

	private var startTime:Int;

	public function new () {
		
		super ();
		

		var sheetData = Assets.getText("assets/pieces.xml");
		var tilesheet = new SparrowTilesheet(Assets.getBitmapData("assets/pieces.png"), sheetData);
		
		piecesLayer = new TileLayer(tilesheet);

		piece1 = new TileSprite(piecesLayer, "target");	
		piece2 = new TileSprite(piecesLayer, "z");

		piecesGroup = new TileGroup(piecesLayer);
		piecesGroup.addChild(piece1);
		piecesGroup.addChild(piece2);

		piecesLayer.addChild(piecesGroup);

		specialSprite = new SpecialSprite(piecesLayer);
		addChild(specialSprite);
		

		startTime = Lib.getTimer();

		stage.addEventListener (KeyboardEvent.KEY_DOWN, stage_onKeyDown);
		stage.addEventListener (KeyboardEvent.KEY_UP, stage_onKeyUp);
		addEventListener(Event.ENTER_FRAME, this_onEnterFrame);
	}

	public function update():Void
	{
		if (movingDown) {
			piece1.y += 20;
			piece2.y += 10;
		}

		if (movingUp) {
			piece1.y -= 20;
			piece2.y -= 10;
		}

		if (movingLeft){
			piece1.x -= 20;
			piece2.x -= 10;
		}

		if (movingRight){
			piece1.x += 20;
			piece2.x += 10;
		}
	}

	public function render():Void
	{
		piecesLayer.render();
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