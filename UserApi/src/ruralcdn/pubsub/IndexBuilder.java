package ruralcdn.pubsub;


import java.io.File;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;


import org.apache.lucene.analysis.standard.StandardAnalyzer;
import org.apache.lucene.document.Document;
import org.apache.lucene.document.Field;
import org.apache.lucene.index.IndexWriter;
import org.apache.lucene.store.FSDirectory;
import org.apache.lucene.util.Version;


public class IndexBuilder {

	static final String LUCENE_INDEX_DIRECTORY = "C:\\lucene";
	static final String DB_HOST_NAME = "localhost";
	static final String DB_USER_NAME = "root";
	static final String DB_PASSWORD = "abc123";

	//method for indexing
	@SuppressWarnings("deprecation")
	public void buildIndex(){

		Connection con = null;
		Statement stmt = null;
		ResultSet rs = null;
		IndexWriter writer=null;
		StandardAnalyzer analyzer = null;		
		File file = null;
		try{
			System.out.println("Start indexing");
			//get a reference to index directory file
			file = new File(LUCENE_INDEX_DIRECTORY);
			analyzer = new StandardAnalyzer(Version.LUCENE_CURRENT);
			writer = new IndexWriter(
					FSDirectory.open(file),
					analyzer,
					true,
					IndexWriter.MaxFieldLength.LIMITED
			);


			//initialize the driver class
			Class.forName("com.mysql.jdbc.Driver").newInstance();
			//get connection object
			con = DriverManager.getConnection(
					"jdbc:mysql://"+DB_HOST_NAME+"/ruralcdn",
					DB_USER_NAME, DB_PASSWORD);
			//create statement object
			stmt = con.createStatement();
			//execute query
			List<String> contentId = new ArrayList<String>();
			String[] data = new String[50];
			rs = stmt.executeQuery("SELECT dbkey FROM dbsync where dbkey like '%-title%'");
			//iterate through result set
			try{
				while(rs.next()){

					String temp = rs.getString(1);
					contentId.add(temp.substring(0,temp.lastIndexOf("-")));
				}
			}catch(Exception e){
				System.out.println("error is here in 5");
			}
			try{
				for(int i=0;i<contentId.size();i++){

					rs = stmt.executeQuery("SELECT dbvalue FROM dbsync where dbkey like '%"+contentId.get(i)+"%'");
					int j= 0;
					try{
						while(rs.next()){
							data[j++] = rs.getString(1);
							//System.out.println(data[i]);
						}
					}catch(Exception e){
						//System.out.println("error is here 7");
						e.printStackTrace();
					}

					//String c_id = rs.getString("c_id");
					String content_id = contentId.get(i);
					String title = data[7];
					String c_desc = data[3];
					String lang = data[4];
					String cat = data[0];								
					String u_name = data[8];
					String demand = data[2];
					String loc = data[5];
					//System.out.println(data[5]);

					//String des = rs.getString("des");
					//String date = rs.getString("date");


					String fulltext = content_id + " " + title +
					" " + c_desc + " " + lang +
					" " + cat + " " + u_name +" "+demand+" "+loc;

					//create document object
					Document document = new Document();
					//create field objects and add to document			


					Field uidField = new Field("content_id", 
							content_id, Field.Store.YES,
							Field.Index.ANALYZED);
					document.add(uidField);
					Field titleField = new Field("title",
							title, Field.Store.YES,
							Field.Index.ANALYZED);
					document.add(titleField);
					Field c_descField = new Field("c_desc",
							c_desc, Field.Store.YES,
							Field.Index.ANALYZED);
					document.add(c_descField);
					Field langField = new Field("lang",
							lang, Field.Store.YES,
							Field.Index.ANALYZED);
					document.add(langField);
					Field catField = new Field("cat", 
							cat, Field.Store.YES,
							Field.Index.ANALYZED);
					document.add(catField);								
					Field u_nameField = new Field("u_name",
							u_name, Field.Store.YES,
							Field.Index.ANALYZED);
					document.add(u_nameField);
					Field demandField = new Field("demand",
							u_name, Field.Store.YES,
							Field.Index.ANALYZED);
					document.add(demandField);
					Field locField = new Field("loc",
							u_name, Field.Store.YES,
							Field.Index.ANALYZED);
					document.add(locField);

					Field fulltextField = new Field("fulltext",
							fulltext, Field.Store.NO,
							Field.Index.ANALYZED);
					document.add(fulltextField);
					//add the document to writer
					writer.addDocument(document);
					//end while loop


				}
			}catch(Exception e){

				System.out.println("Error is here 6");
			}
			//optimize the index
			System.out.println("Optimizing index");
			writer.optimize();

		}catch(Exception e){
			System.out.println("error is here in 4");
		}finally{
			try{
				if(writer!=null)
					writer.close();
				if(rs!=null)
					rs.close();
				if(stmt!=null)
					stmt.close();
				if(con!=null)
					con.close();
				System.out.println("Finished indexing");

			}catch(Exception ex){
				ex.printStackTrace();
			}

		}


	}



}