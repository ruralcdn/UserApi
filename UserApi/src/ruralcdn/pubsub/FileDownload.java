package ruralcdn.pubsub;

import java.io.IOException;
import java.rmi.registry.LocateRegistry;
import java.rmi.registry.Registry;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import newNetwork.Connection;

import prototype.user.IUser;

public class FileDownload extends HttpServlet {	
	
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
		String choice = req.getParameter("choice");
		int ch = 2 ;
		System.out.println("value of download choice: "+ch);
		System.out.println(ufile);
		String urequest = "Your Request Has Been Send";
		boolean flag = false;
		int num = 0;
		String query = null;
		
		try {	
			  if(choice != null){	
				  ch = Integer.parseInt(choice);
			  }
	          String connectionURL = "jdbc:mysql://localhost:3306/ruralcdn";         
	          java.sql.Connection connection = null;         
	          Statement statement = null;
	          ResultSet rs = null;          
	          Class.forName("com.mysql.jdbc.Driver").newInstance();       
	          connection = DriverManager.getConnection(connectionURL, "root", "abc123");          
	          statement = connection.createStatement();
	          
	          String QueryString = "SELECT dbvalue from dbsync where dbkey = '"+ufile+"-demand'";
	          
	          rs = statement.executeQuery(QueryString);
	          
	          if(rs.next()){
	        	  flag = true;
	        	  num = Integer.parseInt(rs.getString(1));
	          }
	          
	          if(flag){
	        	  	num=num+1;
	        	  	String numStr = Integer.toString(num);
	        	   	query = "update dbsync set dbvalue = '"+numStr+"' where dbkey = '"+ufile+"-demand'";
	  	        	
	          }
	          List<String> sqlList = new ArrayList<String>();
	          sqlList.add(query);
	          stub = stubRMI("localhost");
	          stub.updateLog(sqlList);
	          rs.close();
			  statement.close();
			  connection.close();
		} catch (Exception ex) {
			ex.printStackTrace();			   
		}
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
