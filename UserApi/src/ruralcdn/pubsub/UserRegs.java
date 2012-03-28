package ruralcdn.pubsub;

import java.io.*;
import java.rmi.registry.LocateRegistry;
import java.rmi.registry.Registry;
import java.util.HashMap;
import java.util.Map;
import javax.servlet.*;
import javax.servlet.http.*;
import prototype.user.IUser;

public class UserRegs extends HttpServlet{
 
	IUser stub ;
	private static final long serialVersionUID = 1L;
public void init(ServletConfig config) throws ServletException{
    super.init(config);
  }
 
public void doGet(HttpServletRequest req, HttpServletResponse res) 
                                 throws ServletException, IOException{
	  
	boolean flag = false;
    Map<String, String> userInfo = new HashMap<String, String>();
    
    res.setContentType("text/html");    
    //get the variables entered in the form
    
    String s1 = req.getParameter("id");
    String s2 = req.getParameter("pwd");
    String s3 = req.getParameter("fullname");
    String s4 = req.getParameter("email");
    String s5 = req.getParameter("conno");
    String s6 = req.getParameter("address");
    String s7 = req.getParameter("city");
    String s8 = req.getParameter("state"); 
    String host = new String("localhost");
    
    userInfo.put("ulogname",s1 );
    userInfo.put("upwd",s2 );
    userInfo.put("ufullname",s3 );
    userInfo.put("uemail",s4 );
    userInfo.put("ucontct",s5 );
    userInfo.put("uaddres",s6 );
    userInfo.put("ucity",s7 );
    userInfo.put("ustate",s8 );
    
    try {
		stub = stubRMI(host);
		System.out.println("value of stub: "+stub);
		flag = stub.registration(userInfo);
	} catch(Exception e){
		e.printStackTrace();
	}   
	if(flag == true){
		
		System.out.println("registration sucessfull");
		res.sendRedirect("AfterRegisMssg.jsp");
	}
	else{
		System.out.println("user allready exits");
	}		
} 
public static IUser stubRMI(String host)throws Exception{
	Registry registry = LocateRegistry.getRegistry(host);
	IUser stub = null; 
	System.out.println("Finding UserDaemon.");
	boolean bound = false;
	while(!bound)
	{
		try
		{
	   		stub = (IUser) registry.lookup("userdaemon");
	   		bound = true;
	   		System.out.println("Stub is returned");
	   	}
	   	catch(Exception ex)
	   	{
	   		Thread.sleep(1000);
	   	}
	  }
	  System.out.println("UserDaemon Found.");
	  return stub ;
}
}

  