<html><head>




<!--
	This is a jQuery Tools standalone demo. Feel free to copy/paste.
	                                                         
	http://flowplayer.org/tools/demos/
	
	Do *not* reference CSS files and images from flowplayer.org when in production  

	Enjoy!
-->


	<title>jQuery Tools standalone demo</title>

	<!-- include the Tools -->
	<script src="http://cdn.jquerytools.org/1.2.5/full/jquery.tools.min.js"></script>
	 

	<!-- standalone page styling (can be removed) -->
	<link href="http://static.flowplayer.org/tools/css/standalone.css" type="text/css" rel="stylesheet">	
	<!-- tab styling -->
	<link href="http://static.flowplayer.org/tools/css/tabs.css" type="text/css" rel="stylesheet">
	
	
	<!-- tab pane styling -->
	<style>
	
/* tab pane styling */
.panes div {
	display:none;		
	padding:15px 10px;
	border:1px solid #999;
	border-top:0;
	height:100px;
	font-size:14px;
	background-color:#fff;
}

	</style>
</head><body>



<!-- the tabs -->
<ul class="tabs">
	<li><a href="#" class="">Tab 1</a></li>
	<li><a href="#" class="">Tab 2</a></li>
	<li><a href="#" class="current">Tab 3</a></li>
</ul>

<!-- tab "panes" -->
<div class="panes">
	<div style="display: none;">First tab content. Tab contents are called "panes"</div>
	<div style="display: none;">Second tab content</div>
	<div style="display: block;">Third tab content</div>
</div>


<!-- This JavaScript snippet activates those tabs -->
<script>

// perform JavaScript after the document is scriptable.
$(function() {
	// setup ul.tabs to work as tabs for each div directly under div.panes
	$("ul.tabs").tabs("div.panes &gt; div");
});
</script>



</body></html>