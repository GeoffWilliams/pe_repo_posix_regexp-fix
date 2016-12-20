# Class: pe_repo_posix_regexp_fix
# ===========================
#
# Full description of class pe_repo_posix_regexp_fix here.
#
# Parameters
# ----------
#
# Document parameters here.
#
# * `sample parameter`
# Explanation of what this parameter affects and what it defaults to.
# e.g. "Specify one or more upstream ntp servers as an array."
#
# Variables
# ----------
#
# Here you should define a list of variables that this module would require.
#
# * `sample variable`
#  Explanation of how this variable affects the function of this class and if
#  it has a default. e.g. "The parameter enc_ntp_servers must be set by the
#  External Node Classifier as a comma separated list of hostnames." (Note,
#  global variables should be avoided in favor of class parameters as
#  of Puppet 2.6.)
#
# Examples
# --------
#
# @example
#    class { 'pe_repo_posix_regexp_fix':
#      servers => [ 'pool.ntp.org', 'ntp.local.company.com' ],
#    }
#
# Authors
# -------
#
# Author Name <author@domain.com>
#
# Copyright
# ---------
#
# Copyright 2016 Your name here, unless otherwise noted.
#
class pe_repo_posix_regexp_fix(
    $force_patch = false
) {

  if $pe_server_version == '2016.4.2' or $force_patch {
    # Affected template is on the system in 2x locations:
    # 1. used to configure the master: /opt/puppetlabs/puppet/modules/pe_repo/templates/partials/shared_functions.bash.erb
    # 2. used during system (re)installation: /opt/puppetlabs/server/data/enterprise/modules/pe_repo/templates/partials/shared_functions.bash.erb
    file { '/opt/puppetlabs/puppet/modules/pe_repo/templates/partials/shared_functions.bash.erb':
      ensure  => file,
      owner   => 'root',
      group   => 'root',
      mode    => '0755',
      source  => 'puppet:///modules/pe_repo_posix_regexp_fix/shared_functions_bash_erb',
    }
  } else {
    warning("Refusing to apply outdated patch from pe_repo_posix_regexp_fix for PE-18976, set force_patch true if you want override this warning and apply anyway")
  }
}
