# profile for an empty  template
class profile_empty_template
(
  Boolean $enable,
)
{
  if $enable
  {
    case $::facts['kernel']
    {
      'windows':
      {
        include '::profile_empty_template::windows::something
      }
      'Linux':
      {
        include '::profile_empty_template::linux::something
      }
      default:
      {
        fail("Unsupported Operating System ${::facts['kernel']} (${::facts['os']['release']['major']})")
      }
    } # end case fact kernel
  } # end if enable
}
