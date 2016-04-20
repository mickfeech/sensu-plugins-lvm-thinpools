## Sensu-Plugins-lvm-thinpools
[![Build Status](https://travis-ci.org/mickfeech/sensu-plugins-lvm-thinpools.svg?branch=master)](https://travis-ci.org/sensu-plugins/sensu-plugins-disk-checks)
## Functionality
This provides functionality to check lvm thinpools, like those that can be utilized for docker.

## Files
 - bin/check-lvm-thinpools.rb

## Usage
```
check-lvm-thinpools.rb -w WARN -c CRIT
```