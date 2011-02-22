<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Bản đồ thành phố cần thơ </title>
<link href="css/style2.css" rel="stylesheet" type="text/css" />
<link href="css/style3.css" rel="stylesheet" type="text/css" />
<script src="js/Untitled-1.js" language="javascript"></script>
<script src="libs/jquery/jquery-1.4.4.js" language="javascript"></script>
<script type="text/javascript">
function showElement(layer){
var myLayer = document.getElementById(layer);
if(myLayer.style.display=="none"){
myLayer.style.display="block";
myLayer.backgroundPosition="top";
} else {
myLayer.style.display="none";
}
}
</script>
</head>

<body>
                   
<form id="frmVBDMap" action="vbdmap.aspx" method="post" name="frmVBDMap">
<div style="z-index: 1000;">
<input type="hidden" value="" id="__EVENTTARGET" name="__EVENTTARGET">
<input type="hidden" value="" id="__EVENTARGUMENT" name="__EVENTARGUMENT">
<input type="hidden" value="/wEPDwULLTE5MzIzNTkyNjBkGAEFHl9fQ29udHJvbHNSZXF1aXJlUG9zdEJhY2tLZXlfXxYCBS9RdWlja0xvZ2luMSRMb2dpblZpZXdEZWZhdWx0JExvZ2luU3RhdHVzMSRjdGwwMQUvUXVpY2tMb2dpbjEkTG9naW5WaWV3RGVmYXVsdCRMb2dpblN0YXR1czEkY3RsMDOU9+DfwkRSIMLx0BzygifCvm2f1w==" id="__VIEWSTATE" name="__VIEWSTATE">
</div>

<script type="text/javascript">
//&lt;![CDATA[
var theForm = document.forms['frmVBDMap'];
if (!theForm) {
    theForm = document.frmVBDMap;
}
function __doPostBack(eventTarget, eventArgument) {
    if (!theForm.onsubmit || (theForm.onsubmit() != false)) {
        theForm.__EVENTTARGET.value = eventTarget;
        theForm.__EVENTARGUMENT.value = eventArgument;
        theForm.submit();
    }
}
//]]&gt;
</script>



<script src="/maps/ajaxpro/prototype.ashx" type="text/javascript"></script>
<script src="/maps/ajaxpro/core.ashx" type="text/javascript"></script>
<script src="/maps/ajaxpro/converter.ashx" type="text/javascript"></script>
<script src="/maps/ajaxpro/AJLocationSearch,Vietbando.Web.Library.ashx" type="text/javascript"></script>
<script src="/maps/ajaxpro/Vietbando.Web.Library.Render.Overlay,Vietbando.Web.Library.ashx" type="text/javascript"></script>
<script src="/maps/ajaxpro/AJBus,Vietbando.Web.Library.ashx" type="text/javascript"></script>
<script src="/maps/ajaxpro/Control_WeatherModuleAjax,App_Web_weathermoduleajax.ascx.cc189baa.ashx" type="text/javascript"></script>
<script src="/maps/ajaxpro/Control_LocationManager_PlacesManager,App_Web_placesmanager.ascx.b31ddd96.ashx" type="text/javascript"></script>

<div style="z-index: 998;">

	<input type="hidden" value="/wEWAwK24PH1DwKm08znDQLdmf2SAmxviQp5XR8rOiJtjejKr/XN4B23" id="__EVENTVALIDATION" name="__EVENTVALIDATION">
</div><input type="hidden" value="3" id="hdTab" name="hdTab">


    <div onclick="WrapperClick()" id="WrapperClick" style="z-index: 996;">
    
    <div id="loadimg" style="z-index: 994;"></div>
    
    <div style="display: none; z-index: 992;" class="IE6-warning">
    	<p>
            <img src="/Maps/Skins/WhiteSkin/images/warning.jpg" class="warning-img" style="z-index: 990;">
            <span>Chúng tôi không còn hỗ trợ cho trình duyệt Internet Explorer 6 nữa.</span>
            <span>Bạn vui lòng tải về các trình duyệt mới nhất dưới đây để sử dụng được hết các chức năng. </span>
        </p>
        <p class="Browser">
        	<a href="http://www.mozilla.com/?from=sfx&amp;uid=267821&amp;t=449" class="Firefox"></a>
            <a href="http://www.google.com/chrome/index.html?brand=CHNY&amp;utm_campaign=en&amp;utm_source=en-et-youtube&amp;utm_medium=et" class="Chrome"></a>
            <a href="http://www.apple.com/safari/" class="Safari"></a>
            <a href="http://www.opera.com/browser/" class="Opera"></a>
            <a href="http://www.microsoft.com/windows/internet-explorer/default.aspx" class="IE8"></a>
        </p>
        <a onclick="$('.IE6-warning').hide()" class="del">Tắt</a>
    </div>
    
    
<link type="text/css" rel="stylesheet" href="/Maps/Control/WeatherModule/WeatherModuleAjax.css">

<div onclick="toggleWeather()" style="z-index: 988;" class="Weather-shadow">
    <div class="Weather-wrap" style="z-index: 986;">
    	<div style="display: none; opacity: 1; z-index: 984;" class="weather-img-large-wrap">
        	<span class="weather-img-large" style="background: url(&quot;/Maps/Control/WeatherModule/WeatherImages/Set_2/PartlyCloudy_night.png&quot;) no-repeat scroll 0% 0% transparent;" title="Hơi có mây - 66% - 1006hPa (Không đổi) - 18km/h Hướng Nam Đông Nam"></span>
        </div>
        <span class="province">Hồ Chí Minh</span>
        <div class="temp-wrap" style="opacity: 1; z-index: 982;" title="Hơi có mây - 66% - 1006hPa (Không đổi) - 18km/h Hướng Nam Đông Nam">
            <span class="temp" id="divTemperature">28°</span>
        	<span class="weather-img-small" style="background: url(&quot;/Maps/Control/WeatherModule/WeatherImages/Set_2_small/PartlyCloudy_night.png&quot;) no-repeat scroll 0% 0% transparent;"></span>
            <span style="display: none;" class="weather-currentCondition" id="wCondition">Hơi có mây</span>
        </div>
        <div style="display: none; z-index: 980;" class="weather-info-wrap">
            <div class="weather-combobox-wrap" style="z-index: 978;">
                <select onchange="getWeatherInfo()" id="lstLocation" class="weather-combobox">
                    <option value="48820" id="Option6">Hà Nội</option>
                    <option value="48900" id="Option8">Hồ Chí Minh</option>
                    <option value="48855" id="Option5">Đà Nẵng</option>
                    <option value="48852" id="Option9">Huế</option>
                    <option value="48810" id="Option1">Bắc Cạn</option>
                    <option value="48875" id="Option2">Buôn Ma Thuột</option>
                    <option value="48914" id="Option3">Cà Mau</option>
                    <option value="48808" id="Option4">Cao Bằng</option>
                    <option value="48846" id="Option7">Hà Tĩnh</option>
                    <option value="48830" id="Option10">Lạng Sơn</option>
                    <option value="48803" id="Option11">Lào Cai</option>
                    <option value="48823" id="Option12">Nam Định</option>
                    <option value="48877" id="Option13">Nha Trang</option>
                    <option value="48887" id="Option14">Phan Thiết</option>
                    <option value="48917" id="Option15">Phú Quốc</option>
                    <option value="48866" id="Option16">Pleiku</option>
                    <option value="48870" id="Option17">Qui Nhơn</option>
                    <option value="48907" id="Option18">Rạch Giá</option>
                    <option value="48831" id="Option19">Thái Nguyên</option>
                    <option value="48840" id="Option20">Thanh Hóa</option>
                    <option value="48845" id="Option21">Vinh</option>
                    <option value="48910" id="Option22">Vĩnh Long</option>
                </select>
            </div>
        	<ul class="weather-today" style="opacity: 1; z-index: 976;">
            	<li>
                	<span class="weather-today-title">Độ ẩm</span>
                    <span class="weather-today-info" id="wHumidity">66%</span>
                </li>
                <li>
                	<span class="weather-today-title">Áp suất</span>
                    <span class="weather-today-info" id="wPressure">1006hPa (Không đổi)</span>
                </li>
                <li>
                	<span class="weather-today-title"><span class="wind-tit">Gió&nbsp;</span><span id="wWindDirection" class="WindDirection" style="background: url(&quot;/Maps/Control/WeatherModule/WeatherImages/WindDirections/SSE.png&quot;) no-repeat scroll 0% 0% transparent;"></span></span>
                    <span class="weather-today-info weather-WindDirection"><span id="wWindSpeed">18km/h Hướng Nam Đông Nam</span></span>
                </li>
                <li>
                	<span class="weather-today-title">Cập nhật</span>
                    <span class="weather-today-info" id="wUpdateTime">1 giờ 4 phút trước</span>
                </li>
            </ul>
            <ul class="weather-future" style="opacity: 1; z-index: 974;">
            	<li>
                	<span class="weather-future-title" id="day1">Hôm nay</span>
                    <span class="weather-future-day">
                    	<span class="weather-future-img" style="background: url(&quot;/Maps/Control/WeatherModule/WeatherImages/Set_2_small/clear.png&quot;) no-repeat scroll 0% 0% transparent;" id="cday1" title="Sáng: Trời đẹp"></span>
                        <span class="weather-future-temp" id="tday1">32°</span>
                    </span>
                    <span class="weather-future-night">
                    	<span class="weather-future-img" style="background: url(&quot;/Maps/Control/WeatherModule/WeatherImages/Set_2_small/clear_night.png&quot;) no-repeat scroll 0% 0% transparent;" id="cnight1" title="Tối: Trời đẹp"></span>
                        <span class="weather-future-temp" id="tnight1">21°</span>
                    </span>
                </li>
                <li class="weather-middleday">
                	<span class="weather-future-title" id="day2">Thứ 6</span>
                    <span class="weather-future-day">
                    	<span class="weather-future-img" style="background: url(&quot;/Maps/Control/WeatherModule/WeatherImages/Set_2_small/clear.png&quot;) no-repeat scroll 0% 0% transparent;" id="cday2" title="Sáng: Trời đẹp"></span>
                        <span class="weather-future-temp" id="tday2">33°</span>
                    </span>
                    <span class="weather-future-night">
                    	<span class="weather-future-img" style="background: url(&quot;/Maps/Control/WeatherModule/WeatherImages/Set_2_small/clear_night.png&quot;) no-repeat scroll 0% 0% transparent;" id="cnight2" title="Tối: Trời đẹp"></span>
                        <span class="weather-future-temp" id="tnight2">22°</span>
                    </span>
                </li>
                <li>
                	<span class="weather-future-title" id="day3">Thứ 7</span>
                    <span class="weather-future-day">
                    	<span class="weather-future-img" style="background: url(&quot;/Maps/Control/WeatherModule/WeatherImages/Set_2_small/clear.png&quot;) no-repeat scroll 0% 0% transparent;" id="cday3" title="Sáng: Trời đẹp"></span>
                        <span class="weather-future-temp" id="tday3">33°</span>
                    </span>
                    <span class="weather-future-night">
                    	<span class="weather-future-img" style="background: url(&quot;/Maps/Control/WeatherModule/WeatherImages/Set_2_small/clear_night.png&quot;) no-repeat scroll 0% 0% transparent;" id="cnight3" title="Tối: Trời đẹp"></span>
                        <span class="weather-future-temp" id="tnight3">21°</span>
                    </span>
                </li>
                <li style="display: none;" id="weather-option">
                    <input type="checkbox" onchange="bWeatherDynChange = this.checked" id="chkDynamicChange"><label for="chkDynamicChange">Thay đổi theo vị trí trên bản đồ</label>
                </li>
            </ul>
        </div>
    </div><!--End Weather-wrap-->
