#!../../bin/linux-x86_64/opcuaIoc

## You may have to change opcuaIoc to something else
## everywhere it appears in this file

cd /epics/ioc-ts99i-ps-01/ioc

< iocBoot/iocS7-1500/envPaths

## Register all support components
dbLoadDatabase "dbd/opcuaIoc.dbd"
opcuaIoc_registerRecordDeviceDriver pdbbase

## Pretty minimal setup: one session with a 200ms subscription on top
#opcuaSession OPC1 opc.tcp://localhost:4840
opcuaSession OPC1 opc.tcp://172.23.241.219:4840
opcuaSubscription SUB1 OPC1 200

# Switch off security
opcuaOptions OPC1 debug=1
opcuaOptions OPC1 sec-mode=None
# Use authenticaton
opcuaOptions OPC1 sec-mode=SignAndEncrypt
#opcuaOptions OPC1 sec-mode=best
opcuaOptions OPC1 sec-policy=Basic256Sha256
opcuaOptions OPC1 sec-id=iocBoot/iocS7-1500/auth.txt
opcuaSetupPKI /home/karb45/.config/unifiedautomation/uaexpert/PKI
#opcuaClientCertificate iocBoot/iocS7-1500/cert.pem iocBoot/iocS7-1500/private_key.pem
opcuaClientCertificate /home/karb45/.config/unifiedautomation/uaexpert/PKI/own/certs/cert.pem /home/karb45/.config/unifiedautomation/uaexpert/PKI/own/private/private_key.pem

## Load the databases for one of the examples

## Siemens S7-1500 PLC
dbLoadRecords "db/S7-1500-server.db", "P=OPC:,R=,SESS=OPC1,SUBS=SUB1"
#dbLoadRecords "db/S7-1500-DB1.db", "P=OPC:,R=DB1:,SESS=OPC1,SUBS=SUB1"

iocInit
#######
