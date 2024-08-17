#define MAIN_CEF 		1
#define DIALOG_CEF 		2

callback: OnCefBrowserCreated(player_id, browser_id, status_code)
{
	if(status_code == 0)
	{
		SCM(player_id, COLOR_HINT, !"[CEF-client] {FFFFFF}Произошла ошибка загрузки. Повторная попытка..");
		SendAdminsMessagef(COLOR_GREEN, "CEF: У игрока %s[%d] возникла ошибка [code: 0], возможное решение (/reload или переустановка сборки)", getName(player_id), player_id);
		cef_load_url(player_id, MAIN_CEF, "https://cdn.rassvet-rp.fun/Interface/MainHud/index.html");
		cef_load_url(player_id, DIALOG_CEF, "https://cdn.rassvet-rp.fun/Interface/Dialogs/dialog.html");
	}
	else if(status_code == 404)
	{
		SCM(player_id, COLOR_HINT, !"[CEF-client] {FFFFFF}К сожалению, возникла проблема при загрузке – сервер вернул ошибку 404.");
		SendAdminsMessagef(COLOR_GREEN, "CEF: У игрока %s[%d] возникла ошибка [code: 404], возможно проблема с Web-сервером.", getName(player_id), player_id);
	}
	else if(status_code == 200)
	{
		//	SCM(player_id, COLOR_HINT, !"[CEF-client] {FFFFFF}Загрузка прошла успешно! Если интерфейсы не появились, воспользуйтесь командой /reload.");
		SendAdminsMessagef(COLOR_GREEN, "CEF: Игрок %s[%d] успешно подключился к Web-серверу.", getName(player_id), player_id);
		PI[player_id][LoadCefInformation] = SetTimerEx("CefLoad", 3200, false, "d", player_id);
	}
	return 1;
}
callback: OnCefInitialize(player_id, success)
{
	if(success == 1)
	{
		cef_create_browser(player_id, MAIN_CEF, "https://cdn.rassvet-rp.fun/Interface/MainHud/index.html", false, false);
		cef_create_browser(player_id, DIALOG_CEF, "https://cdn.rassvet-rp.fun/Interface/Dialogs/dialog.html", false, false);
		cef_always_listen_keys(player_id, DIALOG_CEF, true);
		cef_always_listen_keys(player_id, MAIN_CEF, true);
        return;
	}
	else SCM(player_id, COLOR_HINT, "[CEF-client] {FFFFFF}загрузка плагина произошла {FFFF33}неуспешно (OCI)");
	return;
}
callback: CefLoad(playerid) 
{
	KillTimer(PI[playerid][LoadCefInformation]);
	CheckGangWar(playerid);
}
CMD:reload(playerid) 
{
	cef_load_url(playerid, DIALOG_CEF, "https://cdn.rassvet-rp.fun/Interface/Dialogs/dialog.html");
	cef_load_url(playerid, MAIN_CEF, "https://cdn.rassvet-rp.fun/Interface/MainHud/index.html");
	return 1;
}
stock SendPlayerOfferNotify(playerid, type, message[], button1[], button2[], time) 
{
	cef_emit_event(playerid, "cef:send:notification:offer", CEFINT(type), CEFSTR(message), CEFSTR(button1), CEFSTR(button2), CEFINT(time));
	OfferTimer[playerid] = SetTimerEx("ClearOffer", time*1000, false, "d", playerid);
	return 1;
}
callback: ClearOffer(playerid)
{
	ClearRequest(playerid);
}
stock SendPlayerHudNotify(playerid, id, type[], message[], time) 
{
	cef_emit_event(playerid, "cef:send:notification:hud", CEFINT(id), CEFSTR(type), CEFSTR(message), CEFINT(time));
	return 1;
}
stock SendPlayerRadarNotify(playerid, id, type[], message[], description[], time) 
{
	cef_emit_event(playerid, "cef:send:notification:radar", CEFINT(id), CEFSTR(type), CEFSTR(message), CEFSTR(description), CEFINT(time));
	return 1;
}
stock SendPlayerWelcomeNotify(playerid, header[], message[], time) 
{
	cef_emit_event(playerid, "cef:send:notification:welcome", CEFSTR(header), CEFSTR(message), CEFINT(time));
	return 1;
}
stock SendPlayerHelpKeyNotify(playerid, id, key[], message[], time) 
{
	cef_emit_event(playerid, "cef:send:notification:helpKey", CEFINT(id), CEFSTR(key), CEFSTR(message), CEFINT(time));
	return 1;
}
stock SendPlayerCenterNotify(playerid, type, message[], time) 
{
	cef_emit_event(playerid, "cef:send:notification:center", CEFINT(type), CEFSTR(message), CEFINT(time));
	return 1;
}
stock ShowPlayerSpeedometer(playerid) 
{
	cef_emit_event(playerid, "cef:speed:active", CEFINT(1));
	SpeedometerUpdate[playerid] = SetTimerEx("UpdateSpeedometer", 100, true, "d", playerid);
	return 1;
}
stock HidePlayerSpeedometer(playerid) 
{
	cef_emit_event(playerid, "cef:speed:active", CEFINT(0));
    KillTimer(SpeedometerUpdate[playerid]);
    return 1;
}
callback: UpdateSpeedometer(playerid) 
{
	new vehicleid = GetPlayerVehicleID(playerid);
	
	if(CarInfo[vehicleid][cEngineStatus] == 1) cef_emit_event(playerid, "cef:speed:icon", CEFINT(1), CEFINT(1));
	else cef_emit_event(playerid, "cef:speed:icon", CEFINT(1), CEFINT(0));
	
	if(CarInfo[vehicleid][cLamp] == 1) cef_emit_event(playerid, "cef:speed:icon", CEFINT(2), CEFINT(1));
	else cef_emit_event(playerid, "cef:speed:icon", CEFINT(2), CEFINT(0));
	
	if(CarInfo[vehicleid][cLock] == 1) cef_emit_event(playerid, "cef:speed:icon", CEFINT(3), CEFINT(1));
	else cef_emit_event(playerid, "cef:speed:icon", CEFINT(3), CEFINT(0));
	
	if(CarInfo[vehicleid][cID] != 0)
	{
		if(CarInfo[vehicleid][cKey] == 0) cef_emit_event(playerid, "cef:speed:icon", CEFINT(4), CEFINT(0));
		else cef_emit_event(playerid, "cef:speed:icon", CEFINT(4), CEFINT(1));
	}

	new Float:health;
	GetVehicleHealth(vehicleid, health);
	cef_emit_event(playerid, "cef:speed:health", CEFFLOAT(health));
	
	cef_emit_event(playerid, "cef:speed:fuel", CEFINT(CarInfo[vehicleid][cFuel]));
}

