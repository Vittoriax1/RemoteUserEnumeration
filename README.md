# RemoteUserEnumeration
RemoteUserEnumeration is a PowerShell script that remotely identifies which domain users are currently logged into a Windows workstation or server. It filters out noise such as local accounts, service accounts, system processes, and background session users, returning only meaningful domain logon information.

This tool is useful for:
- Helpdesk and IT support
- SOC and incident response
- System administrators
- Security analysts validating active sessions

## Features
- Queries a remote machine by IP address
- Resolves the hostname automatically
- Retrieves logged‑on users via WMI
- Extracts clean DOMAIN\username format
- Filters out:
--local accounts
--machine accounts
--system/service users
--session processes (UMFD, DWM, etc.)
- Outputs an easy‑to‑read table of active domain sessions
- Returns “No domain users found” when applicable

## Example Output

/path/to/image.jpg

## Usage
- Clone or download the repo
- Open a Powershell window with appropriate permissions
- Modify the script to target the desired IP address:
--$ip = "10.2.4.1"
- Run the script:
--.\RemoteUserEnumeration.ps1

## Requirements
- Windows PowerShell (or PowerShell 7 with WMI compatibility)
- Network access to the remote host
- Appropriate permissions to query WMI on the target system

## How It Works

The script uses:
- Resolve-DnsName to resolve hostnames
- WMI class Win32_LoggedOnUser to query session data
- Regex to extract domain + username
- Filtering logic to remove local/system accounts
- PSCustomObject output for clean formatting
