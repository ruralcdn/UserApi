<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>
<%@page  import="java.util.*"%>
<%@page import="javax.servlet.http.HttpSession" %>
<%@ page language="java" %>
	  			
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
</head>
<body >
<%
String username=(String) session.getAttribute("ulogname");
if(username == null){
	String redirectURL = "index.jsp";
	response.sendRedirect(redirectURL);
}
%>
<div id="wrapper">
	<div id="header">
		<div id="logo">
			<h1><a href="#">Welcome: <%=username%></a></h1>					
		</div>
	</div>
	<!-- end #header -->
	<div id="menu">
		<ul >
			<li class="current_page_item"><a href="WelcomeAdmin.jsp">Home</a></li>			
			<li><a href="AllCatAdmin.jsp">Categories Video</a></li>
			<li><a href="AllUserAdmin.jsp">Users Video</a></li>
			<li><a href="AllLocAdmin.jsp">Locations Video</a></li>
			<li><a href="AllLocAdmin.jsp">User's List</a></li>								
			<li class="whlogin"><a href="LogoutUser">Logout</a></li>			
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
								<ul class="thumbnails">
									<li><img class="active" src="images/img04.jpg" title="" alt="" width="604" height="375" onmouseover="this.style.opacity=1;this.filters.alpha.opacity=100"
onmouseout="this.style.opacity=0.4;this.filters.alpha.opacity=70" /></li>
									<li><img src="images/img05.jpg" title="" alt="" width="100" height="75"  onmouseover="this.style.opacity=1;this.filters.alpha.opacity=100"
onmouseout="this.style.opacity=0.4;this.filters.alpha.opacity=70" /></li>
									<li><img src="images/img06.jpg" title="" alt="" width="100" height="75"  onmouseover="this.style.opacity=1;this.filters.alpha.opacity=100"
onmouseout="this.style.opacity=0.4;this.filters.alpha.opacity=70" /></li>
									<li><img src="images/img07.jpg" title="" alt="" width="100" height="75"  onmouseover="this.style.opacity=1;this.filters.alpha.opacity=100"
onmouseout="this.style.opacity=0.4;this.filters.alpha.opacity=70" /></li>
								</ul>
							</div>
							<br class="clear" />
						</div>
					<script type="text/javascript">

						$('#gallery').gallerax({
							outputSelector: 		'.output',					// Output selector
							thumbnailsSelector:		'.thumbnails li img',		// Thumbnails selector
							captionSelector:		'.caption'					// Caption selector
						});

					</script>
						<!-- end -->
						<div class="post">
						<h2 class="title"><a href="#">Recent research in agriculture</a></h2>
						<p class="meta"><span class="date"><%= new java.util.Date() %></span><span class="posted">Posted by <a href="#">Amit dubey</a></span></p>
						<div style="clear: both;">&nbsp;</div>
						<div class="entry">
						</div>
					</div>
					</div>											
					<div style="clear: both;">&nbsp;</div>
				</div>
				<!-- end #content -->
				<div id="sidebar">
					<ul>
										
						<li><h2>Basic Search</h2>						
							<div id="search" align="center"><b><font color="maroon" size="4"></font></b>							
							<table align="center" bgcolor="">
								<tr><td><br/></td></tr>																
									<tr><td align="left">
										<form method="post" action="Search.jsp">
											<div>
												<input type="text" name="query"/>
												<input type="submit" value="Search"/>												
											</div>
										</form>
									</td></tr>
								</table>
							</div>
							<div style="clear: both;">&nbsp;</div>
						</li>
						<li>
						<h2>Advance Search</h2>
						<div id="adsearch" align="center"><b><font color="#571B7e" size="4"></font></b>
							<form method="post" action="advancesearch.jsp">
								<table align="center">
								<tr><td><br/></td><td><br/></td></tr>																			
									<tr>
										<td align="left"><b>Title</b></td>
										<td align="right"><input type="text" name="title" width="20"/></td>											
									</tr>
									<tr>
										<td align="left"><b>Category</b></td>
										<td align="right">
											<select name="cat">
												<option>--Select Video Category--</option>											
												<option>Animal Care</option>												
												<option>Awareness</option>
												<option>Azolla in Paddy</option>
												<option>After Care of Plants</option>
												<option>Compost</option>
												<option>Discussion</option>
												<option>Garlic Cultivation</option>
												<option>Harvesting</option>												
												<option>Herbal Medicine</option>
												<option>Low cost Vermicompost</option>												
												<option>Nonprofits & Activism</option>
												<option>Preparation of Biofertilizer</option>
												<option>Potato Sowing</option>																							
												<option>Seed Treatment</option>
												<option>Sheep Manuring</option>												
												<option>Sucess Story</option>												
												<option>Tomato Transplanting</option>
												<option>Wheat Cultivation</option>
												<option>Other</option>
											</select>												
										</td>
									</tr>
									<tr>
										<td align="left"><b>Language</b></td>
										<td align="right">
											<select name="language">
												<option>Hindi</option>												
												<option>English</option>												
												<option>Other</option>
											</select>												
										</td>
									</tr>									
									<tr>
										<td align="left"><b></b></td>
										<td align="right"><input type="submit" value="Search" width="25px"/></td>															
									</tr>										
								</table>
							</form>
							</div>
						</li>
						<li>						
						<div style="clear: both;">&nbsp;</div>
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
<div id="menufooter">
<ul>
	<li class="downcat"><a href="showrequest.jsp?id=1">Popular Videos</a></li>			
	<li class="downcat"><a href="showrequest.jsp?id=2">Popular Categories</a></li>			
	<li class="downcat"><a href="showrequest.jsp?id=3">Latest Uploaded Videos</a></li>			
	
</ul>			
</div>
<div id="footer">
	<p>Copyright (c) 2011 ruralcdn.com. All rights reserved. Design by <a href="#">ACT4D Group,IITD</a>.</p>
</div>
<!-- end #footer -->
</body>
</html>
