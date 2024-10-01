#!/bin/bash
pcscd --disable-polkit
java --add-exports=jdk.crypto.cryptoki/sun.security.pkcs11.wrapper=ALL-UNNAMED -jar /opt/app/dmss-digital-stamping-service.jar

