#!/bin/bash
#Define SQL script you want to run on next line:
#SQL_SCRIPT=getCountingStats.sql
#SQL_SCRIPT=getU_CS_VarsErr.sql
SQL_SCRIPT=getGammas56Fe_0.sql

location=../src
script=check_py_version.py
python ${location}/${script}
DB=$(python ${location}/${script} | awk '{if ($4==2) print "atlas_baghdad_py2.db"; else if ($4==3) print "atlas_baghdad_py3.db";}')
echo "Using SQLite database: "$DB

sqlite3 -column -header $DB < $SQL_SCRIPT
