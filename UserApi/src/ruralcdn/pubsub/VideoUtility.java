package ruralcdn.pubsub;

import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;

import javax.imageio.ImageIO;
//import javax.media.rtp.SessionAddress;

import com.xuggle.mediatool.IMediaReader;
import com.xuggle.mediatool.MediaListenerAdapter;
import com.xuggle.mediatool.ToolFactory;
import com.xuggle.mediatool.event.IVideoPictureEvent;
import com.xuggle.xuggler.Global;

public class VideoUtility {
	
	public static  String filepath= null;
	public static boolean flag=false;
    public static final double SECONDS_BETWEEN_FRAMES = 480;
    //private static final Stringvideo2 ="F:/two and half men/TAAHM-1x24-Can You Feel My Finger.avi";
   private static final String inputFilename = "E:/data/user/downloads/";
    private static final String outputFilePrefix = "E:/";
    // The video stream index, used to ensure we display frames from one and
    // only one video stream from the media container.
    private static int mVideoStreamIndex = -1;
    static double seconds;
    // Time of last frame write
    private static long mLastPtsWrite = Global.NO_PTS;
    static String outputFilename=null;
    public static final long MICRO_SECONDS_BETWEEN_FRAMES = 
        (long)(Global.DEFAULT_PTS_PER_SECOND * SECONDS_BETWEEN_FRAMES);

	
    public static void main(String[] args) {
    	
    	//String filepath= null;
		//VideoUtility.VideoUtil(inputFilename );	
		return;
    }

    public static String VideoUtil(String videoFile) 
    {
    	
    	 IMediaReader mediaReader = ToolFactory.makeReader(videoFile);
    	 
         // stipulate that we want BufferedImages created in BGR 24bit color space
         mediaReader.setBufferedImageTypeToGenerate(BufferedImage.TYPE_3BYTE_BGR);
         System.out.println(mediaReader);
    	 System.out.println(inputFilename);
         mLastPtsWrite = Global.NO_PTS;
         mediaReader.addListener(new ImageSnapListener());
         //mediaReader.addListener(ImageSnapListener.onVideoPicture());

         // read out the contents of the media file and
         // dispatch events to the attached listener
         int count=0;
         while (mediaReader.readPacket() == null) 
         {
        	 count=count+1;
        	 if(count==100)
        	 {
        		 break;
        	 }
         }
        
         return outputFilename;
    }
   
public static long videosize(String video)
{
	File file=new File(inputFilename+video);
	long filesize=file.length()/1024;	
	return filesize;	
}
  

	private static class ImageSnapListener extends MediaListenerAdapter {

        public void onVideoPicture(IVideoPictureEvent event) {
        	//System.out.println("In ImageSnap");
            if ((event.getStreamIndex() != mVideoStreamIndex)&&(flag==false)) {
                // if the selected video stream id is not yet set, go ahead an
                // select this lucky video stream
                if (mVideoStreamIndex == -1)
                    mVideoStreamIndex = event.getStreamIndex();
                // no need to show frames from this video stream
                else
                    return;
            }
            // if uninitialized, back date mLastPtsWrite to get the very first frame
            if ((mLastPtsWrite == Global.NO_PTS)&&(flag==false))
                mLastPtsWrite = event.getTimeStamp() - MICRO_SECONDS_BETWEEN_FRAMES;

           
			// if it's time to write the next frame
           
            if ((event.getTimeStamp() - mLastPtsWrite >= 
                    MICRO_SECONDS_BETWEEN_FRAMES)&&(flag==false)) {
            	//String outputFilename=null;                
                outputFilename = dumpImageToFile(event.getImage());
                
                System.out.println("path of the snapshot generated"+outputFilename);
                filepath=outputFilename;
                
                // indicate file written
                seconds = ((double) event.getTimeStamp()) / 
                    Global.DEFAULT_PTS_PER_SECOND;
                //System.out.println(seconds);   
                System.out.printf(
                        "at elapsed time of %6.3f seconds wrote: %s\n",
                        seconds, outputFilename);

                // update last write time
                //Commented by Quamar
               mLastPtsWrite += MICRO_SECONDS_BETWEEN_FRAMES;
                
            }
           // mLastPtsWrite = Global.NO_PTS;
            //flag=true;                     
            
 
        }
        
        private String dumpImageToFile(BufferedImage image) {
            try {
            	
                 outputFilename = outputFilePrefix + 
                     System.currentTimeMillis() + ".jpg";
                ImageIO.write(image, "jpg", new File(outputFilename));
                //flag = true;
                return outputFilename;
            	
            } 
            catch (IOException e) {
                e.printStackTrace();
                return null;
            }
			
        }


    }
	
}
