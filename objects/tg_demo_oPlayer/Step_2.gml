if (moveX != 0 || moveY != 0) {
	image_speed = 1;
	
	if (moveX != 0) {
		image_xscale = sign(moveX);
	}
}
else {
	image_speed = 0;
}