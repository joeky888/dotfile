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
del /f /s /q "%ProgramFiles(x86)%\WAYI\SFOnline\XIGNCODE\*"
del /f /s /q "%ProgramFiles(x86)%\WAYI\SFOnline\SpecialForce_exe_log.edl"

break>"%ProgramFiles(x86)%\WAYI\SFOnline\data\lobby\SF_Curse.drk"
