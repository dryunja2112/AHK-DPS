#Include UDF.ahk


buildscr = 1
downlurl := "https://github.com/dryunja2112/AHK-DPS/blob/master/updt.exe?raw=true"
downllen := "https://github.com/dryunja2112/AHK-DPS/raw/master/verlen.ini"

Utf8ToAnsi1(ByRef Utf8String, CodePage = 1251)
{
If (NumGet(Utf8String) & 0xFFFFFF) = 0xBFBBEF
BOM = 3
Else
BOM = 0

UniSize := DllCall("MultiByteToWideChar", "UInt", 65001, "UInt", 0
, "UInt", &Utf8String + BOM, "Int", -1
, "Int", 0, "Int", 0)
VarSetCapacity(UniBuf, UniSize * 2)
DllCall("MultiByteToWideChar", "UInt", 65001, "UInt", 0
, "UInt", &Utf8String + BOM, "Int", -1
, "UInt", &UniBuf, "Int", UniSize)

AnsiSize := DllCall("WideCharToMultiByte", "UInt", CodePage, "UInt", 0
, "UInt", &UniBuf, "Int", -1
, "Int", 0, "Int", 0
, "Int", 0, "Int", 0)
VarSetCapacity(AnsiString, AnsiSize)
DllCall("WideCharToMultiByte", "UInt", CodePage, "UInt", 0
, "UInt", &UniBuf, "Int", -1
, "Str", AnsiString, "Int", AnsiSize
, "Int", 0, "Int", 0)
Return AnsiString
}
WM_HELP(){
IniRead, vupd, %a_temp%/verlen.ini, UPD, v
IniRead, desupd, %a_temp%/verlen.ini, UPD, des
desupd := Utf8ToAnsi1(desupd)
IniRead, updupd, %a_temp%/verlen.ini, UPD, upd
updupd := Utf8ToAnsi1(updupd)
msgbox, , Список изменений версии %vupd%, %updupd%
return
}

OnMessage(0x53, "WM_HELP")
Gui +OwnDialogs

SplashTextOn, , 60,Автообновление, Запуск скрипта. Ожидайте..`nПроверяем наличие обновлений.
URLDownloadToFile, %downllen%, %a_temp%/verlen.ini
IniRead, buildupd, %a_temp%/verlen.ini, UPD, build
if buildupd =
{
SplashTextOn, , 60,Автообновление, Запуск скрипта. Ожидайте..`nОшибка. Нет связи с сервером.
sleep, 2000
}
if buildupd > % buildscr
{
IniRead, vupd, %a_temp%/verlen.ini, UPD, v
SplashTextOn, , 60,Автообновление, Запуск скрипта. Ожидайте..`nОбнаружено обновление до версии %vupd%!
sleep, 2000
IniRead, desupd, %a_temp%/verlen.ini, UPD, des
desupd := Utf8ToAnsi1(desupd)
IniRead, updupd, %a_temp%/verlen.ini, UPD, upd
updupd := Utf8ToAnsi1(updupd)
SplashTextoff
msgbox, 16384, Обновление скрипта до версии %vupd%, %desupd%
IfMsgBox OK
{
msgbox, 1, Обновление скрипта до версии %vupd%, Хотите ли Вы обновиться?
IfMsgBox OK
{
put2 := % A_ScriptFullPath
RegWrite, REG_SZ, HKEY_CURRENT_USER, Software\SAMP ,put2 , % put2
SplashTextOn, , 60,Автообновление, Обновление. Ожидайте..`nОбновляем скрипт до версии %vupd%!
URLDownloadToFile, %downlurl%, %a_temp%/updt.exe
sleep, 1000
run, %a_temp%/updt.exe
exitapp
}
}
}
SplashTextoff



