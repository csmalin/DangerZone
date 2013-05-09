// App Objects
var app         = {};
app.cache       = {};
app.map         = {};
app.map.geo     = {};
app.map.layers  = {};
app.observer    = {};
app.view        = {};
app.crimes      = {};

// Default cache values
app.cache.crimeData       = [];
app.cache.googleData      = new google.maps.MVCArray([]);
app.cache.googleLocation  = new google.maps.LatLng(-122.437, 37.765);

// Default Map configs
app.map.container       = 'map';
app.map.currentLocation = {lng: -122.437, lat: 37.765};
app.map.options = {
  zoom:             18,
  center:           app.cache.googleLocation,
  disableDefaultUI: true,
  zoomControl:      true,
  mapTypeControlOptions: {
    mapTypeIds: [google.maps.MapTypeId.ROADMAP, 'styled_map']
  }
}

app.map.styles = [
{
  "featureType": "road.arterial",
  "elementType": "geometry.fill",
  "stylers": [
  {"hue":    "#aaff00"},
  {"color":  "#ffffff"},
  {"weight": 3}
  ]
},{
  "featureType": "road.arterial",
  "elementType": "geometry.stroke",
  "stylers": [
  {"color":  "#d2d2d0"},
  {"weight": 2}
  ]
},{
  "featureType": "road.arterial",
  "elementType": "labels.text.fill",
  "stylers": [
  {"color": "#ffffff"}
  ]
},{
  "featureType": "road.arterial",
  "elementType": "labels.text.stroke",
  "stylers": [
  {"color":  "#bcbbba"},
  {"weight": 1.9}
  ]
}
];


//Initialize Application
app.initialize = function() {
  app.map.initialize();
  app.observer.initialize();
}

//Initialize map
app.map.initialize = function() {
  var that = this;
  console.log("In initialize")
  that.createMap();
  that.geo.getLocation();
  that.layers.initialize();
}

//Initialize DOM listiners
app.observer.initialize = function() {
  var that = this;
  that.dropDown('div.layers', 'open');
  that.searchFormToggle('div.search img', 'open');
  that.searchLocationForm('form.location-search');
}

//////////////////////////////////////////////////////////////// Map
// Create google map
app.map.createMap = function(){
  var that               = this;
  that.styledMap         = new google.maps.StyledMapType(that.styles, {name: "Styled Map"});
  that.Map               = new google.maps.Map(document.getElementById(that.container), that.options);

  that.Map.mapTypes.set('styled_map', that.styledMap);
  that.Map.setMapTypeId('styled_map');
  console.log("In create map")
  that.setMarker('http://i.imgur.com/FOqzufV.png');
}

// Updata map layers data points
// Updata map layers data points
app.map.updateData = function(data){
  var that = this;
  var crimes = data;
  app.cache.crimeData.push(data);

  for (x in crimes) {
    if (crimes[x].threat_level == 2) {
      app.cache.googleData.push({location: new google.maps.LatLng(crimes[x].latitude, crimes[x].longitude), weight: 3});
    } else if (crimes[x].threat_level == 1){
      app.cache.googleData.push({location: new google.maps.LatLng(crimes[x].latitude, crimes[x].longitude), weight: 1});
    }
  }
}


app.crimes.getSafetyScore = function(date,data) {
  var sum_distance_threat = 0;
  var sum_time_threat =0;
  var sum_priority_threat = 0;
  var priority_count = 0;
  var time_count = 0;
  var distance_count= 0;
  var weights = {"1":50, "2":100};
  var minutes = (date.getHours()*60) + date.getMinutes();
  var crimes = data;
  for (x in crimes) {
    var crime = crimes[x];
    var distance = app.map.geo.CalcDistanceBetween(37.765,-122.437,parseFloat(crime.latitude),parseFloat(crime.longitude));
    
    if(distance >=0 && distance <= 0.5){
      //TODO add priorities
      var distance_threat_score = (-200*distance) + 100;
      sum_distance_threat += distance_threat_score;
      distance_count+=1;
    }
    
    var timeDiff = minutes - crime.time;
    if (timeDiff < 0 && timeDiff >= -60){
      //TODO add priorities
      var time_threat_score = (1.66666666666*timeDiff) + 100;
      sum_time_threat += time_threat_score;
      time_count += 1;

    }  else if (timeDiff >= 0  && timeDiff <= 60) {
     var time_threat_score = (-1.66666666666*timeDiff) + 100;
     sum_time_threat += time_threat_score;
     time_count += 1;
   } 

   if(weights[String(crime.threat_level)]){
    sum_priority_threat += weights[String(crime.threat_level)];
    priority_count += 1;
  }
}
var time_avg = 0;
var distance_avg =0;
var priority_avg = 0;
if(time_count > 0){
  time_avg = sum_time_threat/time_count;
}
if(distance_count > 0){
  distance_avg = sum_distance_threat/distance_count;
}
if(priority_count > 0){
  priority_avg = sum_priority_threat/priority_count;
}
var threat_score = (time_avg + distance_avg + priority_avg)/3;
console.log(threat_score);
return threat_score;
}

