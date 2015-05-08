# unibet-pamldap

[![Build Status](https://secure.travis-ci.org/unibet/puppet-pamldap.png)](http://travis-ci.org/unibet/puppet-pamldap)
[![Puppet Forge](https://img.shields.io/puppetforge/v/unibet/pamldap.svg)](https://forge.puppetlabs.com/unibet/pamldap)
[![Puppet Forge](https://img.shields.io/puppetforge/f/unibet/pamldap.svg)](https://forge.puppetlabs.com/unibet/pamldap)

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

