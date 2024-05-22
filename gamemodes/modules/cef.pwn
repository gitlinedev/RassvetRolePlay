forward CallbackDialogResponse(playerid, const arguments[]);
public CallbackDialogResponse(playerid, const arguments[]) 
{
	new dId, responsed, list, input[64];
	sscanf(arguments, "P< >ddds[64]", dId, responsed, list, input);
	OnDialogResponse(playerid, dId, responsed, list, input);
	return 1;
}

stock CEF__Dialog(playerid, dialogId, dialogType, dHeader[], dText[], button_1[], button_2[]) 
{
 	cef_emit_event(playerid, "show_dialog", CEFINT(dialogId), CEFINT(dialogType), CEFSTR(dHeader), CEFSTR(dText), CEFSTR(button_1), CEFSTR(button_2));
 	return 1;
}
callback: OnCefBrowserCreated(player_id, browser_id, status_code)
{
	if(status_code == 0)
	{
		SCM(player_id, COLOR_HINT, !"[CEF-client] {FFFFFF}Произошла ошибка загрузки. Повторная попытка..");
		SendAdminsMessagef(COLOR_GREEN, "CEF: У игрока %s[%d] возникла ошибка [code: 0], возможное решение (/reload или переустановка сборки)", getName(player_id), player_id);
		cef_load_url(player_id, CEF_INTERFACE_BROWSER_ID, "http://wh16200.web3.maze-host.ru/cef/index.html");
	}
	else if(status_code == 404)
	{
		SCM(player_id, COLOR_HINT, !"[CEF-client] {FFFFFF}К сожалению, возникла проблема при загрузке – сервер вернул ошибку 404.");
		SendAdminsMessagef(COLOR_GREEN, "CEF: У игрока %s[%d] возникла ошибка [code: 404], возможно проблема с Web-сервером.", getName(player_id), player_id);
	}
	else if(status_code == 200)
	{
		SCM(player_id, COLOR_HINT, !"[CEF-client] {FFFFFF}Загрузка прошла успешно! Если интерфейсы не появились, воспользуйтесь командой /reload.");
		SendAdminsMessagef(COLOR_GREEN, "CEF: Игрока %s[%d] успешно подключился к Web-серверу.", getName(player_id), player_id);
		PI[player_id][LoadCefInformation] = SetTimerEx("CefLoad", 3200, false, "d", player_id);
	}
	return 1;
}
callback: OnCefInitialize(player_id, success)
{
	if(success == 1)
	{
		cef_create_browser(player_id, 1, "http://wh16200.web3.maze-host.ru/cef/index.html", false, false);
		cef_always_listen_keys(player_id, 1, true);
        return;
	}
	else SCM(player_id, COLOR_HINT, "[CEF-client] {FFFFFF}загрузка плагина произошла {FFFF33}неуспешно (OCI)");
	return;
}
CMD:reload(playerid) 
{
	cef_load_url(playerid, CEF_INTERFACE_BROWSER_ID, "http://wh16200.web3.maze-host.ru/cef/index.html");
	return 1;
}
stock ReloadCef(playerid) 
{
	CheckGangWar(playerid);
	cef_emit_event(playerid, "update-player-info", CEFINT(19), CEFINT(playerid), CEFINT(PI[playerid][data_ID]));
}