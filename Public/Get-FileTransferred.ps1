function Get-FileTransferred
{
     param(
          [Parameter(Mandatory = $true)]
          $Event,

          [Parameter(Mandatory = $true)]
          [string]$fileName,

          [Parameter(Mandatory = $true)]
          [string]$location
     )

     if ($Null -eq $Event.Error)
     {
          Write-Host "Upload of $fileName succeeded"
     }
     else
     {
          Write-Host "Upload of $fileName failed: $($Event.Error)"
     }

     if ($Null -ne $Event.Chmod)
     {
          if ($Null -eq $Event.Chmod.Error)
          {
               Write-Host "Permissions of $fileName set to $($Event.Chmod.FilePermissions)"
          }
          else
          {
               Write-Host "Setting permissions of $fileName failed: $($Event.Chmod.Error)"
          }

     }
     else
     {
          Write-Host "Permissions of $location kept with their defaults"
     }

     if ($Null -ne $Event.Touch)
     {
          if ($Null -eq $Event.Touch.Error)
          {
               Write-Host "Timestamp of $fileName set to $($Event.Touch.LastWriteTime)"
          }
          else
          {
               Write-Host "Setting timestamp of $fileName failed: $($Event.Touch.Error)"
          }

     }
     else
     {
          # This should never happen during "local to remote" synchronization
          Write-Host "Timestamp of $location kept with its default (current time)"
     }
}
