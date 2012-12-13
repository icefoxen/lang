# Sizers!

import wx

ID_Button1 = 100
ID_Button2 = 101
ID_Button3 = 102

class MainWindow( wx.Panel ):
    def __init__( self, parent, id ):
        wx.Panel.__init__( self, parent, id )

        self.b1 = wx.Button( self, ID_Button1, "B1" )
        wx.EVT_BUTTON( self, ID_Button1, self.ClickOne )

        self.b2 = wx.Button( self, ID_Button2, "B2" )
        wx.EVT_BUTTON( self, ID_Button2, self.ClickTwo )

        self.b3 = wx.Button( self, ID_Button3, "B3" )
        wx.EVT_BUTTON( self, ID_Button3, self.ClickThree )

        vsizer = wx.BoxSizer( wx.VERTICAL )
        vsizer.Add( self.b1, proportion=1, flag=wx.EXPAND | wx.ALL,
                    border=2 )
        vsizer.Add( self.b2, proportion=1, flag=wx.EXPAND | wx.ALL,
                    border=2 )
        vsizer.Add( self.b3, proportion=2, flag=wx.EXPAND | wx.ALL,
                    border=2 ) 
        self.SetSizer( vsizer )

    def ClickOne( self, evt ):
        print "One pressed"

    def ClickTwo( self, evt ):
        print "Two pressed"

    def ClickThree( self, evt ):
        print "Three pressed"
    
        
app = wx.PySimpleApp()
frame = wx.Frame( None, -1, "Thingy" )
MainWindow( frame, -1 )
frame.Show( True )
app.MainLoop()
