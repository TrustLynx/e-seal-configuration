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

# External addresses 

### These addresses should be opened from the server with deployed TL containers:

- https://ec.europa.eu - Trusted lists (TSLs) of every EU member state
- https://trustlist.gov.lv/tsl/latvian-tsl.xml - Latvian Trusted Service List
- https://tsa-com.eparaksts.lv/ - Time Stamping Authority (TSA) service provided by eParaksts
