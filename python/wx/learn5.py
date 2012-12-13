import wx

class Form1( wx.Panel ):
    def __init__( self, parent, id ):
        wx.Panel.__init__( self, parent, id )
        self.quote = wx.StaticText( self, -1, "Your quote is",
                                    wx.Point( 20, 30 ) )

        self.logger = wx.TextCtrl( self, 5, "", wx.Point(300, 20),
                                   wx.Size( 200, 300 ),
                                   wx.TE_MULTILINE | wx.TE_READONLY )

        # Button
        self.button = wx.Button( self, 10, "Save", wx.Point( 200, 325 ) )
        wx.EVT_BUTTON( self, 10, self.OnClick )

        # Edit controls
        self.labelname = wx.StaticText( self, -1, "Your name:",
                                        wx.Point( 20, 60 ) )
        self.editname = wx.TextCtrl( self, 20, "Enter your name here",
                                    wx.Point( 150, 60 ), wx.Size( 140, -1 ) )

        wx.EVT_TEXT( self, 20, self.EvtText )
        wx.EVT_CHAR( self.editname, self.EvtChar )

        # Combo box
        self.samplelist = ['friends', 'bop', 'things']
        self.edithear = wx.ComboBox( self, 30, '', wx.Point( 150, 90 ),
                                     wx.Size( 95, -1 ), self.samplelist,
                                     wx.CB_DROPDOWN )

        wx.EVT_COMBOBOX( self, 30, self.EvtComboBox )
        wx.EVT_TEXT( self, 30, self.EvtText )

        # Checkbox
        self.insure = wx.CheckBox( self, 40, "Do you want foo?",
                                   wx.Point( 20, 180 ) )
        wx.EVT_CHECKBOX( self, 40, self.EvtCheckBox )

        # Radio boxes
        self.radioList = ['blue', 'red', 'yellow', 'orange']
        rb = wx.RadioBox( self, 50, "What color?", wx.Point(20,210),
                            wx.DefaultSize, self.radioList, 3,
                            wx.RA_SPECIFY_COLS )

        wx.EVT_RADIOBOX( self, 50, self.EvtRadioBox )

    def EvtRadioBox( self, event ):
        self.logger.AppendText( "EvtRadioBox: %d\n" % event.GetInt() )

    def EvtComboBox( self, event ):
        self.logger.AppendText( "EvtComboBox: %s\n" % event.GetString() )

    def OnClick( self, event ):
        self.logger.AppendText( "OnClick: %d\n" % event.GetId() )

    def EvtText( self, event ):
        self.logger.AppendText( "Text: %s\n" % event.GetString() )

    def EvtChar( self, event ):
        self.logger.AppendText( "EvtChar: %d\n" % event.GetKeyCode() )
        event.Skip()

    def EvtCheckBox( self, event ):
        self.logger.AppendText( "EvtCheckBox: %d\n" % event.Checked() )
        

app = wx.PySimpleApp()
frame = wx.Frame( None, -1, "Noteboox!" )
nb = wx.Notebook( frame, -1 )
form1 = Form1( nb, -1 )
form2 = Form1( nb, -1 )
nb.AddPage( form1, "Absolute positioning" )
nb.AddPage( form2, "Stuff!" )
frame.Show(1)
app.MainLoop()
