@echo off
setlocal enabledelayedexpansion

REM Set the first octet
set "octet1=%1"

REM Set the start and end IP addresses
set "start_ip=%2"
set "end_ip=%3"

REM Set the number of packets sent to each address, or default to 1
if "%4"=="" (
    set "packet_number=1"
) else (
    set "packet_number=%4"
)

REM Convert IP addresses to 32-bit integer
call :octetsToInt %start_ip% startInt
call :octetsToInt %end_ip% endInt
set "current_last_3_octets="

for /L %%a in (!startInt!,1,!endInt!) do (

    call :intToOctets %%a current_last_3_octets
    
    set "current_ip=!octet1!.!current_last_3_octets!"
                                
    echo Pinging !current_ip!
    
    ping -n !packet_number! !current_ip! | findstr /i "TTL=" > nul
    if !errorlevel! equ 0 (
        echo !current_ip! is reachable.
    ) else (
        echo !current_ip! is not reachable.
    )
)

endlocal
exit /b

REM Function to convert 3 octets to integer
:octetsToInt
set ip=%1
for /f "tokens=1-3 delims=." %%a in ("%ip%") do (
    set "octet2=%%a"
    set "octet3=%%b"
    set "octet4=%%c"
)
set /A "%~2=(octet2*256*256) + (octet3*256) + octet4"
exit /b

REM Function to convert integer to 3 octets
:intToOctets
set /A "octet2=%1>>16 & 255, octet3=%1>>8 & 255, octet4=%1 & 255"
set "%~2=!octet2!.!octet3!.!octet4!"
exit /b