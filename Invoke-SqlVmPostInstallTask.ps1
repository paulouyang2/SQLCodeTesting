Set-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\services\SharedAccess\Parameters\FirewallPolicy\DomainProfile' -name "EnableFirewall" -Value 0
Set-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\services\SharedAccess\Parameters\FirewallPolicy\PublicProfile' -name "EnableFirewall" -Value 0
Set-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\services\SharedAccess\Parameters\FirewallPolicy\Standardprofile' -name "EnableFirewall" -Value 0 
Restart-Service -Name mpssvc

$query = "
exec sp_configure 'show advanced options', 1
RECONFIGURE
exec sp_configure 'Agent XPs',1
RECONFIGURE
"
Invoke-Sqlcmd -Query $query

Get-Service SQLSERVERAGENT | Set-Service -StartupType Automatic -Status Running
