# testapp.py
# This is to test all the things we'll need for game dev,
# namely drawing, and loading and displaying images.

import wx

width = 640
height = 480

class TestWindow( wx.Panel ):
    def __init__( self, parent ):
        wx.Window.__init__( self, parent )
        wx.EVT_PAINT( self, self.onPaint )

        self.SetBackgroundColour( "WHITE" )

        self.sprite = wx.Bitmap( "testimage.png" )


    def onPaint(self, event=None):
        dc = wx.PaintDC(self)
        dc.Clear()
        dc.SetPen(wx.Pen("BLACK", 1 ))
        dc.DrawLine(0, 0, 70, 70)

        dc.DrawCircle( 20, 50, 30 )
        buffer = wx.MemoryDC()
	#buffer.DrawBitmap( self.sprite, 0, 0 )
	buffer.SelectObject( self.sprite )
	
        dc.Blit( 500, 5, 50, 300, buffer, 0, 0 )
	print buffer.GetSize()

    def foo1( self, e ):
        print "Foo 1"

    def foo2( self, e ):
        print "Foo 2"

class TestFrame( wx.Frame ):
    def __init__( self, parent=None ):
        wx.Frame.__init__( self, parent, title="Test frame",
                                 size=(640,480) )
        win = TestWindow( self )


if __name__ == '__main__':
    app = wx.App()
    frame = TestFrame()
    frame.Show( True )
    app.MainLoop()
