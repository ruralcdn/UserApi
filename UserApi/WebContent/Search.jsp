<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<!--
-->
<%@ page import="org.apache.lucene.document.Document,
                 org.apache.lucene.search.Searcher,
                 org.apache.lucene.search.IndexSearcher,
                 org.apache.lucene.analysis.Analyzer,
                 org.apache.lucene.analysis.standard.StandardAnalyzer,
                 java.io.BufferedReader,
                 java.io.InputStreamReader,
                 java.io.File,
                 org.apache.lucene.search.Query,
                 org.apache.lucene.queryParser.QueryParser,
                 org.apache.lucene.search.Hits,
                 org.apache.lucene.analysis.standard.StandardAnalyzer,
				org.apache.lucene.document.Document,
				org.apache.lucene.index.IndexReader,
				org.apache.lucene.queryParser.QueryParser,
				org.apache.lucene.search.IndexSearcher,
				org.apache.lucene.search.Query,
				org.apache.lucene.search.ScoreDoc,
				org.apache.lucene.search.TopScoreDocCollector,
				org.apache.lucene.store.FSDirectory,
				org.apache.lucene.util.Version;"
				%>

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
			<h1><a href="#">Welcome<%=username %></a></h1>
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
    if(request.getParameter("query")==null ||
			request.getParameter("query").equals("")){		
		return;
	}
    String LUCENE_INDEX_DIRECTORY = "C:\\lucene";
	IndexReader reader = null;
	StandardAnalyzer analyzer = null;
	IndexSearcher searcher = null;
	TopScoreDocCollector collector = null;
	QueryParser parser = null;
	Query query = null;
	ScoreDoc[] hits = null;
	Document document = null;

	try{
		//store the parameter value in query variable
		String userQuery = request.getParameter("query");
		//create standard analyzer object
		analyzer = new StandardAnalyzer(Version.LUCENE_CURRENT);
		//create File object of our index directory
		File file = new File(LUCENE_INDEX_DIRECTORY);
		//create index reader object
		reader = IndexReader.open(FSDirectory.open(file),true);
		//create index searcher object
		searcher = new IndexSearcher(reader);
		//create topscore document collector
		collector = TopScoreDocCollector.create(1000, false);
		//create query parser object
		parser = new QueryParser("fulltext", analyzer);
		//parse the query and get reference to Query object
		query = parser.parse(userQuery +"*");
		//search the query
		searcher.search(query, collector);
		hits = collector.topDocs().scoreDocs;
		//check whether the search returns any result
		if(hits.length>0){%>
		<table width="650" bgcolor="grey">
									<th><h3>Search Result</h3></th>
								</table>
								<table width="650" align="center" bgcolor="pink">
								<tr>
									<td><h4></h4></td>
									<td><h4>Title</h4></td>
									<td><h4>Category</h4></td>
									<td><h4>Language</h4></td>
									<td><h4>Uploaded By User</h4></td>
									<td></td>
									<td></td>
								</tr>
		<%
			//iterate through the collection and display result
			for(int i=0; i<hits.length; i++){
				int scoreId = hits[i].doc;
				//now get reference to document
				document = searcher.doc(scoreId);
				//out.println("<TR></TR><TR></TR><TR></TR>");
				
				String fileid = document.getField("content_id").stringValue();
				String itemp = fileid.substring(0,fileid.lastIndexOf("."));
				String ipath = "DBServer/"+itemp+".jpg";
				%>				
				<tr>
					<td><img src="<%=ipath %>" width="80" height="80" align="top"/></td>
					<td><%=document.getField("title").stringValue()%></td>
					<td><%=document.getField("cat").stringValue()%></td>
					<td><%=document.getField("lang").stringValue()%></td>
					<td><%=document.getField("u_name").stringValue()%></td>
					<td>
						<form action="FileDownload" method="post">
							<input type="hidden" name="fileid" value="<%=document.getField("content_id").stringValue()%>"/>
							<input type="submit" value="Download"/>
						</form>
					</td>
					<td>
						<form action="UsertoUserSubcription" method="post">
							<input type="hidden" name="uploader" value="<%=document.getField("u_name").stringValue()%>"/>
							<input type="hidden" name="follower" value="<%=username%>"/>
							<input type="submit" value="Subs To User"/>
						</form>
					</td>
				</tr>				
			<%			
				}
					}else{
				out.println("<h2 align='center'>No records found</h2>");
					} 		
			}catch(Exception e){
				e.printStackTrace();
			}finally{
			if(reader!=null)
				reader.close();
			}
			%>
    </table>
								
								
							</div>
							<br class="clear" />
						</div>
						
						<!-- end -->
					</div>					
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
									<tr><td><br/></td></tr>
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
