import os
import wx

ID_ABOUT=101
ID_OPEN = 102
ID_EXIT=110

## class BasicApp( wx.App ):
##     def OnInit( self ):
##         frame = MainWindow( None, -1, "Hello World" )
##         frame.Show( True )

##         frame.Connect( ID_ABOUT, -1, wx.wxEVT_COMMAND_MENU_SELECTED,
##                        frame.OnAbout )

class MainWindow( wx.Frame ):
    """A new subclass of Frame doing what we want."""
    def __init__( self, parent, id, title ):
        wx.Frame.__init__( self, parent, wx.ID_ANY, title, size=(200,100) )

        self.control = wx.TextCtrl( self, 1, style=wx.TE_MULTILINE )
        self.CreateStatusBar() # Bar at the bottom of the window

        # Setting up a menu
        filemenu = wx.Menu()
        filemenu.Append( ID_ABOUT, "&About", "Information about this program" )
        filemenu.Append( ID_OPEN, "&Open", "Open a file" )
        filemenu.AppendSeparator()
        filemenu.Append( ID_EXIT, "E&xit", "Terminate the program" )

        menubar = wx.MenuBar()
        menubar.Append( filemenu, "&File" )
        self.SetMenuBar( menubar )

        # Event handlers!
        wx.EVT_MENU( self, ID_ABOUT, self.OnAbout )
        wx.EVT_MENU( self, ID_OPEN, self.OnOpen )
        wx.EVT_MENU( self, ID_EXIT, self.OnExit )
        
        self.Show( True )

    def OnAbout( self, evt ):
        d = wx.MessageDialog( self, "A sample editor \nin wxPython",
                              "About sample editor", wx.OK )
        d.ShowModal()
        d.Destroy()

    def OnExit( self, e ):
        self.Close( True )

    def OnOpen( self, e ):
        self.dirname = ''
        dlg = wx.FileDialog( self, "Choose a file", self.dirname, "", "*.*",
                            wx.OPEN )
        if dlg.ShowModal() == wx.ID_OK:
            self.filename = dlg.GetFilename()
            self.dirname = dlg.GetDirectory()
            f = open( os.path.join( self.dirname, self.filename), 'r' )
            self.control.SetValue( f.read() )
            f.close()

        dlg.Destroy()

app = wx.PySimpleApp()
frame = MainWindow( None, -1, "Editor" )
app.MainLoop()
