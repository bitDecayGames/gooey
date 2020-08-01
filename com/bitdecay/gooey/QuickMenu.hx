package com.bitdecay.gooey;

import flixel.FlxBasic;
import flixel.FlxSprite;
import flixel.addons.ui.FlxUI9SliceSprite;
import flixel.addons.ui.FlxUIButton;
import flixel.addons.ui.FlxUISpriteButton;
import flixel.addons.ui.FlxUIText;
import flixel.addons.ui.interfaces.IFlxUIWidget;
import flixel.group.FlxSpriteGroup;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.ui.FlxButton;
import flixel.util.FlxColor;

class QuickMenu extends FlxSpriteGroup {
	public var options:QuickMenuOptions;

	/**
		A simple quick menu object that will generate buttons based on the items passed in.  Each item can be configured differently.

		@param x The starting x position of this quick menu
		@param y The starting y position of this quick menu
		@param items The array of QuickMenuItems that will populate this menu
		@param options Options that you can pass to the quick menu to change the layout
	 */
	public function new(x:Float, y:Float, items:Array<QuickMenuItem>, ?options:QuickMenuOptions) {
		super(x, y);
		if (options == null) {
			options = new QuickMenuOptions();
		}
		this.options = options;
		for (i in 0...items.length) {
			var item = items[i];
			var asset:FlxGraphicAsset = item.asset != null ? item.asset : options.asset;
			var width:Int = item.width != null ? item.width : options.width;
			var height:Int = item.height != null ? item.height : options.height;
			var frameWidth:Int = item.frameWidth != null ? item.frameWidth : options.frameWidth;
			var frameHeight:Int = item.frameHeight != null ? item.frameHeight : options.frameHeight;
			var ninePatch:Array<Int> = item.ninePatch != null ? item.ninePatch : options.ninePatch;
			var btn:FlxUIButton;
			if (asset != null) {
				btn = new FlxUIButton(0, 0, item.name, item.onSelect, false, false, item.color);
				if (ninePatch != null) {
					btn.loadGraphicSlice9([asset], width, height, [ninePatch], FlxUI9SliceSprite.TILE_NONE, -1, false, frameWidth, frameHeight);
				} else {
					// you might be thinking it doesn't make sense to use this 9slice method
					// but you'd be wrong.  In order to be able to resize this graphic, it needs
					// to be a 9slice or else the graphic gets reset to the default button
					// graphic.  So, to get around this, we create a dummy 9slice that will stretch
					// in all directions (effectively canceling the 9slice mechanic).
					btn.loadGraphicSlice9([asset], width, height, [[0, 0, frameWidth, frameHeight]], FlxUI9SliceSprite.TILE_NONE, -1, false, frameWidth,
						frameHeight);
				}

				btn.autoCenterLabel();
			} else {
				btn = new FlxUIButton(0, 0, item.name, item.onSelect, true, false, item.color);
				btn.resize(width, height);
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

class QuickMenuItem {
	public var name:String;
	public var onSelect:Void->Void;
	public var asset:FlxGraphicAsset;
	public var color:FlxColor;
	public var width:Null<Int>;
	public var height:Null<Int>;
	public var ninePatch:Array<Int>;
	public var frameWidth:Null<Int>;
	public var frameHeight:Null<Int>;

	/**
		One button item on a quick menu.

		@param name the name of the button as well as the label, use "" for custom sprite buttons
		@param onSelect the function to call when this button is pressed
		@param width the width of the button on the screen (overrides QuickMenuOptions.width)
		@param height the height of the button on the screen (overrides QuickMenuOptions.height)
		@param color tint this button by the given color, the default is white which is no tinting
		@param asset if this button has a sprite background, this is where you pass that sprite in. Button sprites are usually made of sprite sheets that are one frame wide by 3 frames tall which represent the up, hover, and down states (in that order)
		@param frameWidth required if asset is set, this is the width of each frame in the provided sprite sheet which will most of the time be equal to the asset.width (overrides QuickMenuOptions.frameWidth)
		@param frameHeight required if asset is set, this is the height of each frame in the provided sprite sheet which will most of the time be equal to the asset.height / 3 (overrides QuickMenuOptions.frameHeight)
		@param ninePatch (only applys if asset is set) this is the NinePatchData.data that corresponds to how this sprite must be sliced (overrides QuickMenuOptions.ninePatch).  Leave it null if this sprite should not be sliced and instead should be stretched like normal.
	**/
	public function new(name:String, onSelect:Void->Void, ?width:Int, ?height:Int, ?color:FlxColor, ?asset:flixel.system.FlxAssets.FlxGraphicAsset,
			?frameWidth:Int, ?frameHeight:Int, ?ninePatch:Array<Int>) {
		this.name = name;
		this.onSelect = onSelect;
		this.width = width;
		this.height = height;
		this.color = color;
		this.asset = asset;
		this.frameWidth = frameWidth;
		this.frameHeight = frameHeight;
		this.ninePatch = ninePatch;
	}
}

class QuickMenuOptions {
	public var width:Int;
	public var height:Int;
	public var padding:Float;
	public var mainAxisAlignment:AxisAlignment;
	public var crossAxisAlignment:AxisAlignment;
	public var asset:FlxGraphicAsset;
	public var frameWidth:Null<Int>;
	public var frameHeight:Null<Int>;
	public var ninePatch:Array<Int>;

	/**
		Layout options for a quick menu object

		@param width the default width for buttons in this menu, can be overriden by QuickMenuItem.width
		@param height the default height for buttons in this menu, can be overriden by QuickMenuItem.height
		@param padding the spacing between each element in the menu
		@param mainAxisAlignment determines where the buttons will align in the up/down direction
		@param crossAxisAlignment determines where the buttons will align in the left/right direction
		@param asset the default asset to use for buttons in this menu, can be overriden by QuickMenuItem.asset
		@param frameWidth required if asset is set, this is the width of each frame in the provided sprite sheet which will most of the time be equal to the asset.width (overrides QuickMenuOptions.frameWidth)
		@param frameHeight required if asset is set, this is the height of each frame in the provided sprite sheet which will most of the time be equal to the asset.height / 3 (overrides QuickMenuOptions.frameHeight)
		@param ninePatch (only applys if QuickMenuItem.asset is set) this is the NinePatchData.data that corresponds to how all of the sprites must be sliced (can be overriden by QuickMenuItem.ninePatch).  Leave it null if these sprites should not be sliced and instead should be stretched like normal.
	**/
	public function new(width:Int = 80, height:Int = 20, padding:Float = 10.0, mainAxisAlignment:AxisAlignment = AxisAlignment.START,
			crossAxisAlignment:AxisAlignment = AxisAlignment.CENTER, ?asset:FlxGraphicAsset, ?frameWidth:Int, ?frameHeight:Int, ?ninePatch:Array<Int>) {
		this.width = width;
		this.height = height;
		this.padding = padding;
		this.mainAxisAlignment = mainAxisAlignment;
		this.crossAxisAlignment = crossAxisAlignment;
		this.asset = asset;
		this.frameWidth = frameWidth;
		this.frameHeight = frameHeight;
		this.ninePatch = ninePatch;
	}
}
