#-------------------------------------------------------------------
# CommentedDrawing.py
# Development: windows 98se, Python 2.2.3, wxPython 2.4.0.7
# also ok under wxPython 2.4.1.2
# 17 July 2003
# Jean-Michel Fauth, Switzerland
#-------------------------------------------------------------------

from wxPython.wx import *
from time import asctime

#-------------------------------------------------------------------

def jmtime():
    return '[' + asctime()[11:19] + '] '

#-------------------------------------------------------------------

# The control/widget containing the drawing. It is white and has no border. It
# is not necessary to defined its positon and size, since these parameters are
# set up by the layout constraints mechanism. However, I forced the control
# to have no border.
class MyDrawingArea(wxWindow):

    def __init__(self, parent, id):
        sty = wxNO_BORDER
        wxWindow.__init__(self, parent, id, style=sty)
        self.parent = parent
        self.SetBackgroundColour(wxWHITE)
        self.SetCursor(wxCROSS_CURSOR)

        # Some initalisation, just to reminds the user that a variable
        # called self.BufferBmp exists. See self.OnSize().
        self.BufferBmp = None

        EVT_SIZE(self, self.OnSize)
        EVT_PAINT(self, self.OnPaint)


    # OnSize is fired at the application start or when the frame is resized.
    # The OnSize event is fired BEFORE the OnPaint event. wxWindows
    # handles the events in this order. This is not due to the fact,
    # that the code line EVT_SIZE(...) is placed before the line
    # EVT_PAINT(...).
    # The procedure OnSize() is the right place to define the
    # BufferBmp and its size. self.BufferBmp is the picture in memory,
    # which contains your drawing. self.BufferBmp is also used as a flag,
    # a None value indicates no picture.
    #
    def OnSize(self, event):
        print jmtime() + 'OnSize in MyDrawingArea'
        # Get the size of the drawing area in pixels.
        self.wi, self.he = self.GetSizeTuple()
        # Create BufferBmp and set the same size as the drawing area.
        self.BufferBmp = wxEmptyBitmap(self.wi, self.he)
        memdc = wxMemoryDC()
        memdc.SelectObject(self.BufferBmp)
        # Drawing job
        ret = self.DoSomeDrawing(memdc)
        if not ret:  #error
            self.BufferBmp = None
            wxMessageBox('Error in drawing', 'CommentedDrawing', wxOK | wxICON_EXCLAMATION)


    # OnPaint is executed at the app start, when resizing or when
    # the application windows becomes active. OnPaint copies the
    # buffered picture, instead of preparing (again) the drawing job.
    # This is the trick, copying is very fast.
    # Note: if you forget to define the dc in this procedure,
    # (no dc = ... code line), the application will run in
    # an infinite loop. This is a common beginner's error. (I think)
    # BeginDrawing() and EndDrawing() are for windows platforms (see doc).
    def OnPaint(self, event):
        print jmtime() + 'OnPaint in MyDrawingArea'
        dc = wxPaintDC(self)
        dc.BeginDrawing()
        if self.BufferBmp != None:
            print jmtime() + '...drawing'
            dc.DrawBitmap(self.BufferBmp, 0, 0, True)
        else:
            print jmtime() + '...nothing to draw'
        dc.EndDrawing()


    # The function defines the drawing job. Everything is drawn on the dc.
    # In that application, the dc corresponds to the BufferBmp.
    # Three things are drawn, a square with a fixed size, and two
    # rectangles with sizes determined by the size of the dc, that
    # means the size of the drawing area. Keep in mind, the size
    # of the drawing area depends on the size of the main frame,
    # which can be resized on the fly with your mouse.
    # At this point, I will introduce a small complication, that is
    # in fact quite practical. It may happen, the drawing is not
    # working correctly. Either there is an error in the drawing job
    # or the data you want to plot can not be drawn correctly. A typical
    # example is the plotting of 'scientific data'. The data are not (or
    # may not be) scaled correctly, that leads to errors, generally integer
    # overflow errors.
    # To circumvent this, the procedure returns True, if the drawing succeed.
    # It returns False, if the drawing fails. The returned value may be used
    # later.
    def DoSomeDrawing(self, dc):
        try:
            print jmtime() + 'DoSomeDrawing in MyDrawingArea'

            dc.BeginDrawing()

            #~ raise OverflowError #for test

            # Clear everything
            dc.SetBrush(wxBrush(wxWHITE, wxSOLID))
            dc.Clear()

            # Draw the square with a fixed size.
            dc.SetBrush(wxBrush(wxCYAN, wxSOLID))
            dc.SetPen(wxPen(wxBLUE, 1, wxSOLID))
            dc.DrawRectangle(10, 10, 200, 200)

            # Draw a transparent rectangle with a red border, proportional to
            # the dc size.
            dcwi, dche = dc.GetSizeTuple()
            dc.SetBrush(wxBrush(wxCYAN, wxTRANSPARENT))
            dc.SetPen(wxPen(wxRED, 1, wxSOLID))
            dc.DrawRectangle(0, 0, dcwi, dche)

            # Draw one another rectangle, a rectangle with a size proportional
            # to the dc size.
            gap = 50
            dc.SetBrush(wxBrush(wxWHITE, wxTRANSPARENT))
            dc.SetPen(wxPen(wxBLACK, 1, wxSOLID))
            dc.DrawRectangle(0 + gap, 0 + gap, dcwi - 2 * gap, dche - 2 * gap)

            # These next 2 lines will raise an overflow error.
            #~ largeval = 1e10
            #~ dc.DrawLine(dcwi // 2, dche // 2, largeval, largeval)

            dc.EndDrawing()
            return True

        except:
            return False

#-------------------------------------------------------------------

# Panel in the main frame. It covers automatically the client area of
# its parent frame. The panel contains a single control (class MyDrawingArea),
# on which the drawing takes place. The position and size of this control is
# set up with layout constraints, so that the user see what happens to the
# drawing when the main frame is resized.
class MyPanel(wxPanel):

    def __init__(self, parent, id):
        wxPanel.__init__(self, parent, id, wxDefaultPosition, wxDefaultSize)

        self.drawingarea = MyDrawingArea(self, -1)

        self.SetAutoLayout(True)

        gap = 30 #in pixels
        lc = wxLayoutConstraints()
        lc.top.SameAs(self, wxTop, gap)
        lc.left.SameAs(self, wxLeft, gap)
        lc.right.SameAs(self, wxWidth, gap)
        lc.bottom.SameAs(self, wxBottom, gap)
        self.drawingarea.SetConstraints(lc)

#-------------------------------------------------------------------

# Usual frame. Can be resized, maximized and minimized.
# The frame contains one panel.
class MyFrame(wxFrame):

    def __init__(self, parent, id):
        wxFrame.__init__(self, parent, id, 'CommentedDrawing', wxPoint(0, 0), wxSize(500, 400))
        self.panel = MyPanel(self, -1)

        EVT_CLOSE(self, self.OnCloseWindow)

    def OnCloseWindow(self, event):
        print jmtime() + 'OnCloseWindow in MyFrame'
        self.Destroy()

#-------------------------------------------------------------------

class MyApp(wxApp):

    def OnInit(self):
        frame = MyFrame(None, -1)
        frame.Show(True)
        self.SetTopWindow(frame)
        return True

#-------------------------------------------------------------------

def main():
    print 'main is running...'
    app = MyApp(0)
    app.MainLoop()

#-------------------------------------------------------------------

if __name__ == "__main__" :
    main()
