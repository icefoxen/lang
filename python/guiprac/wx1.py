from wxPython.wx import *

ID_ABOUT = 101
ID_EXIT  = 102

class MyFrame( wxFrame ):
   def __init__( self, parent, ID, title ):
      wxFrame.__init__( self, parent, ID, title, 
                        wxDefaultPosition, wxSize( 200, 150 ) )
      
      self.CreateStatusBar()
      self.SetStatusText( "This is the statusbar" )

      menu = wxMenu()
      menu.Append( ID_ABOUT, "&About", "More info about this program" )
      menu.AppendSeparator()
      menu.Append( ID_EXIT, "E&xit", "Terminate the program" )

      menuBar = wxMenuBar()
      menuBar.Append( menu, "&File" )
      self.SetMenuBar( menuBar )

      EVT_MENU( self, ID_ABOUT, self.OnAbout )
      EVT_MENU( self, ID_EXIT, self.TimeToQuit )

   def OnAbout( self, event ):
      d = wxMessageDialog( self,
         "This sample program shows off\nframes, menus, statusbars,\nand this"
	 + " Message dialog",
	 "About Me", wxOK | wxICON_INFORMATION )

      d.ShowModal()
      d.Destroy()

   def TimeToQuit( self, event ):
      self.Close( true )


class MyApp( wxApp ):
   def OnInit( self ):
      frame = MyFrame( NULL, -1, "Hello from wxPython" )
      frame.Show( true )
      self.SetTopWindow( frame )
      return true


app = MyApp( 0 )
app.MainLoop()
