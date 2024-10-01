#!/bin/bash
pcscd --disable-polkit
utnm -c "set autoconnect=true  86.52.89.4 1"
utnm -c "set autoconnect=true  86.52.89.4 2"
java --add-exports=jdk.crypto.cryptoki/sun.security.pkcs11.wrapper=ALL-UNNAMED -jar /opt/app/dmss-digital-stamping-service.jar

