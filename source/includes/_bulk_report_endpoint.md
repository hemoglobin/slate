# BULK-REPORT Endpoint

If reporting IP addresses one by one may not seem efficient to you, we offer an endpoint that allows a CSV file of IPs to be reported in one shot. Such a list can be extracted from your secure log file or similar. See the [bulk report form](https://www.abuseipdb.com/bulk-report) for a guide.

```shell
# POST the submission.
curl https://api.abuseipdb.com/api/v2/bulk-report \
  -F csv=@report.csv \
  -H "Key: $YOUR_API_KEY" \
  -H "Accept: application/json" \
  > output.json
```

```python
import requests
import json

# Defining the api-endpoint
url = 'https://api.abuseipdb.com/api/v2/bulk-report'

files = {
    'csv': ('report.csv', open('report.csv', 'rb'))
}

headers = {
    'Accept': 'application/json',
    'Key': '$YOUR_API_KEY'
}

response = requests.request(method='POST', url=url, headers=headers, files=files)

# Formated output
decodedResponse = json.loads(response.text)
print json.dumps(decodedResponse, sort_keys=True, indent=4)
```

```php
<?php
$client = new GuzzleHttp\Client([
  'base_uri' => 'https://api.abuseipdb.com/api/v2/'
]);

$response = $client->request('POST', 'bulk-report', [
	'multipart' => [
    [
      'name' => 'csv',
      'contents' => fopen('report.csv',r)
    ]
	],
	'headers' => [
		'Accept' => 'application/json',
		'Key' => $YOUR_API_KEY
  ],
]);

$output = $response->getBody();
// Store response as a PHP object.
$status = json_decode($output, true);
?>
```

```csharp
using System;
using RestSharp;
using Newtonsoft.Json;

public class BulkReportEndpoint
{
    public static void Main()
    {
        var client = new RestClient("https://api.abuseipdb.com/api/v2/bulk-report");
        var request = new RestRequest(Method.POST);
        request.AddHeader("Key", "YOUR_API_KEY");
        request.AddHeader("Accept", "application/json");
        request.AddFile("csv", "report.csv");

        IRestResponse response = client.Execute(request);

        dynamic parsedJson = JsonConvert.DeserializeObject(response.Content);

        foreach (var item in parsedJson)
        {
            Console.WriteLine(item);
        }
    }
}
```
> The response will inform you how many IPs were successfully reported, and which ones were rejected and why.

```json
  {
    "data": {
      "savedReports": 60,
      "invalidReports": [
        {
          "error": "Duplicate IP",
          "input": "41.188.138.68",
          "rowNumber": 5
        },
        {
          "error": "Invalid IP",
          "input": "127.0.foo.bar",
          "rowNumber": 6
        },
        {
          "error": "Invalid Category",
          "input": "189.87.146.50",
          "rowNumber": 8
        }
      ]
    }
  }
```
