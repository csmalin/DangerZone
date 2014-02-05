$("#slider").rangeSlider({
		range: {min: 60, max: false },
		bounds: {min: 0, max: 1439},
		step: 1,
		formatter:function(val){
			var hour = (val/60 < 1) ? 12 : Math.floor(val/60)
			var meridiem = hour < 13 ? "AM" : "PM"
			var minutes = val % 60
			var time = ((hour > 12 ) ? hour - 12 : hour) + ":" + ((minutes < 10) ? (minutes + "0") : minutes) + " " + meridiem
			return time
	}
});


$("#slider").bind("valuesChanging", function(e, data){
  console.log("Max:" + data.values.max);
	console.log("Min: " + data.values.min);
});