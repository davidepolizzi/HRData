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

frame2 = tk.Frame(master=window, width=500, height = 400, relief = tk.RAISED, borderwidth=1)

#frame2.grid(row=0, column=0)

lblEmp = tk.Label(master = frame2, text= 'Total Employees', anchor="w").grid(row=0, column=0)
txtEmp = tk.Entry(master = frame2).grid(row=0, column=1)

#txtEmp.insert(0,'1250')
# txtEmp.pack()

# cg.totEmp = int(txtEmp.get())

frame2.pack()
window.mainloop()

print(cg.totEmp)
print(cg.dtStart)