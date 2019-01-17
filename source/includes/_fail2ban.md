# Configuring Fail2Ban

```
actionban = curl --fail 'https://api.abuseipdb.com/api/v2/report' \
    -H 'Accept: application/json' \
    -H 'Key: <abuseipdb_apikey>' \
    --data-urlencode 'comment=<matches>' \
    --data-urlencode 'ip=<ip>' \
    --data 'categories=<abuseipdb_category>'
```

Follow our [APIv1 tutorial](https://www.abuseipdb.com/fail2ban.html). APIv2 works the same way except for slight alterations to the cURL request. In APIv2, `actionban` command in Fail2Ban's abuseipdb.conf will looks like:

- The `category` parameter has been renamed to `categories`.
- Your API key can still be passed in the query as `key`, but it is recommended to use the HTTP header.
- The IP value should be url encoded because IPv6 addresses have colons.
- Request JSON with "Accept: application/json"

That's it! You've migrated.
