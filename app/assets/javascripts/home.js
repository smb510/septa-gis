var reloadPoints = function(e) {
		if (window.superSpecialData !== undefined) {
			var map = window.superSpecialMap;
			//remove the markers
			window.currentMarkers.forEach(function(o, i, a) {
				map.removeLayer(o);
			});
			window.currentMarkers = [];
			//add the new ones.
			var bounds = window.superSpecialMap.getBounds();
			window.superSpecialData.forEach(function(obj, index, array) {
				if (obj.arrest !== true && obj.YCoord !== null && obj.XCoord !== null && bounds.contains(new L.LatLng(obj.YCoord, obj.XCoord))) {
					var marker = L.marker([obj.YCoord, obj.XCoord]);
					marker.addTo(window.superSpecialMap);
					window.currentMarkers.push(marker);
				}

			});
		}
	}


var getFoursquare = function(e)
{
	var map = window.superSpecialMap;
	
	$.ajax({
		url : "https://api.foursquare.com/v2/venues/search",
	});
	
	
	
}

$(document).ready(function() {	
	var map = L.map("map_canvas").setView([39.95, -75.2], 9)
	L.tileLayer('http://{s}.tile.cloudmade.com/72C96B4D077B45E7BDCF70917FE311DB/997/256/{z}/{x}/{y}.png', {
		attribution: 'Map data &copy; OpenStreetMap',
		maxZoom: 18
	}).addTo(map);
	
	

	//map.on('move', reloadPoints);
	//map.on('zoom', reloadPoints);
	window.superSpecialMap = map;
	window.currentMarkers = [];
	//add the incident points
	$.ajax({
		url: "/incidents",
		context: map
	}).success(function(d, t, j) {
		console.log(d);
		window.superSpecialData = d;
		var bounds = window.superSpecialMap.getBounds();
		var merkers = new L.MarkerClusterGroup();
		d.forEach(function(obj, index, array) {
			if (obj.arrest !== true && obj.YCoord !== null && obj.XCoord !== null && bounds.contains(new L.LatLng(obj.YCoord, obj.XCoord))) {
				labelString = 
				
				var marker = L.marker([obj.YCoord, obj.XCoord]).bindLabel(obj.date + " at " + obj.time);
				merkers.addLayer(marker);
				window.currentMarkers.push(marker);
			}
		});
		window.superSpecialMap.addLayer(merkers);
		$("#layers").html(window.superSpecialMap.layers)
	});

	// add the rail lines
	$.getScript("lines.json", function() {
		var astyle = {
			"color": "#990000",
			"weight": 2,
			"opacity": 1
		}

		var layer = L.geoJson(lines, {
			style: astyle
		}).addTo(window.superSpecialMap);
	});


});
