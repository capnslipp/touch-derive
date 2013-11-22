abstract class SpotBase
{
	color centerColor;
	color outlineColor;
	
	int diameter;
	
	
	SpotBase(int hue, int diameter) {
		this.centerColor = color(hue, 1.0, 1.0, 0.5);
		this.outlineColor = color(hue, 0.9, 1.0, 0.5);
		
		this.diameter = diameter;
	}
	
	abstract int getInvariantXAt(int relativeTimeStep);
	abstract int getInvariantYAt(int relativeTimeStep);
	
	abstract int getXAt(int relativeTimeStep);
	abstract int getYAt(int relativeTimeStep);
		
	abstract void draw();
	
	void drawCircleWith(int centerX, int centerY, float alpha, boolean shouldDrawCenter, boolean shouldDrawOutline) {
		if (shouldDrawCenter) {
			color fillColor = color(
				hue(this.centerColor),
				saturation(this.centerColor),
				brightness(this.centerColor),
				alpha
			);
			fill(fillColor);
		} else {
			noFill();
		}
		
		if (shouldDrawOutline) {
			color strokeColor = color(
				hue(this.outlineColor),
				saturation(this.outlineColor),
				brightness(this.outlineColor),
				alpha
			);
			stroke(strokeColor);
			strokeWeight(2.0);
		} else {
			noStroke();
		}
		
		ellipseMode(CENTER);
		ellipse(centerX, centerY, this.diameter, this.diameter);
	}
}
