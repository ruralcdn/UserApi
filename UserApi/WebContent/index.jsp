<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">

<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>

<html xmlns="http://www.w3.org/1999/xhtml">

<head>
<meta name="keywords" content="" />
<meta name="description" content="" />
<meta http-equiv="content-type" content="text/html; charset=utf-8" />
<title>Rural CDN Network</title>

<link href="styling1.css" rel="stylesheet" type="text/css" media="screen" />
<link href="style.css" rel="stylesheet" type="text/css" media="screen" />
<link href="button.css" rel="stylesheet" type="text/css" media="screen" />

<script type="text/javascript" src="jquery/jquery-1.4.2.min.js"></script>
<script type="text/javascript" src="jquery/jquery.gallerax-0.2.js"></script>
<style type="text/css">
@import "gallery.css";
</style>
<script type="text/javascript">
window.history.forward(1);
function setmessagecat() {
	var confirmmessage = "Please login to see video in this category";	
	alert(confirmmessage);
}
function setmessageuser() {
	var confirmmessage = "Please login to see video uploaded by this user";	
	alert(confirmmessage);
}
</script>
<script type="text/javascript">
$(document).ready(function() {
	$(".paging").show();
	$(".paging a:first").addClass("active");

	//Get size of the image, how many images there are, then determin the size of the image reel.
	var imageWidth = $(".window").width();
	var imageSum = $(".image_reel img").size();
	var imageReelWidth = imageWidth * imageSum;

	//Adjust the image reel to its new size
	$(".image_reel").css({'width' : imageReelWidth});
	//Paging  and Slider Function
	rotate = function(){
	    var triggerID = $active.attr("rel")-1; //Get number of times to slide
	    var image_reelPosition = triggerID * imageWidth; //Determines the distance the image reel needs to slide

	    $(".paging a").removeClass('active'); //Remove all active class
	    $active.addClass('active'); //Add active class (the $active is declared in the rotateSwitch function)

	    //Slider Animation
	    $(".image_reel").animate({
	        left: -image_reelPosition
	    }, 300 );

	}; 

	//Rotation  and Timing Event
	rotateSwitch = function(){
	    play = setInterval(function(){ //Set timer - this will repeat itself every 7 seconds
	        $active = $('.paging a.active').next(); //Move to the next paging
	        if ( $active.length === 0) { //If paging reaches the end...
	            $active = $('.paging a:first'); //go back to first
	        }
	        rotate(); //Trigger the paging and slider function
	    }, 5000); //Timer speed in milliseconds (7 seconds)
	};

	rotateSwitch(); //Run function on launch
	//On Hover
	$(".image_reel a").hover(function() {
	    clearInterval(play); //Stop the rotation
	}, function() {
	    rotateSwitch(); //Resume rotation timer
	});	

	//On Click
	$(".paging a").click(function() {
	    $active = $(this); //Activate the clicked paging
	    //Reset Timer
	    clearInterval(play); //Stop the rotation
	    rotate(); //Trigger rotation immediately
	    rotateSwitch(); // Resume rotation timer
	    return false; //Prevent browser jump to link anchor
	});
});
</script>
<script type="text/javascript" src="javascript/login.js"></script>

</head>

