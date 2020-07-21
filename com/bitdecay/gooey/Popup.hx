package com.bitdecay.gooey;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.ui.FlxUIGroup;

class Popup {
	public static function slideUp(content:FlxSprite) {
		var grp = new FlxUIGroup();
		grp.add(content);

		FlxG.state.add(grp);
	}
}
