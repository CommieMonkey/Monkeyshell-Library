Get-WinEvent -FilterHashtable @{
    LogName='Security'; 
    ID=4625;
    StartTime=(Get-Date).AddDays(-1)
} | Select-Object TimeCreated, Message
