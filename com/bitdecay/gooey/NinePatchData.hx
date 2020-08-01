package com.bitdecay.gooey;

class NinePatchData {
	/**
		A quick and easy way to build 9patch data.  Keep in mind that these numbers are 0-based.  In other words, if you have a 10x10 sprite that has a 2 pixel boarder, your data will look like {left: 2, top: 2, right: 7, bottom: 7}.  So the right and bottom are not the number of pixels FROM the right or the bottom, but TO the right and the bottom.

		@param left aka: x1, this is the left side of the slice
		@param top aka: y1, this is the top side of the slice
		@param right aka: x2, this is the right side of the slice
		@param bottom aka: y2, this is the bottom side of the slice
	 */
	public static function data(left:Int, top:Int, right:Int, bottom:Int) {
		return [left, top, right, bottom];
	}
}
