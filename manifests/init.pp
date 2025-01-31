# == class pdk_training
#
# @summary A class that does something on windows or linux
#
# @param enable Whether to enable the class or not
#
class pdk_training (
  Boolean $enable,
) {
  if $enable {
    case $facts['os']['family'] {
      'windows':
        {
          include 'pdk_training::windows::install'
        }
        'RedHat':
        {
          include 'pdk_training::linux::install'
        }
        default:
        {
          fail("Unsupported Operating System ${::facts['kernel']} (${::facts['os']['release']['major']})")
        }
    } # end case fact kernel
  } # end if enable
}
