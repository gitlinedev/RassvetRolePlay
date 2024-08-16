static const stock AdminName[9][6] = {
	"�����",
 	"NGM",
 	"JRGM",
 	"GM",
 	"GM+",
 	"LGM",
 	"SGM",
 	"SGM+",
 	"DEV"
};
static const stock ModerName[4][17] = {
	"�����",
 	"Junior Moderator",
 	"Moderator",
 	"Senior Moderator"
};

static const stock VehicleNames[][] = {
	"BMW X5","Audi A6 C8","Mersedec Akula","Lexus GX460","BMW M5 F90 2021","Mercedes-Benz E63","�����-���","����� ��������","Audi A6 2019","Mercedes GL63","Audi R8","Lada Kalina",
	"Lexus GSF","Nissan Titan 2017","BMW M5","Porsche 911","Ambulance","������ ������","Volkswagen Multivan","��� 2107","Nissan GTR","Washington","Infiniti JX 35 2013","Mr Whoopee","BF Injection",
	"Hunter","Audi A6","������","���������","���-�22","Predator","����-677�","Rhino","��� 131","Hotknife","Trailer","Toyota MarkII","Ikarus 260","���-2402",
	"��-412","Rumpo","RC Bandit","Romero","Packer","Monster","���-45","Squalo","Seasparrow","Pizzaboy","Tram","Trailer","Turismo","Speeder",
	"Reefer","Tropic","Flatbed","���-3309","Caddy","Audi A6","Berkley's RC Van","Skimmer","PCJ-600","Faggio","Freeway","RC Baron","RC Raider",
	"BMW 535i","Mercedes GLE","Sanchez","Sparrow","Patriot","Audi A7","Coastguard","Dinghy","���-21�","Toyota Land Cruiser","Rustler","ZR3 50","��-27151","���-2114",
	"Toyota Supra","���������","Burrito","���-3205","Marquis","��� 2402","Dozer","Maverick","News Chopper","Chevrolet Niva","FBI Rancher","Virgo","��� 2109",
	"Jetmax","Hotring","Sandking","���-1102","Police Maverick","Boxville","���-53","���-69","RC Goblin","Hotring A","Mersedes Benz E200",
	"Bloodring Banger","Rancher","Super GT","���-2401"," ���-452","�����","������ �����","Beagle","Cropdust","Stunt","�����-54115","���-608�",
	"���-21099","���-2203"," ����-672","Shamal","Hydra","�� ������� 5","NRG-500","����","Cement Truck","���������","Fortune","Cadrona","FBI Truck",
	"Willard","Forklift","Tractor","Combine","Feltzer","Remington","Slamvan","Blade","Freight","Streak","Vortex","�5 F90","Bugatti Chiron","��� 2424",
	"�������-434","Firetruck","�������-400","�������-2125","�������-2140","Cargobob","���-968�","Sunrise","��� 31105","Utility","Nevada","���-3303","���-968�","Monster A",
	"Monster B","Lamborghini Huracan Devo","Acura NSX GT3","Orange Porshe","�� �������-427","Elegy","Raindance","RC Tiger","��� 2108","��� 2104","Savanna","Bandito","Freight","Trailer",
	"Kart","Mower","Duneride","Sweeper","���-�20","�������-408","AT-400","���-157","Mersedes G65","BMW X5M","BF-400","Newsvan","Tug","Trailer A","Emperor",
	"������ 3�","Euros","����-677","Club","Trailer B","Trailer C","Andromada","Dodo","RC Cam","Launch","���-2401","��� 21099",
	"��� 2114","��� 469","��-2717","S.W.A.T.","Alpha","Phoenix","Glendale","Sadler","L Trailer A","L Trailer B",
	"Stair Trailer","���-699�","Farm Plow","U Trailer"
};
static const stock Fraction_Name[MAX_FRACTIONS][32] = {
	"�����������",
	"�������������",
 	"��������� �����",
 	"�������",
 	"����",
 	"��������",
 	"������",
 	"��������"
};
//================================ [CMD] =============================//
CMD:setsex(playerid, params[])
{
    if(CheckAccess(playerid, 7)) return 1;
	if(sscanf(params, "u", params[0])) return SCM(playerid, COLOR_LIGHTGREY, !"�����������: /setsex [ID ������]");
	switch(PI[params[0]][pSex])
	{
		case 1:
		{
			SCMf(playerid, COLOR_GREY, "�� �������� ��� ������ %s �� �������", getName(params[0]));
			SCMf(params[0], -1, "������� ������ ������� ��� ��� �� �������", PI[playerid][pAdminNumber]);
			PI[params[0]][pSex] = 2;
		}
		case 2:
		{
			SCMf(playerid, COLOR_GREY, "�� �������� ��� ������ %s �� �������",getName(params[0]));
			SCMf(params[0], -1, "������� ������ ������� ��� ��� �� �������", PI[playerid][pAdminNumber]);
			PI[params[0]][pSex] = 1;
		}
	}
	return 1;
}
cmd:rasform(playerid) 
{
    if(CheckAccess(playerid, 7)) return 1;
	rasform[playerid]++;
	if(rasform[playerid] != 2) return SCM(playerid, COLOR_GREY, !"���� �� �������� ��� ��� ������ ������� ��� ���������� ����� ��������������");
	rasform[playerid] = 0;
    for(new i = 0; i < totalgz; i++) 
	{
		gz_info[i][gzopg] = gz_info[i][standart_opg];
		SaveGZ(gz_info[i][standart_opg], i);
		foreach(new pl:Player) 
		{
			if(PI[pl][pMember] == 5 || PI[pl][pMember] == 6 || PI[pl][pMember] == 7) 
			{
				GangZoneHideForPlayer(pl, i);
				GangZoneShowForPlayer(pl, i, GetGZFrac(i));
			}
		}
    }
    return ShowPlayerDialog(playerid, 0, DIALOG_STYLE_MSGBOX, !"{ee3366}������� ����������", "�� ������� ���������� ��� ���������� ���!", "�������", "");
}
CMD:admins(playerid)
{
 	if(CheckAccess(playerid, 1)) return 0;

	SCMf(playerid, COLOR_BLUE, "������� ������� ������ (� ����: %d, �� ��� � ���: NaN)", Iter_Count(Admin));

	new str_1[512];

	foreach(Admin, i)
	{
		if !PI[i][pAdmin] *then continue;

		if(GetPVarInt(i, "FlyMode") != 0) format(str_1, sizeof(str_1), "%s[%d] - %s - /re %d- [AFK: %d]. �������� [%d/3]", getName(i), i, AdminName[PI[i][pAdmin]], GetPVarInt(i,"specid"), PI[i][pAFK], PI[i][pAdminWarn]);
		else format(str_1, sizeof(str_1), "%s[%d] - %s - [AFK: %d]. �������� [%d/3]", getName(i), i, AdminName[PI[i][pAdmin]], PI[i][pAFK], PI[i][pAdminWarn]);
		SCM(playerid, COLOR_JOBYELLOW, str_1);

	}
	return 1;
}
CMD:unwarn(playerid,params[]) 
{
    if(CheckAccess(playerid, 3)) return 1;
	if(sscanf(params,"u",params[0])) return SCM(playerid, COLOR_LIGHTGREY, !"�����������: /uwarn [ID ������]");
    if(!IsPlayerConnected(params[0])) return SCM(playerid, COLOR_GREY, !"����� �� � ����");
	if(!IsPlayerLogged{params[0]}) return SCM(playerid, COLOR_GREY, !"����� �� �����������");
	if(PI[params[0]][pWarn] == 0) return SCM(playerid, COLOR_GREY, !"� ������ ��� ��������������");
 	PI[params[0]][pWarn] = 0;
	PI[params[0]][pWarnTime] = 0;
	SendClientMessagef(params[0], COLOR_TOMATO, "������� ������ ���� ��� ������� ��������������", PI[playerid][pAdminNumber]);
	SendAdminsMessagef(COLOR_ADMINCHAT, "[%s #%d] %s[%d] ���� ������� �������������� ������ %s[%d]", AdminName[PI[playerid][pAdmin]], PI[playerid][pAdminNumber], getName(playerid), playerid, getName(params[0]), params[0]);
	return 1;
}
CMD:spawn(playerid,params[],text) 
{
    if(CheckAccess(playerid, 1, 1)) return 1;
    if(sscanf(params,"u",params[0])) return SCM(playerid, COLOR_LIGHTGREY, !"�����������: /spawn [ID ������]");
    if(!IsPlayerConnected(params[0]))return  SCM(playerid, COLOR_GREY, !"����� �� � ����");
	if(!IsPlayerLogged{params[0]})return  SCM(playerid, COLOR_GREY, !"����� �� �����������");

	PlayerSpawn(params[0]);

	SCMf(params[0], -1, "������� ������ ��������� ���", PI[playerid][pAdminNumber]);

	new senderName[MAX_PLAYER_NAME + 20];
	if(PI[playerid][pAdmin]) format(senderName, sizeof(senderName), "%s #%d", AdminName[PI[playerid][pAdmin]], PI[playerid][pAdminNumber]);
	else format(senderName, sizeof(senderName), "%s", ModerName[PI[playerid][pModer]]);

 	SendAdminsMessagef(COLOR_ADMINCHAT, "[%s] %s[%d] ��������� ������ %s[%d]", senderName, getName(playerid), playerid, getName(params[0]), params[0]);
    return 1;
}
CMD:ban(playerid,params[]) 
{
    if(CheckAccess(playerid, 5)) return 1;
	if(sscanf(params,"uds[32]",params[0],params[1],params[2])) return SCM(playerid, COLOR_LIGHTGREY, !"�����������: /ban [ID ������] [���-�� ����] [�������]");
    if(!IsPlayerConnected(params[0]))return  SCM(playerid, COLOR_GREY, !"����� �� � ����");
	if(!IsPlayerLogged{params[0]})return  SCM(playerid, COLOR_GREY, !"����� �� �������������");
	if(params[1] < 1 || params[1] > 3000) return SCM(playerid, COLOR_GREY, !"����������� �� 1 �� 3000 ����.");
    if(playerid == params[0]) return SCM(playerid, COLOR_GREY, !"�� �� ������ �������� ���� ����.");


	if(PI[params[0]][pOnCapture] == 1)
	{
		AutoKickCapture(params[0]);
		CheckCount(params[0]);
	}
	PI[params[0]][pMember] = 0;
	PI[params[0]][pLeader] = 0;
	PI[params[0]][pRang] = 0;
	PI[params[0]][pAdmin] = 0;

    mysql_tqueryf(mysql, "INSERT INTO `banlist` ( `name`,`admin`, `day`, `text`, `ip`) VALUES ( '%e', '%e', '%d', '%e', '%e')",getName(params[0]),getName(playerid),params[1],params[2],PI[params[0]][pLoginIP]);

	SendAdminsMessagef(COLOR_TOMATO, "[%s #%d] %s ������������ %s �� %d ����. �������: %s", AdminName[PI[playerid][pAdmin]], PI[playerid][pAdminNumber], getName(playerid),getName(params[0]),params[1],params[2]);
	SendClientMessagef(params[0], COLOR_TOMATO, "������� ������ ������������ ��� ������� �� %d ����. �������: %s", PI[playerid][pAdminNumber],params[1], params[2]);

	CreatePunishment(playerid, params[0], 1, params[2]);

	new year, mounth, day, hour, minute, second, id;
	getdate(year, mounth, day);
	gettime(hour, minute, second);

	ShowPlayerDialogf(params[0], 0, DIALOG_STYLE_MSGBOX, !"{ee3366}���������� ��������� ��������", !"�����", !"", "\
	{FFFFFF}�������: {396cac}%s\n\
	{FFFFFF}ID ��������: {396cac}%s\n\
	{FFFFFF}���� � �����: {FFFFFF}%02d.%02d.%04d %02d:%02d:%02d\n\
	{FFFFFF}���������� ����: {FFFFFF}%d ��\n\
	{FFFFFF}�������: {FFFFFF}%s\n\
	{d6d886}�������� ������� �������� (������� F8), ����� �����\n\
	{d6d886}����������� ���������� ��� �� ������", getName(params[0]), id, day, mounth, year, hour, minute, second,params[1],params[2]);

	SCM(params[0], COLOR_BLACK, !"��� ������� ������������, ��� ������ ������� /q");
	TogglePlayerSpectating(params[0], true);

	return Kick(params[0]);
}
CMD:spawncar(playerid) 
{
    if(CheckAccess(playerid, 3)) return 1;
	new carid = GetPlayerVehicleID(playerid);
	if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER) return SCM(playerid, COLOR_GREY, !"����� ���������� �� ����� ����������");
	SetVehicleToRespawn(carid);
	return SCM(playerid, COLOR_GREY, !"���������� ��� ���������");
}
CMD:setfuel(playerid,params[]) 
{
    if(CheckAccess(playerid, 3)) return 1;
    if(sscanf(params,"d",params[0])) return SCM(playerid, COLOR_LIGHTGREY, !"�����������: /setfuel [���-��]");
    if(IsPlayerInAnyVehicle(playerid) && GetPlayerState(playerid) == PLAYER_STATE_DRIVER) 
	{
		new carid = GetPlayerVehicleID(playerid);
		CarInfo[carid][cFuel] = params[0];
		SCM(playerid, -1, !"������� ������� � ���������� �������");
	}
	else SCM(playerid, COLOR_GREY, !"����� ���������� �� ������������ �����");
	return 1;
}
CMD:skin(playerid,params[]) 
{
    if(CheckAccess(playerid)) return 1;
	if(sscanf(params,"ud",params[0], params[1])) return SCM(playerid, COLOR_LIGHTGREY, !"�����������: /skin [ID ������] [����� �����]");
	if(!IsPlayerConnected(params[0]))return  SCM(playerid, COLOR_GREY, !"����� �� � ����");
	if(!IsPlayerLogged{params[0]})return  SCM(playerid, COLOR_GREY, !"����� �� �����������");
	if(params[1] > 2000) return 1;
	SetPlayerSkinAC(params[0],params[1]);
    SendAdminsMessagef(COLOR_ADMINCHAT, "[%s #%d] %s[%d] ����� ��������� ���� ������ %s[%d] (ID %d)", AdminName[PI[playerid][pAdmin]], PI[playerid][pAdminNumber], getName(playerid), playerid, getName(params[0]), params[0], params[1]);
    SCMf(params[0], -1, "������� ������ ����� ��� ��������� ����.", PI[playerid][pAdminNumber]);
    return 1;
}
CMD:gethere(playerid,params[]) 
{
    if(CheckAccess(playerid, 2, 1)) return 1;
    if(sscanf(params, "u",params[0])) return SCM(playerid, COLOR_LIGHTGREY, !"�����������: /gethere [ID ������]");
    if(!IsPlayerConnected(params[0])) return SCM(playerid, COLOR_GREY, !"����� �� � ����");
    if(params[0] == playerid) return SCM(playerid, COLOR_GREY, !"�� �� ������ ��������������� ����");
	if(!IsPlayerLogged{params[0]})return  SCM(playerid, COLOR_GREY, !"����� �� �����������");
    new Float:x, Float:y, Float:z;
    DeletePVar(params[0], "ac_fly");
    GetPlayerPos(playerid,x,y,z);
    SetPlayerPosAC(params[0],x+1,y,z+1.0);
    SetPlayerInterior(params[0],GetPlayerInterior(playerid));
    SetPlayerVirtualWorld(params[0],GetPlayerVirtualWorld(playerid));
	HidePlayerSpeedometer(params[0]);
    SendAdminsMessagef(COLOR_ADMINCHAT, "[%s #%d] %s[%d] �������������� � ���� %s[%d]", AdminName[PI[playerid][pAdmin]], PI[playerid][pAdminNumber], getName(playerid),playerid, getName(params[0]), params[0]);
    SCM(params[0], COLOR_GREY, !"�� ���� ��������������� ������� ��������");
    return 1;
}
alias:goto("g");
CMD:goto(playerid, params[]) 
{
    if(CheckAccess(playerid, 1, 1)) return 1;
    if(sscanf(params, "u",params[0])) return SCM(playerid, COLOR_LIGHTGREY, !"�����������: /goto [ID ������]");
    if(!IsPlayerConnected(params[0]))return  SCM(playerid, COLOR_GREY, !"����� �� � ����");
	if(!IsPlayerLogged{params[0]})return  SCM(playerid, COLOR_GREY, !"����� �� �����������");
	if(GetPVarInt(params[0], "SpecBool") == 1) return SCM(playerid, COLOR_GREY, !"�����/������� ������ ��������� � ������ ����������");
    new Float:x, Float:y, Float:z;
    GetPlayerPos(params[0],x,y,z);
    SetPlayerPosAC(playerid,x+1,y,z);
    SetPlayerInterior(playerid,GetPlayerInterior(params[0]));
    SetPlayerVirtualWorld(playerid,GetPlayerVirtualWorld(params[0]));

	new senderName[MAX_PLAYER_NAME + 20];
	if(PI[playerid][pAdmin]) format(senderName, sizeof(senderName), "%s #%d", AdminName[PI[playerid][pAdmin]], PI[playerid][pAdminNumber]);
	else format(senderName, sizeof(senderName), "%s", ModerName[PI[playerid][pModer]]);

    SendAdminsMessagef(COLOR_ADMINCHAT, "[%s] %s[%d] ���������������� � ������ %s[%d]", senderName, PI[playerid][pName], playerid, getName(params[0]), params[0]);
    return 1;
}
CMD:veh(playerid,params[]) 
{
    if(CheckAccess(playerid)) return 1;
    if(sscanf(params, "ddd",params[0],params[1],params[2])) return SCM(playerid, COLOR_LIGHTGREY, !"�����������: /veh [ID ������] [����] [����]");
    if(params[0] < 400 || params[0] > 611 && params[0]) return SCM(playerid, COLOR_GREY, !"����� ������������� �������� �� ����� ���� ���� 400 ��� ���� 611 !");
    new Float:pos[3]; GetPlayerPos(playerid,pos[0],pos[1],pos[2]);
    new vehc = CreateVehicle(params[0],pos[0],pos[1],pos[2],0,params[1],params[2],-1);
    SetVehicleVirtualWorld(vehc, GetPlayerVirtualWorld(playerid));
	PutPlayerInVehicle(playerid, vehc, 0);
    ClearCarData(vehc);
    CarInfo[vehc][cFuel] = 50;
    CarInfo[vehc][cCreate] = 1;
	new vehicadm = GetVehicleModel(vehc);
	SetVehicleNumberPlate(vehc, "ADMIN");
    SendAdminsMessagef(COLOR_ADMINCHAT, "[%s #%d] %s[%d] ������ %s[%d] (id: %d, ����: %d, %d)", AdminName[PI[playerid][pAdmin]], PI[playerid][pAdminNumber], PI[playerid][pName],playerid, VehicleNames[vehicadm-400], vehc, params[0], params[1], params[2]);
	return 1;
}
CMD:dveh(playerid) 
{
    if(CheckAccess(playerid, 3)) return 1;
    if(!IsPlayerInAnyVehicle(playerid)) return SCM(playerid, COLOR_GREY, !"����� ���������� � ����������");
    new carid = GetPlayerVehicleID(playerid);
	if(CarInfo[carid][cCreate] == 0) return SCM(playerid, COLOR_GREY, !"������ ��������� ������ �������");
    CarInfo[carid][cCreate] = 0;
	DestroyVehicle(carid);
	HidePlayerSpeedometer(playerid);
    return 1;
}
CMD:unmute(playerid,params[]) 
{
    if(CheckAccess(playerid, 2, 2)) return 1;
	if(sscanf(params,"u",params[0])) return SCM(playerid, COLOR_LIGHTGREY, !"�����������: /unmute [ID ������]");
	if(!IsPlayerConnected(params[0]))return  SCM(playerid, COLOR_GREY, !"����� �� � ����");
	if(!IsPlayerLogged{params[0]})return SCM(playerid, COLOR_GREY, !"����� �� �����������");
	if(PI[params[0]][pMute] == 0) return SCM(playerid, COLOR_GREY, !"� ������� ������ ��� ���������� ����");
	PI[params[0]][pMute] = 0;
	SendAdminsMessagef(COLOR_ADMINCHAT, "[%s #%d] %s[%d] ���� ���������� ���� ������ %s[%d]", AdminName[PI[playerid][pAdmin]], PI[playerid][pAdminNumber], getName(playerid),playerid,getName(params[0]),params[0]);
	SendClientMessagef(params[0], COLOR_TOMATO, "������� ������ ���� ��� ���������� ����", PI[playerid][pAdminNumber]);
	return 1;
}
CMD:setarm(playerid,params[]) 
{
    if(CheckAccess(playerid)) return 1;
	if(sscanf(params, "ud", params[0],params[1])) return SCM(playerid, COLOR_LIGHTGREY, !"�����������: /setarm [ID ������] [���-��]");
	if(!IsPlayerConnected(params[0]))return  SCM(playerid, COLOR_GREY, !"����� �� � ����");
	if(!IsPlayerLogged{params[0]}) return SCM(playerid, COLOR_GREY, !"����� �� �����������");
	cef_emit_event(params[0], "show-center-notify", CEFINT(5), CEFSTR("������� ������ ������� ��� �����"));
	SendAdminsMessagef(COLOR_ADMINCHAT, "[%s #%d] %s[%d] ������� ������� ����� ������ %s[%d] �� %d.0", AdminName[PI[playerid][pAdmin]], PI[playerid][pAdminNumber], getName(playerid), playerid, getName(params[0]), params[0], params[1]);
	SCMf(params[0], -1, "������� ������ ����� ��� ����������", PI[playerid][pAdminNumber]);
	SetPlayerArmourAC(params[0], params[1]);
	return 1;
}
CMD:vmute(playerid,params[]) 
{
    if(CheckAccess(playerid, 2, 2)) return 1;
	if(sscanf(params,"uds[32]",params[0],params[1],params[2])) return SCM(playerid, COLOR_LIGHTGREY, !"�����������: /vmute [ID ������] [�����] [�������]");
	if(!IsPlayerConnected(params[0]))return  SCM(playerid, COLOR_GREY, !"����� �� � ����");
	if(!IsPlayerLogged{params[0]})return  SCM(playerid, COLOR_GREY, !"����� �� �����������");

	if(params[1] > 300) return SCM(playerid, COLOR_LIGHTGREY, !"������ ������ ���������� ���� ������ ��� �� 300 �����");
	if(params[1] < 1) return SCM(playerid, COLOR_LIGHTGREY, !"������ ������ ���������� ���� ������ ��� �� 1 ������");

    if(PI[params[0]][pAdmin] > PI[playerid][pAdmin]) return SCM(playerid, COLOR_GREY, !"������ ��������� � �������� �������");

	PI[params[0]][pVmute] = 1;
	PI[params[0]][pVmuteTime] = params[1]*60;

	SendPlayerHudNotify(params[0], 20, "mute", "���������� ���������� ����", PI[params[0]][pVmuteTime]);

	SendAdminsMessagef(COLOR_ADMINCHAT, "[%s #%d] %s[%d] ������������ ������ %s[%d] ��������� ��� �� %d �����. �������: %s", AdminName[PI[playerid][pAdmin]], PI[playerid][pAdminNumber], getName(playerid),playerid,getName(params[0]),params[0],params[1],params[2]);
	SendClientMessagef(params[0], COLOR_TOMATO, "������� ������ ������������ ��� ��������� ��� �� %d �����. �������: %s", PI[playerid][pAdminNumber], params[1], params[2]);
	SvMutePlayerEnable(params[0]);
	return 1;
}
CMD:unvmute(playerid,params[]) 
{
    if(CheckAccess(playerid, 2)) return 1;
	if(sscanf(params,"u",params[0])) return SCM(playerid, COLOR_LIGHTGREY, !"�����������: /unvmute [ID ������]");
	if(!IsPlayerConnected(params[0]))return  SCM(playerid, COLOR_GREY, !"����� �� � ����");
	if(!IsPlayerLogged{params[0]})return SCM(playerid, COLOR_GREY, !"����� �� �����������");
	if(PI[params[0]][pVmute] == 0) return SCM(playerid, COLOR_GREY, !"� ������� ������ ��� ���������� ����");
	
	PI[params[0]][pVmute] = 0;
	PI[params[0]][pVmuteTime] = 0;

	cef_emit_event(params[0], "cef:remove:notification:hud", CEFINT(20));

	SendAdminsMessagef(COLOR_ADMINCHAT, "[%s #%d] %s[%d] ���� ������ %s[%d] ���������� ���������� ����", AdminName[PI[playerid][pAdmin]], PI[playerid][pAdminNumber], getName(playerid),playerid,getName(params[0]),params[0]);
	SendClientMessagef(params[0], COLOR_TOMATO, "������� ������ ���� ��� ���������� ���������� ����", PI[playerid][pAdminNumber]);
	SvMutePlayerDisable(params[0]);
	return 1;
}
CMD:mute(playerid,params[]) 
{
    if(CheckAccess(playerid, 2, 2)) return 1;
	if(sscanf(params,"uds[32]",params[0],params[1],params[2])) return SCM(playerid, COLOR_LIGHTGREY, !"�����������: /mute [ID ������] [�����] [�������]");
	if(!IsPlayerConnected(params[0]))return  SCM(playerid, COLOR_GREY, !"����� �� � ����");
	if(!IsPlayerLogged{params[0]})return  SCM(playerid, COLOR_GREY, !"����� �� �����������");

	if(params[1] > 300) return SCM(playerid, COLOR_LIGHTGREY, !"������ ������ ���������� ���� ������ ��� �� 300 �����");
	if(params[1] < 1) return SCM(playerid, COLOR_LIGHTGREY, !"������ ������ ���������� ���� ������ ��� �� 1 ������");

	if(PI[params[0]][pAdmin] > PI[playerid][pAdmin]) return SCM(playerid, COLOR_GREY, !"������ ��������� � �������� �������");

	PI[params[0]][pMute] = 1;
	PI[params[0]][pMuteTime] = params[1]*60;

	SendPlayerHudNotify(params[0], 21, "mute", "���������� ���������� ����", PI[params[0]][pMuteTime]);

	new senderName[MAX_PLAYER_NAME + 20];
	if(PI[playerid][pAdmin]) format(senderName, sizeof(senderName), "%s #%d", AdminName[PI[playerid][pAdmin]], PI[playerid][pAdminNumber]);
	else format(senderName, sizeof(senderName), "%s", ModerName[PI[playerid][pModer]]);

    SendAdminsMessagef(COLOR_ADMINCHAT, "[%s] %s[%d] ������������ ��� ������ %s[%d] �� %d �����. �������: %s", senderName, getName(playerid),playerid,getName(params[0]),params[0],params[1],params[2]);
	SendClientMessagef(params[0], COLOR_TOMATO, "%s ������������ ��� ��� �� %d �����. �������: %s", PI[playerid][pAdmin] ? "������� ������" : "������� ���������", params[1], params[2]);
	return 1;
}
cmd:saveplayers(playerid) 
{
    if(CheckAccess(playerid, 8)) return 1;
    if(GetPVarInt(playerid, "saveplayers") > gettime()) return SCM(playerid, COLOR_GREY, !"������� ����� ������������ ��� � 1 ������");
	new players = 0;
	foreach(Player, i) 
	{
		if(!IsPlayerConnected(i)) continue;
		SavePlayerData(i);
		players++;
	}
	SetPVarInt(playerid,"saveplayers",gettime() + 59);
	SCMf(playerid, COLOR_YELLOW, "�� ��������� �������� �������. ��������� {ff2457}('%d'){FFFF00} �����", players);
	return 1;
}
CMD:msg(playerid,params[]) 
{
    if(CheckAccess(playerid)) return 1;
	if(sscanf(params,"s[144]",params[0])) return SCM(playerid, COLOR_LIGHTGREY, !"�����������: /msg [�����]");
	SendClientMessageToAllf(COLOR_BLACKRED, "������� ������: %s", params[0]);
    return 1;
}
CMD:a(playerid,params[]) 
{
    if(CheckAccess(playerid, 1, 1)) return 1;
	if(sscanf(params,"s[90]",params[0])) return SCM(playerid, COLOR_LIGHTGREY, !"�����������: /a [�����]");

	SendAdminsMessagef(0x99CC00FF, "%s %s[%d]: %s", PI[playerid][pAdmin] ? "[A]" : "[M]", PI[playerid][pName], playerid, params[0]);
    return 1;
}
CMD:kick(playerid,params[]) 
{
    if(CheckAccess(playerid, 2, 3)) return 1;
	if(sscanf(params,"us[32]",params[0],params[1])) return SCM(playerid, COLOR_LIGHTGREY, !"�����������: /kick [ID ������] [�������]");
	if(!IsPlayerConnected(params[0]))return  SCM(playerid, COLOR_GREY, !"����� �� � ����");
    if(playerid == params[0]) return SCM(playerid, COLOR_GREY, !"������ ������ ������ ����");
    if(PI[params[0]][pAdmin] > PI[playerid][pAdmin]) return SCM(playerid, COLOR_GREY, !"������ ��������� � �������� �������");

	new senderName[MAX_PLAYER_NAME + 20];
	if(PI[playerid][pAdmin]) format(senderName, sizeof(senderName), "%s #%d", AdminName[PI[playerid][pAdmin]], PI[playerid][pAdminNumber]);
	else format(senderName, sizeof(senderName), "%s", ModerName[PI[playerid][pModer]]);

	SendAdminsMessagef(COLOR_ADMINCHAT, "[%s] %s[%d] ������ ������ %s. �������: %s", senderName, PI[playerid][pName], playerid, PI[params[0]][pName], params[1]);
	SendClientMessagef(params[0], COLOR_TOMATO, "%s ������ ���. �������: %d", PI[playerid][pAdmin] ? "������� ������" : "������� ���������", params[1]);
	Kick(params[0]);
	return 1;
}
CMD:astorage(playerid)
{
	if(CheckAccess(playerid, 5)) return 1;
	ShowPlayerDialogf(playerid, 2390, DIALOG_STYLE_LIST, !"{ee3366}��������� ������ ��", !"�����", !"�������", "\
	1. ������ ������ ��: \t%s\n\
	2. ��������� ����� ��\n\
	3. �������� ����� ��\n\
	 \n\
	{FFFF99}���������� ������: \n\
	{FFFF99}������� %d ��\n\
	{FFFF99}������ %d ��", 
	ArmyStorage ? ("{66cc66}(������)") : ("{ff6633}(������)"), army_wh[1], army_wh[0]);
	return 1;
}
CMD:giveownable(playerid,params[]) 
{
    if(CheckAccess(playerid, 8)) return 1;
    if(sscanf(params, "dddd", params[0],params[1],params[2],params[3])) return SCM(playerid, COLOR_LIGHTGREY, !"�����������: /giveownable [id] [car id] [color 1] [color 2]");
    if(!IsPlayerConnected(params[0])) return SCM(playerid, COLOR_GREY, !"����� �� � ����");
	if(!IsPlayerLogged{params[0]}) return SCM(playerid, COLOR_GREY, !"����� �� �������������");
    if(params[1] < 400 || params[1] > 611 && params[1]) return SCM(playerid, COLOR_GREY, !"����� ������������� �������� �� ����� ���� ���� 400 ��� ���� 611 !");
    
	GivePlayerOwnable(params[0], params[1], 0, 50, params[2], params[3], 1, 336);

    SendAdminsMessagef(COLOR_ADMINCHAT, "[%s #%d] %s[%d] ����� ������ %s[%d] ������ %s � /cars �� 14 ����.", AdminName[PI[playerid][pAdmin]], PI[playerid][pAdminNumber], PI[playerid][pName], playerid, getName(params[0]), params[0], VehicleNames[params[1]-400]);
    SendClientMessagef(params[0], COLOR_YELLOW, "������� ������ ����� ��� ������ %s �� 14 ����, ����������� /cars", VehicleNames[params[1]-400]);
	return 1;
}
CMD:resgun(playerid,params[]) 
{
    if(CheckAccess(playerid, 3)) return 1;
    if(sscanf(params,"u",params[0])) return SCM(playerid, COLOR_LIGHTGREY, !"�����������: /resgun [ID ������]");
	if(!IsPlayerConnected(params[0])) return  SCM(playerid, COLOR_GREY, !"����� �� � ����");
	if(!IsPlayerLogged{params[0]}) return SCM(playerid, COLOR_GREY, !"����� �� �����������");
	SendAdminsMessagef(COLOR_ADMINCHAT, "[%s #%d] %s ������ ��� ������ � ������ %s", AdminName[PI[playerid][pAdmin]], PI[playerid][pAdminNumber], getName(playerid),getName(params[0]));
    return ResetWeaponAll(params[0]);
}
CMD:mphp(playerid,params[]) 
{
    if(CheckAccess(playerid, 4)) return 1;
	if(sscanf(params,"d",params[0])) return SCM(playerid, COLOR_LIGHTGREY, !"�����������: /mphp [���-��]");
	new Float:x,Float:y,Float:z;
	GetPlayerPos(playerid, x,y,z);
   	for(new i = 0; i < MAX_PLAYERS; i++) 
	{
		if(!IsPlayerConnected(i)) continue;
		if(PlayerToPoint(100.0, i, x,y,z)) 
		{
		    SetPlayerHealthAC(i, params[0]);
		    SCMf(i, -1,"������� ������ ������� ������� ������ ��������", PI[playerid][pAdminNumber]);
			PI[i][pHospital] = 0;
		}
   	}
    return 1;
}
cmd:setmember(playerid, params[]) 
{
    if(CheckAccess(playerid, 3)) return 1;
    if(sscanf(params,"u",params[0])) return SCM(playerid, COLOR_LIGHTGREY, !"�����������: /setmember [ID ������]");
	if(!IsPlayerConnected(params[0]))return  SCM(playerid, COLOR_GREY, !"����� �� � ����");
	if(!IsPlayerLogged{params[0]})return  SCM(playerid, COLOR_GREY, !"����� �� �����������");
	if(PI[params[0]][pOnCapture])return  SCM(playerid, COLOR_GREY, !"����� ��������� � ������� ����������");
	SetPVarInt(playerid, "setMember", params[0]);
	ShowPlayerDialog(playerid, 2150, DIALOG_STYLE_LIST, "{ee3366}�������� �����������", "\
	1. �������������\n\
	2. ��������� �����\n\
	3. �������\n\
	4. ����\n\
	5. ��������\n\
	6. ������\n\
	7. ��������", "�������", "������");
	return 1;
}
cmd:slap(playerid, params[])
{
	if(CheckAccess(playerid, 2, 1)) return 1;
	new id;
	if(sscanf(params,"ud",id, params[1])) return SCM(playerid, COLOR_LIGHTGREY, !"�����������: /slap [ID ������] [������]");
	//if(params[1] < 1 || params[1] > 30) return SCM(playerid, COLOR_LIGHTGREY, !"�����������: /slap [ID ������] [������]");
	if(!IsPlayerConnected(id))return  SCM(playerid, COLOR_GREY, !"����� �� � ����");
	if(!IsPlayerLogged{id}) return SCM(playerid, COLOR_GREY, !"����� �� �����������");
	new Float:X,Float:Y,Float:Z;
	GetPlayerPos(id,X,Y,Z);
	SetPlayerPos(id,X,Y,Z+params[1]);
	SendAdminsMessagef(COLOR_ADMINCHAT, "[%s #%d] %s[%d] ��������� ������ %s[%d] �� %d.0 ������", AdminName[PI[playerid][pAdmin]], PI[playerid][pAdminNumber], getName(playerid), playerid, getName(id), id, params[1]);
	SendClientMessage(params[0], -1, !"������� ������ �������� ���");
	new Float: SlapHealth;
    GetPlayerHealth(params[0], SlapHealth);
    SetPlayerHealthAC(params[0], SlapHealth - 5);
	return true;
}
CMD:mparm(playerid,params[]) 
{
    if(CheckAccess(playerid, 4)) return 1;
	if(sscanf(params,"d",params[0])) return SCM(playerid, COLOR_LIGHTGREY, !"�����������: /mparm [���-��]");
	new Float:x,Float:y,Float:z;
	GetPlayerPos(playerid, x,y,z);
   	for(new i = 0; i < MAX_PLAYERS; i++) 
	{
		if(!IsPlayerConnected(i)) continue;
		if(PlayerToPoint(100.0, i, x,y,z)) 
		{
		    SetPlayerHealthAC(i, params[0]);
		    SCMf(i, -1,"������� ������ ����� ��� ����������", PI[playerid][pAdminNumber]);
		}
   	}
    return 1;
}
CMD:mpskin(playerid,params[]) 
{
    if(CheckAccess(playerid, 3)) return 1;
	if(sscanf(params,"dd",params[0], params[1])) return SCM(playerid, COLOR_LIGHTGREY, !"�����������: /mpskin [1, 2, 3] [����� �����]");
	if(params[1] > 297) return 1;
	new team_1[250],team_2[250], all, team1, team2;
	new Float:x,Float:y,Float:z;
	GetPlayerPos(playerid, x,y,z);
   	for(new i = 0; i < MAX_PLAYERS; i++) 
	{
	    if(i == playerid) continue;
		if(!IsPlayerConnected(i)) continue;
		if(PlayerToPoint(100.0, i, x,y,z)) 
		{
		    all++;
            if(params[0] == 3) 
			{
			    SetPlayerSkinAC(i,params[1]);
			    SCMf(i, -1, "������� ������ ����� ��� ��������� ����", PI[playerid][pAdminNumber]);
			    continue;
			}
            if(params[0] == 2 && all%2 == 0) 
			{
                team2++;
            	team_2[team2] = i;
            	SetPlayerSkinAC(i,params[1]);
            	SCMf(i, -1, "������� ������ ����� ��� ��������� ����", PI[playerid][pAdminNumber]);
            	continue;
			}
			if(params[0] == 1 && all%2 == 1) 
			{
			    team1++;
			    team_1[team1] = i;
			    SetPlayerSkinAC(i,params[1]);
			    SCMf(i, -1, "������� ������ ����� ��� ��������� ����", PI[playerid][pAdminNumber]);
			    continue;
			}
			if(params[0] < 1 || params[0] > 3) 
			{
			    SCM(playerid, COLOR_LIGHTGREY, !"�����������: /mpskin [1, 2, 3] [����� �����]");
			    break;
			}
		}
   	}
	if(params[0] == 3) return SCM(playerid, COLOR_HINT, !"[���������]: {FFFFFF}�� ������ ���� ������� � ������� ����");
	if(params[0] == 2) return SCM(playerid, COLOR_HINT, !"[���������]: {FFFFFF}�� ������ ��������� ������� � ������� ����");
	if(params[0] == 1) return SCM(playerid, COLOR_HINT, !"[���������]: {FFFFFF}�� ������ ��������� ������� � ������� ����");
    return 1;
}
CMD:mpgun(playerid,params[]) 
{
    if(CheckAccess(playerid, 3)) return 1;
	if(sscanf(params, "ddd", params[0], params[1], params[2])) return SCM(playerid, COLOR_LIGHTGREY, !"�����������: /mpgun [1, 2, 3] [������] [�������]");
  	else if(params[1] > 47 || params[1] < 1) return SCM(playerid, COLOR_GREY, !"������ ������ �� ����������");
    else if(params[2] > 1000 || params[2] < 1) return SCM(playerid, COLOR_GREY, !"�� ������ ���������� ������");
	if(params[1] == 35 && params[1] == 36 && params[1] == 37 && params[1] == 38 && params[1] == 39 && params[1] == 40) return SCM(playerid, COLOR_GREY, !"������ ������ �������� ������������ �������.");
	new team_1[250],team_2[250], all, team1, team2;
	new Float:x,Float:y,Float:z;
	GetPlayerPos(playerid, x,y,z);
   	for(new i = 0; i < MAX_PLAYERS; i++) 
	{
		if(i == playerid) continue;
		if(!IsPlayerConnected(i)) continue;
		if(PlayerToPoint(100.0, i, x,y,z)) 
		{
		    all++;
            if(params[0] == 3) 
			{
			    GiveWeapon(i,params[1], params[2]);
			    SCMf(i, -1, "������� ������ ����� ��� %s (+%d ��)", weapon_names[params[1]], params[2]);
			    continue;
			}
            if(params[0] == 2 && all%2 == 0) 
			{
                team2++;
            	team_2[team2] = i;
            	GiveWeapon(i,params[1], params[2]);
            	SCMf(i, -1, "������� ������ ����� ��� %s (+%d ��)", weapon_names[params[1]], params[2]);
            	continue;
			}
			if(params[0] == 1 && all%2 == 1) 
			{
			    team1++;
			    team_1[team1] = i;
			    GiveWeapon(i,params[1], params[2]);
			    SCMf(i, -1, "������� ������ ����� ��� %s (+%d ��)", weapon_names[params[1]], params[2]);
			    continue;
			}
			if(params[0] < 1 || params[0] > 3) 
			{
			    SCM(playerid, COLOR_LIGHTGREY, !"�����������: /mpgun [1, 2, 3] [������] [�������]");
				SCM(playerid, COLOR_GREY, !"1 - ������ �������, 2 - ������ �������, 3 - ��� ������");
			    break;
			}
		}
   	}
	if(params[0] == 3) return SCM(playerid, COLOR_HINT, !"[���������]: {FFFFFF}�� ������ ���� ������� � ������� ������");
	if(params[0] == 2) return SCM(playerid, COLOR_HINT, !"[���������]: {FFFFFF}�� ������ ��������� ������� � ������� ������");
	if(params[0] == 1) return SCM(playerid, COLOR_HINT, !"[���������]: {FFFFFF}�� ������ ��������� ������� � ������� ������");
    return 1;
}
CMD:setleader(playerid,params[]) 
{
    if(CheckAccess(playerid, 5)) return 1;
    if(sscanf(params,"u",params[0])) return SCM(playerid, COLOR_LIGHTGREY, !"�����������: /setleader [ID ������]");
    if(!IsPlayerConnected(params[0]))return  SCM(playerid, COLOR_GREY, !"����� �� � ����");
    if(!IsPlayerLogged{params[0]})return  SCM(playerid, COLOR_GREY, !"����� �� �����������");
	if(PI[params[0]][pOnCapture])return  SCM(playerid, COLOR_GREY, !"����� ��������� � ������� ����������");
    if(PI[params[0]][pLeader] >= 1) return SCM(playerid, COLOR_LIGHTGREY, !"����� ��� �����, ��� ����� ����� ����� ��������� {ff6633}(/luninvite)");
    SetPVarInt(playerid, "setLeader", params[0]);
    return ShowPlayerDialog(playerid, 2149, DIALOG_STYLE_LIST, "{ee3366}�������� �����������", "\
	1. �������������\n\
	2. ��������� �����\n\
	3. �������\n\
	4. ����\n\
	5. ��������\n\
	6. ������\n\
	7. ��������", "�������", "������");
}
CMD:tp(playerid) 
{
    if(CheckAccess(playerid, 1, 1)) return 1;
	return ShowPlayerDialog(playerid, 4385, DIALOG_STYLE_LIST, "{ee3366}������������", "\
	{FFFF99}�. ��������� \n\
	{FFFF99}���. �������\n\
	{FFFF99}�. �����\n\
	{FFFF99}�. ��������\n\
	{FFFF99}�. ��������\n\
	{FFFFFF}��� '��������'\n\
	{FFFFFF}��� '������'\n\
	{FFFFFF}��� '��������'\n\
	{FFFFFF}�������������\n\
	{FFFFFF}�������\n\
	{FFFFFF}����\n\
	{FFFFFF}�������� �����\n\
	{FFFFFF}�����\n\
	{FFFFFF}��������� (Luxe)\n\
	{FFFFFF}�����\n\
	{FFFFFF}����� �������\n\
	{FFFFFF}������������� �����\n\
	{FFFFFF}����� ��������\n\
	{FFFFFF}���� �������", "�������", "�������");
}
CMD:auninvite(playerid, params[]) 
{
    if(CheckAccess(playerid, 5)) return 1;
    if(sscanf(params,"u",params[0])) return SCM(playerid, COLOR_LIGHTGREY, !"�����������: /auninvite [ID ������]");
	if(!IsPlayerConnected(params[0])) return SCM(playerid, COLOR_GREY, !"����� �� � ����");
	if(!IsPlayerLogged{params[0]}) return SCM(playerid, COLOR_GREY, !"����� �� �����������");
	if(PI[params[0]][pLeader] == 1) return SCM(playerid, COLOR_GREY, !"����� �������� ������� �����������! ��� �� ����� ����������� {ff6633}(/luninvite)");

	new year,month,day ;
	getdate(year, month, day);

	mysql_tqueryf(mysql, "\
	INSERT INTO `wbook`(`w_player`,`w_fraction`,`w_name`,`w_reason`,`w_rank`,`w_day`,`w_mes`,`w_year`)\
		VALUES\
	('%d','%d','%s','���������� ������� ��������','%d','%d','%d','%d')",\
		PI[params[0]][pID], PI[params[0]][pMember], getName(params[0]), PI[params[0]][pRang], day, month, year);

	if(PI[params[0]][pOnCapture] == 1)
	{
		AutoKickCapture(params[0]);
		CheckCount(params[0]);
	}

	SCMf(params[0], COLOR_YELLOW, "������� ������ ������ ��� �� ����������� %s (%d ����)",
		Fraction_Name[PI[params[0]][pMember]], PI[params[0]][pRang]);

	cef_emit_event(params[0], "cef:capture:visible", CEFINT(false));

	PI[params[0]][pLeader] = 0;
	PI[params[0]][pMember] = 0;
	PI[params[0]][pRang] = 0;
	PI[params[0]][pOrgSkin] = 0;
	PI[params[0]][pProgressMetall] = 0;
	PI[params[0]][pProgressDrugs] = 0;
	PI[params[0]][pProgressAmmo] = 0;
	PI[params[0]][pProgressCarGrabber] = 0;
	PI[params[0]][pProgressSellGun] = 0;
	PI[params[0]][pProgressCapture] = 0;
    PI[params[0]][pCaptureManager] = 0;
	PI[params[0]][pRankUPTime] = 0;

	SetPlayerSkinAC(params[0], PI[params[0]][pSkin]);
	SetPlayerColorEx(params[0]);
	SetPlayerTeam(params[0], NO_TEAM);

	for(new g; g <= totalgz; g++) GangZoneHideForPlayer(params[0], g);
	GangZoneStopFlashForPlayer(params[0], WarZone);


	ClearGroup(params[0]);
	return SendAdminsMessagef(COLOR_ADMINCHAT, "[%s #%d] %s[%d] ������ �� ����������� ������ %s[%d]", AdminName[PI[playerid][pAdmin]], PI[playerid][pAdminNumber], getName(playerid),playerid,getName(params[0]), params[0]);
}
CMD:luninvite(playerid, params[]) 
{
    if(CheckAccess(playerid, 5)) return 1;
    if(sscanf(params,"u",params[0])) return SCM(playerid, COLOR_LIGHTGREY, !"�����������: /luninvite [ID ������]");
	if(!IsPlayerConnected(params[0])) return SCM(playerid, COLOR_GREY, !"����� �� � ����");
	if(!IsPlayerLogged{params[0]}) return SCM(playerid, COLOR_GREY, !"����� �� �����������");

	new year,month,day ;
	getdate(year, month, day);

	mysql_tqueryf(mysql, "\
	INSERT INTO `wbook`(`w_player`,`w_fraction`,`w_name`,`w_reason`,`w_rank`,`w_day`,`w_mes`,`w_year`)\
		VALUES\
	('%d','%d','%s','������ � ����� ������','%d','%d','%d','%d')",\
		PI[params[0]][pID], PI[params[0]][pMember], getName(params[0]), PI[params[0]][pRang], day, month, year );

	if(PI[params[0]][pOnCapture] == 1)
	{
		AutoKickCapture(params[0]);
		CheckCount(params[0]);
	}
	
	SCM(params[0], COLOR_YELLOW, !"������� ������ ���� ��� � ����� ������ �����������");

	SendAdminsMessagef(COLOR_ADMINCHAT, "[%s #%d] %s[%d] ���� � ����� ������ ����������� %s[%d]",\
		AdminName[PI[playerid][pAdmin]], PI[playerid][pAdminNumber], getName(playerid), playerid, getName(params[0]), params[0]);

	PI[params[0]][pLeader] = 0;
	PI[params[0]][pMember] = 0;
	PI[params[0]][pRang] = 0;
	PI[params[0]][pOrgSkin] = 0;
	PI[params[0]][pRankUPTime] = 0;

	SetPlayerSkinAC(params[0], PI[params[0]][pSkin]);
	SetPlayerColorEx(params[0]);
	SetPlayerTeam(params[0], NO_TEAM);

	cef_emit_event(params[0], "cef:capture:visible", CEFINT(false));

	for(new g; g <= totalgz; g++) GangZoneHideForPlayer(params[0], g);
	GangZoneStopFlashForPlayer(params[0], WarZone);

	ClearGroup(params[0]);
	return 1;
}
CMD:unjail(playerid,params[])
{
    if(CheckAccess(playerid, 1, 2)) return 1;
	if(sscanf(params,"u",params[0])) return SCM(playerid, COLOR_LIGHTGREY, !"�����������: /unjail [ID ������]");
    if(!IsPlayerConnected(params[0]))return  SCM(playerid, COLOR_GREY, !"����� �� � ����");
	if(!IsPlayerLogged{params[0]})return  SCM(playerid, COLOR_GREY, !"����� �� �����������");
	if(PI[params[0]][pDemorgan] == 0) return SCM(playerid, COLOR_GREY, !"����� �� ���������� � ���������");
	
	PI[params[0]][pJail] = 0;
	PI[params[0]][pJailTime] = 0;
	PI[params[0]][pDemorgan]= 0;
	PI[params[0]][pDemorganTime]= 0;

	PlayerSpawn(params[0]);
	SCMf(playerid, COLOR_TOMATO, "�� ��������� ������ %s �� ������", getName(params[0]));
	SCMf(params[0], COLOR_TOMATO, "������� ������ �������� ��� �� ������.", PI[playerid][pAdminNumber]);
	return SendAdminsMessagef(COLOR_ADMINCHAT, "[%s #%d] %s[%d] ��������� ������ %s[%d] �� ������", AdminName[PI[playerid][pAdmin]], PI[playerid][pAdminNumber], getName(playerid),playerid,getName(params[0]),params[0]);
}
CMD:givevb(playerid, params[])
{
    if(CheckAccess(playerid, 5)) return 1;
    if(sscanf(params,"u",params[0])) return SCM(playerid, COLOR_LIGHTGREY, !"�����������: /givevb [ID ������]");
	else if(PI[params[0]][pMilitaryID]) return SCM(playerid, COLOR_GREY,"� ������ ��� ������� ������� �����!");
	PI[params[0]][pMilitaryID] = 1;
	SCMf(params[0], COLOR_WHITE, "������� ������ ����� ��� ������� �����.", PI[playerid][pAdminNumber]);
	return SendAdminsMessagef(COLOR_ADMINCHAT, "[%s #%d] %s[%d] ����� ������ %s[%d] ������� �����",\
		AdminName[PI[playerid][pAdmin]], PI[playerid][pAdminNumber], getName(playerid), playerid, getName(params[0]), params[0]);
}
CMD:agivelic(playerid,params[])
{
    if(CheckAccess(playerid, 3)) return 1;
	if(sscanf(params, "u", params[0])) return SCM(playerid, COLOR_LIGHTGREY, !"�����������: /agivelic [ID ������]");
	if(!IsPlayerConnected(params[0])) return SCM(playerid, COLOR_GREY, !"����� �� � ����");
	if(!IsPlayerLogged{params[0]}) return SCM(playerid, COLOR_GREY, !"����� �� �����������");
	PI[params[0]][pDriveLicense] = 1;
	if(PI[params[0]][pLicNumber] == 0) PI[params[0]][pLicNumber] = RandomEX(1111111, 6666666);
	SCMf(playerid, -1, "������� ������ ����� ��� ������������ �����", PI[playerid][pAdminNumber]);
	return SendAdminsMessagef(COLOR_ADMINCHAT, "[%s #%d] %s ����� ������������ ����� %s", AdminName[PI[playerid][pAdmin]], PI[playerid][pAdminNumber], getName(playerid),getName(params[0]));
}
CMD:jail(playerid,params[])
{
    if(CheckAccess(playerid, 3, 3)) return 1;
	if(sscanf(params,"uds[32]",params[0],params[1],params[2])) return SCM(playerid, COLOR_LIGHTGREY, !"�����������: /jail [ID ������] [�����] [�������]");
    if(!IsPlayerConnected(params[0]))return  SCM(playerid, COLOR_GREY, !"����� �� � ����");
	if(!IsPlayerLogged{params[0]})return  SCM(playerid, COLOR_GREY, !"����� �� �����������");
	if(params[1] < 1 || params[1] > 600) return SCM(playerid, COLOR_GREY, !"������ ������ 1 ������ � ������ 600 �����");
    if(PI[params[0]][pAdmin] > PI[playerid][pAdmin]) return SCM(playerid, COLOR_GREY, !"������ ��������� � �������� �������");
	if(PI[params[0]][pDemorgan] == 1) return SCM(playerid, COLOR_GREY, !"����� ��� ���������� � ���������");

	if(PI[params[0]][pOnCapture] == 1)
	{
		AutoKickCapture(params[0]);
		CheckCount(params[0]);
	}
	
	PI[params[0]][pHospital] = 0;
	PI[params[0]][pDemorgan] = 1;
	PI[params[0]][pDemorganTime] = params[1]*60;

	new senderName[MAX_PLAYER_NAME + 20];
	if(PI[playerid][pAdmin]) format(senderName, sizeof(senderName), "%s #%d", AdminName[PI[playerid][pAdmin]], PI[playerid][pAdminNumber]);
	else format(senderName, sizeof(senderName), "%s", ModerName[PI[playerid][pModer]]);

	SCMf(playerid, COLOR_TOMATO, "�� �������� � ������ ������ %s �� %d �����. �������: %s", getName(params[0]), params[1], params[2]);
	SCMf(params[0], COLOR_TOMATO, "%s ������� ��� � ������ �� %d �����. �������: %s", PI[playerid][pAdmin] ? "������� ������" : "������� ���������", params[1], params[2]);

	SendAdminsMessagef(COLOR_ADMINCHAT, "[%s] %s[%d] ������� ������ %s � ������ �� %d �����. �������: %s", senderName, getName(playerid),playerid,getName(params[0]),params[1],params[2]);
	PlayerSpawn(params[0]);
	return ResetPlayerWeapons(params[0]);
}
CMD:unban(playerid,params[]) 
{
    if(CheckAccess(playerid, 5)) return 1;
	if(sscanf(params, "s[24]", params[0])) return SCM(playerid, COLOR_LIGHTGREY, !"�����������: /unban [���]");
	mysql_string[0] = EOS, f(mysql_string, 70, "SELECT * FROM `banlist` WHERE `name` = '%e'",params[0]);
	mysql_tquery(mysql, mysql_string, "UnbanAccount", "is", playerid, params[0]);
	return 1;
}
CMD:offgm(playerid,params[]) 
{
    if(CheckAccess(playerid, 8)) return 1;
	if(sscanf(params, "s[24]", params[0])) return SCM(playerid, COLOR_LIGHTGREY, !"�����������: /offgm [���]");
	mysql_string[0] = EOS, f(mysql_string, 70, "SELECT * FROM `accounts` WHERE `Name` = '%e'",params[0]);
	mysql_tquery(mysql, mysql_string, "OffGM", "is", playerid, params[0]);
	return 1;
}
CMD:offleader(playerid,params[]) 
{
    if(CheckAccess(playerid, 5)) return 1;
	if(sscanf(params, "s[24]", params[0])) return SCM(playerid, COLOR_LIGHTGREY, !"�����������: /offleader [���]");
	mysql_string[0] = EOS, f(mysql_string, 70, "SELECT * FROM `accounts` WHERE `Name` = '%e'",params[0]);
	mysql_tquery(mysql, mysql_string, "OffLeader", "is", playerid, params[0]);
	return 1;
}
//======================================= [ dialogs ] =============================//
stock admins_OnDialogResponse(playerid, dialogid, response, listitem)
{
	switch(dialogid) 
	{
		case 4385:
        {
            if(response)
            {
                switch(listitem)
                {
					case 0: SetPlayerPos(playerid, -2496.6514,187.7827,55.7560);
                    case 1: SetPlayerPos(playerid, -506.5684,-1417.5021,56.2231);
                    case 2: SetPlayerPos(playerid, 2254.5574,-1727.5728,61.1377);
                    case 3: SetPlayerPos(playerid, 1880.3647,1180.8679,38.8619);
                    case 4: SetPlayerPos(playerid, 2386.1399,-938.3940,14.3443);
                    case 5: SetPlayerPos(playerid, 2306.2070,1757.4645,9.9055+2); // ����
                    case 6: SetPlayerPos(playerid, 2224.7097,-2611.0547,31.8857+2);
                    case 7: SetPlayerPos(playerid, -367.4405,-1198.3756,50.2112+2);
                    case 8: SetPlayerPos(playerid, 1907.1965,-2226.8005,43.2401+2);
                    case 9: SetPlayerPos(playerid, 2403.2986,-1849.3372,21.9369+2);
					case 10: SetPlayerPos(playerid, 2113.0063,1821.8636,23.0438+2);
                    case 11: SetPlayerPos(playerid, -2586.5540,309.6096,20.9953+2);
					case 12: SetPlayerPos(playerid, 1812.3840,2095.7266,28.6875+2); // �����
                    case 13: SetPlayerPos(playerid, 2336.7915,-1803.0875,33.1497+2);
                    case 14: SetPlayerPos(playerid, 2782.3528,2698.6128,16.7200+2);
                    case 15: SetPlayerPos(playerid, 1880.3647,1180.8679,38.8619+2);
					case 16: SetPlayerPos(playerid, 2469.1038,-714.2072,24.5437+2);
					case 17: SetPlayerPos(playerid, 1474.5935,2045.2124,24.0309+2);
					case 18: SetPlayerPos(playerid, 1517.7395,-1213.6506,15.0275+2);
                }
				SetPlayerVirtualWorld(playerid,0);
				SetPlayerInterior(playerid,0);
				SetPlayerHealthAC(playerid, 200);
				SendClientMessage(playerid, COLOR_LIGHTGREY, !"�� ���� ��������������� {ff6633}(/tp)");
				SendAdminsMessagef(COLOR_ADMINCHAT, "[%s #%d] %s[%d] ���������������� ��������� /tp", AdminName[PI[playerid][pAdmin]], PI[playerid][pAdminNumber], PI[playerid][pName], playerid);
            }
        }
		case 2149:
     	{
            if(!response) return 1;
            if(response)
            {
                new id = GetPVarInt(playerid, "setLeader");

                PI[id][pLeader] = setleader_config[listitem][member];
				PI[id][pMember] = setleader_config[listitem][member];
				PI[id][pRang] = 10;

				SCMf(id, COLOR_YELLOW, "�����������! ������� ������ �������� ��� ������� ����������� '%s'",setleader_config[listitem][f_name]);
				SetPlayerColorEx(id);
				
			    if(PI[id][pPassiveMode] == 1)
				{
					SCM(id, COLOR_HINT, !"[Info] {FFFFFF}��������� ����� ������������� �������� (�������: ������� � ���)");
					PassiveModeOff(id);
	            }

				if(PI[playerid][pSex] == 1) 
				{
					switch(PI[id][pMember]) 
					{
						case 1: PI[id][pOrgSkin] = 208;
						case 2: PI[id][pOrgSkin] = 222;
						case 3: PI[id][pOrgSkin] = 280;
						case 4: PI[id][pOrgSkin] = 70;
						case 5: PI[id][pOrgSkin] = 117;
						case 6: PI[id][pOrgSkin] = 236;
						case 7: PI[id][pOrgSkin] = 118;
						case 8: PI[id][pOrgSkin] = 283;
					}
				}
				if(PI[playerid][pSex] == 2) 
				{
					switch(PI[id][pMember]) 
					{
						case 1: PI[id][pOrgSkin] = 156;
						case 2: PI[id][pOrgSkin] = 179;
						case 3: PI[id][pOrgSkin] = 280;
						case 4: PI[id][pOrgSkin] = 276;
						case 5: PI[id][pOrgSkin] = 117;
						case 6: PI[id][pOrgSkin] = 121;
						case 7: PI[id][pOrgSkin] = 118;
						case 8: PI[id][pOrgSkin] = 298;
					}
				}
				new str_q[73];
				mysql_format(mysql, str_q, sizeof(str_q), "SELECT * FROM `group` WHERE `fraction` = '%d' AND `skin_m` = %d", PI[id][pMember], PI[id][pOrgSkin]);
				mysql_function_query(mysql, str_q, true, "SetPlayerStandartGroup", "d", id);

				UpdatePlayerDataInt(playerid, "skinm", PI[playerid][pOrgSkin]);
				SetPlayerSkinAC(id,PI[id][pOrgSkin]);

				if(PI[id][pMember] == 5 || PI[id][pMember] == 6 || PI[id][pMember] == 7) for(new g; g <= totalgz; g++) GangZoneShowForPlayer(id, g, GetGZFrac(g));

    			ShowPlayerDialogf(playerid, 0, DIALOG_STYLE_MSGBOX, !"{ee3366}���������", "�������", "�������", "{FFFFFF}�����������! �� ���� ��������� ������� ����������� %s\n\n������ ��� ���������� �������� � ������ ������� ���������. ��� ����� ��������\n�� ����� �������� ����� ��������� ������ ����:{F7E19C}vk.com/"VK"", Fraction_Name[PI[playerid][pMember]]);

				SendAdminsMessagef(COLOR_ADMINCHAT, "[%s #%d] %s[%d] �������� %s[%d] �� ��������� ������ ����������� '%s'", AdminName[PI[playerid][pAdmin]], PI[playerid][pAdminNumber], PI[playerid][pName],playerid,PI[id][pName], id, Fraction_Name[PI[id][pMember]]);

				CheckGangWar(playerid);
				SetPlayerTeam(id, PI[id][pMember]);
				SavePlayerData(id);

				DeletePVar(playerid,"setMember");
			}
		}
		case 2150: 
		{
            if(!response) return 1;
            if(response) 
			{
				new id = GetPVarInt(playerid,"setMember");
               	PI[id][pTempMember] = setleader_config[listitem][member];
               	ShowPlayerDialog(playerid, 2151, DIALOG_STYLE_LIST, !"{ee3366}�������� ����", !"1\n2\n3\n4\n5\n6\n7\n8\n{FFFF99}�����������", !"�������", !"������");
			}
		}
		case 2151:
		{
			if(!response) return 1;
			if(response) 
			{
			    new id = GetPVarInt(playerid,"setMember");

				SetPlayerColorEx(id);
				SetDefaultSkin(PI[id][pTempMember], id);
				PI[id][pLeader] = 0;
				PI[id][pMember] = PI[id][pTempMember];
				PI[id][pTempMember] = -1;
				PI[id][pRang] = listitem+1;

				if(PI[id][pMember] == 5 || PI[id][pMember] == 6 || PI[id][pMember] == 7) for(new g; g <= totalgz; g++) GangZoneShowForPlayer(id, g, GetGZFrac(g));

				CheckGangWar(playerid);

				SCMf(playerid, COLOR_YELLOW, "�� ������� %s[%d] � ����������� %s �� %d ����", PI[id][pName], id, Fraction_Name[PI[id][pMember]], PI[id][pRang]);
				SCMf(id, COLOR_YELLOW, "������� ������ ������ ��� � ����������� %s �� %d ����", Fraction_Name[PI[id][pMember]], PI[id][pRang]);
				SendAdminsMessagef(COLOR_ADMINCHAT, "[%s #%d] %s[%d] ������ %s[%d] � ����������� %s �� %d ����", AdminName[PI[playerid][pAdmin]], PI[playerid][pAdminNumber], PI[playerid][pName],playerid,PI[id][pName], id, Fraction_Name[PI[id][pMember]], PI[id][pRang]);
				
				if(PI[id][pPassiveMode] == 1)
				{
					SCM(id, COLOR_HINT, !"[Info] {FFFFFF}��������� ����� ������������� �������� (�������: ������� � ���)");
					PI[id][pPassiveMode] = 0;
					PassiveModeOff(id);
	            }
				
				new str_q[73];
				mysql_format(mysql,str_q, sizeof(str_q), "SELECT * FROM `group` WHERE `fraction` = '%d' AND `standart` = 1", PI[id][pMember]);
				mysql_function_query(mysql, str_q, true, "SetPlayerStandartGroup", "d", id);

				SavePlayerData(id);

				DeletePVar(playerid,"setMember");
			}
		}
		case 2390:
		{
			if(!response) return 1;
			if(response)
			{
				switch(listitem)
				{
					case 0: 
					{
						if(ArmyStorage == 0) ArmyStorage = 1;
						else ArmyStorage = 0;

						SendAdminsMessagef(COLOR_ADMINCHAT, "[%s #%d] %s[%d] %s ����� ����������� '�������� �����'",\
							AdminName[PI[playerid][pAdmin]], PI[playerid][pAdminNumber], PI[playerid][pName], playerid, ArmyStorage ? ("������") : ("������"));
					}
					case 1:
					{
						SendAdminsMessagef(COLOR_ADMINCHAT, "[%s #%d] %s[%d] �������� ����� ����������� '�������� �����'",\
							AdminName[PI[playerid][pAdmin]], PI[playerid][pAdminNumber], PI[playerid][pName], playerid);
						
						army_wh[0] +=500000;
						army_wh[1] +=500000;

						new str_3[256];
						format(str_3,sizeof(str_3),"{f18c2b}��������� �����\n\n{FFFFFF}������: %d ��.\n{fccf39}�������: %d ��.",army_wh[0],army_wh[1]);
						UpdateDynamic3DTextLabelText(army_sklad_text, -1, str_3);
					}
					case 2:
					{
						SendAdminsMessagef(COLOR_ADMINCHAT, "[%s #%d] %s[%d] ������� ����� ����������� '�������� �����'",\
							AdminName[PI[playerid][pAdmin]], PI[playerid][pAdminNumber], PI[playerid][pName], playerid);
						
						army_wh[0] = 0;
   						army_wh[1] = 0;

						new str_3[256];
						format(str_3,sizeof(str_3),"{f18c2b}��������� �����\n\n{FFFFFF}������: %d ��.\n{fccf39}�������: %d ��.",army_wh[0],army_wh[1]);
						UpdateDynamic3DTextLabelText(army_sklad_text, -1, str_3);
					}
				}
				SaveWarehouse();
			}
		}
	}
	return 1;
}
callback: OffGM(playerid,name[]) 
{
    new rows, fields;
    cache_get_data(rows, fields);
    if(rows)
	{
	    for(new i = 0; i < MAX_PLAYERS; i++) 
		{
	        if(!IsPlayerConnected(i)) continue;
	        if(strcmp(PI[i][pName], name, true, 24) == 0) 
			{
	            SCM(i, COLOR_GREY, !"�� ���� ����� � ��������� �������� �������");
				PI[i][pAdmin] = 0;
	        }
	    }
	    mysql_tqueryf(mysql, "UPDATE `accounts` SET `Admin` = '0' WHERE `Name` = '%e'", name);
		SendAdminsMessagef(COLOR_ADMINCHAT, "[%s #%d] %s[%d] ���� %s � ����� �������� ������� �������", AdminName[PI[playerid][pAdmin]], PI[playerid][pAdminNumber], PI[playerid][pName], playerid, name);
	}
	else SCM(playerid, COLOR_GREY, !"������ ������� �� ������ � ���� ������");
	return 1;
}
callback: UnbanAccount(playerid,name[]) 
{
    new rows, fields;
    cache_get_data(rows, fields);
    if(rows) 
	{
	    mysql_tqueryf(mysql, "DELETE FROM `banlist` WHERE `name` = '%e'", name);
		SendAdminsMessagef(COLOR_YELLOW, "[%s #%d] %s[%d] �������� ������� %s", AdminName[PI[playerid][pAdmin]], PI[playerid][pAdminNumber], PI[playerid][pName],playerid,name);
	}
	else SCM(playerid, COLOR_GREY, !"������ ������� �� ������ � ���� ������");
	return 1;
}
public OnPlayerClickMap(playerid, Float:fX, Float:fY, Float:fZ)
{
	if(PI[playerid][pAdmin] >= 1)
	{
		new vehicleid = GetPlayerVehicleID(playerid);
		if(vehicleid != INVALID_VEHICLE_ID)
		{
			SetVehiclePos(vehicleid, fX, fY, fZ);
		}
		else
		{
			SetPlayerPosAC(playerid, fX, fY, fZ);
		}
		SendClientMessage(playerid, -1, !"�� ���� ������� ���������������");
	}
	else 
	{
		SCM(playerid, COLOR_GREEN, "����� ���������� ������� � ��� �� ����-�����!");
		cef_emit_event(playerid, "show-notify", CEFINT(17), CEFSTR("����� ���������� ������� � ��� �� ����-�����"), CEFSTR("4ea650"));
	}
	return 1;
}
CMD:givemoney(playerid, params[]) 
{
    if(CheckAccess(playerid, 8)) return 1;
    if(GetPVarInt(playerid,"givemoney") > gettime()) return SCM(playerid, COLOR_GREY,"������� ����� ������������ ��� � 1 ������");
	if(sscanf(params,"ud",params[0],params[1])) return SCM(playerid, COLOR_LIGHTGREY, !"�����������: /givemoney [id] [ammount]");
    if(!IsPlayerConnected(params[0])) return  SCM(playerid, COLOR_GREY, !"����� �� � ����");
	if(!IsPlayerLogged{params[0]}) return SCM(playerid, COLOR_GREY, !"����� �� �����������");
	if(params[1] > 5000000)return  SCM(playerid, COLOR_GREY, !"����� ������ ������ �� 1 �� 5000000 ���");
    SetPVarInt(playerid,"givemoney",gettime() + 59);
	GivePlayerMoneyLog(params[0], params[1]);
	SCMf(params[0], COLOR_YELLOW, "������� ������ ����� ��� %d ������", PI[playerid][pAdminNumber], params[1]);
	SendAdminsMessagef(COLOR_ADMINCHAT, "[%s #%d] %s[%d] ����� ������ %s[%d] %d ������", AdminName[PI[playerid][pAdmin]], PI[playerid][pAdminNumber], getName(playerid), playerid, getName(params[0]), params[0], params[1]);
	return 1;
}
CMD:makegm(playerid, params[]) 
{
    if(CheckAccess(playerid, 8)) return 1;
    if(sscanf(params,"u",params[0])) return SCM(playerid, COLOR_LIGHTGREY, !"�����������: /makegm [ID ������]");
	if(!IsPlayerConnected(params[0]))return  SCM(playerid, COLOR_GREY, !"����� �� � ����");
	if(!IsPlayerLogged{params[0]})return  SCM(playerid, COLOR_GREY, !"����� �� �����������");
	if(PI[playerid][pAdmin] < PI[params[0]][pAdmin]) return SCM(playerid, COLOR_GREY, !"������ �������� ������� �������� ������� ������� ���� ���");
	SetPVarInt(playerid, "AdmID", params[0]);
	return ShowPlayerDialog(playerid, 8000, DIALOG_STYLE_LIST, !"{ee3366}������ ���� �������� �������", !"\
	����� ����� �������� �������\n\
	1. NGM\n\
	2. JRGM\n\
	3. GM\n\
	4. GM+\n\
	5. LGM\n\
	6. SGM\n\
	7. SGM+\n\
	8. DEV", !"�����", !"������");
}