[![Build Status](https://travis-ci.org/GeoffWilliams/pe_repo_posix_regexp_fix.svg?branch=master)](https://travis-ci.org/GeoffWilliams/pe_repo_posix_regexp_fix)
# pe_repo_posix_regexp_fix

#### Table of Contents

1. [Description](#description)
1. [Setup - The basics of getting started with pe_repo_posix_regexp_fix](#setup)
    * [What pe_repo_posix_regexp_fix affects](#what-pe_repo_posix_regexp_fix-affects)
    * [Setup requirements](#setup-requirements)
    * [Beginning with pe_repo_posix_regexp_fix](#beginning-with-pe_repo_posix_regexp_fix)
1. [Usage - Configuration options and additional functionality](#usage)
1. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
1. [Limitations - OS compatibility, etc.](#limitations)
1. [Development - Guide for contributing to the module](#development)

## Description
Addresses PE-18976 by replacing a non-POSIX regexp in the templates used to generate the BASH installations across multiple Puppet Enterprise supported platforms, of note: AIX and Solaris.

## Setup

### What pe_repo_posix_regexp_fix affects

Replaces the template file at `/opt/puppetlabs/puppet/modules/pe_repo/templates/partials/shared_functions.bash.erb` with a static file shipped inside this module.

This resolves the error 'Unable to interpret argument:...' when script arguments such as agent:certname are used on non-GNU operating systems.



## Usage

Probably the simplest way to use this module is to create a classification group matching all Puppet Enterprise master nodes and then include the `pe_repo_posix_regexp_fix` class.  When the module is no longer needed - eg due to a new version of Puppet Enterprise, remove the classification group, and then optionally the module.  

You may then proceed to upgrade the system, which will replace the template at `/opt/puppetlabs/puppet/modules/pe_repo/templates/partials/shared_functions.bash.erb` with the shipped fix.

Alternatively, the following code snipits can be added to your roles and profiles as required.

### Fix the installation script to use a POSIX compatible regexp

```puppet
include pe_repo_posix_regexp_fix
```

### Force patch application on versions of Puppet Enterprise != 2016.4.2
```
```puppet
class { 'pe_repo_posix_regexp_fix':
  force_patch => true.
}
```
_Please be careful with this option_

## Reference

### Classes
* `pe_repo_posix_regexp_fix` Patch the .erb template with a POSIX regexp

### Files
* `shared_functions.bash.erb` File containing fixed regexp to install onto the system.  Obtained from `/opt/puppetlabs/puppet/modules/pe_repo/templates/partials/shared_functions.bash.erb` on a regular Puppet Enterprise master.  The fix involves reverting this [commit](https://github.com/puppetlabs/puppetlabs-pe_repo/commit/3d0ab2d46d14ef8815623853dbb165b9ebf8ca1a)

## Limitations

* This module only works with Puppet Enterprise 2016.4.2 as it is expected that later versions will resolve this issue
* The `pe_repo_posix_regexp_fix` class has a `force_patch` parameter that can be used to force installation on subsequent version of puppet if the fix slips from next version.  
* If using the `force_patch` parameter, be sure to understand that it will completely replace the target `.erb` file.  It's recommended to inspect for difference carefully using the diff command before attempting to force patching.

## Development

This module is a customer hotfix and as such, is not actively maintained.
