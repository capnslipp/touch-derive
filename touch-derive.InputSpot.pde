class InputSpot extends SpotBase
{
	// 0 is front/most-recent, 9 is back/least-recent
	protected int[] x = new int[10];
	protected int[] y = new int[10];
	protected int historyLength = 0;
	
	
	InputSpot(int hue, int diameter) {
		super(hue, diameter);
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
		
		for (int timeStepI = 0; timeStepI > -10; --timeStepI) {
			drawHistory(timeStepI);
		}
	}
	
	void drawHistory(int relativeTimeStep) {
		if (relativeTimeStep > 0)
			return;
		if (!(relativeTimeStep > -(this.historyLength)))
			return;
		
		int centerX = getXAt(relativeTimeStep);
		int centerY = getYAt(relativeTimeStep);
		float alpha = lerp(1.0, 0.0, relativeTimeStep / -10);
		
		boolean isCurrent = (relativeTimeStep == 0);
		drawCircleWith(centerX, centerY, alpha, true, isCurrent);
	}
}
