# export_failed_logons.ps1
# Export recent failed logon events (Event ID 4625) from the Security log

$timestamp = Get-Date -Format "yyyyMMdd_HHmmss"
$outFile = ".\failed_logons_$timestamp.csv"

$filter = @{
    LogName = 'Security'
    Id      = 4625
}

Write-Host "Querying Windows Security log for Event ID 4625..."
$events = Get-WinEvent -FilterHashtable $filter -MaxEvents 2000

$parsed = $events | Select-Object TimeCreated, Id, LevelDisplayName, MachineName, Message

$parsed | Export-Csv -Path $outFile -NoTypeInformation -Encoding UTF8

Write-Host "Exported $($parsed.Count) failed logon events to $outFile"
