package com.bitdecay.gooey;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.ui.FlxUIButton;
import flixel.addons.ui.FlxUIList;
import flixel.addons.ui.FlxUIState;
import flixel.addons.ui.interfaces.IFlxUIWidget;
import flixel.group.FlxSpriteGroup;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.util.FlxColor;

/**
	This class is meant to be overriden and given values for the level info
**/
class LevelSelectState extends FlxUIState {
	private var list:FlxUIList;
	private var options:Array<LevelSelectOption>;

	public function new(options:Array<LevelSelectOption>) {
		super();
		if (options == null || options.length == 0) {
			throw "Options cannot be null or empty";
		}
		this.options = options;
	}

	public override function create() {
		trace("Creating options");
		var opts = new Array<IFlxUIWidget>();
		for (option in options) {
			opts.push(buildOption(option));
			trace("Created option");
		}
		trace("Building list");
		list = new FlxUIList(0, 0, opts, FlxG.width, FlxG.height);
		trace("Adding list");
		add(list);
		trace("done");
	}

	/**
		You can use the default objects that are generated or override this method to build your own list items

		@param option the level select option to build
		@return a FlxSprite can be a FlxGroup or any number of things
	**/
	private function buildOption(option:LevelSelectOption):IFlxUIWidget {
		return new FlxUIButton(0, 0, option.label, () -> {
			trace("do nothing");
		});
	}
}

class LevelSelectOption {
	public var label:String;
	public var sprite:FlxSprite;
	public var onSelect:Void->Void;

	public function new(label:String, ?sprite:FlxSprite, ?onSelect:Void->Void) {
		this.label = label;
		this.sprite = sprite;
		this.onSelect = onSelect;
	}
}
