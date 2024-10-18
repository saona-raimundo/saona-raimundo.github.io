---
layout: page
title: People
permalink: /people/
---

# Students

## Ali Shafiee
Internship, IST Austria

June 2024 - September 2024

Complexity of Memoryless Limit-sure value in POMDPs. 

## Roodabeh Safavi
Internship, IST Austria

June 2022 - September 2022

Game Theory literature review, towards Simple Stochastic Games.

## Mona Mohammadi
Internship, IST Austria

November 2021 - October 2022

Optimal stopping problems: Prophet inequality and Secretary problem.

She gave a [talk titled "Repeated Prophet Inequality"](https://sites.google.com/view/adwim-2022/abstracts#h.uai6gxfy57n0) in the [SECOND Austrian Day of women in mathematics](https://sites.google.com/view/adwim-2022/home?authuser=0).

We submitted a paper to [ACM-SIAM Symposium on Discrete Algorithms (SODA23)](https://www.siam.org/conferences/cm/conference/soda23) on the Prophet Inequality.

## Mahdi Jafari
Internship, IST Austria

November 2021 - October 2022

Markov Decission Processes: New algorithms for reachability objective

## Mikhailo Bondarenko
Internship, IST Austria

June 2021 - September 2021

Numerichal schemes for Partial Differential Equations (PDEs) and Entropy estimator

## [Simone Bombari](https://simone-bombari.github.io/)
Rotation, IST Austria

October 2020 - January 2021

Risk-aware objectives in Partially Observable Markov Decission Processes (POMDPs)

# Supervisors

## [Krishnendu Chatterjee](https://pub.ist.ac.at/~kchatterjee/)
PhD, IST Austria

July 2019 - today



## [José Correa](https://www.dii.uchile.cl/~jcorrea/)
Master, Universidad de Chile

March 2018 - March 2019

Prophet Secretary Through Blind Strategies

## [Aaron Ellison](https://harvardforest.fas.harvard.edu/aaron-ellison)
Internship, Harvard

January 2017 - March 2017

Anthole modelling with noninvasive data

## [Soledad Torres](https://storres-cimfav.uv.cl/)
Internship, Universidad de Valparaíso

January 2016 - March 2016

Preventive alert for inter-regional fires

<!--
This section needs to be automatically generated. Otherwise, it grows old fast.

# Co-authors

- Bruno Ziliotto
- David Acuña
- Fyodor Kondrashov
- Jakub Svoboda
- José Correa
- Krishnendu Chatterjee
- Ksenia Khudiakova
- Marcos Orchard
- Mona Mohammadi
- Tobias Meggendorfer
-->

# Researchers in the world

I have encountered many good people during my time as a researcher. This map shows some of them, with their respective affiliations when I met them. 

<!-- Leaflet (https://leafletjs.com) -->
<!-- Stylesheet -->
<link rel="stylesheet"
	href="https://unpkg.com/leaflet@1.8.0/dist/leaflet.css"
	integrity="sha512-hoalWLoI8r4UszCkZ5kL8vayOGVae1oxXe/2A4AO6J9+580uKHDO3JdHb7NzwwzK5xr/Fs0W40kiNHxM9vyTtQ=="
	crossorigin=""
/>
<!-- Script -->
<script src="https://unpkg.com/leaflet@1.8.0/dist/leaflet.js"
	integrity="sha512-BB3hKbKWOc9Ez/TAwyWxNXeoV9c1v6FIeYiBieIWkpLjauysF18NzgR1MBNBXf8/KABdlkX68nAhlwcDFLGPCQ=="
	crossorigin="">
</script>
<!-- Leaflet marker cluster (https://github.com/Leaflet/Leaflet.markercluster) -->
<link rel="stylesheet"
	href="https://unpkg.com/leaflet.markercluster@1.4.1/dist/MarkerCluster.css"
/>
<link rel="stylesheet"
	href="https://unpkg.com/leaflet.markercluster@1.4.1/dist/MarkerCluster.Default.css"
/>
<script src="https://unpkg.com/leaflet.markercluster@1.4.1/dist/leaflet.markercluster-src.js">
</script>


<noscript>
	This website uses JavaScript, make sure it is enabled please.
</noscript>

<!-- Map -->
<div id="map" style="width: 600px; height: 400px; position: relative;"></div>


<!-- Map information -->
<script>

	// Points to show
	var information = [
		// ['Name', 'Institution', 'Longitude ', 'Latitude'],
		['Aditya Aradhye', 'Czech Technical University', 50.10318089221843, 14.391284097595074],
		['Alexander Guterman', 'Bar-Ilan University', 32.06934233433513, 34.8430803966437],
		['Alexandra Lassota', 'Christian-Albrechts-Universität zu Kiel', 54.343438785044974, 10.115050586153627],
		['Andreas Wiese', 'TU Munich', 48.26249293890026, 11.66804851978819],
		['Andreas Schulz', 'Technical University of Munich', 48.158223185617295, 11.567946031296778],
		['Andrés Perea', 'Maastricht University', 50.84493591828424, 5.684834929071263],
		['Anna Zseleva', 'Maastricht University', 50.84698050189696, 5.6879908264648735],
		['Antonín Kučera', 'Masaryk University', 49.19873503876354, 16.605437641735367],
		['Arkadi Predtetchinski', 'Maastricht University', 50.84698050189696, 5.6879908264648735],
		['Arturo Merino', 'TU Berlin', 52.5122047299131, 13.328828322944394],
		['Bary S. R. Pradelski', 'CNRS', 48.85163984352975, 2.2638762544034945],
		['Barnabé Monnot', 'Ethereum Foundation', 52.50190943746014, 13.425802343989291],
		['Bruno Ziliotto', 'CNRS & CEREMADE', 48.87019258518365, 2.2737967576874163],
		['Christian Bach', 'University of Liverpool', 53.40482900911875, -2.965253527071097],
		['Dana Pizarro', "O'Higgins University", -34.16399984063102, -70.74160098465548],
		['Eilon Solan', 'Tel-Aviv University', 32.11350491443059, 34.80434478157295],
		['Eran Shmaya', 'Stonny Brook University', 40.90490159414964, -73.12390052976914],
		['Franziska Eberle', 'London School of Economics', 51.514370572733625, -0.11641432067783081],
		['Frederik Mallmann-Trenn', 'King’s Collegue London', 51.51355029116478, -0.11679380052104096],
		['Fryderyk Falniowski', 'Krakow University of Economics', 50.068440913960636, 19.955120095943368],
		['Gaëtan Fournier', 'Aix-Marseille Université', 43.30283923513663, 5.379250610798506],
		['Galit Seknadji-Golan', 'London School of Economics', 51.51457231426795, -0.11640838699617974],
		['Javier Cembrano', 'TU Berlin', 52.51233531948273, 13.328656661566253],
		['János Flesch', 'Maastricht University', 50.84698050189696, 5.6879908264648735],
		['Joakim Blikstad', 'KTH Royal Institute of Technology', 59.34980432241335, 18.070241800211775],
		['José Verschae', 'Pontificie Universidad Católica de Chile', -33.49977929392596, -70.6107391893226],
		['José Correa', 'University of Chile', -33.45688485684971, -70.6668742625855],
		['Krishnendu Chatterjee', 'ISTA', 48.309568, 16.258709],
		['Léonard Brice', 'Université Libre de Bruxelles', 50.81322710873037, 4.382018348125053]
		['Mahsa Shirmohammadi', 'CNRS & IRIF', 48.82717897389951, 2.380807899391197],
		['Marc Schröder', 'Maastricht University', 50.844613783694875, 5.685717869834652],
		['Marco Scarsini', 'LUISS', 41.92461719962625, 12.493981712597572],
		['Maryam Kamgarpour', 'EPFL', 46.51897226796198, 6.566599864257258],
		['Miquel Oliu-Barton', 'Paris Dauphine', 48.87019258518365, 2.2737967576874163],
		['Moritz Buchem', 'Technical University of Munich', 48.14956692330043, 11.56773145147504],
		['Nicolas Klein', 'University of Montreal', 45.50572084767318, -73.61383430449108],
		['Nicolas Vieille', 'HEC Paris', 48.757211966416335, 2.1688400128797434],
		['Neil Olver', 'London School of Economics', 51.51457231426795, -0.11640838699617974],
		['Niklas Rieken', 'RWTH Aachen University', 50.779980510996864, 6.0656524894524155],
		['Raimundo Saona', 'ISTA', 48.309568, 16.258709],
		['Rasmus Ibsen-Jensen', 'Uniersity of Liverpool', 53.404807964306286, -2.965202442727258],
		['Soldead Torres', 'University of Valparaiso', -33.045874464135814, -71.61320389488866],
		['Sylvain Sorin', 'Sorbonne Université', 48.84742963307259, 2.3539671665027173],
		['Sven Rady', 'Hausdorff Center for Mathematics', 50.728495688209414, 7.08418867434603],
		['Thomas Lidbetter', 'Rutgers Business School', 40.745335845427554, -74.1703874162834],
		['Tim Oosterwijk', 'Vrije Universiteit Amsterdam', 52.33389445495339, 4.865709168861083],
		['Tommaso Cesari', 'Toulouse School of Economics', 43.604609820951566, 1.4348480220979003],
		['Tristan Tomala', 'HEC Paris', 48.757211966416335, 2.1688400128797434],
		['Ulrike Schmidt-Kraepelin', 'TU Berlin', 52.5122047299131, 13.328828322944394],
		['Vasilis Livanos', 'University of Illinois at Urbana-Champaign', 40.10164045301988, -88.22707566931092],
		['Xavier Venel', 'LUISS', 41.92461719962625, 12.493981712597572],
		['Vianney Perchet', 'Center for Research in Economics and Statistics ENSAE', 48.71073189303987, 2.2075533074870317],
		['Yehuda "John" Levy', 'University of Glasgow', 55.871507696350534, -4.288443046314292],
		['Yevgeny Tsodikovich', 'Aix-Marseille School of Economics', 43.302800196174985, 5.3792507107985275],
	];

	// Map implementation
	var map = L.map('map')
		.setView([0, 0], 1) // World view
	;

	// Adding tiles
	var tiles = L.tileLayer('https://api.mapbox.com/styles/v1/{id}/tiles/{z}/{x}/{y}?access_token=pk.eyJ1IjoibWFwYm94IiwiYSI6ImNpejY4NXVycTA2emYycXBndHRqcmZ3N3gifQ.rJcFIG214AriISLbB6B5aw', {
		maxZoom: 18,
		attribution: 'Map data &copy; <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a> contributors, ' +
			'Imagery © <a href="https://www.mapbox.com/">Mapbox</a>',
		id: 'mapbox/streets-v11',
		tileSize: 512,
		zoomOffset: -1
	}).addTo(map);

	// Displaying information
	var markers = L.markerClusterGroup();
	for (var i = 0; i < information.length; ++i) {
		var row = information[i];
		var marker = L.marker([row[2], row[3]]); //addTo(map);
		marker.bindPopup("<b>" + row[0] +"</b>" + "<br>" + row[1]).openPopup();
		markers.addLayer(marker);
	}
	map.addLayer(markers);

	// Easily find new coordinates by clicking
	var popup = L.popup();
	function onMapClick(e) {
	    popup
	        .setLatLng(e.latlng)
	        .setContent(e.latlng.toString())
	        .openOn(map);
	}
	map.on('click', onMapClick);
	
</script>

