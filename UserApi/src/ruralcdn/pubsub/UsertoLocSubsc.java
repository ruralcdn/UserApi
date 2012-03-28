package ruralcdn.pubsub;

import java.io.IOException;
import java.io.PrintWriter;
import java.rmi.registry.LocateRegistry;
import java.rmi.registry.Registry;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import prototype.user.IUser;

public class UsertoLocSubsc extends HttpServlet {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	IUser stub ;

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		String connectionURL = "jdbc:mysql://localhost:3306/ruralcdn";
	    Connection connection=null;   
	    
	    HttpSession session = req.getSession(true);
	    resp.setContentType("text/html");
	    PrintWriter out = resp.getWriter();
	    
	    String follower = req.getParameter("follower");
	    String location = req.getParameter("location");
	    String choice = req.getParameter("choice");
	    session.setAttribute("choice", choice);
	    String Subscription = null;	    
	    
	    try {        
	    	boolean flag = false;         
			Statement statement = null;
			ResultSet rs = null;			
	    	Class.forName("com.mysql.jdbc.Driver").newInstance();       
		    connection = DriverManager.getConnection(connectionURL, "root", "abc123");          
		    statement = connection.createStatement();
		   
		    String sql;	       
		    String QueryString = "SELECT dbkey from dbsync where dbkey like '%"+follower+"%' and dbvalue = '"+location+"'";
		    rs = statement.executeQuery(QueryString);		    
		    while(rs.next()){	    	  
		    	flag = true;		    				    		


		    }
		    if(flag == true){
		    	Subscription ="You already subscribe with this location";		    	
		    	session.setAttribute("subscription", Subscription);
		    	resp.sendRedirect("AfterSubscription.jsp");
		    	
		    }
		    else{			    
		    	   sql = "insert into dbsync values('"+follower+"-subcloc','"+location+"')";
		    	   List<String> sqlList = new ArrayList<String>();
				   sqlList.add(sql);
		    	  try {
						stub = stubRMI("localhost");
		    	  } 
				  catch (Exception e) {
						e.printStackTrace();
				  }
					boolean s = stub.updateLog(sqlList);
								        
			       if(s) {
			    	 Subscription = "Your Subscription is successful";
			    	 session.setAttribute("subscription", Subscription);
			         resp.sendRedirect("AfterSubscription.jsp");
			         System.out.println("subscription is complete");
			        }
			       else {
			    	   Subscription = "Subscription is uncessful please try again";
			    	   session.setAttribute("subscription", Subscription);
			    	   resp.sendRedirect("AfterSubscription.jsp");
			    	   System.out.println("unsucessfull to Subscription.");
			         }
		       
			       session.setAttribute("location", location);		       	    
			       
	       }       
	      
		    }
	      catch(ClassNotFoundException e){
	        e.printStackTrace();
	      }
	      catch(SQLException e){
	        e.printStackTrace();
	    	  //out.println("SQLException caught: " + e.getMessage());
	      }
	      catch (Exception e){
	        e.printStackTrace();
	    	  //out.println(e);
	      }
	      finally {
	        
	        try {
	          if (connection != null) connection.close();
	        }
	        catch (SQLException ignored){
	          out.println(ignored);
	        }
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
