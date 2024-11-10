# Get current brightness
$currentBrightness = (Get-CimInstance -Namespace root/wmi -ClassName WmiMonitorBrightness).CurrentBrightness

# Check if any arguments are passed
if ($args.Count -eq 0) {
    # Print the current brightness to stdout
    Write-Output "Current Brightness: $currentBrightness%"

} elseif ($args[0] -eq '+ve') {
    # Increase the brightness by 10%
    $newBrightness = [math]::Min($currentBrightness + 10, 100)  # Cap the brightness at 100%
    
    # Set the new brightness value --> Increase
    $brightnessController = Get-WmiObject -Namespace root/WMI -Class WmiMonitorBrightnessMethods
    $brightnessController.WmiSetBrightness(1, $newBrightness)

} elseif ($args[0] -eq '-ve') {
    # Decrease the brightness by 10%
    $newBrightness = [math]::Min($currentBrightness - 10, 100)  # Cap the brightness at 100%
    
    # Set the new brightness value --> Decrease
    $brightnessController = Get-WmiObject -Namespace root/WMI -Class WmiMonitorBrightnessMethods
    $brightnessController.WmiSetBrightness(1, $newBrightness)

} else {
    Write-Output "Invalid argument." 
}
