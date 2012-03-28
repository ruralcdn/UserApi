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

public class LogoutUser extends HttpServlet {
	
	private static final long serialVersionUID = 1L;
	IUser stub ;
	
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		HttpSession session = req.getSession();
		String name = (String)session.getAttribute("ulogname");
		String host = "localhost";
		//HttpSession session = req.getSession(true);
		//req.getSession().invalidate();
		//String username=(String) session.getAttribute("login");
		
		//session.setAttribute("login",0);
		//session.setAttribute("ulogname",null);
		try {
			stub = stubRMI(host);
		} catch (Exception e) {
			
		}
		stub.logout(name);
		session.invalidate();		
		session = req.getSession(false);		 
		resp.getWriter().println("Session : " + session);
		resp.sendRedirect("index.jsp");
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
