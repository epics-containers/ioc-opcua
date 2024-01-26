
## Register all support components
dbLoadDatabase "dbd/ioc.dbd"
ioc_registerRecordDeviceDriver pdbbase

## Pretty minimal setup: one session with a 200ms subscription on top
opcuaSession OPC1 opc.tcp://172.23.243.75:4840
opcuaSubscription SUB1 OPC1 200

# Switch off security
opcuaOptions OPC1 debug=0
opcuaOptions OPC1 sec-mode=None

## Siemens S7-1500 PLC
dbLoadRecords "$(OPCUA)/exampleTop/db/S7-1500-server.db", "P=OPC:,R=,SESS=OPC1,SUBS=SUB1"

iocInit
