/*
 *  ------   [Ut_06] - Stack EEPROM Basic operation   -------- 
 *
 *  Explanation: This example shows how to use the Stack EEPROM
 *  library of Waspmote in order to store and get pending frames
 *  using the EEPROM memory of the Waspmote device
 *
 *  Copyright (C) 2016 Libelium Comunicaciones Distribuidas S.L. 
 *  http://www.libelium.com 
 *  
 *  This program is free software: you can redistribute it and/or modify 
 *  it under the terms of the GNU General Public License as published by 
 *  the Free Software Foundation, either version 3 of the License, or 
 *  (at your option) any later version. 
 *  
 *  This program is distributed in the hope that it will be useful, 
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of 
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the 
 *  GNU General Public License for more details. 
 *  
 *  You should have received a copy of the GNU General Public License 
 *  along with this program.  If not, see <http://www.gnu.org/licenses/>. 
 *  
 *  Version:           3.0
 *  Design:            David Gascon 
 *  Implementation:    Alejandro Gallego
 */


#include <WaspStackEEPROM.h>
#include <WaspFrame.h>       

int answer;

void setup() 
{
  
  // set Waspmote ID
  frame.setID("node_001");
  
  //////////////////////////////////////////////////
  // 1. inits the block size and the stack  
  //////////////////////////////////////////////////
  
  // init block size
  USB.println(F("Set Block Size to '100' Bytes"));
  stack.initBlockSize(100);
  
  // clear stack initializing to zeros
  USB.println(F("Clearing Stack..."));
  answer = stack.initStack();
  if (answer == 1)
  {   
    USB.println(F("Stack initialized"));
  }
  else
  {   
    USB.println(F("Stack NOT initialized"));
  }
  
  USB.print(F("Number of stored frames:"));
  USB.println(stack.getStoredFrames());

}



void loop() 
{

  //////////////////////////////////////////////////
  // 2. Create a frame
  //////////////////////////////////////////////////
  
  // Create new frame (ASCII)
  frame.createFrame(ASCII); 
  // set frame fields (String - char*)
  frame.addSensor(SENSOR_STR, (char*) "Stack_example");
  // set frame fields (Battery sensor - uint8_t)
  frame.addSensor(SENSOR_BAT, (uint8_t) PWR.getBatteryLevel());

  USB.println(F("Frame to store:"));
  frame.showFrame();


  //////////////////////////////////////////////////
  // 3. push frame into the stack
  //////////////////////////////////////////////////
  answer = stack.push( frame.buffer, frame.length);
  if (answer == 1)
  {   
    USB.println(F("Frame pushed"));
  }
  else if (answer == 2)
  {   
    USB.println(F("Stack is full, frame not pushed"));
  }
  else if (answer == 3)
  {   
    USB.println(F("Block size too small, frame not pushed"));
  }
  else
  {   
    USB.println(F("Error pushing the frame"));
  }


  USB.print(F("Number of stored frames:"));
  USB.println(stack.getStoredFrames());

  //////////////////////////////////////////////////
  // 4. pop frame from the stack
  //////////////////////////////////////////////////
  frame.length = stack.pop( frame.buffer );
  
  if (frame.length > 2)
  {   
    USB.println(F("Frame extracted:"));
    frame.showFrame();
  }
  else if (frame.length == 0)
  {   
    USB.println(F("Stack is empty, frame not extracted"));
  }
  else if (frame.length == 1)
  {   
    USB.println(F("Error reading the EEPROM, frame not extracted"));
  }
  else
  {   
    USB.println(F("Error updating the new pointer"));
  }

  USB.print(F("Number of stored frames:"));
  USB.println(stack.getStoredFrames());
  
  USB.println();
  USB.println();
  delay(5000);

}<!DOCTYPE html>