</div>

<script type="text/javascript">
    $(document).ready(function()
    {
        $('#lstLocation, .weather-today, .weather-future, .Weather-shadow').click(function(e) { e.stopPropagation(); });
        
        var weatherID = getCookie('UserWeather');
        if (weatherID == null || weatherID == '')
        {
            weatherID = 48900;
        }

        $('#lstLocation').val(weatherID);
        getWeatherInfo();
    });
    var countLoad = 0;
    var bshowWeather = true;
    var bWeatherDynChange = false;
    function toggleWeather()
    {
        if (bshowWeather)
            showWeather();
        else
            hideWeather();
    }
    function showWeather()
    {
        $('.province').hide();
        $('.weather-img-small').hide();
        $('.temp-wrap').addClass('right');
        $('.weather-img-large-wrap').show();
        $('.weather-currentCondition').show();
        $('.Weather-shadow').addClass('dark');
		$('.Weather-wrap').addClass('fixie');
        $('.weather-info-wrap').show();

        bshowWeather = false;
    }
    function hideWeather()
    {
        $('.province').show();
        $('.weather-img-small').show();
        $('.temp-wrap').removeClass('right');
        $('.weather-img-large-wrap').hide();
        $('.weather-currentCondition').hide();
        $('.Weather-shadow').removeClass('dark');
		$('.Weather-wrap').removeClass('fixie');
        $('.weather-info-wrap').hide();

        bshowWeather = true;
    }
    function getWeatherInfo()
    {
        setCookie('UserWeather', $('#lstLocation :selected').val(), 5000, "", "", "");
        if (isSupportEffect())
        {
            $('.weather-img-large-wrap, .temp-wrap, .weather-today, .weather-future').stop().animate(
		    {
		        opacity: 0.5
		    }, 400, "linear");
        }

        setTimeout(function()
        {
            Control_WeatherModuleAjax.LoadWeatherInformation($('#lstLocation :selected').val(), callback_Message);
        }, 400);
    }
    var CountLoadWeather = 0;
    function callback_Message(data)
    {
        var info = data.value;
        if (info != null) {            
            //Fill data to div Weather Icon
            $('.province').html($('#lstLocation :selected').text());

            var curHour = (new Date).getHours();
            $('.weather-img-small').css('background', 'url("/Maps/Control/WeatherModule/WeatherImages/Set_2_small/' + ((curHour &gt; 6 &amp;&amp; curHour &lt; 18) ? info.strImgCurrentCon : info.strImgCurrentCon + "_night") + '.png") no-repeat');
            $('.weather-img-large').css('background', 'url("/Maps/Control/WeatherModule/WeatherImages/Set_2/' + ((curHour &gt; 6 &amp;&amp; curHour &lt; 18) ? info.strImgCurrentCon : info.strImgCurrentCon + "_night") + '.png") no-repeat');
            $('.temp-wrap, .weather-img-large').attr('title', info.strCurrentCon + ' - ' + info.strHumidity + ' - ' + info.strPressure + ' - ' + info.strWindSpeed);

            //Fill data to div Weather Temperature
            $('#divTemperature').html(info.strTemperature);

            //Fill data to tab 1
            $('#wCondition').html(info.strCurrentCon);
            $('#wHumidity').html(info.strHumidity);
            $('#wPressure').html(info.strPressure);
            $('#wWindDirection').css('background', 'url("/Maps/Control/WeatherModule/WeatherImages/WindDirections/' + info.strWindDirection + '.png") no-repeat');
            $('#wWindSpeed').html(info.strWindSpeed);
            $('#wUpdateTime').html(info.strUpdateTime);

            //$('#day1').html(info.otherDays[0].strDay);
            $('#cday1').css('background', 'url("/Maps/Control/WeatherModule/WeatherImages/Set_2_small/' + info.otherDays[0].strImgCondition + '.png") no-repeat');
            $('#cday1').attr('title', 'Sáng: ' + info.otherDays[0].strCondition);
            $('#tday1').html(info.otherDays[0].strTemperature);
            $('#cnight1').css('background', 'url("/Maps/Control/WeatherModule/WeatherImages/Set_2_small/' + info.otherDays[1].strImgCondition + '.png") no-repeat');
            $('#cnight1').attr('title', 'Tối: ' + info.otherDays[1].strCondition);
            $('#tnight1').html(info.otherDays[1].strTemperature);

            $('#day2').html(info.otherDays[2].strDay);
            $('#cday2').css('background', 'url("/Maps/Control/WeatherModule/WeatherImages/Set_2_small/' + info.otherDays[2].strImgCondition + '.png") no-repeat');
            $('#cday2').attr('title', 'Sáng: ' + info.otherDays[2].strCondition);
            $('#tday2').html(info.otherDays[2].strTemperature);
            $('#cnight2').css('background', 'url("/Maps/Control/WeatherModule/WeatherImages/Set_2_small/' + info.otherDays[3].strImgCondition + '.png") no-repeat');
            $('#cnight2').attr('title', 'Tối: ' + info.otherDays[3].strCondition);
            $('#tnight2').html(info.otherDays[3].strTemperature);

            $('#day3').html(info.otherDays[4].strDay);
            $('#cday3').css('background', 'url("/Maps/Control/WeatherModule/WeatherImages/Set_2_small/' + info.otherDays[4].strImgCondition + '.png") no-repeat');
            $('#cday3').attr('title', 'Sáng: ' + info.otherDays[4].strCondition);
            $('#tday3').html(info.otherDays[4].strTemperature);
            $('#cnight3').css('background', 'url("/Maps/Control/WeatherModule/WeatherImages/Set_2_small/' + info.otherDays[5].strImgCondition + '.png") no-repeat');
            $('#cnight3').attr('title', 'Tối: ' + info.otherDays[5].strCondition);
            $('#tnight3').html(info.otherDays[5].strTemperature);
            $('.Weather-shadow').show();

            if (isSupportEffect()) {
                $('.weather-img-large-wrap, .temp-wrap, .weather-today, .weather-future').stop().animate(
	        {
	            opacity: 1
	        }, 400, "linear");
            }
        }
        else {
            //$('.weather-today').html('Chưa có dữ liệu');
            if (CountLoadWeather &lt; 10) {
                CountLoadWeather++;
                setTimeout(function() { getWeatherInfo(); }, CountLoadWeather*500);                
            }
            else {
                $('.Weather-shadow').hide();
            }
        }    
    }
</script>

    

<div style="display: none; z-index: 972;" class="kb-bor1">
	<div class="kb-bor2" style="z-index: 970;">
    	<div class="kb-row1" style="z-index: 968;">
            <a>
                <span>Q</span>
            </a>
            <a>
                <span>W</span>
            </a>
            <a>
                <span>E</span>
            </a>
            <a>
                <span>R</span>
            </a>
            <a>
                <span>T</span>
            </a>
            <a>
                <span>Y</span>
            </a>
            <a>
                <span>U</span>
            </a>
            <a>
                <span>I</span>
            </a>
            <a>
                <span>O</span>
            </a>
            <a>
                <span>P</span>
            </a>
            <a class="kb-btnNumber">
                <span>7</span>
            </a>
            <a class="kb-btnNumber">
                <span>8</span>
            </a>
            <a class="kb-btnNumber">
                <span>9</span>
            </a>
        </div>
        <div class="kb-first kb-line2" style="z-index: 966;">
            <a>
                <span>A</span>
            </a>
            <a>
                <span>S</span>
            </a>
            <a>
                <span>D</span>
            </a>
            <a>
                <span>F</span>
            </a>
            <a>
                <span>G</span>
            </a>
            <a>
                <span>H</span>
            </a>
            <a>
                <span>J</span>
            </a>
            <a>
                <span>K</span>
            </a>
            <a class="kb-end">
                <span>L</span>
            </a>
            <a class="kb-btnNumber">
                <span>4</span>
            </a>
            <a class="kb-btnNumber">
                <span>5</span>
            </a>
            <a class="kb-btnNumber">
                <span>6</span>
            </a>
        </div>
        <div class="kb-first kb-line1" style="z-index: 964;">
            <a class="kb-btnChar kb-btnShift">
                <span><img src="/Maps/Control/VirtualKeyboard/images/btn-shift.png" style="z-index: 962;"></span>
            </a>
            <a>
                <span>Z</span>
            </a>
            <a>
                <span>X</span>
            </a>
            <a>
                <span>C</span>
            </a>
            <a>
                <span>V</span>
            </a>
            <a>
                <span>B</span>
            </a>
            <a>
                <span>N</span>
            </a>
            <a>
                <span>M</span>
            </a>
            <a class="kb-btnEnter">
                <span>Enter</span>
            </a>
            <a class="kb-btnNumber">
                <span>1</span>
            </a>
            <a class="kb-btnNumber">
                <span>2</span>
            </a>
            <a class="kb-btnNumber">
                <span>3</span>
            </a>
        </div>
        <div class="kb-first kb-line2" style="z-index: 960;">
            <a class="kb-btnChar">
                <span>-</span>
            </a>
            <a class="kb-btnChar">
                <span>_</span>
            </a>
            <a class="kb-btnChar">
                <span>=</span>
            </a>
            <a class="kb-btnChar">
                <span>&lt;</span>
            </a>
            <a class="kb-btnChar">
                <span>&gt;</span>
            </a>
            <a class="kb-btnChar">
                <span>&amp;</span>
            </a>
            <a class="kb-btnChar">
                <span>:</span>
            </a>
            <a class="kb-btnChar">
                <span>'</span>
            </a>
            <a class="kb-end kb-btnChar">
                <span>,</span>
            </a>
            <a class="kb-btnChar">
                <span>.</span>
            </a>
            <a class="kb-btnChar">
                <span>/</span>
            </a>
            <a class="kb-btnNumber">
                <span>0</span>
            </a>
        </div>
        <div class="kb-first kb-endrow" style="z-index: 958;">
            <a class="kb-btnSpace">
                <span>Space</span>
            </a>
            <a class="kb-btnClearColor kb-btnBksp">
                <span><img src="/Maps/Control/VirtualKeyboard/images/btn-bksp.png" style="z-index: 956;"></span>
            </a>
            <a class="kb-btnClear kb-btnClearColor">
                <span>Clear</span>
            </a>
        </div>
        <a class="kb-close">Đóng</a>
    </div><!--end kb-bor2-->
