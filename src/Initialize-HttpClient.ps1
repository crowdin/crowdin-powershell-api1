New-Variable ApiBaseUrl -Value ([uri]'https://api.crowdin.com/api/') -Option Constant
New-Variable HttpClient -Value (New-Object System.Net.Http.HttpClient -Property @{BaseAddress=$ApiBaseUrl}) -Option Constant

Invoke-Command {
    $module = $ExecutionContext.SessionState.Module
    $m = "$($module.Name)/$($module.Version)"
    $ps = "$($PSVersionTable.PSEdition)/$($PSVersionTable.PSVersion)"
    $os = if ($PSVersionTable.OS) {
        "$($PSVersionTable.OS); $($PSVersionTable.Platform)"
    }
    else {
        [System.Environment]::OSVersion.VersionString
    }
    $ua = "$m $ps ($os)"
    $HttpClient.DefaultRequestHeaders.UserAgent.ParseAdd($ua)
}