articles := ["2 1.1 УК (Нападение на гражданское лицо)"
			,"4 1.2 УК (Нападение на гражданское лицо, будучи вооруженным)"
			,"5 1.3 УК (Оказание вооруженного сопротивения)"
			,"2 2.1 УК (Попытка / угон цивильного транспорта)"
			,"3 2.2 УК (Попытка / угон государственного транспорта)"
			,"1 2.3 УК (Ношение оружия в открытом виде)"
			,"2 2.4 УК (Использование оружия не имея лицензий)"
			,"4 2.5 УК (Нелегальное распространение оружия)"
			,"5 2.6 УК (Нелегальное распространение / покупка наркотиков)"
			,"4 2.7 УК (Использование, хранение наркотиков)"
			,"1 3.1 УК (Попытка дачи взятки должестному лицу)"
			,"4 3.2 УК (Получение взятки со стороны должестного лица)"
			,"1 3.3 УК (Оскорбление сотрудника гос.структур)"
			,"2 4.1 УК (Неподчинение правоохранительным органам)"
			,"1 4.2 УК (Помеха работе правоохранительным органам)"
			,"6 4.3 УК (Проникновение на территорию воинской части)"
			,"2 4.4 УК (Проникновение на территорию, защищаемую правоохранительными органами)"
			,"2 4.5 УК (Соучастие в преступлении)"
			,"6 5.1 УК (Любой акт терроризма)"
			,"4 5.2 УК (Организация митингов)"
			,"6 5.3 УК (Взятие в заложники)"
			,"2 6.1 УК (Порча государственного / гражданского имущества)"
			,". 6.2 УК (Ложный вызов государственных структур) (Выдается штраф)"
			,"1 6.3 УК (Отказ от предоставления документов)"
			,"1 6.4 УК (Явка с повинной, 2 - 4 уровень розыска)"
			,"2 6.5 УК (Явка с повинной, 5 - 6 уровень розыска)"
			,"6 6.6 УК (Шпионаж / Продажа / Слив государственной информации)"
			,"6 6.7 УК (Передача государственной информации ОПГ)"]
	
articles2 :=["1.2 КоАП (Превышение скорости, в следствии чего произошло ДТП)"
			,"2.1 КоАП (Езда по встречной полосе)"
			,"2.2 КоАП (Езда по встречной полосе, в следствии чего произошло ДТП)"
			,"2.3 КоАП (Разворот через сплошную линию)"
			,"3.2 КоАП (Проезд на красный свет, в следствии чего произошло ДТП)"
			,"6.2 КоАП (Игнорирование сирен спец.служб, в следствии чего произошло ДТП)"
			,"10.1 КоАП (Агрессивное вождение)"]

F4::
text := ["{FFFAFA}Сковать в наручники(/cuff)"
		,"Расковать из наручников (/uncuff)"
		,"Объявить в розыск (/su)"
		,"Выписать штраф (/ticket)"
		,"Отправить преступника в КПЗ (/arrest)"
		,"Лишить прав (/takelic)"]
showDialog(2, "{FFA500}Меню ДПС {FFFAFA}by Andre Wilman", GetText(text)[1], "X")
menu := 1, line_num := 1, line_max := text.MaxIndex()
return

End:: reload

