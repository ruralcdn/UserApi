function emailCheck(str) {

	var at="@";
	var dot=".";
	var lat=str.indexOf(at);
	var lstr=str.length;
	var ldot=str.indexOf(dot);
    
	if (str.indexOf(at)==-1 || str.indexOf(at)==0 ||str.indexOf(at)==lstr){
	   window.alert("Invalid E-mail ID");
	   return false;
	}
    if (str.indexOf(dot)==-1 || str.indexOf(dot)==0 ||str.indexOf(dot)==lstr){
	    window.alert("Invalid E-mail ID");
	    return false;
	}
    if (str.indexOf(at,(lat+1))!=-1){
	    window.alert("Invalid E-mail ID");
	    return false;
	 }
     if (str.substring(lat-1,lat)==dot ||str.substring(lat+1,lat+2)==dot){
	    alert("Invalid E-mail ID");
	    return false;
	 }
     if (str.indexOf(dot,(lat+2))==-1){
	    window.alert("Invalid E-mail ID");
	    return false;
	 }
	 if (str.indexOf(" ")!=-1){
	    window.alert("Invalid E-mail ID");
	    return false;
	 }
		 return true;					
}
function validateform()
{	
if(document.onlineform.id.value=="") {
window.alert ("Please Enter a Username!");
return false;
}
if (document.onlineform.pwd.value=="") { 
window.alert ("Please Enter your Password!");
return false;
}
if (document.onlineform.cpwd.value=="") { 
window.alert ("Please Enter your Confirm Password!");
return false;
}
if (document.onlineform.cpwd.value != document.onlineform.pwd.value) { 
window.alert ("Confirm password don't match with password!");
return false;
}
if(document.onlineform.fullname.value=="") {
	window.alert ("Please Enter a Your Name!");
	return false;
}
var emailID=document.onlineform.email;
if (emailID.value=="") { 
	window.alert ("Please Enter your Email Id");
	return false;
}
if (emailCheck(emailID.value)==false){
	emailID.value="";
	emailID.focus();
	return false;
}
if (document.onlineform.conno.value=="") { 
	window.alert ("Please Enter Contact No!");
	return false;
}
if (document.onlineform.conno.value.length !=10) { 
	window.alert ("Please Enter 10 digit for your contact no");
	return false;
}
if (document.onlineform.address.value=="") { 
window.alert ("Please Enter your Address!");
return false;
}
if (document.onlineform.city.value=="") { 
window.alert ("You have not entered your City!");
return false;
}
return true;
}
function showData(){ 
	var value=document.getElementById("id").value;

	xmlHttp=GetXmlHttpObject()
	var url="CheckUserId.jsp";
	url=url+"?id="+value;
	xmlHttp.onreadystatechange=stateChanged 
	xmlHttp.open("GET",url,true)
	xmlHttp.send(null)
	}
	function stateChanged() { 
	if(xmlHttp.readyState==4 || xmlHttp.readyState=="complete"){ 
	    var showdata = xmlHttp.responseText; 
	    alert(showdata);
	} 
	}
	function GetXmlHttpObject(){
	var xmlHttp=null;
	try {
	  xmlHttp=new XMLHttpRequest();
	 }
	catch (e) {
	 try  {
	  xmlHttp=new ActiveXObject("Msxml2.XMLHTTP");
	  }
	 catch (e)  {
	  xmlHttp=new ActiveXObject("Microsoft.XMLHTTP");
	  }
	 }
	return xmlHttp;
	}