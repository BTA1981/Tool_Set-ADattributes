<#
Script: Set AD attributes
Author: Bart Tacken
Date:   16-10-2015
#>

# Wanneer een veld leeg is in het CSV dan wordt er een foutmelding gegenereerd 
# De manager kan alleen ingevuld worden indien het een volledige naam betreft.

Start-Transcript c:\temp\SetADattributes_logging.log

#Import AD module
Import-Module ActiveDirectory

#Set variables
$CSVpath = '<>.csv'  
#$customOU = "OU=Organisatie,OU=<OU name>,Domain,DC=domain,DC=local"

#Import CSV into variable $usersCSV
$usersCSV = Import-Csv -Path $CSVpath -Delimiter ';'        
           
foreach ($user in $usersCSV) {
#Search in specified OU and Update existing attributes
 
    Get-ADUser -Filter "SamAccountName -eq '$($user.usernaam)'" -Properties * -SearchBase $customOU | Set-ADUser -Replace @{TelephoneNumber="$($user.Telefoon_zakelijk)"} -Verbose
    Get-ADUser -Filter "SamAccountName -eq '$($user.usernaam)'" -Properties * -SearchBase $customOU | Set-ADUser -Replace @{ipPhone="$($user.Telefoon_intern)"} -Verbose
    Get-ADUser -Filter "SamAccountName -eq '$($user.usernaam)'" -Properties * -SearchBase $customOU | Set-ADUser -Replace @{Mobile="$($user.Mobiel_zakelijk)"} -Verbose 
    Get-ADUser -Filter "SamAccountName -eq '$($user.usernaam)'" -Properties * -SearchBase $customOU | Set-ADUser -Replace @{Pager="$($user.Semafoon)"} -Verbose 
    Get-ADUser -Filter "SamAccountName -eq '$($user.usernaam)'" -Properties * -SearchBase $customOU | Set-ADUser -Replace @{Title="$($user.Functienaamextvriendelijk)"} -Verbose 
    Get-ADUser -Filter "SamAccountName -eq '$($user.usernaam)'" -Properties * -SearchBase $customOU | Set-ADUser -Replace @{Department="$($user.Team)"} -Verbose 
} # End ForEach

Stop-Transcript
# Usernaam;Telefoon_zakelijk;Telefoon_intern;Mobiel_zakelijk;Semafoon;Functienaam-ext-vriendelijk;Team;Manager

#If ($user.Manager -ne '') {
    #$manager = $(Get-ADuser ($user.Manager) -Properties * | select -ExpandProperty name)
    #Get-ADUser -Filter "SamAccountName -eq '$($user.usernaam)'" -Properties * -SearchBase $customOU | Set-ADUser -Replace @{Manager="$(Get-Aduser ($user.Manager) -Properties * | select -ExpandProperty name)"} -verbose
    #"$($user.Manager)"} -Verbose 
#If ($user.Team -ne '') {
