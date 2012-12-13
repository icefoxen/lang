// Compile with mcs hello.cs -pkg:dotnet
// try replacing mcs with gmcs

using System;
using System.Windows.Forms;
 
public class HelloWorld : Form
{
	static public void Main ()
	{
		Application.Run (new HelloWorld ());
	}
 
	public HelloWorld ()
	{
		Text = "Hello Mono World";
	}
}
