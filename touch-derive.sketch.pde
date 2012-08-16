InputSpot spotD0;
//DerivedSpot spotD1, spotD2;

void setup() {
	size(window.innerWidth, window.innerHeight);
	
	frameRate(30);
	
	colorMode(HSB, 360, 1.0, 1.0, 1.0);
	background(0.0);
	
	spotD0 = new InputSpot(210);
	//spotD1 = new Spot(30);
	//spotD2 = new Spot(120);
}

void draw() {
	if (mousePressed) {
		spotD0.setPos(mouseX, mouseY);
		//spotD1.derivePosFromSpot(spotD0);
	}
	
	background(0.0);
	
	spotD0.draw();
	//spotD1.draw();
	//spotD2.draw();
}
