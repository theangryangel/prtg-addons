Import-Module Hyper-V
 
$VMReplication = Get-VMReplication | select Name,Health,State

if (($VMReplication).count -lt 1) {
  Write-Host 1, ": No data returned from Get-VMReplication! Either no VMs are replicating, or have not elevated!" 
  Exit 4
}

$ErrMessage = " "
$Errors = 0
$Warning = 0
$Critical = 0
foreach ($Name in $VMReplication) {
  if ($Name.Health -Contains "Normal" -and $Name.State -Contains "Replicating") {
    $stat = 0
  }
  elseif ($Name.Health = "Warning") {
    $stat = 1
    $Warning = $Warning + 1
  }
  elseif ($Name.Health = "Critical") {
    $stat = 1
    $Critical = $Critical + 1
  }

  if ($stat -gt 0) {
    $VM = $Name.Name
    $Health = $Name.Health
    $Status = $Name.State
    $ErrMessage = $ErrMessage, $VM, " " , $Health , " (", $Status, ") "
    $Errors = $Errors + 1
  }
}

If ($Errors -eq 0) {
  Write-Host 0, ":OK", "Replication is working fine for", ($VMReplication).count, "of", (Get-VM).count, "VMs"
  Exit 0
}
else {
  Write-Host $Errors, ":", $ErrMessage
  Exit 2
}
