<#
    .SYNOPSIS
    Get the Powershell Modules which are installed doubled with separate Versions on the system.

    .DESCRIPTION
    Get the Powershell Modules which are installed doubled with separate Versions on the system.

    .OUTPUTS
    The output are the modules which have more than one version installed

    .EXAMPLE
    C:\PS> Get-DuplicatedModules    
    Be sure to run this as an admin

    Checking navcontainerhelper
    2 versions of this module found [ navcontainerhelper ]
      navcontainerhelper - 0.7.0.13 [highest installed is 0.7.0.26]
      navcontainerhelper - 0.7.0.26 [highest installed is 0.7.0.26]
    ------------------------
    Checking Write-ObjectToSQL
      Write-ObjectToSQL - 1.13 [highest installed is 1.13]
    ------------------------
    Checking PackageManagement
      PackageManagement - 1.4.7 [highest installed is 1.4.7]

    .LINK
    My Source: http://sharepointjack.com/2017/powershell-script-to-remove-duplicate-old-modules/
#>
function Get-DuplicatedModules {
  [CmdletBinding()]
  param (
    
  )
  
  begin {
    
  }
  
  process {
  
    $mods = get-installedmodule
    
    foreach ($mod in $mods)
    {
      write-verbose "Checking $($mod.name)"
      $latest = get-installedmodule $mod.name
      $specificmods = get-installedmodule $mod.name -allversions

      $moreSpecificmods = $specificmods -is [array];
      if ($moreSpecificmods)
      {
        write-verbose "$($specificmods.count) versions of this module found [ $($mod.name) ]"
      }

      foreach ($specificmod in $specificmods)
      {
        if ($specificmod.version -ne $latest.version) 
        {
          write-verbose " $($specificmod.name) - $($specificmod.version) [highest installed is $($latest.version)]" 
          write-output $specificmod
        }
        
      }
      write-verbose "------------------------"
    }

  }
  
  end {
    
  }
}

Export-ModuleMember -Function Get-DuplicatedModules