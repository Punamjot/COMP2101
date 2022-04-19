function welcome {
write-output "Welcome to poershell $env:computername Overlord $env:username"
$now = get-date -format 'HH:MM tt on dddd'
write-output "it is $now"
}
welcome

function get-cpuinfo {
get-ciminstance cim_processor | format-list Manufacturer, Name, CurrentClockSpeed, MaxClockSpeed, NumberOfCores
}
get-cpuinfo

function get-mydisks {
get-disk | select-object Manufacturer, Model, SerialNumber, FirmwareRevision, Size
}
get-mydisks


echo " ***__System_Hardware_Description__***"
function HardwareDescription {
Get-WmiObject -class win32_computersystem
}
HardwareDescription



echo " ***__Operating_System_Name_and_Version_Number__***"
function OperatingSystem {
Get-WmiObject -class win32_OperatingSystem | Format-list name, version
}
OperatingSystem



echo " ***__Processor_Description__***"
function ProcessorDescription {
Get-WmiObject -class win32_processor | Format-list  Description, MaxClockspeed, NumberOfCores, L3CacheSize, L3CacheSpeed
}
ProcessorDescription



echo " ***__Summary_Of_RAM_installed__***"
function RAMinstalled {
Get-WmiObject -class win32_physicalmemory |
foreach {
         New-Object -TypeName psobject -Property @{
             Manufacturer = $_.Manufacturer
             Description = $_.Description
             Banklabel = $_.BankLabel
             Slot = $_.DeviceLocator
             "Size(MB)"=$_.Capacity / 1mb -as [int]
          }
          $total = $_.Capacity / 1mb -as [int]
 } |Format-Table Manufacturer, Description, BankLabel, Slot, "Size(MB)"
 "totalRAM = $total MB"
}
RAMinstalled



echo " ***__Summary_Of_PhysicalDisk_drives__***"
function PhysicalDisk {
$diskdrives = Get-CIMInstance CIM_diskdrive

  foreach ($disk in $diskdrives) {
      $partitions = $disk|get-cimassociatedinstance -resultclassname CIM_diskpartition
      foreach ($partition in $partitions) {
            $logicaldisks = $partition | get-cimassociatedinstance -resultclassname CIM_logicaldisk
            foreach ($logicaldisk in $logicaldisks) {
                     new-object -typename psobject -property @{Manufacturer = $disk.Manufacturer
                                                               Model = $disk.model
                                                               Space = ($disk.size - $logicaldisk.FreeSpace) /1gb -as [int]
                                                               FreeSpace = ($logicaldisk.FreeSpace) /1gb -as [int]
                                                               "Size(GB)"=$disk.size / 1gb -as [int]
                                                               } | Format-Table Manufacturer, Space, FreeSpace, "Size(GB)"
           }
      }
  }
}
PhysicalDisk



echo " ***__Network_Adapter_Configuration__***"
function NetworkAdapter {
get-ciminstance -class win32_networkadapterconfiguration | where-object ipenabled | format-table Description, Index, IPAddress, IPSubnet, DNSDomain, DNSServerSearchOrder
}
NetworkAdapter



echo " ***__Video_Card_Vendor_Description_and_CurrentScreenResolution__***"
function VideoController {
Get-WmiObject -class win32_Videocontroller |
foreach {
          New-Object -TypeName psobject -Property @{
                     Description = $_.Description
                     Manufacturer = $_.AdapterCompatibility
                     VideoArchitecture = $_.VideoArchitecture
                     CurrentScreenResolution = [string]$_.CurrentHorizontalResolution + "x" + $_.CurrentVerticalResolution
  } | Format-List Description, Manufacturer, VideoArchitecture, CurrentScreenResolution
  }
  }
VideoController