</div>
    
    <div class="SendMapLinks-wrap" style="display: none; z-index: 954;">
    	<label for="txtMapLink">Bạn gửi đường dẫn dưới đây cho bạn bè</label>
        <div class="input-wrap" style="z-index: 952;"><input type="text" onclick="this.select()" id="txtMapLink"></div>
        <label for="txtMapEmbed" class="margin">Bạn dùng đường dẫn này nhúng vào website của bạn</label>
        <div class="input-wrap" style="z-index: 950;"><input type="text" onclick="this.select()" id="txtMapEmbed"></div>
        <ul style="z-index: 948;">
        	<li><a class="shareFacebook" target="_blank" title="Facebook">Facebook</a></li>
            <li><a class="shareTwitter" target="_blank" title="Twitter">Twitter</a></li>
            <li><a class="shareYahooMess" target="_blank" title="Yahoo Messenger">Yahoo Messenger</a></li>
            <li><a class="shareDelicious" target="_blank" title="Delicious">Delicious</a></li>
            <li><a class="shareDigg" target="_blank" title="Digg">Digg</a></li>
            <li><a class="shareZingme" target="_blank" title="ZingMe">ZingMe</a></li>
            <li><a class="shareLinkhay" target="_blank" title="LinkHay">LinkHay</a></li>
        </ul>
        <a onclick="CloseSendMap()" class="btn-links"></a>
    </div>
    
    <div class="PopupTraffic" id="PopupTraffic" style="z-index: 946;">
        <div class="ColPopupTraffic" style="z-index: 944;">
        	<a onclick="ToggleRoadCons()" class="PopupTraffic-construction"></a>
            <span class="PopupTraffic-count" id="RoadConsCount">0</span>
            <span class="PopupTraffic-text">điểm rào chắn</span>
        </div>
        <div class="ColPopupTraffic" style="z-index: 942;">
        	<a onclick="ToggleTrafficJam()" class="PopupTraffic-jam"></a>
            <span class="PopupTraffic-count" id="TrafficJamCount">0</span>
            <span class="PopupTraffic-text">điểm kẹt xe</span>
        </div>
        <a onclick="ClosePopupTraffic();" class="btn-PopupTraffic"></a>
    </div>
    
    <div class="dokhoangcach" style="z-index: 940;">
		<p>Khoảng cách đoạn hiện hành: <span id="lblCurDistance">0</span></p>
        <p class="huongdan">Nhấp-đúp để kết thúc quá trình đo khoảng cách</p>
        <p>Tổng khoảng cách: <span class="total" id="lblTotalDistance">0</span></p>
        <a onclick="ClosePopupDistance(event)" class="btn-dokhoangcach"></a>
   </div>
    
    <div id="header_wrap" style="z-index: 938;">
        
        <ul id="bando_tab" style="z-index: 936;">
          <li style="margin-left: 5px;" class="active2" id="searchtab"><a onclick="ChangeFunctionType(GLOBAL_SEARCH_FUNCTION)">Tìm vị trí</a></li>
          <li id="findpathtab"><a onclick="ChangeFunctionType(GLOBAL_FINDPATH_FUNCTION)">Tìm đường</a></li>
          <li id="mymaptab"><a onclick="ChangeFunctionType(GLOBAL_MYMAP_FUNCTION)">Cá nhân</a></li>
          <img src="Skins/WhiteSkin/images/tab_img_end.png" alt="" class="tab_img_end" style="z-index: 934;">
        </ul>
        <!--bg_bando_tab-->
        
        <div id="logo" style="z-index: 932;"><a href="/Maps/" class="logo-old"></a></div>
        <!--logo-->
        
        <div id="header" style="z-index: 930;">
            

<ul id="nav" class="sf-js-enabled sf-shadow" style="z-index: 928;">
	<li class="navitem nav-first selectedLava"><a href="/Maps/">Bản đồ</a></li>
	<li class="navitem selectedLava" id="APIMenu"><a href="/Maps/API/APIRegister.aspx" class="sf-with-ul">Maps API<span class="sf-sub-indicator"> »</span></a>
		<ul style="width: 135px; display: none; visibility: hidden; z-index: 926;" class="submenu1">
			<li class="noLava topradius selectedLava" style="padding-top: 4px;"><a href="/Maps/API/APIRegister.aspx">Đăng ký sử dụng</a></li>
			<li class="noLava selectedLava"><a href="/Maps/API/UserGuide.aspx">Hướng dẫn sử dụng</a></li>
			<li class="noLava selectedLava"><a href="/Maps/API/Reference.aspx">Tài liệu tra cứu API</a></li>
			<li class="noLava botradius selectedLava" style="padding-bottom: 4px;"><a href="/Maps/API/Examples.aspx">Ví dụ mẫu</a></li>
		</ul>
	</li>
	<li class="navitem selectedLava"><a href="/Maps/Help/Mobile.aspx?cs=1">Mobile</a></li>
	<li class="navitem selectedLava"><a href="/Maps/DS_Manager/Managestore.aspx">Doanh nghiệp</a></li>
	<li class="navitem selectedLava" id="HelpMenu"><a href="/Maps/Help/Web.aspx" target="_blank" class="sf-with-ul">Hướng dẫn<span class="sf-sub-indicator"> »</span></a>
		<ul style="width: 150px; display: none; visibility: hidden; z-index: 924;" class="submenu2">
			<li class="noLava topradius selectedLava" style="padding-top: 4px;"><a href="/Maps/Help/Index.aspx" target="_blank">Giới thiệu</a></li>
			<li class="noLava selectedLava"><a href="/Maps/Help/Web.aspx" target="_blank" class="sf-with-ul">Hướng dẫn sử dụng Web<span class="sf-sub-indicator"> »</span></a>
				<ul class="sub-submenu1" style="display: none; visibility: hidden; z-index: 922;">
					<li class="noLava topradius selectedLava" style="padding-top: 4px;"><a href="/Maps/Help/Web.aspx#link1" target="_blank">Tìm thông tin, vị trí</a></li>
					<li class="noLava selectedLava"><a href="/Maps/Help/Web.aspx#link2" target="_blank">Tìm đường đi</a></li>
					<li class="noLava botradius selectedLava" style="padding-bottom: 4px;"><a href="/Maps/Help/Web.aspx#link3" target="_blank">Bản đồ của tôi</a></li>
				</ul>
			</li>
			<li class="noLava selectedLava"><a href="/Maps/Help/Wap.aspx" class="sf-with-ul">Hướng dẫn sử dụng Wap<span class="sf-sub-indicator"> »</span></a>
				<ul class="sub-submenu2" style="display: none; visibility: hidden; z-index: 920;">
					<li class="noLava topradius selectedLava" style="padding-top: 4px;"><a href="/Maps/Help/Wap.aspx#link12">Tìm thông tin, vị trí</a></li>
					<li class="noLava botradius selectedLava" style="padding-bottom: 4px;"><a href="/Maps/Help/Wap.aspx#link13">Tìm đường đi</a></li>
				</ul>
			</li>
			<li class="noLava selectedLava"><a href="/Maps/Help/Biz.aspx" target="_blank">Quảng cáo Doanh nghiệp</a></li>
			<li class="noLava selectedLava"><a href="/Maps/Help/SMS.aspx">Vietbando SMS Navigator</a></li>
			<li class="noLava selectedLava"><a href="/Maps/Help/Mobile.aspx" class="sf-with-ul">Vietbando Mobile<span class="sf-sub-indicator"> »</span></a>
				<ul class="sub-submenu3" style="display: none; visibility: hidden; z-index: 918;">
					<li class="noLava topradius selectedLava" style="padding-top: 4px;"><a href="/Maps/Help/Blackberry.aspx">Blackbery</a></li>
					<li class="noLava selectedLava"><a href="/Maps/Help/Symbian.aspx">Symbian</a></li>
					<li class="noLava selectedLava"><a href="/Maps/Help/Android.aspx">Android</a></li>
					<li class="noLava selectedLava"><a href="/Maps/Help/WindowMobile.aspx">Window Mobile</a></li>
					<li class="noLava botradius selectedLava" style="padding-bottom: 4px;"><a href="/Maps/Help/JavaJ2ME.aspx">Java J2ME</a></li>
				</ul>
			</li>
			<li class="noLava botradius selectedLava" style="padding-bottom: 4px;"><a href="/Maps/Help/VietbandoID.aspx"><span>VietbandoID</span></a></li>
		</ul>
	</li>
	<li class="navitem selectedLava"><a href="/Maps/vbdfeedback.aspx">Liên hệ</a></li>
