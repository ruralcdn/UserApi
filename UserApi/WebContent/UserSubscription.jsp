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
</head>
<body>
<%
String username=(String) session.getAttribute("ulogname");
//if(username.length()==0){
if(username == null){
	String redirectURL = "index.jsp";
	response.sendRedirect(redirectURL);
}
%>
<div id="wrapper">
	<div id="header">
		<div id="logo">
			<h1><a href="#">Welcome: <%=username%></a></h1>
			<p> <!--
				-->
			</p>
		</div>
	</div>
	<!-- end #header -->
	<div id="menu">
		<ul >
			<li class="current_page_item"><a href="WelcomeUser.jsp">Home</a></li>
			<li><a href="UploadFile.jsp">Upload File</a></li>			
			<li><a href="UserStatus.jsp">Status</a></li>
			<li><a href="AllCategories.jsp">Categories</a></li>
			<li><a href="AllUsers.jsp">Users</a></li>
			<li><a href="AllLocations.jsp">Locations</a></li>
			<li><a href="UserSubscription.jsp">Subscription</a></li>		
			<li class="whlogin"><a href="LogoutUser">Logout</a></li>			
		</ul>
	</div>
	<!-- end #menu -->
	<div id="page">
		<div id="page-bgtop">
			<div id="page-bgbtm">
				<div id="content">
					<div id="gallery-wrapper">
						<div id="gallery"> 
							<div id="thumbnail-bg">
								<!--form-->
								<%
									try {							          
									String connectionURL = "jdbc:mysql://localhost:3306/ruralcdn";         
									Connection connection = null;         
									Statement statement = null;
									ResultSet rs = null;
									ResultSet rs1 = null;
									Class.forName("com.mysql.jdbc.Driver").newInstance();       
									connection = DriverManager.getConnection(connectionURL, "root", "abc123");          
									statement = connection.createStatement();							  
									String QueryString1 = "SELECT distinct(dbvalue) from dbsync where dbkey like '%-user%' and dbvalue !='"+username+"'";
									rs = statement.executeQuery(QueryString1);
								%>
								<table width="650" bgcolor="#41A317"><th><font color="white" size="4px">User Subscription Form</font></th></table>								
								<table width="650" bgcolor="pink">								
								<form action="UsertoUserSubcription" method="get">
									<tr>
										<td></td>
										<td align="center"><strong>Select User for Subscription</strong></td>										
										<td>
											<select name="uploader">
												<% while(rs.next()){ %>
												<option><%=rs.getString(1)%></option>
												<%} %>
											</select>
										</td>										
									</tr>
									<tr>
										<td><input type="hidden" name=choice value="1"/></td>
										<td><input type="hidden" name="follower" value="<%=username %>"/></td>
										<td><input type="submit" value="Subscribe"/></td>
									</tr>
								</form>									
								</table>
								<br/>
								<%						  
									String QueryString2 = "SELECT distinct(dbvalue) from dbsync where dbkey like '%-cat%'" ;
									rs = statement.executeQuery(QueryString2);
								%>
								<table width="650" bgcolor="#41A317"><th><font color="white" size="4px">Category Subscription Form</font></th></table>								
								<table width="650" bgcolor="pink">								
								<form action="UsertoCatSubsc" method="get">
									<tr>
										<td></td>
										<td align="center"><strong>Select Category for Subscription</strong></td>										
										<td>
											<select name="category">
												<% while(rs.next()){ %>
												<option><%=rs.getString(1)%></option>
												<%} %>
											</select>
										</td>										
									</tr>
									<tr>
										<td><input type="hidden" name=choice value="2"/></td>
										<td><input type="hidden" name="follower" value="<%=username %>"/></td>
										<td><input type="submit" value="Subscribe"/></td>
									</tr>
								</form>									
								</table>
								<br/>
								<% 								   
									String QueryString3 = "SELECT distinct(dbvalue) from dbsync where dbkey like '%-loc%'" ;
								   	rs = statement.executeQuery(QueryString3);
								%>
								<table width="650" bgcolor="#41A317"><th><font color="white" size="4px">Location Subscription Form</font></th></table>								
								<table width="650" bgcolor="pink">								
								<form action="UsertoLocSubsc" method="get">
									<tr>
										<td></td>
										<td align="center"><strong>Select Location for Subscription</strong></td>										
										<td>
											<select name="location">
												<% while(rs.next()){ %>
												<option><%=rs.getString(1)%></option>
												<%} %>
											</select>
										</td>
										
									</tr>
									<tr>
										<td><input type="hidden" name=choice value="3"/></td>
										<td><input type="hidden" name="follower" value="<%=username %>"/></td>
										<td><input type="submit" value="Subscribe"/></td>
									</tr>
								</form>									
								</table>
								<br/>
								<table width="650" bgcolor="#41A317"><th><font color="white" size="5px">Remove Your Subscription</font></th></table>
								<table width="650" bgcolor="pink">
									<form action="RemoveSubsc" method="post">
										<tr>
											<td align="center">Subscribed User</td>
											<%   										   
												String QueryString4 = "SELECT distinct(dbvalue) from dbsync where dbkey like '%"+username+"-subcuser%'" ;
												rs = statement.executeQuery(QueryString4);
											%>
											<td align="center">
											
												<select name="username">
													<%while(rs.next()){ %>
														<option><%=rs.getString(1)%></option>
													<%} %>
												</select>
											
											</td>
											<td><input type="hidden" name=choice value="1"/></td>
											<td><input type="hidden" name=activeuser value="<%=username %>"/></td>
											<td align="center"><input type="submit" value="Remove Subscribed User"/></td>
										</tr>
									</form>
									<tr><td><br/></td></tr>
									<form action="RemoveSubsc" method="post">
										<tr>
											<td align="center">Subscribed Category</td>
											<% 										   
											   String QueryString5 = "SELECT distinct(dbvalue) from dbsync where dbkey like '%"+username+"-subccat%'" ;
											   rs = statement.executeQuery(QueryString5);
											%>
											<td align="center">
											
												<select name="category">
													<%while(rs.next()){ %>
														<option><%=rs.getString(1)%></option>
													<%} %>
												</select>
											
											</td>
											<td><input type="hidden" name=choice value="2"/></td>
											<td><input type="hidden" name=activeuser value="<%=username %>"/></td>
											<td align="center"><input type="submit" value="Remove Subscribed Category"/></td>
										</tr>
									</form>
									<tr><td><br/></td></tr>
									<form action="RemoveSubsc" method="post">
										<tr>
											<td align="center">Subscribed Location</td>
											<% 										  
												String QueryString6 = "SELECT distinct(dbvalue) from dbsync where dbkey like '%"+username+"-subcloc%'" ;
												rs = statement.executeQuery(QueryString6);
											%>
											<td align="center">
											
												<select name="location">
													<%while(rs.next()){ %>
														<option><%=rs.getString(1)%></option>
													<%} %>
												</select>
											
											</td>
											<td><input type="hidden" name=choice value="3"/></td>
											<td><input type="hidden" name=activeuser value="<%=username %>"/></td>
											<td align="center"><input type="submit" value="Remove Subscribed Location"/></td>
										</tr>
									</form>		
								
								</table>
								<%				
									rs.close();						
									statement.close();
									connection.close();
									} catch (Exception ex) {								
										ex.printStackTrace();						 
									}
								%>
							</div>
							<br class="clear" />
						</div>						
						<!-- end -->
					</div>
					<div class="post">						
					</div>					
					<div style="clear: both;">&nbsp;</div>
				</div>
				<!-- end #content -->
				<div id="sidebar">
					<ul>
						<li><h2>Basic Search</h2>
							<div id="search" align="center"><b><font color="maroon" size="4"></font></b>
								<table align="center">
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
									<tr>
										<td><br></td>
										<td></td>									
									</tr>										
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
	<p>Copyright (c) 2011 ruralcdn.com. All rights reserved. Design by <a href="">ACT4D Group,IITD</a>.</p>
</div>
<!-- end #footer -->
</body>
</html>