<!--

                                                      )[            ....   
                                                   -$wj[        _swmQQWC   
                                                    -4Qm    ._wmQWWWW!'    
                                                     -QWL_swmQQWBVY"~.____ 
                                                     _dQQWTY+vsawwwgmmQWV! 
                                    1isas,       _mgmQQQQQmmQWWQQWVY!"-    
                                   .s,. -?ha     -9WDWU?9Qz~-         
                                   -""?Ya,."h,   <!`_mT!2-?5a,             
                                   -Swa. Yg.-Q,  ~ ^`  /`   "$a.           
 aac  <aa, aa/                aac  _a,-4c ]k +m               "1           
.QWk  ]VV( QQf   .      .     QQk  )YT`-C.-? -Y  .                         
.QWk       WQmymmgc  <wgmggc. QQk       wgz  = gygmgwagmmgc                
.QWk  jQQ[ WQQQQQQW;jWQQ  QQL QQk  ]WQ[ dQk  ) QF~"WWW(~)QQ[               
.QWk  jQQ[ QQQ  QQQ(mWQ9VVVVT QQk  ]WQ[ mQk  = Q;  jWW  :QQ[               
 WWm,,jQQ[ QQQQQWQW']WWa,_aa. $Qm,,]WQ[ dQm,sj Q(  jQW  :QW[               
 -TTT(]YT' TTTYUH?^  ~TTB8T!` -TYT[)YT( -?9WTT T'  ]TY  -TY(               
                 
                      www.libelium.com

-->

<html xmlns="http://www.w3.org/1999/xhtml" lang="en-US">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<meta name="viewport" content="width=1024, user-scalable = yes">

<title>UT 06: Stack EEPROM | Libelium</title>

<link rel="shortcut icon" href="/favicon.ico" type="image/x-icon" />

<!-- <link rel="stylesheet" href="/wp-content/themes/libelium/css/style.min.css" type="text/css" />
 -->

<script type="text/javascript" src="/wp-content/themes/libelium/js/jquery-1.10.2.min.js"></script>


<!--[if lt IE 9]>
<script src="/wp-content/themes/libelium/js/html5shiv.js"></script>
<link rel="stylesheet" href="/wp-content/themes/libelium/css/ie.css" type="text/css" />
<![endif]-->

<!--[if gte IE 9]>
  <style type="text/css">
    .gradient {
       filter: none;
    }
  </style>
<![endif]-->

<link rel="pingback" href="http://www.libelium.com/xmlrpc.php" />

<link rel='stylesheet' id='ab_prettyphotozoom2-css'  href='http://www.libelium.com/extras/prettyphoto-libelium/prettyPhoto_3.1.32/css/prettyPhoto.css?ver=3.5.1' type='text/css' media='all' />
<link rel='stylesheet' id='libelium-css-css'  href='http://www.libelium.com/wp-content/themes/libelium/css/style.min.css?ver=1492420475' type='text/css' media='all' />
<script type='text/javascript' src='http://www.libelium.com/wp-includes/js/jquery/jquery.js?ver=1.8.3'></script>
<script type='text/javascript' src='http://www.libelium.com/extras/prettyphoto-libelium/prettyPhoto_3.1.32/js/jquery.prettyPhoto.js?ver=1.0'></script>
<script type='text/javascript' src='http://www.libelium.com/extras/prettyphoto-libelium/prettyPhoto_3.1.32/js/launch.js?ver=3.5.1'></script>
<meta name="keywords" content="eeprom,general,waspmote" />
<link rel="canonical" href="http://www.libelium.com/development/waspmote/examples/ut-06-stack-eeprom-basic-operation/" />
<link rel="stylesheet" title="Default" href="http://www.libelium.com/extras/lphpjs/highlight/styles/vs.css"> 
<script type="text/javascript" src="http://www.libelium.com/extras/lphpjs/highlight/highlight.pack.js"></script>
<link rel="alternate" type="application/rss+xml" title="Libelium - Connecting Sensors to the Cloud RSS Feed" href="http://www.libelium.com/feed/" />
<script type="text/javascript">
var lang = 'EN';function getText(text) {var re = new RegExp("<!--:" + lang + "-->(.*?)<!--:-->");return text.match(re)[1]}function visor_page(id_page, padding, alto) {$('#visor').remove();$('#visor_tmp').remove();$('body').css('overflow', 'hidden').append('<div id="visor_tmp"></div><div id="visor"><div id="visor_border"><div id="visor_close">&#10005;</div><div id="visor_content"></div></div></div>');$('#visor').height($(document).height());$('#visor_content').hide();$('#visor_border').css({'margin-top':($(window).height()-$('#visor_border').height()-25)/2, 'position': 'fixed', 'margin-left': ($(window).width()-$('#visor_border').width())/2});$.ajax({type: 'POST',url: "/ajax-controller",async: false,data: {action: 'get_page',page: id_page ,lang: 'EN'},success: function(data, textStatus, XMLHttpRequest){if (!padding) { $('#visor_content').css('padding',0); $('#visor_tmp').css('padding',0); }$('#visor_tmp').width($('#visor_content').width()).append(data);if (alto != undefined && alto < 0.8*$(window).height()) {$('#visor_tmp').height(alto);var height = alto}else {if (!padding) {var height = ($('#visor_tmp').height()+20> 0.8*$(window).height())? 0.8*$(window).height() : $('#visor_tmp').height()+2; }else {var height = ($('#visor_tmp').height()+20> 0.8*$(window).height())? 0.8*$(window).height() : $('#visor_tmp').height()+20}}$('#visor_tmp').remove();$('#visor_border').css({'position': 'fixed', 'margin-left': ($(window).width()-$('#visor_border').width())/2 }).animate({'margin-top':($(window).height()-height-25)/2,'height': height}, '', '', function() { $('#visor_close').fadeIn() });if (!padding) $('#visor_content').height(height-2).html(data).fadeIn(1500);else $('#visor_content').height(height-34).html(data).fadeIn(1500);$('#visor_close').click(function() { $('body').css('overflow','visible'); $('#visor').remove() })}})}function visor_text(txt, padding, ancho , alto) {if (padding == undefined) padding = true;$('#visor').remove();$('#visor_tmp').remove();$('body').css('overflow', 'hidden').append('<div id="visor_tmp"></div><div id="visor"><div id="visor_border"><div id="visor_close">&#10005;</div><div id="visor_content"></div></div></div>');if (!padding) { $('#visor_content').css('padding',0); $('#visor_tmp').css('padding',0); }if (ancho != undefined) {$('#visor_close').css('margin-left', ancho);$('#visor_border').width(ancho+2)}$('#visor').height($(document).height());$('#visor_content').hide();$('#visor_border').css({'margin-top':($(window).height()-$('#visor_border').height()-25)/2, 'position': 'fixed', 'margin-left': ($(window).width()-$('#visor_border').width())/2});$('#visor_tmp').append(txt);if (alto == undefined)var height = ($('#visor_tmp').height()+20> 0.9*$(window).height())? 0.8*$(window).height() : $('#visor_tmp').height()+((!padding)? 15 : 30);else var height = alto;if ($('#visor_tmp').height()+20<= 0.9*$(window).height()) $('#visor_content').css('overflow','hidden');$('#visor_tmp').remove();$('#visor_border').css({'position': 'fixed', 'margin-left': ($(window).width()-$('#visor_border').width())/2 }).animate({'margin-top':($(window).height()-height-25)/2,'height': height-((!padding)? 28 : 0)}, '', '', function() { $('#visor_close').fadeIn() }); $('#visor_content').height(height-34).html(txt).fadeIn(1500);$('#visor_close').click(function() { $('body').css('overflow','visible'); $('#visor').remove() })}function decode64(input) { var output = ""; var chr1, chr2, chr3 = ""; var enc1, enc2, enc3, enc4 = ""; var i = 0; var keyStr = "ABCDEFGHIJKLMNOP" + "QRSTUVWXYZabcdef" + "ghijklmnopqrstuv" + "wxyz0123456789+/" + "="; var base64test = /[^A-Za-z0-9\+\/\=]/g; if (base64test.exec(input)) {alert("There were invalid base64 characters in the input text.\n" +"Valid base64 characters are A-Z, a-z, 0-9, '+', '/',and '='\n" +"Expect errors in decoding."); } input = input.replace(/[^A-Za-z0-9\+\/\=]/g, ""); do {enc1 = keyStr.indexOf(input.charAt(i++));enc2 = keyStr.indexOf(input.charAt(i++));enc3 = keyStr.indexOf(input.charAt(i++));enc4 = keyStr.indexOf(input.charAt(i++));chr1 = (enc1 << 2) | (enc2 >> 4);chr2 = ((enc2 & 15) << 4) | (enc3 >> 2);chr3 = ((enc3 & 3) << 6) | enc4;output = output + String.fromCharCode(chr1);if (enc3 != 64) { output = output + String.fromCharCode(chr2)}if (enc4 != 64) { output = output + String.fromCharCode(chr3)}chr1 = chr2 = chr3 = "";enc1 = enc2 = enc3 = enc4 = ""; } while (i < input.length); return unescape(output)}function scroll_to_id(id) {if ($('#'+id).length) {var position = $('#'+id).position();$('html, body').animate({scrollTop: position.top})} }
</script>
<script type="text/javascript">

  var _gaq = _gaq || [];
  _gaq.push(['_setAccount', 'UA-22686813-1']);
  _gaq.push(['_trackPageview']);

  (function() {
    var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
    ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
    var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
  })();

</script>

<!-- Start Visual Website Optimizer Asynchronous Code -->
<script type='text/javascript'>
var _vwo_code=(function(){
var account_id=68490,
settings_tolerance=2000,
library_tolerance=2500,
use_existing_jquery=false,
// DO NOT EDIT BELOW THIS LINE
f=false,d=document;return{use_existing_jquery:function(){return use_existing_jquery;},library_tolerance:function(){return library_tolerance;},finish:function(){if(!f){f=true;var a=d.getElementById('_vis_opt_path_hides');if(a)a.parentNode.removeChild(a);}},finished:function(){return f;},load:function(a){var b=d.createElement('script');b.src=a;b.type='text/javascript';b.innerText;b.onerror=function(){_vwo_code.finish();};d.getElementsByTagName('head')[0].appendChild(b);},init:function(){settings_timer=setTimeout('_vwo_code.finish()',settings_tolerance);this.load('//dev.visualwebsiteoptimizer.com/j.php?a='+account_id+'&u='+encodeURIComponent(d.URL)+'&r='+Math.random());var a=d.createElement('style'),b='body{opacity:0 !important;filter:alpha(opacity=0) !important;background:none !important;}',h=d.getElementsByTagName('head')[0];a.setAttribute('id','_vis_opt_path_hides');a.setAttribute('type','text/css');if(a.styleSheet)a.styleSheet.cssText=b;else a.appendChild(d.createTextNode(b));h.appendChild(a);return settings_timer;}};}());_vwo_settings_timer=_vwo_code.init();
</script>
<!-- End Visual Website Optimizer Asynchronous Code -->


</head>

<body>
<div id="wrapper">

	<header>
		<div class="header_logo">
			
			<a href="http://www.libelium.com">
				<img src="/wp-content/themes/libelium/images/logo.png" width="182" height="91" alt="Libelium logo" />
			</a>
			
		</div>
		<div class="header_nav">
			<div class="nav_top">
				<div class="languages" style="min-height:36px;">
									</div>
				<div class="social_search">
					<div class="social">
						<div id="social_header">
											 			<a href="http://www.libelium.com/contact/" id="email_header" class="dir_mail"></a>
				 			<a target="_blank" href="https://twitter.com/libelium" id="twitter_header"></a>
				 			<a target="_blank" href="http://www.linkedin.com/company/1062497" id="linkedin_header"></a>
				 			<a target="_blank" href="http://www.youtube.com/user/libelium?sub_confirmation=1" id="youtube_header"></a>
				 			<a target="_blank" href="http://www.libelium.com/feed/" id="feeds_header"></a>
 						</div>
					</div>
					<div class="language">

<form action="http://www.libelium.com/" id="searchform" method="get">
    <div>
        <input class="shadow" type="text" id="s" name="s" placeholder="Search" />
        <div id="searchsubmit"></div>
    </div>
</form>
					</div>
				</div>
			</div>
			<div class="nav_menu">
            <div id="desplegable_4085" class="menu_bubble">
                <div id="header_pincho"></div>
                <ul>
            <li id="menu-item-4120"> <a
                    href="http://www.libelium.com/products/waspmote/"><div class="submenu_waspmote"></div><span>Waspmote</span><p>The Sensor Device for Developers</p
                    ></a></li><li id="menu-item-6976"> <a
                    href="http://www.libelium.com/products/plug-sense/"><div class="submenu_plug-sense"></div><span>Plug & Sense!</span><p>Sensor Networks Made Easy</p
                    ></a></li><li id="menu-item-4135"> <a
                    href="http://www.libelium.com/products/meshlium/"><div class="submenu_meshlium"></div><span>Meshlium</span><p>Connect Sensor Networks to the Cloud</p
                    ></a></li><li id="menu-item-27556"> <a
                    href="http://www.libelium.com/products/mysignals/"><div class="submenu_mysignals"></div><span>MySignals</span><p>eHealth and Medical IoT Development Platform</p
                    ></a></li></br><li id="menu-item-23609"> <a
                    href="http://www.libelium.com/products/the-iot-marketplace/"><div class="submenu_the-iot-marketplace"></div><span>The IoT Marketplace</span><p> IoT Kits with Cloud Connectivity</p
                    ></a></li><li id="menu-item-4137"> <a
                    href="http://www.libelium.com/products/cooking-hacks/"><div class="submenu_cooking-hacks"></div><span>Cooking Hacks</span><p> IoT Starter Kits for Makers</p
                    ></a></li><li id="menu-item-4142"> <a
                    href="http://www.libelium.com/products/services/"><div class="submenu_services"></div><span>Services</span><p>Custom Hardware & Firmware Design</p
                    ></a></li><li id="menu-item-4139"> <a
                    href="http://www.libelium.com/products/training/"><div class="submenu_training"></div><span>Training Courses</span><p>e-Learning<br>Face-to-Face</p
                    ></a></li>                </ul>
            </div>
                        <div id="desplegable_26163" class="menu_bubble">
                <div id="header_pincho"></div>
                <ul>
            <li id="menu-item-4088"> <a
                    href="http://www.libelium.com/resources/top_50_iot_sensor_applications_ranking/"><div class="submenu_top_50_iot_sensor_applications_ranking"></div><span>Applications</span><p>50 sensor applications for a smarter world</p
                    ></a></li><li id="menu-item-4092"> <a
                    href="http://www.libelium.com/resources/case-studies/"><div class="submenu_case-studies"></div><span>Case Studies</span><p>Success stories with libelium technologies</p
                    ></a></li><li id="menu-item-26187"> <a
                    href="http://www.libelium.com/resources/white-papers/"><div class="submenu_white-papers"></div><span>White Papers</span><p>Deep reports on IoT market</p
                    ></a></li><li id="menu-item-36183"> <a
                    href="http://www.libelium.com/resources/projects/"><div class="submenu_projects"></div><span>Projects</span><p>Consortium & European Calls</p
                    ></a></li><li id="menu-item-6335"> <a
                    href="http://www.libelium.com/resources/legal/"><div class="submenu_legal"></div><span>Terms & Conditions</span><p></p
                    ></a></li><li id="menu-item-27568"> <a
                    href="http://www.libelium.com/resources/certifications/"><div class="submenu_certifications"></div><span>Quality & Certification Document M.S.</span><p></p
                    ></a></li>                </ul>
            </div>
            <div class="menu-menu-en-container"><ul id="menu-menu-en" class="menu"><li id="menu-item-4085" class="menu-item menu-item-type-post_type menu-item-object-page menu-item-4085"><a href="http://www.libelium.com/products/">Products <div id="header_indicador"></div></a></li>
<li id="menu-item-26163" class="menu-item menu-item-type-post_type menu-item-object-page menu-item-26163"><a href="http://www.libelium.com/resources/">Resources <div id="header_indicador"></div></a></li>
<li id="menu-item-4092" class="menu-item menu-item-type-post_type menu-item-object-page menu-item-4092"><a href="http://www.libelium.com/resources/case-studies/">Case Studies</a></li>
<li id="menu-item-4759" class="menu-item menu-item-type-post_type menu-item-object-page menu-item-4759"><a href="http://www.libelium.com/development/">Development</a></li>
<li id="menu-item-4096" class="menu-item menu-item-type-post_type menu-item-object-page menu-item-4096"><a href="http://www.libelium.com/company/">Company</a></li>
<li id="menu-item-32902" class="menu-item menu-item-type-post_type menu-item-object-page menu-item-32902"><a href="http://www.libelium.com/partners-ecosystem/">Ecosystem</a></li>
<li id="menu-item-4186" class="menu-item menu-item-type-custom menu-item-object-custom menu-item-4186"><a href="/libeliumworld">Libelium World</a></li>
<li id="menu-item-4098" class="menu-item menu-item-type-post_type menu-item-object-page menu-item-4098"><a href="http://www.libelium.com/contact/">Contact</a></li>
</ul></div>			</div>
		</div>

<script type="text/javascript">
$('#menu-item-4759').addClass('current_page_item');$('#searchsubmit').click(function() { $('#searchform').submit()});$('div.menu_bubble').detach().appendTo('header');var anchos = Array();var ancho_total = 0;var ancho_final = 0;var total = $('ul.menu').width();var numero = 0;$('ul.menu li').each(function() {anchos[numero] = Array($(this).width(), $(this).attr('id')) ;ancho_total += $(this).width();numero++});for(var i =0; i <numero-1; i++) {ancho_final+= parseInt(((anchos[i][0]*total)/ancho_total)); $('#'+anchos[i][1]).css('width', (parseInt((anchos[i][0]*total)/ancho_total))+1)}$('#'+anchos[i-2][1]).css('width',total-ancho_final+10);$('#'+anchos[i][1]).css('width',total-ancho_final+3);$('header ul.menu li').css('opacity',1);if (navigator.appName != 'Microsoft Internet Explorer' || !(/Android|webOS|iPhone|iPad|iPod|BlackBerry/i.test(navigator.userAgent))) {$('div.nav_menu div ul li.menu-item').hover(function() {$('div.menu_bubble').hide();var marginleft = 157; var left = $(this).position()['left']+marginleft+($(this).width()/2)-18-$('div.nav_menu').position()['left']; $('div#desplegable_'+$(this).attr('id').match(/[\d]+$/)+' div#header_pincho').css('margin-left', left); $('div#desplegable_'+$(this).attr('id').match(/[\d]+$/)).show()}, function (e) { var id = $(this).attr('id').match(/[\d]+$/); var position = $('div#desplegable_'+id).position(); var width = $('div#desplegable_'+id).width(); var height = $('div#desplegable_'+id).height(); if (position != null && e.pageX >= position['left'] && e.pageX <= position['left']+width && e.pageY >= position['top']&& e.pageY <= position['top']+height) { $('div#desplegable_'+id).hover(function(){}, function() { $(this).hide() }); } else $('div#desplegable_'+id).hide()})}$('div.nav_menu div ul li.menu-item').click(function() {var id = $(this).attr('id').match(/[\d]+$/);if ($('div#desplegable_'+id).length) {if ($('div#desplegable_'+id).is(':visible')) $('div#desplegable_'+id).hide();else {var marginleft = ($('div#desplegable_'+$(this).attr('id').match(/[\d]+$/)).css('margin-left')== '0px')? 0 : 157;var left = $(this).position()['left']+marginleft+($(this).width()/2)-18-$('div.nav_menu').position()['left']; $('div#desplegable_'+$(this).attr('id').match(/[\d]+$/)+' div#header_pincho').css('margin-left', left); $('div#desplegable_'+$(this).attr('id').match(/[\d]+$/)).show();$('div#desplegable_'+id).show()}return false}});if ('ut-06-stack-eeprom-basic-operation' == 'products') $('div.nav_menu div ul li#menu-item-4180').trigger('click');
</script>

	</header>
	<div id="page-wrap">


    <!-- Development Section -->

    <section id="development">

        <div class="h1page"><div class="h1page-left"></div><h1>Development</h1><div class="h1page-right"></div></div>
        <div id="sidebar">

    <!-- Search Development widget -->

<!--    --><!--        <div id="widget-search" class="boxgradient widget">-->
<!--            <h2 class="titlegrey">Search</h2>-->
<!--            <p>Enter your Development search:</p>-->
<!--            <form action="--><!--/development/"-->
<!--                  id="widget_search" method="get">-->
<!--                <input class="shadow" type="text" size="35" id="search_term"-->
<!--                       name="search_term" placeholder="Development Keywords" />-->
<!--                <div id="widget_search_submit"></div>-->
<!--            </form>-->
<!--        </div>-->
<!--        <script type="text/javascript">-->
<!--            $('#widget_search_submit').click(function() {-->
<!--                $('#widget_search').submit() }); //Submit Form-->
<!--        </script>-->
<!--    -->
    <div class="note" style="background-color: #ffeded; border: 1px dotted #ef8181; margin-bottom: 16px; padding: 0 15px;">
        <h3>Warning - Product Update</h3>
        <p>All the resources present on this section belong to <strong>Waspmote v15</strong>, <strong>Waspmote Plug & Sense! v15</strong> and <strong>Meshlium v4.0</strong></p>
        <p>If you have a <strong>Waspmote v12</strong>, <strong>Waspmote Plug & Sense! v12</strong> or <strong>Meshlium v3.8</strong> please go to the <a href="/v12/development">old Development Section</a>.</p>
        <p>Check what is your version and what are the differences between the old and the new one <a href="/downloads/new_generation_libelium_product_lines.pdf" target="_blank">in this document</a>.</p>

    </div>

    <!-- New Ide Note -->

    
        <div id="widget-note-orange" class="widget">
            <h3>NEW <a href="/development/waspmote/sdk_applications/">Waspmote Pro API v027</a></h3>
        </div>

    
    
        <!-- Forja directory widget -->

        <div id="widget-directory" class="boxgradient widget">
            <h2 class="titlegrey">Examples</h2>

                        <ul class="category_list"><li>
        <a href="#" id="subcategory_general-examples"
           class="label_subcategory"><span></span>
            General</a>
    </li><ul id="subcategory_general-examples_list"
         class="subcategory_list"><li>
            <a href="/development/waspmote/examples/?cat=general-examples&subcat=encryption" id="subsubcategory_encryption"
               class="label_subsubcategory"><span></span>
                Encryption</a>
        </li><ul id="subsubcategory_encryption_list"
             class="subsubcategory_list">
            <li id="dev_aes-01-aes128-ecb-pkcs">
                <a href="http://www.libelium.com/development/waspmote/examples/aes-01-aes128-ecb-pkcs/">AES 01: AES 128, ECB, PKCS</a>
            </li>
            <li id="dev_aes-02-aes192-ecb-pkcs">
                <a href="http://www.libelium.com/development/waspmote/examples/aes-02-aes192-ecb-pkcs/">AES 02: AES 192, ECB, PKCS</a>
            </li>
            <li id="dev_aes-03-aes256-ecb-pkcs">
                <a href="http://www.libelium.com/development/waspmote/examples/aes-03-aes256-ecb-pkcs/">AES 03: AES 256, ECB, PKCS</a>
            </li>
            <li id="dev_aes-04-aes128-cbc-zeros">
                <a href="http://www.libelium.com/development/waspmote/examples/aes-04-aes128-cbc-zeros/">AES 04: AES 128, CBC, ZEROS</a>
            </li>
            <li id="dev_aes-05-aes256-cbc-zeros">
                <a href="http://www.libelium.com/development/waspmote/examples/aes-05-aes256-cbc-zeros/">AES 05: AES 256, CBC, ZEROS</a>
            </li>
            <li id="dev_aes-06-aes256-cbc-zeros">
                <a href="http://www.libelium.com/development/waspmote/examples/aes-06-aes256-cbc-zeros/">AES 06: AES 256, CBC, ZEROS</a>
            </li>
            <li id="dev_aes-07-encryption-128-cbc-zeros">
                <a href="http://www.libelium.com/development/waspmote/examples/aes-07-encryption-128-cbc-zeros/">AES 07: AES 128, EBC, ZEROS with Frame</a>
            </li>
            <li id="dev_aes-08-decryption-128-cbc-zeros">
                <a href="http://www.libelium.com/development/waspmote/examples/aes-08-decryption-128-cbc-zeros/">AES 08: AES 128, CBC, PKCS with Frame</a>
            </li>
            <li id="dev_hash-01-md5">
                <a href="http://www.libelium.com/development/waspmote/examples/hash-01-md5/">HASH 01: MD5</a>
            </li>
            <li id="dev_hash-02-sha1">
                <a href="http://www.libelium.com/development/waspmote/examples/hash-02-sha1/">HASH 02: SHA-1</a>
            </li>
            <li id="dev_hash-03-sha224">
                <a href="http://www.libelium.com/development/waspmote/examples/hash-03-sha224/">HASH 03: SHA-224</a>
            </li>
            <li id="dev_hash-04-sha256">
                <a href="http://www.libelium.com/development/waspmote/examples/hash-04-sha256/">HASH 04: SHA-256</a>
            </li>
            <li id="dev_hash-05-sha384">
                <a href="http://www.libelium.com/development/waspmote/examples/hash-05-sha384/">HASH 05: SHA-384</a>
            </li>
            <li id="dev_hash-06-sha512-message-digest">
                <a href="http://www.libelium.com/development/waspmote/examples/hash-06-sha512-message-digest/">HASH 06: SHA-512</a>
            </li>
            <li id="dev_rsa-01-encryption">
                <a href="http://www.libelium.com/development/waspmote/examples/rsa-01-encryption/">RSA 01: RSA Encryption</a>
            </li>
            <li id="dev_rsa-03-rsa-encryption-frame">
                <a href="http://www.libelium.com/development/waspmote/examples/rsa-03-rsa-encryption-frame/">RSA 03: RSA Encryption Frame</a>
            </li></ul><li>
            <a href="/development/waspmote/examples/?cat=general-examples&subcat=factory-default-code" id="subsubcategory_factory-default-code"
               class="label_subsubcategory"><span></span>
                Factory default code</a>
        </li><ul id="subsubcategory_factory-default-code_list"
             class="subsubcategory_list">
            <li id="dev_waspmote-pro-test-code">
                <a href="http://www.libelium.com/development/waspmote/examples/waspmote-pro-test-code/">Waspmote factory default</a>
            </li></ul><li>
            <a href="/development/waspmote/examples/?cat=general-examples&subcat=frame" id="subsubcategory_frame"
               class="label_subsubcategory"><span></span>
                Frame</a>
        </li><ul id="subsubcategory_frame_list"
             class="subsubcategory_list">
            <li id="dev_frame-01-ascii-simple">
                <a href="http://www.libelium.com/development/waspmote/examples/frame-01-ascii-simple/">Frame 01: ASCII simple</a>
            </li>
            <li id="dev_frame-02-ascii-multiple">
                <a href="http://www.libelium.com/development/waspmote/examples/frame-02-ascii-multiple/">Frame 02: ASCII multiple</a>
            </li>
            <li id="dev_frame-03-binary-simple">
                <a href="http://www.libelium.com/development/waspmote/examples/frame-03-binary-simple/">Frame 03: Binary simple</a>
            </li>
            <li id="dev_frame-04-binary-multiple">
                <a href="http://www.libelium.com/development/waspmote/examples/frame-04-binary-multiple/">Frame 04: Binary multiple</a>
            </li>
            <li id="dev_frame-05-set-frame-size">
                <a href="http://www.libelium.com/development/waspmote/examples/frame-05-set-frame-size/">Frame 05: Set Frame Size</a>
            </li>
            <li id="dev_frame-06-set-frame-type">
                <a href="http://www.libelium.com/development/waspmote/examples/frame-06-set-frame-type/">Frame 06: Set Frame Type</a>
            </li>
            <li id="dev_frame-07-encrypted-frames">
                <a href="http://www.libelium.com/development/waspmote/examples/frame-07-encrypted-frames/">Frame 07: Encrypted Frames</a>
            </li></ul><li>
            <a href="/development/waspmote/examples/?cat=general-examples&subcat=interrupts" id="subsubcategory_interrupts"
               class="label_subsubcategory"><span></span>
                Interrupts</a>
        </li><ul id="subsubcategory_interrupts_list"
             class="subsubcategory_list"></ul><li>
            <a href="/development/waspmote/examples/?cat=general-examples&subcat=power" id="subsubcategory_power"
               class="label_subsubcategory"><span></span>
                Power</a>
        </li><ul id="subsubcategory_power_list"
             class="subsubcategory_list">
            <li id="dev_power-01-setting-sleep-mode">
                <a href="http://www.libelium.com/development/waspmote/examples/power-01-setting-sleep-mode/">Power 01: Setting sleep mode</a>
            </li>
            <li id="dev_power-02-deep-sleep-mode">
                <a href="http://www.libelium.com/development/waspmote/examples/power-02-deep-sleep-mode/">Power 02: Deep sleep mode</a>
            </li>
            <li id="dev_power-03-hibernate-mode">
                <a href="http://www.libelium.com/development/waspmote/examples/power-03-hibernate-mode/">Power 03: Hibernate mode</a>
            </li>
            <li id="dev_power-04-getting-battery-level">
                <a href="http://www.libelium.com/development/waspmote/examples/power-04-getting-battery-level/">Power 04: Getting battery level</a>
            </li>
            <li id="dev_power-05-io-power-supply-management">
                <a href="http://www.libelium.com/development/waspmote/examples/power-05-io-power-supply-management/">Power 05: I/O power supply</a>
            </li>
            <li id="dev_power-06-read-battery-recharging">
                <a href="http://www.libelium.com/development/waspmote/examples/power-06-read-battery-recharging/">Power 06: battery recharging</a>
            </li></ul><li>
            <a href="/development/waspmote/examples/?cat=general-examples&subcat=rtc" id="subsubcategory_rtc"
               class="label_subsubcategory"><span></span>
                RTC</a>
        </li><ul id="subsubcategory_rtc_list"
             class="subsubcategory_list">
            <li id="dev_rtc-01-setting-and-reading-time">
                <a href="http://www.libelium.com/development/waspmote/examples/rtc-01-setting-and-reading-time/">RTC 01: Setting and reading time</a>
            </li>
            <li id="dev_rtc-02-setting-reading-alarms">
                <a href="http://www.libelium.com/development/waspmote/examples/rtc-02-setting-reading-alarms/">RTC 02: Setting reading alarms</a>
            </li>
            <li id="dev_rtc-04-alarm-modes">
                <a href="http://www.libelium.com/development/waspmote/examples/rtc-04-alarm-modes/">RTC 04: Alarm modes</a>
            </li>
            <li id="dev_rtc-06-complete-example">
                <a href="http://www.libelium.com/development/waspmote/examples/rtc-06-complete-example/">RTC 06: Complete example</a>
            </li>
            <li id="dev_rtc-07-set-waspmote-date">
                <a href="http://www.libelium.com/development/waspmote/examples/rtc-07-set-waspmote-date/">RTC 07: Set Waspmote Date</a>
            </li>
            <li id="dev_rtc-08-unixepoch-time">
                <a href="http://www.libelium.com/development/waspmote/examples/rtc-08-unixepoch-time/">RTC 08: Unix/Epoch time</a>
            </li>
            <li id="dev_rtc-10-set-watchdog">
                <a href="http://www.libelium.com/development/waspmote/examples/rtc-10-set-watchdog/">RTC 10: Set watchdog</a>
            </li></ul><li>
            <a href="/development/waspmote/examples/?cat=general-examples&subcat=sd" id="subsubcategory_sd"
               class="label_subsubcategory"><span></span>
                SD</a>
        </li><ul id="subsubcategory_sd_list"
             class="subsubcategory_list">
            <li id="dev_sd-01-create-delete-file">
                <a href="http://www.libelium.com/development/waspmote/examples/sd-01-create-delete-file/">SD 01: Create/delete SD file</a>
            </li>
            <li id="dev_sd-02-write-file">
                <a href="http://www.libelium.com/development/waspmote/examples/sd-02-write-file/">SD 02: Write file</a>
            </li>
            <li id="dev_sd-03-append-file">
                <a href="http://www.libelium.com/development/waspmote/examples/sd-03-append-file/">SD 03: Append data</a>
            </li>
            <li id="dev_sd-04-read-file">
                <a href="http://www.libelium.com/development/waspmote/examples/sd-04-read-file/">SD 04: Read file</a>
            </li>
            <li id="dev_sd-05-create-delete-directories">
                <a href="http://www.libelium.com/development/waspmote/examples/sd-05-create-delete-directories/">SD 05: Create/delete directories</a>
            </li>
            <li id="dev_sd-06-list-files">
                <a href="http://www.libelium.com/development/waspmote/examples/sd-06-list-files/">SD 06: List files</a>
            </li>
            <li id="dev_sd-07-datalogger">
                <a href="http://www.libelium.com/development/waspmote/examples/sd-07-datalogger/">SD 07: Datalogger</a>
            </li>
            <li id="dev_sd-08-change-directories">
                <a href="http://www.libelium.com/development/waspmote/examples/sd-08-change-directories/">SD 08: Change directories</a>
            </li>
            <li id="dev_sd-09-indexof-pattern">
                <a href="http://www.libelium.com/development/waspmote/examples/sd-09-indexof-pattern/">SD 09: IndexOf pattern</a>
            </li>
            <li id="dev_sd-10-write-binary-data">
                <a href="http://www.libelium.com/development/waspmote/examples/sd-10-write-binary-data/">SD 10: Write binary data</a>
            </li>
            <li id="dev_sd-11-create-file-according-to-date">
                <a href="http://www.libelium.com/development/waspmote/examples/sd-11-create-file-according-to-date/">SD 11: create file related to date</a>
            </li>
            <li id="dev_sd-12-format-sd">
                <a href="http://www.libelium.com/development/waspmote/examples/sd-12-format-sd/">SD 12: Format SD</a>
            </li>
            <li id="dev_create-delete-sd-file">
                <a href="http://www.libelium.com/development/waspmote/examples/create-delete-sd-file/">SD 13: SD card menu</a>
            </li></ul><li>
            <a href="/development/waspmote/examples/?cat=general-examples&subcat=usb" id="subsubcategory_usb"
               class="label_subsubcategory"><span></span>
                USB</a>
        </li><ul id="subsubcategory_usb_list"
             class="subsubcategory_list">
            <li id="dev_usb-01-usb-functions">
                <a href="http://www.libelium.com/development/waspmote/examples/usb-01-usb-functions/">USB 01: USB functions</a>
            </li>
            <li id="dev_usb-02-usb-printf-function">
                <a href="http://www.libelium.com/development/waspmote/examples/usb-02-usb-printf-function/">USB 02: USB printf function</a>
            </li></ul><li>
            <a href="/development/waspmote/examples/?cat=general-examples&subcat=utils" id="subsubcategory_utils"
               class="label_subsubcategory"><span></span>
                Utils</a>
        </li><ul id="subsubcategory_utils_list"
             class="subsubcategory_list">
            <li id="dev_ut-01-using-eeprom">
                <a href="http://www.libelium.com/development/waspmote/examples/ut-01-using-eeprom/">UT 01: Using EEPROM</a>
            </li>
            <li id="dev_ut-02-using-leds">
                <a href="http://www.libelium.com/development/waspmote/examples/ut-02-using-leds/">UT 02: Using LEDs</a>
            </li>
            <li id="dev_ut-03-reading-serial-id">
                <a href="http://www.libelium.com/development/waspmote/examples/ut-03-reading-serial-id/">UT 03: Reading Serial ID</a>
            </li>
            <li id="dev_ut-04-convert-types">
                <a href="http://www.libelium.com/development/waspmote/examples/ut-04-convert-types/">UT 04: Converting types</a>
            </li>
            <li id="dev_ut-05-get-free-memory">
                <a href="http://www.libelium.com/development/waspmote/examples/ut-05-get-free-memory/">UT 05: Get free memory</a>
            </li>
            <li id="dev_ut-06-stack-eeprom-basic-operation">
                <a href="http://www.libelium.com/development/waspmote/examples/ut-06-stack-eeprom-basic-operation/">UT 06: Stack EEPROM</a>
            </li>
            <li id="dev_ut-07-formatted-strings">
                <a href="http://www.libelium.com/development/waspmote/examples/ut-07-formatted-strings/">UT 07: Formatted strings</a>
            </li>
            <li id="dev_ut-08-millis-function">
                <a href="http://www.libelium.com/development/waspmote/examples/ut-08-millis-function/">UT 08: millis function</a>
            </li>
            <li id="dev_ut-09-analog-pins">
                <a href="http://www.libelium.com/development/waspmote/examples/ut-09-analog-pins/">UT 09: Analog pins</a>
            </li>
            <li id="dev_ut-10-hex-string-to-hex-array">
                <a href="http://www.libelium.com/development/waspmote/examples/ut-10-hex-string-to-hex-array/">UT 10: Hex string to hex array</a>
            </li>
            <li id="dev_ut-11-show-waspmote-version">
                <a href="http://www.libelium.com/development/waspmote/examples/ut-11-show-waspmote-version/">UT 11: Show Waspmote version</a>
            </li></ul></ul><li>
        <a href="#" id="subcategory_sensors-examples"
           class="label_subcategory"><span></span>
            Sensors</a>
    </li><ul id="subcategory_sensors-examples_list"
         class="subcategory_list"><li>
            <a href="/development/waspmote/examples/?cat=sensors-examples&subcat=smart-cities-pro" id="subsubcategory_smart-cities-pro"
               class="label_subsubcategory"><span></span>
                Smart Cities PRO</a>
        </li><ul id="subsubcategory_smart-cities-pro_list"
             class="subsubcategory_list">
            <li id="dev_scp-v30-01-electrochemical-gas-sensors">
                <a href="http://www.libelium.com/development/waspmote/examples/scp-v30-01-electrochemical-gas-sensors/">SCP v30 01 &#8211; Electrochemical gas sensors</a>
            </li>
            <li id="dev_scp-v30-02-ndir-gas-sensors">
                <a href="http://www.libelium.com/development/waspmote/examples/scp-v30-02-ndir-gas-sensors/">SCP v30 02 &#8211; NDIR gas sensors</a>
            </li>
            <li id="dev_scp-v30-03-pellistor-gas-sensors">
                <a href="http://www.libelium.com/development/waspmote/examples/scp-v30-03-pellistor-gas-sensors/">SCP v30 03 &#8211; Pellistor gas sensors</a>
            </li>
            <li id="dev_scp-v30-04-particle-matter-sensor">
                <a href="http://www.libelium.com/development/waspmote/examples/scp-v30-04-particle-matter-sensor/">SCP v30 04 &#8211; Particle Matter Sensor</a>
            </li>
            <li id="dev_scp-v30-05-temperature-humidity-and-pressure-sensor">
                <a href="http://www.libelium.com/development/waspmote/examples/scp-v30-05-temperature-humidity-and-pressure-sensor/">SCP v30 05 &#8211; Temperature, humidity and pressure sensor</a>
            </li>
            <li id="dev_scp-v30-06-ultrasound-sensor">
                <a href="http://www.libelium.com/development/waspmote/examples/scp-v30-06-ultrasound-sensor/">SCP v30 06 &#8211; Ultrasound sensor</a>
            </li>
            <li id="dev_scp-v30-07-luxes-sensor">
                <a href="http://www.libelium.com/development/waspmote/examples/scp-v30-07-luxes-sensor/">SCP v30 07 &#8211; Luxes sensor</a>
            </li>
            <li id="dev_scp-v30-08-noise-level-sensorg">
                <a href="http://www.libelium.com/development/waspmote/examples/scp-v30-08-noise-level-sensorg/">SCP v30 08 – Noise level</a>
            </li>
            <li id="dev_scp-v30-09-frame-class-utility">
                <a href="http://www.libelium.com/development/waspmote/examples/scp-v30-09-frame-class-utility/">SCP v30 09 &#8211; Frame Class Utility</a>
            </li></ul><li>
            <a href="/development/waspmote/examples/?cat=sensors-examples&subcat=4-20-ma-board" id="subsubcategory_4-20-ma-board"
               class="label_subsubcategory"><span></span>
                4-20 mA Board</a>
        </li><ul id="subsubcategory_4-20-ma-board_list"
             class="subsubcategory_list">
            <li id="dev_4-20ma-01-current-loop-basic-example">
                <a href="http://www.libelium.com/development/waspmote/examples/4-20ma-01-current-loop-basic-example/">4-20 mA 01: Current Loop Basic</a>
            </li>
            <li id="dev_4-20ma-02-current-loop-connection-state">
                <a href="http://www.libelium.com/development/waspmote/examples/4-20ma-02-current-loop-connection-state/">4-20 mA 02: Current Loop Connection State</a>
            </li>
            <li id="dev_4-20-ma-03-several-sensors">
                <a href="http://www.libelium.com/development/waspmote/examples/4-20-ma-03-several-sensors/">4-20 mA 03: Several Sensors</a>
            </li>
            <li id="dev_4-20-ma-04-frame-class-utility">
                <a href="http://www.libelium.com/development/waspmote/examples/4-20-ma-04-frame-class-utility/">4-20 mA 04: Frame class utility</a>
            </li></ul><li>
            <a href="/development/waspmote/examples/?cat=sensors-examples&subcat=accelerometer" id="subsubcategory_accelerometer"
               class="label_subsubcategory"><span></span>
                Accelerometer</a>
        </li><ul id="subsubcategory_accelerometer_list"
             class="subsubcategory_list">
            <li id="dev_acc-01-reading-acceleration">
                <a href="http://www.libelium.com/development/waspmote/examples/acc-01-reading-acceleration/">Acc 01: Reading acceleration</a>
            </li>
            <li id="dev_acc-02-free-fall-interruption">
                <a href="http://www.libelium.com/development/waspmote/examples/acc-02-free-fall-interruption/">Acc 02: Free fall interruption</a>
            </li>
            <li id="dev_acc-03-tilt-measurement">
                <a href="http://www.libelium.com/development/waspmote/examples/acc-03-tilt-measurement/">Acc 03: Tilt measurement</a>
            </li>
            <li id="dev_acc-04-power-modes">
                <a href="http://www.libelium.com/development/waspmote/examples/acc-04-power-modes/">Acc 04: Power modes</a>
            </li>
            <li id="dev_acc-05-intertial-wake-up-interrupt">
                <a href="http://www.libelium.com/development/waspmote/examples/acc-05-intertial-wake-up-interrupt/">Acc 05: Intertial wake up interrupt</a>
            </li>
            <li id="dev_acc-06-6d-movement">
                <a href="http://www.libelium.com/development/waspmote/examples/acc-06-6d-movement/">Acc 06: 6D Movement</a>
            </li>
            <li id="dev_acc-07-6d-position">
                <a href="http://www.libelium.com/development/waspmote/examples/acc-07-6d-position/">Acc 07: 6D position</a>
            </li>
            <li id="dev_acc-08-sleep-to-wake-mode">
                <a href="http://www.libelium.com/development/waspmote/examples/acc-08-sleep-to-wake-mode/">Acc 08: Sleep to wake mode</a>
            </li></ul><li>
            <a href="/development/waspmote/examples/?cat=sensors-examples&subcat=ambient-control" id="subsubcategory_ambient-control"
               class="label_subsubcategory"><span></span>
                Ambient Control</a>
        </li><ul id="subsubcategory_ambient-control_list"
             class="subsubcategory_list"></ul><li>
            <a href="/development/waspmote/examples/?cat=sensors-examples&subcat=agriculture-board" id="subsubcategory_agriculture-board"
               class="label_subsubcategory"><span></span>
                Agriculture Board v20</a>
        </li><ul id="subsubcategory_agriculture-board_list"
             class="subsubcategory_list"></ul><li>
            <a href="/development/waspmote/examples/?cat=sensors-examples&subcat=agriculture-board-v30" id="subsubcategory_agriculture-board-v30"
               class="label_subsubcategory"><span></span>
                Agriculture Board v30</a>
        </li><ul id="subsubcategory_agriculture-board-v30_list"
             class="subsubcategory_list">
            <li id="dev_ag-v30-01-temperature-sensor-reading">
                <a href="http://www.libelium.com/development/waspmote/examples/ag-v30-01-temperature-sensor-reading/">Ag v30 01: Temperature sensor</a>
            </li>
            <li id="dev_ag-v30-02-leaf-wetness-sensor-reading">
                <a href="http://www.libelium.com/development/waspmote/examples/ag-v30-02-leaf-wetness-sensor-reading/">Ag v30 02: Leaf wetness</a>
            </li>
            <li id="dev_ag-v30-03-ultraviolet_solar_radiation_sensor_reading">
                <a href="http://www.libelium.com/development/waspmote/examples/ag-v30-03-ultraviolet_solar_radiation_sensor_reading/">Ag v30 03: UV Solar radiation</a>
            </li>
            <li id="dev_ag-v30-04-photosynthetic-solar-radiation-sensor-reading">
                <a href="http://www.libelium.com/development/waspmote/examples/ag-v30-04-photosynthetic-solar-radiation-sensor-reading/">Ag v30 04: Photosynthetic solar radiation</a>
            </li>
            <li id="dev_ag-v30-05-dendrometer-sensor-reading">
                <a href="http://www.libelium.com/development/waspmote/examples/ag-v30-05-dendrometer-sensor-reading/">Ag v30 05: Dendrometer sensor</a>
            </li>
            <li id="dev_ag-v30-06-pt1000-sensor-reading">
                <a href="http://www.libelium.com/development/waspmote/examples/ag-v30-06-pt1000-sensor-reading/">Ag v30 06: PT1000 sensor</a>
            </li>
            <li id="dev_ag-v30-07-watermark-sensor-reading">
                <a href="http://www.libelium.com/development/waspmote/examples/ag-v30-07-watermark-sensor-reading/">Ag v30 07: Watermark sensor</a>
            </li>
            <li id="dev_ag-v30-08-weather-station-sensor-reading">
                <a href="http://www.libelium.com/development/waspmote/examples/ag-v30-08-weather-station-sensor-reading/">Ag v30 08: Weather station</a>
            </li>
            <li id="dev_ag-v30-09-wind-vane-filtered">
                <a href="http://www.libelium.com/development/waspmote/examples/ag-v30-09-wind-vane-filtered/">Ag v30 09: Wind vane</a>
            </li>
            <li id="dev_ag-v30-10-pluviometer-interruption-reading">
                <a href="http://www.libelium.com/development/waspmote/examples/ag-v30-10-pluviometer-interruption-reading/">Ag v30 10: Pluviometer</a>
            </li>
            <li id="dev_agr-v30-11-frame-class-utility">
                <a href="http://www.libelium.com/development/waspmote/examples/agr-v30-11-frame-class-utility/">Ag v30 11: Frame class utility</a>
            </li>
            <li id="dev_ag-v30-12-ds18b20-temperature-sensor-reading">
                <a href="http://www.libelium.com/development/waspmote/examples/ag-v30-12-ds18b20-temperature-sensor-reading/">Ag v30 12: DS18B20 sensor</a>
            </li>
            <li id="dev_agr-v30-13-ultrasound-sensor">
                <a href="http://www.libelium.com/development/waspmote/examples/agr-v30-13-ultrasound-sensor/">Ag v30 13: Ultrasound sensor</a>
            </li>
            <li id="dev_agr-v30-14-luxes-sensor">
                <a href="http://www.libelium.com/development/waspmote/examples/agr-v30-14-luxes-sensor/">Ag v30 14: Luxes sensor</a>
            </li></ul><li>
            <a href="/development/waspmote/examples/?cat=sensors-examples&subcat=basic-sensors" id="subsubcategory_basic-sensors"
               class="label_subsubcategory"><span></span>
                Basic Sensors</a>
        </li><ul id="subsubcategory_basic-sensors_list"
             class="subsubcategory_list">
            <li id="dev_bs-01-reading-temperature">
                <a href="http://www.libelium.com/development/waspmote/examples/bs-01-reading-temperature/">BS 01: Temperature sensor</a>
            </li>
            <li id="dev_bs-02-reading-light">
                <a href="http://www.libelium.com/development/waspmote/examples/bs-02-reading-light/">BS 02: Light sensor</a>
            </li>
            <li id="dev_bs-03-reading-humidity">
                <a href="http://www.libelium.com/development/waspmote/examples/bs-03-reading-humidity/">BS 03: Humidity sensor</a>
            </li>
            <li id="dev_bs-04-reading-sensors">
                <a href="http://www.libelium.com/development/waspmote/examples/bs-04-reading-sensors/">BS 04: Reading all basic sensors</a>
            </li>
            <li id="dev_bs-05-reading-ds18b20">
                <a href="http://www.libelium.com/development/waspmote/examples/bs-05-reading-ds18b20/">BS 05: DS18B20 sensor</a>
            </li></ul><li>
            <a href="/development/waspmote/examples/?cat=sensors-examples&subcat=events-board" id="subsubcategory_events-board"
               class="label_subsubcategory"><span></span>
                Events Board v20</a>
        </li><ul id="subsubcategory_events-board_list"
             class="subsubcategory_list"></ul><li>
            <a href="/development/waspmote/examples/?cat=sensors-examples&subcat=smart-water" id="subsubcategory_smart-water"
               class="label_subsubcategory"><span></span>
                Smart Water</a>
        </li><ul id="subsubcategory_smart-water_list"
             class="subsubcategory_list">
            <li id="dev_sw-01-ph-sensor-reading">
                <a href="http://www.libelium.com/development/waspmote/examples/sw-01-ph-sensor-reading/">SW 01: pH sensor</a>
            </li>
            <li id="dev_sw-02-orp-sensor-reading">
                <a href="http://www.libelium.com/development/waspmote/examples/sw-02-orp-sensor-reading/">SW 02: ORP sensor</a>
            </li>
            <li id="dev_sw-04-dissolved-oxygen-sensor-reading">
                <a href="http://www.libelium.com/development/waspmote/examples/sw-04-dissolved-oxygen-sensor-reading/">SW 04: Dissolved Oxygen</a>
            </li>
            <li id="dev_sw-05-conductivity-sensor-reading">
                <a href="http://www.libelium.com/development/waspmote/examples/sw-05-conductivity-sensor-reading/">SW 05: Conductivity Sensor</a>
            </li>
            <li id="dev_sw-06-temperature-sensor-reading-2">
                <a href="http://www.libelium.com/development/waspmote/examples/sw-06-temperature-sensor-reading-2/">SW 06: Temperature Sensor</a>
            </li>
            <li id="dev_sw-07-turbidity-sensor-reading">
                <a href="http://www.libelium.com/development/waspmote/examples/sw-07-turbidity-sensor-reading/">SW 07: Turbidity Sensor</a>
            </li>
            <li id="dev_sw-08-frame-class-utility">
                <a href="http://www.libelium.com/development/waspmote/examples/sw-08-frame-class-utility/">SW 08: Frame Class Utility</a>
            </li></ul><li>
            <a href="/development/waspmote/examples/?cat=sensors-examples&subcat=events-board-v30" id="subsubcategory_events-board-v30"
               class="label_subsubcategory"><span></span>
                Events Board v30</a>
        </li><ul id="subsubcategory_events-board-v30_list"
             class="subsubcategory_list">
            <li id="dev_ev-v30-01-temperature">
                <a href="http://www.libelium.com/development/waspmote/examples/ev-v30-01-temperature/">Ev v30 01: BME sensor (temperature, humidity &#038; pressure)</a>
            </li>
            <li id="dev_ev-v30-02-pir">
                <a href="http://www.libelium.com/development/waspmote/examples/ev-v30-02-pir/">Ev v30 02: PIR sensor</a>
            </li>
            <li id="dev_ev-v30-03-liquid-level-sensor">
                <a href="http://www.libelium.com/development/waspmote/examples/ev-v30-03-liquid-level-sensor/">Ev v30 03: Liquid Level sensor</a>
            </li>
            <li id="dev_ev-v30-04-hall-efect">
                <a href="http://www.libelium.com/development/waspmote/examples/ev-v30-04-hall-efect/">Ev v30 04: Hall effect sensor</a>
            </li>
            <li id="dev_ev-v30-05-water-point">
                <a href="http://www.libelium.com/development/waspmote/examples/ev-v30-05-water-point/">Ev v30 05: Liquid presence</a>
            </li>
            <li id="dev_ev-v30-06-water-leakage-line">
                <a href="http://www.libelium.com/development/waspmote/examples/ev-v30-06-water-leakage-line/">Ev v30 06: Water leakage line</a>
            </li>
            <li id="dev_ev-v30-07-yf-s401">
                <a href="http://www.libelium.com/development/waspmote/examples/ev-v30-07-yf-s401/">Ev v30 07: Water Flow (YF-S401)</a>
            </li>
            <li id="dev_ev-v30-08-fs300a">
                <a href="http://www.libelium.com/development/waspmote/examples/ev-v30-08-fs300a/">Ev v30 08: Water Flow (FS300A)</a>
            </li>
            <li id="dev_ev-v30-09-yfg1">
                <a href="http://www.libelium.com/development/waspmote/examples/ev-v30-09-yfg1/">Ev v30 09: Water Flow (YF-G1)</a>
            </li>
            <li id="dev_ev-v30-10-ext-in">
                <a href="http://www.libelium.com/development/waspmote/examples/ev-v30-10-ext-in/">Ev v30 10: Relay input</a>
            </li>
            <li id="dev_ev-v30-11-relay-output">
                <a href="http://www.libelium.com/development/waspmote/examples/ev-v30-11-relay-output/">Ev v30 11: Relay output</a>
            </li>
            <li id="dev_ev-v30-12-frame-class-utility">
                <a href="http://www.libelium.com/development/waspmote/examples/ev-v30-12-frame-class-utility/">Ev v30 12: Frame class utility</a>
            </li>
            <li id="dev_ev-v30-13-ultrasound-sensor">
                <a href="http://www.libelium.com/development/waspmote/examples/ev-v30-13-ultrasound-sensor/">Ev v30 13: Ultrasound sensor</a>
            </li>
            <li id="dev_ev-v30-14-luxes-sensor">
                <a href="http://www.libelium.com/development/waspmote/examples/ev-v30-14-luxes-sensor/">Ev v30 14: Luxes sensor</a>
            </li></ul><li>
            <a href="/development/waspmote/examples/?cat=sensors-examples&subcat=gases-board" id="subsubcategory_gases-board"
               class="label_subsubcategory"><span></span>
                Gases Board v20</a>
        </li><ul id="subsubcategory_gases-board_list"
             class="subsubcategory_list"></ul><li>
            <a href="/development/waspmote/examples/?cat=sensors-examples&subcat=gases-board-v30" id="subsubcategory_gases-board-v30"
               class="label_subsubcategory"><span></span>
                Gases Board v30</a>
        </li><ul id="subsubcategory_gases-board-v30_list"
             class="subsubcategory_list">
            <li id="dev_ga-v30-01-bme280-sensor-reading">
                <a href="http://www.libelium.com/development/waspmote/examples/ga-v30-01-bme280-sensor-reading/">Ga v30 01: BME280 sensor</a>
            </li>
            <li id="dev_ga-v30-02-o2-sensor-reading">
                <a href="http://www.libelium.com/development/waspmote/examples/ga-v30-02-o2-sensor-reading/">Ga v30 02: O2 sensor</a>
            </li>
            <li id="dev_ga-v30-03-co2-sensor-reading">
                <a href="http://www.libelium.com/development/waspmote/examples/ga-v30-03-co2-sensor-reading/">Ga v30 03: CO2 sensor</a>
            </li>
            <li id="dev_ga-v30-04-o3-sensor-reading">
                <a href="http://www.libelium.com/development/waspmote/examples/ga-v30-04-o3-sensor-reading/">Ga v30 04: O3 sensor</a>
            </li>
            <li id="dev_ga-v30-05-co-sensor-reading">
                <a href="http://www.libelium.com/development/waspmote/examples/ga-v30-05-co-sensor-reading/">Ga v30 05: CO sensor</a>
            </li>
            <li id="dev_ga-v30-06-voc-sensor-reading">
                <a href="http://www.libelium.com/development/waspmote/examples/ga-v30-06-voc-sensor-reading/">Ga v30 06: VOC sensor</a>
            </li>
            <li id="dev_ga-v30-07-ch4-sensor-reading">
                <a href="http://www.libelium.com/development/waspmote/examples/ga-v30-07-ch4-sensor-reading/">Ga v30 07: CH4 sensor</a>
            </li>
            <li id="dev_ga-v30-08-nh3-sensor-reading">
                <a href="http://www.libelium.com/development/waspmote/examples/ga-v30-08-nh3-sensor-reading/">Ga v30 08: NH3 sensor</a>
            </li>
            <li id="dev_ga-v30-09-no2-sensor-reading">
                <a href="http://www.libelium.com/development/waspmote/examples/ga-v30-09-no2-sensor-reading/">Ga v30 09: NO2 sensor</a>
            </li>
            <li id="dev_ga-v30-10-sv-sensor-reading">
                <a href="http://www.libelium.com/development/waspmote/examples/ga-v30-10-sv-sensor-reading/">Ga v30 10: SV sensor</a>
            </li>
            <li id="dev_ga-v30-11-lpg-sensor-reading">
                <a href="http://www.libelium.com/development/waspmote/examples/ga-v30-11-lpg-sensor-reading/">Ga v30 11: LPG sensor</a>
            </li>
            <li id="dev_ga-v30-12-app-sensor-reading">
                <a href="http://www.libelium.com/development/waspmote/examples/ga-v30-12-app-sensor-reading/">Ga v30 12: AP1 sensor</a>
            </li>
            <li id="dev_ga-v30-13-frame-class-utility">
                <a href="http://www.libelium.com/development/waspmote/examples/ga-v30-13-frame-class-utility/">Ga v30 13: Frame class utility</a>
            </li>
            <li id="dev_ga-v30-14-luxes-sensor-reading">
                <a href="http://www.libelium.com/development/waspmote/examples/ga-v30-14-luxes-sensor-reading/">Ga v30 14: Luxes sensor</a>
            </li>
            <li id="dev_ga-v30-15-ultrasound-sensor-reading">
                <a href="http://www.libelium.com/development/waspmote/examples/ga-v30-15-ultrasound-sensor-reading/">Ga v30 15: Ultrasound sensor</a>
            </li></ul><li>
            <a href="/development/waspmote/examples/?cat=sensors-examples&subcat=gases-pro-board" id="subsubcategory_gases-pro-board"
               class="label_subsubcategory"><span></span>
                Gases PRO Board</a>
        </li><ul id="subsubcategory_gases-pro-board_list"
             class="subsubcategory_list">
            <li id="dev_gp-v30-01-electrochemical-gas-sensors">
                <a href="http://www.libelium.com/development/waspmote/examples/gp-v30-01-electrochemical-gas-sensors/">GP v30 01 &#8211; Electrochemical gas sensors</a>
            </li>
            <li id="dev_gp-v30-02-ndir-gas-sensors">
                <a href="http://www.libelium.com/development/waspmote/examples/gp-v30-02-ndir-gas-sensors/">GP v30 02 &#8211; NDIR gas sensors</a>
            </li>
            <li id="dev_gp-v30-03-pellistor-gas-sensors">
                <a href="http://www.libelium.com/development/waspmote/examples/gp-v30-03-pellistor-gas-sensors/">GP v30 03 &#8211; Pellistor gas sensors</a>
            </li>
            <li id="dev_gp-v30-05-temperature-humidity-and-pressure-sensor">
                <a href="http://www.libelium.com/development/waspmote/examples/gp-v30-05-temperature-humidity-and-pressure-sensor/">GP v30 05 &#8211; Temperature, humidity and pressure sensor</a>
            </li>
            <li id="dev_gp-v30-06-ultrasound-sensor">
                <a href="http://www.libelium.com/development/waspmote/examples/gp-v30-06-ultrasound-sensor/">GP v30 06 &#8211; Ultrasound sensor</a>
            </li>
            <li id="dev_gp-v30-07-luxes-sensor">
                <a href="http://www.libelium.com/development/waspmote/examples/gp-v30-07-luxes-sensor/">GP v30 07 &#8211; Luxes sensor</a>
            </li>
            <li id="dev_gp-v30-08-frame-class-utility">
                <a href="http://www.libelium.com/development/waspmote/examples/gp-v30-08-frame-class-utility/">GP v30 08 &#8211; Frame Class Utility</a>
            </li></ul><li>
            <a href="/development/waspmote/examples/?cat=sensors-examples&subcat=gps" id="subsubcategory_gps"
               class="label_subsubcategory"><span></span>
                GPS module</a>
        </li><ul id="subsubcategory_gps_list"
             class="subsubcategory_list"></ul><li>
            <a href="/development/waspmote/examples/?cat=sensors-examples&subcat=parking-board" id="subsubcategory_parking-board"
               class="label_subsubcategory"><span></span>
                Parking Board</a>
        </li><ul id="subsubcategory_parking-board_list"
             class="subsubcategory_list"></ul><li>
            <a href="/development/waspmote/examples/?cat=sensors-examples&subcat=prototyping-board" id="subsubcategory_prototyping-board"
               class="label_subsubcategory"><span></span>
                Prototyping Board</a>
        </li><ul id="subsubcategory_prototyping-board_list"
             class="subsubcategory_list">
            <li id="dev_pr-1-reading-the-adc-at-prototyping-2-0-board">
                <a href="http://www.libelium.com/development/waspmote/examples/pr-1-reading-the-adc-at-prototyping-2-0-board/">Pr 01: Reading the ADC</a>
            </li></ul><li>
            <a href="/development/waspmote/examples/?cat=sensors-examples&subcat=radiation-board" id="subsubcategory_radiation-board"
               class="label_subsubcategory"><span></span>
                Radiation Board</a>
        </li><ul id="subsubcategory_radiation-board_list"
             class="subsubcategory_list">
            <li id="dev_rb-01-reading-radiation-in-cpm">
                <a href="http://www.libelium.com/development/waspmote/examples/rb-01-reading-radiation-in-cpm/">RB 01: Reading radiation in cpm</a>
            </li>
            <li id="dev_rb-02-reading-radiation-in-usvh">
                <a href="http://www.libelium.com/development/waspmote/examples/rb-02-reading-radiation-in-usvh/">RB 02: Reading radiation in uSv/h</a>
            </li>
            <li id="dev_rb-03-using-led-array">
                <a href="http://www.libelium.com/development/waspmote/examples/rb-03-using-led-array/">RB 03: Using led array</a>
            </li>
            <li id="dev_rb-04-frame-class-utility">
                <a href="http://www.libelium.com/development/waspmote/examples/rb-04-frame-class-utility/">RB 04: Frame Class Utility</a>
            </li></ul><li>
            <a href="/development/waspmote/examples/?cat=sensors-examples&subcat=smart-cities-board" id="subsubcategory_smart-cities-board"
               class="label_subsubcategory"><span></span>
                Smart Cities Board v20</a>
        </li><ul id="subsubcategory_smart-cities-board_list"
             class="subsubcategory_list"></ul><li>
            <a href="/development/waspmote/examples/?cat=sensors-examples&subcat=smart-metering-board" id="subsubcategory_smart-metering-board"
               class="label_subsubcategory"><span></span>
                Smart Metering v20</a>
        </li><ul id="subsubcategory_smart-metering-board_list"
             class="subsubcategory_list"></ul><li>
            <a href="/development/waspmote/examples/?cat=sensors-examples&subcat=smart-water-ion-examples" id="subsubcategory_smart-water-ion-examples"
               class="label_subsubcategory"><span></span>
                Smart Water Ions</a>
        </li><ul id="subsubcategory_smart-water-ion-examples_list"
             class="subsubcategory_list">
            <li id="dev_swi-01-temperature-sensor-reading">
                <a href="http://www.libelium.com/development/waspmote/examples/swi-01-temperature-sensor-reading/">SWI 01: Temperature Sensor</a>
            </li>
            <li id="dev_swi-02-ph-sensor-reading">
                <a href="http://www.libelium.com/development/waspmote/examples/swi-02-ph-sensor-reading/">SWI 02: pH Sensor Reading</a>
            </li>
            <li id="dev_swi-03-socket1-sensor-reading">
                <a href="http://www.libelium.com/development/waspmote/examples/swi-03-socket1-sensor-reading/">SWI 03: Socket1 Sensor Reading</a>
            </li>
            <li id="dev_swi-04-socket2-sensor-reading">
                <a href="http://www.libelium.com/development/waspmote/examples/swi-04-socket2-sensor-reading/">SWI 04: Socket2 Sensor reading</a>
            </li>
            <li id="dev_swi-05-socket3-sensor-reading">
                <a href="http://www.libelium.com/development/waspmote/examples/swi-05-socket3-sensor-reading/">SWI 05: Socket3 Sensor Reading</a>
            </li>
            <li id="dev_swi-06-socket4-sensor-reading">
                <a href="http://www.libelium.com/development/waspmote/examples/swi-06-socket4-sensor-reading/">SWI 06: Socket4 Sensor Reading</a>
            </li>
            <li id="dev_swi-07-plugsense-reading">
                <a href="http://www.libelium.com/development/waspmote/examples/swi-07-plugsense-reading/">SWI 07: Plug&#038;Sense Reading</a>
            </li>
            <li id="dev_swi-08-frame-class-utility">
                <a href="http://www.libelium.com/development/waspmote/examples/swi-08-frame-class-utility/">SWI 08: Frame Class Utility</a>
            </li></ul><li>
            <a href="/development/waspmote/examples/?cat=sensors-examples&subcat=video-camera-board" id="subsubcategory_video-camera-board"
               class="label_subsubcategory"><span></span>
                Video Camera Board</a>
        </li><ul id="subsubcategory_video-camera-board_list"
             class="subsubcategory_list">
            <li id="dev_vc-01-focusing-the-lens-with-microsd">
                <a href="http://www.libelium.com/development/waspmote/examples/vc-01-focusing-the-lens-with-microsd/">VC 01: Focus lens with microSD</a>
            </li>
            <li id="dev_vc-02-focusing-the-lens-via-videocall">
                <a href="http://www.libelium.com/development/waspmote/examples/vc-02-focusing-the-lens-via-videocall/">VC 02: Focus lens via videocall</a>
            </li>
            <li id="dev_vc-03-focusing-the-lens-with-calibration-program">
                <a href="http://www.libelium.com/development/waspmote/examples/vc-03-focusing-the-lens-with-calibration-program/">VC 03: Focus lens with calibration</a>
            </li>
            <li id="dev_vc-04-configuration-of-the-camera-and-take-picture">
                <a href="http://www.libelium.com/development/waspmote/examples/vc-04-configuration-of-the-camera-and-take-picture/">VC 04: Config and take picture</a>
            </li>
            <li id="dev_vc-05-configuration-of-the-camera-and-record-video">
                <a href="http://www.libelium.com/development/waspmote/examples/vc-05-configuration-of-the-camera-and-record-video/">VC 05: Config and record video</a>
            </li>
            <li id="dev_vc-06-videocall">
                <a href="http://www.libelium.com/development/waspmote/examples/vc-06-videocall/">VC 06: Videocall</a>
            </li>
            <li id="dev_vc-07-pir-interrupt-with-picture-and-ftp">
                <a href="http://www.libelium.com/development/waspmote/examples/vc-07-pir-interrupt-with-picture-and-ftp/">VC 07: PIR int (picture to FTP)</a>
            </li>
            <li id="dev_vc-08-pir-interrupt-with-picture-and-ftp">
                <a href="http://www.libelium.com/development/waspmote/examples/vc-08-pir-interrupt-with-picture-and-ftp/">VC 08: PIR int (video to FTP)</a>
            </li>
            <li id="dev_vc-09-pir-interrupt-with-picture-and-smtp">
                <a href="http://www.libelium.com/development/waspmote/examples/vc-09-pir-interrupt-with-picture-and-smtp/">VC 09: PIR int (picture to SMTP)</a>
            </li></ul></ul><li>
        <a href="#" id="subcategory_communication-examples"
           class="label_subcategory"><span></span>
            Communication</a>
    </li><ul id="subcategory_communication-examples_list"
         class="subcategory_list"><li>
            <a href="/development/waspmote/examples/?cat=communication-examples&subcat=3g-gps" id="subsubcategory_3g-gps"
               class="label_subsubcategory"><span></span>
                3G + GPS</a>
        </li><ul id="subsubcategory_3g-gps_list"
             class="subsubcategory_list">
            <li id="dev_3g-01-changing-power-mode-from-on-to-power-off">
                <a href="http://www.libelium.com/development/waspmote/examples/3g-01-changing-power-mode-from-on-to-power-off/">3G 01: Changing power mode from ON to POWER_OFF</a>
            </li>
            <li id="dev_3g-02-changing-power-mode-from-on-to-rf_off">
                <a href="http://www.libelium.com/development/waspmote/examples/3g-02-changing-power-mode-from-on-to-rf_off/">3G 02: Changing power mode from ON to RF_OFF</a>
            </li>
            <li id="dev_3g-03-changing-power-mode-from-on-to-minimum">
                <a href="http://www.libelium.com/development/waspmote/examples/3g-03-changing-power-mode-from-on-to-minimum/">3G 03: Changing power mode from ON to minimum</a>
            </li>
            <li id="dev_3g-04-changing-power-mode-from-on-to-sleep">
                <a href="http://www.libelium.com/development/waspmote/examples/3g-04-changing-power-mode-from-on-to-sleep/">3G 04: Changing power mode from ON to sleep</a>
            </li>
            <li id="dev_3g-05-making-a-lost-call">
                <a href="http://www.libelium.com/development/waspmote/examples/3g-05-making-a-lost-call/">3G 05: Making a lost call</a>
            </li>
            <li id="dev_3g-06-making-a-call">
                <a href="http://www.libelium.com/development/waspmote/examples/3g-06-making-a-call/">3G 06:  Making a call</a>
            </li>
            <li id="dev_3g-07-sending-sms">
                <a href="http://www.libelium.com/development/waspmote/examples/3g-07-sending-sms/">3G 07: Sending SMS</a>
            </li>
            <li id="dev_3g-08-receiving-sms">
                <a href="http://www.libelium.com/development/waspmote/examples/3g-08-receiving-sms/">3G 08: Receiving SMS</a>
            </li>
            <li id="dev_3g-09-getting-rssi-and-network-info">
                <a href="http://www.libelium.com/development/waspmote/examples/3g-09-getting-rssi-and-network-info/">3G 09: Getting RSSI and network info</a>
            </li>
            <li id="dev_3g-10-tcp-client-in-single-connection">
                <a href="http://www.libelium.com/development/waspmote/examples/3g-10-tcp-client-in-single-connection/">3G 10: TCP client in single connection</a>
            </li>
            <li id="dev_3g-11-udp-client-in-single-connection">
                <a href="http://www.libelium.com/development/waspmote/examples/3g-11-udp-client-in-single-connection/">3G 11: UDP client in single connection</a>
            </li>
            <li id="dev_3g-12-tcp-server-in-single-connection">
                <a href="http://www.libelium.com/development/waspmote/examples/3g-12-tcp-server-in-single-connection/">3G 12: TCP server in single connection</a>
            </li>
            <li id="dev_3g-13-tcp-and-udp-clients-in-multiple-connection">
                <a href="http://www.libelium.com/development/waspmote/examples/3g-13-tcp-and-udp-clients-in-multiple-connection/">3G 13: TCP and UDP clients in multiple connection</a>
            </li>
            <li id="dev_3g-14-sending-at-commands">
                <a href="http://www.libelium.com/development/waspmote/examples/3g-14-sending-at-commands/">3G 14: Sending AT commands</a>
            </li>
            <li id="dev_3g-15a-getting-url">
                <a href="http://www.libelium.com/development/waspmote/examples/3g-15a-getting-url/">3G 15a: Getting URL</a>
            </li>
            <li id="dev_3g-15b-sending-a-frame-to-meshlium">
                <a href="http://www.libelium.com/development/waspmote/examples/3g-15b-sending-a-frame-to-meshlium/">3G 15b: Sending a frame to Meshlium</a>
            </li>
            <li id="dev_3g-16-getting-urls">
                <a href="http://www.libelium.com/development/waspmote/examples/3g-16-getting-urls/">3G 16: Getting URLS</a>
            </li>
            <li id="dev_3g-17-uploading-files-to-a-ftp-server-from-waspmotes-sd">
                <a href="http://www.libelium.com/development/waspmote/examples/3g-17-uploading-files-to-a-ftp-server-from-waspmotes-sd/">3G 17: Uploading files to a FTP server from Waspmote&#8217;s SD</a>
            </li>
            <li id="dev_3g-18-uploading-files-to-a-ftp-server-from-3g-modules-sd">
                <a href="http://www.libelium.com/development/waspmote/examples/3g-18-uploading-files-to-a-ftp-server-from-3g-modules-sd/">3G 18: Uploading files to a FTP server from 3G module&#8217;s SD</a>
            </li>
            <li id="dev_3g-19-downloading-files-to-waspmotes-sd-from-a-ftp-server">
                <a href="http://www.libelium.com/development/waspmote/examples/3g-19-downloading-files-to-waspmotes-sd-from-a-ftp-server/">3G 19: Downloading files to Waspmote&#8217;s SD from a FTP server</a>
            </li>
            <li id="dev_3g-20-uploading-files-to-a-ftp-server-from-3g-modules-sd">
                <a href="http://www.libelium.com/development/waspmote/examples/3g-20-uploading-files-to-a-ftp-server-from-3g-modules-sd/">3G 20: Downloading files to a 3G module from a FTP server</a>
            </li>
            <li id="dev_3g-21-uploading-files-to-a-ftps-server-from-waspmotes-sd">
                <a href="http://www.libelium.com/development/waspmote/examples/3g-21-uploading-files-to-a-ftps-server-from-waspmotes-sd/">3G 21: Uploading files to a FTPS server from Waspmote&#8217;s SD</a>
            </li>
            <li id="dev_3g-22-uploading-files-to-a-ftps-server-from-3g-modules-sd">
                <a href="http://www.libelium.com/development/waspmote/examples/3g-22-uploading-files-to-a-ftps-server-from-3g-modules-sd/">3G 22: Uploading files to a FTPS server from 3G module&#8217;s SD</a>
            </li>
            <li id="dev_3g-23-downloading-files-to-waspmotes-sd-from-a-ftps-server">
                <a href="http://www.libelium.com/development/waspmote/examples/3g-23-downloading-files-to-waspmotes-sd-from-a-ftps-server/">3G 23: Downloading files to Waspmote&#8217;s SD from a FTPS server</a>
            </li>
            <li id="dev_3g-24-uploading-files-to-a-ftps-server-from-3g-modules-sd">
                <a href="http://www.libelium.com/development/waspmote/examples/3g-24-uploading-files-to-a-ftps-server-from-3g-modules-sd/">3G 24: Downloading files to 3G module from a FTPS server</a>
            </li>
            <li id="dev_3g-25-getting-imsi-from-sim-and-imei">
                <a href="http://www.libelium.com/development/waspmote/examples/3g-25-getting-imsi-from-sim-and-imei/">3G 25: Getting IMSI from SIM and IMEI</a>
            </li>
            <li id="dev_3g-26-sending-email-with-smtp">
                <a href="http://www.libelium.com/development/waspmote/examples/3g-26-sending-email-with-smtp/">3G 26: Sending email with SMTP</a>
            </li>
            <li id="dev_3g-27-receiving-email-with-pop3">
                <a href="http://www.libelium.com/development/waspmote/examples/3g-27-receiving-email-with-pop3/">3G 27: Receiving email with POP3</a>
            </li>
            <li id="dev_3g-28-start-gps-and-get-gps-info">
                <a href="http://www.libelium.com/development/waspmote/examples/3g-28-start-gps-and-get-gps-info/">3G 28: Start GPS and get GPS info</a>
            </li>
            <li id="dev_3g-29-start-ms-based-gps-and-get-gps-info">
                <a href="http://www.libelium.com/development/waspmote/examples/3g-29-start-ms-based-gps-and-get-gps-info/">3G 29: Start MS-based GPS and get GPS info</a>
            </li>
            <li id="dev_3g-30-start-ms-assisted-gps-and-get-gps-info">
                <a href="http://www.libelium.com/development/waspmote/examples/3g-30-start-ms-assisted-gps-and-get-gps-info/">3G 30: Start MS-assisted GPS and get GPS info</a>
            </li>
            <li id="dev_3g-31-demo-gps-tracker">
                <a href="http://www.libelium.com/development/waspmote/examples/3g-31-demo-gps-tracker/">3G 31: Demo GPS tracker</a>
            </li>
            <li id="dev_3g-32-ota">
                <a href="http://www.libelium.com/development/waspmote/examples/3g-32-ota/">3G 32: OTA</a>
            </li></ul><li>
            <a href="/development/waspmote/examples/?cat=communication-examples&subcat=4g" id="subsubcategory_4g"
               class="label_subsubcategory"><span></span>
                4G</a>
        </li><ul id="subsubcategory_4g_list"
             class="subsubcategory_list">
            <li id="dev_4g-01-enter-pin-code">
                <a href="http://www.libelium.com/development/waspmote/examples/4g-01-enter-pin-code/">4G 01: Enter pin code</a>
            </li>
            <li id="dev_4g-02-get-module-info">
                <a href="http://www.libelium.com/development/waspmote/examples/4g-02-get-module-info/">4G 02: Get module info</a>
            </li>
            <li id="dev_4g-03-get-network-info">
                <a href="http://www.libelium.com/development/waspmote/examples/4g-03-get-network-info/">4G 03: Get network info</a>
            </li>
            <li id="dev_4g-04-sending-sms">
                <a href="http://www.libelium.com/development/waspmote/examples/4g-04-sending-sms/">4G 04: Sending SMS</a>
            </li>
            <li id="dev_4g-05-receiving-sms">
                <a href="http://www.libelium.com/development/waspmote/examples/4g-05-receiving-sms/">4G 05: Receiving SMS</a>
            </li>
            <li id="dev_4g-06-http-get">
                <a href="http://www.libelium.com/development/waspmote/examples/4g-06-http-get/">4G 06: http GET</a>
            </li>
            <li id="dev_4g-07-http-post">
                <a href="http://www.libelium.com/development/waspmote/examples/4g-07-http-post/">4G 07: http POST</a>
            </li>
            <li id="dev_4g-08-send-frames-to-meshlium">
                <a href="http://www.libelium.com/development/waspmote/examples/4g-08-send-frames-to-meshlium/">4G 08: Send frames to Meshlium</a>
            </li>
            <li id="dev_4g-09-ftp-upload">
                <a href="http://www.libelium.com/development/waspmote/examples/4g-09-ftp-upload/">4G 09: FTP upload</a>
            </li>
            <li id="dev_4g-10-ftp-download">
                <a href="http://www.libelium.com/development/waspmote/examples/4g-10-ftp-download/">4G 10: FTP download</a>
            </li>
            <li id="dev_4g-11-tcp-client">
                <a href="http://www.libelium.com/development/waspmote/examples/4g-11-tcp-client/">4G 11: TCP client</a>
            </li>
            <li id="dev_4g-12-tcp-server">
                <a href="http://www.libelium.com/development/waspmote/examples/4g-12-tcp-server/">4G 12: TCP server</a>
            </li>
            <li id="dev_4g-13-udp-client">
                <a href="http://www.libelium.com/development/waspmote/examples/4g-13-udp-client/">4G 13: UDP client</a>
            </li>
            <li id="dev_4g-14-udp-server">
                <a href="http://www.libelium.com/development/waspmote/examples/4g-14-udp-server/">4G 14: UDP server</a>
            </li>
            <li id="dev_4g-15-ssl-sockets">
                <a href="http://www.libelium.com/development/waspmote/examples/4g-15-ssl-sockets/">4G 15: SSL sockets</a>
            </li>
            <li id="dev_4g-16-gps-autonomous-mode">
                <a href="http://www.libelium.com/development/waspmote/examples/4g-16-gps-autonomous-mode/">4G 16: GPS autonomous mode</a>
            </li>
            <li id="dev_4g-17-agps-ms-assisted">
                <a href="http://www.libelium.com/development/waspmote/examples/4g-17-agps-ms-assisted/">4G 17: A-GPS MS-assisted</a>
            </li>
            <li id="dev_4g-18-agps-ms-based">
                <a href="http://www.libelium.com/development/waspmote/examples/4g-18-agps-ms-based/">4G 18: A-GPS MS-based</a>
            </li>
            <li id="dev_4g-19-send-email-smtp">
                <a href="http://www.libelium.com/development/waspmote/examples/4g-19-send-email-smtp/">4G 19: Send email SMTP</a>
            </li>
            <li id="dev_4g-20-ota">
                <a href="http://www.libelium.com/development/waspmote/examples/4g-20-ota/">4G 20: OTA</a>
            </li></ul><li>
            <a href="/development/waspmote/examples/?cat=communication-examples&subcat=802-15-4" id="subsubcategory_802-15-4"
               class="label_subsubcategory"><span></span>
                802.15.4</a>
        </li><ul id="subsubcategory_802-15-4_list"
             class="subsubcategory_list">
            <li id="dev_802-01-configure-xbee-parameters">
                <a href="http://www.libelium.com/development/waspmote/examples/802-01-configure-xbee-parameters/">802 01: Configure XBee</a>
            </li>
            <li id="dev_802-02-send-packets">
                <a href="http://www.libelium.com/development/waspmote/examples/802-02-send-packets/">802 02: Send packets</a>
            </li>
            <li id="dev_802-03-receive-packets">
                <a href="http://www.libelium.com/development/waspmote/examples/802-03-receive-packets/">802 03: Receive packets</a>
            </li>
            <li id="dev_802-04a-send-unicast-16b-address">
                <a href="http://www.libelium.com/development/waspmote/examples/802-04a-send-unicast-16b-address/">802 04a: Send unicast @16b</a>
            </li>
            <li id="dev_802-04b-receive-unicast-16b-address">
                <a href="http://www.libelium.com/development/waspmote/examples/802-04b-receive-unicast-16b-address/">802 04b: Receive unicast @16b</a>
            </li>
            <li id="dev_802-06a-send-broadcast">
                <a href="http://www.libelium.com/development/waspmote/examples/802-06a-send-broadcast/">802 06a: Send broadcast</a>
            </li>
            <li id="dev_802-06b-receive-broadcast">
                <a href="http://www.libelium.com/development/waspmote/examples/802-06b-receive-broadcast/">802 06b: Receive broadcast</a>
            </li>
            <li id="dev_802-07-energy-scan">
                <a href="http://www.libelium.com/development/waspmote/examples/802-07-energy-scan/">802 07: Energy scan</a>
            </li>
            <li id="dev_802-08-get-rssi">
                <a href="http://www.libelium.com/development/waspmote/examples/802-08-get-rssi/">802 08: Get RSSI</a>
            </li>
            <li id="dev_802-09a-expansion-board-send">
                <a href="http://www.libelium.com/development/waspmote/examples/802-09a-expansion-board-send/">802 09a: Expansion board TX</a>
            </li>
            <li id="dev_802-09b-expansion-board-reception">
                <a href="http://www.libelium.com/development/waspmote/examples/802-09b-expansion-board-reception/">802 09b: Expansion board RX</a>
            </li>
            <li id="dev_802-10-set-low-power-mode">
                <a href="http://www.libelium.com/development/waspmote/examples/802-10-set-low-power-mode/">802 10: Set low power mode</a>
            </li>
            <li id="dev_802-11a-complete-example-send">
                <a href="http://www.libelium.com/development/waspmote/examples/802-11a-complete-example-send/">802 11a: Complete example TX</a>
            </li>
            <li id="dev_802-11b-complete-example-receive">
                <a href="http://www.libelium.com/development/waspmote/examples/802-11b-complete-example-receive/">802 11b: Complete example RX</a>
            </li>
            <li id="dev_802-12-send-atcommand">
                <a href="http://www.libelium.com/development/waspmote/examples/802-12-send-atcommand/">802 12: Send AT commands</a>
            </li>
            <li id="dev_802-13-scan-network">
                <a href="http://www.libelium.com/development/waspmote/examples/802-13-scan-network/">802 13: Scan Network</a>
            </li>
            <li id="dev_802-14a-node-search-tx">
                <a href="http://www.libelium.com/development/waspmote/examples/802-14a-node-search-tx/">802 14a: Node search TX</a>
            </li>
            <li id="dev_802-14b-node-search-rx">
                <a href="http://www.libelium.com/development/waspmote/examples/802-14b-node-search-rx/">802 14b: Node search RX</a>
            </li>
            <li id="dev_802-15-setread-power-level">
                <a href="http://www.libelium.com/development/waspmote/examples/802-15-setread-power-level/">802 15: Set/Read Power Level</a>
            </li>
            <li id="dev_802-16-set-time-from-meshlium">
                <a href="http://www.libelium.com/development/waspmote/examples/802-16-set-time-from-meshlium/">802 16: Set time from Meshlium</a>
            </li></ul><li>
            <a href="/development/waspmote/examples/?cat=communication-examples&subcat=868" id="subsubcategory_868"
               class="label_subsubcategory"><span></span>
                868</a>
        </li><ul id="subsubcategory_868_list"
             class="subsubcategory_list"></ul><li>
            <a href="/development/waspmote/examples/?cat=communication-examples&subcat=868lp" id="subsubcategory_868lp"
               class="label_subsubcategory"><span></span>
                868LP</a>
        </li><ul id="subsubcategory_868lp_list"
             class="subsubcategory_list">
            <li id="dev_868lp-01-configure-xbee-parameters">
                <a href="http://www.libelium.com/development/waspmote/examples/868lp-01-configure-xbee-parameters/">868LP 01: Configure XBee</a>
            </li>
            <li id="dev_868lp-02-send-packets">
                <a href="http://www.libelium.com/development/waspmote/examples/868lp-02-send-packets/">868LP 02: Send packets</a>
            </li>
            <li id="dev_868lp-03-receive-packets">
                <a href="http://www.libelium.com/development/waspmote/examples/868lp-03-receive-packets/">868LP 03: Receive packets</a>
            </li>
            <li id="dev_868lp-04a-send-broadcast">
                <a href="http://www.libelium.com/development/waspmote/examples/868lp-04a-send-broadcast/">868LP 04a: Send broadcast</a>
            </li>
            <li id="dev_868lp-04b-receive-broadcast">
                <a href="http://www.libelium.com/development/waspmote/examples/868lp-04b-receive-broadcast/">868LP 04b: Receive broadcast</a>
            </li>
            <li id="dev_868lp-05-get-rssi">
                <a href="http://www.libelium.com/development/waspmote/examples/868lp-05-get-rssi/">868LP 05: Get RSSI</a>
            </li>
            <li id="dev_868lp-06a-expansion-board-send">
                <a href="http://www.libelium.com/development/waspmote/examples/868lp-06a-expansion-board-send/">868LP 06a: Expansion board TX</a>
            </li>
            <li id="dev_868lp-06b-expansion-board-reception">
                <a href="http://www.libelium.com/development/waspmote/examples/868lp-06b-expansion-board-reception/">868LP 06b: Expansion board RX</a>
            </li>
            <li id="dev_868lp-07-set-low-power-mode">
                <a href="http://www.libelium.com/development/waspmote/examples/868lp-07-set-low-power-mode/">868LP 07: Set low power mode</a>
            </li>
            <li id="dev_868lp-08a-complete-example-send">
                <a href="http://www.libelium.com/development/waspmote/examples/868lp-08a-complete-example-send/">868LP 08a: Complete example TX</a>
            </li>
            <li id="dev_868lp-08b-complete-example-receive">
                <a href="http://www.libelium.com/development/waspmote/examples/868lp-08b-complete-example-receive/">868LP 08b: Complete example RX</a>
            </li>
            <li id="dev_868lp-09-scan-network">
                <a href="http://www.libelium.com/development/waspmote/examples/868lp-09-scan-network/">868LP 09: Scan network</a>
            </li>
            <li id="dev_868lp-10-node-search-tx">
                <a href="http://www.libelium.com/development/waspmote/examples/868lp-10-node-search-tx/">868LP 10: Node search TX</a>
            </li>
            <li id="dev_868lp-10b-node-search-rx">
                <a href="http://www.libelium.com/development/waspmote/examples/868lp-10b-node-search-rx/">868LP 10b: Node search RX</a>
            </li>
            <li id="dev_868lp-11-send-at-command">
                <a href="http://www.libelium.com/development/waspmote/examples/868lp-11-send-at-command/">868LP 11: Send AT command</a>
            </li>
            <li id="dev_868lp-12-power-level">
                <a href="http://www.libelium.com/development/waspmote/examples/868lp-12-power-level/">868LP 12: Power level</a>
            </li>
            <li id="dev_868lp-13-set-time-from-meshlium">
                <a href="http://www.libelium.com/development/waspmote/examples/868lp-13-set-time-from-meshlium/">868LP 13: Set time from Meshlium</a>
            </li></ul><li>
            <a href="/development/waspmote/examples/?cat=communication-examples&subcat=900" id="subsubcategory_900"
               class="label_subsubcategory"><span></span>
                900</a>
        </li><ul id="subsubcategory_900_list"
             class="subsubcategory_list"></ul><li>
            <a href="/development/waspmote/examples/?cat=communication-examples&subcat=900hp" id="subsubcategory_900hp"
               class="label_subsubcategory"><span></span>
                900HP</a>
        </li><ul id="subsubcategory_900hp_list"
             class="subsubcategory_list">
            <li id="dev_900hp-01-configure-xbee-parameters">
                <a href="http://www.libelium.com/development/waspmote/examples/900hp-01-configure-xbee-parameters/">900HP 01: Configure XBee</a>
            </li>
            <li id="dev_900hp-02-send-packets">
                <a href="http://www.libelium.com/development/waspmote/examples/900hp-02-send-packets/">900HP 02: Send packet</a>
            </li>
            <li id="dev_900hp-03-receive-packets">
                <a href="http://www.libelium.com/development/waspmote/examples/900hp-03-receive-packets/">900HP 03: Receive packets</a>
            </li>
            <li id="dev_900hp-04-send-broadcast">
                <a href="http://www.libelium.com/development/waspmote/examples/900hp-04-send-broadcast/">900HP 04a: Send broadcast</a>
            </li>
            <li id="dev_900hp-04b-receive-broadcast">
                <a href="http://www.libelium.com/development/waspmote/examples/900hp-04b-receive-broadcast/">900HP 04b: Receive broadcast</a>
            </li>
            <li id="dev_900hp-05-get-rssi">
                <a href="http://www.libelium.com/development/waspmote/examples/900hp-05-get-rssi/">900HP 05: Get RSSI</a>
            </li>
            <li id="dev_900hp-06a-expansion-board-send">
                <a href="http://www.libelium.com/development/waspmote/examples/900hp-06a-expansion-board-send/">900HP 06a: Expansion board TX</a>
            </li>
            <li id="dev_900hp-06b-expansion-board-reception">
                <a href="http://www.libelium.com/development/waspmote/examples/900hp-06b-expansion-board-reception/">900HP 06b: Expansion board RX</a>
            </li>
            <li id="dev_900hp-07-set-low-power-mode">
                <a href="http://www.libelium.com/development/waspmote/examples/900hp-07-set-low-power-mode/">900HP 07: Set low power</a>
            </li>
            <li id="dev_900hp-08a-complete-example-send">
                <a href="http://www.libelium.com/development/waspmote/examples/900hp-08a-complete-example-send/">900HP 08a: Complete example TX</a>
            </li>
            <li id="dev_900hp-08b-complete-example-receive">
                <a href="http://www.libelium.com/development/waspmote/examples/900hp-08b-complete-example-receive/">900HP 08b: Complete example RX</a>
            </li>
            <li id="dev_900hp-09-scan-network">
                <a href="http://www.libelium.com/development/waspmote/examples/900hp-09-scan-network/">900HP 09: Scan network</a>
            </li>
            <li id="dev_900hp-10a-node-search-tx">
                <a href="http://www.libelium.com/development/waspmote/examples/900hp-10a-node-search-tx/">900HP 10a: Node search TX</a>
            </li>
            <li id="dev_900hp-10b-node-search-rx">
                <a href="http://www.libelium.com/development/waspmote/examples/900hp-10b-node-search-rx/">900HP 10b: Node search RX</a>
            </li>
            <li id="dev_900hp-11-send-atcommand">
                <a href="http://www.libelium.com/development/waspmote/examples/900hp-11-send-atcommand/">900HP 11: Send AT command</a>
            </li>
            <li id="dev_900hp-12-set-power-level">
                <a href="http://www.libelium.com/development/waspmote/examples/900hp-12-set-power-level/">900HP 12: Set power level</a>
            </li></ul><li>
            <a href="/development/waspmote/examples/?cat=communication-examples&subcat=bluetooth-low-energy" id="subsubcategory_bluetooth-low-energy"
               class="label_subsubcategory"><span></span>
                Bluetooth Low Energy</a>
        </li><ul id="subsubcategory_bluetooth-low-energy_list"
             class="subsubcategory_list">
            <li id="dev_ble-01-normal-scan">
                <a href="http://www.libelium.com/development/waspmote/examples/ble-01-normal-scan/">BLE 01 Normal scan</a>
            </li>
            <li id="dev_ble-02-name-scan">
                <a href="http://www.libelium.com/development/waspmote/examples/ble-02-name-scan/">BLE 02 Name scan</a>
            </li>
            <li id="dev_ble-03-limited-scan">
                <a href="http://www.libelium.com/development/waspmote/examples/ble-03-limited-scan/">BLE 03 Limited scan</a>
            </li>
            <li id="dev_ble-04-scan-device">
                <a href="http://www.libelium.com/development/waspmote/examples/ble-04-scan-device/">BLE 04 Scan device</a>
            </li>
            <li id="dev_ble-05-configuring-a-scan">
                <a href="http://www.libelium.com/development/waspmote/examples/ble-05-configuring-a-scan/">BLE 05 Configuring a scan</a>
            </li>
            <li id="dev_ble-06-configuring-a-connection">
                <a href="http://www.libelium.com/development/waspmote/examples/ble-06-configuring-a-connection/">BLE 06 Configuring a connection</a>
            </li>
            <li id="dev_ble-07-connecting-to-a-ble-device-as-master">
                <a href="http://www.libelium.com/development/waspmote/examples/ble-07-connecting-to-a-ble-device-as-master/">BLE 07 Connecting to a BLE device as Master</a>
            </li>
            <li id="dev_ble-08-connecting-to-a-ble-device-as-slave">
                <a href="http://www.libelium.com/development/waspmote/examples/ble-08-connecting-to-a-ble-device-as-slave/">BLE 08 Connecting to a BLE device as Slave</a>
            </li>
            <li id="dev_ble-09-encrypted-connection">
                <a href="http://www.libelium.com/development/waspmote/examples/ble-09-encrypted-connection/">BLE 09 Encrypted connection</a>
            </li>
            <li id="dev_ble-10-characteristic-notification-as-master">
                <a href="http://www.libelium.com/development/waspmote/examples/ble-10-characteristic-notification-as-master/">BLE 10 Characteristic notification as master</a>
            </li>
            <li id="dev_ble-11-characteristic-notification-slave">
                <a href="http://www.libelium.com/development/waspmote/examples/ble-11-characteristic-notification-slave/">BLE 11 Characteristic notification slave</a>
            </li>
            <li id="dev_ble12-characteristic-indication-master">
                <a href="http://www.libelium.com/development/waspmote/examples/ble12-characteristic-indication-master/">BLE 12 Characteristic indication Master</a>
            </li>
            <li id="dev_ble-13-characteristic-indication-slave">
                <a href="http://www.libelium.com/development/waspmote/examples/ble-13-characteristic-indication-slave/">BLE 13 characteristic indication slave</a>
            </li>
            <li id="dev_ble-14-managing-whitelist">
                <a href="http://www.libelium.com/development/waspmote/examples/ble-14-managing-whitelist/">BLE 14 Managing WhiteList</a>
            </li>
            <li id="dev_ble-15-get-set-own-name">
                <a href="http://www.libelium.com/development/waspmote/examples/ble-15-get-set-own-name/">BLE 15 get set own name</a>
            </li>
            <li id="dev_ble-17-configuring-advertisements">
                <a href="http://www.libelium.com/development/waspmote/examples/ble-17-configuring-advertisements/">BLE 17 Configuring advertisements</a>
            </li>
            <li id="dev_ble-18-sleep-mode">
                <a href="http://www.libelium.com/development/waspmote/examples/ble-18-sleep-mode/">BLE 18 Sleep mode</a>
            </li>
            <li id="dev_ble-19-get-own-mac">
                <a href="http://www.libelium.com/development/waspmote/examples/ble-19-get-own-mac/">BLE 19 Get own mac</a>
            </li>
            <li id="dev_ble-20-sending-custom-commands">
                <a href="http://www.libelium.com/development/waspmote/examples/ble-20-sending-custom-commands/">BLE 20 Sending custom commands</a>
            </li>
            <li id="dev_ble-21-software-reset">
                <a href="http://www.libelium.com/development/waspmote/examples/ble-21-software-reset/">BLE 21 Software reset</a>
            </li></ul><li>
            <a href="/development/waspmote/examples/?cat=communication-examples&subcat=bluetooth-pro" id="subsubcategory_bluetooth-pro"
               class="label_subsubcategory"><span></span>
                Bluetooth PRO</a>
        </li><ul id="subsubcategory_bluetooth-pro_list"
             class="subsubcategory_list">
            <li id="dev_bt-pro-01-normal-scan">
                <a href="http://www.libelium.com/development/waspmote/examples/bt-pro-01-normal-scan/">BT Pro 01: Normal scan</a>
            </li>
            <li id="dev_bt-pro-02-limited-scan">
                <a href="http://www.libelium.com/development/waspmote/examples/bt-pro-02-limited-scan/">BT Pro 02: Limited scan</a>
            </li>
            <li id="dev_bt-pro-03-scan-specific-device">
                <a href="http://www.libelium.com/development/waspmote/examples/bt-pro-03-scan-specific-device/">BT Pro 03: Scan specific device</a>
            </li>
            <li id="dev_bt-pro-04-scan-with-friendly-name">
                <a href="http://www.libelium.com/development/waspmote/examples/bt-pro-04-scan-with-friendly-name/">BT Pro 04: Scan with friendly name</a>
            </li>
            <li id="dev_bt-pro-05-read-own-mac">
                <a href="http://www.libelium.com/development/waspmote/examples/bt-pro-05-read-own-mac/">BT Pro 05: Read own mac</a>
            </li>
            <li id="dev_bt-pro-06-reading-bluetooth-temperature">
                <a href="http://www.libelium.com/development/waspmote/examples/bt-pro-06-reading-bluetooth-temperature/">BT Pro 06: Reading bluetooth temperature</a>
            </li>
            <li id="dev_bt-pro-07-getset-friendly-name">
                <a href="http://www.libelium.com/development/waspmote/examples/bt-pro-07-getset-friendly-name/">BT Pro 07: Get/Set friendly name</a>
            </li>
            <li id="dev_bt-pro-08-get-set-node-id">
                <a href="http://www.libelium.com/development/waspmote/examples/bt-pro-08-get-set-node-id/">BT Pro 08: Get/Set node ID</a>
            </li>
            <li id="dev_bt-pro-09-sleep-mode">
                <a href="http://www.libelium.com/development/waspmote/examples/bt-pro-09-sleep-mode/">BT Pro 09: Sleep mode</a>
            </li>
            <li id="dev_bt-pro-10-creating-a-transparent-connection">
                <a href="http://www.libelium.com/development/waspmote/examples/bt-pro-10-creating-a-transparent-connection/">BT Pro 10: Creating a transparent connection</a>
            </li>
            <li id="dev_bt-pro-11-sending-frames">
                <a href="http://www.libelium.com/development/waspmote/examples/bt-pro-11-sending-frames/">BT Pro 11: Sending frames</a>
            </li>
            <li id="dev_bt-pro-12-pairing-example">
                <a href="http://www.libelium.com/development/waspmote/examples/bt-pro-12-pairing-example/">BT PRO 12: Pairing example</a>
            </li></ul><li>
            <a href="/development/waspmote/examples/?cat=communication-examples&subcat=can-bus" id="subsubcategory_can-bus"
               class="label_subsubcategory"><span></span>
                CAN Bus</a>
        </li><ul id="subsubcategory_can-bus_list"
             class="subsubcategory_list">
            <li id="dev_can-bus-01-basic-example">
                <a href="http://www.libelium.com/development/waspmote/examples/can-bus-01-basic-example/">CAN Bus 01: Basic Example</a>
            </li>
            <li id="dev_can-bus-02-get-engine-rpm">
                <a href="http://www.libelium.com/development/waspmote/examples/can-bus-02-get-engine-rpm/">CAN Bus 02: Get Engine RPM</a>
            </li>
            <li id="dev_can-bus-03-get-vehicle-speed">
                <a href="http://www.libelium.com/development/waspmote/examples/can-bus-03-get-vehicle-speed/">CAN Bus 03: Get Vehicle Speed</a>
            </li>
            <li id="dev_can-bus-04-dash-board">
                <a href="http://www.libelium.com/development/waspmote/examples/can-bus-04-dash-board/">CAN Bus 04: Dash Board</a>
            </li>
            <li id="dev_can-bus-05-general-pids">
                <a href="http://www.libelium.com/development/waspmote/examples/can-bus-05-general-pids/">CAN Bus 05: General PIDs</a>
            </li></ul><li>
            <a href="/development/waspmote/examples/?cat=communication-examples&subcat=digimesh" id="subsubcategory_digimesh"
               class="label_subsubcategory"><span></span>
                DigiMesh</a>
        </li><ul id="subsubcategory_digimesh_list"
             class="subsubcategory_list">
            <li id="dev_dm-01-configure-xbee-parameters">
                <a href="http://www.libelium.com/development/waspmote/examples/dm-01-configure-xbee-parameters/">DM 01: Configure XBee</a>
            </li>
            <li id="dev_dm-02-send-packets">
                <a href="http://www.libelium.com/development/waspmote/examples/dm-02-send-packets/">DM 02: Send packets</a>
            </li>
            <li id="dev_dm-03-receive-packets">
                <a href="http://www.libelium.com/development/waspmote/examples/dm-03-receive-packets/">DM 03: Receive packets</a>
            </li>
            <li id="dev_dm-04a-send-broadcast">
                <a href="http://www.libelium.com/development/waspmote/examples/dm-04a-send-broadcast/">DM 04a: Send broadcast</a>
            </li>
            <li id="dev_dm-04b-receive-broadcast">
                <a href="http://www.libelium.com/development/waspmote/examples/dm-04b-receive-broadcast/">DM 04b: Receive broadcast</a>
            </li>
            <li id="dev_dm-05-get-rssi">
                <a href="http://www.libelium.com/development/waspmote/examples/dm-05-get-rssi/">DM 05: Get RSSI</a>
            </li>
            <li id="dev_dm-06a-expansion-board-send">
                <a href="http://www.libelium.com/development/waspmote/examples/dm-06a-expansion-board-send/">DM 06a: Expansion board TX</a>
            </li>
            <li id="dev_dm-06b-expansion-board-reception">
                <a href="http://www.libelium.com/development/waspmote/examples/dm-06b-expansion-board-reception/">DM 06b: Expansion board RX</a>
            </li>
            <li id="dev_dm-07-set-low-power-mode">
                <a href="http://www.libelium.com/development/waspmote/examples/dm-07-set-low-power-mode/">DM 07: Set low power mode</a>
            </li>
            <li id="dev_dm-08a-complete-example-send">
                <a href="http://www.libelium.com/development/waspmote/examples/dm-08a-complete-example-send/">DM 08a: Complete example TX</a>
            </li>
            <li id="dev_dm-08b-complete-example-receive">
                <a href="http://www.libelium.com/development/waspmote/examples/dm-08b-complete-example-receive/">DM 08b: Complete example RX</a>
            </li>
            <li id="dev_dm-10-scan-network">
                <a href="http://www.libelium.com/development/waspmote/examples/dm-10-scan-network/">DM 10: Scan network</a>
            </li>
            <li id="dev_dm-11-node-search">
                <a href="http://www.libelium.com/development/waspmote/examples/dm-11-node-search/">DM 11: Node search</a>
            </li>
            <li id="dev_dm-11a-node-search-tx">
                <a href="http://www.libelium.com/development/waspmote/examples/dm-11a-node-search-tx/">DM 11a: Node search TX</a>
            </li>
            <li id="dev_dm-11b-node-search-rx">
                <a href="http://www.libelium.com/development/waspmote/examples/dm-11b-node-search-rx/">DM 11b: Node search RX</a>
            </li>
            <li id="dev_dm-12-send-at-command">
                <a href="http://www.libelium.com/development/waspmote/examples/dm-12-send-at-command/">DM 12: Send AT commands</a>
            </li>
            <li id="dev_dm-13-setread-power-level">
                <a href="http://www.libelium.com/development/waspmote/examples/dm-13-setread-power-level/">DM 13: Set/Read Power Level</a>
            </li>
            <li id="dev_dm-14-set-time-from-meshlium">
                <a href="http://www.libelium.com/development/waspmote/examples/dm-14-set-time-from-meshlium/">DM 14: Set time from Meshlium</a>
            </li></ul><li>
            <a href="/development/waspmote/examples/?cat=communication-examples&subcat=gprs" id="subsubcategory_gprs"
               class="label_subsubcategory"><span></span>
                GPRS</a>
        </li><ul id="subsubcategory_gprs_list"
             class="subsubcategory_list">
            <li id="dev_gprs-01-changing-power-mode-from-on-to-power-off">
                <a href="http://www.libelium.com/development/waspmote/examples/gprs-01-changing-power-mode-from-on-to-power-off/">GPRS 01: Changing power mode from ON to POWER_OFF</a>
            </li>
            <li id="dev_gprs-02-changing-power-mode-from-on-to-rf-off">
                <a href="http://www.libelium.com/development/waspmote/examples/gprs-02-changing-power-mode-from-on-to-rf-off/">GPRS 02: Changing power mode from ON to RF_OFF</a>
            </li>
            <li id="dev_gprs-03-changing-power-mode-from-on-to-minimum">
                <a href="http://www.libelium.com/development/waspmote/examples/gprs-03-changing-power-mode-from-on-to-minimum/">GPRS 03: Changing power mode from ON to minimum</a>
            </li>
            <li id="dev_gprs-04-changing-power-mode-from-on-to-sleep">
                <a href="http://www.libelium.com/development/waspmote/examples/gprs-04-changing-power-mode-from-on-to-sleep/">GPRS 04: Changing power mode from ON to sleep</a>
            </li>
            <li id="dev_gprs-05-changing-power-mode-from-rf-off-to-minimu">
                <a href="http://www.libelium.com/development/waspmote/examples/gprs-05-changing-power-mode-from-rf-off-to-minimu/">GPRS 05: Changing power mode from RF_OFF to minimum</a>
            </li>
            <li id="dev_gprs-06-making-lost-call">
                <a href="http://www.libelium.com/development/waspmote/examples/gprs-06-making-lost-call/">GPRS 06: Making a lost call</a>
            </li>
            <li id="dev_gprs-07-making-call">
                <a href="http://www.libelium.com/development/waspmote/examples/gprs-07-making-call/">GPRS 07: Making call</a>
            </li>
            <li id="dev_gprs-08-sending-sms">
                <a href="http://www.libelium.com/development/waspmote/examples/gprs-08-sending-sms/">GPRS 08: Sending SMS</a>
            </li>
            <li id="dev_gprs-09-receiving-sms">
                <a href="http://www.libelium.com/development/waspmote/examples/gprs-09-receiving-sms/">GPRS 09: Receiving SMS</a>
            </li>
            <li id="dev_gprs-10-getting-rssi-and-cellid">
                <a href="http://www.libelium.com/development/waspmote/examples/gprs-10-getting-rssi-and-cellid/">GPRS 10: Getting RSSI and cellID</a>
            </li>
            <li id="dev_gprs-11-non-transparent-tcp-client-in-single-connection">
                <a href="http://www.libelium.com/development/waspmote/examples/gprs-11-non-transparent-tcp-client-in-single-connection/">GPRS 11: Non transparent TCP client in single connection</a>
            </li>
            <li id="dev_gprs-12">
                <a href="http://www.libelium.com/development/waspmote/examples/gprs-12/">GPRS 12: Non transparent UDP client in single connection</a>
            </li>
            <li id="dev_gprs-13-non-transparent-tcp-server-in-single-connection">
                <a href="http://www.libelium.com/development/waspmote/examples/gprs-13-non-transparent-tcp-server-in-single-connection/">GPRS 13: Non transparent TCP server in single connection</a>
            </li>
            <li id="dev_gprs-14-transparent-tcp-client-in-single-connection">
                <a href="http://www.libelium.com/development/waspmote/examples/gprs-14-transparent-tcp-client-in-single-connection/">GPRS 14: Transparent TCP client in single connection</a>
            </li>
            <li id="dev_gprs-15">
                <a href="http://www.libelium.com/development/waspmote/examples/gprs-15/">GPRS 15: Transparent UDP client in single connection</a>
            </li>
            <li id="dev_gprs-16-transparent-tcp-server-in-single-connection">
                <a href="http://www.libelium.com/development/waspmote/examples/gprs-16-transparent-tcp-server-in-single-connection/">GPRS 16: Transparent TCP server in single connection</a>
            </li>
            <li id="dev_gprs-17-tcp-and-udp-clients-in-multiple-connection">
                <a href="http://www.libelium.com/development/waspmote/examples/gprs-17-tcp-and-udp-clients-in-multiple-connection/">GPRS 17: TCP and UDP clients in multiple connection</a>
            </li>
            <li id="dev_gprs-18-io-control-by-tcp">
                <a href="http://www.libelium.com/development/waspmote/examples/gprs-18-io-control-by-tcp/">GPRS 18: I/O control by TCP</a>
            </li>
            <li id="dev_gprs-19a-reading-url-with-get">
                <a href="http://www.libelium.com/development/waspmote/examples/gprs-19a-reading-url-with-get/">GPRS 19a: Reading URL with GET</a>
            </li>
            <li id="dev_gprs-19b-reading-url-with-get-and-frame">
                <a href="http://www.libelium.com/development/waspmote/examples/gprs-19b-reading-url-with-get-and-frame/">GPRS 19b: Reading URL with GET and frame</a>
            </li>
            <li id="dev_gprs-19c-reading-url-with-post">
                <a href="http://www.libelium.com/development/waspmote/examples/gprs-19c-reading-url-with-post/">GPRS 19c: Reading URL with POST</a>
            </li>
            <li id="dev_gprs-19d-reading-url-with-post-and-frame">
                <a href="http://www.libelium.com/development/waspmote/examples/gprs-19d-reading-url-with-post-and-frame/">GPRS 19d: Reading URL with POST and frame</a>
            </li>
            <li id="dev_gprs-20-uploading-files-to-a-ftp-server">
                <a href="http://www.libelium.com/development/waspmote/examples/gprs-20-uploading-files-to-a-ftp-server/">GPRS 20: Uploading files to a FTP server</a>
            </li>
            <li id="dev_gprs-21-downloading-files-from-a-ftp-server">
                <a href="http://www.libelium.com/development/waspmote/examples/gprs-21-downloading-files-from-a-ftp-server/">GPRS 21: Downloading files from a FTP server</a>
            </li>
            <li id="dev_gprs-22-getting-imsi-from-sim-and-imei">
                <a href="http://www.libelium.com/development/waspmote/examples/gprs-22-getting-imsi-from-sim-and-imei/">GPRS 22: Getting IMSI from SIM and IMEI</a>
            </li>
            <li id="dev_gprs-23-lost-call-with-hibernate">
                <a href="http://www.libelium.com/development/waspmote/examples/gprs-23-lost-call-with-hibernate/">GPRS 23: Lost call with hibernate</a>
            </li>
            <li id="dev_gprs-24-ota">
                <a href="http://www.libelium.com/development/waspmote/examples/gprs-24-ota/">GPRS 24: OTA</a>
            </li></ul><li>
            <a href="/development/waspmote/examples/?cat=communication-examples&subcat=gprsgps" id="subsubcategory_gprsgps"
               class="label_subsubcategory"><span></span>
                GPRS+GPS</a>
        </li><ul id="subsubcategory_gprsgps_list"
             class="subsubcategory_list">
            <li id="dev_gprsgps908-24-getting-gps-info">
                <a href="http://www.libelium.com/development/waspmote/examples/gprsgps908-24-getting-gps-info/">GPRS SIM908 24: Getting GPS info</a>
            </li>
            <li id="dev_gprsgps908-25-gps-tracker-with-frame">
                <a href="http://www.libelium.com/development/waspmote/examples/gprsgps908-25-gps-tracker-with-frame/">GPRS SIM908 25: GPS tracker with frame</a>
            </li>
            <li id="dev_gprsgps-01-changing-power-mode-from-on-to-power_off">
                <a href="http://www.libelium.com/development/waspmote/examples/gprsgps-01-changing-power-mode-from-on-to-power_off/">GPRS SIM928A 01: Changing power mode from ON to POWER_OFF</a>
            </li>
            <li id="dev_gprsgps-02-changing-power-mode-from-on-to-rf_off">
                <a href="http://www.libelium.com/development/waspmote/examples/gprsgps-02-changing-power-mode-from-on-to-rf_off/">GPRS SIM928A 02: Changing power mode from ON to RF_OFF</a>
            </li>
            <li id="dev_gprsgp-03-changing-power-mode-from-on-to-minimum">
                <a href="http://www.libelium.com/development/waspmote/examples/gprsgp-03-changing-power-mode-from-on-to-minimum/">GPRS SIM928A 03: Changing power mode from ON to minimum</a>
            </li>
            <li id="dev_gprsgps-04-changing-power-mode-from-on-to-sleep">
                <a href="http://www.libelium.com/development/waspmote/examples/gprsgps-04-changing-power-mode-from-on-to-sleep/">GPRS SIM928A 04: Changing power mode from ON to sleep</a>
            </li>
            <li id="dev_gprsgps-05-changing-power-mode-from-rf_off-to-minimum">
                <a href="http://www.libelium.com/development/waspmote/examples/gprsgps-05-changing-power-mode-from-rf_off-to-minimum/">GPRS SIM928A 05: Changing power mode from RF_OFF to minimum</a>
            </li>
            <li id="dev_gprsgps-06-making-lost-call">
                <a href="http://www.libelium.com/development/waspmote/examples/gprsgps-06-making-lost-call/">GPRS SIM928A 06: Making a lost call</a>
            </li>
            <li id="dev_gprsgps-07-making-call">
                <a href="http://www.libelium.com/development/waspmote/examples/gprsgps-07-making-call/">GPRS SIM928A 07: Making call</a>
            </li>
            <li id="dev_gprsgps-08-sending-sms">
                <a href="http://www.libelium.com/development/waspmote/examples/gprsgps-08-sending-sms/">GPRS SIM928A 08: Sending SMS</a>
            </li>
            <li id="dev_gprsgps-09-receiving-sms">
                <a href="http://www.libelium.com/development/waspmote/examples/gprsgps-09-receiving-sms/">GPRS SIM928A 09: Receiving SMS</a>
            </li>
            <li id="dev_gprsgps-10-getting-rssi-and-cellid">
                <a href="http://www.libelium.com/development/waspmote/examples/gprsgps-10-getting-rssi-and-cellid/">GPRS SIM928A 10: Getting RSSI and cellID</a>
            </li>
            <li id="dev_gprsgps-11-non-transparent-tcp-client-in-single-connection">
                <a href="http://www.libelium.com/development/waspmote/examples/gprsgps-11-non-transparent-tcp-client-in-single-connection/">GPRS SIM928A 11: Non transparent TCP client in single connection</a>
            </li>
            <li id="dev_gprsgps-12-non-transparent-udp-client-in-single-connection">
                <a href="http://www.libelium.com/development/waspmote/examples/gprsgps-12-non-transparent-udp-client-in-single-connection/">GPRS SIM928A 12: Non transparent UDP client in single connection</a>
            </li>
            <li id="dev_gprsgps-13-non-transparent-tcp-server-in-single-connection">
                <a href="http://www.libelium.com/development/waspmote/examples/gprsgps-13-non-transparent-tcp-server-in-single-connection/">GPRS SIM928A 13: Non transparent TCP server in single connection</a>
            </li>
            <li id="dev_gprsgps-14-transparent-tcp-client-in-single-connection">
                <a href="http://www.libelium.com/development/waspmote/examples/gprsgps-14-transparent-tcp-client-in-single-connection/">GPRS SIM928A 14: Transparent TCP client in single connection</a>
            </li>
            <li id="dev_gprsgps-15-transparent-udp-client-in-single-connection">
                <a href="http://www.libelium.com/development/waspmote/examples/gprsgps-15-transparent-udp-client-in-single-connection/">GPRS SIM928A 15: Transparent UDP client in single connection</a>
            </li>
            <li id="dev_gprsgps-16-transparent-tcp-server-in-single-connection">
                <a href="http://www.libelium.com/development/waspmote/examples/gprsgps-16-transparent-tcp-server-in-single-connection/">GPRS SIM928A 16: Transparent TCP server in single connection</a>
            </li>
            <li id="dev_gprsgps-17-tcp-and-udp-clients-in-multiple-connection">
                <a href="http://www.libelium.com/development/waspmote/examples/gprsgps-17-tcp-and-udp-clients-in-multiple-connection/">GPRS SIM928A 17: TCP and UDP clients in multiple connection</a>
            </li>
            <li id="dev_gprsgps-18-io-control-by-tcp">
                <a href="http://www.libelium.com/development/waspmote/examples/gprsgps-18-io-control-by-tcp/">GPRS SIM928A 18: I/O control by TCP</a>
            </li>
            <li id="dev_gprsgps-19a-reading-url-with-get">
                <a href="http://www.libelium.com/development/waspmote/examples/gprsgps-19a-reading-url-with-get/">GPRS SIM928A 19a: Reading URL with GET</a>
            </li>
            <li id="dev_gprsgps-19b-reading-url-with-get-and-frame">
                <a href="http://www.libelium.com/development/waspmote/examples/gprsgps-19b-reading-url-with-get-and-frame/">GPRS SIM928A 19b: Reading URL with GET and frame</a>
            </li>
            <li id="dev_gprsgps-19c-reading-url-with-post">
                <a href="http://www.libelium.com/development/waspmote/examples/gprsgps-19c-reading-url-with-post/">GPRS SIM928A 19c: Reading URL with POST</a>
            </li>
            <li id="dev_gprsgps-19d-reading-url-with-post-and-frame">
                <a href="http://www.libelium.com/development/waspmote/examples/gprsgps-19d-reading-url-with-post-and-frame/">GPRS SIM928A 19d: Reading URL with POST and frame</a>
            </li>
            <li id="dev_gprsgps-20-uploading-files-to-a-ftp-server">
                <a href="http://www.libelium.com/development/waspmote/examples/gprsgps-20-uploading-files-to-a-ftp-server/">GPRS SIM928A 20: Uploading files to a FTP server</a>
            </li>
            <li id="dev_gprsgps-21-downloading-files-from-a-ftp-server">
                <a href="http://www.libelium.com/development/waspmote/examples/gprsgps-21-downloading-files-from-a-ftp-server/">GPRS SIM928A 21: Downloading files from a FTP server</a>
            </li>
            <li id="dev_gprsgps-22-getting-imsi-from-sim-and-imei">
                <a href="http://www.libelium.com/development/waspmote/examples/gprsgps-22-getting-imsi-from-sim-and-imei/">GPRS SIM928A 22: Getting IMSI from SIM and IMEI</a>
            </li>
            <li id="dev_gprsgps-23-lost-call-with-hibernate">
                <a href="http://www.libelium.com/development/waspmote/examples/gprsgps-23-lost-call-with-hibernate/">GPRS SIM928A 23: Lost call with hibernate</a>
            </li>
            <li id="dev_gprsgps-24-getting-gps-info">
                <a href="http://www.libelium.com/development/waspmote/examples/gprsgps-24-getting-gps-info/">GPRS SIM928A 24: Getting GPS info</a>
            </li>
            <li id="dev_gprsgps-25-gps-tracker-with-frame">
                <a href="http://www.libelium.com/development/waspmote/examples/gprsgps-25-gps-tracker-with-frame/">GPRS SIM928A 25: GPS tracker with frame</a>
            </li>
            <li id="dev_gprsgps-26-demo-gps-tracker">
                <a href="http://www.libelium.com/development/waspmote/examples/gprsgps-26-demo-gps-tracker/">GPRS SIM928A 26: Demo GPS tracker</a>
            </li></ul><li>
            <a href="/development/waspmote/examples/?cat=communication-examples&subcat=lora-communication-examples" id="subsubcategory_lora-communication-examples"
               class="label_subsubcategory"><span></span>
                LoRa</a>
        </li><ul id="subsubcategory_lora-communication-examples_list"
             class="subsubcategory_list">
            <li id="dev_sx-00-configure-registers">
                <a href="http://www.libelium.com/development/waspmote/examples/sx-00-configure-registers/">SX 00: Configure Registers</a>
            </li>
            <li id="dev_sx-01-configure-lora-parameters">
                <a href="http://www.libelium.com/development/waspmote/examples/sx-01-configure-lora-parameters/">SX 01: Configure LoRa</a>
            </li>
            <li id="dev_sx-02a-tx-lora">
                <a href="http://www.libelium.com/development/waspmote/examples/sx-02a-tx-lora/">SX 02a: TX</a>
            </li>
            <li id="dev_sx-02b-rx-lora">
                <a href="http://www.libelium.com/development/waspmote/examples/sx-02b-rx-lora/">SX 02b: RX</a>
            </li>
            <li id="dev_sx-03a-tx-lora-ack">
                <a href="http://www.libelium.com/development/waspmote/examples/sx-03a-tx-lora-ack/">SX 03a: TX ACK</a>
            </li>
            <li id="dev_sx-03b-rx-lora-ack">
                <a href="http://www.libelium.com/development/waspmote/examples/sx-03b-rx-lora-ack/">SX 03b: RX ACK</a>
            </li>
            <li id="dev_sx-04a-tx-lora-ackwretries">
                <a href="http://www.libelium.com/development/waspmote/examples/sx-04a-tx-lora-ackwretries/">SX 04a: TX ACK wRetries</a>
            </li>
            <li id="dev_sx-04b-rx-lora-ackwretries">
                <a href="http://www.libelium.com/development/waspmote/examples/sx-04b-rx-lora-ackwretries/">SX 04b: RX ACK wRetries</a>
            </li>
            <li id="dev_sx-05a-tx-lora-waspframe">
                <a href="http://www.libelium.com/development/waspmote/examples/sx-05a-tx-lora-waspframe/">SX 05a: TX Frame</a>
            </li>
            <li id="dev_sx-05b-rx-lora-waspframe">
                <a href="http://www.libelium.com/development/waspmote/examples/sx-05b-rx-lora-waspframe/">SX 05b: RX Frame</a>
            </li>
            <li id="dev_sx-06a-tx-lora-ack-waspframe">
                <a href="http://www.libelium.com/development/waspmote/examples/sx-06a-tx-lora-ack-waspframe/">SX 06a: TX Frame ACK</a>
            </li>
            <li id="dev_sx-06b-rx-lora-ack-waspframe">
                <a href="http://www.libelium.com/development/waspmote/examples/sx-06b-rx-lora-ack-waspframe/">SX 06b: RX Frame ACK</a>
            </li>
            <li id="dev_sx-07a-tx-lora-ackwretries-waspframe">
                <a href="http://www.libelium.com/development/waspmote/examples/sx-07a-tx-lora-ackwretries-waspframe/">SX 07a: TX Frame ACK wRetries</a>
            </li>
            <li id="dev_sx-07b-rx-lora-ackwretries-waspframe">
                <a href="http://www.libelium.com/development/waspmote/examples/sx-07b-rx-lora-ackwretries-waspframe/">SX 07b: RX Frame ACK wRetries</a>
            </li>
            <li id="dev_sx-08a-encrypted">
                <a href="http://www.libelium.com/development/waspmote/examples/sx-08a-encrypted/">SX 08a: TX encrypted</a>
            </li>
            <li id="dev_sx-09a-encrypted-waspframe">
                <a href="http://www.libelium.com/development/waspmote/examples/sx-09a-encrypted-waspframe/">SX 09a: TX encrypted Frame</a>
            </li>
            <li id="dev_sx-10-receiveall-lora">
                <a href="http://www.libelium.com/development/waspmote/examples/sx-10-receiveall-lora/">SX 10: RX from all nodes</a>
            </li>
            <li id="dev_sx-11-receiveall-ack-lora">
                <a href="http://www.libelium.com/development/waspmote/examples/sx-11-receiveall-ack-lora/">SX 11: RX wACK from all nodes</a>
            </li>
            <li id="dev_sx-12-rssilora">
                <a href="http://www.libelium.com/development/waspmote/examples/sx-12-rssilora/">SX 12: RSSI LoRa</a>
            </li>
            <li id="dev_sx-13-get-temp">
                <a href="http://www.libelium.com/development/waspmote/examples/sx-13-get-temp/">SX 13: Get Temperature</a>
            </li>
            <li id="dev_sx-14-currentsupply">
                <a href="http://www.libelium.com/development/waspmote/examples/sx-14-currentsupply/">SX 14: Current Supply</a>
            </li></ul><li>
            <a href="/development/waspmote/examples/?cat=communication-examples&subcat=lorawan-communication-examples" id="subsubcategory_lorawan-communication-examples"
               class="label_subsubcategory"><span></span>
                LoRaWAN</a>
        </li><ul id="subsubcategory_lorawan-communication-examples_list"
             class="subsubcategory_list">
            <li id="dev_lorawan-01a-configure-module-eu">
                <a href="http://www.libelium.com/development/waspmote/examples/lorawan-01a-configure-module-eu/">LoRaWAN 01a: Configure module EU</a>
            </li>
            <li id="dev_lorawan-01b-configure-module-us">
                <a href="http://www.libelium.com/development/waspmote/examples/lorawan-01b-configure-module-us/">LoRaWAN 01b: Configure module US</a>
            </li>
            <li id="dev_lorawan-02a-channels-configuration-eu">
                <a href="http://www.libelium.com/development/waspmote/examples/lorawan-02a-channels-configuration-eu/">LoRaWAN 02a: Channels EU</a>
            </li>
            <li id="dev_lorawan-02b-channels-configuration-us">
                <a href="http://www.libelium.com/development/waspmote/examples/lorawan-02b-channels-configuration-us/">LoRaWAN 02b: Channels US</a>
            </li>
            <li id="dev_lorawan-03-power-level">
                <a href="http://www.libelium.com/development/waspmote/examples/lorawan-03-power-level/">LoRaWAN 03: Power level</a>
            </li>
            <li id="dev_lorawan-04-data-rate">
                <a href="http://www.libelium.com/development/waspmote/examples/lorawan-04-data-rate/">LoRaWAN 04: Data rate</a>
            </li>
            <li id="dev_lorawan-05-adaptive-data-rate">
                <a href="http://www.libelium.com/development/waspmote/examples/lorawan-05-adaptive-data-rate/">LoRaWAN 05: Adaptive data rate</a>
            </li>
            <li id="dev_lorawan-06-join-abp-send-unconfirmed">
                <a href="http://www.libelium.com/development/waspmote/examples/lorawan-06-join-abp-send-unconfirmed/">LoRaWAN 06: Join ABP send unconfirmed</a>
            </li>
            <li id="dev_lorawan-07-join-abp-send-confirmed">
                <a href="http://www.libelium.com/development/waspmote/examples/lorawan-07-join-abp-send-confirmed/">LoRaWAN 07: Join ABP send confirmed</a>
            </li>
            <li id="dev_lorawan-08-join-abp-send-frame">
                <a href="http://www.libelium.com/development/waspmote/examples/lorawan-08-join-abp-send-frame/">LoRaWAN 08: Join ABP send frame</a>
            </li>
            <li id="dev_lorawan-09-join-otaa-send-unconfirmed">
                <a href="http://www.libelium.com/development/waspmote/examples/lorawan-09-join-otaa-send-unconfirmed/">LoRaWAN 09: Join OTAA send unconfirmed</a>
            </li>
            <li id="dev_lorawan-10-join-otaa-send-confirmed">
                <a href="http://www.libelium.com/development/waspmote/examples/lorawan-10-join-otaa-send-confirmed/">LoRaWAN 10: Join OTAA send confirmed</a>
            </li>
            <li id="dev_lorawan-11-join-otaa-send-frame">
                <a href="http://www.libelium.com/development/waspmote/examples/lorawan-11-join-otaa-send-frame/">LoRaWAN 11: Join OTAA send frame</a>
            </li>
            <li id="dev_lorawan-p2p-01-configure-module">
                <a href="http://www.libelium.com/development/waspmote/examples/lorawan-p2p-01-configure-module/">LoRaWAN P2P 01: Configure</a>
            </li>
            <li id="dev_lorawan-p2p-02-send-packets">
                <a href="http://www.libelium.com/development/waspmote/examples/lorawan-p2p-02-send-packets/">LoRaWAN P2P 02: Send</a>
            </li>
            <li id="dev_lorawan-p2p-03-receive-packets">
                <a href="http://www.libelium.com/development/waspmote/examples/lorawan-p2p-03-receive-packets/">LoRaWAN P2P 03: Receive</a>
            </li>
            <li id="dev_lorawan-p2p-04-hybrid-p2p-to-lorawan">
                <a href="http://www.libelium.com/development/waspmote/examples/lorawan-p2p-04-hybrid-p2p-to-lorawan/">LoRaWAN P2P 04: Hybrid P2P / LoRaWAN</a>
            </li></ul><li>
            <a href="/development/waspmote/examples/?cat=communication-examples&subcat=ota" id="subsubcategory_ota"
               class="label_subsubcategory"><span></span>
                OTA</a>
        </li><ul id="subsubcategory_ota_list"
             class="subsubcategory_list"></ul><li>
            <a href="/development/waspmote/examples/?cat=communication-examples&subcat=rfid-13-56" id="subsubcategory_rfid-13-56"
               class="label_subsubcategory"><span></span>
                RFID 13.56</a>
        </li><ul id="subsubcategory_rfid-13-56_list"
             class="subsubcategory_list">
            <li id="dev_rfid1356-01-basic-example">
                <a href="http://www.libelium.com/development/waspmote/examples/rfid1356-01-basic-example/">RFID1356 01: Basic Example</a>
            </li>
            <li id="dev_rfid1356-02-read-all-blocks">
                <a href="http://www.libelium.com/development/waspmote/examples/rfid1356-02-read-all-blocks/">RFID1356 02: Read All Blocks</a>
            </li>
            <li id="dev_rfid1356-03-bus-ticketing">
                <a href="http://www.libelium.com/development/waspmote/examples/rfid1356-03-bus-ticketing/">RFID1356 03: Bus Ticketing</a>
            </li>
            <li id="dev_rfid1356-04-get-uid">
                <a href="http://www.libelium.com/development/waspmote/examples/rfid1356-04-get-uid/">RFID1356 04: Get UID</a>
            </li>
            <li id="dev_rfid1356-05-password-simple">
                <a href="http://www.libelium.com/development/waspmote/examples/rfid1356-05-password-simple/">RFID1356 05: Password Simple</a>
            </li>
            <li id="dev_rfid1356-06-single-cards-counter">
                <a href="http://www.libelium.com/development/waspmote/examples/rfid1356-06-single-cards-counter/">RFID1356 06: Single Cards Counter</a>
            </li>
            <li id="dev_rfid1356-07-several-cards-counter">
                <a href="http://www.libelium.com/development/waspmote/examples/rfid1356-07-several-cards-counter/">RFID1356 07: Several Cards Counter</a>
            </li>
            <li id="dev_rfid1356-08-set-low-power-mode">
                <a href="http://www.libelium.com/development/waspmote/examples/rfid1356-08-set-low-power-mode/">RFID1356 08: Set low power mode</a>
            </li></ul><li>
            <a href="/development/waspmote/examples/?cat=communication-examples&subcat=rs-232" id="subsubcategory_rs-232"
               class="label_subsubcategory"><span></span>
                RS-232</a>
        </li><ul id="subsubcategory_rs-232_list"
             class="subsubcategory_list">
            <li id="dev_rs-232-01-send-data">
                <a href="http://www.libelium.com/development/waspmote/examples/rs-232-01-send-data/">RS-232 01: Send Data</a>
            </li>
            <li id="dev_rs-232-02-receive-data">
                <a href="http://www.libelium.com/development/waspmote/examples/rs-232-02-receive-data/">RS-232 02: Receive Data</a>
            </li>
            <li id="dev_rs-232-03-modbus-slave-acc-battery">
                <a href="http://www.libelium.com/development/waspmote/examples/rs-232-03-modbus-slave-acc-battery/">RS-232 03: Modbus Slave ACC &#038; Battery</a>
            </li>
            <li id="dev_rs-232-04-modbus-master-acc-battery">
                <a href="http://www.libelium.com/development/waspmote/examples/rs-232-04-modbus-master-acc-battery/">RS-232 04: Modbus Master ACC &#038; Battery</a>
            </li>
            <li id="dev_rs-232-05-modbus-read-coils">
                <a href="http://www.libelium.com/development/waspmote/examples/rs-232-05-modbus-read-coils/">RS-232 05: Modbus Read Coils</a>
            </li>
            <li id="dev_rs-232-06-modbus-write-single-register">
                <a href="http://www.libelium.com/development/waspmote/examples/rs-232-06-modbus-write-single-register/">RS-232 06: Modbus Write Single Register</a>
            </li></ul><li>
            <a href="/development/waspmote/examples/?cat=communication-examples&subcat=rs-485" id="subsubcategory_rs-485"
               class="label_subsubcategory"><span></span>
                RS-485</a>
        </li><ul id="subsubcategory_rs-485_list"
             class="subsubcategory_list">
            <li id="dev_rs485-01-send-data">
                <a href="http://www.libelium.com/development/waspmote/examples/rs485-01-send-data/">RS-485 01: Send Data</a>
            </li>
            <li id="dev_rs485-02-receive-data">
                <a href="http://www.libelium.com/development/waspmote/examples/rs485-02-receive-data/">RS-485 02: Receive Data</a>
            </li>
            <li id="dev_rs485-03-configuration-example">
                <a href="http://www.libelium.com/development/waspmote/examples/rs485-03-configuration-example/">RS-485 03: Configuration Example</a>
            </li>
            <li id="dev_rs-485-04-modbus-read-coils">
                <a href="http://www.libelium.com/development/waspmote/examples/rs-485-04-modbus-read-coils/">RS-485 04: Modbus Read Coils</a>
            </li>
            <li id="dev_rs-485-05-modbus-read-input-registers">
                <a href="http://www.libelium.com/development/waspmote/examples/rs-485-05-modbus-read-input-registers/">RS-485 05: Modbus Read Input Registers</a>
            </li>
            <li id="dev_rs-485-06-modbus-write-single-coil">
                <a href="http://www.libelium.com/development/waspmote/examples/rs-485-06-modbus-write-single-coil/">RS-485 06: Modbus Write Single Coil</a>
            </li>
            <li id="dev_rs-485-07-modbus-write-single-register">
                <a href="http://www.libelium.com/development/waspmote/examples/rs-485-07-modbus-write-single-register/">RS-485 07: Modbus Write Single Register</a>
            </li>
            <li id="dev_rs-485-08-modbus-several-slaves">
                <a href="http://www.libelium.com/development/waspmote/examples/rs-485-08-modbus-several-slaves/">RS-485 08: Modbus Several Slaves</a>
            </li>
            <li id="dev_rs-485-09-modbus-slave-mode">
                <a href="http://www.libelium.com/development/waspmote/examples/rs-485-09-modbus-slave-mode/">RS-485 09: Modbus Slave Mode</a>
            </li>
            <li id="dev_rs-485-10-modbus-slave-acc-battery-level">
                <a href="http://www.libelium.com/development/waspmote/examples/rs-485-10-modbus-slave-acc-battery-level/">RS-485 10: Modbus Slave ACC &#038; Battery Level</a>
            </li>
            <li id="dev_rs-485-11-modbus-master-acc-battery-level">
                <a href="http://www.libelium.com/development/waspmote/examples/rs-485-11-modbus-master-acc-battery-level/">RS-485 11: Modbus Master ACC &#038; Battery Level</a>
            </li>
            <li id="dev_rs-485-12-modbus-registers-map">
                <a href="http://www.libelium.com/development/waspmote/examples/rs-485-12-modbus-registers-map/">RS-485 12: Modbus Registers Map</a>
            </li></ul><li>
            <a href="/development/waspmote/examples/?cat=communication-examples&subcat=sigfox" id="subsubcategory_sigfox"
               class="label_subsubcategory"><span></span>
                Sigfox</a>
        </li><ul id="subsubcategory_sigfox_list"
             class="subsubcategory_list">
            <li id="dev_sigfox-01-read-id">
                <a href="http://www.libelium.com/development/waspmote/examples/sigfox-01-read-id/">Sigfox 01: Read ID</a>
            </li>
            <li id="dev_sigfox-02-send-data-string">
                <a href="http://www.libelium.com/development/waspmote/examples/sigfox-02-send-data-string/">Sigfox 02: Send data string</a>
            </li>
            <li id="dev_sigfox-03-send-data-array">
                <a href="http://www.libelium.com/development/waspmote/examples/sigfox-03-send-data-array/">Sigfox 03: Send data array</a>
            </li>
            <li id="dev_sigfox-04-send-data-string-ack">
                <a href="http://www.libelium.com/development/waspmote/examples/sigfox-04-send-data-string-ack/">Sigfox 04: Send string with ACK</a>
            </li>
            <li id="dev_sigfox-05-send-data-array-ack">
                <a href="http://www.libelium.com/development/waspmote/examples/sigfox-05-send-data-array-ack/">Sigfox 05: Send array with ACK</a>
            </li>
            <li id="dev_sigfox-06-send-keep-alive">
                <a href="http://www.libelium.com/development/waspmote/examples/sigfox-06-send-keep-alive/">Sigfox 06: Send keep-alive</a>
            </li>
            <li id="dev_sigfox-07-set-get-power-level">
                <a href="http://www.libelium.com/development/waspmote/examples/sigfox-07-set-get-power-level/">Sigfox 07: Set/get power level</a>
            </li>
            <li id="dev_sigfox-08-test-sigfox">
                <a href="http://www.libelium.com/development/waspmote/examples/sigfox-08-test-sigfox/">Sigfox 08: Sigfox TX test</a>
            </li>
            <li id="dev_sigfox-09-show-firmware">
                <a href="http://www.libelium.com/development/waspmote/examples/sigfox-09-show-firmware/">Sigfox 09: Show firmware</a>
            </li>
            <li id="dev_sigfox-10-fcc-module-functions">
                <a href="http://www.libelium.com/development/waspmote/examples/sigfox-10-fcc-module-functions/">Sigfox 10: FCC module functions</a>
            </li>
            <li id="dev_lan-01-configure-module">
                <a href="http://www.libelium.com/development/waspmote/examples/lan-01-configure-module/">Sigfox P2P 01: Configure module</a>
            </li>
            <li id="dev_lan-02-send-data-string">
                <a href="http://www.libelium.com/development/waspmote/examples/lan-02-send-data-string/">Sigfox P2P 02: Send data as string</a>
            </li>
            <li id="dev_lan-03-receive-single-packet">
                <a href="http://www.libelium.com/development/waspmote/examples/lan-03-receive-single-packet/">Sigfox P2P 03: RX single packet</a>
            </li>
            <li id="dev_lan-04-receive-multi-packet">
                <a href="http://www.libelium.com/development/waspmote/examples/lan-04-receive-multi-packet/">Sigfox P2P 04: RX multipacket</a>
            </li>
            <li id="dev_lan-05-send-data-array">
                <a href="http://www.libelium.com/development/waspmote/examples/lan-05-send-data-array/">Sigfox P2P 05: Send data as array</a>
            </li>
            <li id="dev_lan-06-lan-to-sigfox-gateway">
                <a href="http://www.libelium.com/development/waspmote/examples/lan-06-lan-to-sigfox-gateway/">Sigfox P2P 06: LAN to Sigfox GW</a>
            </li></ul><li>
            <a href="/development/waspmote/examples/?cat=communication-examples&subcat=wifi-examples" id="subsubcategory_wifi-examples"
               class="label_subsubcategory"><span></span>
                WiFi</a>
        </li><ul id="subsubcategory_wifi-examples_list"
             class="subsubcategory_list"></ul><li>
            <a href="/development/waspmote/examples/?cat=communication-examples&subcat=wifi-pro-communication-examples" id="subsubcategory_wifi-pro-communication-examples"
               class="label_subsubcategory"><span></span>
                WiFi PRO</a>
        </li><ul id="subsubcategory_wifi-pro-communication-examples_list"
             class="subsubcategory_list">
            <li id="dev_wifi-pro-01-configure-essid">
                <a href="http://www.libelium.com/development/waspmote/examples/wifi-pro-01-configure-essid/">WiFi PRO 01: Configure ESSID</a>
            </li>
            <li id="dev_wifi-pro-02-join-ap">
                <a href="http://www.libelium.com/development/waspmote/examples/wifi-pro-02-join-ap/">WiFi PRO 02: join AP</a>
            </li>
            <li id="dev_wifi-pro-03-get-ip">
                <a href="http://www.libelium.com/development/waspmote/examples/wifi-pro-03-get-ip/">WiFi PRO 03: Get IP</a>
            </li>
            <li id="dev_wifi-pro-04-static-ip">
                <a href="http://www.libelium.com/development/waspmote/examples/wifi-pro-04-static-ip/">WiFi PRO 04: Static IP</a>
            </li>
            <li id="dev_wifi-pro-05-ping">
                <a href="http://www.libelium.com/development/waspmote/examples/wifi-pro-05-ping/">WiFi PRO 05: Ping</a>
            </li>
            <li id="dev_wifi-pro-06-set-power">
                <a href="http://www.libelium.com/development/waspmote/examples/wifi-pro-06-set-power/">WiFi PRO 06: TX Power</a>
            </li>
            <li id="dev_wifi-pro-07-tcp-client">
                <a href="http://www.libelium.com/development/waspmote/examples/wifi-pro-07-tcp-client/">WiFi PRO 07: TCP client</a>
            </li>
            <li id="dev_wifi-pro-08-tcp-server">
                <a href="http://www.libelium.com/development/waspmote/examples/wifi-pro-08-tcp-server/">WiFi PRO 08: TCP server</a>
            </li>
            <li id="dev_wifi-pro-09-udp-client">
                <a href="http://www.libelium.com/development/waspmote/examples/wifi-pro-09-udp-client/">WiFi PRO 09: UDP client</a>
            </li>
            <li id="dev_wifi-pro-10-udp-listener">
                <a href="http://www.libelium.com/development/waspmote/examples/wifi-pro-10-udp-listener/">WiFi PRO 10: UDP listener</a>
            </li>
            <li id="dev_wifi-pro-11-tcp-udp-simultaneously">
                <a href="http://www.libelium.com/development/waspmote/examples/wifi-pro-11-tcp-udp-simultaneously/">WiFi PRO 11: TCP UDP</a>
            </li>
            <li id="dev_wifi-pro-12-http-get">
                <a href="http://www.libelium.com/development/waspmote/examples/wifi-pro-12-http-get/">WiFi PRO 12: HTTP GET</a>
            </li>
            <li id="dev_wifi-pro-13-http-post">
                <a href="http://www.libelium.com/development/waspmote/examples/wifi-pro-13-http-post/">WiFi PRO 13: HTTP POST</a>
            </li>
            <li id="dev_wifi-pro-14-https-get">
                <a href="http://www.libelium.com/development/waspmote/examples/wifi-pro-14-https-get/">WiFi PRO 14: HTTPS GET</a>
            </li>
            <li id="dev_wifi-pro-15-https-post">
                <a href="http://www.libelium.com/development/waspmote/examples/wifi-pro-15-https-post/">WiFi PRO 15: HTTPS POST</a>
            </li>
            <li id="dev_wifi-pro-16-send-to-meshlium">
                <a href="http://www.libelium.com/development/waspmote/examples/wifi-pro-16-send-to-meshlium/">WiFi PRO 16: Frame to Meshlium</a>
            </li>
            <li id="dev_wifi-pro-17-ftp-upload">
                <a href="http://www.libelium.com/development/waspmote/examples/wifi-pro-17-ftp-upload/">WiFi PRO 17: FTP upload</a>
            </li>
            <li id="dev_wifi-pro-18-ftp-download">
                <a href="http://www.libelium.com/development/waspmote/examples/wifi-pro-18-ftp-download/">WiFi PRO 18: FTP download</a>
            </li>
            <li id="dev_wifi-pro-19-ftp-make-directory">
                <a href="http://www.libelium.com/development/waspmote/examples/wifi-pro-19-ftp-make-directory/">WiFi PRO 19: FTP make directory</a>
            </li>
            <li id="dev_wifi-pro-20-scan">
                <a href="http://www.libelium.com/development/waspmote/examples/wifi-pro-20-scan/">WiFi PRO 20: Scan</a>
            </li>
            <li id="dev_wifi-pro-21-ota">
                <a href="http://www.libelium.com/development/waspmote/examples/wifi-pro-21-ota/">WiFi PRO 21: OTA</a>
            </li>
            <li id="dev_wifi-pro-22-time">
                <a href="http://www.libelium.com/development/waspmote/examples/wifi-pro-22-time/">WiFi PRO 22: Set time from WiFi</a>
            </li>
            <li id="dev_wifi-pro-23-multiple-ssid">
                <a href="http://www.libelium.com/development/waspmote/examples/wifi-pro-23-multiple-ssid/">WiFi PRO 23: Set multiple SSID</a>
            </li>
            <li id="dev_wifi-pro-24-roaming-mode">
                <a href="http://www.libelium.com/development/waspmote/examples/wifi-pro-24-roaming-mode/">WiFi PRO 24: Roaming mode</a>
            </li>
            <li id="dev_wifi-pro-25-firmware-version">
                <a href="http://www.libelium.com/development/waspmote/examples/wifi-pro-25-firmware-version/">WiFi PRO 25: Firmware version</a>
            </li>
            <li id="dev_wifi-pro-26-ssl-sockets">
                <a href="http://www.libelium.com/development/waspmote/examples/wifi-pro-26-ssl-sockets/">WiFi PRO 26: SSL sockets</a>
            </li></ul><li>
            <a href="/development/waspmote/examples/?cat=communication-examples&subcat=zigbee" id="subsubcategory_zigbee"
               class="label_subsubcategory"><span></span>
                ZigBee</a>
        </li><ul id="subsubcategory_zigbee_list"
             class="subsubcategory_list">
            <li id="dev_zb-01a-coordinator-creates-network">
                <a href="http://www.libelium.com/development/waspmote/examples/zb-01a-coordinator-creates-network/">ZB 01a: Coordinator set up</a>
            </li>
            <li id="dev_zb-01b-coordinator-resets-network">
                <a href="http://www.libelium.com/development/waspmote/examples/zb-01b-coordinator-resets-network/">ZB 01b: Coordinator reset</a>
            </li>
            <li id="dev_zb-02a-router-joins-known-network">
                <a href="http://www.libelium.com/development/waspmote/examples/zb-02a-router-joins-known-network/">ZB 02a: Join known network</a>
            </li>
            <li id="dev_zb-02b-router-joins-unknown-network">
                <a href="http://www.libelium.com/development/waspmote/examples/zb-02b-router-joins-unknown-network/">ZB 02b: Join unkown network</a>
            </li>
            <li id="dev_zb-03-send-packets">
                <a href="http://www.libelium.com/development/waspmote/examples/zb-03-send-packets/">ZB 03: Send packets</a>
            </li>
            <li id="dev_zb-04-receive-packets">
                <a href="http://www.libelium.com/development/waspmote/examples/zb-04-receive-packets/">ZB 04: Receive packets</a>
            </li>
            <li id="dev_zb-05a-send-broadcast">
                <a href="http://www.libelium.com/development/waspmote/examples/zb-05a-send-broadcast/">ZB 05a: Send broadcast</a>
            </li>
            <li id="dev_zb-05b-receive-broadcast">
                <a href="http://www.libelium.com/development/waspmote/examples/zb-05b-receive-broadcast/">ZB 05b: Receive broadcast</a>
            </li>
            <li id="dev_zb-06-get-rssi">
                <a href="http://www.libelium.com/development/waspmote/examples/zb-06-get-rssi/">ZB 06: Get RSSI</a>
            </li>
            <li id="dev_zb-07a-expansion-board-send">
                <a href="http://www.libelium.com/development/waspmote/examples/zb-07a-expansion-board-send/">ZB 07a: Expansion board TX</a>
            </li>
            <li id="dev_zb-07b-expansion-board-reception">
                <a href="http://www.libelium.com/development/waspmote/examples/zb-07b-expansion-board-reception/">ZB 07b: Expansion board RX</a>
            </li>
            <li id="dev_zb-08-set-low-power-mode">
                <a href="http://www.libelium.com/development/waspmote/examples/zb-08-set-low-power-mode/">ZB 08: Set low power mode</a>
            </li>
            <li id="dev_zb-09a-complete-example-send">
                <a href="http://www.libelium.com/development/waspmote/examples/zb-09a-complete-example-send/">ZB 09a: Complete example TX</a>
            </li>
            <li id="dev_zb-09b-complete-example-receive">
                <a href="http://www.libelium.com/development/waspmote/examples/zb-09b-complete-example-receive/">ZB 09b: Complete example RX</a>
            </li>
            <li id="dev_zb-10-scan-network">
                <a href="http://www.libelium.com/development/waspmote/examples/zb-10-scan-network/">ZB 10: Scan network</a>
            </li>
            <li id="dev_zb-11a-node-search-tx">
                <a href="http://www.libelium.com/development/waspmote/examples/zb-11a-node-search-tx/">ZB 11a: Search node TX</a>
            </li>
            <li id="dev_zb-11b-node-search-rx">
                <a href="http://www.libelium.com/development/waspmote/examples/zb-11b-node-search-rx/">ZB 11b: Search node RX</a>
            </li>
            <li id="dev_zb-12a-setting-encryption-mode-coordinator">
                <a href="http://www.libelium.com/development/waspmote/examples/zb-12a-setting-encryption-mode-coordinator/">ZB 12a: Encryption in Coordinator</a>
            </li>
            <li id="dev_zb-12b-setting-encryption-mode-routers">
                <a href="http://www.libelium.com/development/waspmote/examples/zb-12b-setting-encryption-mode-routers/">ZB 12b: Encryption in Router</a>
            </li>
            <li id="dev_zb-13-send-atcommand">
                <a href="http://www.libelium.com/development/waspmote/examples/zb-13-send-atcommand/">ZB 13: Send AT commands</a>
            </li>
            <li id="dev_zb-14-setread-power-level">
                <a href="http://www.libelium.com/development/waspmote/examples/zb-14-setread-power-level/">ZB 14: Set/Read Power Level</a>
            </li>
            <li id="dev_zb-15-set-time-from-meshlium">
                <a href="http://www.libelium.com/development/waspmote/examples/zb-15-set-time-from-meshlium/">ZB 15: Set time from Meshlium</a>
            </li></ul></ul><li>
        <a href="#" id="subcategory_combined"
           class="label_subcategory"><span></span>
            Combined</a>
    </li><ul id="subcategory_combined_list"
         class="subcategory_list"><li>
            <a href="/development/waspmote/examples/?cat=combined&subcat=data-in-data-out" id="subsubcategory_data-in-data-out"
               class="label_subsubcategory"><span></span>
                Data In / Data Out</a>
        </li><ul id="subsubcategory_data-in-data-out_list"
             class="subsubcategory_list"></ul><li>
            <a href="/development/waspmote/examples/?cat=combined&subcat=sensors-radio" id="subsubcategory_sensors-radio"
               class="label_subsubcategory"><span></span>
                Sensors + Radio</a>
        </li><ul id="subsubcategory_sensors-radio_list"
             class="subsubcategory_list"></ul></ul><li>
        <a href="#" id="subcategory_mote-runner"
           class="label_subcategory"><span></span>
            Mote Runner</a>
    </li><ul id="subcategory_mote-runner_list"
         class="subcategory_list">
        <li id="dev_mr-6lowpan-01-reply">
            <a href="http://www.libelium.com/development/waspmote/examples/mr-6lowpan-01-reply/">MR-6LowPAN 01: Reply</a>
        </li>
        <li id="dev_mr-ag-2-humidity-sensor-reading">
            <a href="http://www.libelium.com/development/waspmote/examples/mr-ag-2-humidity-sensor-reading/">MR-Ag 02: Humidity Sensor Reading</a>
        </li>
        <li id="dev_mr-ag-03-atmospheric-pressure-sensor-reading">
            <a href="http://www.libelium.com/development/waspmote/examples/mr-ag-03-atmospheric-pressure-sensor-reading/">MR-Ag 03: Atmospheric Pressure Sensor Reading</a>
        </li>
        <li id="dev_mr-ag-4-ldr-sensor-reading">
            <a href="http://www.libelium.com/development/waspmote/examples/mr-ag-4-ldr-sensor-reading/">MR-Ag 04: LDR Sensor Reading</a>
        </li>
        <li id="dev_mr-ag-5-leaf-wetness-sensor-reading">
            <a href="http://www.libelium.com/development/waspmote/examples/mr-ag-5-leaf-wetness-sensor-reading/">MR-Ag 05: Leaf Wetness Sensor Reading</a>
        </li>
        <li id="dev_mr-ag-6-digital-humidity-sensor-reading">
            <a href="http://www.libelium.com/development/waspmote/examples/mr-ag-6-digital-humidity-sensor-reading/">MR-Ag 06: Digital Humidity Sensor Reading</a>
        </li>
        <li id="dev_mr-ag-7-radiation-sensor-reading">
            <a href="http://www.libelium.com/development/waspmote/examples/mr-ag-7-radiation-sensor-reading/">MR-Ag 07: Radiation sensor reading</a>
        </li>
        <li id="dev_mr-ag-8-dendrometer-sensor-reading">
            <a href="http://www.libelium.com/development/waspmote/examples/mr-ag-8-dendrometer-sensor-reading/">MR-Ag 08: Dendrometer sensor reading</a>
        </li>
        <li id="dev_mr-ag-9-pt1000-sensor-reading">
            <a href="http://www.libelium.com/development/waspmote/examples/mr-ag-9-pt1000-sensor-reading/">MR-Ag 09: PT1000 sensor reading</a>
        </li>
        <li id="dev_mr-ag-10-watermark-sensor-reading">
            <a href="http://www.libelium.com/development/waspmote/examples/mr-ag-10-watermark-sensor-reading/">MR-Ag 10: Watermark sensor reading</a>
        </li>
        <li id="dev_mr-ag-11-anemometer-sensor-reading">
            <a href="http://www.libelium.com/development/waspmote/examples/mr-ag-11-anemometer-sensor-reading/">MR-Ag 11: Anemometer sensor reading</a>
        </li></ul><li>
        <a href="#" id="subcategory_mr-general"
           class="label_subcategory"><span></span>
            General</a>
    </li><ul id="subcategory_mr-general_list"
         class="subcategory_list"><li>
            <a href="/development/waspmote/examples/?cat=mr-general&subcat=mr-adc" id="subsubcategory_mr-adc"
               class="label_subsubcategory"><span></span>
                ADC</a>
        </li><ul id="subsubcategory_mr-adc_list"
             class="subsubcategory_list">
            <li id="dev_mr-general-02-analog-syncrhonous-reading">
                <a href="http://www.libelium.com/development/waspmote/examples/mr-general-02-analog-syncrhonous-reading/">MR-General 02: Analog syncrhonous reading</a>
            </li>
            <li id="dev_mr-general-03-analog-asyncrhonous-reading">
                <a href="http://www.libelium.com/development/waspmote/examples/mr-general-03-analog-asyncrhonous-reading/">MR-General 03: Analog asyncrhonous reading</a>
            </li></ul><li>
            <a href="/development/waspmote/examples/?cat=mr-general&subcat=mr-gpio" id="subsubcategory_mr-gpio"
               class="label_subsubcategory"><span></span>
                GPIO</a>
        </li><ul id="subsubcategory_mr-gpio_list"
             class="subsubcategory_list">
            <li id="dev_mr-general-01-gpio-example">
                <a href="http://www.libelium.com/development/waspmote/examples/mr-general-01-gpio-example/">MR-General 01: GPIO Example</a>
            </li></ul><li>
            <a href="/development/waspmote/examples/?cat=mr-general&subcat=mr-i2c" id="subsubcategory_mr-i2c"
               class="label_subsubcategory"><span></span>
                I2C</a>
        </li><ul id="subsubcategory_mr-i2c_list"
             class="subsubcategory_list">
            <li id="dev_mr-general-05-i2c-reading">
                <a href="http://www.libelium.com/development/waspmote/examples/mr-general-05-i2c-reading/">MR-General 05: I2C reading</a>
            </li></ul><li>
            <a href="/development/waspmote/examples/?cat=mr-general&subcat=mr-interruptions" id="subsubcategory_mr-interruptions"
               class="label_subsubcategory"><span></span>
                Interruptions</a>
        </li><ul id="subsubcategory_mr-interruptions_list"
             class="subsubcategory_list">
            <li id="dev_mr-general-04-interruptions">
                <a href="http://www.libelium.com/development/waspmote/examples/mr-general-04-interruptions/">MR-General 04: Interruptions</a>
            </li></ul><li>
            <a href="/development/waspmote/examples/?cat=mr-general&subcat=mr-rtc" id="subsubcategory_mr-rtc"
               class="label_subsubcategory"><span></span>
                RTC</a>
        </li><ul id="subsubcategory_mr-rtc_list"
             class="subsubcategory_list">
            <li id="dev_mr-rtc-01-general-rtc-example">
                <a href="http://www.libelium.com/development/waspmote/examples/mr-rtc-01-general-rtc-example/">MR-RTC 01: General RTC Example</a>
            </li></ul></ul><li>
        <a href="#" id="subcategory_mr-6lowpan"
           class="label_subcategory"><span></span>
            6LoWPAN</a>
    </li><ul id="subcategory_mr-6lowpan_list"
         class="subcategory_list">
        <li id="dev_mr-6lowpan-01-reply">
            <a href="http://www.libelium.com/development/waspmote/examples/mr-6lowpan-01-reply/">MR-6LowPAN 01: Reply</a>
        </li></ul><li>
        <a href="#" id="subcategory_mr-sensor-boards"
           class="label_subcategory"><span></span>
            Sensor Boards</a>
    </li><ul id="subcategory_mr-sensor-boards_list"
         class="subcategory_list"><li>
            <a href="/development/waspmote/examples/?cat=mr-sensor-boards&subcat=mr-agriculture" id="subsubcategory_mr-agriculture"
               class="label_subsubcategory"><span></span>
                Agriculture</a>
        </li><ul id="subsubcategory_mr-agriculture_list"
             class="subsubcategory_list">
            <li id="dev_mr-ag-1-temperature-sensor-reading">
                <a href="http://www.libelium.com/development/waspmote/examples/mr-ag-1-temperature-sensor-reading/">MR-Ag 01: Temperature sensor reading</a>
            </li>
            <li id="dev_mr-ag-2-humidity-sensor-reading">
                <a href="http://www.libelium.com/development/waspmote/examples/mr-ag-2-humidity-sensor-reading/">MR-Ag 02: Humidity Sensor Reading</a>
            </li>
            <li id="dev_mr-ag-03-atmospheric-pressure-sensor-reading">
                <a href="http://www.libelium.com/development/waspmote/examples/mr-ag-03-atmospheric-pressure-sensor-reading/">MR-Ag 03: Atmospheric Pressure Sensor Reading</a>
            </li>
            <li id="dev_mr-ag-4-ldr-sensor-reading">
                <a href="http://www.libelium.com/development/waspmote/examples/mr-ag-4-ldr-sensor-reading/">MR-Ag 04: LDR Sensor Reading</a>
            </li>
            <li id="dev_mr-ag-5-leaf-wetness-sensor-reading">
                <a href="http://www.libelium.com/development/waspmote/examples/mr-ag-5-leaf-wetness-sensor-reading/">MR-Ag 05: Leaf Wetness Sensor Reading</a>
            </li>
            <li id="dev_mr-ag-6-digital-humidity-sensor-reading">
                <a href="http://www.libelium.com/development/waspmote/examples/mr-ag-6-digital-humidity-sensor-reading/">MR-Ag 06: Digital Humidity Sensor Reading</a>
            </li>
            <li id="dev_mr-ag-7-radiation-sensor-reading">
                <a href="http://www.libelium.com/development/waspmote/examples/mr-ag-7-radiation-sensor-reading/">MR-Ag 07: Radiation sensor reading</a>
            </li>
            <li id="dev_mr-ag-8-dendrometer-sensor-reading">
                <a href="http://www.libelium.com/development/waspmote/examples/mr-ag-8-dendrometer-sensor-reading/">MR-Ag 08: Dendrometer sensor reading</a>
            </li>
            <li id="dev_mr-ag-9-pt1000-sensor-reading">
                <a href="http://www.libelium.com/development/waspmote/examples/mr-ag-9-pt1000-sensor-reading/">MR-Ag 09: PT1000 sensor reading</a>
            </li>
            <li id="dev_mr-ag-10-watermark-sensor-reading">
                <a href="http://www.libelium.com/development/waspmote/examples/mr-ag-10-watermark-sensor-reading/">MR-Ag 10: Watermark sensor reading</a>
            </li>
            <li id="dev_mr-ag-11-anemometer-sensor-reading">
                <a href="http://www.libelium.com/development/waspmote/examples/mr-ag-11-anemometer-sensor-reading/">MR-Ag 11: Anemometer sensor reading</a>
            </li>
            <li id="dev_mr-ag-12-vane-sensor-reading">
                <a href="http://www.libelium.com/development/waspmote/examples/mr-ag-12-vane-sensor-reading/">MR-Ag 12: Vane sensor reading</a>
            </li></ul><li>
            <a href="/development/waspmote/examples/?cat=mr-sensor-boards&subcat=mr-events" id="subsubcategory_mr-events"
               class="label_subsubcategory"><span></span>
                Events</a>
        </li><ul id="subsubcategory_mr-events_list"
             class="subsubcategory_list">
            <li id="dev_mr-ev-01-socket-7-reading-with-pir-sensor">
                <a href="http://www.libelium.com/development/waspmote/examples/mr-ev-01-socket-7-reading-with-pir-sensor/">MR-Ev 01: Socket 7 Reading with PIR Sensor</a>
            </li>
            <li id="dev_mr-ev-02-socket-1-reading-with-resistive-sensor">
                <a href="http://www.libelium.com/development/waspmote/examples/mr-ev-02-socket-1-reading-with-resistive-sensor/">MR-Ev 02: Socket 1 Reading with Resistive Sensor</a>
            </li></ul><li>
            <a href="/development/waspmote/examples/?cat=mr-sensor-boards&subcat=mr-gases-mr-sensor-boards" id="subsubcategory_mr-gases-mr-sensor-boards"
               class="label_subsubcategory"><span></span>
                Gases</a>
        </li><ul id="subsubcategory_mr-gases-mr-sensor-boards_list"
             class="subsubcategory_list">
            <li id="dev_mr-ga-01-co-sensor-on-socket-4-reading">
                <a href="http://www.libelium.com/development/waspmote/examples/mr-ga-01-co-sensor-on-socket-4-reading/">MR-Ga 01: CO Sensor on Socket 4 Reading</a>
            </li>
            <li id="dev_mr-ga-02-socket-2a-reading">
                <a href="http://www.libelium.com/development/waspmote/examples/mr-ga-02-socket-2a-reading/">MR-Ga 02: Socket 2A Reading</a>
            </li></ul><li>
            <a href="/development/waspmote/examples/?cat=mr-sensor-boards&subcat=mr-parking-mr-sensor-boards" id="subsubcategory_mr-parking-mr-sensor-boards"
               class="label_subsubcategory"><span></span>
                Parking</a>
        </li><ul id="subsubcategory_mr-parking-mr-sensor-boards_list"
             class="subsubcategory_list">
            <li id="dev_mr-pa-smart-parking-example">
                <a href="http://www.libelium.com/development/waspmote/examples/mr-pa-smart-parking-example/">MR-Pa: Smart Parking Example</a>
            </li></ul><li>
            <a href="/development/waspmote/examples/?cat=mr-sensor-boards&subcat=mr-prototyping" id="subsubcategory_mr-prototyping"
               class="label_subsubcategory"><span></span>
                Prototyping</a>
        </li><ul id="subsubcategory_mr-prototyping_list"
             class="subsubcategory_list">
            <li id="dev_mr-pr-01-reading-the-adc">
                <a href="http://www.libelium.com/development/waspmote/examples/mr-pr-01-reading-the-adc/">MR-Pr 01: Reading the ADC</a>
            </li></ul><li>
            <a href="/development/waspmote/examples/?cat=mr-sensor-boards&subcat=mr-radiation" id="subsubcategory_mr-radiation"
               class="label_subsubcategory"><span></span>
                Radiation</a>
        </li><ul id="subsubcategory_mr-radiation_list"
             class="subsubcategory_list">
            <li id="dev_mr-rb-reading-radiation">
                <a href="http://www.libelium.com/development/waspmote/examples/mr-rb-reading-radiation/">MR-RB 01: Reading Radiation</a>
            </li></ul><li>
            <a href="/development/waspmote/examples/?cat=mr-sensor-boards&subcat=mr-cities" id="subsubcategory_mr-cities"
               class="label_subsubcategory"><span></span>
                Smart Cities</a>
        </li><ul id="subsubcategory_mr-cities_list"
             class="subsubcategory_list">
            <li id="dev_mr-sc-01-temperature-sensor-reading">
                <a href="http://www.libelium.com/development/waspmote/examples/mr-sc-01-temperature-sensor-reading/">MR-SC 01: Temperature Sensor Reading</a>
            </li>
            <li id="dev_mr-sc-02-dust-sensor-reading">
                <a href="http://www.libelium.com/development/waspmote/examples/mr-sc-02-dust-sensor-reading/">MR-SC 02: Dust Sensor Reading</a>
            </li></ul><li>
            <a href="/development/waspmote/examples/?cat=mr-sensor-boards&subcat=mr-smart" id="subsubcategory_mr-smart"
               class="label_subsubcategory"><span></span>
                Smart Metering</a>
        </li><ul id="subsubcategory_mr-smart_list"
             class="subsubcategory_list">
            <li id="dev_mr-sm-01-current-sensor-reading">
                <a href="http://www.libelium.com/development/waspmote/examples/mr-sm-01-current-sensor-reading/">MR-SM 01: Current Sensor Reading</a>
            </li>
            <li id="dev_mr-sm-02-flow-sensor-reading">
                <a href="http://www.libelium.com/development/waspmote/examples/mr-sm-02-flow-sensor-reading/">MR-SM 02: Flow Sensor Reading</a>
            </li>
            <li id="dev_mr-sm-03-humidity-sensor-reading">
                <a href="http://www.libelium.com/development/waspmote/examples/mr-sm-03-humidity-sensor-reading/">MR-SM 03: Humidity Sensor Reading</a>
            </li>
            <li id="dev_mr-sm-04-load-cell-sensor-reading">
                <a href="http://www.libelium.com/development/waspmote/examples/mr-sm-04-load-cell-sensor-reading/">MR-SM 04: Load Cell Sensor Reading</a>
            </li>
            <li id="dev_mr-sm-05-linear-displacement-sensor-reading">
                <a href="http://www.libelium.com/development/waspmote/examples/mr-sm-05-linear-displacement-sensor-reading/">MR-SM 05: Linear Displacement Sensor Reading</a>
            </li>
            <li id="dev_mr-sm-06-ldr-sensor-reading">
                <a href="http://www.libelium.com/development/waspmote/examples/mr-sm-06-ldr-sensor-reading/">MR-SM 06: LDR Sensor Reading</a>
            </li>
            <li id="dev_mr-sm-07-ultrasound-sensor-reading">
                <a href="http://www.libelium.com/development/waspmote/examples/mr-sm-07-ultrasound-sensor-reading/">MR-SM 07: Ultrasound Sensor Reading</a>
            </li></ul></ul><li>
            <a href="/development/waspmote/examples/?cat=recent" id="subcategory_recent"
               class="label_subcategory"><span></span>
                Recently Updated</a>
        </li><ul id="subcategory_recent_list"
             class="subcategory_list">
            <li id="dev_wifi-pro-26-ssl-sockets">
                <a href="http://www.libelium.com/development/waspmote/examples/wifi-pro-26-ssl-sockets/">WiFi PRO 26: SSL sockets</a>
            </li>
            <li id="dev_wifi-pro-25-firmware-version">
                <a href="http://www.libelium.com/development/waspmote/examples/wifi-pro-25-firmware-version/">WiFi PRO 25: Firmware version</a>
            </li>
            <li id="dev_lorawan-01a-configure-module-eu">
                <a href="http://www.libelium.com/development/waspmote/examples/lorawan-01a-configure-module-eu/">LoRaWAN 01a: Configure module EU</a>
            </li>
            <li id="dev_lorawan-01b-configure-module-us">
                <a href="http://www.libelium.com/development/waspmote/examples/lorawan-01b-configure-module-us/">LoRaWAN 01b: Configure module US</a>
            </li>
            <li id="dev_lorawan-02a-channels-configuration-eu">
                <a href="http://www.libelium.com/development/waspmote/examples/lorawan-02a-channels-configuration-eu/">LoRaWAN 02a: Channels EU</a>
            </li>
            <li id="dev_lorawan-03-power-level">
                <a href="http://www.libelium.com/development/waspmote/examples/lorawan-03-power-level/">LoRaWAN 03: Power level</a>
            </li>
            <li id="dev_lorawan-05-adaptive-data-rate">
                <a href="http://www.libelium.com/development/waspmote/examples/lorawan-05-adaptive-data-rate/">LoRaWAN 05: Adaptive data rate</a>
            </li>
            <li id="dev_lorawan-06-join-abp-send-unconfirmed">
                <a href="http://www.libelium.com/development/waspmote/examples/lorawan-06-join-abp-send-unconfirmed/">LoRaWAN 06: Join ABP send unconfirmed</a>
            </li>
            <li id="dev_lorawan-07-join-abp-send-confirmed">
                <a href="http://www.libelium.com/development/waspmote/examples/lorawan-07-join-abp-send-confirmed/">LoRaWAN 07: Join ABP send confirmed</a>
            </li>
            <li id="dev_lorawan-09-join-otaa-send-unconfirmed">
                <a href="http://www.libelium.com/development/waspmote/examples/lorawan-09-join-otaa-send-unconfirmed/">LoRaWAN 09: Join OTAA send unconfirmed</a>
            </li></ul></ul>
    <script type="text/javascript">
        var categories_special_main =["mote-runner"];var categories_special_total =["mote-runner","mr-general","mr-6lowpan","mr-sensor-boards"];var categories_special =[{"slug":"mote-runner","title":"Mote Runner","categories":["mr-general","mr-6lowpan","mr-sensor-boards"]}];var subcategory = "examples";var subsubcategory ="general-examples";var subsubsubcategory = "utils";var dev_page = "ut-06-stack-eeprom-basic-operation";if ($.inArray(subsubcategory,categories_special_total) != -1) {function hide_category(cat_names) {$('.label_subcategory').each(function() {if ($.inArray($(this).attr('id').split('_')[1],cat_names) == -1)$(this).parent('li').remove()});$('.subcategory_list').each(function() {if ($.inArray($(this).attr('id').split('_')[1],cat_names) == -1)$(this).remove()})}if ($.inArray(subsubcategory, categories_special_main) != -1) {for (var i=0; i<categories_special.length;i++) {$('#widget-directory h2').html(categories_special[i]['title']+' examples');hide_category(categories_special[i]['categories'])}}else {for (var i=0; i<categories_special.length;i++) {if (subsubcategory, categories_special[i]['categories'] != -1) {$('#widget-directory h2').html(categories_special[i]['title']+' examples');hide_category(categories_special[i]['categories']);break}}}}else {for (var i=0;i<categories_special_total.length;i++) {$('#subcategory_'+categories_special_total[i]).parent('li').remove();$('#subcategory_'+categories_special_total[i]+'_list').remove()}}if (subcategory == 'examples')$('.subcategory_list').addClass('noliststyle');$('#subcategory_recent_list').removeClass('noliststyle');$('#subcategory_'+subsubcategory+', #subcategory_'+subsubcategory+'_list, #subsubcategory_'+subsubsubcategory+', #subsubcategory_'+subsubsubcategory+'_list').addClass('active');$('#dev_'+dev_page).append($('#dev_'+dev_page).find('a').html()).find('a').remove();$('ul.subcategory_list, ul.subsubcategory_list').each(function() {if (!$(this).hasClass('active')) $(this).hide(); });$('a.label_subcategory span').click(function() {var active = ($(this).parent('a').hasClass('active'))? true : false;$('a.label_subcategory').removeClass('active');if (!active)$(this).parent('a').addClass('active');$('ul.subcategory_list').removeClass('active').hide();if (!active)$('ul#'+$(this).parent('a').attr('id')+'_list').show().addClass('active');$('#'+$(this).parent('a').attr('id')+'_list ul').hide();$('#'+$(this).parent('a').attr('id')+'_list li a').removeClass('active');return false});$('a.label_subcategory').click(function() {if ($(this).attr('href') == '#') {var active = ($(this).hasClass('active'))? true : false;$('a.label_subcategory').removeClass('active');if (!active)$(this).addClass('active');$('ul.subcategory_list').removeClass('active').hide();if (!active)$('ul#'+$(this).attr('id')+'_list').show().addClass('active');$('#'+$(this).attr('id')+'_list ul').hide();$('#'+$(this).attr('id')+'_list li a').removeClass('active');return false}});$('a.label_subsubcategory span').click(function() {var active = ($(this).parent('a').hasClass('active'))? true : false;$('a.label_subsubcategory').removeClass('active');if (!active) $(this).parent('a').addClass('active');$('ul.subsubcategory_list').removeClass('active').hide();if (!active) $('ul#'+$(this).parent('a').attr('id')+'_list').show().addClass('active');return false});$('.subsubcategory_list').each(function(i, val) {if($(val).children().length == 0) {$(val).prev('li').remove()}});$('.subcategory_list').each(function(i, val) {if($(val).children(':not(ul)').length == 0) {$(val).prev('li').remove()}});
    </script>


        </div>

    
    <!-- Forum widget -->

    <div id="widget-generic" class="boxgradient widget twocolumn">
        <h2 class="titlegrey">Forum</h2>
        <img class="icon-widget" id="icon-forum" src="http://www.libelium.com/resources/images/content/development/forum_icon.png" width="81" height="69" alt="Forum icon" />
        <p>Share your questions<br />with our Developer<br />Community</p>
        <div class="buttonshort"><a href="/forum/" style="padding-right: 15px"><div style="margin-right: 11px"></div> Forum</a></div>
    </div>

    
        <!-- Developers widget -->

        <div id="widget-generic" class="boxgradient widget twocolumn">
            <h2 class="titlegrey">Code for Developers</h2>
            <img class="icon-widget" id="icon-developers" src="http://www.libelium.com/resources/images/content/development/github_icon.png" width="81" height="69" alt="Github icon" />
            <p>Share your code using<br />the GitHub Code<br />Repository</p>
            <div class="buttonshort margintop16"><a href="http://www.libelium.com/developers/" style="padding-right: 19px"><div style="margin-right: 15px"></div> Enter</a></div>
        </div>

    
    <!-- Suggestion widget -->

    <div id="widget-generic" class="boxgradient widget twocolumn">
        <h2 class="titlegrey">Suggestion Box</h2>
        <img class="icon-widget" id="icon-suggestions" src="http://www.libelium.com/resources/images/content/development/suggestions_icon.png" width="81" height="69" alt="Sugestion icon" />
        <p class="marginbottom20">Your feedback is<br />important to us</p>
        <div class="buttonshort">
            <a href="http://www.libelium.com/contact/#general" id="suggestions"><div></div> Contact</a>
        </div>
    </div>

    <script type="text/javascript">

        //Handle special categories

                if ($.inArray(subsubcategory,categories_special_total) != -1)
            $('#widget-note-orange, #widget-note').hide();
        
        // Handler newsletter form submit
        $('#suggestion').click(function() {

            visor_text(
                '<form id="suggestion_form">'+
                '<h2 class="title"><span>&rsaquo;</span> Suggestions</h2>'+
                '<table>'+
                '<tr>'+
                '<th class="row1"><label for="suggestion_name">Name<span class="rojo">(*)</span></label></th>'+
                '<td class="row2"><input type="text" name="suggestion_name" tabindex="1" /></td>'+
                '<th><label for="suggestion_message">Message<span class="rojo">(*)</span></label></th>'+
                '</tr>'+
                '<tr>'+
                '<th class="row1"><label for="suggestion_country">Country <span class="rojo">(*)</span></label></th>'+
                '<td class="row2"><select name="suggestion_country" id="suggestion_country" size="1" tabindex="2">'+
                '<option value="noSelected">Select Country</option>'+
                "<option value=\"Afghanistan\">Afghanistan</option><option value=\"Albania\">Albania</option><option value=\"Algeria\">Algeria</option><option value=\"Andorra\">Andorra</option><option value=\"Angola\">Angola</option><option value=\"Antarctica\">Antarctica</option><option value=\"Antigua and Barbuda\">Antigua and Barbuda</option><option value=\"Argentina\">Argentina</option><option value=\"Armenia\">Armenia</option><option value=\"Australia\">Australia</option><option value=\"Austria\">Austria</option><option value=\"Azerbaijan\">Azerbaijan</option><option value=\"Bahamas\">Bahamas</option><option value=\"Bahrain\">Bahrain</option><option value=\"Bangladesh\">Bangladesh</option><option value=\"Barbados\">Barbados</option><option value=\"Belarus\">Belarus</option><option value=\"Belgium\">Belgium</option><option value=\"Belize\">Belize</option><option value=\"Benin\">Benin</option><option value=\"Bermuda\">Bermuda</option><option value=\"Bhutan\">Bhutan</option><option value=\"Bolivia\">Bolivia</option><option value=\"Bosnia and Herzegovina\">Bosnia and Herzegovina</option><option value=\"Botswana\">Botswana</option><option value=\"Brazil\">Brazil</option><option value=\"Brunei\">Brunei</option><option value=\"Bulgaria\">Bulgaria</option><option value=\"Burkina Faso\">Burkina Faso</option><option value=\"Burma\">Burma</option><option value=\"Burundi\">Burundi</option><option value=\"Cambodia\">Cambodia</option><option value=\"Cameroon\">Cameroon</option><option value=\"Canada\">Canada</option><option value=\"Cape Verde\">Cape Verde</option><option value=\"Central African Republic\">Central African Republic</option><option value=\"Chad\">Chad</option><option value=\"Chile\">Chile</option><option value=\"China\">China</option><option value=\"Colombia\">Colombia</option><option value=\"Comoros\">Comoros</option><option value=\"Congo, Democratic Republic\">Congo, Democratic Republic</option><option value=\"Congo, Republic of the\">Congo, Republic of the</option><option value=\"Costa Rica\">Costa Rica</option><option value=\"Cote d\'Ivoire\">Cote d\'Ivoire</option><option value=\"Croatia\">Croatia</option><option value=\"Cuba\">Cuba</option><option value=\"Cyprus\">Cyprus</option><option value=\"Czech Republic\">Czech Republic</option><option value=\"Denmark\">Denmark</option><option value=\"Djibouti\">Djibouti</option><option value=\"Dominica\">Dominica</option><option value=\"Dominican Republic\">Dominican Republic</option><option value=\"East Timor\">East Timor</option><option value=\"Ecuador\">Ecuador</option><option value=\"Egypt\">Egypt</option><option value=\"El Salvador\">El Salvador</option><option value=\"Equatorial Guinea\">Equatorial Guinea</option><option value=\"Eritrea\">Eritrea</option><option value=\"Estonia\">Estonia</option><option value=\"Ethiopia\">Ethiopia</option><option value=\"Fiji\">Fiji</option><option value=\"Finland\">Finland</option><option value=\"France\">France</option><option value=\"Gabon\">Gabon</option><option value=\"Gambia\">Gambia</option><option value=\"Georgia\">Georgia</option><option value=\"Germany\">Germany</option><option value=\"Ghana\">Ghana</option><option value=\"Greece\">Greece</option><option value=\"Greenland\">Greenland</option><option value=\"Grenada\">Grenada</option><option value=\"Guatemala\">Guatemala</option><option value=\"Guinea\">Guinea</option><option value=\"Guinea-Bissau\">Guinea-Bissau</option><option value=\"Guyana\">Guyana</option><option value=\"Haiti\">Haiti</option><option value=\"Honduras\">Honduras</option><option value=\"Hong Kong\">Hong Kong</option><option value=\"Hungary\">Hungary</option><option value=\"Iceland\">Iceland</option><option value=\"India\">India</option><option value=\"Indonesia\">Indonesia</option><option value=\"Iran\">Iran</option><option value=\"Iraq\">Iraq</option><option value=\"Ireland\">Ireland</option><option value=\"Israel\">Israel</option><option value=\"Italy\">Italy</option><option value=\"Jamaica\">Jamaica</option><option value=\"Japan\">Japan</option><option value=\"Jordan\">Jordan</option><option value=\"Kazakhstan\">Kazakhstan</option><option value=\"Kenya\">Kenya</option><option value=\"Kiribati\">Kiribati</option><option value=\"Korea, North\">Korea, North</option><option value=\"Korea, South\">Korea, South</option><option value=\"Kuwait\">Kuwait</option><option value=\"Kyrgyzstan\">Kyrgyzstan</option><option value=\"Laos\">Laos</option><option value=\"Latvia\">Latvia</option><option value=\"Lebanon\">Lebanon</option><option value=\"Lesotho\">Lesotho</option><option value=\"Liberia\">Liberia</option><option value=\"Libya\">Libya</option><option value=\"Liechtenstein\">Liechtenstein</option><option value=\"Lithuania\">Lithuania</option><option value=\"Luxembourg\">Luxembourg</option><option value=\"Macedonia\">Macedonia</option><option value=\"Madagascar\">Madagascar</option><option value=\"Malawi\">Malawi</option><option value=\"Malaysia\">Malaysia</option><option value=\"Maldives\">Maldives</option><option value=\"Mali\">Mali</option><option value=\"Malta\">Malta</option><option value=\"Marshall Islands\">Marshall Islands</option><option value=\"Mauritania\">Mauritania</option><option value=\"Mauritius\">Mauritius</option><option value=\"Mexico\">Mexico</option><option value=\"Micronesia\">Micronesia</option><option value=\"Moldova\">Moldova</option><option value=\"Mongolia\">Mongolia</option><option value=\"Monaco\">Monaco</option><option value=\"Montenegro\">Montenegro</option><option value=\"Morocco\">Morocco</option><option value=\"Mozambique\">Mozambique</option><option value=\"Namibia\">Namibia</option><option value=\"Nauru\">Nauru</option><option value=\"Nepal\">Nepal</option><option value=\"Netherlands\">Netherlands</option><option value=\"New Zealand\">New Zealand</option><option value=\"Nicaragua\">Nicaragua</option><option value=\"Niger\">Niger</option><option value=\"Nigeria\">Nigeria</option><option value=\"Norway\">Norway</option><option value=\"Oman\">Oman</option><option value=\"Pakistan\">Pakistan</option><option value=\"Panama\">Panama</option><option value=\"Papua New Guinea\">Papua New Guinea</option><option value=\"Paraguay\">Paraguay</option><option value=\"Peru\">Peru</option><option value=\"Philippines\">Philippines</option><option value=\"Poland\">Poland</option><option value=\"Portugal\">Portugal</option><option value=\"Qatar\">Qatar</option><option value=\"Reunion (FR)\">Reunion (FR)</option><option value=\"Romania\">Romania</option><option value=\"Russia\">Russia</option><option value=\"Rwanda\">Rwanda</option><option value=\"Samoa\">Samoa</option><option value=\"San Marino\">San Marino</option><option value=\"Sao Tome\"> Sao Tome</option><option value=\"Saudi Arabia\">Saudi Arabia</option><option value=\"Senegal\">Senegal</option><option value=\"Serbia\">Serbia</option><option value=\"Seychelles\">Seychelles</option><option value=\"Sierra Leone\">Sierra Leone</option><option value=\"Singapore\">Singapore</option><option value=\"Slovakia\">Slovakia</option><option value=\"Slovenia\">Slovenia</option><option value=\"Solomon Islands\">Solomon Islands</option><option value=\"Somalia\">Somalia</option><option value=\"South Africa\">South Africa</option><option value=\"Spain\">Spain</option><option value=\"Sri Lanka\">Sri Lanka</option><option value=\"Sudan\">Sudan</option><option value=\"Suriname\">Suriname</option><option value=\"Swaziland\">Swaziland</option><option value=\"Sweden\">Sweden</option><option value=\"Switzerland\">Switzerland</option><option value=\"Syria\">Syria</option><option value=\"Taiwan\">Taiwan</option><option value=\"Tajikistan\">Tajikistan</option><option value=\"Tanzania\">Tanzania</option><option value=\"Thailand\">Thailand</option><option value=\"Togo\">Togo</option><option value=\"Tonga\">Tonga</option><option value=\"Trinidad and Tobago\">Trinidad and Tobago</option><option value=\"Tunisia\">Tunisia</option><option value=\"Turkey\">Turkey</option><option value=\"Turkmenistan\">Turkmenistan</option><option value=\"Uganda\">Uganda</option><option value=\"Ukraine\">Ukraine</option><option value=\"United Arab Emirates\">United Arab Emirates</option><option value=\"United Kingdom\">United Kingdom</option><option value=\"United States\">United States</option><option value=\"Uruguay\">Uruguay</option><option value=\"Uzbekistan\">Uzbekistan</option><option value=\"Vanuatu\">Vanuatu</option><option value=\"Venezuela\">Venezuela</option><option value=\"Vietnam\">Vietnam</option><option value=\"Yemen\">Yemen</option><option value=\"Zambia\">Zambia</option><option value=\"Zimbabwe\">Zimbabwe</option>"+
                '</select></td>'+
                '<td rowspan="3"><textarea name="suggestion_message" tabindex="5"></textarea></td>'+
                '</tr>'+
                '<tr>'+
                '<th class="row1"><label for="suggestion_mail">E-mail <span class="rojo">(*)</span></label></th>'+
                '<td class="row2"><input type="text" name="suggestion_mail" tabindex="3"/></td>'+
                '</tr>'+
                '<tr>'+
                '<th class="row1"><label for="suggestion_subject">Subject <span class="rojo">(*)</span></label></th>'+
                '<td class="row2"><input type="text" name="suggestion_subject" tabindex="4"/></td>'+
                '</tr>'+
                '</table>'+
                '<div id="suggestion_privacy_submit" class="margintop20">'+
                '<div class="buttonshort"><a href="#submit" id="suggestion_submit"><div></div> Send Suggestion</a></div>'+
                '<input type="checkbox" name="suggestion_accept_policity" id="suggestion_accept_policity" tabindex="6"/>'+
                '<label for="suggestion_accept_policity">I have read and I accept the <a href="http://www.libelium.com/privacy-policy/" id="privacy" target="_blank">privacy policy</a><span>(*)</span></label>'+
                '</div>'+
                '</form>');

            /* Mod form */
            $('label').click(function() {
                if ($('#'+$(this).attr('for')+'_styled').length) {
                    if ($('input[name='+$(this).attr('for')+']').attr('type') == 'checkbox') {
                        if ($('#'+$(this).attr('for')+'_styled').hasClass('checked')) $('#'+$(this).attr('for')+'_styled').removeClass('checked');
                        else $('#'+$(this).attr('for')+'_styled').addClass('checked');
                    }
                    else $('#'+$(this).attr('for')+'_styled').trigger('click');
                }
            });

            $('input[type=checkbox]').each(function() {
                $(this).hide().after('<span class="checkbox" id="'+$(this).attr('id')+'_styled"></span>');
                if ($(this).attr('checked')) $('span#'+$(this).attr('id')+'_styled').addClass('checked');
            });
            $('span.checkbox').click(function() {
                if ($(this).hasClass('checked')) { $(this).removeClass('checked'); $('#'+$(this).attr('id').split('_styled')[0]).removeAttr('checked'); }
                else { $(this).addClass('checked'); $('#'+$(this).attr('id').split('_styled')[0]).attr('checked',true); }
            });

            /* Move focus to name input */
            //$('input[name=suggestion_name]').focus();

            /* Show Privacy policy */
            $('#privacy').click(function() {

                if (!$('#privacy-policy').length) {

                    $.ajax({
                        type: 'POST',
                        url: "/ajax-controller",
                        async: false,
                        data: {
                            action: 'get_page',
                            page: 4601 ,
                            lang: 'EN'
                        },
                        success: function(data, textStatus, XMLHttpRequest){

                            $('#visor_border').animate({'height':($('#visor_border').height()+177)+'px'});
                            $('#visor_content').animate({'height':($('#visor_border').height()+141)+'px'}, '', function() {

                                $('<div id="privacy-policy">'+data+'</div>').appendTo('#visor_content').fadeIn();

                            });
                        }
                    });
                }

                return false;
            });

            // Check if mail is correct (leters @ leters . leters(2-4))
            // @input str string to check
            // @return bool
            function check_mail(str) {
                var ml = /^([a-zA-Z0-9_\.\-])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,4})+$/;
                if (str != undefined && str.match(ml)) return true;
                else return false;
            }

            $('#suggestion_submit').click(function() {

                /* Remove error marks */
                $('#suggestion_form input, #suggestion_form label, #suggestion_form select, #suggestion_form textarea').removeClass('border_red red');

                /* Check form input */
                var vacios = Array();

                if (!$('input[name=suggestion_name]').val().length) vacios.push('suggestion_name');
                if ($('select[name=suggestion_country]').val() == 'noSelected') vacios.push('suggestion_country');
                if (!$('input[name=suggestion_mail]').val().length ||
                    !check_mail($('input[name=suggestion_mail]').val())) vacios.push('suggestion_mail');
                if (!$('input[name=suggestion_subject]').val().length) vacios.push('suggestion_subject');
                if (!$('textarea[name=suggestion_message]').val().length) vacios.push('suggestion_message');
                if (!$('input[name=suggestion_accept_policity]').is(':checked')) vacios.push('suggestion_accept_policity');

                //Mark in red empty fields
                for (field in vacios) {
                    $('label[for='+vacios[field]+']').addClass('red');
                    $('input[name='+vacios[field]+']').addClass('border_red');
                    $('select[name='+vacios[field]+']').addClass('border_red');
                    $('textarea[name='+vacios[field]+']').addClass('border_red');
                }

                if (vacios.length == 0) {

                    $.ajax({
                        type: 'POST',
                        url: 'http://www.libelium.com/contact/?action=submitformnoprint&form=suggestion',
                        data: {
                            suggestion_name: $('input[name=suggestion_name]').val(),
                            suggestion_country: $('select[name=suggestion_country]').val(),
                            suggestion_mail: $('input[name=suggestion_mail]').val(),
                            suggestion_subject: $('input[name=suggestion_subject]').val(),
                            suggestion_message: $('textarea[name=suggestion_message]').val(),
                            suggestion_policy: $('input[name=suggestion_accept_policity]').val()
                        },
                        success: function(response) { visor_text(response); }
                    });
                } return false;
            });

            return false;
        });



    </script>

