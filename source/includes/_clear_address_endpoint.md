# CLEAR-ADDRESS Endpoint

```shell

# The CLEAR-ADDRESS endpoint is a DELETE request.
curl -X DELETE https://api.abuseipdb.com/api/v2/clear-address \
  --data-urlencode "ipAddress=118.25.6.39" \
  -H "Key: $YOUR_API_KEY" \
  -H "Accept: application/json"
```

```python
import requests
import json

# Defining the api-endpoint
url = 'https://api.abuseipdb.com/api/v2/clear-address'

querystring = {
    'ipAddress': '118.25.6.39',
}

headers = {
    'Accept': 'application/json',
    'Key': '$YOUR_API_KEY'
}

response = requests.request(method='DELETE', url=url, headers=headers, params=querystring)

# Formatted output
decodedResponse = json.loads(response.text)
print json.dumps(decodedResponse, sort_keys=True, indent=4)
```

```php
<?php
$client = new GuzzleHttp\Client([
  'base_uri' => 'https://api.abuseipdb.com/api/v2/clear-address'
]);

$response = $client->request('DELETE', 'clear-address', [
	'query' => [
		'ipAddress' => '118.25.6.39',
	],
	'headers' => [
        'Accept' => 'application/json',
        'Key' => $YOUR_API_KEY
    ],
]);

$output = $response->getBody();
// Store response as a PHP object.
$details = json_decode($output, true);
?>
```

```csharp
using System;
using RestSharp;
using Newtonsoft.Json;

public class ClearAddressEndpoint
{
    public static void Main()
    {
        var client = new RestClient("https://api.abuseipdb.com/api/v2/clear-address");
        var request = new RestRequest(Method.DELETE);
        request.AddHeader("Key", "YOUR_API_KEY");
        request.AddHeader("Accept", "application/json");
        request.AddParameter("ipAddress", "118.25.6.39");

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
    "data": {
      "numReportsDeleted": 0
    }
  }
```

<aside class="warning">
This endpoint is in OPEN BETA. It's specifications may change without notice. If you have feedback, please let us hear it.
</aside>

The `clear-address` endpoint accepts a single IP address (v4 or v6).

The only property it returns is the number of reports deleted from your account.

<aside class="notice">
This endpoint is ONLY used to delete reports for an specific address from YOUR account. It cannot delete another user's reports. If this is what you are looking to do, the correct channel is the takedown request form available on an IP's web page.
</aside>

### Address Parameters

| field        | required |
|--------------|----------|
| ipAddress    | yes      |
