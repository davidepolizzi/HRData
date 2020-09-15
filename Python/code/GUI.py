# -*- coding: utf-8 -*-
"""
Created on Sun Sep  6 20:56:43 2020

@author: david
"""
import tkinter as tk
import Config as cg

def StartGUI():
        
    window = tk.Tk()
    window.title("Set parameters for app.")
    window.geometry('400x500')
    
    txtEmp = tk.IntVar()
    txtPeriod = tk.IntVar()
    bolGenBias = tk.BooleanVar()
    
    def Submit_Button():
        cg.periods = int(txtPeriod.get())
        cg.totEmp = int(txtEmp.get())
        cg.bolGenderBias = bool(bolGenBias.get())

        #window.withdraw()

       
    widgets = ([0,txtEmp,'Total Employees: ',(1000,10000,500.0),'spin'],
               [1,txtPeriod,'Total Periods: ',(3,10,1),'spin'],
               [2,bolGenBias,'Gender Bias: ',True,'check'],
               [3,Submit_Button,'Submit','','button'])
    
    def add_widget(wid):
        if wid[-1] == 'entry':
            tk.Label(master = window, text = wid[2]).grid(row = wid[0],sticky=tk.W)
            temp = tk.Entry(master = window, textvariable=wid[1])
            temp.grid(row = wid[0], column=1,sticky=tk.W)
            temp.insert(0, wid[3])
        elif wid[-1] == 'spin':
            tk.Label(master = window, text = wid[2]).grid(row = wid[0], sticky=tk.W)
            temp = tk.Spinbox(master = window, textvariable=wid[1], from_=wid[3][0], to_=wid[3][1], increment=wid[3][2])
            temp.grid(row = wid[0], column=1,sticky=tk.W)
            #print(wid[1].get())
        elif  wid[-1] == 'check':
            tk.Label(master = window, text = wid[2]).grid(row = wid[0],sticky=tk.W)
            temp = tk.Checkbutton(master = window, variable=wid[1])
            temp.grid(row = wid[0], column=1,sticky=tk.W)
        elif wid[-1] == 'button':
            tk.Button(master = window, text = wid[2], command = wid[1]).grid(row = wid[0], sticky=tk.W)
        else:
            print('one entry not recognized')
    
    for w in widgets:
        add_widget(w)
    
    window.mainloop()
    window.quit()
   # window.destroy()
   # window.withdraw()