# Script to send multiple requests to the cloud service deployed on Azure
# When executed, it will send multiple request to the server simulating load.
# It will prompt for Cloud Service Name (e.g. yourapp.azurewebsites.net - note
# this is without http://)
# It will prompt for no. of threads to use (for e.g 10, 20, 50)
# It will prompt for no. of times to loop (for e.g. 100, 200, 500)
# It will start TineyGet instances and send multiple requests to different pages
# of the application

function Get-ScriptDirectory
{
    $Invocation = (Get-Variable MyInvocation -Scope 1).Value
    Split-Path $Invocation.MyCommand.Path
}

$ScriptDirectory = Split-Path -Path $MyInvocation.MyCommand.Definition -Parent
$program = Join-Path $ScriptDirectory "tinyget.exe"
$argServerURL = "-server:" + (Read-Host 'Please input the Web App URL')
$argThreads = "-threads:" + (Read-Host 'Please input no. of threads to use (fore.g 10, 20, 50)')
$argLoop = "-loop:" + (Read-Host 'Please input no. of times to loop (for e.g.100, 200, 500)')

$uriDefault = '/Home/Index'
$uriMemory = '/PerfIssues/MemLeak'
$uriHighCPU = '/PerfIssues/SpinCpuBtnHandler'
$uriException = '/ProduceError/500'
$uriLongRunning='/PerfIssues/SleepBtnHandler'
$uriDiagnosticLogging = '/Home/ProduceLogs'

$argPageURL = "-uri:$uriDiagnosticLogging"
$arguments = "$argServerURL $argPageURL $argThreads $argLoop"
Write-Host "Started Requests for" $uriDiagnosticLogging
Start-Process $program -ArgumentList $arguments -WindowStyle Hidden

$argPageURL = "-uri:$uriDefault"
$arguments = "$argServerURL $argPageURL $argThreads $argLoop"
Write-Host "Started Requests for" $uriDefault $arguments
Start-Process $program -ArgumentList $arguments -WindowStyle Hidden

$argPageURL = "-uri:$uriException"
$arguments = "$argServerURL $argPageURL $argThreads $argLoop"
Write-Host "Started Requests for" $uriException $arguments
Start-Process $program -ArgumentList $arguments -WindowStyle Hidden

$argPageURL = "-uri:$uriLongRunning"
$arguments = "$argServerURL $argPageURL $argThreads $argLoop"
Write-Host "Started Requests for" $uriLongRunning $arguments
Start-Process $program -ArgumentList $arguments -WindowStyle Hidden

$argPageURL = "-uri:$uriHighCPU"
$arguments = "$argServerURL $argPageURL $argThreads $argLoop"
Write-Host "Started Requests for" $uriHighCPU $arguments
Start-Process $program -ArgumentList $arguments -WindowStyle Hidden
