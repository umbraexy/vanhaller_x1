
#2/23/23
#Created by umbraexy


Get-NetTCPConnection -State Listen, ESTABLISHED | Select-Object  State, LocalPort, OwningProcess | sort-object -Property LocalPort -Unique| Sort-Object -Property State -Descending | out-file processport.txt;
Get-NetTCPConnection -State Listen, ESTABLISHED | Select-Object  State, LocalPort, OwningProcess | sort-object -Property LocalPort -Unique| Sort-Object -Property State -Descending | Select-Object -Expandproperty owningprocess -outvariable id | out-null;
$name= foreach ($line in $id) {
    if ($line -match $regex) {
        Get-CimInstance -Class Win32_Process | where-object PROCESSID -eq $line | select-object ProcessName | Get-Unique -AsString
    }
};
$name | out-file name.txt
$process = Get-Content processport.txt
$nam= Get-Content name.txt
$merged= For ($i=0; $i -lt $nam.count; $i++) {
    $process[$i]+ " " + $nam[$i]
}
Remove-Item processport.txt,name.txt 
$merged | out-file state_port_procid_name.txt