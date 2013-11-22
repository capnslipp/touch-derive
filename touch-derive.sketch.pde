InputSpot spotD0; // position
DerivedSpot spotD1; // velocity (D1 of position)
DerivedSpot spotD2; // acceleration (D1 of velocity, D2 of position)
DerivedSpot spotD3; // delta-acceleration (D1 of acceleration, D3 of position)
DerivedSpot spotD4; // delta-delta-acceleration (D1 of delta-acceleration, D4 of position)

Object _debugInstance = null;
Object _debugInstance2 = null;
boolean _debugOn = false;

void setup() {
	size(window.innerWidth, window.innerHeight);
	
	frameRate(30);
	noLoop();
	
	colorMode(HSB, 360, 1.0, 1.0, 1.0);
	background(0.0);
	
	spotD0 = new InputSpot(210, 50);
	spotD1 = new DerivedSpot(spotD0, 55, 45);
	_debugInstance2 = spotD2 = new DerivedSpot(spotD1, 345, 40);
	//spotD3 = new DerivedSpot(spotD2, 270, 35);
	//spotD4 = new DerivedSpot(spotD3, 330, 30);
}

void draw() {
	if (mousePressed) {
		spotD0.setPos(mouseX, mouseY);
	}
	
	background(0.0);
	
	spotD0.draw();
	spotD1.draw();
	spotD2.draw();
	//spotD3.draw();
	//spotD4.draw();
}

void mouseDragged() {
	redraw();
}
