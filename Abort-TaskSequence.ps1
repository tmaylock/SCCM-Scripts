$namespace = "root\ccm\SoftMgmtAgent"
$class = "CCM_TSExecutionRequest"
$filter = "State = 'Completed' And CompletionState = 'Failure'"

$ts = Get-WmiObject -Namespace $namespace -Class $class -Filter $filter

if ($ts) {
    $ts.Delete()
    Restart-Service ccmexec -force
}