~Enter::
if (!menu)
{
	return
}
if (menu == 1)
{
	menu := 0
	
	if (line_num == 1)
	{
		showDialog(1, "Сковать в наручники", "{FFFFFF}Введите ID игрока", "X")
		Input, ID, V I M, {enter}
		SendChat("/do Наручники находятся в кобуре.")
		Sleep, 700
		SendChat("/me резким движением руки взял наручники в руку")
		Sleep, 700
		SendChat("/do Наручники в руке.")
		Sleep, 700
		SendChat("/me резко надел наручники на руки")
		Sleep, 700
		SendChat("/cuff " ID)
		Sleep, 700
		SendChat("/do Наручники надеты.")
		Sleep, 700
		SendChat("/me заломал нарушителя")
		Sleep, 700
		SendChat("/escort " ID)
		Sleep, 700
		SendChat("/do Процесс...")
	}
		else if (line_num == 4)
	{
	showDialog(1, "Выписать штраф", "{FFFFFF}Введите ID игрока", "X")
	Input, ID, V I M, {enter}
	Sleep, 700
	showDialog(1, "Выписать штраф", "{FFFFFF}Введите сумму штрафа", "X")
	Input, srok, V I M, {enter}
	Sleep, 700
	showDialog(1, "Выписать штраф", "{FFFFFF}Введите причину штрафа", "X")
	Input, prich, V I M, {enter}
	Sleep, 700
	SendChat("/me достал протокол и ручку")
	Sleep, 1200
	SendChat("/do Протокол и ручка в руках.")
	Sleep, 1200
	SendChat("/me начал заполнять протокол")
	Sleep, 1200
	SendChat("/do Процесс...")
	Sleep, 1200
	SendChat("/me написал персональный номер водителя")
	Sleep, 1200
	SendChat("/do В графе «Персональный номер водителя» написано: " ID ".")
	Sleep, 1200
	SendChat("/me написал причину штрафа")
	Sleep, 1200
	SendChat("/do В графе «Причина» написано: " prich ".")
	Sleep, 1200
	SendChat("/me написал сумму штрафа")
	Sleep, 1200
	SendChat("/do В графе «Сумма штрафа» написано: " srok " рублей.")
	Sleep, 1200
	SendChat("/me написал дату выдачи штрафа")
	Sleep, 1200
	SendChat("/do В графе «Дата» написано: " A_DD "." A_MM ".2020.")
	Sleep, 1200
	SendChat("/me написал время выдачи штрафа")
	Sleep, 1200
	SendChat("/do В графе «Время» написано: " A_Hour ":" A_Min ".")
	Sleep, 1200
	SendChat("/do Протокол заполнен.")
	Sleep, 1200
	SendChat("/me оторвал копию протокола по линии разрыва")
	Sleep, 1200
	SendChat("/do Копия протокола оторвана.")
	Sleep, 1200
	SendChat("/me передал копию протокола")
	Sleep, 1200
	SendChat("С данной копией протокола пройдите в банк для оплаты штрафа.")
	Sleep, 1200
	SendChat("/ticket " ID " " srok " " prich)
	}
	else if (line_num == 2)
	{
		showDialog(1, "Расковать из наручников", "{FFFFFF}Введите ID игрока", "X")
		Input, ID, V I M, {enter}
		Sleep, 700
		SendChat("/do Наручники надеты на руках.")
		Sleep, 700
		SendChat("/me взяв ключ в руку, отстегнул наручники")
		Sleep, 700
		SendChat("/uncuff " ID)
		Sleep, 700
		SendChat("/do Наручники отстегнуты.")
		Sleep, 700
		SendChat("/me положил наручники в кобуру")
		Sleep, 700
		SendChat("/do Наручники в кобуре.")
	}
		else if (line_num == 5)
	{
		showDialog(1, "Отправить преступника в КПЗ", "{FFFFFF}Введите ID игрока", "X")
		Input, ID, V I M, {enter}
		Sleep, 1000
		SendChat("/me достал протокол и ручку")
		Sleep, 1000
		SendChat("/do Протокол и ручка в руках.")
		Sleep, 1000
		SendChat("/me начал заполнять протокол задержания")
		Sleep, 1000
		SendChat("/do Процесс...")
		Sleep, 1000
		SendChat("/me написал персональный номер задерживаемого")
		Sleep, 1000
		SendChat("/do В графе «Персональный номер задерживаемого» написано: " ID ".")
		Sleep, 1000
		SendChat("/me написал причину задержания")
		Sleep, 1000
		SendChat("/do В графе «Причина задержания» написано: нарушение Уголовного Кодекса.")
		Sleep, 1000
		SendChat("/me написал дату задержания")
		Sleep, 1000
		SendChat("/do В графе «Дата» написано: " A_DD "." A_MM ".2020.")
		Sleep, 1000
		SendChat("/me написал время задержания")
		Sleep, 1000
		SendChat("/do В графе «Время» написано: " A_Hour ":" A_Min ".")
		Sleep, 1000
		SendChat("/do Протокол заполнен.")
		Sleep, 1000
		SendChat("/me передал протокол дежурному")
		Sleep, 1000
		SendChat("/do Передача.")
		Sleep, 1000
		SendChat("/arrest " ID)
	}
	else if (line_num == 3)
	{
		showDialog(2, "Объявить в розыск (перед статьей указано количество звезд)", GetText(articles)[1], "X")
		menu := 2, line_num := 1, line_max := articles.MaxIndex()
	}
	else if (line_num == 6)
	{
		showDialog(2, "Лишить прав", GetText(articles2)[1], "X")
		menu := 3, line_num := 1, line_max := articles2.MaxIndex()
	}
}
else if (menu == 2)
{
	menu := 0
	
	showDialog(1, "Объявить в розыск", "{FFFFFF}Введите ID игрока", "X")
	Input, ID, V I M, {enter}
	Sleep, 700
	SendChat("/me взял рацию в руку")
	Sleep, 700
	SendChat("/do Рация в руке.")
	Sleep, 700
	SendChat("/me сообщил данные нарушителя дежурному")
	Sleep, 700
	SendChat("/do Данные сообщены.")
	Sleep, 700
	SendChat("/su " ID " " RegExReplace(articles[line_num], "\s+\(.*\)"))
	Sleep, 700
	SendChat("/me убрал рацию в крепление")
}
else if (menu == 3)
{
	menu := 0
	
	showDialog(1, "Лишить прав", "{FFFFFF}Введите ID игрока", "X")
	Input, ID, V I M, {enter}
	Sleep, 700
	SendChat("/me взял протокол и ручку в руки")
	Sleep, 1200
	SendChat("/do Протокол и ручка в руках")
	Sleep, 1200
	SendChat("/me начал заполнять протокол")
	Sleep, 1200
	SendChat("/do Процесс...")
	Sleep, 1200
	SendChat("/me написал персональный номер водителя")
	Sleep, 1200
	SendChat("/do В графе «Персональный номер водителя» написано: " ID ".")
	Sleep, 1200
	SendChat("/me написал причину")
	Sleep, 1200
	SendChat("/do В графе «Причина» написано: " RegExReplace(articles2[line_num], "\s+\(.*\)")".")
	Sleep, 1200
	SendChat("/me написал дату")
	Sleep, 1200
	SendChat("/do В графе «Дата» написано: " A_DD "." A_MM ".2020.")
	Sleep, 1200
	SendChat("/me написал время")
	Sleep, 1200
	SendChat("/do В графе «Время» написано: " A_Hour ":" A_Min ".")
	Sleep, 1200
	SendChat("/do Протокол заполнен.")
	Sleep, 1200
	SendChat("/me оторвал копию протокола по линии разрыва")
	Sleep, 1200
	SendChat("/do Копия протокола оторвана.")
	Sleep, 1200
	SendChat("/me передал копию протокола")
	Sleep, 1200
	SendChat("/takelic " ID " " RegExReplace(articles2[line_num], "\s+\(.*\)"))
	Sleep, 1200
	SendChat("Если вы не согласны с лишением водительского удостоверения...")
	Sleep, 1200
	SendChat("то пишите жалобу на оф.портал, приложив копию данного протокола.")
}
	else if (line_num == 4)
	{
	showDialog(1, "Выписать штраф", "{FFFFFF}Введите ID игрока", "X")
	Input, ID, V I M, {enter}
	Sleep, 700
	showDialog(1, "Выписать штраф", "{FFFFFF}Введите сумму штрафа", "X")
	Input, srok, V I M, {enter}
	Sleep, 700
	showDialog(1, "Выписать штраф", "{FFFFFF}Введите причину штрафа", "X")
	Input, prich, V I M, {enter}
	Sleep, 700
	SendChat("/me достал протокол и ручку")
	Sleep, 1200
	SendChat("/do Протокол и ручка в руках.")
	Sleep, 1200
	SendChat("/me начал заполнять протокол")
	Sleep, 1200
	SendChat("/do Процесс...")
	Sleep, 1200
	SendChat("/me написал персональный номер водителя")
	Sleep, 1200
	SendChat("/do В графе «Персональный номер водителя» написано: " ID ".")
	Sleep, 1200
	SendChat("/me написал причину штрафа")
	Sleep, 1200
	SendChat("/do В графе «Причина» написано: " prich ".")
	Sleep, 1200
	SendChat("/me написал сумму штрафа")
	Sleep, 1200
	SendChat("/do В графе «Сумма штрафа» написано: " srok " рублей.")
	Sleep, 1200
	SendChat("/me написал дату выдачи штрафа")
	Sleep, 1200
	SendChat("/do В графе «Дата» написано: " A_DD "." A_MM ".2020.")
	Sleep, 1200
	SendChat("/me написал время выдачи штрафа")
	Sleep, 1200
	SendChat("/do В графе «Время» написано: " A_Hour ":" A_Min ".")
	Sleep, 1200
	SendChat("/do Протокол заполнен.")
	Sleep, 1200
	SendChat("/me оторвал копию протокола по линии разрыва")
	Sleep, 1200
	SendChat("/do Копия протокола оторвана.")
	Sleep, 1200
	SendChat("/me передал копию протокола")
	Sleep, 1200
	SendChat("С данной копией протокола пройдите в банк для оплаты штрафа.")
	Sleep, 1200
	SendChat("/ticket " ID " " srok " " prich)
	}
return

~ESC::
~F6::
menu := 0
return

~UP::
if (line_num > 1)
	line_num--
return

~DOWN::
if (line_num < line_max)
	line_num++
return


GetText(name, min := 1, max := 45, button := 0)
{
	text:=""
	for key, val in name
    {
        if (A_Index >= min && A_Index <= max)
            text .= val "`n"
		temp_A_Index := A_Index
    }
    text := Trim(text, "`n")
    if  (button)
    {
        if (min > 45)
            text .= " `nНазад"
        if (temp_A_Index > max)
            text .= "`nВперед"
    }
    text := Trim(text, "`n")
	return [text, min, max, temp_A_Index]
}
