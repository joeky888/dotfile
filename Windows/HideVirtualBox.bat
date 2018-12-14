@echo off
@reg copy HKLM\HARDWARE\ACPI\DSDT\VBOX__ HKLM\HARDWARE\ACPI\DSDT\NOBOX__ /s /f
@reg delete HKLM\HARDWARE\ACPI\DSDT\VBOX__ /f
@reg add HKLM\HARDWARE\DESCRIPTION\System /v SystemBiosVersion /t REG_MULTI_SZ /d "NOBOX - 1" /f
@reg add HKLM\HARDWARE\DESCRIPTION\System /v VideoBiosVersion /t REG_MULTI_SZ /d "" /f
pause
