\# Detection: Windows Brute Force Logons (Event ID 4625)



\## Goal



Detect repeated failed logon attempts against Windows accounts that may indicate a brute force attack.



\## Log Source



\- \*\*Product:\*\* Windows

\- \*\*Log:\*\* Security

\- \*\*Event ID:\*\* 4625 (An account failed to log on)



\## Splunk Search (Example)



```spl

index=wineventlog sourcetype="WinEventLog:Security" EventCode=4625

| stats count values(Workstation\_Name) as hosts values(Source\_Network\_Address) as src\_ips by Account\_Name

| where count >= 10

| sort - count



