<#
    .SYNOPSIS
    Deletes Powershell Modules which are double installed

    .DESCRIPTION
    Deletes Powershell Modules which are double installed.
    It ises the "Get-DuplicatedModules" function of this module.

    .EXAMPLE
    C:\PS> Remove-DuplicatedModules    
#>
function Remove-DuplicatedModules {
    [CmdletBinding()]
    param (
        
    )
    
    begin {
        
    }
    
    process {
        $DoubledModules = Get-DuplicatedModules

        if ($null -ne $DoubledModules)
        {
            foreach ($DoubledModule in $DoubledModules) {
                write-verbose "$($DoubledModule.Name) will be deleted..."
                $DoubledModule | uninstall-module -force
                write-host "done uninstalling $($DoubledModule.name) - $($DoubledModule.version)"

            }
        }
    }
    
    end {
        
    }
}

Export-ModuleMember -Function Remove-DuplicatedModules