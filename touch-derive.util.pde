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
