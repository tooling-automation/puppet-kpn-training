# This is a class that does install on linux
#
# == class pdk_training::linux::install
#
class pdk_training::linux::install {
  # create directory pdk_training
  file { '/usr/local/sbin/pdk_training':
    ensure => 'directory',
  }
}
