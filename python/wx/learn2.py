import wx

ID_ABOUT=101
ID_EXIT=110

class MainWindow( wx.Frame ):
    """A new subclass of Frame doing what we want."""
    def __init__( self, parent, id, title ):
        wx.Frame.__init__( self, parent, wx.ID_ANY, title, size=(200,100) )

        self.control = wx.TextCtrl( self, 1, style=wx.TE_MULTILINE )
        self.CreateStatusBar() # Bar at the bottom of the window

        # Setting up a menu
        filemenu = wx.Menu()
        filemenu.Append( ID_ABOUT, "&About", "Information about this program" )
        filemenu.AppendSeparator()
        filemenu.Append( ID_EXIT, "E&xit", "Terminate the program" )

        menubar = wx.MenuBar()
        menubar.Append( filemenu, "&File" )
        
        self.SetMenuBar( menubar )
        self.Show( True )

app = wx.PySimpleApp()
frame = MainWindow( None, -1, "Editor" )
app.MainLoop()
