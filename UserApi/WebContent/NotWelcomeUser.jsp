<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta name="keywords" content="" />
<meta name="description" content="" />
<meta http-equiv="content-type" content="text/html; charset=utf-8" />
<title>Welcome To CDN</title>
<link href="style.css" rel="stylesheet" type="text/css" media="screen" />
<script type="text/javascript" src="jquery/jquery-1.4.2.min.js"></script>
<script type="text/javascript" src="jquery/jquery.gallerax-0.2.js"></script>
<style type="text/css">
@import "gallery.css";
</style>
<script type="text/javascript" src="javascript/login.js"></script>
</head>
<body>
<div id="wrapper">
	<div id="header">
		<div id="logo">
			<h1><a href="#">Welcome to rural cdn network</a></h1>
			<p> <!--
				-->
			</p>
		</div>
	</div>
	<!-- end #header -->
	<div id="menu">
		<ul >
			<li class="current_page_item"><a href="index.jsp">Home</a></li>
			<li><a href="UserRegistration.jsp">registration</a></li>	
			<li class="hlogin"><a href="index.jsp">Please login to access website contain</a></li>			
		</ul>
	</div>
	<!-- end #menu -->
	<div id="page">
		<div id="page-bgtop">
			<div id="page-bgbtm">
				<div id="content">
					<div id="gallery-wrapper">
						<div id="gallery"> <img class="output" src="images/img04.jpg" alt="" />
							<div id="thumbnail-bg">
								
							</div>
							<br class="clear" />
						</div>
						
					<div class="post">
						<h2 class="title">You are already logged in or Invalid User</h2>
						
					</div>	
					</div>					
					<div class="post">
						
					</div>
					<div style="clear: both;">&nbsp;</div>
				</div>
				<!-- end #content -->
				<div id="sidebar">
					<ul>						
						<li>
							<table bgcolor="pink" width="280" bordercolor="red">
							
								<form action="UserValid"  name="onlineform" onSubmit="return validateform( this.form )" method="post" align="center">
									<th>Please enter your Username & Password</th>
									<tr><td><b>Username:</b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="text" name="username" id="search-text" value="" /><td></tr>
									<tr><td><b>Password:</b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="password" name="password" id="search-text" value="" /><td></tr>
									<tr align="right"><td align="right"><input type="submit" id="search-submit" value="Login" align="right"/><td></tr>
								</form>
								
							</table>
							<div style="clear: both;">&nbsp;</div>
						</li>	
						<li>
							<h2>Popular Videos</h2>
							<ul>
								<li><a href="#">categorie#1</a></li>
								<li><a href="#">categorie#2</a></li>
								<li><a href="#">categorie#3</a></li>
								<li><a href="#">categorie#4</a></li>								
							</ul>
						</li>
						<li>
							<h2>Popular Categories</h2>
							<ul>
								<li><a href="#">Video#1</a></li>
								<li><a href="#">Video#2</a></li>
								<li><a href="#">Video#3</a></li>
								<li><a href="#">Video#4</a></li>								
							</ul>
						</li>
						<li>
							<h2>Latest Uploaded Videos</h2>
							<ul>
								<li><a href="#">vedio#1</a></li>
								<li><a href="#">vedio#2</a></li>
								<li><a href="#">vedio#3</a></li>
								<li><a href="#">vedio#4</a></li>								
							</ul>
						</li>
					</ul>
				</div>
				<!-- end #sidebar -->
				<div style="clear: both;">&nbsp;</div>
			</div>
		</div>
	</div>
	<!-- end #page -->
</div>
<div id="footer">
	<p><strong>Copyright(c)2011 RuralCdn All rights reserved. Design by <a href="">ACT4D,IIT Delhi</a>.</strong></p>
</div>
<!-- end #footer -->
</body>
</html>
