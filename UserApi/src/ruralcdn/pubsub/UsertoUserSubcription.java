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

public class UsertoUserSubcription extends HttpServlet {
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
	    String uploader = req.getParameter("uploader");
	    String choice = req.getParameter("choice");
	    session.setAttribute("choice", choice);
	    String Subscription = null;	    
	    
	    try {        
	    	        
			Statement statement = null;
			ResultSet rs = null;			
	    	Class.forName("com.mysql.jdbc.Driver").newInstance();       
		    connection = DriverManager.getConnection(connectionURL, "root", "abc123");          
		    statement = connection.createStatement();
		   
		    String sql;	       
		    //String QueryString = "SELECT sub_name from usersubc where u_name = '"+follower+"'";
		    //String QueryString = "SELECT dbkey from dbsync where dbkey like '%"+uploader+"%' and dbvalue = '"+follower+"'";
		    String QueryString = "SELECT dbkey from dbsync where dbkey like '%"+follower+"%' and dbvalue = '"+uploader+"'";
		    rs = statement.executeQuery(QueryString);
		    boolean flag = false; 
		    if(rs.next()){	    	  
		    	//if(rs.getString(1).equals(uploader)){
		    		flag = true;		    				    		
		    	//}
		    	
		    }
		    if(flag == true){
		    	Subscription ="You already subscribe with this user";		    	
		    	session.setAttribute("subscription", Subscription);
		    	resp.sendRedirect("AfterSubscription.jsp");
		    	
		    }
		    else{
		    	if(follower.equals(uploader)){		       
		    		Subscription = "You cant Subscribe yourself";
		    		session.setAttribute("subscription", Subscription);
		    		resp.sendRedirect("AfterSubscription.jsp");
		    	}
		    	else{
			    	
		    	   //sql = "insert into usersubc(u_name,sub_name) values ('"+follower+"','"+uploader+"')";
				   sql = "insert into dbsync values('"+follower+"-subcuser','"+uploader+"')";
		    	   //PreparedStatement pst = connection.prepareStatement(sql);   
		    	   List<String> sqlList = new ArrayList<String>();
				   sqlList.add(sql);
		    	   try {
						stub = stubRMI("localhost");
					} 
					catch (Exception e) {
						e.printStackTrace();
					}
					boolean s = stub.updateLog(sqlList);
					//stub.subscribe();
			       //pst.setString(1, follower);
			      // pst.setString(2, uploader);        
			      // int s = pst.executeUpdate();       
			        
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
		       
			       session.setAttribute("uploader", uploader);		       	    
			      // pst.close();
		    	}       
		    }
		  }
	      catch(ClassNotFoundException e){
	        e.printStackTrace();
	    	  //out.println("Couldn't load database driver: " + e.getMessage());
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