</div>
<!-- Development Navigation Menu -->
<div id="menu_development">
    <ul class="section_list">

        <li class="first active" id="section_waspmote" style="width: 236px;">
            <a href="/development/waspmote"><img width="56" alt="Waspmote" src="/resources/images/content/development/waspmote_button.png" class="section_img">
                Waspmote</a>
        </li>

        <li class=" " id="section_plug-sense" style="width: 236px;">
            <a href="/development/plug-sense"><img width="56" alt="Plug &amp; Sense!" src="/resources/images/content/development/plug-sense_button.png" class="section_img">
                Plug &amp; Sense!</a>
        </li>

        <li class=" " id="section_meshlium" style="width: 236px;">
            <a href="/development/meshlium"><img width="56" alt="Meshlium" src="/resources/images/content/development/meshlium_button.png" class="section_img">
                Meshlium</a>
        </li>

        <li class="last " id="section_mysignals" style="width: 236px;">
            <a href="/development/mysignals"><img width="56" alt="MySignals" src="/resources/images/content/development/mysignals_button.png" class="section_img">
                MySignals</a>
        </li>

    </ul>

    <ul id="subsection_waspmote" class="subsection_list hover static">
        <li class="first " id="position_0" style="width: 166px; left: 0px;">
            <a href="/development/waspmote/documentation">Documentation</a>
        </li>
        <li class="" id="position_1" style="width: 241px; left: -8px;">
            <a href="/development/waspmote/sdk_applications">SDK and Applications</a>
        </li>
        <li class="active" id="position_2" style="width: 105px; left: -16px;">
            <a href="/development/waspmote/examples">Examples</a>
        </li>
        <li class="last " id="position_3" style="width: 196px; left: -24px;">
            <a href="/development/waspmote/technical_service">Technical Support</a>
        </li>
    </ul>
    <ul id="subsection_plug-sense" class="subsection_list deactive">
        <li class="first " id="position_0" style="width: 166px; left: 0px;">
            <a href="/development/plug-sense/documentation">Documentation</a>
        </li>
        <li class="" id="position_1" style="width: 241px; left: -8px;">
            <a href="/development/plug-sense/sdk_applications">SDK and Applications</a>
        </li>
        <li class="" id="position_2" style="width: 105px; left: -16px;">
            <a href="/development/plug-sense/examples">Examples</a>
        </li>
        <li class="last " id="position_3" style="width: 196px; left: -24px;">
            <a href="/development/plug-sense/technical_service">Technical Support</a>
        </li>
    </ul>
    <ul id="subsection_meshlium" class="subsection_list  deactive">
        <li class="first " id="position_0" style="width: 324px; left: 0px;">
            <a href="/development/meshlium/documentation">Documentation</a>
        </li>
        <li class="last " id="position_1" style="width: 384px; left: -8px;">
            <a href="/development/meshlium/technical_service">Technical Support</a>
        </li>
    </ul>
    <ul id="subsection_mysignals" class="subsection_list  deactive">
        <li class="first  " id="position_0" style="width: 224px; left: 0px;">
            <a href="/development/mysignals/documentation">Documentation</a>
        </li>
        <li class="  " id="position_1" style="width: 284px; left: -8px;">
            <a href="/development/mysignals/api_sw_tools">API & SW Tools</a>
        </li>
        <li class="last  " id="position_2" style="width: 270px; left: -16px;">
            <a href="/development/mysignals/technical_service">Technical Support</a>
        </li>
    </ul>
