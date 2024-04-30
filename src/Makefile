###############################################################################
#For Linux and Mac OS X only (not Windows)                                    #
#To compile the OS-dependent executable:                                      #
#$ make                                                                       #
#To make the Python-version dependent SQLite database:                        #
#$ make run                                                                   #
#To install library and database into appropriate locations:                  #
#$ make install                                                               #
#See document/install.html for more details                                   #
#                                                                             #
#Aaron Hurst <amhurst@berkeley.edu>                                           #
#Department of Nuclear Engineering, UC Berkeley                               #
#March 1, 2017                                                                #
###############################################################################

# C-code variables
CC = gcc
SRC = extension-functions.c shell.c sqlite3.c

OBJECTS = extension-functions.o shell.o sqlite3.o
sqlite3ext_h = extension-functions.o sqlite3.o
sqlite3_h = extension-functions.o shell.o sqlite3.o

# Test for Python version
PY = python
SCRIPT_LIBSQL = define_library.py
python_version_full := $(wordlist 2,4,$(subst ., ,$(shell python --version 2>&1)))
python_version_major := $(word 1,${python_version_full})
python_version_minor := $(word 2,${python_version_full})
python_version_micro := $(word 3,${python_version_full})

ifeq ($(python_version_major), 2)
	SCRIPT_DB = create_atlas_py2.py
	DB = atlas_baghdad_py2.db
endif
ifeq ($(python_version_major), 3)
	SCRIPT_DB = create_atlas_py3.py
	DB = atlas_baghdad_py3.db
endif

# Test for OS kernel name: Linux or Mac OS X only!
UNAME_S := $(shell uname -s)
ifeq ($(UNAME_S), Linux)
	TARGET = libsqlitefunctions.so
	CFLAGS = -O3 -fPIC
	LDFLAGS = -lm -shared
	CCFLAGS += -D LINUX
endif
ifeq ($(UNAME_S), Darwin)
	TARGET = libsqlitefunctions.dylib
	CFLAGS = -O3 -fno-common -dynamiclib -Wno-deprecated-declarations
#	CFLAGS += -Qunused-arguments
	CCFLAGS += -D OSX
endif

UNAME_M := $(shell uname -m)
ifeq ($(UNAME_M), x86_64)
	CCFLAGS += -D AMD64
endif

# Mac OS X users may need to define additional flags according to their 
# installation of SQLite3 and define appropriate rule to make the target.

# If SQLite3 installed via MacPorts, enable the 3 following statements:
#MACPORTS = /opt/local
#CPPFLAGS = -I$(MACPORTS)/include
#LDFLAGS = -L$(MACPORTS)/lib -lsqlite3

# If SQLite3 installed via Fink, enable the 3 following statements instead:
#FINK = /sw
#CPPFLAGS = -I$(FINK)/include
#LDFLAGS = -L$(FINK)/lib -lsqlite3

EXT_DIR = ../UDF/sqlite-amalgamation
NB_DIR = ../notebook_analysis
SQL_DIR = ../sql_codes

export ANNOUNCE_LINUX
export ANNOUNCE_MAC_OSX
export ANNOUNCE_MAC_FAIL
export ANNOUNCE_PYTHON

default: $(TARGET)

$(TARGET): $(OBJECTS)
ifeq ($(UNAME_S), Linux)
	@echo "$$ANNOUNCE_LINUX"
	$(CC) $(CFLAGS) $(CCFLAGS) $(OBJECTS) -o $@ $(LDFLAGS)
endif
ifeq ($(UNAME_S), Darwin)
	@echo "$$ANNOUNCE_MAC_OSX"
	@echo "$$ANNOUNCE_MAC_FAIL"
	$(CC) $(CFLAGS) $(CCFLAGS) $(OBJECTS) -o $@
#	$(CC) $(CFLAGS) $(CCFLAGS) $(CPPFLAGS) $(OBJECTS) -o $@ $(LDFLAGS)
endif

$(sqlite3ext_h): sqlite3ext.h
$(sqlite3_h): sqlite3.h

run:
	@echo "$$ANNOUNCE_PYTHON"
	$(PY) $(SCRIPT_LIBSQL)
	$(PY) $(SCRIPT_DB)

install:
	mkdir -p $(EXT_DIR)/
	install -m 750 $(TARGET) $(EXT_DIR)/
	install -m 750 $(DB) $(NB_DIR)/
	install -m 750 $(DB) $(SQL_DIR)/

.PHONY: clean-all clean clean-pyc clean-sql clean-nb
clean-all: clean clean-pyc clean-sql clean-nb
clean: 
	find . -name $(TARGET) -exec \rm -f {} +
	find . -name '*.o' -exec rm -f {} +
	find . -name '*~' -exec rm -f {} +
	rm -rf $(EXT_DIR)

clean-pyc:
	find . -name '__pycache__' -exec rm -rf {} +
	find . -name '*.pyc' -exec rm -f {} +
	find . -name '*.pyo' -exec rm -f {} +
	find . -name '*~' -exec rm -f {} +

clean-sql:
	find . -name '*.db' -exec rm -f {} +
	find . -name $(DB) -exec rm -f {} +
	rm -f $(NB_DIR)/$(DB)
	rm -f $(SQL_DIR)/$(DB)
	rm -f $(SQL_DIR)/*~

clean-nb:
	rm -f $(NB_DIR)/*.dat
	rm -f $(NB_DIR)/*.pdf
	rm -f $(NB_DIR)/*.png
	rm -rf $(NB_DIR)/.ipynb_checkpoints

help:
	@echo "   default"
	@echo "       Compile shared-object library to enhance SQLite functionality."
	@echo "   run"
	@echo "       Run script on local machine to create SQLite ATLAS."
	@echo "   install"
	@echo "       Install shared-object library to location:"
	@echo "                       BaghdadAtlas/UDF/sqlite-amalgamation"
	@echo "       Install SQLite database to the following two locations:" 
	@echo "                       BaghdadAtlas/sql_codes"
	@echo "                       BaghdadAtlas/notebook_analysis"
	@echo "   clean"
	@echo "       Remove C artifacts."
	@echo "   clean-pyc"
	@echo "       Remove Python artifacts."
	@echo "   clean-sql"
	@echo "       Remove SQLite artifacts."
	@echo "   clean-nb"
	@echo "       Remove artifacts and objects created with Jupyter Notebook."
	@echo "   clean-all"
	@echo "       Remove all C, Python, SQLite artifacts, and Jupyter Notebook objects."

define ANNOUNCE_LINUX

Linux OS detected: appropriate variables defined

endef

define ANNOUNCE_MAC_OSX

Mac OS X detected: appropriate variables defined

endef

define ANNOUNCE_MAC_FAIL

"""
If compilation fails, try defining MACPORTS or FINK variables in Makefile.  
This will depend on whether SQLite3 has been installed using MacPorts or Fink.  
Then enable the following rule to make the TARGET:
       $$(CC) $$(CFLAGS) $$(CCFLAGS) $$(CPPFLAGS) $$(OBJECTS) -o $$@ $$(LDFLAGS)
"""

endef

define ANNOUNCE_PYTHON

Python $(python_version_major) detected: appropriate variables defined

endef
