# collect_host_info.ps1
# Simple script to collect basic host information for incident triage

$timestamp = Get-Date -Format "yyyyMMdd_HHmmss"
$outFile = ".\host_info_$timestamp.txt"

"===== HOST INFO =====" | Out-File $outFile
"Hostname: $(hostname)" | Out-File $outFile -Append
"OS Version:" | Out-File $outFile -Append
(Get-CimInstance -ClassName Win32_OperatingSystem).Caption | Out-File $outFile -Append

"`n===== USERS =====" | Out-File $outFile -Append
try {
    quser | Out-File $outFile -Append
} catch {
    "quser command not available" | Out-File $outFile -Append
}

"`n===== TOP PROCESSES BY CPU =====" | Out-File $outFile -Append
Get-Process | Sort-Object CPU -Descending | Select-Object -First 10 `
    | Format-Table -AutoSize | Out-String | Out-File $outFile -Append

"`n===== TCP CONNECTIONS =====" | Out-File $outFile -Append
Get-NetTCPConnection | Select-Object -First 20 `
    | Format-Table -AutoSize | Out-String | Out-File $outFile -Append

Write-Host "Host information saved to $outFile"
