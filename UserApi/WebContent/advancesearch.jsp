<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">

<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %> 
<%@ page import="java.util.*" %>

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
								<table width="650" bgcolor="orchid">
									<th><h3>Advance Search Result</h3></th>
								</table>
								<br/>
								<%	
								try{
									String connectionURL = "jdbc:mysql://localhost:3306/ruralcdn";         
									Connection connection = null;         
									Statement statement = null;
									ResultSet rs = null; 
									Class.forName("com.mysql.jdbc.Driver").newInstance();       
									connection = DriverManager.getConnection(connectionURL, "root", "abc123");          
									statement = connection.createStatement();								
								
									String title = request.getParameter("title"); 
									String category = request.getParameter("cat");
									String language = request.getParameter("language");									
									List<String> contentId = new ArrayList<String>();
									String[] data = new String[50];
									String[] pipe = new String[50];  
									
									String sql = "select * from dbsync where dbkey like '%-title%'";
									rs = statement.executeQuery(sql);
									while(rs.next()){
										String temp = rs.getString(1);
										contentId.add(temp.substring(0,temp.lastIndexOf("-")));
										//System.out.println("temp is: "+temp);
									}
									//System.out.println("value is 5" );
									List<String> searchId = new ArrayList<String>();
								%>
								<table width="650" bgcolor="pink">
									<tr>
										<td><b></b></td>
										<td><b>Description</b></td>
										<td><b>Uploaded By</b></td>
										<td><b>Location</b></td>
										<td><b>FileSize(kb)</b></td>
										<td></td>
										<td></td>
									</tr>									
								<%	
									for(int i=0;i<contentId.size();i++ ){
										//System.out.println("value is 4" );
									String content = contentId.get(i);
									System.out.println("content is"+content );
										String sql1 = "select dbvalue from dbsync where dbkey like '%"+content+"%'";
										rs = statement.executeQuery(sql1);
										int j = 0;
										while(rs.next()){
											data[j] = rs.getString(1);
											System.out.println("value is "+data[j++]);
										}
										if(title.equals(data[7])&& category.equals(data[0])&& language.equals(data[4])){
											searchId.add(contentId.get(i));
										}			
									}									
									for(int k = 0;k < searchId.size();k++){
									String sql2 = "select dbvalue from dbsync where dbkey like '%"+searchId.get(k)+"%'";
									rs = statement.executeQuery(sql2);
									int m = 0;
									while(rs.next()){
										pipe[m++] = rs.getString(1);
									}
									String fileid = searchId.get(k);
									String itemp = fileid.substring(0,fileid.lastIndexOf("."));
									String ipath = "DBServer/"+itemp+".jpg";									
								%>
								  <tr>
									<td><img src="<%=ipath %>" width="80" height="80" align="top"/></td>
									<td><%=pipe[3] %></td>
									<td><%=pipe[8] %></td>
									<td><%=pipe[5] %></td>
									<td><%=pipe[6] %></td>
									<td>
								        <form action="FileDownload" method="post">
									        <input type="hidden" name="fileid" value="<%=searchId.get(k)%>"/>							        
									        <input type="submit" value="Download"/>
									    </form>
							        </td>
							        <td>
							        	<form action="UsertoUserSubcription" method="post">
									        <input type="hidden" name="uploader" value="<%=pipe[8]%>"/>
									        <input type="hidden" name="follower" value="<%=username%>"/>							        
									        <input type="submit" value="Subs To User"/>
									    </form>
							        </td>							        
								</tr>		
								<%									
									}
								%>
								</table>
								<%
									rs.close();						
									statement.close();
									connection.close(); 
								}catch(Exception e){
										e.printStackTrace();					
								}%>	
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
