# -*- coding: utf-8 -*-
"""
Created on Sat Aug 15 21:50:03 2020

@author: david
"""
import Config as cg
import CreateEmp as ce
import datetime
import sqlite3 as lite
import random



def GenerateAttrition(fdyear):
    connIn = lite.connect('../data/Setting.db')
    connOut = lite.connect('../output/HRData.db')
    ci = connIn.cursor()
    co = connOut.cursor()
    for e in range(int(cg.totEmp *  cg.pctChange)):
        #sets the termination date with a random date +-3 months from the period it refers to. Starting from June.
        termDt = ce.makeDate(datetime.date(fdyear,6,30), 90)
        tEmp = co.execute('SELECT EmpID, EngDt FROM tbl_Employee ORDER by random() LIMIT 1').fetchone()
        if termDt > datetime.datetime.strptime(tEmp[1], '%Y-%m-%d').date():
            co.execute('UPDATE tbl_Employee SET TermDt = ?, EmpStatus = 0 WHERE EmpID = ?',(termDt,tEmp[0]))
            co.execute("INSERT INTO tbl_Action ('ActionID','EmpID','EffectiveDt') VALUES (?,?,?)",(random.choice([90,91]) ,tEmp[0],termDt))
            connOut.commit()
    connOut.close()
    connIn.close()
    print('Generated attrition for ' + str(fdyear) + ' periods')
 
def GenerateRating(fdyear):
    connIn = lite.connect('../data/Setting.db')
    connOut = lite.connect('../output/HRData.db')
    ci = connIn.cursor()
    co = connOut.cursor()
    #this generates performace. Takes all the active employees in a given time.  
    totEmp = co.execute('SELECT COUNT(*) FROM Tbl_Employee WHERE EmpStatus = 1').fetchone()[0]
    #paste all the active employees to the Perf table
    co.execute("INSERT INTO tbl_Perf ('EmpID', 'PerfDate') SELECT E.EmpID, ? FROM tbl_Employee E WHERE E.EmpStatus = 1", [fdyear])
    #distributes ratings 10%-5 20%-4 40%-3 20%-2 10%-1
    co.execute("UPDATE tbl_Perf SET Rating = 5 WHERE EmpID in (SELECT EmpID FROM tbl_Perf WHERE Rating Is Null ORDER by random() LIMIT ?)",[int(totEmp * 0.1)])
    co.execute("UPDATE tbl_Perf SET Rating = 4 WHERE EmpID in (SELECT EmpID FROM tbl_Perf WHERE Rating Is Null ORDER by random() LIMIT ?)",[int(totEmp * 0.2)])
    co.execute("UPDATE tbl_Perf SET Rating = 3 WHERE EmpID in (SELECT EmpID FROM tbl_Perf WHERE Rating Is Null ORDER by random() LIMIT ?)",[int(totEmp * 0.4)])
    co.execute("UPDATE tbl_Perf SET Rating = 2 WHERE EmpID in (SELECT EmpID FROM tbl_Perf WHERE Rating Is Null ORDER by random() LIMIT ?)",[int(totEmp * 0.2)])
    co.execute("UPDATE tbl_Perf SET Rating = 1 WHERE Rating Is Null")
    connOut.commit()
    connOut.close()
    connIn.close()