</div>


<style>

    section#development div#menu_development ul.section_list {
        margin-bottom: 1px;
    }
    section#development div#menu_development ul.subsection_list {
        border: 1px solid transparent;
        width: 673px;
        background: #ededed;
    }
    section#development div#menu_development ul.subsection_list.static {
        background: #f7f7f7;
        /* ACTIVE*/
        border-color: #ededed;
    }
    section#development div#menu_development ul.section_list li a {
        font-size: 11pt;
    }
    section#development div#menu_development ul.section_list img.section_img {
        top: auto;
    }
    section#development div#menu_development {
        width: 675px;
    }
    section#development div#menu_development ul.section_list li.hover,
    section#development div#menu_development ul.section_list li.active {
        border: 1px solid transparent;
        /*border-bottom-color: white;*/
        background: #ededed;
    }
    section#development div#menu_development ul.section_list li.active {
        /*background: white;*/
        background: #f7f7f7;
        /* ACTIVE */
        border: 1px solid #ededed;
        border-bottom-color: transparent;
        /*background: none;*/
    }
    section#development div#menu_development ul.section_list li {
        border: 1px solid transparent;
        left: auto;
    }
    section#development div#menu_development ul.section_list li.last {
        left: auto;
    }




    section#development div#menu_development ul.section_list li {
        background-image: none;
    }
    section#development div#menu_development ul.section_list li.hover,
    section#development div#menu_development ul.section_list li.active {
        background-image: none;
    }
    section#development div#menu_development ul.section_list li div.section_list_left {
        background-image: none;
    }
    section#development div#menu_development ul.section_list li.hover div.section_list_left,
    section#development div#menu_development ul.section_list li.active div.section_list_left {
        background-image: none;
    }
    section#development div#menu_development ul.section_list li div.section_list_right {
        background-image: none;
    }
    section#development div#menu_development ul.section_list li.hover div.section_list_right,
    section#development div#menu_development ul.section_list li.active div.section_list_right {
        background-image: none;
    }
    section#development div#menu_development ul.section_list li div.section_list_inter_left {
        background-image: none;
    }
    section#development div#menu_development ul.section_list li.hover div.section_list_inter_left,
    section#development div#menu_development ul.section_list li.active div.section_list_inter_left {
        background-image: none;

    }
    section#development div#menu_development ul.section_list li div.section_list_inter_right {
        background-image: none;

    }
    section#development div#menu_development ul.section_list li.hover div.section_list_inter_right,
    section#development div#menu_development ul.section_list li.active div.section_list_inter_right {
        background-image: none;
    }
    section#development div#menu_development ul.subsection_list li {
        background-image: none;
    }
    section#development div#menu_development ul.subsection_list.static li,
    section#development div#menu_development ul.subsection_list.hover li {
        background-image: none;
    }
    section#development div#menu_development ul.subsection_list li.active,
    section#development div#menu_development ul.subsection_list li:hover {
        background-image: none;
    }
    section#development div#menu_development ul.subsection_list li div.section_list_left {
        background-image: none;
    }
    section#development div#menu_development ul.subsection_list li.active div.section_list_left,
    section#development div#menu_development ul.subsection_list.static li div.section_list_left,
    section#development div#menu_development ul.subsection_list.hover li div.section_list_left {
        background-image: none;
    }
    section#development div#menu_development ul.subsection_list li.active div.section_list_left,
    section#development div#menu_development ul.subsection_list li:hover div.section_list_left {
        background-image: none;
    }
    section#development div#menu_development ul.subsection_list li div.section_list_right {
        background-image: none;
    }
    section#development div#menu_development ul.subsection_list li.active div.section_list_right,
    section#development div#menu_development ul.subsection_list.static li div.section_list_right,
    section#development div#menu_development ul.subsection_list.hover li div.section_list_right {
        background-image: none;
    }
    section#development div#menu_development ul.subsection_list li.active div.section_list_right,
    section#development div#menu_development ul.subsection_list li:hover div.section_list_right {
        background-image: none;
    }
    section#development div#menu_development ul.subsection_list li div.section_list_inter_right {
        background-image: none;
    }
    section#development div#menu_development ul.subsection_list li.active div.section_list_inter_right,
    section#development div#menu_development ul.subsection_list.static li div.section_list_inter_right,
    section#development div#menu_development ul.subsection_list.hover li div.section_list_inter_right {
        background-image: none;
    }
    section#development div#menu_development ul.subsection_list li.active div.section_list_inter_right,
    section#development div#menu_development ul.subsection_list li:hover div.section_list_inter_right {
        background-image: none;
    }
    section#development div#menu_development ul.subsection_list li div.section_list_inter_left {
        background-image: none;
    }
    section#development div#menu_development ul.subsection_list li.active div.section_list_inter_left,
    section#development div#menu_development ul.subsection_list.static li div.section_list_inter_left,
    section#development div#menu_development ul.subsection_list.hover li div.section_list_inter_left {
        background-image: none;
    }
    section#development div#menu_development ul.subsection_list li.active div.section_list_inter_left,
    section#development div#menu_development ul.subsection_list li:hover div.section_list_inter_left {
        background-image: none;
    }
