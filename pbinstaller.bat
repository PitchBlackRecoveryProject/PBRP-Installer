@echo off
title PitchBlack Recovery Installer
echo.
echo  """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
echo  " __________   __    __              __      __________   __                       __     "
echo  " \______   \ |__| _/  |_    ____   |  |__   \______   \ |  |   _____      ____   |  | __ "
echo  "  |     ___/ |  | \   __\ _/ ___\  |  |  \   |    |  _/ |  |   \__  \   _/ ___\  |  |/ / "
echo  "  |    |     |  |  |  |   \  \___  |   Y  \  |    |   \ |  |__  / __ \_ \  \___  |    <  "
echo  "  |____|     |__|  |__|    \___  > |___|  /  |______  / |____/ (____  /  \___  > |__|_ \ "
echo  "                               \/       \/          \/              \/       \/       \/ "
echo  "               __________                                                                " 
echo  "               \______   \ ____   ____  _______  __ ___________ ___.__.                  "
echo  "                |       _// __ \_/ ___\/  _ \  \/ // __ \_  __ <   |  |                  "
echo  "                |    |   \  ___/\  \__(  <_> )   /\  ___/|  | \/\___  |                  "
echo  "                |____|_  /\___  >\___  >____/ \_/  \___  >__|   / ____|                  "
echo  "                       \/     \/     \/                \/       \/                       "
echo  """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
echo. 
echo                                Welcome to PBRP installer
echo. 
echo  """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
echo.
echo Allow debugging in your phone...
echo.
bin\adb.exe kill-server
bin\adb.exe devices
echo Getting stuff ready...
echo.
bin\7z.exe x PitchBlack*.zip >nul
rmdir /s /q META-INF >nul
echo Pushing tools... 
bin\adb.exe shell rm -r /sdcard/PBRP/tools >nul 2>nul
bin\adb.exe push PBRP /sdcard >nul 2>nul
echo.
echo Rebooting into fastboot...
bin\adb.exe reboot bootloader
echo.
echo Press enter if you are in fastboot mode...
pause >nul
echo.
echo Flashing PBRP...
bin\fastboot.exe flash recovery TWRP\recovery.img >nul 2>nul
echo.
echo Booting into PBRP...
bin\fastboot.exe boot TWRP\recovery.img >nul 2>nul
echo.
timeout 15
rmdir /s /q  TWRP >nul
rmdir /s /q PBRP >nul
echo.
echo ALL DONE
echo.
pause