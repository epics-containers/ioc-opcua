#!/epics/ioc-ts99i-ps-01/ioc/bin/linux-x86_64/opcuaIoc

## You may have to change opcuaIoc to something else
## everywhere it appears in this file

cd /epics/ioc-ts99i-ps-01/ioc

< iocBoot/iocUaDemoServer/envPaths


## Register all support components
dbLoadDatabase "dbd/opcuaIoc.dbd"
opcuaIoc_registerRecordDeviceDriver pdbbase

# Pretty minimal setup: one session with a 200ms subscription on top
#opcuaSession OPC1 opc.tcp://localhost:48010
opcuaSession OPC1 opc.tcp://DIAMRD2882:48010
opcuaSubscription SUB1 OPC1 200

# Alternative session for Omron PLC in G.13
opcuaSession OPC2 opc.tcp://172.23.243.75:4840
opcuaSubscription SUB2 OPC2 200

# Switch off security
opcuaOptions OPC1 sec-mode=None
opcuaOptions OPC2 sec-mode=None

# Load the databases for the UaServerCpp demo server

dbLoadRecords "db/UaDemoServer-server.db", "P=OPC:,R=,SESS=OPC1,SUBS=SUB1"
dbLoadRecords "db/Demo.Dynamic.Arrays.db", "P=OPC:,R=DDA:,SESS=OPC1,SUBS=SUB1"
dbLoadRecords "db/Demo.Dynamic.Scalar.db", "P=OPC:,R=DDS:,SESS=OPC1,SUBS=SUB1"
dbLoadRecords "db/Demo.Static.Arrays.db", "P=OPC:,R=DSA:,SESS=OPC1,SUBS=SUB1"
dbLoadRecords "db/Demo.Static.Scalar.db", "P=OPC:,R=DSS:,SESS=OPC1,SUBS=SUB1"

dbLoadRecords "db/Demo.WorkOrder.db", "P=OPC:,SESS=OPC1,SUBS=SUB1"

# DO NOT LOAD THESE DBs ON EPICS BASE < 7.0     \/  \/  \/     EPICS 7 ONLY
# int64 and long string records need EPICS 7
dbLoadRecords "db/Demo.Dynamic.ScalarE7.db", "P=OPC:,R=DDS:,SESS=OPC1,SUBS=SUB1"
dbLoadRecords "db/Demo.Dynamic.ArraysE7.db", "P=OPC:,R=DDA:,SESS=OPC1,SUBS=SUB1"
dbLoadRecords "db/Demo.Static.ScalarE7.db", "P=OPC:,R=DSS:,SESS=OPC1,SUBS=SUB1"
dbLoadRecords "db/Demo.Static.ArraysE7.db", "P=OPC:,R=DSA:,SESS=OPC1,SUBS=SUB1"

# Extra records for Omron PLC.
#dbLoadRecords "db/OmronServer.db", "P=OPC2:,R=,SESS=OPC2,SUBS=SUB2"
dbLoadRecords "db/Omron_DS.db", "P=OPC2:,R=DS:,SESS=OPC2,SUBS=SUB2"

iocInit
