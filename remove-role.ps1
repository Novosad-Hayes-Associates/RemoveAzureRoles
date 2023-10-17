function Debug-Break {

    Disconnect-AzureAD
    Write-Output "Press any key to exit..."
    [void][System.Console]::ReadKey($true)

}

Connect-AzureAD

$roles = Get-AzureADDirectoryRole

$user = Read-Host -Prompt "Enter user email that you are trying to remove roles or exit to close"

do {

    $u = Get-AzureADUser -ObjectId $user
    foreach($role in $roles){
        $members = Get-AzureADDirectoryRoleMember -ObjectId $role.ObjectId
        if($members -contains $u){
            Write-Host "Removing " $u.DisplayName "from" $role.DisplayName"."
            Remove-AzureADDirectoryRoleMember -ObjectId $role.ObjectId -MemberId $u.ObjectId
        }
    }
        
    $user = Read-Host -Prompt "Enter user email that you are trying to remove roles or exit to close"
   
} until ($user -eq "exit")

Debug-Break