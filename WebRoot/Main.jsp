<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'Main.jsp' starting page</title>
    
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
    <img id="receiver" style="width:320px;height:240px"/>
  </body>
   <script type="text/javascript" charset="utf-8">
        var receiver_socket = new WebSocket("ws://"+window.location.host+"/WebsocketDay04/websocket");
        var image = document.getElementById('receiver');
        receiver_socket.onmessage = function(data)
        {
            image.src=data.data;
        }
        window.onbeforeunload=function(){
			ws.close();
		}
    </script>
</html>
