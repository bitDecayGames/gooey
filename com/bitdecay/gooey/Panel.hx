package com.bitdecay.gooey;

import flixel.FlxSprite;
import flixel.group.FlxSpriteGroup;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.util.FlxColor;

/**
	Panel is a slotted FlxSpriteGroup that allows you to set the sprites into top, bottom, center, topLeft, bottomLeft, topRight, and bottomRight slots.  Calling .refreshPositions after adding the sprites will auto-calculate where all the items need to be placed.  Can be used in a Popup to create an easy "Are you sure?" dialog.

	Example:
		var panel = new Panel(FlxG.width / 2 - 200, FlxG.height / 2 - 100, 400, 200)
			.setBackground(new FlxSprite(0, 0, AssetPaths.red_square__png), 15.0)
			.setTopLeft(new FlxSprite(0, 0, AssetPaths.btn_onion_brush__png))
			.setTopRight(new FlxSprite(0, 0, AssetPaths.btn_onion_brush__png))
			.setBottomLeft(new FlxButton(0, 0, "BottomLeft", () -> trace("bottomleft")))
			.setBottomRight(new FlxButton(0, 0, "BottomRight", () -> trace("bottomright")))
			.setTop(new FlxText(0, 0, 0, "Top", fontSize))
			.setBottom(new FlxText(0, 0, 0, "Bottom", fontSize))
			.setCenter(new FlxText(0, 0, 0, "Center", fontSize))
			.refreshPositions();
**/
class Panel extends FlxSpriteGroup {
	private var topLeft:FlxSprite;
	private var topLeftPadding:Float = 0.0;
	private var topRight:FlxSprite;
	private var topRightPadding:Float = 0.0;
	private var bottomRight:FlxSprite;
	private var bottomRightPadding:Float = 0.0;
	private var bottomLeft:FlxSprite;
	private var bottomLeftPadding:Float = 0.0;
	private var top:FlxSprite;
	private var topPadding:Float = 0.0;
	private var bottom:FlxSprite;
	private var bottomPadding:Float = 0.0;
	private var center:FlxSprite;
	private var background:FlxSprite;
	private var backgroundPadding:Float = 0.0;
	private var _width:Float = 0.0;
	private var _height:Float = 0.0;

	public function new(x:Float = 0.0, y:Float = 0.0, width:Float = 100.0, height:Float = 100.0) {
		super(x, y);
		setSize(width, height);
	}

	public override function setPosition(x:Float = 0.0, y:Float = 0.0):Void {
		super.setPosition(x, y);
	}

	public override function setSize(width:Float, height:Float):Void {
		_width = width;
		_height = height;
		super.setSize(width, height);
	}

	public function refreshPositions():Panel {
		var _x:Float = x;
		var _y:Float = y;
		if (background != null) {
			background.x = _x;
			background.y = _y;
			background.setGraphicSize(Std.int(_width), Std.int(_height));
			background.updateHitbox();
		}
		if (center != null) {
			center.x = _x + _width / 2.0 - center.width / 2.0;
			center.y = _y + _height / 2.0 - center.height / 2.0;
		}
		if (top != null) {
			top.x = _x + _width / 2.0 - top.width / 2.0;
			top.y = _y + backgroundPadding + topPadding;
		}
		if (topLeft != null) {
			topLeft.x = _x + backgroundPadding + topLeftPadding;
			topLeft.y = _y + backgroundPadding + topLeftPadding + topPadding;
		}
		if (topRight != null) {
			topRight.x = _x + _width - topRight.width - backgroundPadding - topRightPadding;
			topRight.y = _y + backgroundPadding + topRightPadding + topPadding;
		}
		if (bottom != null) {
			bottom.x = _x + _width / 2.0 - bottom.width / 2.0;
			bottom.y = _y + _height - bottom.height - backgroundPadding - bottomPadding;
		}
		if (bottomLeft != null) {
			bottomLeft.x = _x + backgroundPadding + bottomLeftPadding;
			bottomLeft.y = _y + _height - bottomLeft.height - backgroundPadding - bottomLeftPadding - bottomPadding;
		}
		if (bottomRight != null) {
			bottomRight.x = _x + _width - bottomRight.width - backgroundPadding - bottomRightPadding;
			bottomRight.y = _y + _height - bottomRight.height - backgroundPadding - bottomRightPadding - bottomPadding;
		}
		return this;
	}

	public function setBackground(spr:FlxSprite, padding:Float = 0.0):Panel {
		if (background != null) {
			remove(background);
		}
		background = spr;
		if (background != null) {
			insert(0, background);
		}
		backgroundPadding = padding;
		return this;
	}

	public function setTopLeft(spr:FlxSprite, padding:Float = 0.0):Panel {
		if (topLeft != null) {
			remove(topLeft);
		}
		topLeft = spr;
		add(topLeft);
		topLeftPadding = padding;
		return this;
	}

	public function setTopRight(spr:FlxSprite, padding:Float = 0.0):Panel {
		if (topRight != null) {
			remove(topRight);
		}
		topRight = spr;
		add(topRight);
		topRightPadding = padding;
		return this;
	}

	public function setBottomLeft(spr:FlxSprite, padding:Float = 0.0):Panel {
		if (bottomLeft != null) {
			remove(bottomLeft);
		}
		bottomLeft = spr;
		add(bottomLeft);
		bottomLeftPadding = padding;
		return this;
	}

	public function setBottomRight(spr:FlxSprite, padding:Float = 0.0):Panel {
		if (bottomRight != null) {
			remove(bottomRight);
		}
		bottomRight = spr;
		add(bottomRight);
		bottomRightPadding = padding;
		return this;
	}

	public function setTop(spr:FlxSprite, padding:Float = 0.0):Panel {
		if (top != null) {
			remove(top);
		}
		top = spr;
		add(top);
		topPadding = padding;
		return this;
	}

	public function setBottom(spr:FlxSprite, padding:Float = 0.0):Panel {
		if (bottom != null) {
			remove(bottom);
		}
		bottom = spr;
		add(bottom);
		bottomPadding = padding;
		return this;
	}

	public function setCenter(spr:FlxSprite):Panel {
		if (center != null) {
			remove(center);
		}
		center = spr;
		add(center);
		return this;
	}
}
