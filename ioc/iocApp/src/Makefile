

# Makefile automatically generated using
# git@github.com:epics-containers/ibek-support.git

TOP = ../..
include $(TOP)/configure/CONFIG

PROD_IOC = ioc
DBD += ioc.dbd
ioc_DBD += base.dbd

ioc_DBD += devIocStats.dbd
ioc_DBD += opcua.dbd

ioc_SRCS += ioc_registerRecordDeviceDriver.cpp
ioc_SYS_LIBS_Linux += xml2 crypto

ioc_LIBS += opcua
ioc_LIBS += devIocStats


ioc_LIBS += $(EPICS_BASE_IOC_LIBS)
ioc_SRCS += iocMain.cpp

include $(TOP)/configure/RULES