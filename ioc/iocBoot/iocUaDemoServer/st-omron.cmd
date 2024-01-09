#!/epics/ioc-ts99i-ps-01/ioc/bin/linux-x86_64/opcuaIoc

cd /epics/ioc-ts99i-ps-01/ioc

< iocBoot/iocUaDemoServer/envPaths


## Register all support components
dbLoadDatabase "dbd/opcuaIoc.dbd"
opcuaIoc_registerRecordDeviceDriver pdbbase

# Alternative session for Omron PLC in G.13
opcuaSession OPC2 opc.tcp://172.23.243.75:4840
opcuaSubscription SUB2 OPC2 200

# Switch off security
opcuaOptions OPC2 debug=1
#opcuaOptions OPC2 sec-mode=SignAndEncrypt
opcuaOptions OPC2 sec-mode=None
#opcuaOptions OPC2 sec-policy=Basic256Sha256
#opcuaOptions OPC2 sec-id=iocBoot/iocUaDemoServer/auth.txt
opcuaSetupPKI /home/karb45/.config/unifiedautomation/uaexpert/PKI
#opcuaClientCertificate iocBoot/iocUaDemoServer/cert.pem iocBoot/iocUaDemoServer/private_key.pem
opcuaClientCertificate /home/karb45/.config/unifiedautomation/uaexpert/PKI/own/certs/cert.der /home/karb45/.config/unifiedautomation/uaexpert/PKI/own/private/private_key.pem

# Load the databases for the UaServerCpp demo server

#dbLoadRecords "db/UaDemoServer-server.db", "P=OPC:,R=,SESS=OPC1,SUBS=SUB1"
#dbLoadRecords "db/Demo.Dynamic.Arrays.db", "P=OPC:,R=DDA:,SESS=OPC1,SUBS=SUB1"
#dbLoadRecords "db/Demo.Dynamic.Scalar.db", "P=OPC:,R=DDS:,SESS=OPC1,SUBS=SUB1"
#dbLoadRecords "db/Demo.Static.Arrays.db", "P=OPC:,R=DSA:,SESS=OPC1,SUBS=SUB1"
#dbLoadRecords "db/Demo.Static.Scalar.db", "P=OPC:,R=DSS:,SESS=OPC1,SUBS=SUB1"

#dbLoadRecords "db/Demo.WorkOrder.db", "P=OPC:,SESS=OPC1,SUBS=SUB1"

# DO NOT LOAD THESE DBs ON EPICS BASE < 7.0     \/  \/  \/     EPICS 7 ONLY
# int64 and long string records need EPICS 7
#dbLoadRecords "db/Demo.Dynamic.ScalarE7.db", "P=OPC:,R=DDS:,SESS=OPC1,SUBS=SUB1"
#dbLoadRecords "db/Demo.Dynamic.ArraysE7.db", "P=OPC:,R=DDA:,SESS=OPC1,SUBS=SUB1"
#dbLoadRecords "db/Demo.Static.ScalarE7.db", "P=OPC:,R=DSS:,SESS=OPC1,SUBS=SUB1"
#dbLoadRecords "db/Demo.Static.ArraysE7.db", "P=OPC:,R=DSA:,SESS=OPC1,SUBS=SUB1"

# Extra records for Omron PLC.
#dbLoadRecords "db/OmronServer.db", "P=OPC2:,R=,SESS=OPC2,SUBS=SUB2"
dbLoadRecords "db/Omron_DS.db", "P=OPC2:,R=DS:,SESS=OPC2,SUBS=SUB2"

iocInit
