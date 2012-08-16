class Spot
{
	// 0 is front/most-recent, 9 is back/least-recent
	int[] x = new int[10];
	int[] y = new int[10];
	int historyLength = 0;
	
	color centerColor;
	color outlineColor;
	
	
	Spot(int hue) {
		this.centerColor = color(hue, 1.0, 1.0, 0.5);
		this.outlineColor = color(hue, 0.9, 1.0, 0.5);
	}
	
	int indexFromRelativeTimeStep(int relativeTimeStep) {
		if (relativeTimeStep > 0 || relativeTimeStep <= -10)
			return null;
		
		return (-relativeTimeStep);
	}
	
	int getXAt(int relativeTimeStep) {
		int index = indexFromRelativeTimeStep(relativeTimeStep);
		return this.x[index];
	}
	
	int getYAt(int relativeTimeStep) {
		int index = indexFromRelativeTimeStep(relativeTimeStep);
		return this.y[index];
	}
	
	void pushHistoryPos(newX, newY) {
		for (int i = (this.historyLength - 1); i >= 0; --i) {
			this.x[i + 1] = this.x[i];
			this.y[i + 1] = this.y[i];
		}
		
		this.x[0] = newX;
		this.y[0] = newY;
		
		if (this.historyLength < 10)
			this.historyLength += 1;
	}
	
	void setPos(newX, newY) {
		pushHistoryPos(newX, newY);
	}
	
	void derivePosFromSpot(Spot integralSpot) {
		this.x[0] = integralSpot.getXAt(0);
		this.y[0] = integralSpot.getYAt(0);
	}
	
	void draw() {
		if (!(this.historyLength > 0))
			return;
		
		for (int timeStepI = 0; timeStepI > -(this.historyLength); --timeStepI) {
			drawHistorySlice(timeStepI);
		}
	}
	
	void drawHistorySlice(int relativeTimeStep) {
		if (relativeTimeStep > 0 || relativeTimeStep <= -10)
			return;
		
		float alpha = lerp(1.0, 0.0, relativeTimeStep / -10);
		drawCircleWith(
			this.getXAt(relativeTimeStep),
			this.getYAt(relativeTimeStep),
			alpha
		);
	}
	
	void drawCircleWith(centerX, centerY, alpha) {
		color fillColor = color(
			hue(this.centerColor),
			saturation(this.centerColor),
			brightness(this.centerColor),
			alpha
		);
		fill(fillColor);
		
		color strokeColor = color(
			hue(this.outlineColor),
			saturation(this.outlineColor),
			brightness(this.outlineColor),
			alpha
		);
		stroke(strokeColor);
		strokeWeight(2.0);
		
		ellipseMode(CENTER);
		ellipse(centerX, centerY, 50, 50);
	}
}


Spot spotD0, spotD1, spotD2;

void setup() {
	size(window.innerWidth, window.innerHeight);
	
	frameRate(30);
	
	colorMode(HSB, 360, 1.0, 1.0, 1.0);
	background(0.0);
	
	spotD0 = new Spot(210);
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
