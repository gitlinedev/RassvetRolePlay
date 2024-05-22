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
		SCM(player_id, COLOR_HINT, !"[CEF-client] {FFFFFF}��������� ������ ��������. ��������� �������..");
		SendAdminsMessagef(COLOR_GREEN, "CEF: � ������ %s[%d] �������� ������ [code: 0], ��������� ������� (/reload ��� ������������� ������)", getName(player_id), player_id);
		cef_load_url(player_id, CEF_INTERFACE_BROWSER_ID, "http://wh16200.web3.maze-host.ru/cef/index.html");
	}
	else if(status_code == 404)
	{
		SCM(player_id, COLOR_HINT, !"[CEF-client] {FFFFFF}� ���������, �������� �������� ��� �������� � ������ ������ ������ 404.");
		SendAdminsMessagef(COLOR_GREEN, "CEF: � ������ %s[%d] �������� ������ [code: 404], �������� �������� � Web-��������.", getName(player_id), player_id);
	}
	else if(status_code == 200)
	{
		SCM(player_id, COLOR_HINT, !"[CEF-client] {FFFFFF}�������� ������ �������! ���� ���������� �� ���������, �������������� �������� /reload.");
		SendAdminsMessagef(COLOR_GREEN, "CEF: ������ %s[%d] ������� ����������� � Web-�������.", getName(player_id), player_id);
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
	else SCM(player_id, COLOR_HINT, "[CEF-client] {FFFFFF}�������� ������� ��������� {FFFF33}��������� (OCI)");
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