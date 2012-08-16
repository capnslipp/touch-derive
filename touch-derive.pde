String colorInspect(color c) {
	String hsb = "H:"+hue(c)+"," +
		"S:"+saturation(c)+"," +
		"B:"+brightness(c);
	String rgb = "R:"+red(c)+"," +
		"G:"+green(c)+"," +
		"B:"+blue(c);
	String a = "A:"+alpha(c);
	return "{"+hsb+" / "+rgb+" / "+a+"}";
}


abstract class SpotBase
{
	color centerColor;
	color outlineColor;
	
	
	SpotBase(int hue) {
		this.centerColor = color(hue, 1.0, 1.0, 0.5);
		this.outlineColor = color(hue, 0.9, 1.0, 0.5);
	}
	
	abstract int getXAt(int relativeTimeStep);
	abstract int getYAt(int relativeTimeStep);
		
	abstract void draw();
	
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

class InputSpot extends SpotBase
{
	// 0 is front/most-recent, 9 is back/least-recent
	protected int[] x = new int[10];
	protected int[] y = new int[10];
	protected int historyLength = 0;
	
	
	InputSpot(int hue) {
		super(hue);
	}
	
	protected int indexFromRelativeTimeStep(int relativeTimeStep) {
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
	
	protected void pushHistoryPos(newX, newY) {
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
		
		int centerX = getXAt(relativeTimeStep);
		int centerY = getYAt(relativeTimeStep);
		float alpha = lerp(1.0, 0.0, relativeTimeStep / -10);
		
		drawCircleWith(centerX, centerY, alpha);
	}
}

//class DerivedSpot extends SpotBase
//{
//	
//	
//	void derivePosFromSpot(Spot integralSpot) {
//		this.x[0] = integralSpot.getXAt(0);
//		this.y[0] = integralSpot.getYAt(0);
//	}
//}


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
