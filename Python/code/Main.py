#Main -*- coding: utf-8 -*-
"""
Created on Sun Aug  9 22:04:38 2020

@author: Davide Polizzi
"""

import CreateEmp as ce
import ActionCreation as ac
import Perf
import ResetDB
from timeit import default_timer as timer
import Config as cg
import GUI

start_time = timer()
# GUI.StartGUI()

ResetDB.reset()
Perf.LogDuration(start_time,'ResetDB')

start_time = timer()
ce.makeEmp(cg.totEmp)    
Perf.LogDuration(start_time,'CreateEmp', cg.totEmp)

start_time = timer()
for p in range(cg.periods):
    ac.GenerateRating(cg.dtStart.year + p)
    ac.GenerateAttrition(cg.dtStart.year + p)
Perf.LogDuration(start_time,'ActionCreation', cg.periods)