app.map.geo.CalcDistanceBetween = function(lat1,lon1,lat2,lon2){
  var p1 = new google.maps.LatLng(lat1,lon1);
  var p2 = new google.maps.LatLng(lat2,lon2);

  return this.calcDistance(p1,p2);
}

app.map.geo.calcDistance = function(p1,p2){
  return ((google.maps.geometry.spherical.computeDistanceBetween(p1, p2)).toFixed(2))/1000 *  0.621371;  
}
// Set a location marker on new map
app.map.setMarker = function(url) {
  var that        = this;
  console.log("In set marker")
  that.geoMarker  = new google.maps.Marker({
    position: app.cache.googleLocation,
    map:      that.Map,
    title:    'Your geolocation',
    icon:     url
  });
}

// app.map.setLegend = function() {
//   alert("I am here")
//   var that = this;
//   var legend = document.getElementById('legend');
//   map.controls[google.maps.ControlPosition.LEFT_BOTTOM].push(legend);
// }

app.map.setLocation = function(lat, lng) {
  var that = this;
  console.log("In setLocation")
  app.cache.googleLocation = new google.maps.LatLng(lat,lng);
  that.currentLocation.lat = lat;
  that.currentLocation.lng = lng;
}

app.map.updateLocation = function() {
  var that = this;
  that.Map.setCenter(app.cache.googleLocation);
  that.Map.setZoom(18);
  that.geoMarker.setPosition(app.cache.googleLocation);
  var maxDistance = 0.50;
  var minDistance = 0;
  var lat = app.cache.googleLocation.kb;
  var lng = app.cache.googleLocation.lb;
   // var lat = 37.765;
   //  var lng = -122.437;
   var date = new Date(); 
   $.getJSON('/crimes?max_distance='+maxDistance+'&min_distance='+minDistance+'&location='+lat+', '+lng, function(data) {
    var crimes = data
    var safety_score = app.crimes.getSafetyScore(date,crimes)
    if (maxDistance === 0.50 && minDistance === 0) {
      var safety_score = app.crimes.getSafetyScore(date,crimes)
      if(safety_score <= 10 && safety_score >= 0) {
        app.map.setMarker('http://i.imgur.com/5BydPNx.jpg')
    } else if (safety_score > 10 && safety_score <=30) { //yellow
      app.map.setMarker('http://i.imgur.com/5BydPNx.jpg')
    } else {
      app.map.setMarker('http://i.imgur.com/k6vIygX.jpg') //red
    }
  }
});
 }

// Map Layers
app.map.layers.initialize = function() {
  app.map.layers.createHeatMap();
  //app.map.layers.createPointMap();
}

// Heat map layer
app.map.layers.createHeatMap = function(){
  var that        = this;
  console.log('heat map');
  that.heatMap    = new google.maps.visualization.HeatmapLayer({ data: app.cache.googleData });
  console.log('heat map');
  console.log(that.heatMap);
  that.heatMap.setMap(app.map.Map);
  var gradient = [
  'rgba(255, 235, 10, 0)',
  'rgba(255, 235, 10, 1)',
  'rgba(255, 222, 10, 1)',
  'rgba(255, 177, 10, 1)',
  'rgba(255, 141, 10, 1)',
  'rgba(255, 96, 10, 1)',
  'rgba(255, 55, 10, 1)',
  'rgba(255, 39, 10, 1)'
  ];
  that.heatMap.setOptions({gradient: gradient, radius: 15, opacity: 0.9, maxIntensity: 80});
}
app.crimes.initialize = function() {
  console.log("crimes initalized");
  app.map.updateLocation();
  app.crimes.getData(0, 0.5, 0);
  app.map.createLayers();
}

//////////////////////////////////////////////////////////////// Geolocation
app.map.geo.getLocation = function() {
  var that = this;
  navigator.geolocation.requestCurrentPosition(that.successCallback, that.errorCallback, that.timeoutCallback, 5000);
}

app.map.geo.successCallback = function(pos) {
  var that = this;
  var lat = pos.coords.latitude;
  var lng = pos.coords.longitude;

  app.map.setLocation(lat, lng);
  app.map.updateLocation();
  app.crimes.getData(0, 0.5, 0);
}

app.map.geo.timeoutCallback = function(){
  app.view.formOpen();
  app.view.flash("Enter your location!", "warning");
  app.map.updateLocation();
  app.crimes.getData(0, 0.5, 0)
}

