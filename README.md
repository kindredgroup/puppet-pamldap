# unibet-pamldap

#### Table of Contents

1. [Overview](#overview)
2. [Usage - Configuration options and additional functionality](#usage)

## Overview

Configure a system to use LDAP for user authentication, authorisation and related name resolution.

Currently only tested on Redhat-like systems.

## Usage

```
class { 'pamldap':
  ldap_base  => 'dc=example,dc=com',
  krb_realm  => 'EXAMPLE.COM',
  krb_domain => 'example.com',
  kdcs       => ['10.7.96.13', '10.7.96.14'],
}
```

