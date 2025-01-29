# profile for an empty  template
#
class pdk_training
(
  Boolean $enable,
)
{
  if $enable {
    case $::facts['kernel'] {
      'windows':
        {
          include 'pdk_training::windows::something'
        }
        'Linux':
        {
          include 'pdk_training::linux::something'
        }
        default:
        {
          fail("Unsupported Operating System ${::facts['kernel']} (${::facts['os']['release']['major']})")
        }
    } # end case fact kernel
  } # end if enable
}
