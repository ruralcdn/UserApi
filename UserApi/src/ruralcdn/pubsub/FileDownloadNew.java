package ruralcdn.pubsub;

import java.io.IOException;
import java.rmi.registry.LocateRegistry;
import java.rmi.registry.Registry;

import java.sql.Statement;


import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import newNetwork.Connection;
import prototype.user.IUser;

public class FileDownloadNew extends HttpServlet {
	
	private static final long serialVersionUID = 1L;
	IUser stub ;
	java.sql.Connection con ;
	Statement stat ;
	String name = UserValid.name;

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		
		HttpSession session = req.getSession(true);		
		String username=(String) session.getAttribute("ulogname");
		String ufile = req.getParameter("fileid");
		
		int ch = 2 ;		
		String urequest = "Your Request Has Been Send";
				
		//String fileExt = ufile.substring(ufile.lastIndexOf("."), ufile.length());
		ufile  = ufile.substring(0, ufile.lastIndexOf("."))+".mp4";
		
		try {						
			stub = stubRMI("localhost");
			if(ch == 2)
				stub.find(ufile,Connection.Type.USB,1,username);
			else if(ch == 3)
				stub.find(ufile,Connection.Type.DSL,1,username);
			System.out.println("Request for download has been sent");						
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		if(username == null){			
			session.setAttribute("urequest",urequest);
			String redirectURL ="FileRequest.jsp";
			resp.sendRedirect(redirectURL);
		}
		else{
			session.setAttribute("urequest",urequest);
			String redirectURL ="FileRequestAL.jsp";
			resp.sendRedirect(redirectURL);
		}
		
		System.out.println(ufile);
		
	}
	public static IUser stubRMI(String host)throws Exception
	   {
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
