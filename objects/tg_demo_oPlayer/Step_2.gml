if (moveX != 0 || moveY != 0) {
	image_speed = inputSlow ? 0.3 : 1;
	
	if (moveX != 0) {
		image_xscale = sign(moveX);
	}
}
else {
	image_speed = 0;
	image_index = 0;
}

depth = -bbox_bottom;