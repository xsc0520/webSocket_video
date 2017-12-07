<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'index.jsp' starting page</title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
  </head>
  
 <body>
    <video autoplay id="sourcevid" style="width:320;height:240px"></video>
    <br>
    <canvas id="output" style="display:none"></canvas>

    <script type="text/javascript" charset="utf-8">
        var socket = new WebSocket("ws://"+window.location.host+"/WebsocketDay04/websocket");
        var back = document.getElementById("output");
        var backcontext = back.getContext("2d");
        var video = document.getElementsByTagName("video")[0];
        
        var success = function(stream){
            video.src = window.URL.createObjectURL(stream);
        }
        socket.onopen = function(){
            draw();
        }
        var draw = function(){
            try{
                backcontext.drawImage(video,0,0, back.width, back.height);
            }catch(e){
                if (e.name == "NS_ERROR_NOT_AVAILABLE") {
                    return setTimeout(draw, 100);
                } else {
                    throw e;
                }
            }
            if(video.src){
                socket.send(back.toDataURL("image/jpeg", 0.6));
            }
            setTimeout(draw, 200);
        }
        window.onbeforeunload=function(){
			ws.close();
		}
        navigator.getUserMedia = navigator.getUserMedia || navigator.webkitGetUserMedia ||
        navigator.mozGetUserMedia || navigator.msGetUserMedia;
        navigator.getUserMedia({video:true, audio:false}, success, console.log);
    </script>
</body>
</html>
