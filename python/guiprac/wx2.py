from wxPython.wx import *

ID_ABOUT = 101
ID_EXIT = 102
ID_HELP = 103

class MainWindow( wxFrame ):
   def __init__( self, parent, id, title ):
      wxFrame.__init__( self, parent, -4, title, size = (300, 250),
                        style=wxDEFAULT_FRAME_STYLE |
			wxNO_FULL_REPAINT_ON_RESIZE )
      self.control = wxTextCtrl( self, 1, style=wxTE_MULTILINE )

      self.CreateStatusBar()

      filemenu = wxMenu()
      filemenu.Append( ID_ABOUT, "&About", "Information about this program" )
      filemenu.AppendSeparator()
      filemenu.Append( ID_EXIT, "E&xit", "Terminate the program" )

      helpmenu = wxMenu()
      helpmenu.Append( ID_HELP, "&Help", "Help on this program" )

      menubar = wxMenuBar()
      menubar.Append( filemenu, "&File" )
      menubar.Append( helpmenu, "&Help" )
      self.SetMenuBar( menubar )

      EVT_MENU( self, ID_ABOUT, self.OnAbout )
      EVT_MENU( self, ID_EXIT, self.OnExit )
      EVT_MENU( self, ID_HELP, self.OnHelp )
      
      self.Show( true )

   def OnAbout( self, e ):
      d = wxMessageDialog( self, "A sample editor\nin wxPython", 
         "About Sample Editor", wxOK )
      d.ShowModal()
      d.Destroy()

   def OnHelp( self, e ):
      d = wxMessageDialog( self, "You type.\nThat's about it.", 
         "Sample Editor Help", wxOK )
      d.ShowModal()
      d.Destroy()

   def OnExit( self, e ):
      self.Close( true )

app = wxPySimpleApp()
frame = MainWindow( None, -1, "Editor thing" )
app.MainLoop()
