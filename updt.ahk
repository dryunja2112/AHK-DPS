﻿updurl := "https://github.com/dryunja2112/AHK-DPS/blob/master/DPS%20AHK.exe?raw=true"
SplashTextOn, , 60,Автообновление, Обновление. Ожидайте..`nНастраиваем систему обновления.
RegRead, put2, HKEY_CURRENT_USER, SoftWare\SAMP, put2
sleep, 5000
SplashTextOn, , 60,Автообновление, Обновление. Ожидайте..`nСкачиваем обновленную версию.
URLDownloadToFile, %updurl%, %put2%
SplashTextOn, , 60,Автообновление, Обновление. Ожидайте..`nЗапускаем обновленную версию.
sleep, 3000
run % put2
sleep, 1000
FileDelete, %a_temp%/updt.ahk
ExitApp