</style>



<script type="text/javascript">$('ul.section_list li').each(function(){$(this).width(($(this).parent('ul').width()/$('ul.section_list li').length) - 2)});$('ul.section_list li.first').prepend('<div class="section_list_left"></div>');$('<div class="section_list_right"></div>').appendTo('ul.section_list li.last').css('left', $('ul.section_list li.last').width()-54);$('ul.section_list li').each(function() {if (!$(this).hasClass('first')) $(this).prepend('<div class="section_list_inter_left"></div>');if (!$(this).hasClass('last')) $(this).append('<div class="section_list_inter_right"></div>')});$('ul.subsection_list').each(function() {var anchos = Array();var ancho_total = 0;var ancho_final = 0;var total = $(this).width() - 5;var numero = 0;var parent_id = $(this).attr('id');$('#'+parent_id+' li').each(function() {anchos[numero] = $(this).width();ancho_total += $(this).width();numero++});for(var i =0; i <numero; i++) {ancho_final+= parseInt(((anchos[i]*total)/ancho_total));$('#'+parent_id+' li#position_'+i).css('width', (parseInt((anchos[i]*total)/ancho_total)))}$('#'+parent_id+' li#position_0').css('width', $('#'+parent_id+' li#position_0').width()+total-ancho_final)});$('ul.subsection_list li.first').prepend('<div class="section_list_left"></div>');$('<div class="section_list_right"></div>').appendTo('ul.subsection_list li.last');$('ul.subsection_list li.last div.section_list_right').each(function() {$(this).css('left', $(this).parent('li').width()-(32-$(this).parent('li').attr('id').match(/[\d]+$/)*8)-54)});$('ul.subsection_list li').each(function() {if (!$(this).hasClass('first')) $(this).prepend('<div class="section_list_inter_left"></div>');if (!$(this).hasClass('last')) $(this).append('<div class="section_list_inter_right"></div>');$(this).css('left','-'+$(this).attr('id').match(/[\d]+$/)*8+'px')});$('ul.subsection_list').hide();if ($('ul.section_list li.active').length == 0) {} else {$('ul.subsection_list.static').show()}$('ul.section_list li').hover(function(e) {e.preventDefault();$('ul.section_list li').removeClass('hover');$('ul.subsection_list').hide();$(this).addClass('hover');$('ul#sub'+$(this).attr('id')).addClass('hover').show()});$('ul.subsection_list').hover(function() {e.preventDefault();$('#'+$(this).attr('id').substr(3)).addClass('hover'); $('ul.subsection_list').addClass('hover')}, function() { $(this).removeClass('hover') });</script>        <article>

        <div class="entry">
    <div class="buttonshortslimdownload right" style="margin-right: 0">
        <a href="http://www.libelium.com/development/waspmote/examples/ut-06-stack-eeprom-basic-operation/?action=download" target="_blank"  onClick="_gaq.push(['_trackEvent', 'Example', 'DOWNLOAD', 'UT 06: Stack EEPROM']);">
            <div></div> Download Code</a>
    </div>
    <h3 class="title"><span>&raquo;</span> UT 06: Stack EEPROM</h3>

    <p>This example shows how to use the Stack EEPROM library of Waspmote in order to store and get pending frames using the EEPROM memory of the Waspmote device</p>
    <div class="box materials"><h4>Required Materials</h4><p>1 x Waspmote<br />
