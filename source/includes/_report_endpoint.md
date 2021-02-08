# REPORT Endpoint

```shell
# POST the submission.
curl https://api.abuseipdb.com/api/v2/report \
  --data-urlencode "ip=127.0.0.1" \
  -d categories=18,22 \
  --data-urlencode "comment=SSH login attempts with user root." \
  -H "Key: $YOUR_API_KEY" \
  -H "Accept: application/json"
```

```python
import requests
import json

# Defining the api-endpoint
url = 'https://api.abuseipdb.com/api/v2/report'

# String holding parameters to pass in json format
params = {
    'ip':'180.126.219.126',
    'categories':'18,20',
    'comment':'SSH login attempts with user root.'
}

headers = {
    'Accept': 'application/json',
    'Key': '$YOUR_API_KEY'
}

response = requests.request(method='POST', url=url, headers=headers, params=params)

# Formatted output
decodedResponse = json.loads(response.text)
print json.dumps(decodedResponse, sort_keys=True, indent=4)
```

```php
<?php
$client = new GuzzleHttp\Client([
  'base_uri' => 'https://api.abuseipdb.com/api/v2/'
]);

$response = $client->request('POST', 'report', [
	'form_params' => [
		'ip' => '127.0.0.1',
		'categories' => '18,22',
		'comment' => 'SSH login attempts with user root.'
	],
	'headers' => [
		'Accept' => 'application/json',
		'Key' => $YOUR_API_KEY
  ],
]);

$output = $response->getBody();
// Store response as a PHP object.
$ipDetails = json_decode($output, true);
?>
```

```csharp
using System;
using RestSharp;
using Newtonsoft.Json;

public class ReportEndpoint
{
    public static void Main()
    {
        var client = new RestClient("https://api.abuseipdb.com/api/v2/report");
        var request = new RestRequest(Method.POST);
        request.AddHeader("Key", "YOUR_API_KEY");
        request.AddHeader("Accept", "application/json");
        request.AddParameter("ip", "127.0.0.1");
        request.AddParameter("categories", "8");
        request.AddParameter("comment", "hacker!");

        IRestResponse response = client.Execute(request);

        dynamic parsedJson = JsonConvert.DeserializeObject(response.Content);

        foreach (var item in parsedJson)
        {
            Console.WriteLine(item);
        }
    }
}
```

> Response:

```json
  {
    "data": {
      "ipAddress": "127.0.0.1",
      "abuseConfidenceScore": 52
    }
  }
```

Reporting IP addresses is the core feature of AbuseIPDB. When you report what you observe, everyone benefits, including yourself. To report an IP address, send a POST request. At least one category is required, but you may add additional categories using commas to separate the integer IDs. Related details can be included in the comment field.


<aside class="warning">
STRIP ANY PERSONALLY IDENTIFIABLE INFORMATION (PPI); WE ARE NOT RESPONSIBLE FOR PPI YOU REVEAL.
</aside>


In the body, we get the updated abuseConfidenceScore.

### Report Parameters

| field      | default  | restrictions | description                                                               |
|------------|----------|--------------|---------------------------------------------------------------------------|
| ip         | required |              | A valid IPv4 or IPv6 address.                                             |
| categories | required | 30           | Comma separated values; [Reference](https://www.abuseipdb.com/categories) |
| comment    |          |              | Related information (server logs, timestamps, etc.)                       |

## Test IP Addresses

```json

  {
    "errors": [
      {
        "detail": "You can only report the same IP address (`127.0.0.2`) once in 15 minutes.",
        "status": 429,
        "source": {
          "parameter": "ip"
        }
      }
    ]
  }
```

Reporting 127.0.0.2 will simulate a short term rate limit. This is useful for application testing.
