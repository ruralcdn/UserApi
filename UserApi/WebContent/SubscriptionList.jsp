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
								<!--upload form-->
								<%
									int i=0;
									int j =0;
									String[] user = new String[4];
									String[] cat = new String[4];
									String[] loc = new String[4];
									String s3 = "forms";
									String s4 = "null";
									String add = "null";
									String s5 = "null";
									String name = "null";
									String s6 = "form";
									String s7 = "frm";
									try {							          
									String connectionURL = "jdbc:mysql://localhost:3306/ruralcdn";         
									Connection connection = null;         
									Statement statement = null;
									ResultSet rs = null;
									ResultSet rs1 = null;
									ResultSet rs2 = null;
									ResultSet rs3 = null ;
									Class.forName("com.mysql.jdbc.Driver").newInstance();       
									connection = DriverManager.getConnection(connectionURL, "root", "abc123");          
									statement = connection.createStatement();
								
									String choice =request.getParameter("choice") ;
									int num = Integer.parseInt(choice);
								%>
								<table width="650" bgcolor="orchid">
								
								<%if(num ==1){ %>
									<th><h3>Videos By Subscribed User</h3></th>
								<%} %>
								<%if(num==2){ %>
								<th><h3>Videos By Subscribed Category</h3></th>
								<%} %>
								<%if(num==3){ %>
								<th><h3>Videos By Subscribed Location</h3></th>
								<%} %>
								</table><br/>															
								<!-- subscribe user videos -->
								<%if(num==1){ %>																
								<table width="650" bgcolor="pink">
									<tr>
										<td align="center"></td>
										<td align="center"><b>Title</b></td>
										<td align="center"><b>Description</b></td>
										<td align="center"><b>Category</b></td>
										<td align="center"><b>Location</b></td>
										<td align="center"><b>Download</b></td>
										<td align="center"></td>
									</tr>
								<%
									//String QueryString1 = "SELECT sub_name from usersubc where u_name = '"+username+"'";
									String QueryString1 = "SELECT dbvalue from dbsync where dbkey  = '"+username+"-subcuser'" ;
								   	rs = statement.executeQuery(QueryString1);						
									while(i<4&&rs.next()){
										user[i]=rs.getString(1);
										i++;
									}	
									int m = i ;
									
									while(j < m){										
										
										String QueryString2 = "select dbkey from dbsync where dbvalue ='"+user[j]+"' and dbkey like '%-user%'";
										rs = statement.executeQuery(QueryString2);
										String[] temp = new String[50];
										i=0;
										while(rs.next()){
											temp[i]=rs.getString(1);											
											i++;
										}
										int cout = i;
										String conId="" ;
										String[] title = new String[50] ;
										i=0;
										try{
											while(i < cout){
												String temp4 = temp[i];
												System.out.println("temp is"+ temp[i]);
												conId = temp4.substring(0,temp4.lastIndexOf("-"));
												String itemp = conId.substring(0,conId.lastIndexOf("."));
												String ipath = "DBServer/"+itemp+".jpg";
												System.out.println("conId is : "+conId);
												int k = 0 ;
												rs2 = statement.executeQuery("select * from dbsync where dbkey like '%"+conId+"%'");
												while(rs2.next()){													
													title[k++] = rs2.getString(2);
												}											
										%>										
											<tr>
												<td align="left"><img src="<%=ipath %>" width="80" height="80" align="top"/></td>
												<td align="center"><%=title[7] %></td>
												<td align="center"><%=title[3] %></td>
												<td align="center"><%=title[0] %></td>
												<td align="center"><%=title[5] %></td>												
												<td align="center">
													<form action="FileDownload" method="post">
														<select name="choice">
															<option value="1">Select</option>
															<option value="2">By Usb</option>
															<option value="3">By Tcp</option>
														</select>	
														<input type="hidden" name="fileid" value="<%=conId %>"/>
														<input type="submit" value="Download" name="Download"/>
													</form>
												</td>
											</tr>										
										<%
												i++;
												
											}
										}catch(Exception e){
											System.out.println("Problem happened");
										}
										j++;
									}
									%>
									</table>
								<%}%>
						<!-- end subscribe user videos -->
						<!-- subscribe category videos  -->
						<%if(num==2){ %>
						<table width="650" bgcolor="pink">
							<tr>
								<td align="center"></td>
								<td align="center"><b>Title</b></td>
								<td align="center"><b>Description</b></td>
								<td align="center"><b>Upload By</b></td>
								<td align="center"><b>Location</b></td>
								<td align="center"><b>Download</b></td>
								<td align="center"></td>
							</tr>			
						<%  							
						   	//String QueryString3 = "SELECT category from usertocat where u_name = '"+username+"'";
								String QueryString3 = "SELECT dbvalue from dbsync where dbkey  = '"+username+"-subccat'" ;
						   		rs = statement.executeQuery(QueryString3);						
								for(i=0;i<4&&rs.next();i++){
								cat[i]=rs.getString(1);								
								}
						%>						
						<%  	String conId="" ;
								String[] title = new String[10] ;
								int m =i;
								j = 0 ;
								while(j < m){	
									
									System.out.println("Value of m: "+m);
							//String QueryString4 = "SELECT * from content where cat = '"+cat[k]+"' order by c_id desc limit 2";
									String QueryString4 = "select dbkey from dbsync where dbvalue ='"+cat[j]+"' and dbkey like '%-cat%' ";
									rs = statement.executeQuery(QueryString4);					  		
						%>	
						<%			i = 0 ;
							//for(i=0;i<4&&rs.next();i++){
									try{
										while(i<3&&rs.next()){
											String temp = rs.getString(1);
											conId = temp.substring(0,temp.lastIndexOf("-"));
											System.out.println("conId is : "+conId);
											String itemp = conId.substring(0,conId.lastIndexOf("."));
											String ipath = "DBServer/"+itemp+".jpg";
											int k = 0 ;
											rs2 = statement.executeQuery("select * from dbsync where dbkey like '%"+conId+"%'");
											while(rs2.next()){
												//System.out.println(rs2.getString(2));
												title[k++] = rs2.getString(2);
											}
							
						%>															
						<tr>
							<td align="left"><img src="<%=ipath %>" width="80" height="80" align="top"/></td>
							<td align="center"><%=title[7]%></td>
							<td align="center"><%=title[3]%></td>
							<td align="center"><%=title[8]%></td>
							<td align="center"><%=title[5]%></td>
							<td align="center">
								<form action="FileDownload" method="post">
									<select name="choice">
										<option value="1">Select</option>
										<option value="2">By Usb</option>
										<option value="3">By Tcp</option>
									</select>
									<input type="hidden" name="fileid" value="<%=conId %>"/>
									<input type="submit" value="Download" name="Download"/>
								</form>
							</td>
						</tr>		
						<%					i++;
											System.out.println("value of i is: "+i);
										}
						%>					
						<%			}catch(Exception e){
										System.out.println("Problem happened in 2");
									}
						%>											
						<% 			j++;
								} %>
						</table>				
						<%} %>
					<!-- End Subscribe Category videos -->
					<!-- subscribe location videos -->
					<%if(num == 3){ %>
					<table width="650" bgcolor="pink">
						<tr>
							<td align="center"></td>
							<td align="center"><b>Title</b></td>
							<td align="center"><b>Description</b></td>
							<td align="center"><b>Category</b></td>
							<td align="center"><b>Upload By</b></td>
							<td align="center"><b>Download</b></td>
							<td align="center"></td>
						</tr>
					<% 							
					  	//String QueryString5 = "SELECT location from usertoloc where u_name = '"+username+"'";
						String QueryString5 ="Select dbvalue from dbsync where dbkey = '"+username+"-subcloc'";
					   	rs = statement.executeQuery(QueryString5);						
						for(i=0;i<4&&rs.next();i++){
							loc[i]=rs.getString(1);								
						}					  
						int k =0;
						i=0;
						String[] conId = new String[50];
						String[] title = new String[50];
						try{
							while(k < 3){						
							//String QueryString6 = "SELECT * from content where cont_loc = '"+loc[k]+"' order by c_id desc limit 2";
							String QueryString6 = "SELECT dbkey from dbsync where dbvalue = '"+loc[k]+"' and dbkey like '%-loc%'";
							rs = statement.executeQuery(QueryString6);
								try{
								while(rs.next()){
									String temp = rs.getString(1);
									//System.out.println("temp is : "+temp);
									conId[i] = temp.substring(0,temp.lastIndexOf("-"));									
									//System.out.println("conId is : "+conId[i]);
									i++;
								}
								}catch(Exception e){
									System.out.println("Problem happened in 4");
								}							
							k++;
						}
					}catch(Exception e){
						System.out.println("Problem happened in 3");
					}					
					int m =i;
					j = 0;
					try{
					while(j < m){
						String itemp = conId[j].substring(0,conId[j].lastIndexOf("."));
						String ipath = "DBServer/"+itemp+".jpg";
						String QueryString7 = "SELECT dbvalue from dbsync where dbkey like '%"+conId[j]+"%'";
						//System.out.println("conId is in while : "+conId[j]);
						rs = statement.executeQuery(QueryString7);
						//System.out.println("value of j before"+j);
						i = 0;
						try{
						while(rs.next()){													
							title[i++]= rs.getString(1);
						}
						}catch(Exception e){
							System.out.println("Problem happened in 5");
						}
					%>												
					<tr>
						<td align="left"><img src="<%=ipath %>" width="80" height="80" align="top"/></td>
						<td align="center"><%=title[7] %></td>
						<td align="center"><%=title[3] %></td>
						<td align="center"><%=title[0] %></td>
						<td align="center"><%=title[8] %></td>
						<td align="center">
							<form action="FileDownload" method="post">
								<select name="choice">
									<option value="1">Select</option>
									<option value="2">By Usb</option>
									<option value="3">By Tcp</option>
								</select>
								<input type="hidden" name="fileid" value="<%=conId[j]%>"/>
								<input type="submit" value="Download" name="Download"/>
							</form>
						</td>
					</tr>						
					<%j++;} %>
					<%}catch(Exception e){
						System.out.println("Problem happened in 6");
					} %>												
					</table>							
					<%} %>		
					<!-- end subscribe location videos -->								
								
								
							<%							    // close all the connections.
								rs2.close();
								rs.close();						
								statement.close();
								connection.close();
								} catch (Exception ex) {
							%>							    
							<%
							System.out.println("Problem happened in 7");
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
						<h2>Advanced Search</h2>
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
