param 
(
[parameter()]
[switch]$System, 

[parameter()]
[switch]$Disks,
 
[parameter()]
[switch]$Networks
)
if ($System)
{
echo " ***__System_Hardware_Description__***"
HardwareDescription

echo " ***__Operating_System_Name_and_Version_Number__***"
OperatingSystem

echo " ***__Processor_Description__***"
ProcessorDescription

echo " ***__Summary_Of_RAM_installed__***"
RAMinstalled

echo " ***__Video_Card_Vendor_Description_and_CurrentScreenResolution__***"
VideoController
}
elseif ($Disks)
{
echo " ***__Summary_Of_PhysicalDisk_drives__***"
PhysicalDisk
}
elseif ($Networks)
{
echo " ***__Network_Adapter_Configuration__***"
NetworkAdapter
}
else {
echo " ***__System_Hardware_Description__***"
HardwareDescription

echo " ***__Operating_System_Name_and_Version_Number__***"
OperatingSystem

echo " ***__Processor_Description__***"
ProcessorDescription

echo " ***__Summary_Of_RAM_installed__***"
RAMinstalled

echo " ***__Summary_Of_PhysicalDisk_drives__***"
PhysicalDisk

echo " ***__Network_Adapter_Configuration__***"
NetworkAdapter

echo " ***__Video_Card_Vendor_Description_and_CurrentScreenResolution__***"
VideoController
}