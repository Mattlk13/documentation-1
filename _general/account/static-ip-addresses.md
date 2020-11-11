---
title: Static IP Addresses
shortTitle: Static IP Addresses
tags:
  - administration
  - static
categories:
  - Account
  - Security
menus:
  general/account:
    title: Static IP Addresses
    weight: 4
redirect_from:
  - /general/account/whitelisting/
---

* include a table of contents
{:toc}

{% csnote info %}
The static IP addresses feature is only available on paid subscriptions.
{% endcsnote %}

The static IP addresses feature is mainly useful if you have a [self-hosted git server]({{ site.baseurl }}{% link _general/about/self-hosted-scm.md %}) or if you deploy/push build artifacts to something that is hosted behind your own firewall.

If you are unsure if you need static IP addresses, keep reading. If you know you need it, jump to [setting up static IP addresses](#setting-up-static-ip-addresses) to get started.

## When to use static IP addresses
There's no need for static IP addresses if you're deploying to Heroku or similar cloud services, as they generally allow connections from any public IP address.

If you use AWS, Google Cloud, or Azure you shouldn't need to use static IP addresses, unless you have a VPC setup that does not allow access from public networks.

As a general rule, you only need static IP addresses if you are connecting to a server/service that does not have a public IP address.

## How static IP addresses work
Once the static IP addresses feature is enabled, all traffic from CodeShip builds will originate from one of the eight IP addresses listed further below.

This will allow you to open your firewall to allow access from just these IP addresses, instead of allowing access from the entire AWS us-east-1 network (or worse still, from any public IP address). Our static IP addresses also won't change, at least not without sufficient notice, which makes maintenance much easier.

Note, the static IP addresses only apply to traffic originating from CodeShip builds. If your organization limits outgoing traffic, you won't be able to rely on these eight IP addresses to limit outbound traffic to CodeShip.

## Setting up static IP addresses

### Step 1

The first step is to enable the static IP addresses feature on CodeShip:

1. Navigate to the account that needs the static IP addresses feature
2. Select "Settings" from the top navigation
3. Check the "Static IP Addresses" box and save the changes

### Step 2

Next step is to open your firewall to the IP addresses listed below. How to do this depends on your firewall, so we're not going to cover that here.

```
35.153.154.87
34.235.84.42
54.88.27.219
35.170.141.30
52.20.253.7
107.23.56.82
34.238.108.61
34.239.17.55
```

Generally you should only open access to these IP addresses on the ports that you expect requests to come from.

See the documentation for [Self Hosted SCM]({{ site.baseurl }}{% link _general/about/self-hosted-scm.md %}#exposing-ports)
for details on which ports to open to be able to connect to your internal SCM.
