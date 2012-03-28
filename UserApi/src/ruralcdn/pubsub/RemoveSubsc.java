package ruralcdn.pubsub;

import java.io.IOException;
import java.io.PrintWriter;
import java.rmi.registry.LocateRegistry;
import java.rmi.registry.Registry;
import java.sql.Connection;
import java.sql.DriverManager;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import prototype.user.IUser;

@SuppressWarnings("serial")
public class RemoveSubsc extends HttpServlet {
	
	@SuppressWarnings("unused")
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		
		HttpSession session = req.getSession(true);
	    resp.setContentType("text/html");
	    PrintWriter out = resp.getWriter();
	    
	    String username = req.getParameter("username");
	    String category = req.getParameter("category");
	    String location = req.getParameter("location");
	    String choice = req.getParameter("choice");
	    session.setAttribute("choice", choice);
	    String activeuser = req.getParameter("activeuser");
	    int num = Integer.parseInt(choice);
	    int i=0;
	    IUser stub ;
	    String connectionURL = "jdbc:mysql://localhost/ruralcdn";
	    Connection connection;
	    try{
	        Class.forName("org.gjt.mm.mysql.Driver");
	        connection = DriverManager.getConnection(connectionURL, "root", "abc123");
	        boolean flag = false ;
	        String query = "";
	        if(num==1)
	        	query = "delete from dbsync where dbkey like '%"+activeuser+"%' and dbvalue ='"+username+"'";
	        else if(num==2)
		       	query = "delete from dbsync where dbkey like '%"+activeuser+"%' and dbvalue ='"+category+"'";
		     else
		        query = "delete from dbsync where dbkey like '%"+activeuser+"%' and dbvalue ='"+location+"'";
	        
	        List<String> sqlList = new ArrayList<String>();
        	sqlList.add(query);
        	stub = stubRMI("localhost");
        	stub.updateLog(sqlList);
        	resp.sendRedirect("RemoveSubs.jsp");
        	/*flag = stub.unsubscribe();
	        if (flag){
	          System.out.println("row is deleted");
	          resp.sendRedirect("UserSubscription.jsp");
	        }
	        else{
	          System.out.println("no row has been deleted");
	        }*/
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
