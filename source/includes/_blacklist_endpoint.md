# BLACKLIST Endpoint

```shell
# The -G option will convert form parameters (-d options) into query parameters.
# The CHECK endpoint is a GET request.
curl -G https://api.abuseipdb.com/api/v2/blacklist \
  -d countMinimum=15 \
  -d maxAgeInDays=60 \
  -d confidenceMinimum=90 \
  -H "Key: $YOUR_API_KEY" \
  -H "Accept: application/json"
```

> This will yield the following JSON response:

```json
{
  "meta": {
    "generatedAt": "2018-12-21T16:00:04+00:00"
  },
  "data": [
    {
      "ipAddress": "5.188.10.179",
      "totalReports": 560,
      "abuseConfidenceScore": 100
    },
    {
      "ipAddress": "185.222.209.14",
      "totalReports": 529,
      "abuseConfidenceScore": 100
    },
    {
      "ipAddress": "191.96.249.183",
      "totalReports": 325,
      "abuseConfidenceScore": 100
    },
    ...
  ]
}
```

The blacklist is the culmination of all of the valiant reporting by AbuseIPDB users. It's a list of the most reported IP addresses.

The body is an array where each element contains the IP address, the total number of reports, and our confidence of abuse score.

We recommend you filter by `abuseConfidenceScore`, which is our calculated evaluation on how abusive the IP is based on the users that reported it ([more](https://www.abuseipdb.com/faq.html#confidence)). We place a hard minimum of 25% on the abuseConfidenceScore. There are two critical reasons for this:

1. **To prevent a handful of reports drastically impacting networks.** If an AbuseIPDB user were to implement a blacklist that includes <25%-rated IPs, their network protocol would easily be swayed by a single or few third-party users. We recommend against the minimum of 25% for most applications. 75%-100% is the recommended range for denial of service.

2. **Performance.** A <25% range is a wide net that would match the vast majority of our database. There are simply too many results for it to be performant or useful.

However, you can also filter by raw report count using `countMinimum`, which effectively gives every distinct reporter an equal weight. There is a hard minimum of 10 reports for the same reasons above.

The `maxAgeInDays` parameter determines how far back in time we go to fetch reports counted for the `countMinimum` parameter.
In this example, we ask for reports no older than 60 days. The default is 30.

In the `meta` block we include `generatedAt` property that lets you check for the freshness of the list, if you'd like.

Subscribers may set the self flag, which configures the blacklist generator to only consider reports from their own account.

## Plaintext Blacklist

```shell
curl -G https://api.abuseipdb.com/api/v2/blacklist \
  -d countMinimum=15 \
  -d maxAgeInDays=60 \
  -d confidenceMinimum=90 \
  -d plaintext \
  -H "Key: $YOUR_API_KEY" \
  -H "Accept: application/json"
```
> or

```shell

curl -G https://api.abuseipdb.com/api/v2/blacklist \
  -d countMinimum=15 \
  -d maxAgeInDays=60 \
  -d confidenceMinimum=90 \
  -H "Key: $YOUR_API_KEY" \
  -H "Accept: text/plain"
```

> to receive

```
5.188.10.179
185.222.209.14
95.70.0.46
191.96.249.183
115.238.245.8
122.226.181.164
122.226.181.167
...
```

If you prefer a simple newline-separated plaintext response. Set the `plaintext` flag via a GET flag or the Accept header.

The generation timestamp will be placed in the HTTP response headers as X-Generated-At.

<aside class="warning">
If you plan into import these IPs into iptables, it is critical that the list is either continually updated or, if it cannot be updated, flushed from iptables. Report value decay over time, cycling out IPs that stop abusing. AbuseIPDB is not responsible for dropped connections from legitimate sources.</aside>

## Blacklist Caching

By default, the blacklist with default parameters is cached for one day. Results for premium subscribers are cached for one hour. The `generatedAt` property is the cache timestamp.

## Blacklist IP Truncation

To conserve bandwidth, the number of IP addresses included in the list is capped to 10,000. Subscribers can overcome this limit. All users can set it between 1 and 10,000 using the `limit` parameter.

## Blacklist Parameters

| field             | required | default | min | max  | subscriber feature                                |
|-------------------|----------|---------|-----|------|---------------------------------------------------|
| maxAgeInDays      | no       | 30      | 1   | 365  | yes                                               |
| countMinimum      | no       | 10      | 10  | 1000 | yes                                               |
| confidenceMinimum | no       | 100     | 25  | 100  | yes                                               |
| limit             | no       | 10,000  | 1   |      | restricted, [see above](#blacklist-ip-truncation) |
| plaintext         |          |         |     |      | no                                                |
| self              |          |         |     |      |                                                   |