1 x Battery<br />
1 x MiniUSB wire</p></div>
    <div class="box note"><h4>Notes</h4><p>- Note that it is possible to specify the block size to be used within the EEPROM. Greater block size implies less frame slots.<br />
- This example can be executed in Waspmote v12 and Waspmote v15</p></div>
    <div class="box code"><h4>Code</h4><pre><code class="cs">/*
 *  ------   [Ut_06] - Stack EEPROM Basic operation   -------- 
 *
 *  Explanation: This example shows how to use the Stack EEPROM
 *  library of Waspmote in order to store and get pending frames
 *  using the EEPROM memory of the Waspmote device
 *
 *  Copyright (C) 2016 Libelium Comunicaciones Distribuidas S.L. 
 *  http://www.libelium.com 
 *  
 *  This program is free software: you can redistribute it and/or modify 
 *  it under the terms of the GNU General Public License as published by 
 *  the Free Software Foundation, either version 3 of the License, or 
 *  (at your option) any later version. 
 *  
 *  This program is distributed in the hope that it will be useful, 
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of 
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the 
 *  GNU General Public License for more details. 
 *  
 *  You should have received a copy of the GNU General Public License 
 *  along with this program.  If not, see &lt;http://www.gnu.org/licenses/&gt;. 
 *  
 *  Version:           3.0
 *  Design:            David Gascon 
 *  Implementation:    Alejandro Gallego
 */


