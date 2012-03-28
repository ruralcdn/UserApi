package ruralcdn.pubsub;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.nio.channels.FileChannel;
import java.rmi.registry.LocateRegistry;
import java.rmi.registry.Registry;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
/*import com.xuggle.xuggler.ICodec;
import com.xuggle.xuggler.IContainer;
import com.xuggle.xuggler.IStream;
import com.xuggle.xuggler.IStreamCoder;*/

import newNetwork.Connection;
import prototype.user.IUser;

@SuppressWarnings("unused")
public class UploadFile extends HttpServlet {

	private static final long serialVersionUID = 1L;
	IUser stub ;
	int num = 1;
	//BlockingQueue<String> insMap = LocalUpdate.insMap;
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {		

		HttpSession session = req.getSession(true);	    
		resp.setContentType("text/html");   

		String path = req.getParameter("filename");	
		String name = (String) session.getAttribute("ulogname");

		//select choice for upload by usb or internet

		String choice = req.getParameter("choice");	
		int ch = Integer.parseInt(choice);

		//System.out.println("choice"+ ch);

		File file = new File("path");		
		String fileName = "" ;
		int lastIndex;   

		lastIndex = path.lastIndexOf("\\");	       
		fileName = path.substring(lastIndex + 1, path.length());

		//System.out.println("filename : "+ fileName);

		String connectionURL = "jdbc:mysql://localhost:3306/ruralcdn";   
		java.sql.Connection con=null ; 


		//get the variables entered in the form     

		String s2 = req.getParameter("title");
		String s3 = req.getParameter("language");
		String s4 = req.getParameter("cat");
		String s5 = req.getParameter("description");
		String s6 = UserValid.userLoc;
		String s7 = "E:/data/user/downloads/";
		String FilePath =s7.concat(path);


		File file1 = new File(FilePath);
		long filesize = file1.length()/1024;
		
		if(fileName.length()==0){			
			
		}		
		else{		
			try {
				stub = stubRMI("localhost");
			} 
			catch (Exception e) {
				e.printStackTrace();
			}
			//System.out.println("Stub value: "+stub);
			int appId = stub.getAppId();
			System.out.println("Inside UploadFile");
			String contentId = "" ;
			try{
				if(ch == 1)			
					contentId = stub.upload(fileName,Connection.Type.DSL,appId,"youtube.com",name);
				else{
					try{
						contentId = stub.upload(fileName,Connection.Type.USB,appId,"youtube.com",name);
					}catch(Exception e){
						System.err.println("Contentid not generated:Uploadfile.java ");
					}
				}				

				//System.out.println("ContentId : "+ contentId);
				//System.out.println("stub.Upload called");
			}catch(Exception ex){				
				System.err.println("content id not generated");
				ex.printStackTrace();				
			}

			String content = contentId ;
			String thumbNail = "" ;
			try{

				String dirpath = "E:/data/user/downloads/";
				String fullpath = dirpath +fileName;

				//System.out.println("fullpath is"+fullpath);//to be commented

				//String thumbFile = VideoUtility.VideoUtil(fullpath);
				//Thumbnail call

				String thumbFile = "E:/thumbnails/Deafault.jpg";
				String command="C:/FFmpeg-git-c9e16a9/ffmpeg.exe -itsoffset -25 -y -i "+ fullpath +" -vcodec mjpeg -vframes 1 -an -f rawvideo -s 320x240 " + thumbFile;

				//System.out.println("Command is:"+command);//to be commented
				//System.out.println("thumbfile is:"+thumbFile);//to be commented				

				long Stime = new Date().getTime();
				System.out.println("Thubmnail Processing.........");
				try{
					Process p = Runtime.getRuntime().exec(command);
							System.out.println("Waiting 1.........");		
					p.waitFor();
					System.out.println("Waiting 2.........");		
					if (p.exitValue() == 0) {						
						System.out.println("Thubmnail created");
					}
					//System.out.println(p.exitValue());
					p.destroy();
				}catch(Exception e){
					System.err.println("Unable to create thumbnail::uploadfile.java::");
				}
				long Etime = new Date().getTime();
				long Ttime = Etime-Stime;
				System.err.println("Time taken by FFMPEG : "+ Ttime +" ms");

				File filexugg = new File(thumbFile);
				if(filexugg.exists()){
					String namexugg = Integer.toString(num);
					//System.out.println("File exits");
					String targetPath = "E:/data/DBServer/";

					String imgPath = "C:/Users/Administrator/workspace/PubSubApi/WebContent/DBServer/";
					copyFile(filexugg,new File(imgPath+content+".jpg"));
					thumbNail = content+".jpg" ;
					filexugg.renameTo(new File(targetPath+thumbNail));
				}
			}catch(Exception e){
				e.printStackTrace();
				System.err.print("FFMPEg problem");
			}
			/*Upload Image for thumbNail */

			stub.uploadImg(thumbNail);

			String ext = fileName.substring(fileName.lastIndexOf("."));
			contentId = contentId+ext ;
			System.out.println("ContentIdn generated inside UploadFile : "+contentId);
			if(contentId.startsWith("null")){	

				System.err.println("Your file is not uploaded");
				resp.sendRedirect("UploadUnsuccessful.jsp");
			}
			else{
				try {
					Class.forName ("com.mysql.jdbc.Driver").newInstance();					      
					con = DriverManager.getConnection(connectionURL, "root", "abc123");					  
					String sql;
					SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
					Date date = new Date();
					String date_to_String = sdf.format(date);
					List<String> sqlList = new ArrayList<String>();
					sql = "insert into dbsync values('"+contentId+"-title','"+s2+"')";
					sqlList.add(sql);
					sql = "insert into dbsync values('"+contentId+"-desc','"+s5+"')";
					sqlList.add(sql);
					sql = "insert into dbsync values('"+contentId+"-lang','"+s3+"')";
					sqlList.add(sql);
					sql = "insert into dbsync values('"+contentId+"-date','"+date_to_String+"')";
					sqlList.add(sql);
					sql = "insert into dbsync values('"+contentId+"-user','"+name+"')";
					sqlList.add(sql);
					sql = "insert into dbsync values('"+contentId+"-cat','"+s4+"')";
					sqlList.add(sql);
					sql = "insert into dbsync values('"+contentId+"-loc','"+s6+"')";
					sqlList.add(sql);
					sql = "insert into dbsync values('"+contentId+"-demand',0)";
					sqlList.add(sql);
					sql = "insert into dbsync values('"+contentId+"-size(kb)','"+filesize+"')";
					sqlList.add(sql);
					sql = "insert into dbsync values('"+contentId+"-visRep','"+thumbNail+"')";
					sqlList.add(sql);
					//stub.updateLog(content,sqlList);					
					//System.out.println("Upload is successfull");
					resp.sendRedirect("AfterUpload.jsp");


				}

				catch(ClassNotFoundException e){
					System.err.println("Couldn't load database driver: " + e.getMessage());
				}
				catch(SQLException e){
					System.err.println("SQLException caught: " + e.getMessage());
				}
				catch (Exception e){
					e.printStackTrace();
				}
				finally {
					// Always close the database connection.
					try {
						if (con != null) con.close();
					}
					catch (SQLException ignored){
						System.out.println(ignored);
					}
				}
				session.setAttribute("contentid", contentId);
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
	private static void copyFile(File sourceFile, File destFile)
			throws IOException {
		if (!sourceFile.exists()) {
			return;
		}
		if (!destFile.exists()) {
			destFile.createNewFile();
		}
		FileChannel source = null;
		FileChannel destination = null;
		source = new FileInputStream(sourceFile).getChannel();
		destination = new FileOutputStream(destFile).getChannel();
		if (destination != null && source != null) {
			destination.transferFrom(source, 0, source.size());
		}
		if (source != null) {
			source.close();
		}
		if (destination != null) {
			destination.close();
		}

	}


}