<li style="z-index: -1; left: 0px; top: 0px; width: 73px; height: 41px; overflow: hidden; display: block;" class="nav-arrow"></li></ul>
            
            <div id="search" style="z-index: 916;">
            	<div class="SLeft" style="z-index: 914;"></div>
                <div class="SCenter" style="z-index: 912;">
                	<div class="SBox" style="z-index: 910;">
                    	<div class="SBoxLeft" style="z-index: 908;"></div>
                        <script src="vbdScript/Avim/Avim.js" type="text/javascript"></script><span onclick="AVIMObj.AvimControlOn(this)" id="avim" class="AvimOff" title="Bật bộ gõ tiếng Việt" alt=""></span>
                        <input type="text" onblur="showInputTextHelp()" onfocus="inputTextClick()" value="Tìm địa chỉ, dịch vụ và số điện thoại..." id="mapinput" class="SText keyboardInput" name="mapinput"><img class="keyboardInputInitiator" src="/Maps/Control/VirtualKeyboard/images/keyboard.png" style="z-index: 906;">
                        <div class="SHelpClose" id="s-help" style="z-index: 904;"><a onclick="LoadHelp()">Ví dụ</a></div>
                        <input type="submit" onclick="return doSearch()" value="Tìm" class="SButton">
                    </div>
                    <div class="SHelpDiv" onclick="clickHelp()" id="HelpDiv" style="z-index: 902;">
                    	<div class="SHelpDiv-div" style="z-index: 900;">
                            <h3>Ví dụ tìm kiếm</h3>
                            <a href="/Maps/Help/Web.aspx" target="_blank" class="btn-xemthem">Xem thêm...</a>
                            <ul class="SHelpDiv-div-ul" style="z-index: 898;">
                                <li class="favicon">Tìm vị trí:
                                    <ul style="z-index: 896;">
                                        <li><a onclick="MapExampleClick('hn')" id="hn">Hà Nội</a></li>
                                        <li><a onclick="MapExampleClick('q1')" id="q1">Quận 1, TPHCM</a></li>
                                        <li><a onclick="MapExampleClick('nvc')" id="nvc">Nguyễn Huệ, TPHCM</a></li>
                                        <li><a onclick="MapExampleClick('gl')" id="gl">Giao lộ Cách Mạng Tháng Tám &amp; Nguyễn 
                                            Đình Chiểu</a></li>
                                        <li><a onclick="MapExampleClick('ll')" id="ll">10.775659, 106.702351</a></li>
                                        <li><a onclick="MapExampleClick('dg')" id="dg">10°46'32.376", 106°42'8.4672"</a></li>
                                    </ul>
                                </li>
                                <li class="favicon">Tìm xung quanh vị trí:
                                    <ul style="z-index: 894;">
                                        <li><a onclick="MapExampleClick('nhgks')" id="nhgks">Nhà hàng gần Khách sạn 
                                            Caravelle</a></li>
                                    </ul>
                                </li>
                                <li class="favicon">Tìm địa chỉ:
                                    <ul style="z-index: 892;">
                                    	<li><a onclick="MapExampleClick('hvb')" id="hvb">31A Huỳnh Văn Bánh, Quận Phú Nhuận, 
                                            TPHCM</a></li>
                                    </ul>
                                </li>
                                <li class="favicon">Tìm số điện thoại:
                                    <ul id="ullasthelp" style="z-index: 890;">
                                        <li>Vietbando: <a onclick="MapExampleClick('dt39956665')" id="dt39956665">39956665</a></li>
                                        <li>Khách sạn Rex: <a onclick="MapExampleClick('dt38293115')" id="dt38293115">
                                            38293115</a></li>
                                    </ul>
                                </li>
                            </ul>
                    	</div>
                        <a onclick="UnLoadHelp()" class="close">Close</a>
                    </div>
                </div>
                <div class="SRight" style="z-index: 888;"></div>
                <div onclick="clickTree()" class="SWTrans" style="z-index: 886;">
                	<div class="boundTree" id="boundTree" style="z-index: 884;">
                    	<div id="Tree" style="overflow: auto; z-index: 882;"></div>
                        <div class="SW-img" style="z-index: 880;"></div>
                    </div>
                    <div class="SWRight-bgShadow" style="z-index: 878;">
                        <div class="SWRight-bg" style="z-index: 876;">
                            <div class="SWCenter-bg" style="z-index: 874;">
                            	<div class="SWLeft" style="z-index: 872;">
                                    <div class="SWRight" style="z-index: 870;">
                                        <div class="SWContent" style="z-index: 868;">
                                            <div class="SWBut" style="z-index: 866;"><a onclick="LoadTree()">Tìm ở</a></div>
                                            <div id="TreeFilter" style="z-index: 864;"><div style="display: inline; white-space: normal; z-index: 862;" id="map_path_div"><a onclick="TreeBinding.NavigatorClick(event,0,'Việt Nam','VN')">Việt Nam</a></div></div>
                                            <br style="clear: both;">
                                        </div>
                                        <a onclick="TreeBinding.ResetTree()" style="display: none;" class="SWCloseArea"></a>
                                    </div>
                            	</div>
                            </div>
                        </div>
                	</div>
                </div>
            </div>
            
            
        </div>
        <!--header-->
        

<style type="text/css">
    .AdminTool
    {
    	-moz-border-radius:5px 5px 0 0;
        background-color:#EFEFEF;
        border:1px solid #CCCCCC;
        bottom:0;
        left:10px;
        padding:2px 7px;
        position:fixed;
        border-bottom:0;
    }
</style>

<div id="login" style="z-index: 860;">
    <div id="line2" style="z-index: 858;">
        
                <a id="Signup" href="/Accounts/Signup.aspx?ReturnUrl=%2fMaps%2fvbdMap.aspx" class="line2reg">Đăng ký</a> |
                <a href="javascript:__doPostBack('QuickLogin1$LoginViewDefault$LoginStatus1$ctl02','')" class="line2login" id="QuickLogin1_LoginViewDefault_LoginStatus1">Đăng nhập</a>
            
    </div>
    <!--line2-->
    <a class="reg" href=""></a>
    <!--line3-->
