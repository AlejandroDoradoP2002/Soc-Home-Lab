# SOC Home Lab – pfSense, Splunk, Windows & Kali

## 1. Problem

Most junior security roles ask for "hands-on experience" with SIEMs, logs and incident response.  
Courses and tutorials helped me understand the theory, but I had no real environment to **detect and investigate attacks** end to end.

So I decided to build my own **SOC home lab**.

## 2. Lab Architecture

**Goal:** simulate a small company network with an internal SOC.

- **Firewall / Router:** pfSense
- **SIEM:** Splunk
- **Windows host:** target for logon attempts and basic attacks
- **Kali Linux:** attacker box for brute force and port scanning

High level topology:

- `Kali` and `Windows` sit behind `pfSense`
- `pfSense` forwards logs to `Splunk`
- `Windows` sends Security Event Logs to `Splunk`

*(Here I will add a simple diagram image later.)*

## 3. Scenarios Implemented

### 3.1 Brute Force Logon Detection (Windows Event ID 4625)

**Scenario:**  
From Kali, I generate multiple failed logon attempts against the Windows machine.

**What I collect:**

- Windows Security logs (Event ID 4625)
- Source IP, username, target host, timestamp

**Splunk search idea:**

- Count failed logons per user/IP
- Flag when attempts exceed a threshold in a short time window

**Outcome:**

- I can clearly see brute force patterns in Splunk.
- This becomes the base for an alert/playbook:  
  1. Verify the user and source IP  
  2. Block IP at the firewall if needed  
  3. Force password reset / MFA check

### 3.2 Port Scanning Detection (Nmap)

**Scenario:**  
Using Nmap from Kali against different hosts in the lab.

**What I collect:**

- Firewall logs from pfSense
- Connections to many ports from the same source IP

**Splunk search idea:**

- Group connections by source IP and destination host
- Detect when one IP touches an unusually high number of ports

**Outcome:**

- I can identify reconnaissance activity before an exploit happens.
- This feeds into another detection rule + playbook.

## 4. Tools & Skills

- **Networking:** basic routing, subnets, firewall rules with pfSense
- **Operating Systems:** Windows log sources, Linux (Kali) usage
- **SIEM:** Splunk searches, dashboards, saved searches
- **Security Operations:**
  - Detecting brute force logon attempts
  - Detecting port scanning behavior
  - Writing simple incident response steps (playbooks)

## 5. Next Steps

- Add more detections (malware, privilege escalation)
- Automate parts of the investigation with Python / PowerShell
- Document full incident reports with screenshots

---

If you have feedback or ideas for improving this lab, feel free to open an issue or reach out.
