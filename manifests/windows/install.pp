# This is a class that does install on windows
#
# @summary A class that does install on windows
#
class pdk_training::windows::install {
  # create directory pdk_training
  file { 'c:/Management/pdk_training':
    ensure => 'directory',
  }
}
