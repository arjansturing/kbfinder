#KBFinder.ps1
#By: Arjan Sturing
#PowerShell script for finding a installed update on the local computer or a remote computer in an Active Directory environment.

#Function for finding a installed update based on input
Function kbfinder {$updatelist = wmic qfe list
$update = Read-Host "Enter full KB name (For example: KB4537759)"
cls
If ($updatelist -imatch "$update"){
Write-Host "$update is installed on $env:computername" -ForeGroundColor Green
Write-Host "You will be redirected to the menu in 10 seconds" -ForeGroundColor Green}
Else{
Write-Host "$update is not installed on $env:computername" -ForeGroundColor Red
Write-Host "You will be redirected to the menu in 10 seconds" -ForeGroundColor Red}
}

#Function for finding a installed update on a remote computer based on input
Function kbfinderremote {
Write-Host "For scanning a remote remote you need to enable PS Remoting on the regarding computer."
Write-Host "You can enable PS Remoting by executing the follwing command on the regarding server: Enable-PSRemoting -Force"
Write-Host ""-ForeGroundColor Green
$server = Read-Host -Prompt 'Enter Server FDQN or IP Address'
cls
Write-Host "Enter credentials of authorized PS Remoting User" -ForeGroundColor Green
$credential = Get-Credential -Message "Enter credentials of authorized PS Remoting User"
Invoke-Command -ComputerName $server -ScriptBlock {$updatelist = wmic qfe list
$update = Read-Host "Enter full KB name (For example: KB4537759)"
cls
If ($updatelist -imatch "$update"){
Write-Host "$update is installed on $env:computername" -ForeGroundColor Green
Write-Host "You will be redirected to the menu in 10 seconds" -ForeGroundColor Green}
Else{
Write-Host "$update is not installed on $env:computername" -ForeGroundColor Red
Write-Host "You will be redirected to the menu in 10 seconds" -ForeGroundColor Red}} -Credential $credential
}


#Function for the menu
function menu
{
    Clear-Host
    Write-Host "  _  _____   ___ ___ _  _ ___  ___ ___ " -ForeGroundColor Red
    Write-Host " | |/ / _ ) | __|_ _| \| |   \| __| _ \" -ForeGroundColor Red
    Write-Host " | ' <| _ \ | _| | ||  `  | |) | _||   /" -ForeGroundColor Red  
    Write-Host " |_|\_\___/ |_| |___|_|\_|___/|___|_|_\" -ForeGroundColor Red
    write-host ""
    write-host "By: Arjan Sturing" -ForegroundColor Green
    write-host "" 
    Write-Host "1: Find installed update on local computer"
    Write-Host "2: Find installed update on remote computer"
    Write-Host "Q: Quit"
    write-host "" 
    Write-Host "Automate the world! #Powershell" -ForegroundColor Yellow
    write-host "" 

     $selection = Read-Host "Select an option"
     switch ($selection)
     {
         '1' {
             cls
             kbfinder
             Start-Sleep 10
             cls
             menu
         } '2' {
             cls
             kbfinderremote
             Start-Sleep 10
             cls
             menu
         }

     }
     }
menu
