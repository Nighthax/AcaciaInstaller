@ECHO OFF & CLS & ECHO.
NET FILE 1>NUL 2>NUL & IF ERRORLEVEL 1 (ECHO You must right-click and select & ECHO "RUN AS ADMINISTRATOR"  to run this batch. Exiting... & ECHO. & PAUSE & EXIT /D)
:: ... proceed here with admin rights ...
:: This replaces the previous UAC prompt to avoid false flags from anti-virus products
:: Makes sure user has UAC privlages. If not, the script will not continue.
goto :Start

:Start
:: set title of application
title Acacia Installer 5.0.1
cls
goto :AutoUpdate

:AutoUpdate
:: launch update website
:: if you have an issue with this, just remove the "start" command and the website
start https://acaciainstaller.weebly.com/5dot0dot1update.html
echo The script will now launch a website to check if you are on the latest version of Acacia Installer
echo Press any key to continue
echo Nighthax/AcaciaInstaller is licensed under the GNU General Public License v2.0
pause
cls
goto :FunctionPrompt

:FunctionPrompt
:: prompts user with actions, alerts user of Chocolatey requirement,  describes license
Color 40
cls
echo.
echo Chocolatey is REQUIRED to uses this application.
echo Nighthax/AcaciaInstaller is licensed under the GNU General Public License v2.0
echo Acacia Installer is not responsible for any damage caused by using Chocolatey incorrectly.
echo If you have any issue that is not directly related to this script, ask Chocolatey for help, not us.
echo 1. Install Chocolatey
echo 2. Update and install programs
echo 3. Help - Official Website
echo.
choice /C 123 /M "Enter your choice:"
:: Note - list ERRORLEVELS in decreasing order
if errorlevel 3 goto :helpsite
if errorlevel 2 goto :installconfirmation
if errorlevel 1 goto :chocolateyinstallerprompt

:helpsite
start https://github.com/Nighthax/AcaciaInstaller
pause
goto :FunctionPrompt

:chocolateyinstallerprompt
color 40
cls
:: Confirms user agrees to what will take place and lists system requirements
echo Press any key to install chocolatey and common dependencies for various applications
echo SYSTEM REQUIREMENTS:
echo Windows 7+ or Windows Server 2003+
echo PowerShell V2 (minimum is v3 for install from this website due to TLS 1.2 requirement)
echo .NET Framework 4+ (the installation will attempt to install .NET 4.0 if you do not have it installed)(minimum is 4.5 for install from this website due to TLS 1.2 requirement)
echo at least 500mb of ram free (Recommended 1GB) - atleast 2gb of ram in the system (4GB recommended)
echo at least 1GB of free hard drive space
echo Acacia Installer is not responsible for any damage caused by ignoring these requirements!
pause
goto :chocolateyinstaller

:chocolateyinstaller
color 3f
cls
echo Installing Chocolatey and common dependencies for various applications
echo By installing, you agree to the Chocolatey license agreement as well as the dependency license agreements.
echo process started at %date% %time%
:: official command prompt Chocolatey Installer. If you do not trust this, you can compare it to the one on the chocolatey website
:: at https://chocolatey.org/install   - They are the same as of May 10 2020
@"%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe" -NoProfile -InputFormat None -ExecutionPolicy Bypass -Command "[System.Net.ServicePointManager]::SecurityProtocol = 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))" && SET "PATH=%PATH%;%ALLUSERSPROFILE%\chocolatey\bin"
echo Installing dependencies
echo stage 2 started at %date% %time%
:: Installs common dependencies to fix an issue that might occur
choco upgrade chocolatey-windowsupdate.extension chocolatey-core.extension dotnetfx netfx-4.6.2 chocolatey-dotnetfx.extension netfx-repair-tool chocolatey-azuredatastudio.extension chocolatey-visualstudio.extension chocolatey-isomount.extension -y
echo If you have any issues with dependencies, run the "netfx-repair-tool" installed on the computer.
echo Done installing Chocolatey
echo finished at %date% %time%
pause
goto :FunctionPrompt

:installconfirmation
:: Confirms user agrees to what will take place
color 40
cls
echo This will update all of the software in the list that you have created. If it is not detected, it will be installed
echo By installing these software, you automatically agree to their own license agreements.
echo If you have UAC turned on or are not an administrator, Chocolatey is going to request administrative permission at some point (at least once during the process). Otherwise it will not be able to finish what it is doing successfully. If you don't have UAC turned on, it will just continue on without stopping to bother you.
echo Press any key to agree
pause
goto :listsoftwarechoice

:listsoftwarechoice
color 40
cls
echo What programs would you like to update?
::You can have as many lists of software as you would like.
echo 1.Update and install Example 1
echo 2.Update and install Example 2
echo.
choice /C 12 /M "Enter your choice:"
:: Make sure you change the above line's number count if you add more lists (example: 12 is for 2 lists, 123 is for 3 lists)
:: Note - list ERRORLEVELS in decreasing order
if errorlevel 2 goto :Example2
if errorlevel 1 goto :Example1
::Add extra errorlevels for more lists.

:Example1
::Tells the software to update Example 1's list of software
::You can find Chocolatey packages at https://chocolatey.org/packages
color 1f
cls
echo Installing Example1
echo process started at %date% %time%
choco upgrade SOFTWARE GOES HERE CHANGE THIS -y
goto :Done
:: Keep the "choco upgrade" and "-y" part

:Example2
::Tells the software to update Example 2's list of software
::You can find Chocolatey packages at https://chocolatey.org/packages
color 1f
cls
echo Installing Example2
echo process started at %date% %time%
choco upgrade SOFTWARE GOES HERE CHANGE THIS -y
goto :Done
:: Keep the "choco upgrade" and "-y" part

:Done
::Stop the application
color 20
echo process finished at %date% %time%
echo Done! Press any key to exit.
pause

::  Nighthax/AcaciaInstaller is licensed under the GNU General Public License v2.0
:: The GNU GPL is the most widely used free software license and has a strong copyleft requirement. When distributing derived works, the source code of the work must be made available under the same license. There are multiple variants of the GNU GPL, each with different requirements.
::  __    ___   __    ___  __   __     __  __ _  ____  ____  __   __    __    ____  ____ 
:: / _\  / __) / _\  / __)(  ) / _\   (  )(  ( \/ ___)(_  _)/ _\ (  )  (  )  (  __)(  _ \
::/    \( (__ /    \( (__  )( /    \   )( /    /\___ \  )( /    \/ (_/\/ (_/\ ) _)  )   /
::\_/\_/ \___)\_/\_/ \___)(__)\_/\_/  (__)\_)__)(____/ (__)\_/\_/\____/\____/(____)(__\_)
::Acacia Installer 5.0.1 by Acacia/Nighthax

