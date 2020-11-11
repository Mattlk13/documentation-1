---
title: Security Specifications
shortTitle: Security Specifications
description: Technical documentation outlining CodeShip's security specifications
menus:
  general/about:
    title: Security Information
    weight: 5
tags:
  - security
  - gpg key
  - permissions
  - ssh
  - git
  - 2fa
  - static
categories:
  - About CodeShip
  - Security
redirect_from:
  - /security/
  - /security/security/
---

* include a table of contents
{:toc}

We fully understand and recognize, that the security of your source code and configuration data is important, as it forms the base of your and our endeavors. Therefore we put a lot of effort and thought into providing secure infrastructure for you to use.

## System Security Overview

For every project you add to CodeShip we create a SSH key that is itself encrypted strongly and only decrypted shortly before being used in the build virtual machine. For every build we start a new and clean virtual machine. All changes you make (including file system changes) are stored in a ramdisk which is removed as soon as your build finishes (tests and deployment). None of your data is ever stored on any hard drive on our build servers.

All communication between your browser and our website is SSL encrypted, as is all communication to our Openredis queue. All communication to the build virtual machines is done over SSH.

## Can CodeShip Read My Code?

On CodeShip Basic, with permission, our support team can open a [SSH debug session]({{ site.baseurl }}{% link _basic/builds-and-configuration/ssh-access.md %}) which allows us to see your source code.

On CodeShip Pro, we have no direct access to your source code but our support team can see your builds and build logs, as well as account information.

## What Kind Of Access To My SCM Does CodeShip Need?

To run your tests, we need to check out your code from your source code provider. We support GitHub, GitLab, and Bitbucket. You can sign up for CodeShip via email as well but as soon as you connect a repository with your CodeShip account you are telling your source code provider that you allow us to check out your private repositories.

You can revoke permission in your source code provider settings and by removing CodeShip's deploy keys and service hooks from your projects' configuration pages.

## How Can I Access Internal Resources From CodeShip?

If you need to access resources behind a custom firewall from CodeShip, e.g. pulling code from a [self-hosted git server]({{ site.baseurl }}{% link _general/about/self-hosted-scm.md %}) or perhaps deploying build artifacts to an internal environment, you can enable the static IP addresses feature and only open the necessary ports for those IPs in your firewall. See [Static IP Addresses]({{ site.baseurl }}{% link _general/account/static-ip-addresses.md %}) documentation for more details.

## Is CodeShip GDPR Compliant?

Yes, we comply with GDPR as a controller. See more on the [GDPR page]({{ site.baseurl }}{% link _general/about/gdpr.md %}).

## What Services Does CodeShip Use?

Our whole infrastructure is based on Amazon EC2 or services built on top of it. EC2 is one of the most trusted, tried and tested hosting services out there. The services we use are:

* Amazon EC2
* Heroku
* Openredis

Additionally for monitoring the platform, handling payments, and potentially collecting metrics we use:

+ Braintree
+ Librato
+ PagerDuty
+ Papertrail
+ Rollbar
+ Segment
+ Sisense
+ Statuspage
+ Zendesk

**Note**: Although we do have access to your source code, as outlined in our [Terms of Service](https://codeship.com/tos), we only access it for a build or support request. We do not have any way to access your source code repository outside of our build environment.

## Does CodeShip Save My Code?

CodeShip never takes ownership of your code or files. All builds run on containers or machines that are shut down at the end of your build, with your cloned repository and generated assets never persisted between builds.

The one exception is with opt-in caching. On [CodeShip Basic]({{ site.baseurl }}{% link _basic/builds-and-configuration/dependency-cache.md %}) we will save your dependencies automatically (but not your code) and on [CodeShip Pro]({{ site.baseurl }}{% link _pro/builds-and-configuration/caching.md %}) we will save your images if you explicitly tell us to in your project configuration.

In the case of CodeShip Pro's image caching, we save each project's images in AWS with security credentials specific to that project.

## Does CodeShip Conduct External Security Audits?

Yes, from time to time CodeShip will hire external parties to examine and audit current security practices.

## Does CodeShip Use External Contractors?

For various roles, CodeShip will hire part-time workers or third-party contractors. All employees - full-time, part-time or external - are given appropriately limited resource access and security requirements.

## Does CodeShip Have A Security Audit?

We have a more detailed security checklist available on request. [Get in touch](mailto:security@codeship.com) if you need more information.

## Third-party JavaScript Tracking

CodeShip uses a variety of third-party JavaScript embeds to perform a variety of user and business functions.

**Note** that third-party tracking is enabled on all application pages.

- ProfitWell is used to help notify customers when a credit card (stored securely in Braintree, our payments provider) needs to be renewed or updated.

- Rollbar is used to collect application exception information for development purposes.

- Segment is our main data analytics platform. We use the data (in aggregate) to see how CodeShip is being used and to design improvements and new features.

- Zendesk is used for support ticket handling.

If you have not allowed us to capture data on how you use CodeShip (part of [GDPR]({{ site.baseurl }}{% link _general/about/gdpr.md %})) we will not embed Segment.

## Sensitive Information In The Browser

All JavaScript code running in the browser, including code from the trusted third-parties listed above, has access to any information that is transmitted to the browser at runtime. No sensitive information is sent to third-party tracking functions. Code running the browser does not have restricted API access to any sensitive information that is not displayed in the browser.

## How Can I Get In Touch About Security?

If you have any further questions you can contact [security@codeship.com](mailto:security@codeship.com).

If you want to [report a vulnerability](https://www.cloudbees.com/security-policy) please contact [security@cloudbees.com](mailto:security@cloudbees.com) instead.