#include &lt;WaspStackEEPROM.h&gt;
#include &lt;WaspFrame.h&gt;       

int answer;

void setup() 
{
  
  // set Waspmote ID
  frame.setID(&quot;node_001&quot;);
  
  //////////////////////////////////////////////////
  // 1. inits the block size and the stack  
  //////////////////////////////////////////////////
  
  // init block size
  USB.println(F(&quot;Set Block Size to '100' Bytes&quot;));
  stack.initBlockSize(100);
  
  // clear stack initializing to zeros
  USB.println(F(&quot;Clearing Stack...&quot;));
  answer = stack.initStack();
  if (answer == 1)
  {   
    USB.println(F(&quot;Stack initialized&quot;));
  }
  else
  {   
    USB.println(F(&quot;Stack NOT initialized&quot;));
  }
  
  USB.print(F(&quot;Number of stored frames:&quot;));
  USB.println(stack.getStoredFrames());

}



void loop() 
{

  //////////////////////////////////////////////////
  // 2. Create a frame
  //////////////////////////////////////////////////
  
  // Create new frame (ASCII)
  frame.createFrame(ASCII); 
  // set frame fields (String - char*)
  frame.addSensor(SENSOR_STR, (char*) &quot;Stack_example&quot;);
  // set frame fields (Battery sensor - uint8_t)
  frame.addSensor(SENSOR_BAT, (uint8_t) PWR.getBatteryLevel());

  USB.println(F(&quot;Frame to store:&quot;));
  frame.showFrame();


  //////////////////////////////////////////////////
  // 3. push frame into the stack
  //////////////////////////////////////////////////
  answer = stack.push( frame.buffer, frame.length);
  if (answer == 1)
  {   
    USB.println(F(&quot;Frame pushed&quot;));
  }
  else if (answer == 2)
  {   
    USB.println(F(&quot;Stack is full, frame not pushed&quot;));
  }
  else if (answer == 3)
  {   
    USB.println(F(&quot;Block size too small, frame not pushed&quot;));
  }
  else
  {   
    USB.println(F(&quot;Error pushing the frame&quot;));
  }


  USB.print(F(&quot;Number of stored frames:&quot;));
  USB.println(stack.getStoredFrames());

  //////////////////////////////////////////////////
  // 4. pop frame from the stack
  //////////////////////////////////////////////////
  frame.length = stack.pop( frame.buffer );
  
  if (frame.length &gt; 2)
  {   
    USB.println(F(&quot;Frame extracted:&quot;));
    frame.showFrame();
  }
  else if (frame.length == 0)
  {   
    USB.println(F(&quot;Stack is empty, frame not extracted&quot;));
  }
  else if (frame.length == 1)
  {   
    USB.println(F(&quot;Error reading the EEPROM, frame not extracted&quot;));
  }
  else
  {   
    USB.println(F(&quot;Error updating the new pointer&quot;));
  }

  USB.print(F(&quot;Number of stored frames:&quot;));
  USB.println(stack.getStoredFrames());
  
  USB.println();
  USB.println();
  delay(5000);

}






