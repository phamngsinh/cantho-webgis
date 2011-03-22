<%@ page language="java" contentType="text/html; charset=utf8" pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Bản Đồ Thành Phố Cần Thơ</title>
<script type="text/javascript" src="libs/openlayers/OpenLayers.js"></script>
<script type="text/javascript" src="libs/jquery/jquery-1.4.4.js"></script>
<script src="libs/jquery/jquery-1.4.4.js" language="javascript"></script>
<script src="libs/jquery/jquery.tools.min.js" language="javascript"></script>
<script type="text/javascript" src="js/styles.js"></script>
<script type="text/javascript" src="js/print.js"></script>
<script type="text/javascript" src="js/events.js"></script>
<script type="text/javascript" src="js/services.js"></script>
<script type="text/javascript" src="js/popup.js"></script>
<script type="text/javascript" src="js/effect.js"></script>
<script type="text/javascript" src="js/functions.js"></script>
<link type="text/css" rel="stylesheet" href="css/print.css"></link>
<link type="text/css" rel="stylesheet" href="css/bottom_content.css"></link>
<link type="text/css" rel="stylesheet" href="css/header_content.css"></link>
<link type="text/css" rel="stylesheet" href="css/left_content.css"></link>
<link type="text/css" rel="stylesheet" href="css/right_content.css"></link>
<link type="text/css" rel="stylesheet" href="css/popup.css"></link>
</head>
<body id="all" onload="init()">
<div class = "map" id = "map"></div>
<a class="inbando" href="javascript:window.print()">In bản đồ</a>
<a class="inbando1" href="javascript:check()">Check</a>
</body>


</html>