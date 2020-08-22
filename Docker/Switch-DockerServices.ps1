<#
    .SYNOPSIS
    You could start/stop the Docker services.

    .DESCRIPTION
    The function will ask you if you want to start or stop the docker services.

    .EXAMPLE
    C:\PS> Switch-DockerServices    
#>
function Switch-DockerServices {
    [CmdletBinding()]
    param (
        
    )
    
    begin {
        
    }
    
    process {
  
        Write-Host "------"
        Get-Service "*Docker*" | Sort-Object Status
        Write-Host "------"
        
        $startServices = Read-Host "Start or stop the docker services?[Y=Start;N=Stop]";
        $startServices = $startServices.ToUpper();
        
        if ($startServices -eq 'Y') {
            $stoppedDockerServices = Get-Service "*docker*" | Where-Object { $_.Status -EQ "Stopped" } 
            foreach ($dockerService in $stoppedDockerServices) {   
                Write-Host -ForegroundColor Green "$($dockerService.DisplayName) will be started..."     
                start-Service $dockerService -Verbose
            }
        }
        else {
            $startedDockerServices = Get-Service "*docker*" | Where-Object { $_.Status -EQ "Running" } 
            foreach ($dockerService in $startedDockerServices) {
                Write-Host -ForegroundColor Red "$($dockerService.DisplayName) will be stopped..."     
                Stop-Service $dockerService -Verbose
            }
            
        }
                   
    }
    
    end {
        
    }
}

Export-ModuleMember -Function Switch-DockerServices