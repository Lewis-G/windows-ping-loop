@echo off
setlocal enabledelayedexpansion

set "subnet=10.0.0."
set "start=1"
set "end=255"

for /L %%i in (%start%, 1, %end%) do (
    set "ip=!subnet!%%i"
    ping -n 1 !ip! | find "Reply" >nul
    if not errorlevel 1 (
        echo !ip! is reachable
    )
)
