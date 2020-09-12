# -*- coding: utf-8 -*-
"""
Created on Sun Sep  6 20:56:43 2020

@author: david
"""
import tkinter as tk
import Config as cg

#def StartGUI():
    
window = tk.Tk()
window.title("Set parameters for app.")
window.geometry('400x500')

txtEmp = tk.StringVar()
txtPeriod = tk.StringVar()
bolGenBias = []

widgets = [[0,txtEmp,'Total Employees: ',(1000,10000,500.0),'spin'],
           [1,txtPeriod,'Total Periods: ',(3,10,1),'spin'],
           [2,bolGenBias,'Gender Bias: ',True,'bol']]

def add_widget(wid):
    if wid[-1] == 'entry':
        tk.Label(master = window, text = wid[2]).grid(row = wid[0])
        temp = tk.Entry(master = window, textvariable=wid[2])
        temp.grid(row = wid[0], column=1)
        temp.insert(0, wid[3])
    if wid[-1] == 'spin':
        tk.Label(master = window, text = wid[2]).grid(row = wid[0])
        temp = tk.Spinbox(master = window, textvariable=wid[2], from_=wid[3][0], to_=wid[3][1], increment=wid[3][2])
        temp.grid(row = wid[0], column=1)
        #temp.insert(0, wid[3])
for w in widgets:
    add_widget(w)

print(txtEmp.get())
# txtEmp = []
# txtPeriod = []
# widgets = [[txtEmp, 'Total Employees: ','1000',''],
#            [txtPeriod, 'Total Periods: ','2','']]

# widgets = [['Total Employees: ','1000', 'entry'],
#            ['Total Periods: ','2', 'entry'],
#            ['Bias: ',True,'bol']]

# def add_widgets:
        
    
# # print(widgets)
# tk.Label(master=window, )
# myCount = 1
# for w in widgets:
#     tk.Label(master = window, text = w[1]).grid(row = myCount)
#     w[3] = tk.Entry(master = window).grid(row = myCount, column=1)
#     myCount +=1

# print(widgets)

# lblEmp = tk.Label(master = window, text= 'Total Employees: ', anchor="w").grid(row=0, column=0)
# txtEmp = tk.Entry(master = window).grid(row=0, column=1)

#txtEmp.insert(0,'1250')
# txtEmp.pack()

#cg.totEmp = int(txtEmp.get())

#frame2.pack()
window.mainloop()

# print(cg.totEmp)
# print(cg.dtStart)

