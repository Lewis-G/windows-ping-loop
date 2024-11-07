@echo off
setlocal enabledelayedexpansion

:: Set the start and end IP addresses
set "start_ip=192.168.1.1"
set "end_ip=192.168.1.10"

:: Extract the octets
for /f "tokens=1-4 delims=." %%a in ("%start_ip%") do (
    set "start_octet1=%%a"
    set "start_octet2=%%b"
    set "start_octet3=%%c"
    set "start_octet4=%%d"
)

for /f "tokens=1-4 delims=." %%a in ("%end_ip%") do (
    set "end_octet1=%%a"
    set "end_octet2=%%b"
    set "end_octet3=%%c"
    set "end_octet4=%%d"
)

for /L %%a in (!start_octet1!,1,!end_octet1!) do (
    REM Check if the current value exceeds 255
    if %%a lss 256 (
        
        for /L %%b in (!start_octet2!,1,!end_octet2!) do (
            if %%b lss 256 (
                
                for /L %%c in (!start_octet3!,1,!end_octet3!) do (
                    if %%c lss 256 (

                        for /L %%d in (!start_octet4!,1,!end_octet4!) do (
                            if %%d lss 256 (

                                set "current_ip=%%a.%%b.%%c.%%d"
                                
                                echo Pinging !current_ip!
                                
                                ping -n 1 !current_ip! | findstr /i "TTL=" > nul
                                if !errorlevel! equ 0 (
                                    echo !current_ip! is reachable.
                                ) else (
                                    echo !current_ip! is not reachable.
                                )
                            )
                        )
                    )
                )
            )
        )
    )
)

endlocal