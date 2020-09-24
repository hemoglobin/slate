# BLACKLIST Endpoint

```shell
# The -G option will convert form parameters (-d options) into query parameters.
# The BLACKLIST endpoint is a GET request.
curl -G https://api.abuseipdb.com/api/v2/blacklist \
  -d confidenceMinimum=90 \
  -H "Key: $YOUR_API_KEY" \
  -H "Accept: application/json"
```

```python
import requests
import json

# Defining the api-endpoint
url = 'https://api.abuseipdb.com/api/v2/blacklist'

querystring = {
    'confidenceMinimum':'90'
}

headers = {
    'Accept': 'application/json',
    'Key': '$YOUR_API_KEY'
}

response = requests.request(method='GET', url=url, headers=headers, params=querystring)

# Formatted output
decodedResponse = json.loads(response.text)
print json.dumps(decodedResponse, sort_keys=True, indent=4)
```

```php
<?php
$client = new GuzzleHttp\Client([
  'base_uri' => 'https://api.abuseipdb.com/api/v2/'
]);

$response = $client->request('GET', 'blacklist', [
	'query' => [
		'confidenceMinimum' => '90'
	],
	'headers' => [
		'Accept' => 'application/json',
		'Key' => $YOUR_API_KEY
  ],
]);

$output = $response->getBody();
// Store response as a PHP object.
$blacklist = json_decode($output, true);
?>
```

```csharp
using System;
using RestSharp;
using Newtonsoft.Json;

public class BlacklistEndpoint
{
    public static void Main()
    {
        var client = new RestClient("https://api.abuseipdb.com/api/v2/blacklist");
        var request = new RestRequest(Method.GET);
        request.AddHeader("Key", "YOUR_API_KEY");
        request.AddHeader("Accept", "application/json");
        request.AddParameter("confidenceMinimum", "90");

        IRestResponse response = client.Execute(request);

        dynamic parsedJson = JsonConvert.DeserializeObject(response.Content);

        foreach (var item in parsedJson)
        {
            Console.WriteLine(item);
        }
    }
}
```

> This will yield the following JSON response:

```json
{
  "meta": {
    "generatedAt": "2020-09-24T19:54:11+00:00"
  },
  "data": [
    {
      "ipAddress": "5.188.10.179",
      "abuseConfidenceScore": 100,
      "lastReportedAt": "2020-09-24T19:17:02+00:00"
    },
    {
      "ipAddress": "185.222.209.14",
      "abuseConfidenceScore": 100,
      "lastReportedAt": "2020-09-24T19:17:02+00:00"
    },
    {
      "ipAddress": "191.96.249.183",
      "abuseConfidenceScore": 100,
      "lastReportedAt": "2020-09-24T19:17:01+00:00"
    },
    ...
  ]
}
```

The blacklist is the culmination of all of the valiant reporting by AbuseIPDB users. It's a list of the most reported IP addresses.

The body is an array where each element contains the IP address, confidence of abuse score, and the timestamp of the last report. Results are order by `abuseConfidenceScore` descending, and then by `lastReportedAt` descending (most recent).

`abuseConfidenceScore` is our calculated evaluation on how abusive the IP is based on the users that reported it ([more](https://www.abuseipdb.com/faq.html#confidence)). We place a hard minimum of 25% on the abuseConfidenceScore. There are two critical reasons for this:

1. **To prevent a handful of reports drastically impacting networks.** If an AbuseIPDB user were to implement a blacklist that includes <25%-rated IPs, their network protocol would easily be swayed by a single or few third-party users. We recommend against the minimum of 25% for most applications. 75%-100% is the recommended range for denial of service.

2. **Performance.** A <25% range is a wide net that would match the vast majority of our database. There are simply too many results for it to be performant or useful.

In the `meta` block we include `generatedAt` property that lets you check for the freshness of the list, if you'd like.

<aside class="notice">
The abuseConfidenceScore parameter is a subscriber feature. This is because custom blacklists take more juice to generate on-demand. Should your subscriber status lapse, an error response will not be thrown. Rather, the response will degrade gracefully to the simple blacklist. This works nicely with existing firewall software.
</aside>

## Plaintext Blacklist

```shell
curl -G https://api.abuseipdb.com/api/v2/blacklist \
  -d confidenceMinimum=90 \
  -d plaintext \
  -H "Key: $YOUR_API_KEY" \
  -H "Accept: application/json"
```
> or

```shell

curl -G https://api.abuseipdb.com/api/v2/blacklist \
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

```shell
curl -G https://api.abuseipdb.com/api/v2/blacklist \
  -d limit=9999999 \
  -H "Key: $YOUR_API_KEY" \
  -H "Accept: text/plain"
```

```python
import requests
import json

# Defining the api-endpoint
url = 'https://api.abuseipdb.com/api/v2/blacklist'

querystring = {
    'limit':'9999999'
}

headers = {
    'Accept': 'text/plain,
    'Key': '$YOUR_API_KEY'
}

response = requests.request(method='GET', url=url, headers=headers, params=querystring)

# Formatted output
print response.text
```

```php
<?php
$client = new GuzzleHttp\Client([
  'base_uri' => 'https://api.abuseipdb.com/api/v2/'
]);

$response = $client->request('GET', 'blacklist', [
	'query' => [
		'limit' => '9999999'
	],
	'headers' => [
		'Accept' => 'text/plain',
		'Key' => $YOUR_API_KEY
  ],
]);

$output = $response->getBody();
echo $output;
?>
```

```csharp
using System;
using RestSharp;

public class BlacklistEndpoint
{
    public static void Main()
    {
        var client = new RestClient("https://api.abuseipdb.com/api/v2/blacklist");
        var request = new RestRequest(Method.GET);
        request.AddHeader("Key", "YOUR_API_KEY");
        request.AddHeader("Accept", "text/plain");
        request.AddParameter("limit", "9999999");

        IRestResponse response = client.Execute(request);

        Console.WriteLine(response.Content);
    }
}
```

To conserve bandwidth, the number of IP addresses included in the list is capped to 10,000. Subscribers, both basic and premium, can overcome this limit. All users can set it between 1 and 10,000 using the `limit` parameter.

If you are a subscriber and want to the full list, set the `limit` parameter to an absurd number like in the example (9,999,999). However, this large of a request may take a while, and firewall software such as [csf](https://www.abuseipdb.com/csf) may have trouble importing rules for over 10,000 IPs.

## Blacklist Parameters

| field             | required | default | min | max  | subscriber feature                                |
|-------------------|----------|---------|-----|------|---------------------------------------------------|
| confidenceMinimum | no       | 100     | 25  | 100  | yes                                               |
| limit             | no       | 10,000  | 1   |      | restricted, [see above](#blacklist-ip-truncation) |
| plaintext         |          |         |     |      | no                                                |
