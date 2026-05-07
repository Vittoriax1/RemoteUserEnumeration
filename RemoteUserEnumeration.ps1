$ip = "<TARGET_IP"

$hostname = (Resolve-DnsName -Name $ip -ErrorAction SilentlyContinue |
             Select-Object -ExpandProperty NameHost -First 1)

# Get only domain (non-local, non-service) users
$users = Get-WmiObject -Class Win32_LoggedOnUser -ComputerName $ip -ErrorAction SilentlyContinue |
    ForEach-Object {
        $_.Antecedent.ToString() -replace '"', '' -replace '^.*Domain="([^"]+)",Name="([^"]+)".*$', '$1\$2'
    } |
    Sort-Object -Unique |
    Where-Object {
        ($_ -notmatch '^(NT AUTHORITY|Window Manager|Font Driver Host|UMFD|DWM)$') -and
        ($_ -notmatch '^\$') -and                        # exclude machine accounts
        ($_ -notmatch "^(?:$env:COMPUTERNAME)\\")        # exclude local accounts
    }

if ($users) {
    foreach ($u in $users) {
        [PSCustomObject]@{
            IP       = $ip
            HostName = $hostname
            UserName = $u
        }
    }
}
else {
    [PSCustomObject]@{
        IP       = $ip
        HostName = $hostname
        UserName = "No domain users found"
    }
}