app.map.geo.errorCallback = function(error){
  app.map.updateLocation();
  app.crimes.getData(0, 0.5, 0);

  if(error.PERMISSION_DENIED){
    app.view.flash("Enable your Geo Location!", "alert");
  } else if(error.POSITION_UNAVAILABLE){
    app.view.flash("Enter a location!", "alert");
  } else if(error.TIMEOUT){
    app.view.flash("hmmm we timed out trying to find where you are hiding!", "alert");
  }
}

// Get geolocation from client
navigator.geolocation.requestCurrentPosition = function(successCB, errorCB, timeoutCB, timeoutThreshold){
  var successHandler = successCB;
  var errorHandler   = errorCB;
  var timeout        = timeoutThreshold || 4000;

  window.geolocationTimeoutHandler = function(){timeoutCB();}

  window['geolocationRequestTimeoutHandler'] = setTimeout('geolocationTimeoutHandler()', timeout);

  if (typeof(geolocationRequestTimeoutHandler) != 'undefined'){
    clearTimeout(window['geolocationRequestTimeoutHandler']);
  }

  navigator.geolocation.watchPosition(
    function(position){
      clearTimeout(window['geolocationRequestTimeoutHandler']);
      successHandler(position);
    },
    function(error){
      clearTimeout(window['geolocationRequestTimeoutHandler']);
      errorHandler(error);
    },{enableHighAccuracy: true});
};

//////////////////////////////////////////////////////////////// Crime Data
// Data radius chunks
app.crimes.range = [{ min: 0   ,max: 0.50 },
{ min: 0.5 ,max: 1   },
{ min: 1   ,max: 1.5 },
{ min: 1.5 ,max: 2   },
{ min: 2   ,max: 2.5 },
{ min: 2.5 ,max: 3   },
{ min: 3   ,max: 3.5 },
{ min: 3.5 ,max: 4   },
{ min: 4   ,max: 4.5 },
{ min: 4.5 ,max: 5   },
{ min: 5   ,max: 5.5 },
{ min: 5.5 ,max: 6   },
{ min: 6   ,max: 6.5 },
{ min: 6.5 ,max: 7   },
{ min: 7   ,max: 7.5 }];

// Get data from server
app.crimes.getData = function(minDistance, maxDistance, counter) {
  var that    = this;
  var lat     = app.map.currentLocation.lat;
  var lng     = app.map.currentLocation.lng;
    // var lat = 37.765;
    // var lng = -122.437;
    $.getJSON('/crimes?max_distance='+maxDistance+'&min_distance='+minDistance+'&location='+lat+', '+lng, function(data) {
      console.log(maxDistance)
      console.log(minDistance)
      console.log("data recieved");
      var date = new Date();
      console.log(date)
      var crimes = data;
      if (maxDistance === 0.50 && minDistance === 0) {
        var safety_score = app.crimes.getSafetyScore(date,crimes)
        if(safety_score <= 10 && safety_score >= 0) {
          app.map.setMarker('http://i.imgur.com/5BydPNx.jpg')
    } else if (safety_score > 10 && safety_score <=30) { //yellow
      app.map.setMarker('http://i.imgur.com/FOqzufV.png')
    } else {
      app.map.setMarker('http://i.imgur.com/k6vIygX.jpg') //red
    }
  }
  console.log(app.map.geoMarker.icon);
  console.log(counter);

  if (counter <= (that.range.length - 1)) {
    that.getData(that.range[counter].min, that.range[counter].max, (counter+1));
    app.map.updateData(data);
  }
});
  }

//////////////////////////////////////////////////////////////// DOM Observers
// Dropdown click handler
app.observer.dropDown = function(target, cssClass){
  $(target).click(function(event){
    $(this).toggleClass(cssClass);
  });
}
// Search form click handler
app.observer.searchFormToggle = function(target, cssClass) {
  $(target).click(function(){
    $(this).parent().toggleClass(cssClass);
  });
}
// Search from submit handler
app.observer.searchLocationForm = function(target){
  $(target).on('submit', function(event){
    event.preventDefault();
    var data = $(this).serialize();

    $.getJSON('/geocoder?'+data, function(data){
      var pos = data.pos.split(" ");
      var lat = pos[1];
      var lng = pos[0];

      app.map.setLocation(lat, lng)
      app.map.updateLocation();
      app.view.formClose();

    }, function(error){
      app.view.alertFlash(error.message);
    });

  });
}

//////////////////////////////////////////////////////////////// Views
app.view.flash = function(message, type){
  $('.flash').addClass(type).text(message);

  window.setTimeout(function(){
    $('.flash').removeClass(type);
  }, 4000);
}

app.view.formOpen = function(){
  $('div.search').addClass('open');
}

app.view.formClose = function(){
  $('div.search').removeClass('open');
}

// Start Application
$(document).ready(function(){
  app.initialize();
});
