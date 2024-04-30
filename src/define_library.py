# Define load_extension() method in SQL scripts depending on host OS test.
# Aaron Hurst <amhurst@berkeley.edu>
from __future__ import print_function
import os, glob
import subprocess
import fileinput
import sys

# Linux executable
LINUX_ON = str("SELECT load_extension('../UDF/sqlite-amalgamation/libsqlitefunctions.so');")
LINUX_OFF = str("/*SELECT load_extension('../UDF/sqlite-amalgamation/libsqlitefunctions.so');*/")

# Mac OS X executable
MACOSX_ON = str("SELECT load_extension('../UDF/sqlite-amalgamation/libsqlitefunctions.dylib');")
MACOSX_OFF = str("/*SELECT load_extension('../UDF/sqlite-amalgamation/libsqlitefunctions.dylib');*/")

LINUX = False
MACOSX = False

OS = str(subprocess.check_output(['uname']))
try:
    OS = OS.split("\'")[1].strip("\\n").strip()
except IndexError:
    if OS.strip() == str('Linux'): pass
    elif OS.strip() == str('Darwin'): pass
    else: raise

if OS.strip() == str('Linux'): LINUX, MACOSX = True, False
elif OS.strip() == str('Darwin'): LINUX, MACOSX = False, True
else:
    print(str(os.system("uname -s")).strip())
    print("OS: {0} SQL extension-function methods not implemented".format(OS))
    print("SQL scripts assume Linux exectutable defined in load_extension() method")
    exit()

sql_files = list()
file_path = str('../sql_codes/')
for sql_file in glob.glob(str(file_path+"*.sql")): sql_files.append(sql_file)
sorted_sql_files = sorted(sql_files)

file_count, func_count = 0, 0
if LINUX == True:
    for sql_file in sorted_sql_files:
        with open(sql_file, mode = 'rt') as f:
            file_count += 1
            for line in fileinput.input("%s"%str(sql_file), inplace=1):
                if LINUX_OFF in line:
                    func_count += 1
                    line = line.replace(LINUX_OFF, LINUX_ON)
                if MACOSX_OFF in line: pass
                elif MACOSX_ON in line:
                    line = line.replace(MACOSX_ON, MACOSX_OFF)
                sys.stdout.write(line)
            else: pass
        f.close()

    #print("Amended {0}/{1} SQL files".
    #          format(int(func_count),int(file_count)))
    print("Linux executable defined for load_extension() method in SQL scripts")

elif MACOSX == True:
    for sql_file in sorted_sql_files:
        with open(sql_file, mode = 'rt') as f:
            file_count += 1
            for line in fileinput.input("%s"%str(sql_file), inplace=1):
                if MACOSX_OFF in line:
                    func_count += 1
                    line = line.replace(MACOSX_OFF, MACOSX_ON)
                if LINUX_OFF in line: pass
                elif LINUX_ON in line:
                    line = line.replace(LINUX_ON, LINUX_OFF)
                sys.stdout.write(line)
            else: pass
        f.close()

    #print("Amended {0}/{1} SQL files".
    #      format(int(func_count),int(file_count)))
    print("Mac OS X executable defined for load_extension() method in SQL scripts")
