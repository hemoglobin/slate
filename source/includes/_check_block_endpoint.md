# CHECK-BLOCK Endpoint

```shell
# The -G option will convert form parameters (-d options) into query parameters.
# The CHECK-BLOCK endpoint is a GET request.
curl -G https://api.abuseipdb.com/api/v2/check-block \
  --data-urlencode "network=1270.0.0.1/16" \
  -d maxAgeInDays=15 \
  -H "Key: $YOUR_API_KEY" \
  -H "Accept: application/json"
```

> This will yield the following JSON response:

```json
  {
    "data": {
      "networkAddress": "127.0.0.0",
      "netmask": "255.255.0.0",
      "minAddress": "127.0.0.1",
      "maxAddress": "127.0.255.254",
      "numPossibleHosts": 65534,
      "addressSpaceDesc": "Loopback",
      "reportedAddress": [
        {
          "ipAddress": "127.0.0.1",
          "numReports": 631,
          "mostRecentReport": "2019-03-21T16:35:16+00:00",
          "abuseConfidenceScore": 0,
          "countryCode": null
        },
        {
          "ipAddress": "127.0.0.2",
          "numReports": 16,
          "mostRecentReport": "2019-03-12T20:31:17+00:00",
          "abuseConfidenceScore": 0,
          "countryCode": null
        },
        {
          "ipAddress": "127.0.0.3",
          "numReports": 17,
          "mostRecentReport": "2019-03-12T20:31:44+00:00",
          "abuseConfidenceScore": 0,
          "countryCode": null
        },
        ...
      ]
    }
  }
```

The `check-block` endpoint accepts a subnet (v4 or v6) denoted with CIDR notation.

The `maxAgeInDays` parameter determines how old the reports considered in the query search can be.

The desired data is stored in the `data` property. Here you can inspect details regarding the network queried, such as the netmask of the subnet, the number of hosts it can possibly contain, and the assigned description of the address space.

The network should be url-encoded, because the network parameter contains a forward slash, which is a reserved character in URIs.

### Check-Block Parameters

| field        | required | default | min | max |
|--------------|----------|---------|-----|-----|
| network      | yes      |         |     |     |
| maxAgeInDays | no       | 30      | 1   | 365 |

### Check-Block Limits

Due to the depth & breath of the these searches, the range of the parameters is capped by plan tier.

For most use cases, /24 is enough to an entire network. Many autonomous systems will sometimes have blocks of /20. Some of the largest autonomous systems will have blocks of /18 or /17.

| field        | Standard  | Basic Subscription | Premium Subscription |
|--------------|-----------|--------------------|----------------------|
| network      | Up to /24 | Up to /20          | Up to /16            |
| maxAgeInDays | Up to 30  | Up to 60           | Up to 365            |

Exceeding a parameter limit will return a 402 Payment Required response.
