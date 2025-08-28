# NVFetch

Used to be my personal `neofetch`/`fastfetch` replacement with more details. Some arguments will probably also get added like `ids`, so it doesn't display the serial numbers and miscellaneous HWIDs by default. It currently gets most of the information using the [`Get-CimInstance`](https://learn.microsoft.com/en-us/powershell/module/cimcmdlets/get-ciminstance?view=powershell-7.5) cmdlet and `nvidia-smi` ([*](https://discord.com/channels/836870260715028511/1375059420970487838/1375059629255692370)) for NVIDIA GPUs. Use:
```ps
nvidia-smi -q
```
to get a list with information. `win32cimv2.txt` shows class names in the `root\CIMV2` namespace, filtered with `Win32*`:


Example output:
![output](https://github.com/5Noxi/nvfetch/blob/main/output.png?raw=true)

## `nvfetch` displays:
- OS
  - `Win32_OperatingSystem` - `Caption`, `OSArchitecture`, `Version`
- Time Zone
  - `Get-TimeZone` - `DisplayName`
- Uptime
  - `Win32_OperatingSystem` - `LastBootUpTime`
- Display
  - Name, resolution, refresh rate, size (inch), external/internal
  - `Win32_VideoController`, `WmiMonitorID`, `WmiMonitorBasicDisplayParams`, `WmiMonitorConnectionParams`
- BIOS
  - `Win32_BIOS` - `Manufacturer`, `SMBIOSBIOSVersion`, `ReleaseDate`
- Motherboard
  - `Win32_BaseBoard` - `Product`, `Manufacturer`
- CPU
  - `Win32_Processor` - `Name`, `SocketDesignation`, `MaxClockSpeed`
- GPU
  - If `nvidia-smi` is present (`gc nvidia-smi`)
     - Name, core clock, memory clock, VRAM, BPP, performance state (`States range from P0 (maximum performance) to P12 (minimum performance)`)
     - `--query-gpu=name,memory.total,memory.used,memory.free,pstate,clocks.mem,clocks.gr --format=csv,noheader,nounits`
  - If `nvidia-smi` isn't present (AMD)
     - `Win32_VideoController` - `Name`, `Caption`, `CurrentBitsPerPixel`
     - Reads VRAM size  from class path (`qwMemorySize`)
- RAM
  - `Win32_PhysicalMemory` - `Capacity`, `ConfiguredClockSpeed`, `Manufacturer`
- Drive
  - `Win32_DiskDrive` & `Win32_LogicalDisk` - Uses `drive0` & `C:\`, `Size`, `FreeSpace`, `FileSystem`
- Network
  - `Win32_NetworkAdapterConfiguration` - `Description`, `IPAddress`, `DHCPEnabled`
- HWIDs
  - UUID - `Win32_ComputerSystemProduct`, `UUID`
  - Motherboard SN - `Win32_BaseBoard`, `SerialNumber`
  - CPU ID - `Win32_Processor`, `ProcessorId`
  - RAM SNs - `Win32_PhysicalMemory`, `SerialNumber`
  - Drive0 SN - `Win32_DiskDrive`/`Win32_PhysicalMedia`, `SerialNumber`
  - GPU UUID - `nvidia-smi`, `--query-gpu=uuid`

## Usage:
Download `NVFetch.ps1` and leave it in your `Downloads` folder. Run `CL.ps1` and you're done. Open a new terminal and `nvfetch` should show the system information. A valid argument is the color name, default is `Blue`. It changes the color of the ASCII logo. Change it by simply adding a valid color name:
```ps
nvfetch # Uses 'Blue'

nvfetch yellow
nvfetch red
```
Valid colors: `Black`, `Blue`, `Cyan`, `DarkBlue`, `DarkCyan`, `DarkGray`, `DarkGreen`, `DarkMagenta`, `DarkRed`, `DarkYellow`, `Gray`, `Green`, `Magenta`, `Red`, `White`, `Yellow`.

<ins>References:</ins>
> https://docs.nvidia.com/deploy/nvidia-smi/index.html
> https://learn.microsoft.com/en-us/powershell/module/cimcmdlets/get-ciminstance?view=powershell-7.5
> https://github.com/fastfetch-cli/fastfetch
> https://github.com/dylanaraps/neofetch
