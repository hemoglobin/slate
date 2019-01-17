# Security

All requests to the AbuseIPDB website and API must run over HTTPS. If a HTTP unsecure protocol is requested, it will be redirected to HTTPS via 302 Found.

While we accept your key as either a query parameter/form parameter or header, the header form is recommended. Why? Although HTTPS will encrypt the entire query string, server logs (like ours) will record them. And your infrastructure may have outgoing logging you are unaware of. You are responsible for account(s) compromised this way.

**AbuseIPDB support will never ask you for your API key, nor your account password.** We may only ask for your user id.
