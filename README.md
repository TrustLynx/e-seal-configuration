# Solution modes: TEST and PROD
## TEST mode (DEMO e-seal usb stick should be attached)
### Open container-and-signature-services/application.yml and adjust timestamp and digidoc4j sections:
```
timestamp:
  timestampProviders:
    -
      tspSource: http://tsa.demo.sk.ee/tsa
```
```
digidoc4j:
  configuration:
    mode: TEST
    #file: ./src/main/resources/digidoc4j-custom.yaml
    #Additional CAs trusted. Use only in TEST mode to enable test certificates OCSP success
    trustedCACerts:
      - classpath:certs/DEMO_eParaksts_ICA_2017.cer
      - classpath:certs/DEMO_eParaksts_Root_CA.cer
      - classpath:certs/Test_Root_CA.cer
      - classpath:certs/Test_Env_Root_CA_OCSP_2020.cer
      - classpath:certs/Test_Issuing_CA.cer
      - classpath:certs/Test_ocsp_certificate.cer
      - classpath:certs/LV_ePM_CA_Cert.cer
      - classpath:certs/LV_ePM_Cert.cer
      - classpath:certs/Test_Zealid_TSA_CA_OCSP.cer
      - classpath:certs/ZealiD_Test_Env_OCSP_Certificate_Signing.cer
      - classpath:certs/Zeal_ID_Test_Root_CA_HSM.cer
      - classpath:certs/Zeal_ID_Test_Issuing_CA.cer
      - classpath:certs/ZealiD_OCSP_Issuing_2020.cer
      - classpath:certs/zealid_issuer.cer
      - classpath:certs/Test_of_SK_ORG2.cer
      - classpath:certs/Test_of_SK_ROOT.cer
```
## PROD mode (Production e-seal usb stick should be attached)
### Open container-and-signature-services/application.yml and adjust timestamp and digidoc4j sections:
```
timestamp:
  timestampProviders:
    -
      tspSource: https://tsa-com.eparaksts.lv/
      authentications:
        - protocol: https
          host: tsa-com.eparaksts.lv
          port: 443
          scheme: Basic
          realm: KeyOneSystem
          username: username
          password: password
```
```
digidoc4j:
  configuration:
    # Digidoc4j mode, PROD or TEST
    mode: PROD
    #file: "/confs/digidoc4j-custom.yaml"
    # Custom digidoc4j configuration file, more info http://open-eid.github.io/digidoc4j/org/digidoc4j/Configuration.html
    #    file: "./src/main/resources/digidoc4j-custom.yaml"
    #   file: "/confs/digidoc4j-custom.yaml"
    # Preferred AIA ocsp source or SK payed service. true - AIA OCSP, false SK payed service
    preferAiaOcsp: true
    issuers:
```


# TimeStamp configuration

Open **/opt/trustlynx/stamping-service/container-and-signature-services/application.yml** configuration file and fill username and password values under timestamp section (these values should be recieved from a TSA):

```
timestamp:
  timestampProviders:
    -
      tspSource: http://tsa.demo.sk.ee/tsa
    -
      tspSource: https://tsa-com.eparaksts.lv/
      authentications:
        - protocol: https
          host: tsa-com.eparaksts.lv
          port: 443
          scheme: Basic
          realm: KeyOneSystem
          username: username
          password: password
```
After making the changes, restart **container-and-signature-services** container.

# External addresses 

### These addresses should be accessable from the server with deployed TL containers:

- https://ec.europa.eu - Trusted lists (TSLs) of every EU member state
- https://trustlist.gov.lv/tsl/latvian-tsl.xml - Latvian Trusted Service List
- https://tsa-com.eparaksts.lv/ - Time Stamping Authority (TSA) service provided by eParaksts