</div>
<!--login-->
        <a onclick="changeLang()" class="lang-Eng"></a>
        
        <!--Login-->
        <div style="right: 8px; z-index: 856;" id="line4">
        	<a title="Công cụ chụp ảnh bản đồ" onclick="captureMap(map.getCenter())" class="CaptureMap"></a>
        	<a title="Lưu khung nhìn hiện tại" class="ReturnPageScreen">
            	<span onclick="SaveUserRegion()" class="SaveViewIcon" id="SaveView"></span>
            </a>
            <span class="SaveViewbor">
            	<a title="Phục hồi khung nhìn đã lưu" class="SaveView">
            		<span onclick="RestoreUserRegion()" class="ReturnPageScreenIcon" id="ReturnHome"></span>
            	</a>
            </span>
            <a title="In bản đồ" onclick="PrintResult()" class="PrintMap" id="PrintMap"></a>
            <a title="Gửi bản đồ" onclick="SendMap()" class="SendMap" id="SendMap"></a>
            
        </div>
        <!--line4-->
    </div>
    
    <!-- Select Place Box Template -->
    <div style="display: none; z-index: 854;" class="SelectPlace" id="SelectPlace">
        <div class="SelectPlaceArrow" style="z-index: 852;"></div>
        <a onclick="HideSelectPlaceBox()" href="javascript:void(0)" class="SelectPlaceCloseBut">
        Tắt</a>
        <div class="SelectPlaceDiv" style="z-index: 850;">
            <div class="SelectPlaceTitle" style="z-index: 848;">
                <h3 class="SPTitText">Hãy chọn vị trí cho điểm</h3><span class="a-z TitFlag">a</span>
            </div>
            <div style="position: relative; z-index: 846;" class="SelectPlaceContent" id="SelectPlaceContent"></div>
        </div>
    </div>
    <!-- End Select Place Box Template -->
    
    <!-- Add Place Form Template -->
    
    <!-- End Add Place Form Template -->
    
    
    
    <!--header_wrap-->
    <div id="content_wrap" style="z-index: 844;">
    		<div class="LeftPanel" id="leftpanel" style="height: 313px; z-index: 842;">
                    <div class="tableft" id="searchtabdiv" style="z-index: 840;">
                    	<!--Top Left Panel-->
                        <div style="display: none; z-index: 838;" class="topLeftPanel" id="topLeftSearchResult">
                            <a class="link" title="Xóa kết quả" id="clearSearchResultText">Xóa kết quả</a>
                        </div>
                        <div class="bodyLeftPanel padding" id="searchresult_div" style="height: 265px; z-index: 836;">
                        	<div class="MapHelp" id="tblMapHelp" style="z-index: 834;">
                            	<h3>Tính năng mới</h3>
                            	<ul style="z-index: 832;">
                            	    <li><a href="javascript:void(0)" onclick="$(this).HideTipsy();doSearch('dt: QST');ClickStatisticsInsert('Vietbando_Mobile','Vietbando Mobile')" onmouseout="$(this).HideTipsy();" onmouseover="$(this).ShowTipsy();" original-title="Cú pháp: &lt;b&gt;dt:&lt;/b&gt; &lt;u&gt;tên trường&lt;/u&gt; hoặc &lt;u&gt;mã trường&lt;/u&gt;">
                                        Tìm địa điểm thi đại học <span class="new">(new)</span></a></li>
                                	<li><a href="Help/Mobile.aspx?cs=1" onclick="ClickStatisticsInsert('Vietbando_Mobile','Vietbando Mobile')">
                                        Vietbando Mobile <span class="new">(new)</span></a></li>
                                	<li><a onclick="ClickStatisticsInsert('add_business','Đưa doanh nghiệp của bạn vào bản đồ')" href="/Maps/Help/Biz.aspx">
                                        Đưa doanh nghiệp của bạn vào bản đồ</a></li>
                                	<li><a onclick="loadAddPlaceFunc();ClickStatisticsInsert('add_location','Đưa vị trí của bạn vào bản đồ')">
                                        Đưa vị trí của bạn vào bản đồ.</a></li>
                                    <li><a onclick="installSearchEngine();ClickStatisticsInsert('install_vietbando_engine','Cài đặt Vietbando vào thanh tìm kiếm')">
                                        Cài đặt Vietbando vào thanh tìm kiếm</a></li>    
                                </ul>
                                <a style="display: block; height: 60px; margin-bottom: 30px;" onclick="window.open('Help/huongdanwap.aspx')" id="flash">
                                  <object height="60" width="290" codebase="http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=7,0,19,0" classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000">
                                    <param value="images/wapV.swf" name="movie">
                                    <param value="high" name="quality">
                                    <embed height="60" width="290" type="application/x-shockwave-flash" pluginspage="http://www.macromedia.com/go/getflashplayer" quality="high" src="images/wapV.swf">
                                  </object>
                                </a>
                                
                                <!--test-->
                                
                                <!--Endtest-->
                                

                                <h3>Hỗ trợ trực tuyến</h3>
                                <p></p>
                                <div class="ym" style="z-index: 830;"><a href="ymsgr:sendIM?hotro_vietbando"></a></div>
                                <div class="skype" style="z-index: 828;"><a href="skype:hotro_vietbando?chat"></a></div>
                                <div class="facebook" style="z-index: 826;"><a href="http://www.facebook.com/vietbando" target="_blank"></a></div>
                            </div>
                            
                            <!--<ul class="MapOptions" style="width:135px; display:none">
                                    <li style="padding-top:4px" class="topradius"><a href="#">Đăng ký sử dụng</a></li>
                                    <li><a href="#">Hướng dẫn sử dụng</a></li>
                                    <li class="separate"></li>
                                    <li><a href="#">Tài liệu tra cứu API</a></li>
                                    <li style="padding-bottom:4px" class="botradius"><a href="#">Ví dụ mẫu</a></li>
                            </ul>
                            <div id="TablePlace" style="display:none">
                            	<span class="countPlace">Kết quả từ <b>1-3</b> trong số <b>3</b> cho</span>
                                <span class="keyPlace">nha hang rex</span>
                                <div class="resultItem">
                                	<span style="background: url(images/1.gif) no-repeat center left" class="resultTitle"><a><b>Nhà Hàng</b> Cung Đình <b>Rex</b> (Royal Court <b>Restaurant</b></a></span>
                                    <div class="Spacer"></div>
                                    <p>141 Đường Nguyễn Huệ, Phường Bến Nghé, Quận 1, Thành Phố Hồ Chí Minh (08.38292186)</p>
                                    <ul class="resultOptions">
                                    	<li><a>Từ đây</a></li>
                                        <span>|</span>
                                        <li><a>Đến đây</a></li>
                                        <span>|</span>
                                        <li><a>Xem bản đồ</a></li>
                                        <span>|</span>
                                        <li><a>Chi tiết</a></li>
                                    </ul>
                                </div>
                                <div class="resultItem">
                                	<span style="background: url(images/2.gif) no-repeat center left" class="resultTitle"><a><b>Nhà Hàng</b> - Khách Sạn <b>Rex</b></a></span>
                                    <div class="Spacer"></div>
                                    <p>1 Đường Lê Quý Đôn, Phường 1, Thành Phố Vũng Tàu, Tỉnh Bà Rịa Vũng Tàu</p>
                                    <ul class="resultOptions">
                                    	<li><a>Từ đây</a></li>
                                        <span>|</span>
                                        <li><a>Đến đây</a></li>
                                        <span>|</span>
                                        <li><a>Xem bản đồ</a></li>
                                        <span>|</span>
                                        <li><a>Chi tiết</a></li>
                                    </ul>
                                </div>
                                <div class="resultItem">
                                    <span style="background: url(images/3.gif) no-repeat center left" class="resultTitle"><a><b>Nhà Hàng</b> - Khách Sạn Cung Đình <b>Rex</b></a></span>
                                    <div class="Spacer"></div>
                                    <p><img class="resultImg" src="UploadFolder/Store/1/200910/a841cf050ada465494ebc2a8797236cbnhahangrex.jpg"/>146-148 Đường Pasteur, Phường Bến Nghé, Quận 1, Thành Phố Hồ Chí Minh (08.38293115 - 08.38292185) Đây là một nhà hàng sang trọng, nằm ngay trung tâm Thành phố, nhà hàng là thành viên của Saigon Tourist. Nhà hàng Cung Đình có phục vụ điểm tâm, cơm trưa, cơm tối...</p>
                                    <ul class="resultOptions">
                                    	<li><a>Từ đây</a></li>
                                        <span>|</span>
                                        <li><a>Đến đây</a></li>
                                        <span>|</span>
                                        <li><a>Xem bản đồ</a></li>
                                        <span>|</span>
                                        <li><a>Chi tiết</a></li>
                                    </ul>
                                </div>
                                <ul class="resultPage">
                                	<li><span>« Đầu</span></li>
                                    <li><span>Trước</span></li>
                                    <li><span class="active_page">1</span></li>
                                    <li><a>2</a></li>
                                    <li><a>3</a></li>
                                    <li><a>4</a></li>
                                    <li><a>5</a></li>
                                    <li><a>6</a></li>
                                    <li><a>7</a></li>
                                    <li><a>Sau</a></li>
                                    <li><a>Cuối »</a></li>
                                </ul>
                            </div>-->
                        </div>
                    </div>
                    <div style="display: none; height: 297px; z-index: 824;" class="tableft" id="findpathtabdiv">
                    	<!--Top Left Panel-->
                        <div class="topLeftPanel" id="topLeftPathResult" style="z-index: 822;">
                            <span class="FindPathStatus" id="FindPathStatus"></span>
                            <a style="display: none;" class="link clearPathResult" title="Xóa kết quả" id="clearPathResultText">
                            Xóa kết quả</a>
                            <a onclick="FindReverseDirection()" class="link tdreverse" title="Chiều ngược lại" id="tdreverse">Chiều 
                            ngược lại</a>
                            <a onclick="PrintResult()" class="link printDirection" title="In lộ trình" id="printDirection">In lộ 
                            trình</a>
                            <div style="display: none; z-index: 820;" class="link" id="tdvehicle"></div>
                        </div>
                        <div class="bodyLeftPanel" id="findpath_div" style="height: 185px; z-index: 818;">
                            
                            <div id="listDirection" style="z-index: 816;">
                            	<div style="display: none; z-index: 814;" id="dirInputTemplate">
                                    <div class="direction-item" id="direction$section$" style="z-index: 812;">
                                        <div class="swrap-timduong" style="z-index: 810;">
                                            <span class="a-z">$order$</span>
                                            <input type="text" value="Nhập vào địa danh, địa chỉ..." onblur="OnblurTextBoxAB(this)" onfocus="OnforcusTextBoxAB(this)" onkeydown="return SearchPlaceEnter(event,$section$)" class="boxtimduong timduong-default">
                                            <a onclick="ClickRemovePlaceButton(this)" class="del-timduong" style="display: none;">
                                            Xóa</a>
                                            <a onclick="doSearchPlace($section$)" class="btn-timduong" id="btnSearchPlace$section$">Tìm</a>
                                        </div>
                                        <div id="guide$section$" style="z-index: 808;"></div>
                                    </div>
                                </div>
                                
                                <div class="direction-item" id="direction0" style="z-index: 806;">
                                    <div class="swrap-timduong" style="z-index: 804;">
                                        <span class="a-z">a</span>
                                        <input type="text" value="Nhập vào địa danh, địa chỉ..." onblur="OnblurTextBoxAB(this)" onfocus="OnforcusTextBoxAB(this)" onkeydown="return SearchPlaceEnter(event,0)" class="boxtimduong timduong-default">
                                        <a onclick="ClickRemovePlaceButton(this)" class="del-timduong" style="display: none;">
                                        Xóa</a>
                                        <a onclick="doSearchPlace(0)" class="btn-timduong" id="btnSearchPlace0">Tìm</a>
                                    </div>
                                    <div id="guide0" style="z-index: 802;"></div>
                                </div>
                                
                                <div class="direction-item" id="direction1" style="z-index: 800;">
                                    <div class="swrap-timduong" style="z-index: 798;">
                                        <span class="a-z">b</span>
                                        <input type="text" value="Nhập vào địa danh, địa chỉ..." onblur="OnblurTextBoxAB(this)" onfocus="OnforcusTextBoxAB(this)" onkeydown="return SearchPlaceEnter(event,1)" class="boxtimduong timduong-default">
                                        <a onclick="ClickRemovePlaceButton(this)" class="del-timduong" style="display: none;">
                                        Xóa</a>
                                        <a onclick="doSearchPlace(1)" class="btn-timduong" id="btnSearchPlace1">Tìm</a>
                                    </div>
                                    <div id="guide1" style="z-index: 796;"></div>
                                </div>
                            </div>
                        </div>
                        <div id="directionoptions" style="z-index: 794;">
                            <div style="float: left; padding: 0pt 5px 0pt 8px; width: 309px; z-index: 792;">
                                <!--<input style="vertical-align:middle" checked="checked" type="checkbox" id="avoidalley" class="check" />
                                <label class="quahem" for="avoidalley">Hạn chế qua hẻm</label><br />
                                <input style="vertical-align:middle" type="checkbox" id="avoidblock" class="check" />
                                <label class="raochan" for="avoidblock">Hạn chế qua rào chắn</label>-->
                                <a class="NotAlley-Off NotAlley-On" title="Hạn chế qua hẻm [Bật]" onclick="toggleAlley()" id="avoidalley">Hạn chế qua hẻm (On/Off)</a>
                                <a class="NotCons-Off" title="Hạn chế qua nút thắt giao thông [Tắt]" onclick="toggleBlock()" id="avoidblock">Hạn chế qua rào chắn (On/Off)</a>
                                <ul class="phuongtiendichuyen" style="z-index: 790;">
                                	<li><a class="pedestrian" title="Đi bộ">Đi bộ</a></li>
                                    <li><a class="motor motor-enable" title="Xe máy">Xe máy</a></li>
                                    <li><a class="car" title="Ô tô">Ô tô</a></li>
                                    <li><a class="lorry" title="Xe tải">Xe tải</a></li>
                                </ul>
                                <!--<select id="vehicle">
                                    <option value="1">Xe máy</option>
                                    <option value="2">Xe ô tô</option>
                                    <option value="3">Xe tải</option>
                                    <option value="5">Đi bộ</option>
                            	</select>-->
                            </div>
                        	<!--<a href="javascript:void(0)" onclick="FindAllPath()" class="ButTimDuong">Tìm 
                            đường</a>-->
                        </div>
                    </div>
                    <div style="display: none; z-index: 788;" class="tableft" id="mymaptabdiv">
						<div class="topLeftPanel" id="topLeftMyMapResult" style="z-index: 786;">
						    <ul class="mymapsubtab" style="z-index: 784;">
						        <li style="display: none;"><a onclick="MMSubTabChange(BUDDY_TAB)" id="buddy_tab"><span>Bạn tôi</span></a></li>
						        <li><a onclick="MMSubTabChange(FAVOURITE_TAB)" class="active" id="fav_tab"><span>Yêu thích</span></a></li>
                                <li><a onclick="MMSubTabChange(CREATEBYME_TAB)" id="createbyme_tab"><span>Bản đồ của tôi</span></a></li>
                                <li class="mymapsubtab-end"></li>
                            </ul>
                            <div style="display: none; z-index: 782;" id="mymaptoolbar">
                                <a id="createNewMap">Tạo bản đồ mới</a>
                                
                                <a class="back" style="display: none;" title="Quay lại" id="btnCancelMyMap"><span>Quay lại</span></a>
                                <a onclick="editMyMap()" class="edit" style="display: none;" title="Chỉnh sửa" id="btnEditMyMap"><span>Chỉnh sửa</span></a>
                                <a onclick="saveMyMap()" class="save" style="display: none;" title="Lưu" id="btnSaveMyMap"><span>Lưu</span></a>
                                <a class="trash" style="display: none;" title="Xóa" id="btnTrashMyMap"><span>Xóa</span></a>                                
                            </div>
                        </div>
                        <div style="display: none; z-index: 780;" class="bodyLeftPanel mymap_div" id="buddylist">
                            - Nhập địa chỉ nhà bạn
	                        - Tìm kiếm bạn bè (Chung trường cấp 1, cấp 2, cấp 3, gần nhà, chung ngành)
	                        - Chia sẻ vị trí hiện tại và trạng thái của bạn
	                        - Xem bạn bè hiện đang ở đâu và làm gì
                        </div>
                        <div id="MarkLocation" style="height: 243px; z-index: 778;">
                        <div style="z-index: 776;">                            
                            


<link type="text/css" rel="stylesheet" href="/Maps/control/PlacesManager/style/PlacesMangager.css">




<script type="text/javascript" src="/Maps/vbdScript/jquery.ui.js"></script>
<script type="text/javascript" src="/Maps/control/PlacesManager/js/PlacesManager.js"></script>



<div id="PlacesManager_Wrap" style="z-index: 774;">
    
    <div id="PlacesManager_Container_Wrap" style="z-index: 772;">
        
        <div id="ctr_PanelUnlogin" style="z-index: 770;">
	            
        
</div>
    </div>
</div>
                            
                        </div>
                        <div class="bodyLeftPanel mymap_div" id="MarkLocation_Cookie" style="z-index: 768;">
                            <div class="MapHelp MyMapHelp" style="z-index: 766;">
                                <h3>
                                    Hướng dẫn</h3>
                                <ul style="z-index: 764;">
                                    <span class="MyMapHelpspan">Bạn cần thực hiện các thao tác sau:</span>
                                    <li>Nhập vị trí cần tìm vào khung tìm kiếm của Vietbando.</li>
                                    <li>Chọn một vị trí để xem vị trí trên bản đồ.</li>
                                    <li>Nhấp chuột lên <span class="favToogle-Dis NonePadding favimg"></span>&nbsp;để đánh
                                        dấu vị trí yêu thích của bạn.</li>
                                    <li>Xem hướng dẫn chi tiết <a class="flnk" href="/Maps/Help/Web.aspx#link3yt" target="_blank">tại đây</a></li>
                                </ul>
                                <h3>
                                    Hỗ trợ trực tuyến</h3>
                                <p>
                                </p>
                                <div class="ym" style="z-index: 762;">
                                    <a href="ymsgr:sendIM?hotro_vietbando"></a>
                                </div>
                                <div class="skype" style="z-index: 760;">
                                    <a href="skype:hotro_vietbando?chat"></a>
                                </div>
                                <div class="facebook" style="z-index: 758;">
                                    <a href="http://www.facebook.com/vietbando" target="_blank"></a>
                                </div>
                            </div>
                        </div>                        
                    </div>
                        <div style="display: none; height: 217px; z-index: 756;" class="bodyLeftPanel mymap_div" id="mymap_div">
                            <div style="display: none; z-index: 754;" id="MyMapArea">
                            	<div id="InforOfMyMap" style="z-index: 752;">
                                	<h3>Thông tin của bản đồ</h3>
                                    <div id="MyMapInfo" style="z-index: 750;"></div>
                            	</div>
                            	<div id="MyMapCoorList" style="z-index: 748;">
                            	    <h3>Đối tượng trên bản đồ</h3>
                            	    <ul style="display: none; z-index: 746;" id="MyMapToolbar">
                                    	<li><a class="btnMove" onclick="selectToolbarBtn(this)" title="Di chuyển" id="btnMove">Con trỏ</a></li>
                                        <li><a class="btnAddPoint" onclick="selectToolbarBtn(this)" title="Thêm điểm" id="btnAddPoint">Thêm điểm</a></li>
                                        <li><a class="btnAddText" onclick="selectToolbarBtn(this)" title="Thêm chữ" id="btnAddText">Thêm ký tự</a></li>
                                        <li><a class="btnAddPolyline" onclick="selectToolbarBtn(this)" title="Thêm đường" id="btnAddPolyline">Thêm đường chọn</a></li>
                                        <li><a class="btnAddPolygon" onclick="selectToolbarBtn(this)" title="Thêm vùng" id="btnAddPolygon">Thêm vùng chọn</a></li>
                                    </ul>
                                    <span class="ToolbarExplain">Thay đổi vị trí các đối tượng</span>
                                    <ol class="listpins"></ol>
                                </div>
                            </div>
                            <div id="MyMapList" style="z-index: 744;">
                            	
                                <div class="MapHelp MyMapHelp" style="z-index: 742;">
                                    <h3>Hướng dẫn</h3>
                                    <ul style="z-index: 740;">
                                        <li>Bạn phải <a href="javascript:__doPostBack('QuickLogin1$LoginViewDefault$LoginStatus1$ctl02','')" class="flnk">đăng nhập</a> vào Vietbando để có thể tạo bản đồ riêng cho bạn.</li>
                                        <li>Click vào thanh công cụ bên trái bản đồ để thêm các đối tượng vào bản đồ của 
                                            bạn.</li>
                                        <li>Nhập thông tin của các đối tượng, nhấn nút lưu để lưu lại bản đồ. Bạn cũng có 
                                            thể sửa hoặc xóa bản đồ của mình.</li>
                                        <li>Xem hướng dẫn chi tiết <a class="flnk" href="/Maps/Help/Web.aspx#link3bdct" target="_blank">tại đây</a></li>
                                    </ul>
                                    
                                    <h3>Hỗ trợ trực tuyến</h3>
                                    <p></p>
                                    <div class="ym" style="z-index: 738;"><a href="ymsgr:sendIM?hotro_vietbando"></a></div>
                                    <div class="skype" style="z-index: 736;"><a href="skype:hotro_vietbando?chat"></a></div>
                                    <div class="facebook" style="z-index: 734;"><a href="http://www.facebook.com/vietbando" target="_blank"></a></div>
                        	    </div>
                            </div>
                        </div>
                    </div>
            </div>
        <div class="splExpand" id="centerSplit" style="height: 310px; z-index: 732;">
            <div class="topsp1Expand" style="z-index: 730;"></div>
            <div class="botsp1Expand" style="z-index: 728;"></div>
            <a onclick="moveIconClick()" class="moveicon" id="moveicon" style="top: 135px;"></a>
        </div>
        <div class="mainmap" id="container" style="width: 951px; height: 309px; position: absolute; overflow: hidden; cursor: url(&quot;http://image2.vietbando.com/API/Skins/WhiteSkin/images/openhand.cur&quot;), auto; background: none repeat scroll 0% 0% rgb(237, 234, 226); z-index: 726;">
            <div style="position: absolute; top: 180px; left: 300px; text-align: center;">
            </div>
        <div id="container_map1" style="position: absolute; overflow: hidden; left: 0pt; top: 0pt; width: 100%; height: 100%;"><div id="container_mapping" style="position: absolute; left: -229px; top: -34px; width: 1280px; height: 768px; z-index: 20;" class="dragmaparea"><div style="position: absolute; left: 0px; top: 0px;"><map name="usemapindex0_0" id="usemapindex0_0"></map><map name="usemapindex0_1" id="usemapindex0_1"></map><map name="usemapindex0_2" id="usemapindex0_2"></map><map name="usemapindex0_3" id="usemapindex0_3"></map><map name="usemapindex0_4" id="usemapindex0_4"></map><map name="usemapindex1_0" id="usemapindex1_0"></map><map name="usemapindex1_1" id="usemapindex1_1"></map><map name="usemapindex1_2" id="usemapindex1_2"></map><map name="usemapindex1_3" id="usemapindex1_3"></map><map name="usemapindex1_4" id="usemapindex1_4"></map><map name="usemapindex2_0" id="usemapindex2_0"></map><map name="usemapindex2_1" id="usemapindex2_1"></map><map name="usemapindex2_2" id="usemapindex2_2"></map><map name="usemapindex2_3" id="usemapindex2_3"></map><map name="usemapindex2_4" id="usemapindex2_4"></map></div></div><div id="container_inner" style="position: absolute; left: -229px; top: -34px; width: 1280px; height: 768px; z-index: 20;" class="dragmap"><div style="position: absolute; left: 0px; top: 0px;"><img height="256px" width="256px" usemap="#usemapindex0_0" ismap="" src="http://image2.vietbando.com/mapimageservice.ashx?Action=GetTiles&amp;Level=5&amp;X=23&amp;Y=14" style="border: 0px none; margin: 0px; padding: 0px; position: absolute; -moz-user-select: none; left: 0px; top: 0px; width: 256px; height: 256px;" id="23_14"><img height="256px" width="256px" usemap="#usemapindex0_1" ismap="" src="http://image2.vietbando.com/mapimageservice.ashx?Action=GetTiles&amp;Level=5&amp;X=24&amp;Y=14" style="border: 0px none; margin: 0px; padding: 0px; position: absolute; -moz-user-select: none; left: 256px; top: 0px; width: 256px; height: 256px;" id="24_14"><img height="256px" width="256px" usemap="#usemapindex0_2" ismap="" src="http://image2.vietbando.com/mapimageservice.ashx?Action=GetTiles&amp;Level=5&amp;X=25&amp;Y=14" style="border: 0px none; margin: 0px; padding: 0px; position: absolute; -moz-user-select: none; left: 512px; top: 0px; width: 256px; height: 256px;" id="25_14"><img height="256px" width="256px" usemap="#usemapindex0_3" ismap="" src="http://image2.vietbando.com/mapimageservice.ashx?Action=GetTiles&amp;Level=5&amp;X=26&amp;Y=14" style="border: 0px none; margin: 0px; padding: 0px; position: absolute; -moz-user-select: none; left: 768px; top: 0px; width: 256px; height: 256px;" id="26_14"><img height="256px" width="256px" usemap="#usemapindex0_4" ismap="" src="http://image2.vietbando.com/mapimageservice.ashx?Action=GetTiles&amp;Level=5&amp;X=27&amp;Y=14" style="border: 0px none; margin: 0px; padding: 0px; position: absolute; -moz-user-select: none; left: 1024px; top: 0px; width: 256px; height: 256px;" id="27_14"><img height="256px" width="256px" usemap="#usemapindex1_0" ismap="" src="http://image2.vietbando.com/mapimageservice.ashx?Action=GetTiles&amp;Level=5&amp;X=23&amp;Y=15" style="border: 0px none; margin: 0px; padding: 0px; position: absolute; -moz-user-select: none; left: 0px; top: 256px; width: 256px; height: 256px;" id="23_15"><img height="256px" width="256px" usemap="#usemapindex1_1" ismap="" src="http://image2.vietbando.com/mapimageservice.ashx?Action=GetTiles&amp;Level=5&amp;X=24&amp;Y=15" style="border: 0px none; margin: 0px; padding: 0px; position: absolute; -moz-user-select: none; left: 256px; top: 256px; width: 256px; height: 256px;" id="24_15"><img height="256px" width="256px" usemap="#usemapindex1_2" ismap="" src="http://image2.vietbando.com/mapimageservice.ashx?Action=GetTiles&amp;Level=5&amp;X=25&amp;Y=15" style="border: 0px none; margin: 0px; padding: 0px; position: absolute; -moz-user-select: none; left: 512px; top: 256px; width: 256px; height: 256px;" id="25_15"><img height="256px" width="256px" usemap="#usemapindex1_3" ismap="" src="http://image2.vietbando.com/mapimageservice.ashx?Action=GetTiles&amp;Level=5&amp;X=26&amp;Y=15" style="border: 0px none; margin: 0px; padding: 0px; position: absolute; -moz-user-select: none; left: 768px; top: 256px; width: 256px; height: 256px;" id="26_15"><img height="256px" width="256px" usemap="#usemapindex1_4" ismap="" src="http://image2.vietbando.com/mapimageservice.ashx?Action=GetTiles&amp;Level=5&amp;X=27&amp;Y=15" style="border: 0px none; margin: 0px; padding: 0px; position: absolute; -moz-user-select: none; left: 1024px; top: 256px; width: 256px; height: 256px;" id="27_15"><img height="256px" width="256px" usemap="#usemapindex2_0" ismap="" src="http://image2.vietbando.com/mapimageservice.ashx?Action=GetTiles&amp;Level=5&amp;X=23&amp;Y=16" style="border: 0px none; margin: 0px; padding: 0px; position: absolute; -moz-user-select: none; left: 0px; top: 512px; width: 256px; height: 256px;" id="23_16"><img height="256px" width="256px" usemap="#usemapindex2_1" ismap="" src="http://image2.vietbando.com/mapimageservice.ashx?Action=GetTiles&amp;Level=5&amp;X=24&amp;Y=16" style="border: 0px none; margin: 0px; padding: 0px; position: absolute; -moz-user-select: none; left: 256px; top: 512px; width: 256px; height: 256px;" id="24_16"><img height="256px" width="256px" usemap="#usemapindex2_2" ismap="" src="http://image2.vietbando.com/mapimageservice.ashx?Action=GetTiles&amp;Level=5&amp;X=25&amp;Y=16" style="border: 0px none; margin: 0px; padding: 0px; position: absolute; -moz-user-select: none; left: 512px; top: 512px; width: 256px; height: 256px;" id="25_16"><img height="256px" width="256px" usemap="#usemapindex2_3" ismap="" src="http://image2.vietbando.com/mapimageservice.ashx?Action=GetTiles&amp;Level=5&amp;X=26&amp;Y=16" style="border: 0px none; margin: 0px; padding: 0px; position: absolute; -moz-user-select: none; left: 768px; top: 512px; width: 256px; height: 256px;" id="26_16"><img height="256px" width="256px" usemap="#usemapindex2_4" ismap="" src="http://image2.vietbando.com/mapimageservice.ashx?Action=GetTiles&amp;Level=5&amp;X=27&amp;Y=16" style="border: 0px none; margin: 0px; padding: 0px; position: absolute; -moz-user-select: none; left: 1024px; top: 512px; width: 256px; height: 256px;" id="27_16"></div></div><div id="container_animation" style="position: absolute; left: -229px; top: -34px; width: auto; height: auto; z-index: 10;" class="dragmap"><table cellspacing="0" cellpadding="0" border="0" id="table_container"><thead><tr><th></th><th></th><th></th></tr></thead><tbody><tr><td><img ismap="" style="height: 256px; width: 256px;" src="http://image2.vietbando.com/API/Skins/WhiteSkin/images/transparent.png" id="containeranimation_0_0"></td><td><img ismap="" style="height: 256px; width: 256px;" src="http://image2.vietbando.com/API/Skins/WhiteSkin/images/transparent.png" id="containeranimation_0_1"></td><td><img ismap="" style="height: 256px; width: 256px;" src="http://image2.vietbando.com/API/Skins/WhiteSkin/images/transparent.png" id="containeranimation_0_2"></td><td><img ismap="" style="height: 256px; width: 256px;" src="http://image2.vietbando.com/API/Skins/WhiteSkin/images/transparent.png" id="containeranimation_0_3"></td><td><img ismap="" style="height: 256px; width: 256px;" src="http://image2.vietbando.com/API/Skins/WhiteSkin/images/transparent.png" id="containeranimation_0_4"></td></tr><tr><td><img ismap="" style="height: 256px; width: 256px;" src="http://image2.vietbando.com/API/Skins/WhiteSkin/images/transparent.png" id="containeranimation_1_0"></td><td><img ismap="" style="height: 256px; width: 256px;" src="http://image2.vietbando.com/API/Skins/WhiteSkin/images/transparent.png" id="containeranimation_1_1"></td><td><img ismap="" style="height: 256px; width: 256px;" src="http://image2.vietbando.com/API/Skins/WhiteSkin/images/transparent.png" id="containeranimation_1_2"></td><td><img ismap="" style="height: 256px; width: 256px;" src="http://image2.vietbando.com/API/Skins/WhiteSkin/images/transparent.png" id="containeranimation_1_3"></td><td><img ismap="" style="height: 256px; width: 256px;" src="http://image2.vietbando.com/API/Skins/WhiteSkin/images/transparent.png" id="containeranimation_1_4"></td></tr><tr><td><img ismap="" style="height: 256px; width: 256px;" src="http://image2.vietbando.com/API/Skins/WhiteSkin/images/transparent.png" id="containeranimation_2_0"></td><td><img ismap="" style="height: 256px; width: 256px;" src="http://image2.vietbando.com/API/Skins/WhiteSkin/images/transparent.png" id="containeranimation_2_1"></td><td><img ismap="" style="height: 256px; width: 256px;" src="http://image2.vietbando.com/API/Skins/WhiteSkin/images/transparent.png" id="containeranimation_2_2"></td><td><img ismap="" style="height: 256px; width: 256px;" src="http://image2.vietbando.com/API/Skins/WhiteSkin/images/transparent.png" id="containeranimation_2_3"></td><td><img ismap="" style="height: 256px; width: 256px;" src="http://image2.vietbando.com/API/Skins/WhiteSkin/images/transparent.png" id="containeranimation_2_4"></td></tr></tbody></table></div></div><div id="container_path" style="position: absolute; left: 0pt; top: 0pt; z-index: 40;"><div style="position: absolute; left: 0pt; top: 0pt; z-index: 45;"></div><div style="position: absolute; left: 0pt; top: 0pt; z-index: 44;"><svg overflow="visible" style="position: absolute;"/></div><div style="position: absolute; left: 0pt; top: 0pt;" class="dragCustomOverlay"></div><div style="position: absolute; left: 0pt; top: 0pt; z-index: 51;"></div></div><div id="container_VLargeMapControl" style="position: absolute; left: 10px; top: 10px; width: auto; height: auto; z-index: 70; -moz-user-select: none;" class="clickcontrol "><div class="MapMove"><a id="container_btTop" class="clickcontrol MMTop">Bắc^</a><a id="container_btRight" class="MMRight">Đông?</a><a id="container_btBottom" class="clickcontrol MMBot">Namv</a><a id="container_btLeft" class="clickcontrol MMLeft">Tây?</a><a id="container_btTopRight" class="clickcontrol MMTopRight">Đông Bắc</a><a id="container_btBottomRight" class="clickcontrol MMBotRight">Đông Nam</a><a id="container_btBottomLeft" class="clickcontrol MMBotLeft">Tây Nam</a><a id="container_btTopLeft" class="clickcontrol MMTopLeft">Tây Bắc</a><a id="container_btFit" class="clickcontrol MMCenter">Tâm</a></div><div class="MapZoom-top"><div class="MapZoom-bot"><div style="height: 152px;" id="container_rulerBar" class="clickcontrol MapZoom-center"></div></div><a id="container_btZoomIn" class="clickcontrol MZIn">ZoomIn[+]</a><a id="container_btZoomOut" class="clickcontrol MZOut">ZoomOut[-]</a><div id="container_rulerDiv" class="dragruler MZScroll" style="top: 134px;"></div><div style="left: 25px; top: 38px; display: none;" id="container_barWard" class="ZoomPinLeft"><div class="ZoomPinRight"><div class="clickcontrol ZoomPinCenter">Phường</div></div></div><div style="left: 25px; top: 70px; display: none;" id="container_barDistrict" class="ZoomPinLeft"><div class="ZoomPinRight"><div class="clickcontrol ZoomPinCenter">Quận</div></div></div><div style="left: 25px; top: 102px; display: none;" id="container_barCity" class="ZoomPinLeft"><div class="ZoomPinRight"><div class="clickcontrol ZoomPinCenter">Thành phố</div></div></div><div style="left: 25px; top: 134px; display: none;" id="container_barCountry" class="ZoomPinLeft"><div class="ZoomPinRight"><div class="clickcontrol ZoomPinCenter">Quốc gia</div></div></div></div></div><div id="container_VScaleControl" style="position: absolute; left: 10px; top: 280px; width: auto; height: auto; z-index: 70; -moz-user-select: none;"><table height="20px" cellspacing="0px" cellpadding="0px" align="left"><tbody><tr height="10px" valign="bottom"><td valign="bottom" align="left" style="font-size: 8pt; color: black; font-family: Tahoma; height: 1px;" id="container_Units">500 km</td></tr><tr valign="top"><td height="6px" valign="top" align="left"><img height="8px" width="200px" align="top" src="http://image2.vietbando.com/API/Skins/WhiteSkin/images/RulerB.gif" id="container_Ruler" style="width: 105.365px;"></td></tr></tbody></table></div><div id="container_VOverviewMapControl" style="position: absolute; overflow: hidden; left: 799px; top: 178px; width: 151px; height: 131px; z-index: 70; -moz-user-select: none; border-left: 1px solid rgb(0, 114, 204); border-top: 1px solid rgb(0, 114, 204);" class="clickcontrol VOverviewMapControl MiniMapBorderBottomRight"><div style="height: 123px; width: 143px; position: absolute; overflow: hidden; margin-top: 5px; margin-left: 5px;" class="VOverviewBound" id="container_VOverviewBound"><div style="left: -85.0312px; width: 568px; position: absolute; top: -174.812px; height: 568px; background-color: white; overflow: hidden;" class="overviewmap" id="container_VOverviewBox"><table height="512px" width="512px" cellspacing="0" cellpadding="0" border="0" id="container_VOverviewTable"><thead><tr><th></th><th></th></tr></thead><tbody><tr><td><img height="256px" width="256px" ismap="" id="containers_0_0" src="http://image2.vietbando.com/mapimageservice.ashx?Action=GetTiles&amp;Level=1&amp;X=1&amp;Y=0"></td><td><img height="256px" width="256px" ismap="" id="containers_0_1" src="http://image2.vietbando.com/mapimageservice.ashx?Action=GetTiles&amp;Level=1&amp;X=0&amp;Y=0"></td></tr><tr><td><img height="256px" width="256px" ismap="" id="containers_1_0" src="http://image2.vietbando.com/mapimageservice.ashx?Action=GetTiles&amp;Level=1&amp;X=1&amp;Y=1"></td><td><img height="256px" width="256px" ismap="" id="containers_1_1" src="http://image2.vietbando.com/mapimageservice.ashx?Action=GetTiles&amp;Level=1&amp;X=0&amp;Y=1"></td></tr></tbody></table></div><div style="opacity: 0.5; border: 2px double rgb(0, 102, 204); left: 42px; background-image: url(&quot;http://image2.vietbando.com/API/Skins/WhiteSkin/images/sm_trans.gif&quot;); width: 59px; position: absolute; top: 52px; height: 19px; background-color: rgb(213, 242, 255);" id="container_VCenterRect"></div><div style="opacity: 0.2; border: 2px double rgb(0, 102, 204); left: 42px; background-image: url(&quot;http://image2.vietbando.com/API/Skins/WhiteSkin/images/sm_trans.gif&quot;); width: 59px; position: absolute; top: 52px; height: 19px; background-color: transparent;" id="container_VOverviewRect" class="dragoverview"></div><div align="left" style="left: 124px; overflow: hidden; cursor: pointer; position: absolute; top: 104px; background-color: white;" title="Bật/Tắt bản đồ nhỏ" id="container_VBtnOnOffOverviewMap"><a class="clickcontrol MiniMapBut1" id="container_VImgOnOff"></a></div></div></div><div id="container_MapToolbar" class="clickcontrol MapToolbar" style="position: absolute; text-align: right; width: 286px; height: 27px; background-color: transparent; right: 5px; top: 0px; z-index: 70;"><div class="MapTools">                                    <a class="MTools-raochanDis" id="ViewBlockHouse"></a>                                    <a class="MTools-ranhgioiDis" id="ViewGeo"></a>                                    <a class="MTools-dokhcachDis" id="MeasureDis"></a>                                </div></div><div id="containerl1" style="position: absolute; overflow: hidden; left: 0pt; top: 0pt; width: 1px; height: 310px; background: none repeat scroll 0pt 0pt rgb(0, 0, 0); opacity: 0.08; display: block; z-index: 100;"></div><div id="containert1" style="position: absolute; overflow: hidden; left: 0pt; top: 0pt; width: 951px; height: 1px; background: none repeat scroll 0pt 0pt rgb(0, 0, 0); opacity: 0.08; display: block; z-index: 100;"></div><div id="containerl2" style="position: absolute; overflow: hidden; left: 0pt; top: 0pt; width: 2px; height: 310px; background: none repeat scroll 0pt 0pt rgb(0, 0, 0); opacity: 0.06; display: block; z-index: 100;"></div><div id="containert2" style="position: absolute; overflow: hidden; left: 0pt; top: 0pt; width: 951px; height: 2px; background: none repeat scroll 0pt 0pt rgb(0, 0, 0); opacity: 0.06; display: block; z-index: 100;"></div><div id="containerl3" style="position: absolute; overflow: hidden; left: 0pt; top: 0pt; width: 3px; height: 310px; background: none repeat scroll 0pt 0pt rgb(0, 0, 0); opacity: 0.04; display: block; z-index: 100;"></div><div id="containert3" style="position: absolute; overflow: hidden; left: 0pt; top: 0pt; width: 951px; height: 3px; background: none repeat scroll 0pt 0pt rgb(0, 0, 0); opacity: 0.04; display: block; z-index: 100;"></div><div id="containerl4" style="position: absolute; overflow: hidden; left: 0pt; top: 0pt; width: 4px; height: 310px; background: none repeat scroll 0pt 0pt rgb(0, 0, 0); opacity: 0.02; display: block; z-index: 100;"></div><div id="containert4" style="position: absolute; overflow: hidden; left: 0pt; top: 0pt; width: 951px; height: 4px; background: none repeat scroll 0pt 0pt rgb(0, 0, 0); opacity: 0.02; display: block; z-index: 100;"></div></div>
        <div class="footer" style="display: none; top: 407px; z-index: 724;" id="copyright"></div>
    </div>
    <!--content_wrap-->
    </div>
</form>













<div class="taskbar">
	<div style="background: url('images/street1.png') no-repeat scroll left center transparent;" class="taskbar_title">
    	<a href="http://localhost/cantho-map" onclick="" class="menu_taskbar">Đường Đi</a>
    </div>
   	<div style="background: url('images/start.png') no-repeat scroll left center transparent;" class="taskbar_title">
    	<a href="http://localhost/cantho-map" onclick="" class="menu_taskbar">Cơ Quan</a>
    </div>
	<div style="background: url('images/hospital.gif') no-repeat scroll left center transparent;" class="taskbar_title">
    	<a href="http://localhost/cantho-map" onclick="" class="menu_taskbar">Bệnh Viện</a>
    </div>
    <div style="background: url('images/hotel.png') no-repeat scroll left center transparent;" class="taskbar_title">
    	<a href="http://localhost/cantho-map" onclick="" class="menu_taskbar">Khách Sạn</a>
    </div>
    <div style="background: url('images/school.png') no-repeat scroll left center transparent;" class="taskbar_title">
    	<a href="http://localhost/cantho-map" onclick="" class="menu_taskbar">Trường Học</a>
    </div>
        <div style="background: url('images/company.png') no-repeat scroll left center transparent;" class="taskbar_title">
    	<a href="http://localhost/cantho-map" onclick="" class="menu_taskbar">Công Ty</a>
    </div>
    <div style="background: url('images/market.png') no-repeat scroll left center transparent;" class="taskbar_title">
    	<a href="http://localhost/cantho-map" onclick="" class="menu_taskbar">Chợ</a>
    </div>
	
	<div style="background: url('images/car.png') no-repeat scroll left center transparent;" class="taskbar_title">
    	<a href="http://localhost/cantho-map" onclick="" class="menu_taskbar">Bến Tàu Xe</a>
    </div>
                <div class="taskbar_vip">
    	<div style="margin-left: 40px; margin-right: 3px;">
        	<marquee scrolldelay="1" scrollamount="1" behavior="scroll" onmouseout="this.start();" onmouseover="this.stop();">
				<a title="" href="http://vinhlonginfo.com/ads/category/7/detail/1002" 
				class="menu_taskbar">• QUAN NINH KIEU</a>
				<a title="" href="http://vinhlonginfo.com/ads/category/30/detail/986" 
				class="menu_taskbar">• QUAN BINH THUY</a>
				<a title="" href="http://vinhlonginfo.com/ads/category/26/detail/405" 
				class="menu_taskbar">• QUAN CAI RANG</a>
				</marquee>
        </div>
    </div>
    </div>
</body>
</html>
