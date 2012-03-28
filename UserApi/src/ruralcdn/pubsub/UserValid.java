package ruralcdn.pubsub;

import java.io.IOException;
import java.rmi.registry.LocateRegistry;
import java.rmi.registry.Registry;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


import prototype.user.IUser;


public class UserValid extends HttpServlet {


	private static final long serialVersionUID = 1L;
	IUser stub ;
	public static String name ;
	public static String userLoc ;
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
	throws ServletException, IOException {


		String userAuth = null;		
		resp.setContentType("text/html");		
		HttpSession session = req.getSession(true);
		String host = new String("localhost");		
		name = req.getParameter("username");		
		String password = req.getParameter("password");
		/*check whether admin or user login*/
		
		if(name.equals("aseth")&& password.equals("junoon")){
			
			resp.sendRedirect("WelcomeAdmin.jsp");
			System.out.println("welcome aseth");
			
			
		}else{	
			
			try {
				stub = stubRMI(host);
				System.out.println("Inside UserValid");
				userAuth = stub.login(name,password);
			} 
			catch (Exception e) {
				System.out.println("error in program 2");
			}
			/*add a condition to prevent to access this page*/

			if(!(userAuth == null)){
				session.setAttribute("ulogname", name);
				resp.sendRedirect("WelcomeUser.jsp");
				userLoc = userAuth ;
				try{
					IndexBuilder search = new IndexBuilder();
					search.buildIndex();
				}catch(Exception e){
					System.out.println("error in program 3");
				}
			}
			else{
				resp.sendRedirect("NotWelcomeUser.jsp");
			}
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