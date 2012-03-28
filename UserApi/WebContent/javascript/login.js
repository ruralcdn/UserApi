function validateform()
{
if(document.onlineform.username.value=="") {
window.alert ("Please Enter Your Username!");
return false;
}	
if(document.onlineform.password.value=="") {
window.alert ("Please Enter Your Password!");
return false;
}
}