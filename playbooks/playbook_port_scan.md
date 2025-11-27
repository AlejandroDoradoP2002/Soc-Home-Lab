\# Playbook: Port Scanning Detected from pfSense Firewall



\## 1. Detection



\- Splunk alert indicates a source IP connecting to many different ports on the same target.

\- Based on pfSense filterlog data.



\## 2. Triage



1\. Confirm:

&nbsp;  - Source IP (internal host, external IP, VPN user).

&nbsp;  - Target host(s).

&nbsp;  - Number of unique ports.



2\. Check context:

&nbsp;  - Is the source a known security scanner or admin box?

&nbsp;  - Any related IDS alerts (if available)?



\## 3. Containment



\- If source is external and clearly hostile:

&nbsp; - Block IP/range on pfSense.

\- If source is internal:

&nbsp; - Contact owner or responsible team.

&nbsp; - Consider isolating host from the network.



\## 4. Eradication \& Recovery



\- If internal host is compromised:

&nbsp; - Run host triage (use `scripts/collect\_host\_info.ps1`).

&nbsp; - Scan for malware.

&nbsp; - Patch vulnerabilities.

\- Restore normal firewall rules once safe.



\## 5. Lessons Learned



\- Do we need additional alerts for the same host?

\- Should we tune thresholds or whitelist known scanners?

\- Document findings in an incident report.



