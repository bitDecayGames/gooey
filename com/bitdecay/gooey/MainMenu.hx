package com.bitdecay.gooey;

import flixel.FlxBasic;
import flixel.FlxSprite;
import flixel.addons.ui.FlxUIButton;
import flixel.addons.ui.FlxUISpriteButton;
import flixel.addons.ui.interfaces.IFlxUIWidget;
import flixel.group.FlxSpriteGroup;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.util.FlxColor;

class MainMenu extends FlxSpriteGroup {
	public var options:MainMenuOptions;

	/**
		A simple main menu object that will generate buttons based on the items passed in.  Each item can be configured differently.

		@param x The starting x position of this main menu
		@param y The starting y position of this main menu
		@param items The array of MainMenuItems that will populate this menu
		@param options Options that you can pass to the main menu to change the layout
	 */
	public function new(x:Float, y:Float, items:Array<MainMenuItem>, ?options:MainMenuOptions) {
		super(x, y);
		this.options = options;
		if (this.options == null) {
			this.options = new MainMenuOptions();
		}
		for (i in 0...items.length) {
			var item = items[i];
			var btn:FlxSprite;
			if (item.asset != null) {
				btn = new FlxUISpriteButton(0, 0, new FlxSprite(0, 0, item.asset), item.onSelect);
			} else {
				btn = new FlxUIButton(0, 0, item.name, item.onSelect, true, false, item.color);
			}
			add(btn);
		}
		align();
	}

	public function align() {
		var curY = y;
		if (options.mainAxisAlignment == AxisAlignment.CENTER) {
			var totalHeight = 0.0;
			for (member in members) {
				totalHeight += member.height;
			}
			totalHeight += (members.length - 1) * options.padding;

			curY = curY - totalHeight / 2.0;
		}
		for (i in 0...members.length) {
			var member = members[i];
			switch (options.crossAxisAlignment) {
				case AxisAlignment.START:
					member.x = x;
				case AxisAlignment.END:
					member.x = x - member.width;
				case AxisAlignment.CENTER:
					member.x = x - member.width / 2.0;
			}
			switch (options.mainAxisAlignment) {
				case AxisAlignment.CENTER:
					member.y = curY;
					curY += member.height + options.padding;
				case AxisAlignment.START:
					member.y = curY;
					curY += member.height + options.padding;
				case AxisAlignment.END:
					member.y = curY - member.height;
					curY -= member.height + options.padding;
			}
		}
	}
}

class MainMenuItem {
	public var name:String;
	public var onSelect:Void->Void;
	public var asset:FlxGraphicAsset;
	public var color:FlxColor;

	/**
		One button item on a main menu.

		@param name the name of the button as well as the label, use "" for custom sprite buttons
		@param onSelect the function to call when this button is pressed
		@param asset if this button has a sprite background, this is where you pass that sprite in
		@param color if you are not using a sprite background, you can change the button's background color
	**/
	public function new(name:String, onSelect:Void->Void, ?asset:flixel.system.FlxAssets.FlxGraphicAsset, ?color:FlxColor) {
		this.name = name;
		this.onSelect = onSelect;
		this.asset = asset;
		this.color = color;
	}
}

class MainMenuOptions {
	public var padding:Float;
	public var mainAxisAlignment:AxisAlignment;
	public var crossAxisAlignment:AxisAlignment;

	/**
		Layout options for a main menu object

		@param padding the spacing between each element in the menu
		@param mainAxisAlignment determines where the buttons will align in the up/down direction
		@param crossAxisAlignment determines where the buttons will align in the left/right direction
	**/
	public function new(?padding:Float = 10.0, ?mainAxisAlignment:AxisAlignment = AxisAlignment.START,
			?crossAxisAlignment:AxisAlignment = AxisAlignment.CENTER) {
		this.padding = padding;
		this.mainAxisAlignment = mainAxisAlignment;
		this.crossAxisAlignment = crossAxisAlignment;
	}
}
