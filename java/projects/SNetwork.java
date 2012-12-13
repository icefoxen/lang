// SNetwork.java
// This is the actual networking part of my JavaPoster.
// Erm... it's sort of become a universal networking class.  Ah well...
// Simon Heath
// 10/05/2002

import javax.swing.*;
import java.net.*;
import java.io.*;
import com.sonalb.net.http.cookie.*;  // Cookie handling functions.
// For more info on them see http://jcookie.sourceforge.net

public class SNetwork {
   private static Client cookieClient;
   private static CookieJar cJar;
   private URL site;
   private boolean proxy;
   private String authString;
   private String auth;
   private String proxyHost;
   private String proxyPort;
   private String logIn;
   private String toSend;
   private String logOut;
   
   // Vanilla connection
   public SNetwork ( String url )
   {
      proxy = false;
      try
      {
      site = new URL( url );
      }
      catch ( MalformedURLException mfe )
      {
         JOptionPane.showMessageDialog( null, "Please re-type the URL",
	    "Error", JOptionPane.ERROR_MESSAGE );
	 mfe.printStackTrace();
      }
   }

   // Proxy connection
   public SNetwork ( String url,  String host, String port,
                        String usrname, String pass )
   {
      try
      {
      site = new URL( url );
      }
      catch ( MalformedURLException mfe )
      {
         JOptionPane.showMessageDialog( null, "Please re-type the URL",
	    "Error", JOptionPane.ERROR_MESSAGE );
	 mfe.printStackTrace();
      }
      cookieClient = new Client();

      proxyHost = host;
      proxyPort = port;
      authString = usrname + ":" + pass;
      auth = "Basic " + new sun.misc.BASE64Encoder().encode( 
         authString.getBytes() );
      
      proxy = true;
      
      System.getProperties().put( "proxySet", "true" );
      System.getProperties().put( "proxyHost", proxyHost );
      System.getProperties().put( "proxyPort", proxyPort );
      
   }

   // Connect, send data, retrieve data.
   public String hookUp ( String toSend, boolean cookieSend, boolean cookieGet )
      throws IOException  // Error handling be damned
   {
            
      
      HttpURLConnection opener1 = (HttpURLConnection) site.openConnection();
      
      opener1.setDoOutput( true );

      // Check for proxy support
      if ( proxy )
         opener1.setRequestProperty( "Proxy-Authorization", auth );
      
      // Check to see if it has to send a cookie
      if ( cookieSend )
         cookieClient.setCookies( opener1, cJar );
      
      // Create the output stream
      DataOutputStream out1 = new DataOutputStream(
         opener1.getOutputStream() );

      // Write data
      try
      {
         out1.writeBytes( toSend );
      }
      catch ( IOException out1writeE )
      {
         JOptionPane.showMessageDialog( null, "Error sending data",
	    "Error", JOptionPane.ERROR_MESSAGE );
	 out1writeE.printStackTrace();
      }

      try
      {
         out1.close();
      }
      catch ( IOException out1closeE )
      {
         JOptionPane.showMessageDialog( null, "Error closing input stream",
	    "Error", JOptionPane.ERROR_MESSAGE );
	 out1closeE.printStackTrace();
      }

      // Get input stream
      BufferedReader in1 = new BufferedReader( new InputStreamReader(
            opener1.getInputStream() ) );
      
      // Check for cookie
      if ( cookieGet )
	 try
	 {
            cJar = cookieClient.getCookies( opener1 );
	 }
	 catch ( MalformedCookieException getCookiesE )
	 {
	    System.out.println( "Error recieveing cookies" );
	    getCookiesE.printStackTrace();
	 }

      // Recieve data
      String inputLine = "";
      String input = "";
      while ( (inputLine = in1.readLine()) != null )
         input += inputLine;
      
      try
      {
         in1.close();
      }
      catch ( IOException in1closeE )
      {
         JOptionPane.showMessageDialog( null, "Error closing input stream",
	    "Error", JOptionPane.ERROR_MESSAGE );
	 in1closeE.printStackTrace();   
      }
      
      // Disconnect
      opener1.disconnect();

      return input;
   }   
}
   
