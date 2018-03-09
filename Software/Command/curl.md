POST with json, well I didn't really test this one
======
* Make sure single quote is used when passing json body
* -v means verbose
* -insecure means don't check certificate of this connection
```sh
curl -v https://hanshih.management.azure-api.net/api/Assets -X POST \
    --insecure \
    -H "Content-Type: application/json; charset=utf-8" \
    -H "DataServiceVersion:1.0;NetFx" \
    -H "MaxDataServiceVersion:3.0;NetFx" \
    -H "Accept:application/json" \
    -H "Accept-Charset:UTF-8" \
    -H "User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_3) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/44.0.2403.89 Safari/537.36" \
    -H "x-ms-version:2017-07-29" \
    -H "x-ms-client-request-id:08c7535c-f1db-4064-9121-0507f3ea9b36" \
    -H "Host:hanshih.restv2.japanwest.media.azure.net" \
    -H "Content-Length:46" \
    -H "Authorization: eyJ0eXAiOiJKV1QiLC" \
    -d \
    '
    {
        "Name":"03_two_scenarios.mp4", "Options":"0"
    }
    '
```
