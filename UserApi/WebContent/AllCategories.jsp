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
<!--  <script type="text/javascript">
function MyFunction(id)
{
	var n_id = id;
	if(id==1){
	<%	
	String message = "hello world";
	%>
	var msg = "<%=message%>";
	alert(n_id);
	}
	if(id==2){		
		<%	
		String message1 = "hello world";
		%>
		var msg = "<%=message1%>";
		alert(n_id);
	}
}
</script>
-->
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
								<table width="650" bgcolor="#41A317">
									<th><font color="white" size="4px">Videos in All Categories</font></th>
								</table>
								<br/>
								 	<table width="650" bgcolor="pink">
									 	<tr id="row1">
										 	<td align="center">										 										 	
											 	<%	
											 	int num = 0;
											 	String category = null;
											      try {										         
											          String connectionURL = "jdbc:mysql://localhost:3306/ruralcdn";										      
											          Connection connection = null;										         
											          Statement statement = null;										        
											          ResultSet rs = null;										          
											          Class.forName("com.mysql.jdbc.Driver").newInstance();										         
											          connection = DriverManager.getConnection(connectionURL, "root", "abc123");										         
											          statement = connection.createStatement();										          
											          //String QueryString = "SELECT count(*) from content";
											          String QueryString = "SELECT dbvalue,count(*) from dbsync where dbkey like '%-cat'&& dbvalue ='Animal Care'";
											          rs = statement.executeQuery(QueryString);										        
											      	  while (rs.next()) {
											   			num	=rs.getInt(2);
											   			category = rs.getString(1);
											    	} 
											    %>
											    <h3>
													<form name="form1" action ="AllCatList.jsp" method="post">
														<a href="#" id="1" onclick="document.form1.submit()">
															<input type="hidden" value="Animal Care" name="cat"/>
																Animal Care(<%=num %>)
														</a>
											 		</form>
											 	</h3>
											 	<br/>											 	
											 	<img src="images/imgcat01.jpg" width="140" height="100" align="center"/>
											 	<br/><br/>
											 	<b><a href="UsertoCatSubsc?category=<%=category%>&follower=<%=username %>">Sub to this category</a></b>										 					 								 	
										 	</td>
										 	<td align="center">										 	
											    <% //String QueryString1 = "SELECT count(*) from content where cat='Autos & Vehicles'";
											    String QueryString1 = "SELECT dbvalue,count(*) from dbsync where dbkey like '%-cat' && dbvalue ='Application of Insecticide & Fungicide'";
											      rs = statement.executeQuery(QueryString1);										        
											      while (rs.next()) {										    	  
											   			num=rs.getInt(2);
											   			category = rs.getString(1);
											      }
											    %>
											    <h3>
											    	<form name="form2" action ="AllCatList.jsp" method="post">
											    		<a href="#" id="1" onclick="document.form2.submit()">
											    			<input type="hidden" value="Application of Insecticide & Fungicide" name="cat"/>
											    				Application of Insecticide & Fungicide(<%=num %>)
											    		</a>
											    	</form>
											    </h3>
											    <img src="images/imgcat02.jpg" width="140" height="100" align="center"/>
											    <br/><br/> 
											    <b><a href="UsertoCatSubsc?category=<%=category%>&follower=<%=username %>">Sub to this category</a></b>										   	
											 </td>
										 	<td align="center">											 	
											 	<%//String QueryString2 = "SELECT count(*) from content where cat='Comedy'";
											 	String QueryString2 = "SELECT dbvalue,count(*) from dbsync where dbkey like '%-cat' && dbvalue ='Awareness'";
											          rs = statement.executeQuery(QueryString2);										        
											      	  while (rs.next()) {							     
											      		num=rs.getInt(2);
											   			category = rs.getString(1);
											    	}
											    %>
											    <h3>
										    	<form name="form3" action ="AllCatList.jsp" method="post">
										    		<a href="#" id="1" onclick="document.form3.submit()">
										    			<input type="hidden" value="Awareness" name="cat"/>
										    				Awareness(<%=num %>)
										    		</a>
										    	</form>
										    	</h3>
										    	<br/>
										    	<img src="images/imgcat03.jpg" width="140" height="100" align="center"/>
										    	<br/><br/>
											    <b><a href="UsertoCatSubsc?category=<%=category%>&follower=<%=username %>">Sub to this category</a></b>											   
											 </td>										 	
									 	</tr>
									 	<tr><td><br/></td><td></td><td></td></tr>								 	
									 	<tr id="row2">
										 	<td align="center">										 	
										 	<%//String QueryString3 = "SELECT count(*) from content where cat='Education'";
										 	String QueryString3 = "SELECT dbvalue,count(*) from dbsync where dbkey like '%-cat' && dbvalue ='Azolla in Paddy'";
										          rs = statement.executeQuery(QueryString3);										        
										      	  while (rs.next()) {
										      		num=rs.getInt(2);
										   			category = rs.getString(1);
										      	  }
										    %>
										    <h3>
										    	<form name="form4" action ="AllCatList.jsp" method="post">
										    		<a href="#" id="1" onclick="document.form4.submit()">
										    			<input type="hidden" value="Azolla in Paddy" name="cat"/>
										    				Azolla in Paddy(<%=num %>)
										    		</a>
										    	</form>
										    </h3>
										    <br/>
										    <img src="images/imgcat04.jpg" width="140" height="100" align="center"/>
										    <br/><br/>									        
										    <b><a href="UsertoCatSubsc?category=<%=category %>&follower=<%=username %>">Sub to this category</a></b>										    							 	
										 	</td>
										 	<td align="center">										 	
										 	<%//String QueryString4 = "SELECT count(*) from content where cat='Entertainment'";
										 	String QueryString4 = "SELECT dbvalue,count(*) from dbsync where dbkey like '%-cat' && dbvalue ='After Care of Plants('";
										          rs = statement.executeQuery(QueryString4);										        
										      	  while (rs.next()) {
										      		num=rs.getInt(2);
										   			category = rs.getString(1);
										      	  }
										   	%>
										   	<h3>
										    	<form name="form5" action ="AllCatList.jsp" method="post">
										    		<a href="#" id="1" onclick="document.form5.submit()">
										    			<input type="hidden" value="After Care of Plants" name="cat"/>
										    				After Care of Plants(<%=num %>)
										    		</a>
										    	</form>
										    </h3>
										    <br/>
										    <img src="images/imgcat05.jpg" width="140" height="100" align="center"/>
										    <br/><br/>
										    <b><a href="UsertoCatSubsc?category=<%=category%>&follower=<%=username %>">Sub to this category</a></b>										    
										 	</td>
										 	<td align="center">										 	
										 	<%//String QueryString5 = "SELECT count(*) from content where cat='Film & Animation'";
										 	String QueryString5 = "SELECT dbvalue,count(*) from dbsync where dbkey like '%-cat' && dbvalue ='Compost'";
										          rs = statement.executeQuery(QueryString5);										        
										      	  while (rs.next()) {
										      		num=rs.getInt(2);
										   			category = rs.getString(1);
										      	  }
											%>
											<h3>
										 		<form name="form6" action ="AllCatList.jsp" method="post">
										 			<a href="#" id="1" onclick="document.form6.submit()">
										 				<input type="hidden" value="Compost" name="cat"/>
										 				Compost(<%=num %>)
										 			</a>
										 		</form>
										 	</h3>
										 	<br/>
										    <img src="images/imgcat06.jpg" width="140" height="100" align="center"/>
										    <br/><br/>
										    <b><a href="UsertoCatSubsc?category=<%=category %>&follower=<%=username %>">Sub to this category</a></b>										    
										 	</td>
									 	</tr>
									 	<tr><td><br/></td><td></td><td></td></tr>
									 	<tr id="row3">									 		
									 		<td align="center">										 	
										 	<%//String QueryString6 = "SELECT count(*) from content where cat='Gaming'";
										 	String QueryString6 = "SELECT dbvalue,count(*) from dbsync where dbkey like '%-cat' && dbvalue ='Discussion'";
										          rs = statement.executeQuery(QueryString6);										        
										      	  while (rs.next()) {
										      		num=rs.getInt(2);
										   			category = rs.getString(1);
										      	  }
										    %> 	  
										    <h3>
										 		<form name="form7" action ="AllCatList.jsp" method="post">
										 			<a href="#" id="1" onclick="document.form7.submit()">
										 				<input type="hidden" value="Discussion" name="cat"/>
										 					Discussion(<%=num %>)
										 			</a>
										 		</form>
										 	</h3>
										 	<br/>
										    <img src="images/imgcat07.jpg" width="140" height="100" align="center"/>
										    <br/><br/>
										    <b><a href="UsertoCatSubsc?category=<%=category%>&follower=<%=username %>">Sub to this category</a></b>										   
									 		</td>
									 		<td align="center">										 	
										 	<%//String QueryString7 = "SELECT count(*) from content where cat='Howto & Style'";
										 	String QueryString7 = "SELECT dbvalue,count(*) from dbsync where dbkey like '%-cat' && dbvalue ='Garlic Cultivation'";
										          rs = statement.executeQuery(QueryString7);										        
										      	  while (rs.next()) {
										      		num=rs.getInt(2);
										   			category = rs.getString(1);
										      	  }
										    %> 	  
										    <h3>
										 		<form name="form8" action ="AllCatList.jsp" method="post">
										 			<a href="#" id="1" onclick="document.form8.submit()">
										 				<input type="hidden" value="Garlic Cultivation" name="cat"/>
										 					Garlic Cultivation(<%=num %>)
										 			</a>
										 		</form>
										 	</h3>
										 	<br/>
										    <img src="images/imgcat08.JPG" width="140" height="100" align="center"/>
										    <br/><br/>
										    <b><a href="UsertoCatSubsc?category=<%=category%>&follower=<%=username %>">Sub to this category</a></b>										  
									 		</td>
									 		<td align="center">										 	
										 	<%//String QueryString8 = "SELECT count(*) from content where cat='Music'";
										 	String QueryString8 = "SELECT dbvalue,count(*) from dbsync where dbkey like '%-cat' && dbvalue ='Harvesting'";
										          rs = statement.executeQuery(QueryString8);										        
										      	  while (rs.next()) {
										      		num=rs.getInt(2);
										   			category = rs.getString(1);
										      	  }
										    %>
										    <h3>
										 		<form name="form9" action ="AllCatList.jsp" method="post">
										 			<a href="#" id="1" onclick="document.form9.submit()">
										 				<input type="hidden" value="Harvesting" name="cat"/>
										 					Harvesting(<%=num %>)
										 			</a>
										 		</form>
										 	</h3>
										 	<br/>
										    <img src="images/imgcat09.jpg" width="140" height="100" align="center"/>
										    <br/><br/>
										    <b><a href="UsertoCatSubsc?category=<%=category %>&follower=<%=username %>">Sub to this category</a></b>										    
									 		</td>
									 	</tr>
									 	<tr><td><br/></td><td></td><td></td></tr>
									 	<tr id="row4">									 		
									 		<td align="center">										 	
										 	<%//String QueryString9 = "SELECT count(*) from content where cat='News & Politics'";
										 	String QueryString9 = "SELECT dbvalue,count(*) from dbsync where dbkey like '%-cat' && dbvalue ='Herbal Medicine'";
										          rs = statement.executeQuery(QueryString9);										        
										      	  while (rs.next()) {
										      		num=rs.getInt(2);
										   			category = rs.getString(1);
										      	  }
										   	%>
										   	<h3>
										 		<form name="form10" action ="AllCatList.jsp" method="post">
										 			<a href="#" id="1" onclick="document.form10.submit()">
										 				<input type="hidden" value="Herbal Medicine" name="cat"/>
										 					Herbal Medicine(<%=num %>)
										 			</a>
										 		</form>
										 	</h3>
										 	<br/>
										    <img src="images/imgcat10.jpg" width="140" height="100" align="center"/>
										    <br/><br/>
										    <b><a href="UsertoCatSubsc?category=<%=category %>&follower=<%=username %>">Sub to this category</a></b>										    
									 		</td>
									 		<td align="center">										 	
										 	<%//String QueryString10 = "SELECT count(*) from content where cat='Nonprofits & Activism'";
										 	String QueryString10 = "SELECT dbvalue,count(*) from dbsync where dbkey like '%-cat' && dbvalue ='Low cost Vermicompost'";
										          rs = statement.executeQuery(QueryString10);										        
										      	  while (rs.next()) {
										      		num=rs.getInt(2);
										   			category = rs.getString(1);
										      	  }
										    %> 	  
										    <h3>
										 		<form name="form11" action ="AllCatList.jsp" method="post">
										 			<a href="#" id="1" onclick="document.form11.submit()">
										 				<input type="hidden" value="Low cost Vermicompost" name="cat"/>
										 					Low cost Vermicompost(<%=num %>)
										 			</a>
										 		</form>
										 	</h3>
										 	<br/>
										    <img src="images/imgcat11.jpg" width="140" height="100" align="center"/>
										    <br/><br/>
										    <b><a href="UsertoCatSubsc?category=<%=category%>&follower=<%=username %>">Sub to this category</a></b>										    
									 		</td>
									 		<td align="center">										 	
										 	<%//String QueryString12 = "SELECT count(*) from content where cat='Pets & Animals'";
										 	String QueryString12 = "SELECT dbvalue,count(*) from dbsync where dbkey like '%-cat' && dbvalue ='Preparation of Biofertilizer'";
										          rs = statement.executeQuery(QueryString12);										        
										      	  while (rs.next()) {
										      		num=rs.getInt(2);
										   			category = rs.getString(1);
										      	  }
										    %> 	  
										    <h3>
										 		<form name="form12" action ="AllCatList.jsp" method="post">
										 			<a href="#" id="1" onclick="document.form12.submit()">
										 				<input type="hidden" value="Preparation of Biofertilizer" name="cat"/>
										 					Preparation of Biofertilizer(<%=num %>)
										 			</a>
										 		</form>
										 	</h3>
										 	<br/>
										    <img src="images/imgcat12.jpg" width="140" height="100" align="center"/>
										    <br/><br/>   
										    <b><a href="UsertoCatSubsc?category=<%=category %>&follower=<%=username %>">Sub to this category</a></b>										   
									 		</td>									 		
									 	</tr>
									 	<tr><td><br/></td><td></td><td></td></tr>
									 	<tr id="row5">								 		
									 		<td align="center">										 	
										 	<%//String QueryString13 = "SELECT count(*) from content where cat='Science & Technology'";
										 	String QueryString13 = "SELECT dbvalue,count(*) from dbsync where dbkey like '%-cat' && dbvalue ='Potato Sowing'";
										          rs = statement.executeQuery(QueryString13);										        
										      	  while (rs.next()) {
										      		num=rs.getInt(2);
										   			category = rs.getString(1);
										      	  }
										    %>	  
										    <h3>
										 		<form name="form13" action ="AllCatList.jsp" method="post">
										 			<a href="#" id="1" onclick="document.form13.submit()">
										 				<input type="hidden" value="Potato Sowing" name="cat"/>
										 					Potato Sowing(<%=num %>)
										 			</a>
										 		</form>
										 	</h3>
										 	<br/>
										    <img src="images/imgcat13.jpg" width="140" height="100" align="center"/>
										    <br/><br/>   
										    <b><a href="UsertoCatSubsc?category=<%=category %>&follower=<%=username %>">Sub to this category</a></b>										    
									 		</td>
									 		<td align="center">										 	
										 	<%//String QueryString14 = "SELECT count(*) from content where cat='Sports'";
										 	String QueryString14 = "SELECT dbvalue,count(*) from dbsync where dbkey like '%-cat' && dbvalue ='Seed Treatment'";
										          rs = statement.executeQuery(QueryString14);										        
										      	  while (rs.next()) {
										      		num=rs.getInt(2);
										   			category = rs.getString(1);
										      	  }
										    %> 	  
											<h3>
										 		<form name="form14" action ="AllCatList.jsp" method="post">
										 			<a href="#" id="1" onclick="document.form14.submit()">
										 				<input type="hidden" value="Seed Treatment" name="cat"/>
										 					Seed Treatment(<%=num %>)
										 			</a>
										 		</form>
										 	</h3>
										 	<br/>
										    <img src="images/imgcat14.JPG" width="140" height="100" align="center"/>
										    <br/><br/> 
										    <b><a href="UsertoCatSubsc?category=<%=category %>&follower=<%=username %>">Sub to this category</a></b>										   
									 		</td>
									 		<td align="center">										 	
										 	<%//String QueryString15 = "SELECT count(*) from content where cat='Travel & Events'";
										 	String QueryString15 = "SELECT dbvalue,count(*) from dbsync where dbkey like '%-cat' && dbvalue ='Sheep Manuring'";
										          rs = statement.executeQuery(QueryString15);										        
										      	  while (rs.next()) {
										      		num=rs.getInt(2);
										   			category = rs.getString(1);
										      	  }
										    %> 	  
										     <h3>
										 		<form name="form15" action ="AllCatList.jsp" method="post">
										 			<a href="#" id="1" onclick="document.form15.submit()">
										 				<input type="hidden" value="Sheep Manuring" name="cat"/>
										 					Sheep Manuring(<%=num %>)
										 			</a>
										 		</form>
										 	</h3>
										 	<br/>
										    <img src="images/imgcat15.jpg" width="140" height="100" align="center"/>
										    <br/><br/>   
										    <b><a href="UsertoCatSubsc?category=<%=category %>&follower=<%=username %>">Sub to this category</a></b>										    
									 		</td>
									 	</tr>
									 	<tr><td><br/></td><td></td><td></td></tr>
									 	<tr id="row6">								 		
									 		<td align="center">										 	
										 	<%//String QueryString16 = "SELECT count(*) from content where cat='Other'";
										 	String QueryString16 = "SELECT dbvalue,count(*) from dbsync where dbkey like '%-cat' && dbvalue ='Soil Sample Collection for Soil Testing'";
										          rs = statement.executeQuery(QueryString16);										        
										      	  while (rs.next()) {
										      		num = rs.getInt(2);
										   			category = rs.getString(1);
										      	  }
										    %> 	  
										     <h3>
										 		<form name="form16" action ="AllCatList.jsp" method="post">
										 			<a href="#" id="1" onclick="document.form16.submit()">
										 				<input type="hidden" value="Soil Sample Collection for Soil Testing" name="cat"/>
										 					Soil Sample Collection for Soil Testing(<%=num %>)
										 			</a>
										 		</form>
										 	</h3>
										 	<br/>
										    <img src="images/imgcat16.jpg" width="140" height="100" align="center"/>
										    <br/><br/>  
										   <b><a href="UsertoCatSubsc?category=<%=category %>&follower=<%=username %>">Sub to this category</a></b>										   
									 		</td>
									 		<td align="center">
									 		<%String QueryString17 = "SELECT dbvalue,count(*) from dbsync where dbkey like '%-cat' && dbvalue ='Sucess Story'";
										          rs = statement.executeQuery(QueryString17);										        
										      	  while (rs.next()) {										    	  
										      		num = rs.getInt(2);
										   			category = rs.getString(1);
										    	}
										    %>
										 	<h3>
										 		<form name="form17" action ="AllCatList.jsp" method="post">
										 			<a href="#" id="1" onclick="document.form17.submit()">
										 				<input type="hidden" value="Sucess Story" name="cat"/>
										 					Sucess Story(<%=num %>)
										 			</a>
										 		</form>
										 	</h3>
										 	<br/>
										    <img src="images/imgcat17.jpg" width="140" height="100" align="center"/>
										    <br/><br/> 
										 	<b><a href="UsertoCatSubsc?category=<%=category %>&follower=<%=username %>">Sub to this category</a></b>											 	
									 		</td>
									 		<td align="center">
									 		<%String QueryString18 = "SELECT dbvalue,count(*) from dbsync where dbkey like '%-cat' && dbvalue ='Tomato Transplanting'";
										          rs = statement.executeQuery(QueryString18);										        
										      	  while (rs.next()) {										    	  
										      		num=rs.getInt(2);
										   			category = rs.getString(1);
										    	}
										    %>
										 	<h3>
										 		<form name="form18" action ="AllCatList.jsp" method="post">
										 			<a href="#" id="1" onclick="document.form18.submit()">
										 				<input type="hidden" value="Tomato Transplanting" name="cat"/>
										 					Tomato Transplanting(<%=num %>)
										 			</a>
										 		</form>
										 	</h3>
										 	<br/>
										    <img src="images/imgcat18.jpg" width="140" height="100" align="center"/>
										    <br/><br/> 
										 	<b><a href="UsertoCatSubsc?category=<%=category %>&follower=<%=username %>">Sub to this category</a></b>										 	
									 		</td>
									 	</tr>
									 	<tr><td><br/></td><td></td><td></td></tr>
									 	<tr id="row7">
									 											 		
									 		<td align="center">
									 		<%String QueryString19 = "SELECT dbvalue,count(*) from dbsync where dbkey like '%-cat' && dbvalue ='Wheat Cultivation('";
										          rs = statement.executeQuery(QueryString19);										        
										      	  while (rs.next()) {										   	  
										      		num=rs.getInt(2);
										   			category = rs.getString(1);
										    	}
										    %>
										 	<h3>
										 		<form name="form19" action ="AllCatList.jsp" method="post">
										 			<a href="#" id="1" onclick="document.form19.submit()">
										 				<input type="hidden" value="Wheat Cultivation" name="cat"/>
										 					Wheat Cultivation(<%=num %>)
										 			</a>
										 		</form>
										 	</h3>
										 	<br/>
										    <img src="images/imgcat19.jpg" width="140" height="100" align="center"/>
										    <br/><br/>
										 	<b><a href="UsertoCatSubsc?category=<%=category %>&follower=<%=username %>">Sub to this category</a></b>										 	
									 		</td>
									 		<td align="center">
									 		<%String QueryString20 = "SELECT dbvalue,count(*) from dbsync where dbkey like '%-cat' && dbvalue ='Other'";
										          rs = statement.executeQuery(QueryString20);										        
										      	  while (rs.next()) {										    	  
										      		num=rs.getInt(2);
										   			category = rs.getString(1);
										    	}
										    %>
										 	<h3>
										 		<form name="form20" action ="AllCatList.jsp" method="post">
										 			<a href="#" id="1" onclick="document.form20.submit()">
										 				<input type="hidden" value="Other" name="cat"/>
										 					Other(<%=num %>)
										 			</a>
										 		</form>
										 	</h3>
										 	<br/>
										 											 	
									 		</td>
									 		<td align="center">
									 		<%String QueryString21 = "SELECT dbvalue,count(*) from dbsync where dbkey like '%-cat'";
										          rs = statement.executeQuery(QueryString21);										        
										      	  while (rs.next()) {										    	  
										      		num=rs.getInt(2);
										   			category = rs.getString(1);
										    	}
										    %>
										 	<h3>
										 		<form name="form21" action ="AllCatList.jsp" method="post">
										 			<a href="#" id="1" onclick="document.form21.submit()">
										 				<input type="hidden" value="all" name="cat"/>
										 					All(<%=num %>)
										 			</a>
										 		</form>
										 	</h3>
										 	<br/>
										 											 	
									 		</td>									 		
									 	</tr>
									 	<tr><td><br/></td><td></td><td></td></tr>									 	
										<%	
											rs.close();
										    statement.close();
										    connection.close();
										    }catch (Exception ex){
										    	
										    ex.printStackTrace();
										    System.out.println("Exception happened in AllCategories.jsp");
										 	out.println("Unable to connect to database.");
										 	}
										%>
									</table>								 	
								<div>									
								</div>								
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
