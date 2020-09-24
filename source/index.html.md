---
title: AbuseIPDB APIv2 Documentation

language_tabs: # must be one of https://git.io/vQNgJ
  - shell
  - python
  - php
  - csharp

toc_footers:
  - <a href='https://www.abuseipdb.com/account/api'>Sign Up for a Developer Key</a>
  - <a href='https://www.abuseipdb.com/account/plans'>Subscribe to a Paid Plan</a>
  - <a href='https://www.abuseipdb.com/fail2ban.html'>Fail2Ban Integration</a>

includes:
  - fail2ban
  - check_endpoint
  - blacklist_endpoint
  - report_endpoint
  - check_block_endpoint
  - bulk_report_endpoint
  - clear_address_endpoint
  - rate_limits
  - errors
  - security

search: true

---

# Introduction

The AbuseIPDB API allows you to utilize our database programmatically. This is most commonly done through Fail2Ban, which comes prepackaged with an AbuseIPDB configuration. Grab a new API key at from account [dashboard](https://www.abuseipdb.com/account/api).
