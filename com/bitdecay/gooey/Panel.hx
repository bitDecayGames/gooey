package com.bitdecay.gooey;

import flixel.group.FlxSpriteGroup;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.util.FlxColor;

class Panel extends FlxSpriteGroup {
	private topLeft:FlxSprite;
	private topRight:FlxSprite;
	private bottomRight:FlxSprite;
	private bottomLeft:FlxSprite;
	public function new(x:Float = 0.0, y:Float = 0.0, ?ninePatch:FlxGraphicAsset, ?color:FlxColor) {
		super(x, y);
	}

	public function setTopLeft(spr:FlxSprite):Panel {
		if (topLeft != null) {
			remove(topLeft);
		}
		topLeft = spr;
		return this;
	}

	public function setTopRight(spr:FlxSprite):Panel {
		if (topRight != null) {
			remove(topRight);
		}
		topRight = spr;
		return this;
	}

	public function setBottomLeft(spr:FlxSprite):Panel {
		if (bottomLeft != null) {
			remove(bottomLeft);
		}
		bottomLeft = spr;
		return this;
	}

	public function setBottomRight(spr:FlxSprite):Panel {
		if (bottomRight != null) {
			remove(bottomRight);
		}
		bottomRight = spr;
		return this;
	}
}
