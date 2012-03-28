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
<script type="text/javascript">
function validateform1()
{	
	if(document.onlineform1.filename.value=="") {
	window.alert ("Please Enter a filename!");
	return false;
	}	
	if(document.onlineform1.title.value=="") {
	window.alert ("Please Enter a title!");
	return false;
	}
	if(document.onlineform1.description.value=="") {
	window.alert ("Please Enter the Description!");
	return false;
	}
return true;
}
</script>
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
								<!--upload form-->
								<%
									String choice = request.getParameter("id");	
									int num = Integer.parseInt(choice);
								%>
								<table width="650" bgcolor="#41A317">
									<%if(num == 1){ %>
									<th><font color="white" size="4px">Popular Videos</font></th>
									<%} %>
									<%if(num == 2){ %>
									<th><font color="white" size="4px">Popular Categories</font></th>
									<%} %>
									<%if(num == 3){ %>
									<th><font color="white" size="4px">Latest Uploaded Videos</font></th>
									<%} %>
								</table>
								<br/>								
								<%
										try {		          
										String connectionURL = "jdbc:mysql://localhost:3306/ruralcdn";         
										Connection connection = null;         
										Statement statement = null;
										ResultSet rs = null;										
										Class.forName("com.mysql.jdbc.Driver").newInstance();       
										connection = DriverManager.getConnection(connectionURL, "root", "abc123");          
										statement = connection.createStatement();
										String[] fileid = new String[100];
										String[] title = new String[100];
									%>
									<%if(num ==1){ %>
									<!-- start 1-->
									<table width="650" bgcolor="pink">
									<tr>
										<td><b></b></td>
										<td><b>Title</b></td>
										<td><b>Category</b></td>
										<td><b>Language</b></td>
										<td><b>Uploaded By</b></td>
										<td><b>Download</b></td>
										<td></td>										
									</tr>									
									<%  try{         
									   	
										try{
											String QueryString1 = "SELECT dbkey from dbsync where dbkey like '%-demand%'order by dbvalue desc";
										   	rs = statement.executeQuery(QueryString1);
										}catch(Exception e){
											System.out.println("Error in the choice 1");
										}
										int i = 0;
										try{											
											for(i=0;i<4&&rs.next();i++) {									  	
										   	String file = rs.getString(1);
										   	fileid[i] = file.substring(0,file.indexOf("-"));
											}
										}catch(Exception e){
											System.out.println("Error in the choice 11");
										}
										int cout = i;
										int l =0;
										while(l < cout){									
									 	String QueryString2 = "SELECT dbvalue from dbsync where dbkey like '%"+fileid[l]+"%'";
									  	rs = statement.executeQuery(QueryString2);
									  	i =0;
									  	while(rs.next()){
									  		title[i++] = rs.getString(1);
									  	}
									  	try{
									  	System.out.println("value of fileid"+fileid[l]);
									  	String itemp = fileid[l].substring(0,fileid[l].lastIndexOf("."));
										//System.out.println("value of itemp"+itemp);
										String ipath = "DBServer/"+itemp+".jpg";
										//System.out.println("value of ipath"+ipath);
									  	
									%>			
									<tr>
										<td><img src="<%=ipath %>" width="80" height="80" align="top"/></td>
										<td><%=title[7] %></td>
										<td><%=title[0] %></td>
										<td><%=title[4] %></td>
										<td><%=title[8] %></td>
										<td>
											<form action="FileDownload" method="post">
												<select name="choice">
													<option value="1">Select</option>
													<option value="2">By Usb</option>
													<option value="3">By Tcp</option>
												</select>
										        <input type="hidden" name="fileid" value="<%=fileid[i]%>"/>							        
										        <input type="submit" value="Download"/>
										    </form>
										</td>
									</tr>
									<%
									}catch(Exception e) {
										System.out.println("Error in the choice 12");
										//e.printStackTrace();
									}
									%>
																		
									<%l++;
									}
										}catch(Exception e){System.out.println("Error in num == 1");} %>													
									</table>	
									<!-- end 1-->
									<%} %>
									<%if(num ==2){ %>
									<!-- start 2-->
									<table width="650" bgcolor="pink" align="center">
										<tr>
											<td align="center"><b>Category</b></td>
											<td align="center"><b>No. of Videos</b></td>
											<td align="center"><b></b></td>
											<td align="center"><b></b></td>
										</tr>
									
									<%								   
									 String QueryString3 = "SELECT dbvalue,count(*) as c from dbsync where dbkey like '%-cat%' group by dbvalue order by c desc";
									 rs = statement.executeQuery(QueryString3);									
									 for(int j=0;j<=5&&rs.next();j++){							    	
									%>	
									<tr>
										<td align="center"><%=rs.getString(1) %></td>
										<td align="center"><%=rs.getString(2) %></td>
										<td align="center"><b><a href="AllCatList.jsp?cat=<%=rs.getString(1) %>">See All Videos</a></b></td>
										<td align="center"><b><a href="UsertoCatSubsc?category=<%=rs.getString(1) %>&follower=<%=username %>">Subs This Category</a></b></td>
									</tr>
									<%}%>																
									</table>
									<!-- end 2-->
									<%} %>
									<%if(num == 3){ %>
									<!-- start3 -->
									<table width="650" bgcolor="pink">
									<tr>
										<td><b></b></td>
										<td><b>Title</b></td>
										<td><b>Category</b></td>
										<td><b>Language</b></td>
										<td><b>Uploaded By</b></td>
										<td><b>Download</b></td>
									</tr>
									<% 								 
									 String QueryString4 = "SELECT * from dbsync where dbkey like '%-title' order by dbkey desc limit 20";
									 rs = statement.executeQuery(QueryString4);
									
									 int i=0;
									 while (i<20&&rs.next()) {									
										String temp = rs.getString(1);
										fileid[i++] = temp.substring(0,temp.indexOf("-"));
									 }								
										int m = i;
										//System.out.println("value of m "+m );
										int j = 0;
										while(j < m){
										String QueryString5 = "SELECT dbvalue from dbsync where dbkey like '%"+fileid[j]+"%'";
										rs = statement.executeQuery(QueryString5);
										i = 0;
										while(rs.next()){
											title[i++] = rs.getString(1);
										}
										String itemp = fileid[j].substring(0,fileid[j].lastIndexOf("."));
										String ipath = "DBServer/"+itemp+".jpg";
									%>	
									<tr>
										<td><img src="<%=ipath %>" width="80" height="80" align="top"/></td>
										<td><%=title[7] %></td>
										<td><%=title[0] %></td>
										<td><%=title[4] %></td>
										<td><%=title[8] %></td>
										<td>
											<form action="FileDownload" method="post">
												<select name="choice">
													<option value="1">Select</option>
													<option value="2">By Usb</option>
													<option value="3">By Tcp</option>
												</select>
										        <input type="hidden" name="fileid" value="<%=fileid[j]%>"/>							        
										        <input type="submit" value="Download"/>
										    </form>
										</td>
									</tr>		
										
									<%j++;}%>										
									</table>	
									<!-- end3 -->
									<%} %>
									<%						
										rs.close();						
										statement.close();
										connection.close();
										}catch (Exception ex) {									
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
	<p>Copyright (c) 2011 ruralcdn.com. All rights reserved. Design by <a href="">ACT4D Group,IITD</a>.</p>
</div>
<!-- end #footer -->
</body>
</html>
