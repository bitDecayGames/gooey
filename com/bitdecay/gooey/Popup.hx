package com.bitdecay.gooey;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.FlxSubState;
import flixel.addons.ui.FlxUIButton;
import flixel.addons.ui.FlxUIGroup;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.ui.FlxSpriteButton;

typedef PopupTweenBuilder = FlxSprite->Bool->FlxTween;

class Popup {
	private static inline var DEFAULT_TWEEN_TIME = 0.2;
	private static inline var DEFAULT_BACKER_ALPHA = 0.53125;

	private var _subState:FlxSubState;
	private var _backer:FlxUIButton;
	private var _isOpen:Bool = false;
	private var _content:FlxSprite;
	private var _tween:PopupTweenBuilder;

	public function new(content:FlxSprite, ?tween:PopupTweenBuilder) {
		_content = content;
		_tween = tween;
		if (_tween == null) {
			_tween = defaultTweenBuilder;
		}
	}

	private static function defaultTweenBuilder(obj:FlxSprite, isOpen:Bool):FlxTween {
		return FlxTween.tween(obj, {alpha: 1 - obj.alpha}, DEFAULT_TWEEN_TIME, {ease: FlxEase.linear, type: FlxTweenType.ONESHOT});
	}

	private function tweenBacker(duration:Float) {
		FlxTween.tween(_backer, {alpha: DEFAULT_BACKER_ALPHA - _backer.alpha}, duration, {ease: FlxEase.linear, type: FlxTweenType.ONESHOT});
	}

	private function create() {
		_subState = new FlxSubState();
		_backer = new FlxUIButton(-20, -20, null, this.close, false, false);
		_backer.makeGraphic(2, 2, 0x88000000);
		_backer.setGraphicSize(FlxG.width + 40, FlxG.height + 40);
		_backer.updateHitbox();
		_backer.alpha = 0;
		_subState.add(_backer);
		_subState.add(_content);
	}

	private function clear() {
		_subState = null;
		_backer = null;
	}

	public function isOpen():Bool {
		return _isOpen;
	}

	public function open() {
		if (!_isOpen) {
			create();
			FlxG.state.openSubState(_subState);
			if (_tween != null) {
				var myTween = _tween(_content, _isOpen);
				tweenBacker(myTween.duration);
			}
			_isOpen = true;
		}
	}

	public function close() {
		if (_isOpen) {
			if (_tween != null) {
				var myTween = _tween(_content, _isOpen);
				tweenBacker(myTween.duration);
				myTween.onComplete = (t) -> {
					_subState.remove(_content);
					_subState.close();
					clear();
				};
			} else {
				_subState.remove(_content);
				_subState.close();
				clear();
			}
			_isOpen = false;
		}
	}

	public static function fadeIn(content:FlxSprite):Popup {
		content.alpha = 0.0;
		return new Popup(content);
	}

	public static function slideUp(content:FlxSprite, duration:Float = DEFAULT_TWEEN_TIME, ?ease:EaseFunction):Popup {
		var originalY = content.y;
		content.y += FlxG.height;
		return new Popup(content, (obj, isOpen) -> {
			return FlxTween.tween(obj, {y: isOpen ? originalY + FlxG.height : originalY}, duration,
				{ease: ease != null ? ease : FlxEase.linear, type: FlxTweenType.ONESHOT});
		});
	}

	public static function slideDown(content:FlxSprite, duration:Float = DEFAULT_TWEEN_TIME, ?ease:EaseFunction):Popup {
		var originalY = content.y;
		content.y -= FlxG.height;
		return new Popup(content, (obj, isOpen) -> {
			return FlxTween.tween(obj, {y: isOpen ? originalY - FlxG.height : originalY}, duration,
				{ease: ease != null ? ease : FlxEase.linear, type: FlxTweenType.ONESHOT});
		});
	}

	public static function slideFromRight(content:FlxSprite, duration:Float = DEFAULT_TWEEN_TIME, ?ease:EaseFunction):Popup {
		var originalX = content.x;
		content.x += FlxG.width;
		return new Popup(content, (obj, isOpen) -> {
			return FlxTween.tween(obj, {x: isOpen ? originalX + FlxG.width : originalX}, duration,
				{ease: ease != null ? ease : FlxEase.linear, type: FlxTweenType.ONESHOT});
		});
	}

	public static function slideFromLeft(content:FlxSprite, duration:Float = DEFAULT_TWEEN_TIME, ?ease:EaseFunction):Popup {
		var originalX = content.x;
		content.x -= FlxG.width;
		return new Popup(content, (obj, isOpen) -> {
			return FlxTween.tween(obj, {x: isOpen ? originalX - FlxG.width : originalX}, duration,
				{ease: ease != null ? ease : FlxEase.linear, type: FlxTweenType.ONESHOT});
		});
	}
}
