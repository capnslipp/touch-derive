class DerivedSpot extends SpotBase
{
	SpotBase integralSpot;
	
	int debug_lowestAskedPast = 0;
	
	
	DerivedSpot(SpotBase integralSpot, int hue, int diameter) {
		super(hue, diameter);
		
		this.integralSpot = integralSpot;
	}
	
	protected int deltaIntegralX(int frontTimeStep) {
		int iZero = this.integralSpot.getXAt(frontTimeStep);
		int iNegOne = this.integralSpot.getXAt(frontTimeStep - 1);
		//if (_debugInstance2 == this && _debugOn)
		//	println("_debugInstance2: deltaIntegralX("+frontTimeStep+")::"+"\t"+"iZero: "+iZero+", "+"iNegOne: "+iNegOne);
		if (iZero == null || iNegOne == null)
			return null;
		
		return (iZero - iNegOne);
	}
	
	protected int deltaIntegralY(int frontTimeStep) {
		int iZero = this.integralSpot.getYAt(frontTimeStep);
		int iNegOne = this.integralSpot.getYAt(frontTimeStep - 1);
		//if (_debugInstance == this && _debugOn)
		//	println("_debugInstance: deltaIntegralY("+frontTimeStep+")::"+"\t"+"iZero: "+iZero+", "+"iNegOne: "+iNegOne);
		if (iZero == null || iNegOne == null)
			return null;
		
		return (iZero - iNegOne);
	}
	
	int predictDeltaForTimeStep(int timeStep) {
		int predictDelta = deltaIntegralX(0);
		
		return predictDelta;
	}
	
	int getInvariantXAt(int relativeTimeStep) {
	}
	
	int getInvariantYAt(int relativeTimeStep) {
	}
	
	int getXAt(int relativeTimeStep) {
		if (relativeTimeStep == 0) {
			int integralVal = this.integralSpot.getXAt(0);
			//if (_debugInstance == this && _debugOn)
			//	println("_debugInstance: getXAt("+relativeTimeStep+")::\t" + "integralVal: "+integralVal);
			
			return integralVal;
		}
		else if (relativeTimeStep > 0) {
			int integralVal = this.integralSpot.getXAt(0);
			int predictDelta = deltaIntegralX(0);
			//if (_debugInstance2 == this && _debugOn)
			//	println("_debugInstance2: getXAt("+relativeTimeStep+")::\t" + "integralVal: "+integralVal+", predictDelta:"+predictDelta);
			if (integralVal == null || predictDelta == null)
				return null;
			
			int x = integralVal;
			for (int tsI = 0; tsI < relativeTimeStep; ++tsI)
				x += predictDeltaForTimeStep(relativeTimeStep);
			
			return x;
		}
		else if (relativeTimeStep < 0) {
			if (relativeTimeStep < this.debug_lowestAskedPast)
				this.debug_lowestAskedPast = relativeTimeStep;
			
			int integralVal = this.integralSpot.getXAt(relativeTimeStep - 1);
			int pastDelta = deltaIntegralX(relativeTimeStep);
			//if (_debugInstance == this && _debugOn)
			//	println("_debugInstance: getXAt("+relativeTimeStep+")::\t" + "integralVal: "+integralVal+", pastDelta:"+pastDelta+"\treturning: "+(integralVal + pastDelta));
			if (integralVal == null || pastDelta == null)
				return null;
			
			return integralVal + pastDelta;
		}
	}
	
	int getYAt(int relativeTimeStep) {
		if (relativeTimeStep == 0) {
			//if (_debugInstance == this && _debugOn)
			//	println("getYAt("+relativeTimeStep+")::\t" + "this.integralSpot.getYAt(0): "+this.integralSpot.getYAt(0));
			
			return this.integralSpot.getYAt(0);
		}
		else if (relativeTimeStep > 0) {
			int integralVal = this.integralSpot.getYAt(0);
			int predictDelta = deltaIntegralY(0);
			//if (_debugInstance == this && _debugOn)
			//	println("getYAt("+relativeTimeStep+")::\t" + "integralVal: "+integralVal+", predictDelta:"+predictDelta);
			if (integralVal == null || predictDelta == null)
				return null;
			
			return integralVal + (predictDelta * relativeTimeStep);
		}
		else if (relativeTimeStep < 0) {
			if (relativeTimeStep < this.debug_lowestAskedPast)
				this.debug_lowestAskedPast = relativeTimeStep;
			
			int integralVal = this.integralSpot.getYAt(relativeTimeStep - 1);
			int pastDelta = deltaIntegralY(relativeTimeStep);
			//if (_debugInstance == this && _debugOn)
			//	println("getYAt("+relativeTimeStep+")::\t" + "integralVal: "+integralVal+", pastDelta:"+pastDelta+"\treturning: "+(integralVal + pastDelta));
			if (integralVal == null || pastDelta == null)
				return null;
			
			return integralVal + pastDelta;
		}
	}
	
	void draw() {
		int pastTimeSteps = -(this.debug_lowestAskedPast);
		for (int timeStepI = -1; timeStepI >= -(pastTimeSteps); --timeStepI) {
			float alpha = lerp(1.0, 0.0, timeStepI / -(pastTimeSteps + 1));
			drawPast(timeStepI, alpha);
		}
		
		drawCurrent();
		
		int predictionTimeSteps = 10;
		for (int timeStepI = 1; timeStepI <= predictionTimeSteps; ++timeStepI) {
			float alpha = lerp(1.0, 0.0, timeStepI / predictionTimeSteps);
			drawPrediction(timeStepI, alpha);
		}
	}
	
	protected void drawPast(int relativeTimeStep, float alpha) {
		if (!(relativeTimeStep < 0))
			return;
		
		//if (_debugInstance == this && _debugOn)
		//	println("drawPast("+relativeTimeStep+", "+alpha+")");
		
		int centerX = getXAt(relativeTimeStep);
		int centerY = getYAt(relativeTimeStep);
		if (centerX == null || centerY == null)
			return;
		
		drawCircleWith(centerX, centerY, alpha, true, false);
	}
	
	protected void drawCurrent() {
		//if (_debugInstance == this && _debugOn)
		//	println("drawCurrent()");
		
		int centerX = getXAt(0);
		int centerY = getYAt(0);
		if (centerX == null || centerY == null)
			return;
		
		drawCircleWith(centerX, centerY, 1.0, true, true);
	}
	
	protected void drawPrediction(int relativeTimeStep, float alpha) {
		if (!(relativeTimeStep > 0))
			return;
		
		//if (_debugInstance2 == this) {
		//	_debugOn = true;
		//	println("\n");
		//}
		
		//if (_debugInstance2 == this && _debugOn)
		//	println("_debugInstance2: drawPrediction("+relativeTimeStep+", "+alpha+")");
		
		int centerX = getXAt(relativeTimeStep);
		int centerY = getYAt(relativeTimeStep);
		if (centerX == null || centerY == null)
			return;
		
		//if (_debugInstance2 == this)
		//	_debugOn = false;
		
		drawCircleWith(centerX, centerY, alpha, false, true);
	}
}
