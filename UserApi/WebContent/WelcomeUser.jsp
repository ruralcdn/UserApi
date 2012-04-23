<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">

<%@ page import="java.sql.*"%>
<%@ page import="java.io.*"%>
<%@page import="java.util.*"%>
<%@page import="java.util.*"%>
<%@page import="java.io.File"%>
<%@page import="java.io.FileInputStream"%>
<%@page import="java.io.FileNotFoundException"%>

<%@page import="AbstractAppConfig.AppConfig"%>
<%@page import="javax.servlet.http.HttpSession"%>
<%@ page language="java"%>

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
		String username = (String) session.getAttribute("ulogname");
		if (username == null) {
			String redirectURL = "index.jsp";
			response.sendRedirect(redirectURL);
		}
	%>
	<div id="wrapper">
		<div id="header">
			<div id="logo">
				<h1>
					<a href="#">Welcome: <%=username%></a>
				</h1>
			</div>
		</div>
		<!-- end #header -->
		<div id="menu">
			<ul>
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
								<img class="output" src="images/img04.jpg" alt="" />
								<div id="thumbnail-bg">
									<ul class="thumbnails">
										<li><img class="active" src="images/img04.jpg" title=""
											alt="" width="604" height="375"
											onmouseover="this.style.opacity=1;this.filters.alpha.opacity=100"
											onmouseout="this.style.opacity=0.4;this.filters.alpha.opacity=70" /></li>
										<li><img src="images/img05.jpg" title="" alt=""
											width="100" height="75"
											onmouseover="this.style.opacity=1;this.filters.alpha.opacity=100"
											onmouseout="this.style.opacity=0.4;this.filters.alpha.opacity=70" /></li>
										<li><img src="images/img06.jpg" title="" alt=""
											width="100" height="75"
											onmouseover="this.style.opacity=1;this.filters.alpha.opacity=100"
											onmouseout="this.style.opacity=0.4;this.filters.alpha.opacity=70" /></li>
										<li><img src="images/img07.jpg" title="" alt=""
											width="100" height="75"
											onmouseover="this.style.opacity=1;this.filters.alpha.opacity=100"
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
								<h2 class="title">
									<a href="#">Recent research in agriculture</a>
								</h2>
								<p class="meta">
									<span class="date"><%=new java.util.Date()%></span><span
										class="posted">Posted by <a href="#">Amit dubey</a></span>
								</p>
								<div style="clear: both;">&nbsp;</div>
								<div class="entry">Studies by U.S. Department of
									Agriculture (USDA) scientists have confirmed that the presence
									of Escherichia coli pathogens in surface waters could result
									from the pathogen's ability to survive for months in underwater
									sediments. Most E. coli strains don't cause illness, but they
									are indicator organisms used by water quality managers to
									estimate fecal contamination.</div>
							</div>
						</div>
						<div style="clear: both;">&nbsp;</div>
					</div>
					<!-- end #content -->
					<div id="sidebar">
						<%
							int i = 0;
							int j = 0;
							int k = 0;
							String iname = null;
							String[] user = new String[4];
							String[] cat = new String[4];
							String[] loc = new String[4];
							String s3 = "forms";
							String s4 = null;
							String add = null;
							String s5 = null;
							String name = null;
							String s6 = "form";
							String s7 = "frm";
							String ipath = "";
							try {
								String connectionURL = "jdbc:mysql://localhost:3306/ruralcdn";
								Connection connection = null;
								Statement statement = null;
								ResultSet rs = null;
								ResultSet rs1 = null;
								ResultSet rs2 = null;
								Class.forName("com.mysql.jdbc.Driver").newInstance();
								connection = DriverManager.getConnection(connectionURL, "root",
										"abc123");
								statement = connection.createStatement();
						%>
						<ul>
							<!-- subscription user -->
							<li>
								<%
									String QueryString1 = "SELECT dbvalue from dbsync where dbkey  = '"
												+ username + "-subcuser'";
										rs = statement.executeQuery(QueryString1);
										while (i < 2 && rs.next()) {
											user[i] = rs.getString(1);
											//System.out.println(" user name is " + user[i]);
											i++;
										}
										int m = i;
										//System.out.println("value of m is " + m);
								%>
								<h2>Videos(by subscribed user)</h2>
								<ul>
									<%
										j = 0;
											while (j < m) {
												s4 = Integer.toString(j);
												add = s3.concat(s4);
												String conId = null;
												String title = null;

												String QueryString2 = "select dbkey from dbsync where dbvalue ='"
														+ user[j] + "' and dbkey like '%-user%' limit 2";
												rs = statement.executeQuery(QueryString2);
												String[] temp = new String[50];
												i = 0;
												while (rs.next()) {
													temp[i] = rs.getString(1);
													//System.out.println(" temp name is " + temp[i]);
													i++;
													//System.out.println("value of i is " + i);
												}
												try {
													conId = temp[i - 1].substring(0,
															temp[i - 1].lastIndexOf("-"));
												} catch (Exception e) {
													System.out.println("error in lopp 1");
												}
												try {
													rs2 = statement
															.executeQuery("select dbvalue from dbsync where dbkey ='"
																	+ conId + "-title'");
													if (rs2.next()) {
														title = rs2.getString(1);
													}
													String itemp = conId.substring(0,
															conId.lastIndexOf("."));
													ipath = "DBServer/" + itemp + ".jpg";
													s5 = Integer.toString(i);
													name = add.concat(s5);
												} catch (Exception e) {
													System.out.println("error in lopp 2");
												}
									%>
									<li>
										<form name="<%=name%>" action="FileDownload" method="post">
											<a href="#" id="1" onclick="document.<%=name%>.submit()">
												<img src="<%=ipath%>" width="80" height="80" align="top"
												alt="" />
											</a>
											<b>&nbsp;<%=title%></b>
											<input type="hidden" name="fileid" value="<%=conId%>" />
										</form>
									</li>

									<%
										j++;
											}
									%>
									<li>
										<form action="SubscriptionList.jsp" method="post"
											name="myform1">
											<a href="#" id="1" onclick="document.myform1.submit()">See
												all videos</a>
											<input type="hidden" name="choice" value="1" />
										</form>
									</li>
								</ul>
							</li>
							<!-- end subcribed user -->
							<!-- subscribed category -->
							<li>
								<%
									String QueryString3 = "SELECT dbvalue from dbsync where dbkey  = '"
												+ username + "-subccat'";
										rs = statement.executeQuery(QueryString3);
										for (i = 0; i < 2 && rs.next(); i++) {
											cat[i] = rs.getString(1);
										}
								%>
								<h2>Videos(by subscribed Cat.)</h2>
								<ul>
									<%
										k = 0;
											while (k < 2) {
												s4 = Integer.toString(k);
												add = s6.concat(s4);
												String conId = "";
												String title = "";
												String QueryString4 = "select dbkey from dbsync where dbvalue ='"
														+ cat[k] + "' and dbkey like '%-cat%' limit 2";
												rs = statement.executeQuery(QueryString4);
												i = 0;
												while (i < 1 && rs.next()) {
													String temp = rs.getString(1);
													conId = temp.substring(0, temp.lastIndexOf("-"));
													rs2 = statement
															.executeQuery("select dbvalue from dbsync where dbkey ='"
																	+ conId + "-title'");
													if (rs2.next()) {
														title = rs2.getString(1);
													}
													String itemp = conId.substring(0,
															conId.lastIndexOf("."));
													ipath = "DBServer/" + itemp + ".jpg";
													s5 = Integer.toString(i);
													name = add.concat(s5);
									%>
									<li>
										<form name="<%=name%>" action="FileDownload" method="post">
											<a href="#" id="1" onclick="document.<%=name%>.submit()">
												<img src="<%=ipath%>" width="80" height="80" align="top"
												alt="img not found" />
											</a>
											<b><%=title%></b>
											<input type="hidden" name="fileid" value="<%=conId%>" />
										</form>
									</li>
									<%
										i++;
												}
									%>
									<%
										k++;
											}
									%>
									<li>
										<form action="SubscriptionList.jsp" method="post"
											name="myform2">
											<a href="#" id="1" onclick="document.myform2.submit()">See
												all videos</a>
											<input type="hidden" name="choice" value="2" />
										</form>
									</li>
								</ul>
							</li>
							<!-- end subscribed category -->
							<!-- subscribed location -->
							<li>
								<%
									String QueryString5 = "SELECT dbvalue from dbsync where dbkey  = '"
												+ username + "-subcloc'";
										rs = statement.executeQuery(QueryString5);
										for (i = 0; i < 4 && rs.next(); i++) {
											loc[i] = rs.getString(1);
										}
								%>
								<h2>Videos(by subscribed loc.)</h2>
								<ul>
									<%
										k = 0;
											while (k < 2) {
												s4 = Integer.toString(k);
												add = s7.concat(s4);
												String conId = "";
												String title = "";
												String QueryString6 = "select dbkey from dbsync where dbvalue ='"
														+ loc[k] + "' and dbkey like '%-loc%' limit 2";
												rs = statement.executeQuery(QueryString6);
												i = 0;
												while (i < 1 && rs.next()) {
													String temp = rs.getString(1);
													conId = temp.substring(0, temp.lastIndexOf("-"));
													rs2 = statement
															.executeQuery("select dbvalue from dbsync where dbkey ='"
																	+ conId + "-title'");
													if (rs2.next()) {
														title = rs2.getString(1);
													}
													String itemp = conId.substring(0,
															conId.lastIndexOf("."));
													ipath = "DBServer/" + itemp + ".jpg";
													s5 = Integer.toString(i);
													name = add.concat(s5);
									%>
									<li>
										<form name="<%=name%>" action="FileDownload" method="post">
											<a href="#" id="1" onclick="document.<%=name%>.submit()">
												<img src="<%=ipath%>" width="80" height="80" align="top"
												alt="img not found" />
											</a>
											<b>&nbsp;<%=title%></b>
											<input type="hidden" name="fileid" value="<%=conId%>"
												alt="img not found" />
										</form>
									</li>
									<%
										i++;
												}
									%>
									<%
										k++;
											}
									%>
									<li>
										<form action="SubscriptionList.jsp" method="post"
											name="myform3">
											<a href="#" id="1" onclick="document.myform3.submit()">See
												all videos</a>
											<input type="hidden" name="choice" value="3" />
										</form>
									</li>
								</ul>
							</li>
							<!-- end subcribed location -->
							<li>
								<%
									String QueryString4 = "SELECT * from dbsync where dbkey like '%-title' order by dbkey desc limit 5";
										rs = statement.executeQuery(QueryString4);
								%>
								<h2>Latest Uploaded Videos</h2>
								<ul>
									<%
										i = 0;
											int num = 0;
											String s2 = null;
											String s1 = "form1";
											while (i < 2 && rs.next()) {
												num = num + 1;
												s2 = Integer.toString(num);
												name = s1.concat(s2);
												String cid = rs.getString(1);
												String cidTitle = cid.substring(0, cid.indexOf("-"));

												String conId = cidTitle.substring(0,
														cidTitle.lastIndexOf("."));
												System.out.println("Con id is: " + conId);
												String idir = "DBServer/";
												String iPath = idir + conId + "." + "jpg";
												System.out.println("ipath is " + iPath);
									%>
									<li>
										<form name="<%=name%>" action="FileDownload" method="post">
											<a href="#" id="1" onclick="document.<%=name%>.submit()">
												<img src="<%=iPath%>" width="80" height="80"
												alt="click here to download" align="top" />
											</a>
											<b>&nbsp;<%=rs.getString(2)%></b>
											<input type="hidden" name="fileid" value="<%=cidTitle%>" />
										</form>

									</li>
									<%
										i++;
											}
									%>
									<li>
										<%
										String imgPath = "C:/Users/UserDaemon/git/UserApi/UserApi/WebContent/DBServer";
										File dtnDir = new File(imgPath);
										String[] dataList = dtnDir.list();
										int length =  dataList.length;
										//System.out.println("length"+length);
										i = 0 ;
										
										if(length != 0){
										for(i=0;i<length;i++){
											String iPath =  null;
											iPath =  "DBServer/" + dataList[i];
											String ufile = null;
											ufile  = dataList[i].substring(0, dataList[i].lastIndexOf("."));
											//System.err.println(ufile);
										String lastId = null;
										lastId = ufile.substring(ufile.length()-1, ufile.length());
										//System.err.println(lastId);
										int aInt = 0;
										aInt = Integer.parseInt(lastId);
										//System.err.println(aInt);
										name =  "form";
										name = name +Integer.toString(i);
										//System.out.println(name);
										
										%>
										<li>
										
										<img src="<%=iPath%>" width="200" height="150" alt="click here to download" align="top" />
										
										<a href="FilePlay.jsp?id=<%=ufile %>" id>Play This File</a>																				
										</li>
										
											
										
										<% 
											//System.out.println("dataList :"+i+dataList[i]);
											}
										
										}
										%>
									</li>									
								</ul>
							</li>
						</ul>
						<%
							rs.close();
								statement.close();
								connection.close();
							} catch (Exception ex) {
								ex.printStackTrace();
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
	<div id="menufooter">
		<ul>
			<li class="downcat"><a href="showrequest.jsp?id=1">Popular
					Videos</a></li>
			<li class="downcat"><a href="showrequest.jsp?id=2">Popular
					Categories</a></li>
			<li class="downcat"><a href="showrequest.jsp?id=3">Latest
					Uploaded Videos</a></li>

		</ul>
	</div>
	<div id="footer">
		<p>
			Copyright (c) 2011 ruralcdn.com. All rights reserved. Design by <a
				href="http://www.cse.iitd.ernet.in/act4d/">ACT4D Group,IITD</a>.
		</p>
	</div>
	<!-- end #footer -->
</body>
</html>
