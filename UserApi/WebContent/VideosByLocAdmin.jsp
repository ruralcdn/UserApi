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
			<li class="current_page_item"><a href="WelcomeAdmin.jsp">Home</a></li>			
			<li><a href="AllCatAdmin.jsp">Categories</a></li>
			<li><a href="AllUserAdmin.jsp">Users</a></li>
			<li><a href="AllLocAdmin.jsp">Locations</a></li>								
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
								<%String location = request.getParameter("loc"); %>
								<table width="650" bgcolor="orchid">
									<th><h3>Videos Uploaded By <%=location %></h3></th>
								</table>
								<br/>								
								<%
							      try {							          
							          String connectionURL = "jdbc:mysql://localhost:3306/ruralcdn";         
							          Connection connection = null;         
							          Statement statement = null;
							          ResultSet rs = null;  
							          List<String> str = new ArrayList<String>();
							          Class.forName("com.mysql.jdbc.Driver").newInstance();       
							          connection = DriverManager.getConnection(connectionURL, "root", "abc123");          
							          statement = connection.createStatement();
							                    
							          //String QueryString = "SELECT * from content where cat = '"+category+"'";
							          String QueryString = "SELECT dbkey from dbsync where dbkey like '%-loc' && dbvalue ='"+location+"'";
							          rs = statement.executeQuery(QueryString);
							          
							          while(rs.next()){
							        	  String temp = rs.getString(1);
							           	  str.add(temp.substring(0,temp.indexOf("-")));							          	  
							          }							         
							     %>
							         
								
								<table width="650" bgcolor="pink">
								<tr>
									<td><h4>Title</h4></td>
									<td><h4>Description</h4></td>
									<td><h4>Language</h4></td>
									<td><h4>Category</h4></td>
									<td></td>
									<td></td>
									<td></td>
								</tr>
							    <%
							    //while (rs.next()) {
							     for(int i =0; i < str.size(); i++) {
									System.out.println("In for loop");   
									String cid = str.get(i);
							   		String query = "select * from dbsync where dbkey like '%"+cid+"%'";   
							   		ResultSet rs1 = statement.executeQuery(query);
							   		String[] title =new String[10] ;
							   		int j = 0;
							   		int count = 0 ;
							   		while(rs1.next()){
							   			title[j++] = rs1.getString(2);
							   		}
							   		rs1.close();	
							    %>
							    <tr>
							        <td><%=title[7]%></td>
							        <td><%=title[3]%></td>
							        <td><%=title[4]%></td>
							        <td><%=title[0]%></td>
							        <td>
								        <form action="FileDownload" method="post">
									        <input type="hidden" name="fileid" value="<%=cid%>"/>							        
									        <input type="submit" value="Download"/>
									    </form>
							        </td>
							        <td>
							        	
							        </td>
							        <td>
							        	<form action="FileDelete" method="post">
							        		<input type="hidden" name="fileid" value="<%=cid%>"/>									        							        
									        <input type="submit" value="File Delete"/>
							        	</form>
							        </td>
							    </tr>
							    <%}%>
							    <%
							    // close all the connections.
							    rs.close();
							    statement.close();
							    connection.close();
								} catch (Exception ex) {
							    %>						    
							    
							<%
							   ex.printStackTrace();							                
							   }
							%>
							    </table>
								
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
