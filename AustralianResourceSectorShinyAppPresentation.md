
<style>
.footer {
    color: black;
    background: #E8E8E8;
    position: fixed;
    top: 90%;
    text-align:center;
    width:100%;
}
  .rChart {
    display: block;
    height: 100px;
  }

</style>

Australian Resources Sector Application
========================================================
author: Bhaskar Bandaru
date: 25th October 2015
transition: linear

This work is created for the Data Products development Coursera course work Project.



Overview
========================================================
This Shiny Application provides Interactive Data Visualisation of 
Austalain Resources Sector Project from Year 2104 to 2021.

<span style="font-weight:bold; color:Blue;">This App provides following key features</span>

- Provides Australian state wise information 
- Provides Geo Map  visulation of the Austrlation states 
- Provides Overview of projects per year and
- Feature to down load the Data file

The data is obtained from [data.gov.au](http://www.data.gov.au/dataset)


<div class="footer">The data is provided with Creative Commons Attribution 3.0 Australia </div>

Key Features of the App
========================================================

Overiew of projects at a glance

![plot of chunk unnamed-chunk-1](AustralianResourceSectorShinyAppPresentation-figure/unnamed-chunk-1-1.png) 



*************


Full details of Australian Resource Projects could be viewed. 

- From the left side Plot one could view the projects per year and per resource sector.
- The next slide shows key resource projects that are undergoing in each Australian state.
- From Geo map in next slide we could see that Resource Projects are heavily located in West Austrealian and Queensland States compared to other states.

The App has Interactive Plots and Maps 
========================================================
left: 70%
-
Pie chart for Porject costs per State 
<script type='text/javascript' src=//code.jquery.com/jquery-1.9.1.min.js></script>
<script type='text/javascript' src=//code.highcharts.com/highcharts.js></script>
<script type='text/javascript' src=//code.highcharts.com/highcharts-more.js></script>
<script type='text/javascript' src=//code.highcharts.com/modules/exporting.js></script> 
 <style>
  .rChart {
    display: block;
    margin-left: auto; 
    margin-right: auto;
    width: 800px;
    height: 400px;
  }  
  </style>
<div id = 'mychart1' class = 'rChart highcharts'></div>
<script type='text/javascript'>
    (function($){
        $(function () {
            var chart = new Highcharts.Chart({
 "dom": "mychart1",
"width":            800,
"height":            400,
"credits": {
 "href": null,
"text": null 
},
"exporting": {
 "enabled": false 
},
"title": {
 "text": "Project Status Costs Per State" 
},
"yAxis": {
 "title": {
 "text": null 
} 
},
"series": [
 {
 "data": [
 [
 "AU-QLD",
144410 
],
[
 "AU-WA",
185854 
],
[
 "AU-NSW",
12194 
],
[
 "AU-VIC",
3975 
],
[
 "AU-SA",
14454 
],
[
 "AU-NT",
47916 
],
[
 "AU-TAS",
127 
] 
],
"type": "pie",
"name": "Amount in Million (AUD)" 
} 
],
"id": "mychart1",
"chart": {
 "renderTo": "mychart1" 
} 
});
        });
    })(jQuery);
</script>

*********
<!-- GeoChart generated in R 3.2.0 by googleVis 0.5.10 package -->
<!-- Mon Oct 26 10:05:47 2015 -->


<!-- jsHeader -->
<script type="text/javascript">
 
// jsData 
function gvisDataGeoChartID36535df3666e () {
var data = new google.visualization.DataTable();
var datajson =
[
 [
 "AU-QLD",
144410 
],
[
 "AU-WA",
185854 
],
[
 "AU-NSW",
12194 
],
[
 "AU-VIC",
3975 
],
[
 "AU-SA",
14454 
],
[
 "AU-NT",
47916 
],
[
 "AU-TAS",
127 
] 
];
data.addColumn('string','STATE');
data.addColumn('number','value');
data.addRows(datajson);
return(data);
}
 
// jsDrawChart
function drawChartGeoChartID36535df3666e() {
var data = gvisDataGeoChartID36535df3666e();
var options = {};
options["width"] =    600;
options["height"] =    600;
options["region"] = "AU";
options["resolution"] = "provinces";
options["displaymode"] = "regions";
options["colorAxis"] = {colors:['#fff5eb', '#d94801']};

    var chart = new google.visualization.GeoChart(
    document.getElementById('GeoChartID36535df3666e')
    );
    chart.draw(data,options);
    

}
  
 
// jsDisplayChart
(function() {
var pkgs = window.__gvisPackages = window.__gvisPackages || [];
var callbacks = window.__gvisCallbacks = window.__gvisCallbacks || [];
var chartid = "geochart";
  
// Manually see if chartid is in pkgs (not all browsers support Array.indexOf)
var i, newPackage = true;
for (i = 0; newPackage && i < pkgs.length; i++) {
if (pkgs[i] === chartid)
newPackage = false;
}
if (newPackage)
  pkgs.push(chartid);
  
// Add the drawChart function to the global list of callbacks
callbacks.push(drawChartGeoChartID36535df3666e);
})();
function displayChartGeoChartID36535df3666e() {
  var pkgs = window.__gvisPackages = window.__gvisPackages || [];
  var callbacks = window.__gvisCallbacks = window.__gvisCallbacks || [];
  window.clearTimeout(window.__gvisLoad);
  // The timeout is set to 100 because otherwise the container div we are
  // targeting might not be part of the document yet
  window.__gvisLoad = setTimeout(function() {
  var pkgCount = pkgs.length;
  google.load("visualization", "1", { packages:pkgs, callback: function() {
  if (pkgCount != pkgs.length) {
  // Race condition where another setTimeout call snuck in after us; if
  // that call added a package, we must not shift its callback
  return;
}
while (callbacks.length > 0)
callbacks.shift()();
} });
}, 100);
}
 
// jsFooter
</script>
 
<!-- jsChart -->  
<script type="text/javascript" src="https://www.google.com/jsapi?callback=displayChartGeoChartID36535df3666e"></script>
 
<!-- divChart -->
  
<div id="GeoChartID36535df3666e" 
  style="width: 600; height: 600;">
</div>

References
========================================================

<span style="font-weight:bold; color:Green;">Hope the App is interesting and useful and Demonstrated the skills required as requested by the course work </span>


- The Shiny App Link is available from [here](https://bbandaru.shinyapps.io/AustralianResourceSectorApp)

- The Application source files are available at GitHub from [here](https://github.com/bbandaru/Coursera_Data_Products_Shiny)

- The R Presentation filesfrom [here].Rpres Code in my github repository from [here](https://github.com/bbandaru/Coursera_Data_Products_Shiny)


- Sometimes there could be an issue with the Browser and please see [Flash Settings](http://www.macromedia.com/support/documentation/en/flashplayer/help/settings_manager04.html) for Motion Chart


<div class="footer"> Thank You very much  </div>
