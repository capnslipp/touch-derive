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