</pre></code></div>

    <div class="box output"><h4>Output</h4><p>H#<br />
Set Block Size to '100' Bytes<br />
Clearing Stack...<br />
Stack initialized<br />
Number of stored frames:0<br />
Frame to store:<br />
===============================<br />
Current ASCII Frame:<br />
Length: 52<br />
Frame Type:  128<br />
frame (HEX): 3C3D3E800223333934373631383435236E6F64655F3030312330235354523A537461636B5F6578616D706C65234241543A393823<br />
frame (STR): <=>#394761845#node_001#0#STR:Stack_example#BAT:98#<br />
===============================<br />
Frame pushed<br />
Number of stored frames:1<br />
Frame extracted:<br />
===============================<br />
Current ASCII Frame:<br />
Length: 52<br />
Frame Type:  128<br />
frame (HEX): 3C3D3E800223333934373631383435236E6F64655F3030312330235354523A537461636B5F6578616D706C65234241543A393823<br />
frame (STR): <=>#394761845#node_001#0#STR:Stack_example#BAT:98#<br />
===============================<br />
Number of stored frames:0<br />
<br />
<br />
Frame to store:<br />
===============================<br />
Current ASCII Frame:<br />
Length: 52<br />
Frame Type:  128<br />
frame (HEX): 3C3D3E800223333934373631383435236E6F64655F3030312331235354523A537461636B5F6578616D706C65234241543A393823<br />
frame (STR): <=>#394761845#node_001#1#STR:Stack_example#BAT:98#<br />
===============================<br />
Frame pushed<br />
Number of stored frames:1<br />
Frame extracted:<br />
===============================<br />
Current ASCII Frame:<br />
Length: 52<br />
Frame Type:  128<br />
frame (HEX): 3C3D3E800223333934373631383435236E6F64655F3030312331235354523A537461636B5F6578616D706C65234241543A393823<br />
frame (STR): <=>#394761845#node_001#1#STR:Stack_example#BAT:98#<br />
===============================<br />
Number of stored frames:0<br />
<br />
<br />
...</p></div>
    <div class="box seealso"><h4>See also</h4><ul><li><a href="http://www.libelium.com/development/waspmote/documentation/waspmote-technical-guide-v12/">Waspmote Technical Guide (v12)</a></li><li><a href="http://www.libelium.com/development/waspmote/documentation/utilities-guide-v12/">Utilities Guide (v12)</a></li><li><a href="http://www.libelium.com/development/waspmote/documentation/waspmote-technical-guide/"> Waspmote Technical Guide</a></li><li><a href="http://www.libelium.com/development/waspmote/documentation/utilities-guide/">Utilities Guide</a></li></ul></div>

    
    <div class="box related"><h4>Related examples</h4><ul>
                    <li>
                      <a href="http://www.libelium.com/development/waspmote/examples/ut-01-using-eeprom/">UT 01: Using EEPROM</a>
                    </li></ul></div>
    <div id="controls">
        <div class="buttonshortslimdownload">
            <a href="http://www.libelium.com/development/waspmote/examples/ut-06-stack-eeprom-basic-operation/?action=download" target="_blank"  onClick="_gaq.push(['_trackEvent', 'Example', 'DOWNLOAD', 'UT 06: Stack EEPROM']);">
                <div></div> Download Code</a>
        </div>
        	<!-- Motor Social -->
	<div id="social">
		<p>Quick Publish:</p>
		<div id="facebook" class="social popup">
			<a style="width:15px; height:25px; display:block;" title="Send to Facebook" href="http://www.facebook.com/sharer.php?s=100&p[title]=UT 06: Stack EEPROM&p[summary]=This+example+shows+how+to+use+the+Stack+EEPROM+library+of+Waspmote+in+order+to+store+and+get+pending+frames+using+the+EEPROM+memory+of+the+Waspmote+device&p[url]=http://www.libelium.com/development/waspmote/examples/ut-06-stack-eeprom-basic-operation/&p[images][0]=">
			</a>
		</div>
		<div id="twitter" class="social popup">
			<a style="width:19px; height:25px; display:block;" title="Send to Twitter" href="http://twitter.com/share?text=UT+06%3A+Stack+EEPROM&url=http://www.libelium.com/development/waspmote/examples/ut-06-stack-eeprom-basic-operation/&via=libelium">
			</a>
		</div>
		<div id="linkedin" class="social popup">
			<a style="width:19px; height:25px; display:block;" title="Send to Linkedin" href="http://www.linkedin.com/cws/share?url=http://www.libelium.com/development/waspmote/examples/ut-06-stack-eeprom-basic-operation/">
			</a>
		</div>
		<div id="googleplus" class="social popup">
			<a style="width:20px; height:25px; display:block;" title="Send to Google +" href="https://plus.google.com/share?url=http://www.libelium.com/development/waspmote/examples/ut-06-stack-eeprom-basic-operation/"></a>
		</div>
	</div>
	<!-- /Motor Social -->
	    </div>
</div>
<script type="text/javascript">

    $('div.box h4').append('<span>+</span>');

    //Show code
    $('div.box.code').find('span').html('-');

    $('div.box h4').click(function() {
        if ($(this).parent('div').find('p').is(':visible') ||
            $(this).parent('div').find('ul').is(':visible') ||
            $(this).parent('div').find('pre').is(':visible')) {
            $(this).find('span').html('+');
            $(this).parent('div').find('p').hide();
            $(this).parent('div').find('ul').hide();
            $(this).parent('div').find('pre').hide();
        }
        else {
            $(this).find('span').html('-');
            $(this).parent('div').find('p').show();
            $(this).parent('div').find('ul').show();
            $(this).parent('div').find('pre').show();
        }
        return false;
    });

</script>
        </article>

    </section>



	</div>
</div>
<footer id="footer" class="footer_EN">
	<div class="footer_content">
<ul><li id="products" class="first_lvl"><a href="http://www.libelium.com/products/">Products</a><ul><li><a href="http://www.libelium.com/products/waspmote/">Waspmote</a></li><li><a href="http://www.libelium.com/products/plug-sense/">Plug & Sense!</a></li><li><a href="http://www.libelium.com/products/meshlium/">Meshlium</a></li><li><a href="http://www.libelium.com/products/the-iot-marketplace/">The IoT Marketplace</a></li><li><a href="http://www.libelium.com/products/cooking-hacks/">Cooking Hacks</a></li><li><a href="http://www.libelium.com/products/services/">Services</a></li><li><a href="http://www.libelium.com/products/training/">Training Courses</a></li></ul></li><li id="resources" class="first_lvl"><a href="/resources/top_50_iot_sensor_applications_ranking/">Resources</a><ul><li><a href="http://www.libelium.com/resources/top_50_iot_sensor_applications_ranking/">Applications</a></li><li><a href="http://www.libelium.com/resources/case-studies/">Case Studies</a></li><li><a href="http://www.libelium.com/resources/white-papers/">White Papers</a></li><li><a href="http://www.libelium.com/resources/projects/">Projects</a></li></ul></li><li id="case-studies" class="first_lvl"><a href="/resources/case-studies">Case Studies</a></li><li id="development" class="first_lvl"><a href="http://www.libelium.com/development/">Development</a><ul><li><a href="http://www.libelium.com/development/waspmote/">Waspmote</a></li><li><a href="http://www.libelium.com/development/plug-sense/">Plug & Sense!</a></li><li><a href="http://www.libelium.com/development/meshlium/">Meshlium</a></li></ul></li><li id="company" class="first_lvl"><a href="http://www.libelium.com/company/">Company</a><ul><li><a href="http://www.libelium.com/company/customers/">Customers</a></li><li><a href="http://www.libelium.com/company/awards/">Awards</a></li><li><a href="http://www.libelium.com/company/our-team/">Founding Team</a></li><li><a href="/contact/#join">Join Us</a></li></ul></li><li id="partners-ecosystem" class="first_lvl"><a href="http://www.libelium.com/partners-ecosystem/">Ecosystem</a></li><li id="libeliumworld" class="first_lvl"><a href="http://www.libelium.com/libeliumworld/">Libelium World</a><ul><li><a href="http://www.libelium.com/libeliumworld/news/">News</a></li><li><a href="http://www.libelium.com/libeliumworld/articles/">Articles</a></li><li><a href="http://www.libelium.com/libeliumworld/videos/">Videos</a></li><li><a href="http://www.libelium.com/libeliumworld/press/">Media impact</a></li><li><a href="http://www.libelium.com/libeliumworld/events/">Upcoming events</a></li></ul></li><li id="contact" class="first_lvl"><a href="http://www.libelium.com/contact/">Contact</a></li></ul> 		<div id="footer_logo"></div>
 		<div id="top_arrow"></div>

        <div id="newsletter-subscription">

            <form id="newsletter-subscription-form">


            <div class="newsletter-input">
                <label for="newsletter_general_mail" class="title">Subscribe to our newsletter</label>
                <input type="text" name="newsletter_general_mail" id="newsletter_general_mail">
                <input type="submit" id="newsletter_general_submit" value="Subscribe">
                <br><span class="error" id="newsletter_general_mail_error" style="display: none;">Please, type a valid email</span>


            </div>

            <div class="privacy_submit">
                <input type="checkbox" id="newsletter_general_accept_policity" name="newsletter_general_accept_policity">
                <label for="newsletter_general_accept_policity"><small>I have read and I accept the <a target="_blank" id="general_privacy" href="https://www.libelium.com/privacy-policy/">privacy policy</a></small></label>
                <br><span class="error" id="newsletter_general_accept_policity_error" style="display: none;">This field is required</span>

            </div>
            </form>

        </div>

 	</div>
 	<div id="footer_separator"></div>
 	<div id="footer_social">
 		<span>Follow us:</span>

 		 		<div id="social">
 			<a target="_blank" href="https://twitter.com/libelium" id="twitter"></a>
 			<a target="_blank" href="http://www.linkedin.com/company/1062497" id="linkedin"></a>
 			<a target="_blank" href="http://www.youtube.com/user/libelium?sub_confirmation=1" id="youtube"></a>
 			<a target="_blank" href="http://www.libelium.com/feed/" id="feeds"></a>
 		</div>
 		<span id="footer_social_advise">© Libelium Comunicaciones Distribuidas S.L | <a href="/legal/">Terms of Sale and Use</a></span>
 	</div>
</footer>
<script type="text/javascript">
$('.slider_list_container div.list > ul > li').prepend('<span class="list_icon"></span>');$(document).ready(function() {$('#top_arrow').click(function(){$('html, body').animate({scrollTop:0}, 'slow');return false})});function footer_adjust() {if ($(window).height() > ($('#wrapper').height()+255))$('footer').height($(window).height()-$('#wrapper').height()-11);else $('footer').height(255)}if ($(window).width() < 1045)$('#footer_logo').css('margin-left','822px');$('.popup a').click(function(event) {var width= 575, height = 400, left = ($(window).width()- width)/ 2 + 200, top= ($(window).height() - height) / 2;window.open(this.href, 'share', ['status=1,width=',width,',height=',height,',top=',top,',left=',left].join(''));return false});function valid_email(mail) {var ml = /^([a-zA-Z0-9_\.\-])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,4})+$/;if (mail != undefined && mail.match(ml)) return true;else return false}$('#newsletter-subscription-form').submit(function(e) {e.preventDefault();var error_show = false;$('#newsletter_general_accept_policity_error').hide();$('.return-values').hide();$('#newsletter_general_mail_error').hide();if (!$('#newsletter_general_accept_policity:checked').length) {$('#newsletter_general_accept_policity_error').show();error_show = true}var email_value = $('#newsletter_general_mail').val();if (!valid_email($('#newsletter_general_mail').val())) {$('#newsletter_general_mail_error').show();error_show = true}if (error_show) {return false}$.ajax({type: "GET",url: "/wp-admin/admin-ajax.php",data: "action=newsletter_subscribe&newsletter_policy=on&newsletter=" + email_value,success: function (results) {$('<p class="return-values">' + results + '</p>').css({'color':'white', 'background': '#51B86D', 'text-align':'center', 'padding': '.3em'}).insertBefore('#newsletter-subscription-form');$('#newsletter_general_accept_policity:checked').attr('checked', false);$('#newsletter_general_mail').val('')}})});$('#footer_social_advise').before('<p style="display: inline; color: #4A4A4A" class="do-not-print"> '+decode64('TWFkZSBieSBPc2NhciBBYmFkICYgQ2FybG9zIEFz7W4=')+' </p>');
</script>
<script type="text/javascript">
	(function(){
		hljs.tabReplace = '    ';
		hljs.initHighlightingOnLoad();
		//	hljs.highlightBlock(e,'    ');
	})();
</script>
</body>

</html>
