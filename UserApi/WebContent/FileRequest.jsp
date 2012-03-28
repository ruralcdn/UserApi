<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>
<%@page  import="java.util.*" %>
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
<script type="text/javascript" src="javascript/validate.js"></script>
</head>
<body onunload="javascript:history.go(1)">
<%response.setIntHeader("Refresh",3); %>
<div id="wrapper">
	<div id="header">
		<div id="logo">
			<h1><a href="">Welcome to rural cdn network</a></h1>
			<p> 
			</p>
		</div>
	</div>
	<!-- end #header -->
	<div id="menu">
		<ul>
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
					<%
						String filerequest=(String) session.getAttribute("urequest");						
					%>					
					<table bgcolor="pink" width="625" height="">
						<th><h3><%=filerequest %></h3></th>							
					</table>
					<%
								try {							          
									String connectionURL = "jdbc:mysql://localhost:3306/ruralcdn";         
									Connection connection = null;         
									Statement statement = null;
									ResultSet rs = null;								
									Class.forName("com.mysql.jdbc.Driver").newInstance();       
									connection = DriverManager.getConnection(connectionURL, "root", "abc123");          
									statement = connection.createStatement();
								%>
								<%           
								   	String QueryString = "SELECT * from status";
								   	rs = statement.executeQuery(QueryString);
								   	
								%>
								<br>
								<table width="650" bgcolor="pink" >
										<%if(rs.next()){ %>											
											<th><h3>Your File is Downloading.........</h3></th>										
										<%} else{%>
											<th><h3>Your File is downloaded successfully.....</h3></th>
										<%} %>										
								</table>
								<%							    
						
									rs.close();						
									statement.close();
									connection.close();
									} catch (Exception ex) {
								%>							    
								<%
							  		ex.printStackTrace();
							   
							    	}
								%>										
					</div>
					<div class="post">
											
					</div>					
					<div style="clear: both;">&nbsp;</div>
				</div>
				<!-- end #content -->
				<div id="sidebar">
					<%
					int num =0; 
					String s1="form"; 
					String s2="null";
					String name="null";
					String s3 = "forms";
					String s4 = "null";
					String add = "null";
				%>
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
				%>
				
					<ul>						
						<li>
						<%String[] fileid = new String[4]; %>
						<%           
						   String QueryString1 = "SELECT * from popularcontent order by count desc";
						   rs = statement.executeQuery(QueryString1);
						%>
							<h2>Popular Videos</h2>
							<ul>
							<%
							    for(int i=0;i<2&&rs.next();i++) {							    	
							    	fileid[i] = rs.getString("content_id");					    	
							 }
							 %>
													
							<%  
								int l =0;
								while(l < 2){
								s4 = Integer.toString(l);
							    add = s3.concat(s4);
						   		String QueryString2 = "SELECT * from content where content_id = '"+fileid[l]+"'";
						  		rs = statement.executeQuery(QueryString2);					  		
							%>
							
							<%if(rs.next()){ %>								
								<li>
								<form name="<%=add %>" action="FileDownload" method="post">								
									<a href="#" id="1" onclick="document.<%=add %>.submit()"><%=rs.getString(2)%></a>
									<input type="hidden" name="fileid" value="<%=rs.getString(6) %>"/>
								</form>	
								</li>
							<%} %>	
							<%l++;} %>																
							</ul>
						</li>
						<li>
						 <%           
						   String QueryString3 = "SELECT cat,count(*) as c from content group by cat order by c desc";
						   rs = statement.executeQuery(QueryString3);
						%>						
							<h2>Popular Categories</h2>
							<ul>							
							<%
							    for(int j=0;j<2&&rs.next();j++){							    	
							%>	
								<li><a href="#"><%=rs.getString(1) %></a></li>
							<%}%>																
							</ul>
						</li>
						<li>						
						 <%           
						   String QueryString4 = "SELECT * from content order by c_id desc limit 5";
						   rs = statement.executeQuery(QueryString4);
						%>						
							<h2>Latest Uploaded Videos</h2>
							<ul>
							 <%
							 	int i=0;
							    while (i<2&&rs.next()) {
							    	num = num + 1;
							    	s2 = Integer.toString(num);
							    	name = s1.concat(s2);							    	
							 %>								
								<li>
									<form name="<%=name %>" action="FileDownload" method="post">																				
										<a href="#" id="1" onclick="document.<%=name %>.submit()"><%=rs.getString(2)%></a>
										<input type="hidden" name="fileid" value="<%=rs.getString(6)%>"/>									
									</form>
									
								</li>
							<%   i++;}    %>																	
							</ul>
						</li>
						<li>
						<%           
						   String QueryString5 = "SELECT u_name,count(*) as c from content group by u_name order by c desc";
						   rs = statement.executeQuery(QueryString5);
						%>
							<h2>Most Active User</h2>
							<ul>
							<%
							    for(int j=0;j<2&&rs.next();j++){							    	
							%>	
								<li><a href="#"><%=rs.getString(1) %></a></li>
							<%}%>	
							</ul>
						</li>
					</ul>
					<%							    // close all the connections.
						
						rs.close();						
						statement.close();
						connection.close();
						} catch (Exception ex) {
					%>							    
					<%
					  	ex.printStackTrace();
					   //out.println("Unable to connect to database.");
					    }
					%>
				</div>
				<!-- end #sidebar -->
				<div style="clear: both;">&nbsp;</div>
			</div>
		</div>
	</div>
	<!-- end #page -->
</div>
<div id="footer">
	<p>Copyright (c) 2011 ruralcdn.com. All rights reserved. Design by <a href="">ACT4D GROUP</a>.</p>
</div>
<!-- end #footer -->
</body>
</html>
