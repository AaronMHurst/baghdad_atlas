""""
     For PYTHON 2:
     Python script to generate an SQL database for the (n,n'g) 
     "Atlas of Gamma-Ray Spectra from the Inelastic Scattering of Reactor Fast 
     Neutrons", by A. M. Demidov et al.

     Author: A. M. Hurst
     Date: March 1, 2017
     Email: amhurst@berkeley.edu

     Date: March 7, 2020
     Changed 'compound' and 'compound_type' variable names
     to 'residual' and 'residual_type', respectively.
"""
from __future__ import print_function
from time import time, sleep
from datetime import timedelta
import csv, sqlite3
import os, glob
import errno
import setup

class Delete(object):
    """Class to handle removal of database if something gets screwed up."""
    def __init__(self,db):
        self.db = db
        print("Database: {0}".format(str(db)))
        
    def remove_db(self):
        print("Database will be removed in:")
        for s in range(3,0,-1):
            print(s)
            sleep(1)
        os.system("rm -f {0}".format(str(self.db)))
        print("Goodbye :(")
        exit()

db = str("atlas_baghdad_py2.db")
conn = sqlite3.connect(db)
curs = conn.cursor()

curs.execute("DROP TABLE IF EXISTS nucleus;")
curs.execute("DROP TABLE IF EXISTS sample;")

curs.execute("CREATE TABLE nucleus (id INTEGER PRIMARY KEY,\n\tnuc_symb CHAR(2),\n\tnuc_Z INTEGER,\n\tenergy_gamma FLOAT,\n\td_energy_gamma FLOAT,\n\tintensity_gamma FLOAT,\n\td_intensity_gamma FLOAT,\n\ttransition_type CHAR(2),\n\tresidual CHAR(16),\n\tresidual_type CHAR(2),\n\tenergy_ex FLOAT,\n\tex_type CHAR(2),\n\tsample CHAR(1));\n")
curs.execute("CREATE TABLE sample (id INTEGER PRIMARY KEY,\n\tflag CHAR(1),\n\telement TEXT,\n\tZ INTEGER,\n\tsymbol TEXT,\n\tN FLOAT,\n\tdN FLOAT,\n\te_gamma_norm FLOAT,\n\tA INTEGER,\n\tmass FLOAT,\n\texposure_time FLOAT,\n\tenrichment FLOAT,\n\tsample_composition TEXT,\n\tisotope_norm TEXT);\n")


files = list()
file_path = str('../CSV_DATA/')
for data_file in glob.glob(str(file_path+"Z*.csv")): files.append(data_file)
sorted_files = sorted(files)

start_time = time()
for f in sorted_files:
    try:
        reader = csv.reader(open(f, mode='r'), delimiter = '\t')

        if reader:
            print("File: %s successfully opened"%(f))
        
            for row in reader:
                if row[0] != 'X':
                    try:
                        to_db = [unicode(row[0], "utf8"), int(row[1]), float(row[2]), float(row[3]), float(row[4]), float(row[5]), unicode(row[6], "utf8"), unicode(row[7], "utf8"), unicode(row[8], "utf8"), float(row[9]), unicode(row[10], "utf8"), unicode(row[11], "utf8")]
                    except ValueError:
                        if str(row[9]).strip() == str('?'):
                            to_db = [unicode(row[0], "utf8"), int(row[1]), float(row[2]), float(row[3]), float(row[4]), float(row[5]), unicode(row[6], "utf8"), unicode(row[7], "utf8"), unicode(row[8], "utf8"), unicode(row[9], "utf8"), unicode(row[10], "utf8"), unicode(row[11], "utf8")]
                        else:
                            raise

                    curs.execute("INSERT INTO nucleus (nuc_symb, nuc_Z, energy_gamma, d_energy_gamma, intensity_gamma, d_intensity_gamma, transition_type, residual, residual_type, energy_ex, ex_type, sample) VALUES (?,?,?,?,?,?,?,?,?,?,?,?);", to_db)
                    conn.commit()

                else:
                    to_db = [unicode(row[0],"utf8"), unicode(row[1],"utf8"), int(row[2]), unicode(row[3],"utf8"), float(row[4]), float(row[5]), float(row[6]), int(row[7]), float(row[8]), float(row[9]), float(row[10]), unicode(row[11], "utf8"), unicode(row[12], "utf8")]
                    curs.execute("INSERT INTO sample (flag, element, Z, symbol, N, dN, e_gamma_norm, A, mass, exposure_time, enrichment, sample_composition, isotope_norm) VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?);", to_db)
                    conn.commit()

    except IOError as e:
        if e.errno == errno.ENOENT:
            print(errno.ENOENT, os.strerror(errno.ENOENT))
            if errno.ENOENT == 2:
                print("file: {0} not found".format(f))
            Delete(db).remove_db()

        else:
            print(errno.ENOENT, os.strerror(errno.ENOENT), 
                  "\nSomething went wrong!")
            Delete(db).remove_db()
            raise

conn.close()

end_time = time()
execution_time = end_time - start_time
print("Execution time (serial) = {0} s".format(execution_time))
print("Execution time: {0}".format(str(timedelta(seconds=execution_time))))
