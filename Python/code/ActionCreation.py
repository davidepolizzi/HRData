# -*- coding: utf-8 -*-
"""
Created on Sat Aug 15 21:50:03 2020

@author: david
"""
import Config as cg
import CreateEmp as ce
import datetime
import sqlite3 as lite

connIn = lite.connect('../data/Setting.db')
connOut = lite.connect('../output/HRData.db')
ci = connIn.cursor()
co = connOut.cursor()

def GenerateAttrition(dum):
    for p in range(cg.periods):     
        for e in range(int(cg.totEmp *  cg.pctChange)):   
            termDt = ce.makeDate(cg.dtStart + datetime.timedelta(days=180) + datetime.timedelta(days=365 * p), 90)
            tEmp = co.execute('SELECT EmpID, EngDt FROM tbl_Employee ORDER by random() LIMIT 1').fetchone()
            if termDt > tEmp[1]:
                co.execute('UPDATE tbl_Employee SET TermDt = ? WHERE EmpID = ?',(termDt,tEmp[0]))
                connOut.commit()
    connOut.close()
    connIn.close()
    print('Generated attrition for ' + str(cg.periods) + ' periods')
    
