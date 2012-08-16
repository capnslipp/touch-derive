class DerivedSpot extends SpotBase
{
	
	
	void derivePosFromSpot(Spot integralSpot) {
		this.x[0] = integralSpot.getXAt(0);
		this.y[0] = integralSpot.getYAt(0);
	}
}
