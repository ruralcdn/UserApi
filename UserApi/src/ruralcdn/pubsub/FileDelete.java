package ruralcdn.pubsub;

import java.util.*;
import java.io.IOException;
import java.io.PrintWriter;
import java.rmi.registry.LocateRegistry;
import java.rmi.registry.Registry;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.Statement;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import prototype.user.IUser;

public class FileDelete extends HttpServlet {
	
	private static final long serialVersionUID = 1L;
	

	@SuppressWarnings("unused")
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		String FileId = req.getParameter("fileid");
		System.out.println("Hello ur in delete");
		HttpSession session = req.getSession(true);
		String username = (String) session.getAttribute("ulogname");
		resp.setContentType("text/html");
	    PrintWriter out = resp.getWriter();
	    String connectionURL = "jdbc:mysql://localhost/ruralcdn";
	    Connection connection;
	    try{
	        Class.forName("org.gjt.mm.mysql.Driver");
	        connection = DriverManager.getConnection(connectionURL, "root", "abc123");
	        Statement pst = connection.createStatement();
	        String query1 = "delete from dbsync where dbkey like '%"+FileId+"%'";
	        List<String> queryList = new ArrayList<String>();
	        queryList.add(query1);
	        IUser stub = null ;
	        try {
				stub = stubRMI("localhost");
			} 
			catch (Exception e) {
				e.printStackTrace();
			}		
			stub.updateLog(queryList);
			stub.delete(FileId,username);
	        resp.sendRedirect("UserStatus.jsp");
	        
	      }
	      catch(Exception e){
	        out.println("The exception is " + e);
	      }
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
