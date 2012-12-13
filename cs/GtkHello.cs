// Compile with: mcs GtkHello.cs -pkg:gtk-sharp-2.0



using Gtk;
using System;
 
class Hello {
 
        static void Main()
        {
                Application.Init ();
 
                Window window = new Window ("helloworld");
                window.Show();
    
                Application.Run ();
    
        }
}
