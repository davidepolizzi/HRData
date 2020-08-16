# -*- coding: utf-8 -*-
"""
Created on Wed Aug 12 21:28:36 2020

@author: david
"""

import sqlite3 as lite

connIn = lite.connect('../data/Setting.db')
connOut = lite.connect('../output/HRData.db')
ci = connIn.cursor()
co = connOut.cursor()

def reset(bolAll = False):
    co.execute('DELETE FROM tbl_Employee')
    co.execute('UPDATE sqlite_sequence SET seq = 0')
    connOut.commit()
    connOut.close()