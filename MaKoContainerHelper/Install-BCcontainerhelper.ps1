function Install-BCcontainerhelper {
    [CmdletBinding()]    
    Param(    
        [string] $bcContainerHelperPath,
        [string] $bcContainerHelperVersion
    )
    
    begin {
        
    }
    
    process {
        
        ## Set TLS?

        if ([string]::IsNullOrEmpty($bcContainerHelperVersion))
        { 
            $bcContainerHelperVersion = "latest" 
        }

        Write-Host "Version: $bcContainerHelperVersion"

        if ((![string]::IsNullOrEmpty($bcContainerHelperPath)) -and (Test-Path $bcContainerHelperPath)) 
        {
            Write-Host "Using bcContainerHelper from $bcContainerHelperPath"
            . $bcContainerHelperPath
        }
        else 
        {
            $bccontainerhelperModule = Get-InstalledModule -Name bccontainerhelper -ErrorAction SilentlyContinue
            if ($bccontainerhelperModule) 
            {
                $versionStr = $bccontainerhelperModule.Version.ToString()
                Write-Host "bcContainerHelper $VersionStr is installed"
                if ($bcContainerHelperVersion -eq "latest") 
                {
                    Write-Host "Determine latest bcContainerHelper version"
                    $latestVersion = (Find-Module -Name bccontainerhelper).Version
                    $bcContainerHelperVersion = $latestVersion.ToString()
                    Write-Host "bcContainerHelper $bcContainerHelperVersion is the latest version"
                }
                if ($bcContainerHelperVersion -ne $bccontainerhelperModule.Version) {
                    Write-Host "Updating bcContainerHelper to $bcContainerHelperVersion"
                    Update-Module -Name bccontainerhelper -Force -RequiredVersion $bcContainerHelperVersion
                    Write-Host "bcContainerHelper updated"
                }
            }
            else 
            {
                if (!(Get-PackageProvider -Name NuGet -ListAvailable -ErrorAction SilentlyContinue)) 
                {
                    Write-Host "Installing NuGet Package Provider"
                    Install-PackageProvider -Name NuGet -MinimumVersion 2.8.5.208 -Force -WarningAction SilentlyContinue | Out-Null
                }
                if ($bcContainerHelperVersion -eq "latest") 
                {
                    Write-Host "Installing bcContainerHelper"
                    Install-Module -Name bccontainerhelper -Force
                }
                else 
                {
                    Write-Host "Installing bcContainerHelper version $bcContainerHelperVersion"
                    Install-Module -Name bccontainerhelper -Force -RequiredVersion $bcContainerHelperVersion
                }

                $bccontainerhelperModule = Get-InstalledModule -Name bccontainerhelper -ErrorAction SilentlyContinue
                $versionStr = $bccontainerhelperModule.Version.ToString()
                Write-Host "bcContainerHelper $VersionStr installed"
            }
        }
    }
    
    end {
        
    }
}

Export-ModuleMember -Function Install-BCcontainerhelper 