<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	String loginID = (String)request.getParameter("loginid");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>SSO SAMPLE</title>
<script src="js/jquery-1.8.2.min.js"></script>
<script>
	function bodyload() {
		
		var loginname = '<%=loginID%>';
		var password = "1";
		var communityid = "001000000";
		var clientname = "localhost";
		var logintype = "loginid"
		var userkey = "";
		
		$.ajax({
			type : "post",
			cache : false,
			url : "<%=request.getContextPath()%>/openapi/common/auth/login",
			data: {
				loginname: loginname,
				password: password,
				communityid : communityid,
				clientname : clientname,
				logintype : logintype
			},
			dataType : "json",
			success : function(data, status) {
				// console.log(data.responseData.auth.userKey);
				userkey = data.responseData.auth.userKey;
				location.href = "./directory_login2.jsp?userkey="+userkey+"&lang=" + "ko&localGMT=" +getGMToffset();
				// $("#fraMain").html(data);
			}
		});
	}
	//for Local GMT.
	function getGMToffset() {
		var tz = new Date().getTimezoneOffset();
		var h = (tz != 0) ? tz / 60 : 0;
		if (h != 0) {
			h *= -1;
		}
		var str = (h < 0) ? "" + h : "+" + h;
		if (str.indexOf(".") == -1) {
			str += ".0";
		}
		return str; // ex) +0.0, +9.0
	}
</script>
</head>
<body onload="javascript:bodyload();">
<div id="fraMain">
</div>
</body>
</html>
