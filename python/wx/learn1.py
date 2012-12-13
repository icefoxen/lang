import wx

class MainWindow( wx.Frame ):
    """A new subclass of Frame doing what we want."""
    def __init__( self, parent, id, title ):
        wx.Frame.__init__( self, parent, wx.ID_ANY, title, size=(200,100) )

        self.control = wx.TextCtrl( self, 1, style=wx.TE_MULTILINE )
        self.Show( True )

app = wx.PySimpleApp()
frame = MainWindow( None, -1, "Editor" )
app.MainLoop()
