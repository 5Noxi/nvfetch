# NVFetch

Used to be my personal `neofetch`/`fastfetch` replacement with more details. Some arguments will probably also get added like `ids`, so it doesn't display the serial numbers and miscellaneous HWIDs by default. It currently gets most of the information using the [`Get-CimInstance`](https://learn.microsoft.com/en-us/powershell/module/cimcmdlets/get-ciminstance?view=powershell-7.5) cmdlet and `nvidia-smi` for NVIDIA GPUs. Use:
```ps
nvidia-smi -q
```
to get a list with information. `win32cimv2.txt` shows class names in the `root\CIMV2` namespace, filtered with `Win32*`:


Example output:
![](https://github.com/5Noxi/nvfetch/blob/main/images/output.png?raw=true)

## `nvfetch` displays

| Category    | Class / Command | Details |
|-------------|--------------------------|----------------------|
| **OS**      | `Win32_OperatingSystem` | `Caption`, `OSArchitecture`, `Version` |
| **Time Zone** | `Get-TimeZone` | `DisplayName` |
| **Uptime**  | `Win32_OperatingSystem` | `LastBootUpTime` |
| **Display** | `Win32_VideoController`<br>`WmiMonitorID`<br>`WmiMonitorBasicDisplayParams`<br>`WmiMonitorConnectionParams` | Name, resolution, refresh rate, size (inch), external/internal |
| **BIOS**    | `Win32_BIOS` | `Manufacturer`, `SMBIOSBIOSVersion`, `ReleaseDate` |
| **Motherboard** | `Win32_BaseBoard` | `Product`, `Manufacturer` |
| **CPU**     | `Win32_Processor` | `Name`, `SocketDesignation`, `MaxClockSpeed` |
| **GPU (NVIDIA)** | `nvidia-smi` (if present)<br>`gc nvidia-smi` | Name, core clock, memory clock, VRAM, BPP, performance state (`P0`= max performance - `P12` = min performance)*<br><br>Command:<br>``--query-gpu=name,memory.total,memory.used,memory.free,pstate,clocks.mem,clocks.gr --format=csv,noheader,nounits`` |
| **GPU (AMD)** | `Win32_VideoController` | `Name`, `Caption`, `CurrentBitsPerPixel`<br>VRAM size read from class path (`qwMemorySize`) |
| **RAM**     | `Win32_PhysicalMemory` | `Capacity`, `ConfiguredClockSpeed`, `Manufacturer` |
| **Drive**   | `Win32_DiskDrive` & `Win32_LogicalDisk` | Uses `drive0` & `C:\`<br>`Size`, `FreeSpace`, `FileSystem` |
| **Network** | `Win32_NetworkAdapterConfiguration` | `Description`, `IPAddress`, `DHCPEnabled` |
| **HWIDs**   | `Win32_ComputerSystemProduct` - UUID<br>`Win32_BaseBoard` - Motherboard SN<br>`Win32_Processor` - CPU ID<br>`Win32_PhysicalMemory` - RAM SNs<br>`Win32_DiskDrive` / `Win32_PhysicalMedia` - Drive0 SN<br>`nvidia-smi` - GPU UUID<br><br>Command: `--query-gpu=uuid` | Unique identifiers for system components. |


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
