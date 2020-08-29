import sqlite3 as lite
import random
import string
import numpy as np
import datetime
from dateutil.relativedelta import relativedelta

connIn = lite.connect('../data/Setting.db')
connOut = lite.connect('../output/HRData.db')
ci = connIn.cursor()
co = connOut.cursor()
upper_alphabet = string.ascii_uppercase

def makeEmp(numEmp = 15, dtStart = datetime.datetime(2015, 1, 1)):
    EmpID  = co.execute("SELECT Seq FROM sqlite_sequence WHERE name = 'tbl_Employee'").fetchone()[0]
    for i in range(numEmp):
        GenderID = random.choice([0, 1])
        last_name = ci.execute('SELECT lastname FROM tbl_LastName ORDER by random() LIMIT 1').fetchone()[0]
        if GenderID == 1:
            first_name = ci.execute('SELECT Male FROM tbl_FirstName ORDER by random() LIMIT 1').fetchone()[0]
        else:
            first_name = ci.execute('SELECT female FROM tbl_FirstName ORDER by random() LIMIT 1').fetchone()[0]
        
        EmpName = last_name + ', ' + first_name + ' ' + random.choice(upper_alphabet)
        
        EngDt = makeDate(dtStart,300,dtStart, dtStart + relativedelta(months=+18))
        DepCount = min(round(numEmp/30),10)
        depID = random.randint(1,DepCount)
        DOB = makeDate(EngDt- relativedelta(years=38), 3652, EngDt - relativedelta(years=63), EngDt - relativedelta(years=18))
        RaceID = random.randint(1,5)
        EmpID  = co.execute("SELECT Seq FROM sqlite_sequence WHERE name = 'tbl_Employee'").fetchone()[0] + 1 
        vals = (EmpID, EmpName, GenderID, EngDt.date(), DOB.date(), depID, RaceID)
        co.execute("INSERT INTO  tbl_Employee ('EmpID','EmpName','GenderID', 'EngDt','DOB','depID','RaceID') VALUES (?,?,?,?,?,?,?)", vals)
        co.execute("INSERT INTO  tbl_Action ('ActionID','EmpId', 'EffectiveDt') VALUES (10,?,?)", (vals[0],vals[3]))
        connOut.commit()
    
    makeStructure(DepCount)
    connOut.close()
    connIn.close()
    print('Loaded ' + str(numEmp) + ' employees')

def makeDate(myDate, dtDayDev, dtMin = datetime.date(1900, 1, 1), dtMax=datetime.date(9999, 12, 31)):
    days_to_add = round(np.random.normal(loc = 0, scale = dtDayDev))
    result = myDate + relativedelta(days=+days_to_add) 
    result = max(dtMin, result)
    result = min(dtMax, result)
    return result
    
    
def makeStructure(DepCount1):
    for i in range(1,DepCount1+1):
        L1 = co.execute('SELECT EmpID FROM tbl_Employee WHERE depID =? ORDER by random() LIMIT 1', [i]).fetchone()[0]
        co.execute('UPDATE tbl_Employee SET MgrID = ? , Level = 1 WHERE EmpID = ?',(L1,L1))
        connOut.commit()
        co.execute('UPDATE tbl_Employee SET MgrID = ? , Level = 2 WHERE EmpID in (SELECT EmpID FROM tbl_Employee WHERE depID = ? AND MgrID is NUll ORDER by random() LIMIT 10)',(L1,i))
        L2s = co.execute('SELECT EmpID FROM tbl_Employee WHERE depID = ? AND MgrID = ? ', (i,L1)).fetchall()
        connOut.commit()
        for L2 in L2s:
            co.execute('UPDATE tbl_Employee SET MgrID = ? , Level = 3 WHERE EmpID in (SELECT EmpID FROM tbl_Employee WHERE depID = ? AND MgrID is NUll ORDER by random() LIMIT 10)',(L2[0],i))
            connOut.commit()
        L3s = co.execute('SELECT EmpID FROM tbl_Employee WHERE depID = ? AND Level = 3 ', [i]).fetchall()
        L4s = co.execute('SELECT EmpID FROM tbl_Employee WHERE depID = ? AND Level is null ', [i]).fetchall()
        for L4 in L4s:
            L3 = random.choice(L3s)
            co.execute('UPDATE tbl_Employee SET mgrID = ?, Level = 4 WHERE EmpID = ?', (L3[0],L4[0]))
            connOut.commit()
