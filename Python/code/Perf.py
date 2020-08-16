# -*- coding: utf-8 -*-
"""
Created on Wed Aug 12 21:09:25 2020

@author: david
"""
from timeit import default_timer as timer
from datetime import datetime

def LogDuration(start_time, action = '', parameter = ''):
    with open("../output/Perf.txt", "a") as file_object:
        strToWrite = action 
        strToWrite = strToWrite + '|' + str(parameter)
        strToWrite = strToWrite + '|' + str(timer() - start_time)
        strToWrite = strToWrite + '|' + datetime.now().strftime("%d/%m/%Y %H:%M:%S")
        strToWrite = strToWrite +'\n'
        file_object.write(strToWrite)