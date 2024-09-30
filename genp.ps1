param (
    [int]$action  #0 - Disable, 1 - Enable
)

function Set-FirewallRules {
    param (
        [string]$ruleName,
        [bool]$enable
    )
    
    $rules = Get-NetFirewallRule | Where-Object { $_.DisplayName -like "*adobe-block*" }
    
    foreach ($rule in $rules) {
        if ($enable) {
            # Enable rule
            Enable-NetFirewallRule -Name $rule.Name
            Write-Host "Enabled: $($rule.DisplayName)"
        } else {
            # Disable rule
            Disable-NetFirewallRule -Name $rule.Name
            Write-Host "Disabled: $($rule.DisplayName)"
        }
    }
}
if ($action -eq 0) {
    Set-FirewallRules -ruleName "adobe-block" -enable $false
} elseif ($action -eq 1) {
    Set-FirewallRules -ruleName "adobe-block" -enable $true
} else {
    Write-Host "Incorrect value, use 1 - for Enable, 0 - for Disable"
}
