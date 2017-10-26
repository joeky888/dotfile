del /f /s /q %SYSTEMDRIVE%\*.tmp
del /f /s /q %SYSTEMDRIVE%\*._mp
del /f /s /q %SYSTEMDRIVE%\*.log
del /f /s /q %SYSTEMDRIVE%\*.gid
del /f /s /q %SYSTEMDRIVE%\*.chk
del /f /s /q %SYSTEMDRIVE%\*.old
del /f /s /q %SYSTEMDRIVE%\recycled\*.*
del /f /s /q %WINDIR%\*.bak
del /f /s /q %WINDIR%\prefetch\*.*

rd /s /q %WINDIR%\temp & md %WINDIR%\temp

del /f /q %USERPROFILE%\cookies\*.*
del /f /q %USERPROFILE%\recent\*.*
del /f /s /q "%USERPROFILE%\Local Settings\Temporary Internet Files\*.*"
del /f /s /q "%USERPROFILE%\Local Settings\Temp\*.*"
del /f /s /q "%USERPROFILE%\recent\*.*"
del /f /s /q "C:\Dragonfly\Special Force\XIGNCODE\*"
del /f /s /q "C:\Dragonfly\Special Force\SpecialForce_exe_log.edl"

break>"C:\Dragonfly\Special Force\data\lobby\SF_Curse.drk"

:: Lower the mtu value, default mtu=1500
:: netsh interface ipv4 set subinterface Wi-Fi mtu=296  store=persistent

:: Reset Networking
:: ipconfig /release
:: ipconfig /renew
:: arp -d *
:: nbtstat -R
:: nbtstat -RR
:: ipconfig /flushdns
:: ipconfig /registerdns

pause
