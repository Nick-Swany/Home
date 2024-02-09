#Nick Swanson
#Calculator app 
#November 2023
import wx
import sqlite3

def bnclick(evt): #function to get button pressed
    p = evt.GetEventObject().Label
    q = t.GetValue()
    r = q + p
    t.SetValue(r)


def opclick(evt): #function to set operation after being clicked
    global firstnum
    global oper
    firstnum = int(t.GetValue())
    oper = evt.GetEventObject().Label
    t.SetValue("")

def equclick(evt): #function to set do math / get reullt of num1 operation num2
    global firstnum
    global oper
    secondnum = int(t.GetValue())
    if oper == '+':
        result = firstnum + secondnum
    elif oper == '-':
        result = firstnum - secondnum
    elif oper == 'x':
        result = firstnum * secondnum
    elif oper == '/':
        result = int(firstnum / secondnum)
    else:
        result = '0'
    t.SetValue(str(result))

    #save values into databaske. Database has been named Calc.db
    con = sqlite3.connect('Calc.db')
    cur = con.cursor()
    cur.execute("CREATE TABLE IF NOT EXISTS Math(res INT, num1 INT, operation VARCHAR(50), num2 INT)")
    cur.execute("INSERT INTO Math(res, num1, operation, num2) VALUES (?, ?, ?, ?)", (result, firstnum, oper, secondnum))
    con.commit()
    cur.close()
    con.close()

def resclick(evt): #function to reset result blank
    global firstnum
    global oper
    firstnum = int(t.GetValue())
    oper = evt.GetEventObject().Label
    t.SetValue("")

def backclick(evt): #set value to get previous reslut
    con = sqlite3.connect('Calc.db')
    cur = con.cursor()
    #get last row from db memory
    cur.execute("select * from Math ORDER BY ROWID DESC LIMIT 1")
    row = cur.fetchone()
    #print(row) #used for debuging purposes
    #print(row[0]) #output to confirm retrived memory is correct.
    t.SetValue(str(row[0]))
    cur.close()
    con.close()
#glabal variables for operation and first number pressed
firstnum = None
oper = None


theApp = wx.App()
f = wx.Frame(parent=None, title="Calculater")
t = wx.TextCtrl(parent=f, size=(100,25))
t.SetPosition(wx.Point(10,10))

#buttons that can be pressed in calculator
#0-9 + - x / R(reset) = <- (previous)
b1 = wx.Button(parent = f, label = "1", size=(25,25))
b1.SetPosition(wx.Point(10,40))
b1.Bind(wx.EVT_BUTTON, bnclick)

b2 = wx.Button(parent = f, label = "2", size=(25,25))
b2.SetPosition(wx.Point(40,40))
b2.Bind(wx.EVT_BUTTON, bnclick)

b3 = wx.Button(parent = f, label = "3", size=(25,25))
b3.SetPosition(wx.Point(70,40))
b3.Bind(wx.EVT_BUTTON, bnclick)

b4 = wx.Button(parent = f, label = "4", size=(25,25))
b4.SetPosition(wx.Point(10,70))
b4.Bind(wx.EVT_BUTTON, bnclick)

b5 = wx.Button(parent = f, label = "5", size=(25,25))
b5.SetPosition(wx.Point(40,70))
b5.Bind(wx.EVT_BUTTON, bnclick)

b6 = wx.Button(parent = f, label = "6", size=(25,25))
b6.SetPosition(wx.Point(70,70))
b6.Bind(wx.EVT_BUTTON, bnclick)

b7 = wx.Button(parent = f, label = "7", size=(25,25))
b7.SetPosition(wx.Point(10,100))
b7.Bind(wx.EVT_BUTTON, bnclick)

b8 = wx.Button(parent = f, label = "8", size=(25,25))
b8.SetPosition(wx.Point(40,100))
b8.Bind(wx.EVT_BUTTON, bnclick)

b9 = wx.Button(parent = f, label = "9", size=(25,25))
b9.SetPosition(wx.Point(70,100))
b9.Bind(wx.EVT_BUTTON, bnclick)

b0 = wx.Button(parent = f, label = "0", size=(25,25))
b0.SetPosition(wx.Point(100,160))
b0.Bind(wx.EVT_BUTTON, bnclick)

bplus = wx.Button(parent = f, label = "+", size=(25,25))
bplus.SetPosition(wx.Point(100,130))
bplus.Bind(wx.EVT_BUTTON, opclick)

bminus = wx.Button(parent = f, label = "-", size=(25,25))
bminus.SetPosition(wx.Point(70,130))
bminus.Bind(wx.EVT_BUTTON, opclick)

bmult = wx.Button(parent = f, label = "x", size=(25,25))
bmult.SetPosition(wx.Point(100,100))
bmult.Bind(wx.EVT_BUTTON, opclick)

bdiv = wx.Button(parent = f, label = "/", size=(25,25))
bdiv.SetPosition(wx.Point(100,70))
bdiv.Bind(wx.EVT_BUTTON, opclick)

bequals = wx.Button(parent = f, label = "=", size=(25,25))
bequals.SetPosition(wx.Point(10,130))
bequals.Bind(wx.EVT_BUTTON, equclick)

bequals = wx.Button(parent = f, label = "R", size=(25,25))
bequals.SetPosition(wx.Point(40,130))
bequals.Bind(wx.EVT_BUTTON, resclick)

bequals = wx.Button(parent = f, label = "<-", size=(25,25))
bequals.SetPosition(wx.Point(100,40))
bequals.Bind(wx.EVT_BUTTON, backclick)

f.Show()

theApp.MainLoop()
