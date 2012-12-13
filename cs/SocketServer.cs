using System;
using System.Collections;
using System.Net;
using System.Net.Sockets;

public class SocketServer {
   // Use this for initialization
   public static void Main(String[] args) {
      var addrbytes = new byte[]{10, 42, 7, 240};
      var addr = new IPAddress(addrbytes);
      var sock = new TcpListener(addr, 8877);
      sock.Start();
      Console.WriteLine("Waiting for client...");
      var c = sock.AcceptTcpClient();
      Console.WriteLine("Got client!");
      var n = 0.0;
      while(true) {
         if(c != null && c.Connected) {
	    n += 0.01;
	    var locx = Math.Sin(n) / 50;
	    var locy = Math.Cos(n) / 50;
	    Console.WriteLine("Sending {0}, {1}", locx, locy);
            var response = System.BitConverter.GetBytes(locx);
            var stream = c.GetStream();
            stream.Write(response, 0, response.Length);
            response = System.BitConverter.GetBytes(locy);
            stream.Write(response, 0, response.Length);
            var buf = new byte[16];
	    stream.Read(buf, 0, buf.Length);
            Console.WriteLine("Received {0}", System.Text.Encoding.ASCII.GetString(buf));
            
         } else {
            Console.Write("Oh shit, lost connection!");
	    return;
         }
      }
   }
   
}

