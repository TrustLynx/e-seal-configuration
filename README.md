# Run performance tests on TrustLynx e-sealing solution using Postman software

Open postman software. Make sure global setting "Read files outside working directory" is enabled.

![image](https://github.com/user-attachments/assets/8c267b74-51f5-4901-ad7f-2d712ba7479b)

Press new and select collection:

![image](https://github.com/user-attachments/assets/2d89bfce-d9cd-485c-a71d-7de311fc00df)

![image](https://github.com/user-attachments/assets/961cef17-7562-4d20-b55c-59c43acbfbc4)

Rename the collection for appropriate name:

![image](https://github.com/user-attachments/assets/0602568a-0c2d-4266-807f-19bc4f4c66c8)

Add new request for collection

![image](https://github.com/user-attachments/assets/f0d7f427-1c53-46f9-88e8-554dec291327)

Define corresponding request using your environment host / port combination. In current example we overview .asice document signing using API
```
api/eseal/document/profile/TrustLynx
```
and profile with name TrustLynx:

![image](https://github.com/user-attachments/assets/4110c1f6-0a6d-491d-9cdb-61fe63fe9846)

Using collection functional menu select option "Run collection":

![image](https://github.com/user-attachments/assets/e7b93182-c146-4d22-aee2-581eb43ece5c)

Configure auto-run collection parameters to fit testing needs: 

![image](https://github.com/user-attachments/assets/5a71fc9b-9ce3-4156-b97d-e3ef7711e951)

Overview the results

![image](https://github.com/user-attachments/assets/890cadb7-0d17-4ee4-9f38-1c1ccaab25b4)

# E-sealing solution modes: TEST and PROD
### TEST mode (DEMO e-seal usb stick should be attached)
Open **container-and-signature-services/application.yml** and adjust timestamp and digidoc4j sections:
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
### PROD mode (Production e-seal usb stick should be attached)
Open **container-and-signature-services/application.yml** and adjust timestamp and digidoc4j sections:
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
Inside timestamp section do not forget to enter real username and password so TSA connectivity would be available. 
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
After making the changes, restart **container-and-signature-services** container.

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