forward CallbackDialogResponse(playerid, const arguments[]);
public CallbackDialogResponse(playerid, const arguments[]) 
{
	new dId, responsed, list, input[64];
	sscanf(arguments, "P< >ddds[64]", dId, responsed, list, input);

	OnDialogResponse(playerid, dId, responsed, list, input);
	return 1;
}

stock CEF_ShowPlayerDialog(playerid, dialogId, dialogType, dHeader[], dText[], button_1[], button_2[]) 
{
 	cef_emit_event(playerid, "cefstudio:dialog", CEFINT(dialogId), CEFINT(dialogType), CEFSTR(dHeader), CEFSTR(dText), CEFSTR(button_1), CEFSTR(button_2));
 	return 1;
}
stock CEF_ShowPlayerDialogNew(playerid, dialogId, dHeader[], dText[], dInfo[], button_1[], button_2[]) 
{
 	cef_emit_event(playerid, "cefstudio:dialog:new", CEFINT(dialogId), CEFSTR(dHeader), CEFSTR(dText), CEFSTR(dInfo), CEFSTR(button_1), CEFSTR(button_2));
 	return 1;
}
stock Dialog(playerid, dialogid, style, caption[], info[], button1[], button2[]) 
{
	if(style == DIALOG_STYLE_LIST ||
	style == DIALOG_STYLE_INPUT ||
	style == DIALOG_STYLE_PASSWORD ||
	style == DIALOG_STYLE_MSGBOX ||
	style == DIALOG_STYLE_TABLIST_HEADERS) return CEF_ShowPlayerDialog(playerid, dialogid, style, caption, info, button1, button2);
	else return ShowPlayerDialog(playerid, dialogid, style, caption, info, button1, button2);
}