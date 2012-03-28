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

public class UsertoCatSubsc extends HttpServlet {

	
	private static final long serialVersionUID = 1L;
	IUser stub ;
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		 String Subscription = null;	  
		
		String connectionURL = "jdbc:mysql://localhost:3306/ruralcdn";
	    Connection connection=null;   
	    
	    HttpSession session = req.getSession(true);
	    resp.setContentType("text/html");
	    PrintWriter out = resp.getWriter();
	    boolean flag = false;
	    boolean flag1 = false;
	    
	    String follower = req.getParameter("follower");
	    String category = req.getParameter("category");
	    String choice = req.getParameter("choice");
	    session.setAttribute("choice", choice);
	    
	    if((category.length() == 0)||category.equals(null)||(category == null)||(category.equals("null"))){    	
	    	flag1 = true;
	    	flag = true;	    		    	
	    }	    
	    try {        
	    	        
			Statement statement = null;
			ResultSet rs = null;			
	    	Class.forName("com.mysql.jdbc.Driver").newInstance();       
		    connection = DriverManager.getConnection(connectionURL, "root", "abc123");          
		    statement = connection.createStatement();
		   
		    String sql;	       
		    //String QueryString = "SELECT category from usertocat where u_name = '"+follower+"'";
		    String QueryString = "SELECT dbkey from dbsync where dbkey like '%"+follower+"%' and dbvalue = '"+category+"'";
		    rs = statement.executeQuery(QueryString);		    
		    while(rs.next()){	    	  
		    	//if(rs.getString(1).equals(category)){
		    		flag = true;		    				    		
		    	//}
		    	
		    }
		    if(flag == true){
		    	if(flag1){
		    		Subscription ="No Video avaliable in this category";		    	
			    	session.setAttribute("subscription", Subscription);	    	
			    	resp.sendRedirect("AfterSubscription.jsp");
		    	}else{
			    	Subscription ="You already subscribe with this category";		    	
			    	session.setAttribute("subscription", Subscription);
			    	resp.sendRedirect("AfterSubscription.jsp");
		    	}
		    	
		    }
		    else{			    
		    	sql = "insert into dbsync values('"+follower+"-subccat','"+category+"')";
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

		    	session.setAttribute("category", category);		       	    
		    	
		    }       
	      
		    }
	      catch(ClassNotFoundException e){
	        e.printStackTrace();
	      }
	      catch(SQLException e){
	        e.printStackTrace();
	      }
	      catch (Exception e){
	        e.printStackTrace();
	    	 
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