<body onunload="javascript:history.go(1)">
<div id="menuontop">
</div>
<div id="wrapper">
	<div id="header">
		<div id="logo">
			<div class="shadow">
			<h1><a href="#">Welcome to rural cdn network</a></h1>
			</div>			
		</div>
	</div>	
	<!-- end #header -->
	<div id="menu">
		<ul >
			<li class="current_page_item"><a href="index.jsp">Home</a></li>
			<li><a href="UserRegistration.jsp">Registration</a></li>	
			<li class="hlogin"><a href="index.jsp">Please login to access website contain</a></li>			
		</ul>
	</div>
	<!-- end #menu -->
	<div id="page">
		<div id="page-bgtop">
			<div id="page-bgbtm">
				<div id="content">
					<div id="gallery-wrapper">											
						<div class="main_view">
						    <div class="window">
						        <div class="image_reel">
						            <a href="#"><img src="images/img04.jpg" width="650" height="500" alt="" /></a>
						            <a href="#"><img src="images/img05.jpg" width="650" height="500" alt="" /></a>
						            <a href="#"><img src="images/img06.jpg" width="650" height="500" alt="" /></a>
						            <a href="#"><img src="images/img07.jpg" width="650" height="500" alt="" /></a>
						            <a href="#"><img src="images/img004.jpg" width="650" height="500" alt="" /></a>
						        </div>
						    </div>
						    <div class="paging">
						        <a href="#" rel="1">1</a>
						        <a href="#" rel="2">2</a>
						        <a href="#" rel="3">3</a>
						        <a href="#" rel="4">4</a>
						    </div>
						</div>											
					</div>
					<div>
					<br/>
					</div>					
					<div class="post">
						<h2 class="title"><a href="#">Recent research in agriculture</a></h2>
						<p class="meta"><span class="date"><%= new java.util.Date() %></span><span class="posted">Posted by <a href="#">Amit dubey</a></span></p>
						<div style="clear: both;">&nbsp;</div>
						<div class="entry">	
						Studies by U.S. Department of Agriculture (USDA) scientists have confirmed that the presence of Escherichia coli pathogens in
								surface waters could result from the pathogen's ability to survive
								for months in underwater sediments. Most E. coli strains don't cause
								illness, but they are indicator organisms used by water quality 
								managers to estimate fecal contamination.						
						</div>
					</div>					
					<div class="post">
						<h2 class="title"><a href="#">Watch New Episode OF Discussion</a></h2>
						<p class="meta"><span class="date">Season 1</span><span class="posted">Posted by <a href="#">Quamar</a></span></p>
						<div style="clear: both;">&nbsp;</div>
						<div class="entry">
						An estimated 70 percent of the world's poor rely on agriculture for all or some of their 
						household income. Farmers face a number of risks to their livelihoods, including 
						unpredictable weather and crop price variation. These risks may also affect how they 
						choose to borrow and invest to improve their business. The IPA projects in this sector 
						seek to find out how we can help poor farmers in the developing world increase 
						productivity and deal with the risks inherent in farming						
						</div>
					</div>
					<div style="clear: both;">&nbsp;</div>
				</div>
				<!-- end #content -->
				<div id="sidebar">
				<%
					int num = 0;
					int l =0;
					int j=0;
					String s1 = "form"; 
					String s2 = null;
					String name= null;
					String s3 = "forms";
					String s4 = null;
					String add = null;					
					String itemp = "DBServer/";;
					String ipath = null;
					String tempid = null;
					String conId = null;
					String title = null;
					String[] category = new String[4];
					String[] user = new String[4];
					String[] fileid = new String[4];
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
						<form action="UserValid"  name="onlineform" onSubmit="return validateform( this.form )" method="post" align="center">
							<table bgcolor="#D8D8D8" width="280" bordercolor="red">			
								<tr><td>Please enter your Username & Password</td></tr>
								<tr><td><b>Username:</b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="text" name="username" id="search-text" value="" /></td></tr>
								<tr><td><b>Password:</b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="password" name="password" id="search-text" value="" /></td></tr>
								<tr align="right"><td align="right"><input type="submit" id="search-submit" value="Login" align="right"/></td></tr>
							</table>
						</form>
						<div style="clear: both;">&nbsp;</div>
					</li>	
					<li>						
						<% 					   
							String QueryString1 = "SELECT dbkey from dbsync where dbkey like '%-demand%'order by dbvalue desc";
							rs = statement.executeQuery(QueryString1);
						%>
						<h2>Popular Videos</h2>							
						<ul>
							<%	int i =0;
							    for(i=0;i<2&&rs.next();i++) {							    	
							    	String file = rs.getString(1);
							    	fileid[i] = file.substring(0,file.indexOf("-"));
								}
								l=0;								
								while(l < i){
									s4 = Integer.toString(l);
								    add = s3.concat(s4);						   		
							   		String QueryString2 = "SELECT dbvalue from dbsync where dbkey = '"+fileid[l]+"-title'";
							  		rs = statement.executeQuery(QueryString2);
							  		try{						  		
										tempid = fileid[l];
										conId = tempid.substring(0,tempid.lastIndexOf("."));
										ipath = itemp+conId+"."+"jpg";
										System.out.println("i path in index"+ipath);
							  		}catch(Exception e){
							  			System.out.println("problam in loop 1");						  			
							  		}
									while(rs.next()){ 
							%>								
							<li>
								<form name="<%=add %>" action="FileDownload" method="post">								
								 <a href="" onclick="document.<%=add %>.submit()">
										<img src="<%=ipath %>" width="80" height="80" alt="image not found" align="top"/>
									</a>
									<b>&nbsp;<%=rs.getString(1)%></b>
									<input type="hidden" name="fileid" value="<%=fileid[l] %>"/>
								</form>	
							</li>
							<%} %>	
							<%l++;} %>																
						</ul>
					</li>
					<li>
						<%					   
							String QueryString3 = "SELECT dbvalue,count(*) as c from dbsync where dbkey like '%-cat%' group by dbvalue order by c desc";
							rs = statement.executeQuery(QueryString3);
						%>						
						<h2>Popular Categories</h2>
						<ul>							
							<%	
							for(j=0;j<=1&&rs.next();j++){
						    	String temp = rs.getString(1);							    	
						    	category[j] =temp;
							}								
							i = 0;
						 	while((i<j)&&(i<2)){
								String QueryString24 = "SELECT dbkey from dbsync where dbkey like '%-cat%' and dbvalue = '"+category[i]+"'";
								rs = statement.executeQuery(QueryString24);
								while(rs.next()){
									title = rs.getString(1);
								}									
								try{
									tempid = title.substring(0,title.indexOf("-"));
									conId = tempid.substring(0,tempid.lastIndexOf("."));
									ipath = itemp+conId+".jpg";				  		
								}catch(Exception e){
									System.out.println("problam in loop 2");
								}
								s4 = Integer.toString(i);
							    add = "unique"+s4;									
							%>
							<li>
								<form name="<%=add %>" action="FileDownload" method="post">
									<a href="#"  onclick="document.unique.submit()">										
										<img src="<%=ipath%>" width="80" height="80" alt="image not found" align="top" />
										<input type="hidden" name="fileid" value="<%=tempid%>"/>										
									</a>
									<b>&nbsp;<%=category[i] %></b>
								</form>										
							</li>
							<%i++;}%>
						</ul>
					</li>
					<li>						
						<%       
						    String QueryString4 = "SELECT * from dbsync where dbkey like '%-title' order by dbkey desc limit 5";
							rs = statement.executeQuery(QueryString4);
						%>						
						<h2>Latest Uploaded Videos</h2>
						<ul>
							<%
								i=0;
								while (i<2&&rs.next()) {
									num = num + 1;
									s2 = Integer.toString(num);
									name = s1.concat(s2);
									String cid = rs.getString(1);
									String cidTitle = cid.substring(0,cid.indexOf("-"));
									conId = cidTitle.substring(0,cidTitle.lastIndexOf("."));
									ipath = itemp+conId+".jpg";
							%>								
							<li>
								<form name="<%=name %>" action="FileDownload" method="post">																				
									<a href="#" id="1" onclick="document.<%=name %>.submit()" >
										<img src="<%=ipath%>" width="80" height="80" alt="image not found" align="top" />
									</a>
									<b>&nbsp;<%=rs.getString(2) %></b>
									<input type="hidden" name="fileid" value="<%=cidTitle%>"/>									
								</form>									
							</li>
							<%i++;}%>																	
						</ul>
					</li>
					<li>
						<%           
						   	String QueryString5 = "SELECT dbvalue,count(*) as c from dbsync where dbkey like '%-user%' group by dbvalue order by c desc";
						   	rs = statement.executeQuery(QueryString5);
						%>
						<h2>Most Active User</h2>
						<ul>
							<%
							    for(j=0;j<2&&rs.next();j++){
							    	String temp = rs.getString(1);
							    	user[j] = temp;							    	
								}
								i = 0;
								while(i<j){
									s4 = Integer.toString(i);
								    add = "uniquenot"+s4;
									String QueryString25 = "SELECT dbkey from dbsync where dbkey like '%-user%' and dbvalue = '"+user[i]+"'";
									rs = statement.executeQuery(QueryString25);
									System.out.println("problam in loop 3");
									if(rs.next()){
										title = rs.getString(1);							   	
										try{
											tempid = title.substring(0,title.indexOf("-"));
											conId = tempid.substring(0,tempid.lastIndexOf("."));
											ipath = itemp+conId+".jpg";						  		
										}catch(Exception e){
											System.out.println("problam in loop 2");
										}							   	
							%>	
										<li>
											<form name="<%=add %>" action="FileDownload" method="post">
												<a href="#"  onclick="document.uniquenot.submit()">
													<img src="<%=ipath%>" width="80" height="80" alt="image not found" align="top" />
												</a>
												<input type="hidden" name="fileid" value="<%=tempid%>"/>
												<b>&nbsp;<%=user[i] %></b>
											</form>
										</li>
									<%}%>
								<%i++;}%>
						</ul>
					</li>
				</ul>
				<%			
					rs.close();						
					statement.close();
					connection.close();
					} catch (Exception ex) {				
						System.out.println("Exception in index.jsp");				   
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
	<p><strong>Copyright(c)2011 RuralCdn All rights reserved. Design by <a href="http://www.cse.iitd.ernet.in/act4d/">ACT4D,IIT Delhi</a>.</strong></p>
</div>
<!-- end #footer -->
</body>
</html>
