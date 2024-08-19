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
static const stock ModerName[4][22] = {
	"�����",
 	"Junior Moderator (#1)",
 	"Moderator (#2)",
 	"Senior Moderator (#3)"
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
	"Monster B","Lamborghini Huracan Devo","Acura NSX GT3","Tesla Pro","�� �������-427","Elegy","Raindance","RC Tiger","��� 2108","��� 2104","Savanna","Bandito","Freight","Trailer",
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
 	if(CheckAccess(playerid, 1, 1)) return 0;

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
    if(CheckAccess(playerid, 4)) return 1;
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
cmd:giveskill(playerid, params[]) 
{
    if(CheckAccess(playerid, 4, 2)) return 1;
    if(sscanf(params,"u",params[0])) return SCM(playerid, COLOR_LIGHTGREY, !"�����������: /giveskill [ID ������]");
	if(!IsPlayerConnected(params[0]))return  SCM(playerid, COLOR_GREY, !"����� �� � ����");
	if(!IsPlayerLogged{params[0]})return  SCM(playerid, COLOR_GREY, !"����� �� �����������");

	SCM(params[0], -1, !"������� ������ ����� ��� ��� ������ ��������");
	SendAdminsMessagef(COLOR_ADMINCHAT, "[%s #%d] %s[%d] ����� ��� %s[%d] ��� ������ ��������", AdminName[PI[playerid][pAdmin]], PI[playerid][pAdminNumber], getName(playerid), playerid, getName(params[0]), params[0]);

	PI[params[0]][pSkillPistol] = 100;
	PI[params[0]][pSkillSDPistol] = 100;
	PI[params[0]][pSkillDeagle] = 100;
	PI[params[0]][pSkillShotgun] = 100;
	PI[params[0]][pSkillMP5] = 100;
	PI[params[0]][pSkillAK47] = 100;
	PI[params[0]][pSkillRifle] = 100;
	return SetPlayerSkills(params[0]);
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
    if(CheckAccess(playerid, 3, 2)) return 1;
	new carid = GetPlayerVehicleID(playerid);
	if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER) return SCM(playerid, COLOR_GREY, !"����� ���������� �� ����� ����������");
	SetVehicleToRespawn(carid);
	return SCM(playerid, COLOR_GREY, !"���������� ��� ���������");
}
CMD:setfuel(playerid,params[]) 
{
    if(CheckAccess(playerid, 3, 2)) return 1;
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
CMD:skin(playerid, params[]) 
{
    if(CheckAccess(playerid, 1, 2)) return 1;
	if(sscanf(params,"udd", params[0], params[1], params[2])) return SCM(playerid, COLOR_LIGHTGREY, !"�����������: /skin [ID ������] [����� �����] [0/1]");
	if(!IsPlayerConnected(params[0]))return  SCM(playerid, COLOR_GREY, !"����� �� � ����");
	if(!IsPlayerLogged{params[0]})return  SCM(playerid, COLOR_GREY, !"����� �� �����������");
	if(params[1] > 300) return SCM(playerid, COLOR_LIGHTGREY, !"�����������: /skin [ID ������] [����� ����� (1-300)] [0/1]");
	if(params[2] < 0 || params[2] > 1) return 0;
	
	if(params[2] == 1)
	{
		PI[params[0]][pSkin] = params[1];

		SendAdminsMessagef(COLOR_ADMINCHAT, "[%s #%d] %s[%d] ����� ������ ���� ������ %s[%d] (ID %d)", AdminName[PI[playerid][pAdmin]], PI[playerid][pAdminNumber], getName(playerid), playerid, getName(params[0]), params[0], params[1]);
		SCMf(params[0], -1, "������� ������ ����� ��� ������ ����.", PI[playerid][pAdminNumber]);
	}
	else
	{
		SendAdminsMessagef(COLOR_ADMINCHAT, "[%s #%d] %s[%d] ����� ��������� ���� ������ %s[%d] (ID %d)", AdminName[PI[playerid][pAdmin]], PI[playerid][pAdminNumber], getName(playerid), playerid, getName(params[0]), params[0], params[1]);
		SCMf(params[0], -1, "������� ������ ����� ��� ��������� ����.", PI[playerid][pAdminNumber]);
	}
	SetPlayerSkinAC(params[0], params[1]);
    return 1;
}
CMD:gethere(playerid,params[]) 
{
    if(CheckAccess(playerid, 2, 1)) return 1;
    if(sscanf(params, "u",params[0])) return SCM(playerid, COLOR_LIGHTGREY, !"�����������: /gethere [ID ������]");
    if(!IsPlayerConnected(params[0])) return SCM(playerid, COLOR_GREY, !"����� �� � ����");
    if(params[0] == playerid) return SCM(playerid, COLOR_GREY, !"�� �� ������ ��������������� ����");
	if(!IsPlayerLogged{params[0]}) return SCM(playerid, COLOR_GREY, !"����� �� �����������");
	if(PI[params[0]][pOnCapture] == 1 && GangWarStatus >= 2) return SCM(playerid, COLOR_GREY, !"����� ��������� � �������� �� ����������");

    new Float:x, Float:y, Float:z;
    DeletePVar(params[0], "ac_fly");
    GetPlayerPos(playerid,x,y,z);
    SetPlayerPosAC(params[0],x+1,y,z+1.0);
    SetPlayerInterior(params[0], GetPlayerInterior(playerid));
    SetPlayerVirtualWorld(params[0], GetPlayerVirtualWorld(playerid));
	HidePlayerSpeedometer(params[0]);

	new senderName[MAX_PLAYER_NAME + 20];
	if(PI[playerid][pAdmin]) format(senderName, sizeof(senderName), "%s #%d", AdminName[PI[playerid][pAdmin]], PI[playerid][pAdminNumber]);
	else format(senderName, sizeof(senderName), "%s", ModerName[PI[playerid][pModer]]);

    SendAdminsMessagef(COLOR_ADMINCHAT, "[%s] %s[%d] �������������� � ���� %s[%d]", senderName, getName(playerid),playerid, getName(params[0]), params[0]);
	SCMf(params[0], COLOR_GREY, "�� ���� ��������������� %s",  PI[playerid][pAdmin] ? "������� ��������" : "������� �����������");
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
	if(PI[params[0]][pOnCapture] == 1 && GangWarStatus >= 2) return SCM(playerid, COLOR_GREY, !"����� ��������� � �������� �� ����������");

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
CMD:veh(playerid, params[]) 
{
    if(CheckAccess(playerid, 2, 3)) return 1;
    if(sscanf(params, "dddd", params[0], params[1], params[2], params[3])) return SCM(playerid, COLOR_LIGHTGREY, !"�����������: /veh [ID ������] [ID ������] [����] [����]");
    if(params[1] < 400 || params[1] > 611 && params[0]) return SCM(playerid, COLOR_GREY, !"����� ������������� �������� �� ����� ���� ���� 400 ��� ���� 611 !");

	if(params[0] == INVALID_PLAYER_ID || !IsPlayerLogged{params[0]} || !IsPlayerConnected(params[0])) 
		return SCM(playerid, COLOR_GREY, !"����� �� �����������");
	
	if(params[1] == 432 || params[1] == 460 || params[1] == 476 || params[1] == 511 || 
		params[1] == 512 || params[1] == 513 || params[1] == 519 || params[1] == 520 || params[1] == 553 ||
		params[1] == 577 || params[1] == 592 || params[1] == 593) return SCM(playerid, COLOR_GREY, !"���� ��������� �������� �������������� �������");

    new Float:pos[3]; GetPlayerPos(playerid, pos[0], pos[1], pos[2]);
    new vehc = CreateVehicle(params[1], pos[0], pos[1], pos[2], 0, params[1], params[2], -1);

    SetVehicleVirtualWorld(vehc, GetPlayerVirtualWorld(playerid));
	PutPlayerInVehicle(params[0], vehc, 0);

    ClearCarData(vehc);
    CarInfo[vehc][cFuel] = 50;
    CarInfo[vehc][cCreate] = 1;
	new vehicadm = GetVehicleModel(vehc);
	SetVehicleNumberPlate(vehc, "ADMIN");
    SendAdminsMessagef(COLOR_ADMINCHAT, "[%s #%d] %s[%d] ������ %s[%d] (id: %d, ����: %d, %d)",\
		AdminName[PI[playerid][pAdmin]], PI[playerid][pAdminNumber], PI[playerid][pName],playerid, VehicleNames[vehicadm-400], vehc, params[1], params[2], params[3]);
	return 1;
}
CMD:dveh(playerid) 
{
    if(CheckAccess(playerid, 2, 3)) return 1;
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
    if(CheckAccess(playerid, 2, 3)) return 1;
	if(sscanf(params, "ud", params[0], params[1])) return SCM(playerid, COLOR_LIGHTGREY, !"�����������: /setarm [ID ������] [���-��]");
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
    if(CheckAccess(playerid, 2, 3)) return 1;
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
    if(CheckAccess(playerid, 2, 3)) return 1;
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
CMD:gun(playerid,params[]) 
{
    if(CheckAccess(playerid, 3)) return 1;
	if(sscanf(params, "udd", params[0], params[1], params[2])) return SCM(playerid, COLOR_LIGHTGREY, !"�����������: /gun [ID ������] [������] [�������]");
	if(PI[params[0]][pWeaponLock] > 0) return SCM(playerid, COLOR_GREY, !"� ������� ������ ���������� ������");
    if(!IsPlayerConnected(params[0]))return  SCM(playerid, COLOR_GREY, !"����� �� � ����");
	if(!IsPlayerLogged{params[0]})return  SCM(playerid, COLOR_GREY, !"����� �� �����������");
	else if(params[1] > 47 || params[1] < 1) return SCM(playerid, COLOR_GREY, !"������ ������ �� ����������");
    else if(params[2] > 100000 || params[2] < 1) return SCM(playerid, COLOR_GREY, !"���������: /gun [ID ������] [������] [������� > 1]");

	if(PI[params[0]][pOnCapture] == 1 && GangWarStatus >= 2) return SCM(playerid, COLOR_GREY, !"����� ��������� � �������� �� ����������");

	if(params[1] == 35 || params[1] == 36 || params[1] == 37 || params[1] == 38 || params[1] == 39 || params[1] == 40) return SCM(playerid, COLOR_GREY, !"��� ������ �������� �������������� �������");
    GiveWeapon(params[0], params[1], params[2]);
	SendAdminsMessagef(COLOR_ADMINCHAT, "[%s #%d] %s[%d] ����� %s[%d] %s[%d] (%d ��)", AdminName[PI[playerid][pAdmin]], PI[playerid][pAdminNumber], getName(playerid),playerid,getName(params[0]), params[0], weapon_names[params[1]], params[1], params[2]);
	SCMf(params[0], -1, "������� ������ ����� ��� %s (+%d ��)", weapon_names[params[1]], params[2]);
    return 1;
}
CMD:setgz(playerid) 
{
    if(CheckAccess(playerid, 5)) return 1;
	new gz = GetPlayerGangZone(playerid);
	if(gz_info[gz][gzid] == 101) return 1;
	if(gz_info[gz][gzid] == 0) return 1;
 	ShowPlayerDialog(playerid, dialog_SETGZ, DIALOG_STYLE_LIST, "{ee3366}�������� ���", "1. ��������\n2. ������\n3. ��������", "�����", "�������");
	return 1;
}
CMD:aclear(playerid,params[]) 
{
    if(CheckAccess(playerid, 3)) return 1;
	if(sscanf(params, "u", params[0])) return SCM(playerid, COLOR_LIGHTGREY, !"�����������: /aclear [ID ������]");
    if(!IsPlayerConnected(params[0]))return  SCM(playerid, COLOR_GREY, !"����� �� � ����");
	if(!IsPlayerLogged{params[0]})return  SCM(playerid, COLOR_GREY, !"����� �� �����������");
    if(PI[params[0]][pWanted] == 0) return SCM(playerid, COLOR_GREY, !"� ������ ��� �������");
	PI[params[0]][pWanted] = 0;
	SetPlayerWantedLevel(params[0],PI[params[0]][pWanted]);
	return SendAdminsMessagef(COLOR_ADMINCHAT, "[%s #%d] %s ������� ������ %s", AdminName[PI[playerid][pAdmin]], PI[playerid][pAdminNumber], getName(playerid),getName(params[0]));
}
CMD:tpc(playerid) 
{
    if(CheckAccess(playerid, 8)) return 1;
	if(GetPVarInt(playerid, "AddKV") == 0 && GetPVarInt(playerid, "addhouse") == 0) return SCM(playerid, COLOR_GREY, !"�� �� ������ ��������� ������� / ���");
	new Float:x, Float:y, Float:z, Float:a;
    GetPlayerPos(playerid, x, y, z);
    GetPlayerFacingAngle(playerid, a);
  	SetPVarFloat(playerid,"aCarX", x);
  	SetPVarFloat(playerid,"aCarY", y);
  	SetPVarFloat(playerid,"aCarZ", z);
  	SetPVarFloat(playerid,"aCarAngle", a);
  	SCM(playerid, COLOR_YELLOW, !"�������� �� �����, ��� ����� ���������� ������� � ������� (/tpkv) ��� �� ���� ������� ��� (/tph)");
	return 1;
}
CMD:msg(playerid,params[]) 
{
    if(CheckAccess(playerid, 5)) return 1;
	if(sscanf(params,"s[144]",params[0])) return SCM(playerid, COLOR_LIGHTGREY, !"�����������: /msg [�����]");
	SendClientMessageToAllf(COLOR_BLACKRED, "������� ������: %s", params[0]);
    return 1;
}
CMD:addhouse(playerid) 
{
    if(CheckAccess(playerid, 8)) return 1;
	return ShowPlayerDialog(playerid, dialog_ADD_HOUSE, DIALOG_STYLE_MSGBOX, !"{ee3366}���������� ����", !"{FFFFFF}�� ������� �������� ���?", !"��", !"������");
}
CMD:tph(playerid) 
{
    if(CheckAccess(playerid, 8)) return 1;
	if(GetPVarInt(playerid, "addhouse") == 0) return SCM(playerid, COLOR_GREY, !"�� �� ������ ��������� ���");
	new Float:x, Float:y, Float:z;
	GetPlayerPos(playerid, x, y, z);
	SetPVarFloat(playerid,"aEnterX",x);
	SetPVarFloat(playerid,"aEnterY",y);
	SetPVarFloat(playerid,"aEnterZ",z);
	return ShowPlayerDialog(playerid, dialog_ADD_HOUSE_1, DIALOG_STYLE_LIST, !"{ee3366}�������� ��������", !"2 �����. �������\n1 ����. �������� ���", !"�������", !"������");
}
CMD:ahelp(playerid) 
{
	if(PI[playerid][pAdmin] == 0) return 1;
    new dialog[123];
	format(dialog, sizeof(dialog), "1. NGM%s%s%s%s%s%s%s", (PI[playerid][pAdmin] >= 2) ? ("\n2. JRGM") : (""), (PI[playerid][pAdmin] >= 3) ? ("\n3. GM") : (""), (PI[playerid][pAdmin] >= 4) ? ("\n4. GM+") : (""), (PI[playerid][pAdmin] >= 5) ? ("\n5. LGM") : (""), (PI[playerid][pAdmin] >= 6) ? ("\n6. SGM") : (""), (PI[playerid][pAdmin] >= 7) ? ("\n7. SGM+") : (""), (PI[playerid][pAdmin] > 8) ? ("\n8. DEV") : (""));
	return ShowPlayerDialog(playerid, dialog_ADMCOMMAND, DIALOG_STYLE_LIST, "{ee3366}������� �������� �������", dialog, "�������", "�������");
}
CMD:a(playerid,params[]) 
{
    if(CheckAccess(playerid, 1, 1)) return 1;
	if(sscanf(params,"s[90]",params[0])) return SCM(playerid, COLOR_LIGHTGREY, !"�����������: /a [�����]");
	// old color - 0x99CC00FF
	SendAdminsMessagef(0x4F83C6FF, "%s %s[%d]: %s", PI[playerid][pAdmin] ? "[Game Master]" : "[Moder]", PI[playerid][pName], playerid, params[0]);
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
	army_wh[2] ? ("{66cc66}(������)") : ("{ff6633}(������)"), army_wh[1], army_wh[0]);
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
		    SCM(i, -1, !"������� ������ ������� ������� ������ ��������");
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
	if(PI[params[0]][pLeader] >= 1) return SCM(playerid, COLOR_LIGHTGREY, !"������ ����� �����, ��� ����� ����� ����� ��������� �� ������ ���� {ff6633}(/luninvite)");
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
	if(sscanf(params,"ud", id)) return SCM(playerid, COLOR_LIGHTGREY, !"�����������: /slap [ID ������] [value]");
	if(!IsPlayerConnected(id))return  SCM(playerid, COLOR_GREY, !"����� �� � ����");
	if(!IsPlayerLogged{id}) return SCM(playerid, COLOR_GREY, !"����� �� �����������");
	new Float:X,Float:Y,Float:Z;
	GetPlayerPos(id,X,Y,Z);
	SetPlayerPos(id,X,Y,Z+3);
	SendAdminsMessagef(COLOR_ADMINCHAT, "[%s #%d] %s[%d] ��������� ������ %s[%d] �� 3 �����", AdminName[PI[playerid][pAdmin]], PI[playerid][pAdminNumber], getName(playerid), playerid, getName(id), id);
	SendClientMessage(id, -1, !"������� ������ �������� ���");
	new Float: SlapHealth;
    GetPlayerHealth(id, SlapHealth);
    SetPlayerHealthAC(id, SlapHealth - 5);
	return true;
}
cmd:drop(playerid, params[])
{
	if(CheckAccess(playerid, 2, 1)) return 1;
	new id;
	if(sscanf(params,"ud", id)) return SCM(playerid, COLOR_LIGHTGREY, !"�����������: /drop [ID ������] [value]");
	if(!IsPlayerConnected(id))return  SCM(playerid, COLOR_GREY, !"����� �� � ����");
	if(!IsPlayerLogged{id}) return SCM(playerid, COLOR_GREY, !"����� �� �����������");
	new Float:X,Float:Y,Float:Z;
	GetPlayerPos(id,X,Y,Z);
	SetPlayerPos(id,X,Y,Z-3);
	SendAdminsMessagef(COLOR_ADMINCHAT, "[%s #%d] %s[%d] ������� ������ %s[%d] �� 3 �����", AdminName[PI[playerid][pAdmin]], PI[playerid][pAdminNumber], getName(playerid), playerid, getName(id), id);
	SendClientMessage(id, -1, !"������� ������ ������� ���");
	new Float: SlapHealth;
    GetPlayerHealth(id, SlapHealth);
    SetPlayerHealthAC(id, SlapHealth - 5);
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
		    SetPlayerArmourAC(i, params[0]);
		    SCMf(i, -1,"������� ������ ����� ��� ����������", PI[playerid][pAdminNumber]);
		}
   	}
    return 1;
}
CMD:mpskin(playerid,params[]) 
{
    if(CheckAccess(playerid, 4)) return 1;
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
    if(CheckAccess(playerid, 4)) return 1;
	if(sscanf(params, "ddd", params[0], params[1], params[2])) return SCM(playerid, COLOR_LIGHTGREY, !"�����������: /mpgun [1, 2, 3] [������] [�������]");
  	else if(params[1] > 47 || params[1] < 1) return SCM(playerid, COLOR_GREY, !"������ ������ �� ����������");
    else if(params[2] > 1000 || params[2] < 1) return SCM(playerid, COLOR_GREY, !"�� ������ ���������� ������");
	if(params[1] == 35 && params[1] == 36 && params[1] == 37 && params[1] == 38 && params[1] == 39 && params[1] == 40) return SCM(playerid, COLOR_GREY, !"������ ������ �������� ������������ �������.");
	new team_1[250],team_2[250], all, team1, team2;
	new Float:x,Float:y,Float:z;
	GetPlayerPos(playerid, x,y,z);
   	for(new i = 0; i < MAX_PLAYERS; i++) 
	{
		//if(i == playerid) continue;
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
	{FFFFFF}���� �������\n\
	{FFFF99}����� ����\n\
	{FFFF99}����� ��� ��������", "�������", "�������");
}
CMD:auninvite(playerid, params[]) 
{
    if(CheckAccess(playerid, 5, 3)) return 1;
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

	SavePlayerData(params[0]);

	if(PI[params[0]][pOnCapture] == 1)
	{
		AutoKickCapture(params[0]);
		CheckCount(params[0]);
	}

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

	SavePlayerData(params[0]);

	cef_emit_event(params[0], "cef:capture:visible", CEFINT(false));

	for(new g; g <= totalgz; g++) GangZoneHideForPlayer(params[0], g);
	GangZoneStopFlashForPlayer(params[0], WarZone);

	ClearGroup(params[0]);
	return 1;
}
CMD:unjail(playerid,params[])
{
    if(CheckAccess(playerid, 2, 2)) return 1;
	if(sscanf(params,"u", params[0])) return SCM(playerid, COLOR_LIGHTGREY, !"�����������: /unjail [ID ������]");
    if(!IsPlayerConnected(params[0]))return  SCM(playerid, COLOR_GREY, !"����� �� � ����");
	if(!IsPlayerLogged{params[0]})return  SCM(playerid, COLOR_GREY, !"����� �� �����������");
	if(PI[params[0]][pDemorgan] == 0) return SCM(playerid, COLOR_GREY, !"����� �� ���������� � ���������");
	
	PI[params[0]][pDemorgan]= 0;
	PI[params[0]][pDemorganTime]= 0;

	SavePlayerData(params[0]);

	PlayerSpawn(params[0]);
	SCMf(playerid, COLOR_TOMATO, "�� ��������� ������ %s �� ���������", getName(params[0]));
	SCMf(params[0], COLOR_TOMATO, "������� ������ �������� ��� �� ���������.", PI[playerid][pAdminNumber]);
	return SendAdminsMessagef(COLOR_ADMINCHAT, "[%s #%d] %s[%d] ��������� ������ %s[%d] �� ���������", AdminName[PI[playerid][pAdmin]], PI[playerid][pAdminNumber], getName(playerid),playerid,getName(params[0]),params[0]);
}
CMD:unprison(playerid,params[])
{
    if(CheckAccess(playerid, 2, 2)) return 1;
	if(sscanf(params,"u", params[0])) return SCM(playerid, COLOR_LIGHTGREY, !"�����������: /unprison [ID ������]");
    if(!IsPlayerConnected(params[0]))return  SCM(playerid, COLOR_GREY, !"����� �� � ����");
	if(!IsPlayerLogged{params[0]})return  SCM(playerid, COLOR_GREY, !"����� �� �����������");
	if(PI[params[0]][pJail] == 0) return SCM(playerid, COLOR_GREY, !"����� �� ���������� � ������");
	
	PI[params[0]][pJail] = 0;
	PI[params[0]][pJailTime] = 0;

	SavePlayerData(params[0]);

	PlayerSpawn(params[0]);
	SCMf(playerid, COLOR_TOMATO, "�� ��������� ������ %s �� ������", getName(params[0]));
	SCMf(params[0], COLOR_TOMATO, "������� ������ �������� ��� �� ������.", PI[playerid][pAdminNumber]);
	return SendAdminsMessagef(COLOR_ADMINCHAT, "[%s #%d] %s[%d] ��������� ������ %s[%d] �� ������", AdminName[PI[playerid][pAdmin]], PI[playerid][pAdminNumber], getName(playerid),playerid,getName(params[0]),params[0]);
}
CMD:givevb(playerid, params[])
{
    if(CheckAccess(playerid, 5, 3)) return 1;
    if(sscanf(params,"u",params[0])) return SCM(playerid, COLOR_LIGHTGREY, !"�����������: /givevb [ID ������]");
	else if(PI[params[0]][pMilitaryID]) return SCM(playerid, COLOR_GREY,"� ������ ��� ������� ������� �����!");
	PI[params[0]][pMilitaryID] = 1;
	SCMf(params[0], COLOR_WHITE, "������� ������ ����� ��� ������� �����.", PI[playerid][pAdminNumber]);
	return SendAdminsMessagef(COLOR_ADMINCHAT, "[%s #%d] %s[%d] ����� ������ %s[%d] ������� �����",\
		AdminName[PI[playerid][pAdmin]], PI[playerid][pAdminNumber], getName(playerid), playerid, getName(params[0]), params[0]);
}
CMD:agivelic(playerid,params[])
{
    if(CheckAccess(playerid, 3, 2)) return 1;
	if(sscanf(params, "u", params[0])) return SCM(playerid, COLOR_LIGHTGREY, !"�����������: /agivelic [ID ������]");
	if(!IsPlayerConnected(params[0])) return SCM(playerid, COLOR_GREY, !"����� �� � ����");
	if(!IsPlayerLogged{params[0]}) return SCM(playerid, COLOR_GREY, !"����� �� �����������");
	PI[params[0]][pDriveLicense] = 1;
	if(PI[params[0]][pLicNumber] == 0) PI[params[0]][pLicNumber] = RandomEX(1111111, 6666666);
	SCM(params[0], -1, !"������� ������ ����� ��� ������������ �����");
	return SendAdminsMessagef(COLOR_ADMINCHAT, "[%s #%d] %s ����� ������������ ����� %s", AdminName[PI[playerid][pAdmin]], PI[playerid][pAdminNumber], getName(playerid),getName(params[0]));
}
CMD:jail(playerid,params[])
{
    if(CheckAccess(playerid, 2, 2)) return 1;
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
	mysql_string[0] = EOS, mf(mysql, mysql_string, 70, "SELECT * FROM `banlist` WHERE `name` = '%e'",params[0]);
	mysql_function_query(mysql, mysql_string, true, "UnbanAccount", "is", playerid, params[0]);
	return 1;
}
CMD:offgm(playerid,params[]) 
{
    if(CheckAccess(playerid, 8)) return 1;
	if(sscanf(params, "s[24]", params[0])) return SCM(playerid, COLOR_LIGHTGREY, !"�����������: /offgm [���]");
	mysql_string[0] = EOS, mf(mysql, mysql_string, 70, "SELECT * FROM `accounts` WHERE `Name` = '%e'",params[0]);
	mysql_function_query(mysql, mysql_string, true, "OffGM", "is", playerid, params[0]);
	return 1;
}
CMD:offleader(playerid,params[]) 
{
    if(CheckAccess(playerid, 5)) return 1;
	if(sscanf(params, "s[24]", params[0])) return SCM(playerid, COLOR_LIGHTGREY, !"�����������: /offleader [���]");
	mysql_string[0] = EOS, mf(mysql, mysql_string, 70, "SELECT * FROM `accounts` WHERE `Name` = '%e'",params[0]);
	mysql_function_query(mysql, mysql_string, true, "OffLeader", "is", playerid, params[0]);
	return 1;
}
//======================================= [ dialogs ] =============================//
stock admins_OnDialogResponse(playerid, dialogid, response, listitem)
{
	switch(dialogid) 
	{
		case 8000: 
		{
            if(!response) return 1;
            if(response) 
			{
             	new i = GetPVarInt(playerid, "AdmID");
   				switch(listitem) 
				{
	                case 0: 
					{
	                    PI[i][pAdmin] = 0;
	                    PI[i][pVIP] = 0;
	                    SCM(playerid, COLOR_YELLOW, !"�� ���� ����� � ����� �������� �������!");
	                    SCMf(i, COLOR_YELLOW, "������� ������ %s ���� ��� � ��������� �������� �������", getName(playerid));
	                    UpdatePlayerDataInt(i, "Admin", PI[i][pAdmin]);
						UpdatePlayerDataInt(i, "vip", PI[i][pVIP]);
	                }
	                case 1: 
					{
	                    PI[i][pAdmin] = 1;
	                    SCMf(playerid, COLOR_YELLOW, "�� �������� ������� �������� ������� ��� %s[%d], ������ �� 'NGM'", PI[i][pName], i);
	                    SCM(i, COLOR_YELLOW, "������� ������ ������� ��� ������� �� NGM");
	                    UpdatePlayerDataInt(i, "Admin", PI[i][pAdmin]);
	                }
	                case 2: 
					{
	                    PI[i][pAdmin] = 2;
	                    SCMf(playerid, COLOR_YELLOW, "�� �������� ������� �������� ������� ��� %s[%d], ������ �� 'JRGM'", PI[i][pName], i);
	                    SCM(i, COLOR_YELLOW, "������� ������ ������� ��� ������� �� JRGM");
	                    UpdatePlayerDataInt(i, "Admin", PI[i][pAdmin]);
	                }
	                case 3: 
					{
	                    PI[i][pAdmin] = 3;
	                    SCMf(playerid, COLOR_YELLOW, "�� �������� ������� �������� ������� ��� %s[%d], ������ �� 'GM'", PI[i][pName], i);
	                    SCM(i, COLOR_YELLOW, "������� ������ ������� ��� ������� �� GM");
	                    UpdatePlayerDataInt(i, "Admin", PI[i][pAdmin]);
	                }
	                case 4: 
					{
	                    PI[i][pAdmin] = 4;
	                    SCMf(playerid, COLOR_YELLOW, "�� �������� ������� �������� ������� ��� %s[%d], ������ �� 'GM+'", PI[i][pName], i);
	                    SCM(i, COLOR_YELLOW, "������� ������ ������� ��� ������� �� GM+");
	                    UpdatePlayerDataInt(i, "Admin", PI[i][pAdmin]);
	                }
	                case 5: 
					{
	                    PI[i][pAdmin] = 5;
	                    SCMf(playerid, COLOR_YELLOW, "�� �������� ������� �������� ������� ��� %s[%d], ������ �� 'LGM'", PI[i][pName], i);
	                    SCM(i, COLOR_YELLOW, "������� ������ ������� ��� ������� �� LGM");
	                    UpdatePlayerDataInt(i, "Admin", PI[i][pAdmin]);
	                }
	                case 6: 
					{
	                    PI[i][pAdmin] = 6;
	                    SCMf(playerid, COLOR_YELLOW, "�� �������� ������� �������� ������� ��� %s[%d], ������ �� 'SGM'", PI[i][pName], i);
	                    SCM(i, COLOR_YELLOW, "������� ������ ������� ��� ������� �� SGM");
	                    UpdatePlayerDataInt(i, "Admin", PI[i][pAdmin]);
	                }
	                case 7: 
					{
	                    PI[i][pAdmin] = 7;
	                    SCMf(playerid, COLOR_YELLOW, "�� �������� ������� �������� ������� ��� %s[%d], ������ �� 'SGM+'", PI[i][pName], i);
	                    SCM(i, COLOR_YELLOW, "������� ������ ������� ��� ������� �� SGM+");
	                    UpdatePlayerDataInt(i, "Admin", PI[i][pAdmin]);
	                }
	                case 8: 
					{
	                    PI[i][pAdmin] = 8;
	                    SCMf(playerid, COLOR_YELLOW, "�� �������� ������� �������� ������� ��� %s[%d], ������ �� 'DEV'", PI[i][pName], i);
	                    SCM(i, COLOR_YELLOW, "������� ������ ������� ��� ������� �� DEV");
	                    UpdatePlayerDataInt(i, "Admin", PI[i][pAdmin]);
	                }
				}
				SavePlayerData(i);
				if(PI[i][pAdmin] >= 1) Iter_Add(Admin, playerid);
				if(PI[playerid][pAdminNumber] == 0) PI[playerid][pAdminNumber] = random(9999);
			}
        }
		case 4385:
        {
            if(response)
            {
                switch(listitem)
                {
					case 0: SetPlayerPos(playerid, -2496.6514,187.7827,55.7560);
                    case 1: SetPlayerPos(playerid, -506.5684,-1417.5021,56.2231+4);
                    case 2: SetPlayerPos(playerid, 2303.4346,-1722.0289,36.8250);
                    case 3: SetPlayerPos(playerid, 1880.3647,1180.8679,38.8619);
                    case 4: SetPlayerPos(playerid, 2386.1399,-938.3940,14.3443);
                    case 5: SetPlayerPos(playerid, 1429.7269,2343.9487,22.1195+2); // ����
                    case 6: SetPlayerPos(playerid, 2224.7097,-2611.0547,31.8857+2);
                    case 7: SetPlayerPos(playerid, -317.5424,-1055.9333,51.3935+2);
                    case 8: SetPlayerPos(playerid, 1907.1965,-2226.8005,43.2401+2);
                    case 9: SetPlayerPos(playerid, 2403.2986,-1849.3372,21.9369+2);
					case 10: SetPlayerPos(playerid, 2113.0063,1821.8636,23.0438+2);
                    case 11: SetPlayerPos(playerid, -2586.5540,309.6096,20.9953+2);
					case 12: SetPlayerPos(playerid, 1812.3840,2095.7266,28.6875+2); // �����
                    case 13: SetPlayerPos(playerid, 2336.7915,-1803.0875,33.1497+2);
                    case 14: SetPlayerPos(playerid, 2782.3528,2698.6128,16.7200+2);
                    case 15: SetPlayerPos(playerid, 1880.3647,1180.8679,38.8619+2);
					case 16: SetPlayerPos(playerid, 2500.6553,-716.2165,28.3000+2);
					case 17: SetPlayerPos(playerid, 1474.5935,2045.2124,24.0309+2);
					case 18: SetPlayerPos(playerid, 1581.1870,-1199.6599,14.9259+2);
					case 19: SetPlayerPos(playerid, 2095.6086,1560.5791,-46.5100);
					case 20: SetPlayerPos(playerid, -2634.9954,-2385.7825,14.0381);
                }
				SetPlayerVirtualWorld(playerid,0);
				SetPlayerInterior(playerid,0);
				SetPlayerHealthAC(playerid, 200);
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
				mysql_string[0] = EOS, mf(mysql, mysql_string, 86, "SELECT * FROM `group` WHERE `fraction` = '%d' AND `skin_m` = %d", PI[id][pMember], PI[id][pOrgSkin]);
				mysql_function_query(mysql, mysql_string, true, "SetPlayerStandartGroup", "d", id);

				UpdatePlayerDataInt(playerid, "skinm", PI[playerid][pOrgSkin]);
				SetPlayerSkinAC(id,PI[id][pOrgSkin]);

				if(PI[id][pMember] == 5 || PI[id][pMember] == 6 || PI[id][pMember] == 7) for(new g; g <= totalgz; g++) GangZoneShowForPlayer(id, g, GetGZFrac(g));

    			ShowPlayerDialogf(id, 0, DIALOG_STYLE_MSGBOX, !"{ee3366}���������", "�������", "�������", "{FFFFFF}�����������! �� ���� ��������� ������� ����������� %s\n\n������ ��� ���������� �������� � ������ ������� ���������. ��� ����� ��������\n�� ����� �������� ����� ��������� ������ ����:{F7E19C}vk.com/"VK"", Fraction_Name[PI[id][pMember]]);

				SendAdminsMessagef(COLOR_ADMINCHAT, "[%s #%d] %s[%d] �������� %s[%d] �� ��������� ������ ����������� '%s'", AdminName[PI[playerid][pAdmin]], PI[playerid][pAdminNumber], PI[playerid][pName],playerid,PI[id][pName], id, Fraction_Name[PI[id][pMember]]);

				CheckGangWar(playerid);
				SetPlayerTeam(id, PI[id][pMember]);
				SavePlayerData(id);

				if(PI[id][pOnCapture] == 1)
				{
					AutoKickCapture(id);
					CheckCount(id);
				}

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
				
				mysql_string[0] = EOS, mf(mysql, mysql_string, 71, "SELECT * FROM `group` WHERE `fraction` = '%d' AND `default` = 1", PI[id][pMember]);
				mysql_function_query(mysql, mysql_string, true, "SetPlayerStandartGroup", "d", id);

				SavePlayerData(id);

				if(PI[id][pOnCapture] == 1)
				{
					AutoKickCapture(id);
					CheckCount(id);
				}
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
						if(army_wh[2] == 0) army_wh[2] = 1;
						else army_wh[2] = 0;

						SendAdminsMessagef(COLOR_ADMINCHAT, "[%s #%d] %s[%d] %s ����� ����������� '�������� �����'",\
							AdminName[PI[playerid][pAdmin]], PI[playerid][pAdminNumber], PI[playerid][pName], playerid, army_wh[2] ? ("������") : ("������"));
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
	if(sscanf(params,"ud",params[0], params[1])) return SCM(playerid, COLOR_LIGHTGREY, !"�����������: /givemoney [id] [ammount]");
    if(!IsPlayerConnected(params[0])) return  SCM(playerid, COLOR_GREY, !"����� �� � ����");
	if(!IsPlayerLogged{params[0]}) return SCM(playerid, COLOR_GREY, !"����� �� �����������");
	if(params[1] > 5000000)return  SCM(playerid, COLOR_GREY, !"����� ������ ������ �� 1 �� 5000000 ���");
    SetPVarInt(playerid,"givemoney",gettime() + 59);
	GivePlayerMoneyLog(params[0], params[1]);
	SCMf(params[0], COLOR_YELLOW, "������� ������ ����� ��� %d ������", params[1]);
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
CMD:freeze(playerid, params[]) 
{
    if(CheckAccess(playerid)) return 1;
    if(sscanf(params, "i", params[0])) return SCM(playerid, COLOR_LIGHTGREY, !"�����������: /freeze [ID ������]");
    if(!IsPlayerConnected(params[0])) return SCM(playerid, COLOR_GREY, !"����� �� ������");
    if(GetPVarInt(playerid,"Freeze") == 0) 
	{
        SetPVarInt(playerid,"Freeze", 1);
        TogglePlayerControllable(params[0], 0);
        SCMf(params[0], -1, "������� ������ ��������� ���");
        SCMf(playerid, COLOR_GREY, "�� ���������� ������ %s[%d]", getName(params[0]), params[0]);
    }
    else 
	{
         DeletePVar(playerid, "Freeze");
         TogglePlayerControllable(params[0], 1);
         SCMf(params[0], -1, "������� ������ ���������� ���");
         SCMf(playerid, COLOR_GREY, "�� ����������� ������ %s[%d]", getName(params[0]), params[0]);
    }
    return 1;
}
CMD:spawncars(playerid, params[])
{
    if(CheckAccess(playerid)) return 1;
	if(sscanf(params, "d", params[0])) return SCM(playerid, COLOR_LIGHTGREY, !"�����������: /spawncars [id ������]");
	return SetVehicleToRespawn(params[0]);
}
CMD:cc(playerid) 
{
    if(CheckAccess(playerid, 2)) return 1;

	if(GetPVarInt(playerid, "Counting_CC") > gettime()) return SCM(playerid, COLOR_GREY, !"������� ����� ������������ ��� � 2 ������");
	SetPVarInt(playerid, "Counting_CC", gettime() + 120);

	for(new i; i < 90; i++) SendClientMessageToAll(0xFFFFFFFF,"");
	return SendClientMessageToAll(-1, "������� ������ ������� ���");
}
CMD:banip(playerid, params[]) 
{
    if(CheckAccess(playerid, 6)) return 1;
  	if(sscanf(params, "s[16]", params[0])) return SCM(playerid, COLOR_LIGHTGREY, !"�����������: /banip [ip]");
  	new string[24];
  	format(string, sizeof(string), "banip %s", params[0]);
  	SendRconCommand(string);
  	SCMf(playerid, COLOR_TOMATO, "IP-������ ('%d') ������������", params[0]);
	return 1;
}
CMD:unbanip(playerid, params[]) 
{
    if(CheckAccess(playerid, 7)) return 1;
  	if(sscanf(params, "s[16]", params[0])) return SCM(playerid, COLOR_LIGHTGREY, !"�����������: /unbanip [ip]");
  	new string[24];
  	format(string, sizeof(string), "unbanip %s", params[0]);
  	SendRconCommand(string);
  	SCMf(playerid, COLOR_TOMATO, "IP-������ ('%d') �������������", params[0]);
	return 1;
}
CMD:ahp(playerid, params[]) 
{
    if(CheckAccess(playerid, 3)) return 1;
	new Float:radius;
	if (sscanf(params, "f", radius)) return SCM(playerid, COLOR_LIGHTGREY, !"�����������: /ahp [������]");
	new Float:player_x, Float:player_y, Float:player_z;
	for(new players = 0; players < MAX_PLAYERS; players++) 
	{
		GetPlayerPos(players, player_x, player_y, player_z);
		if(IsPlayerInRangeOfPoint(playerid, radius, player_x, player_y, player_z)) 
		{
			SetPlayerHealthAC(players, 100.0);
			SCMf(players, -1, "������� ������ ������� ��� ��������");
		}
	}
	return 1;
}
cmd:givegod(playerid, params[]) 
{
    if(CheckAccess(playerid, 4)) return 1;
    if(sscanf(params, "d", params[0]))	return SCM(playerid, COLOR_LIGHTGREY, !"�����������: /givegod [ID ������]");
	switch(PI[params[0]][pAdminStatus]) 
	{
		case 0: 
		{
    	    PI[params[0]][pAdminStatus] = 1;
			SetPlayerHealthAC(params[0], 200.0);
			if(PI[params[0]][pAdmin] >= 1) for(new i = 0; i < MAX_PLAYERS; i++) ShowPlayerNameTagForPlayer(i, params[0], false);
			SendAdminsMessagef(COLOR_ADMINCHAT, "[%s #%d] %s[%d] ����� ����� ������� �������� ��� %s", AdminName[PI[playerid][pAdmin]], PI[playerid][pAdminNumber], getName(playerid),playerid,getName(params[0]));
		}
		case 1: 
		{
    	    PI[params[0]][pAdminStatus] = 0;
			SetPlayerHealthAC(params[0], 176.0);
			if(PI[params[0]][pAdmin] >= 1) for(new i = 0; i < MAX_PLAYERS; i++) ShowPlayerNameTagForPlayer(i, params[0], true);
			SendAdminsMessagef(COLOR_ADMINCHAT, "[%s #%d] %s[%d] ���� ����� ������� �������� ��� %s", AdminName[PI[playerid][pAdmin]], PI[playerid][pAdminNumber], getName(playerid),playerid,getName(params[0]));
		}
	}
	return 1;
}
cmd:stopwar(playerid) 
{
    if(CheckAccess(playerid, 5)) return 1;
	SetPVarInt(playerid,"frac", playerid);
	return ShowPlayerDialog(playerid, 7610, DIALOG_STYLE_LIST, "{ee3366}�������� �����������", "1. ��������\n2. ������\n3. ��������", "�������", "������");
}
CMD:setstat(playerid, params[]) 
{
    if(CheckAccess(playerid, 8)) return 1;
    new id, idf, amount;
    if(sscanf(params,"udd",id,idf,amount)) 
	{
		SCM(playerid, COLOR_LIGHTGREY, !"�����������: /setstat [ID] [ID-�������] [���-��]");
		ShowPlayerDialog(playerid, 0, DIALOG_STYLE_MSGBOX, !"{ee3366}���������", "\
		{FFFFFF}������� �1 - �������� �� ������\n\
		������� �2 - �������� �� ������ ���\n\
		������� �3 - �������� �� ���-�����\n\
		������� �4 - �������� �� �����-������\n\
		������� �5 - �������� �� ���������� �����\n\
		������� �6 - �������� �� ���������� ������\n\
		������� �7 - �������� �� ���������� �������\n\
		������� �8 - �������� �� ���������� �������\n\
		������� �9 - �������� �� ���������� �����������������\n\
		������� �10 - �������� �� �������\n\
		������� �11 - �������� �� ���������� �������\n\
		������� �12 - �������� �� ������� �������", "�������", "");
		return 1;
	}
	static text[35];
	switch(idf) 
	{
		case 0: 
		{
			return ShowPlayerDialog(playerid, 0, DIALOG_STYLE_MSGBOX, !"{ee3366}���������", "\
			{FFFFFF}������� �1 - �������� �� ������\n\
			������� �2 - �������� �� ������ ���\n\
			������� �3 - �������� �� ���-�����\n\
			������� �4 - �������� �� �����-������\n\
			������� �5 - �������� �� ���������� �����\n\
			������� �6 - �������� �� ���������� ������\n\
			������� �7 - �������� �� ���������� �������\n\
			������� �8 - �������� �� ���������� �������\n\
			������� �9 - �������� �� ���������� �����������������\n\
			������� �10 - �������� �� �������\n\
			������� �11 - �������� �� ���������� �������\n\
			������� �12 - �������� �� ������� �������", "�������", "");
		}
	    case 1:	GivePlayerMoneyLog(id,amount), text = "������";
	    case 2: {
			PI[id][pVIP] = amount;
			UpdatePlayerDataInt(id, "vip", PI[id][pVIP]);
			text = "���";
	    }
	    case 3: {
	        PI[id][pNumber] = amount;
			UpdatePlayerDataInt(id, "number", PI[id][pNumber]);
			text = "����� ��������";
	    }
	    case 4: {
	        PI[id][pDonate] = amount;
			UpdatePlayerDataInt(id, "Donate", PI[id][pDonate]);
			text = "�����-������";
	    }
	    case 5: {
	        PI[id][pMask] = amount;
			UpdatePlayerDataInt(id, "mask", PI[id][pMask]);
			text = "�����";
	    }
	    case 6: {
	        PI[id][pAmmo] = amount;
			UpdatePlayerDataInt(id, "patr", PI[id][pAmmo]);
			text = "�������";
	    }
	    case 7: {
	        PI[id][pMetall] = amount;
			UpdatePlayerDataInt(id, "met", PI[id][pMetall]);
			text = "������";
	    }
	    case 8: {
	        PI[id][pDrugs] = amount;
			UpdatePlayerDataInt(id, "drugs", PI[id][pDrugs]);
			text = "��������";
	    }
	    case 9: {
         	PI[id][pRespect] = amount;
			UpdatePlayerDataInt(id, "Respect", PI[id][pRespect]);
			text = "�����������������";
	    }
		case 10: {
         	PI[id][pPhone] = amount;
			UpdatePlayerDataInt(id, "phone", PI[id][pPhone]);
			text = "�������";
	    }
		case 11: {
         	PI[id][pHealPack] = amount;
			UpdatePlayerDataInt(id, "healthchest", PI[id][pHealPack]);
			text = "�������";
	    }
		case 12: {
         	PI[id][pLevel] = amount;
			UpdatePlayerDataIntName(id, "Level", PI[id][pLevel]);
			SetPlayerScore(id,PI[id][pLevel]);
			text = "�������";
	    }
	}
	SendAdminsMessagef(COLOR_ADMINCHAT, "[%s #%d] %s[%d] ������� ������ %s �������� '%s' �� %d", AdminName[PI[playerid][pAdmin]], PI[playerid][pAdminNumber], getName(playerid),playerid,PI[id][pName],text,amount);
	return SavePlayerData(id);
}
CMD:bangun(playerid,params[])
{
    if(CheckAccess(playerid, 3)) return 1;
	new id,day,reason[32];
	if(sscanf(params,"uds[100]",id,day,reason)) return SCM(playerid, COLOR_LIGHTGREY, !"�����������: /bangun [ID ������] [���] [�������]");
    if(!IsPlayerConnected(id))return  SCM(playerid, COLOR_GREY, !"����� �� � ����");
	if(!IsPlayerLogged{id})return  SCM(playerid, COLOR_GREY, !"����� �� �����������");
	if(day < 1 || day > 30) return SCM(playerid, COLOR_GREY,"������ ������ 1 ��� � ������ 30 ����");
    if(PI[id][pAdmin] > PI[playerid][pAdmin]) return SCM(playerid, COLOR_GREY, !"������ ��������� � �������� �������");

	if(PI[params[0]][pOnCapture] == 1)
	{
		AutoKickCapture(params[0]);
		CheckCount(params[0]);
	}

	PI[id][pWeaponLock] = day;
	UpdatePlayerDataInt(id, "bangun", PI[id][pWeaponLock]);
	SendClientMessagef(id, COLOR_TOMATO, "������� ������ ������������ ��� ������������� ������ �� %d ��. �������: %s", day, reason);
	SendAdminsMessagef(COLOR_ADMINCHAT, "[%s #%d] %s[%d] ������������ ������ %s ������������� ������ �� %d ��. �������: %s", AdminName[PI[playerid][pAdmin]], PI[playerid][pAdminNumber], getName(playerid), playerid, getName(id), day, reason);
	return ResetPlayerWeapons(id);
}
CMD:unbangun(playerid,params[])
{
    if(CheckAccess(playerid, 3)) return 1;
	if(sscanf(params,"u",params[0])) return SCM(playerid, COLOR_LIGHTGREY, !"�����������: /unbangun [ID ������]");
    if(!IsPlayerConnected(params[0]))return  SCM(playerid, COLOR_GREY, !"����� �� � ����");
	if(!IsPlayerLogged{params[0]})return  SCM(playerid, COLOR_GREY, !"����� �� �����������");
	PI[params[0]][pWeaponLock] = 0;
	UpdatePlayerDataInt(params[1], "bangun", PI[params[1]][pWeaponLock]);
	SendAdminsMessagef(COLOR_ADMINCHAT, "[%s #%d] %s[%d] ���� ���������� �� ������������� ������ ������ %s", AdminName[PI[playerid][pAdmin]], PI[playerid][pAdminNumber], getName(playerid), playerid, getName(params[0]));
	return SendClientMessagef(playerid, COLOR_TOMATO, "������� ������ ���� ��� ���������� �� ������������� ������");
}
CMD:prison(playerid, params[]) 
{
    if(CheckAccess(playerid, 2)) return 1;
    if(sscanf(params, "d", params[0])) return SCM(playerid, COLOR_GREY,"����������� /prison [ID ������]");
    if(!IsPlayerLogged{params[0]}) return SCM(playerid, COLOR_GREY, !"����� �� �����������");
    if(PI[params[0]][pAdmin] != 0) return SCM(playerid, COLOR_GREY,"�� �� ������ ������ ��������� �������� �������");
    if(params[0] == playerid) return SCM(playerid, COLOR_GREY,"�� �� ������ ������ ��������� ������ ����");
    SetPVarInt(playerid, "PrisonID", params[0]);

	new str_1[27 + MAX_PLAYER_NAME];
	format(str_1,sizeof(str_1),"{ee3366}�������� %s[ID: %d]", getName(params[0]), params[0]);

    ShowPlayerDialogf(playerid, 5213, DIALOG_STYLE_TABLIST_HEADERS, str_1, "��������", "������", "\
		�\t\t\t��������\t\t\t�������\n\
	    1\tDM\t\t\t\t/jail %d 15 DM (�. 1.1)\n\
	    2\tNonRP Drive\t\t\t\t/jail %d 30 NonRP Drive (�. 1.19)\t\n\
	    3\tDriveBy\t\t\t\t/jail %d 10 DriveBy (� 1.4)\n\
		4\t������\t\t\t\t/jail %d 30 ������ (� 1.7)\n\
		5\t������ ������\t\t\t\t/jail %d 15 ������ ������ (� 1.9)\n\
		6\t������ �� ��������\t\t\t\t/jail %d 15 ������ �� �������� (� 1.22)\n\
		7\t������ � ��������� ���\t\t\t\t/vmute %d 10 ������ (� 2.9)\n\
		8\tTeamKill\t\t\t\t/jail %d 5 TeamKill (� 1.7)\n\
		9\t����������� ����\t\t\t\t/ban %d 1 ����������� ���� (� 1.25)\n\
		10\t����������� ��\t\t\t\t/mute %d 120 ����������� �� (� 1.25)\n\
		11\t������� ��������� ��������\t\t\t\t/ban %d 1 ������� (� 2.6)\n\
		12\t���� � ��������� ���\t\t\t\t/mute %d 15 ���� (� 2.5)\n\
		13\t������ � ������\t\t\t\t/mute %d 15 ������ (� 2.5)\n\
		14\tAFK �� ����� ���\t\t\t\t/jail %d 25 AFK � ��� (� 1.5)\n\
		15\tMG � ��������� ���\t\t\t\t/mute %d 10 MG (� 2.7)\n\
		16\tMG � ��������� ���\t\t\t\t/vmute %d 10 MG (� 2.10)\n\
		17\t������������� ���������� ��\t\t\t\t/jail %d 120 ���� / ������� (� 1.6)\n\
		18\tPowerGaming\t\t\t\t/jail %d 15 PowerGaming (� 1.12)\n\
		19\tNonRP /me\t\t\t\t/jail %d 5 NonRP /me (� 1.25)\n\
		20\tNonRP /sleep\t\t\t\t/kick %d NonRP /sleep (� 1.39)\n\
		21\t��������� � ��������� ���\t\t\t\t/vmute %d 20 ������������ ��������� (� 2.10)", params[0], params[0], params[0], params[0], params[0], params[0], params[0], params[0], params[0], params[0], params[0], params[0], params[0], params[0], params[0], params[0], params[0], params[0], params[0], params[0]);
    return 1;
}
CMD:punishment(playerid, params[]) 
{
	if(CheckAccess(playerid, 3)) return 1;
    if(sscanf(params, "d", params[0])) return SCM(playerid, COLOR_LIGHTGREY, !"�����������: /punishment [ID ������]");
    if(!IsPlayerConnected(params[0]))return  SCM(playerid, COLOR_GREY, !"������� ID ��� �� �������");
	if(!IsPlayerLogged{params[0]}) return SCM(playerid, COLOR_GREY, !"������ ����� �� ������ �����������");
	mysql_string[0] = EOS, mf(mysql, mysql_string, 70, "SELECT * FROM `punishment` WHERE `name` = '%e'", getName(params[0]));
 	mysql_function_query(mysql, mysql_string, true, "GetPunishment", "d", playerid);
	return 1;
}
CMD:atw(playerid, params[])
{
    if(CheckAccess(playerid, 3)) return 1;
	new Float:radius;
	if (sscanf(params, "f", radius)) return  SCM(playerid, COLOR_LIGHTGREY, !"�����������: /atw [������]");
	new Float:player_x, Float:player_y, Float:player_z;
	for(new players = 0; players < MAX_PLAYERS; players++) 
	{
		GetPlayerPos(players, player_x, player_y, player_z);
		if(IsPlayerInRangeOfPoint(playerid, radius, player_x, player_y, player_z)) 
		{
			ResetPlayerWeapons(players);
			SCMf(players, -1, "������� ������ ����� ���� ������");
		}
	}
	SCM(playerid, COLOR_GREY, "�� ������ ������ � ������� � ������������� �������.");
	return 1;
}
CMD:editmp(playerid) 
{
    if(CheckAccess(playerid, 4)) return 1;
	if(MPStatus == false) return SCM(playerid, COLOR_GREY,"����������� �� �������. (/setmp)");

	new playerOnMP;
    for(new i = 0; i < MAX_PLAYERS; i++) 
	{
        if(!IsPlayerConnected(i)) continue;
        if(PI[i][pOnMP] == 1) playerOnMP++;
    }

	return ShowPlayerDialogf(playerid, 5898, DIALOG_STYLE_LIST, 
								!"{ee3366}��������� ��", 
								!"�������", !"�������", 
								"1. �������� ������� ���������\n\
								2. ������ ������ � �������\n\
								3. ������ ������ � �������\n\
								4. ������ ���������� � �������\n\
								5. ������ �������� � �������\n\
								6. �������� ���������\t\t\t%s\n\
								{FFFF99}��������� ��\n\
								{FFFF99}��������� �� (��� ��������)\n\
								{FFFF99}������� �� ��: %d", 
									MPTeamKill ? ("{4eaa77}��������{FFFFFF}") : ("{ce6c4f}���������{FFFFFF}"),
									playerOnMP);
}
CMD:setmp(playerid)
{
    if(CheckAccess(playerid, 4)) return 1;
	if(MPStatus == false) 
	{
		GetPlayerPos(playerid, gomp_pos[0], gomp_pos[1], gomp_pos[2]);

        MPStatus = true;
		MPTeamKill = false;

		SendAdminsMessagef(COLOR_ADMINCHAT, "[%s #%d] %s[%d] ������ ����� ��������� �� �����������", AdminName[PI[playerid][pAdmin]], PI[playerid][pAdminNumber], getName(playerid), playerid);
		
		PI[playerid][pAdminEvents]++;
		UpdatePlayerDataInt(playerid, "AdminEvents", PI[playerid][pAdminEvents]);
	}
	else SCM(playerid, COLOR_GREY, !"����� ��������� ��� �������, ��������: /editmp");
	return 1;
}
CMD:offmute(playerid, params[]) 
{
    if(CheckAccess(playerid, 4)) return 1;
    new param_name[24],param_reason[32],param_time;
    if(sscanf(params, "s[24]ds[32]", param_name,param_time,param_reason)) return SCM(playerid, COLOR_LIGHTGREY, !"�����������: /offmute [���] [�����] [�������]");
    foreach(Player, i) {
        new szName[64];
        if(!IsPlayerConnected(i)) continue;
        GetPlayerName(i,szName,64);
        if(!strcmp(param_name, szName, false)) return SCM(playerid, COLOR_GREY, !"���� ����� � ����, ����������� /mute");
    }
	SetPVarString(playerid, "roffmute",param_reason);
	SetPVarInt(playerid, "offmutetime", param_time);
	mysql_string[0] = EOS, mf(mysql, mysql_string, 70, "SELECT * FROM `accounts` WHERE `Name` = '%e'", param_name);
    mysql_function_query(mysql, mysql_string, true, "OffMute", "i", playerid);
	return 1;
}
callback: OffMute(playerid) 
{
    new rows, fields, temp[32], reason[32], time;
    cache_get_data(rows, fields);
    if(!rows) return SCM(playerid, COLOR_GREY, !"������ ������ ���");
    if(rows) 
	{
	    new names[24], mute, mutetime, admin;
	    cache_get_field_content(0, "Name", names, mysql);
		cache_get_field_content(0, "mute", temp), mute = strval (temp);
		cache_get_field_content(0, "mutetime", temp), mutetime = strval (temp);
		cache_get_field_content(0, "Admin", temp), admin = strval (temp);
		if(PI[playerid][pAdmin] < 6 && admin != 0) return SCM(playerid, COLOR_GREY, !"�� �� ������ �������� ����� ������");
		GetPVarString(playerid,"roffmute", reason, 32);
		time = GetPVarInt(playerid, "offmutetime");
        SendAdminsMessagef(COLOR_ADMINCHAT, "[%s #%d] %s ������������ ��� ������ %s(�������) �� %d �����. �������: %s", AdminName[PI[playerid][pAdmin]], PI[playerid][pAdminNumber], getName(playerid), names, time, reason);
        mute = 1;
        mutetime += GetPVarInt(playerid, "offmutetime");

        mysql_string[0] = EOS, mf(mysql, mysql_string, 125, "UPDATE `accounts` SET `mute` = '%d', `mutetime` = '%d' WHERE `Name` = '%e'", mute, mutetime, names);
		mysql_function_query(mysql, mysql_string, false, "", "");
	}
	return 1;
}
CMD:offjail(playerid, params[])
{
    if(CheckAccess(playerid, 4)) return 1;
    new param_name[24],param_reason[32],param_time;
    if(sscanf(params, "s[24]ds[32]", param_name,param_time,param_reason)) return SCM(playerid, COLOR_LIGHTGREY, !"�����������: /offjail [���] [�����] [�������]");
    foreach(Player, i) 
	{
        new szName[64];
        if(!IsPlayerConnected(i)) continue;
        GetPlayerName(i,szName,64);
        if(!strcmp(param_name, szName, false)) return SCM(playerid, COLOR_GREY, !"���� ����� � ����, ����������� /jail");
    }
	SetPVarString(playerid, "roffjail",param_reason);
	SetPVarInt(playerid, "offjailtime", param_time);

	mysql_string[0] = EOS, mf(mysql, mysql_string, 70, "SELECT * FROM `accounts` WHERE `Name` = '%e'", param_name);
    mysql_function_query(mysql, mysql_string, true, "OffJail", "i", playerid);
	return 1;
}
callback: OffJail(playerid)
{
    new rows, fields, temp[32], reason[32], time;
    cache_get_data(rows, fields);
    if(!rows) return SCM(playerid, COLOR_GREY, !"������ ������ ���");
    if(rows) 
	{
	    new names[24], demorgan, demorgan_time, admin;
	    cache_get_field_content(0, "Name", names, mysql);
		cache_get_field_content(0, "demorgan", temp), demorgan = strval (temp);
		cache_get_field_content(0, "demorgan_time", temp), demorgan_time = strval (temp);
		cache_get_field_content(0, "Admin", temp), admin = strval (temp);
		if(PI[playerid][pAdmin] < 6 && admin != 0) return SCM(playerid, COLOR_GREY, !"�� �� ������ �������� ����� ������");
		GetPVarString(playerid,"roffjail", reason, 32);
		time = GetPVarInt(playerid, "offjailtime");
        SendAdminsMessagef(COLOR_ADMINCHAT, "[%s #%d] %s ������� � �������� ������ %s(�������) �� %d �����. �������: %s", AdminName[PI[playerid][pAdmin]], PI[playerid][pAdminNumber], PI[playerid][pName], names, time, reason);
        demorgan = 1;
        demorgan_time += GetPVarInt(playerid, "offjailtime");

        mysql_string[0] = EOS, mf(mysql, mysql_string, 143, "UPDATE `accounts` SET `demorgan` = '%d', `demorgan_time` = '%d', `hospital` = '0' WHERE `Name` = '%e'", demorgan, demorgan_time, names);
		mysql_function_query(mysql, mysql_string, false, "", "");
	}
	return 1;
}
CMD:offvmute(playerid, params[]) 
{
    if(CheckAccess(playerid, 4)) return 1;
    new param_name[24],param_reason[32],param_time;
    if(sscanf(params, "s[24]ds[32]", param_name,param_time,param_reason)) return SCM(playerid, COLOR_LIGHTGREY, !"�����������: /offvmute [���] [�����] [�������]");
    foreach(Player, i) 
	{
        new szName[64];
        if(!IsPlayerConnected(i)) continue;
        GetPlayerName(i,szName,64);
        if(!strcmp(param_name, szName, false)) return SCM(playerid, COLOR_GREY, !"���� ����� � ����, ����������� /vmute");
    }
	SetPVarString(playerid, "roffvmute",param_reason);
	SetPVarInt(playerid, "offvmutetime", param_time);

	mysql_string[0] = EOS, mf(mysql, mysql_string, 75, "SELECT * FROM `accounts` WHERE `Name` = '%e'", param_name);
    mysql_function_query(mysql, mysql_string, true, "OffVMute", "i", playerid);
	return 1;
}
callback: OffVMute(playerid) 
{
    new rows, fields, temp[32], reason[32], time;
    cache_get_data(rows, fields);
    if(!rows) return SCM(playerid, COLOR_GREY, !"������ ������ ���");
    if(rows) 
	{
	    new names[24], vmute, vmutetime, admin;
	    cache_get_field_content(0, "Name", names, mysql);
		cache_get_field_content(0, "vmute", temp), vmute = strval (temp);
		cache_get_field_content(0, "vmutetime", temp), vmutetime = strval (temp);
		cache_get_field_content(0, "Admin", temp), admin = strval (temp);
		if(PI[playerid][pAdmin] < 6 && admin != 0) return SCM(playerid, COLOR_GREY, !"�� �� ������ �������� ����� ������");
		GetPVarString(playerid,"roffvmute", reason, 32);
		time = GetPVarInt(playerid, "offvmutetime");
        SendAdminsMessagef(COLOR_ADMINCHAT, "[%s #%d] %s ������������ ��������� ��� ������ %s(�������) �� %d �����. �������: %s", AdminName[PI[playerid][pAdmin]], PI[playerid][pAdminNumber], getName(playerid), names, time, reason);
        vmute = 1;
        vmutetime += GetPVarInt(playerid, "offvmutetime");

        mysql_string[0] = EOS, mf(mysql, mysql_string, 129, "UPDATE `accounts` SET `vmute` = '%d', `vmutetime` = '%d' WHERE `Name` = '%e'", vmute, vmutetime, names);
		mysql_function_query(mysql, mysql_string, false, "", "");
	}
	return 1;
}
CMD:offunvmute(playerid, params[]) 
{
    if(CheckAccess(playerid, 4)) return 1;
    new param_name[24],param_reason[32];
    if(sscanf(params, "s[24]s[32]", param_name,param_reason)) return SCM(playerid, COLOR_LIGHTGREY, !"�����������: /offunvmute [���] [�������]");
    foreach(Player, i) 
	{
        new szName[64];
        if(!IsPlayerConnected(i)) continue;
        GetPlayerName(i,szName,64);
        if(!strcmp(param_name, szName, false)) return SCM(playerid, COLOR_GREY, !"���� ����� � ����, ����������� /unvmute");
    }
	SetPVarString(playerid, "roffvmute",param_reason);
	mysql_string[0] = EOS, mf(mysql, mysql_string, 70, "SELECT * FROM `accounts` WHERE `Name` = '%e'", param_name);
    mysql_function_query(mysql, mysql_string, true, "OffUnVMute", "i", playerid);
	return 1;
}
callback: OffUnVMute(playerid) 
{
    new rows, fields, temp[32], reason[32];
    cache_get_data(rows, fields);
    if(!rows) return SCM(playerid, COLOR_GREY, !"������ ������ ���");
    if(rows) 
	{
	    new names[24], vmute, vmutetime, admin;
	    cache_get_field_content(0, "Name", names, mysql);
		cache_get_field_content(0, "vmute", temp), vmute = strval (temp);
		cache_get_field_content(0, "vmutetime", temp), vmutetime = strval (temp);
		cache_get_field_content(0, "Admin", temp), admin = strval (temp);
		if(PI[playerid][pAdmin] < 6 && admin != 0) return SCM(playerid, COLOR_GREY, !"�� �� ������ �������� ����� ������");
		if(vmutetime == 0) return SCM(playerid, COLOR_GREY, !"��������� ��� ������ �� ������������");
		GetPVarString(playerid,"roffvmute", reason, 32);
        SendAdminsMessagef(COLOR_ADMINCHAT, "[%s #%d] %s ������������� ��������� ��� ������ %s(�������). �������: %s", AdminName[PI[playerid][pAdmin]], PI[playerid][pAdminNumber], getName(playerid), names, reason);
        vmute = 0;
        vmutetime = 0;

        mysql_string[0] = EOS, mf(mysql, mysql_string, 110, "UPDATE `accounts` SET `vmute` = '%d', `vmutetime` = '%d' WHERE `Name` = '%e'", vmute, vmutetime, names);
		mysql_function_query(mysql, mysql_string, false, "", "");
	}
	return 1;
}
CMD:offunjail(playerid, params[]) 
{
    if(CheckAccess(playerid, 4)) return 1;
    new param_name[24],param_reason[32];
    if(sscanf(params, "s[24]s[32]", param_name,param_reason)) return SCM(playerid, COLOR_LIGHTGREY, !"�����������: /offunjail [���] [�������]");
    foreach(Player, i) 
	{
        new szName[64];
        if(!IsPlayerConnected(i)) continue;
        GetPlayerName(i,szName,64);
        if(!strcmp(param_name, szName, false)) return SCM(playerid, COLOR_GREY, !"���� ����� � ����, ����������� /unjail");
    }
	SetPVarString(playerid, "roffjail",param_reason);

	mysql_string[0] = EOS, mf(mysql, mysql_string, 70, "SELECT * FROM `accounts` WHERE `Name` = '%e'", param_name);
    mysql_function_query(mysql, mysql_string, true, "OffUnJail", "i", playerid);
	return 1;
}
callback: OffUnJail(playerid) 
{
    new rows, fields, temp[32], reason[32];
    cache_get_data(rows, fields);
    if(!rows) return SCM(playerid, COLOR_GREY, !"������ ������ ���");
    if(rows) 
	{
	    new names[24], demorgan, demorgan_time, admin;
	    cache_get_field_content(0, "Name", names, mysql);
		cache_get_field_content(0, "demorgan", temp), demorgan = strval (temp);
		cache_get_field_content(0, "demorgan_time", temp), demorgan_time = strval (temp);
		cache_get_field_content(0, "Admin", temp), admin = strval (temp);
		if(PI[playerid][pAdmin] < 6 && admin != 0) return SCM(playerid, COLOR_GREY, !"�� �� ������ �������� ����� ������");
		GetPVarString(playerid,"roffjail", reason, 32);
        SendAdminsMessagef(COLOR_ADMINCHAT, "[%s #%d] %s �������� �� ��������� ������ %s(�������). �������: %s", AdminName[PI[playerid][pAdmin]], PI[playerid][pAdminNumber], getName(playerid), names, reason);
        demorgan = 0;
        demorgan_time = 0;

        mysql_string[0] = EOS, mf(mysql, mysql_string, 145, "UPDATE `accounts` SET `demorgan` = '%d', `demorgan_time` = '%d' WHERE `Name` = '%e'", demorgan, demorgan_time, names);
		mysql_function_query(mysql, mysql_string, false, "", "");
	}
	return 1;
}
CMD:offunmute(playerid, params[]) 
{
    if(CheckAccess(playerid, 4)) return 1;
    new param_name[24],param_reason[32];
    if(sscanf(params, "s[24]s[32]", param_name,param_reason)) return SCM(playerid, COLOR_LIGHTGREY, !"�����������: /offunmute [���] [�������]");
    foreach(Player, i) 
	{
        new szName[64];
        if(!IsPlayerConnected(i)) continue;
        GetPlayerName(i,szName,64);
        if(!strcmp(param_name, szName, false)) return SCM(playerid, COLOR_GREY, !"���� ����� � ����, ����������� /unmute");
    }
	SetPVarString(playerid, "roffmute",param_reason);

	mysql_string[0] = EOS, mf(mysql, mysql_string, 69, "SELECT * FROM `accounts` WHERE `Name` = '%e'", param_name);
    mysql_function_query(mysql, mysql_string, true, "OffUnMute", "i", playerid);
	return 1;
}
callback: OffUnMute(playerid) 
{
    new rows, fields, temp[32], reason[32];
    cache_get_data(rows, fields);
    if(!rows) return SCM(playerid, COLOR_GREY, !"������ ������ ���");
    if(rows) 
	{
	    new names[24], mute, mutetime, admin;
	    cache_get_field_content(0, "Name", names, mysql);
		cache_get_field_content(0, "mute", temp), mute = strval (temp);
		cache_get_field_content(0, "mutetime", temp), mutetime = strval (temp);
		cache_get_field_content(0, "Admin", temp), admin = strval (temp);
		if(PI[playerid][pAdmin] < 6 && admin != 0) return SCM(playerid, COLOR_GREY, !"�� �� ������ �������� ����� ������");
		GetPVarString(playerid,"roffmute", reason, 32);
        SendAdminsMessagef(COLOR_ADMINCHAT, "[%s #%d] %s ������������� ��� ������ %s(�������). �������: %s", AdminName[PI[playerid][pAdmin]], PI[playerid][pAdminNumber], getName(playerid), names, reason);
       
	    mute = 0;
        mutetime = 0;

        mysql_string[0] = EOS, mf(mysql, mysql_string, 115, "UPDATE `accounts` SET `mute` = '%d', `mutetime` = '%d' WHERE `Name` = '%e'", mute, mutetime, names);
		mysql_function_query(mysql, mysql_string, false, "", "");
	}
	return 1;
}
CMD:offwarn(playerid, params[]) 
{
    if(CheckAccess(playerid, 4)) return 1;
    new param_name[24],param_reason[32];
    if(sscanf(params, "s[24]s[32]", param_name,param_reason)) return SCM(playerid, COLOR_LIGHTGREY, !"�����������: /offwarn [���] [�������]");
    foreach(Player, i) 
	{
        new szName[64];
        if(!IsPlayerConnected(i)) continue;
        GetPlayerName(i,szName,64);
        if(!strcmp(param_name, szName, false)) return SCM(playerid, COLOR_GREY, !"���� ����� � ����, ����������� /warn");
    }
	SetPVarString(playerid, "roffwarn",param_reason);
	mysql_string[0] = EOS, mf(mysql, mysql_string, 70, "SELECT * FROM `accounts` WHERE `Name` = '%e'", param_name);
    mysql_function_query(mysql, mysql_string, true, "OffWarn", "i", playerid);
	return 1;
}
callback: OffWarn(playerid) 
{
    new rows, fields, temp[32], reason[32];
    cache_get_data(rows, fields);
    if(!rows) return SCM(playerid, COLOR_GREY, !"������ ������ ���");
    if(rows) 
	{
	    new names[24], warn, warntime, admin, member1, rank, leader;
	    cache_get_field_content(0, "Name", names, mysql);
		cache_get_field_content(0, "warn", temp), warn = strval (temp);
		cache_get_field_content(0, "warntime", temp), warntime = strval (temp);
		cache_get_field_content(0, "Admin", temp), admin = strval (temp);
		cache_get_field_content(0, "member", temp), member1 = strval (temp);
		cache_get_field_content(0, "Leader", temp), leader = strval (temp);
		cache_get_field_content(0, "rank", temp), rank = strval (temp);
		if(PI[playerid][pAdmin] < 6 && admin != 0) return SCM(playerid, COLOR_GREY, !"�� �� ������ �������� ����� ������");
		if(warn >= 2) return SCM(playerid, COLOR_GREY, !"����� ����� 2 ��������������, ����������� /offban");
		GetPVarString(playerid,"roffwarn", reason, 32);
		SetPVarString(playerid, "text_wbook", reason);

		mysql_string[0] = EOS, mf(mysql, mysql_string, 70, "SELECT * FROM `accounts` WHERE name = '%e'", names);
		mysql_function_query(mysql, mysql_string, true, "WbookOff", "is", playerid, names);

		warn++;
        SendAdminsMessagef(COLOR_ADMINCHAT, "[%s #%d] %s ����� �������������� ������ %s[%d/3](�������). �������: %s", AdminName[PI[playerid][pAdmin]], PI[playerid][pAdminNumber], getName(playerid), names, warn, reason);
        warntime += 1200;
        member1 = 0;
        leader = 0;
        rank = 0;
        admin = 0;
        mysql_string[0] = EOS, mf(mysql, mysql_string, 240, "UPDATE `accounts` SET `warn` = '%d', `warntime` = '%d', `member` = '%d', `rank` = '%d', `leader` = '%d', `Admin` = '%d' WHERE `Name` = '%e'", warn, warntime, member1, leader, rank, admin, names);
		mysql_function_query(mysql, mysql_string, false, "", "");
	}
	return 1;
}
CMD:offunwarn(playerid, params[]) 
{
    if(CheckAccess(playerid, 4)) return 1;
    new param_name[24],param_reason[32];
    if(sscanf(params, "s[24]s[32]", param_name,param_reason)) return SCM(playerid, COLOR_LIGHTGREY, !"�����������: /offunwarn [���] [�������]");
    foreach(Player, i) {
        new szName[64];
        if(!IsPlayerConnected(i)) continue;
        GetPlayerName(i,szName,64);
        if(!strcmp(param_name, szName, false)) return SCM(playerid, COLOR_GREY, !"���� ����� � ����, ����������� /unwarn");
    }
	SetPVarString(playerid, "roffwarn",param_reason);

	mysql_string[0] = EOS, mf(mysql, mysql_string, 75, "SELECT * FROM `accounts` WHERE `Name` = '%e'", param_name);
    mysql_function_query(mysql, mysql_string, true, "OffUnWarn", "i", playerid);

	return 1;
}
callback: OffUnWarn(playerid) {
    new rows, fields, temp[32], reason[32];
    cache_get_data(rows, fields);
    if(!rows) return SCM(playerid, COLOR_GREY, !"������ ������ ���");
    if(rows) 
	{
	    new names[24], warn, warntime, admin;
	    cache_get_field_content(0, "Name", names, mysql);
		cache_get_field_content(0, "warn", temp), warn = strval (temp);
		cache_get_field_content(0, "warntime", temp), warntime = strval (temp);
		cache_get_field_content(0, "Admin", temp), admin = strval (temp);
		if(PI[playerid][pAdmin] < 6 && admin != 0) return SCM(playerid, COLOR_GREY, !"�� �� ������ �������� ����� ������");
		if(warn == 0) return SCM(playerid, COLOR_GREY, !"����� �� ����� ��������������");
		GetPVarString(playerid,"roffwarn", reason, 32);
		warn--;
        SendAdminsMessagef(COLOR_ADMINCHAT, "[%s #%d] %s ���� �������������� ������ %s[%d/3](�������). �������: %s", AdminName[PI[playerid][pAdmin]], PI[playerid][pAdminNumber], getName(playerid), names, warn, reason);
        if(warn == 0) warntime = 0;
        if(warn == 1) warntime = 1200;

        mysql_string[0] = EOS, mf(mysql, mysql_string, 120, "UPDATE `accounts` SET `warn` = '%d', `warntime` = '%d' WHERE `Name` = '%e'", warn, warntime, names);
		mysql_function_query(mysql, mysql_string, false, "", "");
	}
	return 1;
}
CMD:offban(playerid, params[]) 
{
    if(CheckAccess(playerid, 5)) return 1;
    new param_name[24],param_reason[32],param_time;
    if(sscanf(params, "s[24]ds[32]", param_name, param_time, param_reason)) return SCM(playerid, COLOR_LIGHTGREY, !"�����������: /offban [���] [���] [�������]");
    foreach(Player, i) 
	{
        new szName[64];
        if(!IsPlayerConnected(i)) continue;
        GetPlayerName(i,szName,64);
        if(!strcmp(param_name, szName, false)) return SCM(playerid, COLOR_GREY, !"���� ����� � ����, ����������� /ban");
    }
	SetPVarString(playerid, "roffban",param_reason);
	SetPVarInt(playerid, "offbantime", param_time);

	mysql_string[0] = EOS, mf(mysql, mysql_string, 70, "SELECT * FROM `accounts` WHERE `Name` = '%e'", param_name);
    mysql_function_query(mysql, mysql_string, true, "OffBan", "i", playerid);
	return 1;
}
callback: OffBan(playerid) 
{
    new rows, fields, temp[32], reason[32];
    cache_get_data(rows, fields);
    if(!rows) return SCM(playerid, COLOR_GREY, !"������ ������ ���");
    if(rows) 
	{
	    new names[24], admin, member1, rank, leader, ip[32];
	    cache_get_field_content(0, "Name", names, mysql);
		cache_get_field_content(0, "Admin", temp), admin = strval (temp);
		cache_get_field_content(0, "member", temp), member1 = strval (temp);
		cache_get_field_content(0, "Leader", temp), leader = strval (temp);
		cache_get_field_content(0, "rank", temp), rank = strval (temp);
		cache_get_field_content(0, "LoginIP", ip, mysql, 32);

		if(PI[playerid][pAdmin] < 6 && admin != 0) return SCM(playerid, COLOR_GREY, !"�� �� ������ �������� ����� ������");
		else if(PI[playerid][pAdmin] < admin) return SCM(playerid, COLOR_GREY, !"�� �� ������ �������� ����� ������");

		member1 = 0;
		leader = 0;
		rank = 0;
		admin = 0;

		GetPVarString(playerid,"roffban", reason, 32);

		mysql_string[0] = EOS, mf(mysql, mysql_string, 210, "UPDATE `accounts` SET `member` = '%d', `leader` = '%d', `rank` = '%d', `Admin` = '%d' WHERE `Name` = '%e'", member1, leader, rank, admin, names);
		mysql_function_query(mysql, mysql_string, false, "", "");

		mysql_string[0] = EOS, mf(mysql, mysql_string, 250, "INSERT INTO `banlist` ( `name`,`admin`, `day`, `text`, `ip`) VALUES ( '%e', '%e', '%d', '%s', '%e')",names,getName(playerid),GetPVarInt(playerid, "offbantime"),reason,ip);
	    mysql_function_query(mysql, mysql_string, false, "", "");
	}
	return 1;
}
CMD:vw(playerid, params[]) 
{
    if(CheckAccess(playerid)) return 1;
	if(sscanf(params, "d", params[0])) return SCM(playerid, COLOR_LIGHTGREY, !"�����������: /vw [ID ������������ ����] (0 - �����������)");
	if(params[0] > 500 || params[0] < 0) return SCM(playerid, COLOR_GREY, !"ID ������������ ���� ������ ���� �� ������ 500 � �� ������ 0");
	SetPlayerVirtualWorld(playerid, params[0]);
	SendAdminsMessagef(COLOR_ADMINCHAT, "[%s #%d] %s[%d] ������� � ����������� ��� �%d", AdminName[PI[playerid][pAdmin]], PI[playerid][pAdminNumber], PI[playerid][pName], playerid, params[0]);
	return 1;
}
CMD:aname(playerid, params[])
{
    if (CheckAccess(playerid, 2)) return 1;

    new name[MAX_PLAYER_NAME + 1];
    if (sscanf(params, "s[30]", name)) 
        return SCM(playerid, COLOR_LIGHTGREY, "�����������: /aname [���]");

    mysql_string[0] = EOS, mf(mysql, mysql_string, 80, "SELECT `id` FROM `accounts` WHERE `Name` = '%e' LIMIT 1", name);
    mysql_tquery(mysql, mysql_string, "namestore_callback", "i", playerid);
    return 1;
}

forward namestore_callback(playerid);
public namestore_callback(playerid)
{
    new rows, fields;
    cache_get_data(rows, fields);

    if (!rows) 
        return SCM(playerid, COLOR_BLACK, "����� � ������ ��������� �� ������ � ���� ������.");

    new db_increment = cache_get_field_content_int(0, "id");
    new query_string[128];
    mf(mysql, query_string, sizeof(query_string), "SELECT * FROM `nickname_history` WHERE `nh_owner` = %d", db_increment);
    mysql_tquery(mysql, query_string, "_namestore_callback", "i", playerid);
    return 1;
}

forward _namestore_callback(playerid);
public _namestore_callback(playerid)
{
    new rows, fields;
    cache_get_data(rows, fields);

    if (!rows) 
        return SCM(playerid, COLOR_BLACK, "������� ��������� ������� ������ �����.");

    new str_3[512] = "{FFFF99}������ ������� - ����� ������� - ���� ��������� ��������\n\n{FFFFFF}";

    for (new j = 0; j < rows; j++)
    {
        new _nh_oldname[MAX_PLAYER_NAME], _nh_newname[MAX_PLAYER_NAME], _nh_date[20], line_string[128];
        cache_get_field_content(j, "nh_oldname", _nh_oldname, mysql, sizeof(_nh_oldname));
        cache_get_field_content(j, "nh_newname", _nh_newname, mysql, sizeof(_nh_newname));
        cache_get_field_content(j, "nh_date", _nh_date, mysql, sizeof(_nh_date));

        format(line_string, sizeof(line_string), "%s - %s - %s\n", _nh_oldname, _nh_newname, _nh_date);
        strcat(str_3, line_string);
    }
    return ShowPlayerDialog(playerid, 0, DIALOG_STYLE_MSGBOX, "{ee3366}������� ���������", str_3, "�������", "");
}
CMD:stopcapture(playerid,params[]) 
{
    if(CheckAccess(playerid, 7)) return 1;
	if(GangWarStatus == 0) return SCM(playerid, COLOR_GREY,"� ������� ����� ������ ���������� �� ���.");
	if(sscanf(params,"s[35]",params[0])) return SCM(playerid, COLOR_LIGHTGREY, !"�����������: /stopcapture [�������]");
	foreach(new i:Player)  
	{
		if(PI[i][pMember] == Command[0] || PI[i][pMember] == Command[1]) 
		{
			GangZoneHideForPlayer(i, CaptZone);
			GangZoneStopFlashForPlayer(i, WarZone);
			GangZoneHideForPlayer(i, WarZone);
			GangZoneShowForPlayer(i, WarZone, GetGZFrac(Command[1]));
			cef_emit_event(i, "cef:capture:visible", CEFINT(false));
			SCMf(i, COLOR_TOMATO, "������� ������ ��������� ������ ����������. �������: %s", params[0]);
			GangWarStatus = 0;
			PI[i][pOnCapture] = 0;
		}
	}
	ClearCapture();
    return SendAdminsMessagef(COLOR_ADMINCHAT, "[%s #%d] %s[%d] ��������� ������ ����������. �������: %s", AdminName[PI[playerid][pAdmin]], PI[playerid][pAdminNumber], getName(playerid),playerid,params[0]);
}
CMD:givecard(playerid, params[])
{
    if(CheckAccess(playerid, 5)) return 1;
    if(sscanf(params,"u",params[0])) return SCM(playerid, COLOR_LIGHTGREY, !"�����������: /givemedcard [ID ������]");
	else if(PI[params[0]][pMedCard]) return SCM(playerid, COLOR_GREY,"� ������ ��� ������� ���. �����!");
	PI[params[0]][pMedCard] = 1;
	SCM(params[0], COLOR_WHITE, "������� ������ ����� ��� ���. �����. ������ �� ������� ��������� � �����������.");
	SCMf(playerid, COLOR_GREY, "�� ������ ���. ����� ������ %s", getName(params[0]));
    return 1;
}
CMD:getcar(playerid, params[])
{
    if(CheckAccess(playerid, 3, 2)) return 1;
	else if(sscanf(params, "i", params[0])) return SCM(playerid, COLOR_LIGHTGREY, !"�����������: /getcar [Car ID]");
	new Float:x, Float:y, Float:z;
	GetPlayerPos(playerid, x, y, z);
	SetVehiclePos(params[0], x+2, y+2, z);
	return 1;
}
CMD:sethp(playerid, params[])
{
 	if(CheckAccess(playerid, 1)) return 0;
    extract params -> new player:id, Float:hp; else return SCM(playerid, COLOR_LIGHTGREY, !"�����������: /sethp [id] [ammount]");
	if(hp < 0.0) return SCM(playerid, COLOR_LIGHTGREY, !"�����������: /sethp [id] hp > 0");
    if(hp > 1000.0) return SCM(playerid, COLOR_LIGHTGREY, !"�����������: /sethp [id] hp < 1000");
    if(id == INVALID_PLAYER_ID) return 0;
	SetPlayerHealthAC(id, hp);
	if(PI[id][pHospital] != 0) PI[id][pHospital] = 0;
	SendAdminsMessagef(COLOR_ADMINCHAT, "[%s #%d] %s[%d] ����� ������ %s[%d] %.0f ��", AdminName[PI[playerid][pAdmin]], PI[playerid][pAdminNumber], getName(playerid), playerid, getName(id), id, hp);
	return 1;
}
alias:sethp("hp");
cmd:givemoneyall(playerid, params[]) 
{
    if(CheckAccess(playerid, 8)) return 0;
    if(sscanf(params, "d",params[0])) return SCM(playerid, COLOR_LIGHTGREY, !"�����������: /givemoneyall [ammount]");
	if(params[0] > 500000)return  SCM(playerid, COLOR_GREY, !"����� ������ ������ �� 1 �� 500000 ���");
	for(new i = 0; i < MAX_PLAYERS; i++) 
	{
		if(!IsPlayerConnected(i)) continue;
		GivePlayerMoneyLog(i, params[0]);
		SCMf(i, COLOR_YELLOW, "������� ������ ����� ��� %d ������", params[0]);
   	}
	SendAdminsMessagef(COLOR_ADMINCHAT, "[%s #%d] %s[%d] ����� ���� ������� %d ������", AdminName[PI[playerid][pAdmin]], PI[playerid][pAdminNumber], getName(playerid), playerid, params[0]);
	return 1;
}
cmd:givevipall(playerid, params[]) 
{
    if(CheckAccess(playerid, 8)) return 0;
    if(sscanf(params, "d",params[0])) return SCM(playerid, COLOR_LIGHTGREY, !"�����������: /givevipall [days]");
	if(params[0] > 180) return  SCM(playerid, COLOR_GREY, !"����� ������ ������ �� 1 �� 180 ���� �����");
	for(new i = 0; i < MAX_PLAYERS; i++) 
	{
		if(!IsPlayerConnected(i)) continue;
		GivePlayerMoneyLog(i, params[0]);
		SCMf(i, COLOR_YELLOW, "������� ������ ����� ��� �������+ �� %d ����", params[0]);
   	}
	SendAdminsMessagef(COLOR_ADMINCHAT, "[%s #%d] %s[%d] ����� ���� ������� �������+ �� %d ����", AdminName[PI[playerid][pAdmin]], PI[playerid][pAdminNumber], getName(playerid), playerid, params[0]);
	return 1;
}
CMD:tpcor(playerid, params[]) 
{
    if(CheckAccess(playerid)) return 1;
    new Float:tpX, Float:tpY, Float:tpZ;
    if(sscanf(params, "fff", tpX, tpY, tpZ)) return SCM(playerid, COLOR_LIGHTGREY, !"�����������: /tpcor [X] [Y] [Z]");
    if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER) 
	{
        SetVehiclePos(GetPlayerVehicleID(playerid), tpX, tpY, tpZ);
        PutPlayerInVehicle(playerid, GetPlayerVehicleID(playerid), 0);
    }
    else SetPlayerPos(playerid, tpX, tpY, tpZ);
    SetPlayerVirtualWorld(playerid, GetPlayerVirtualWorld(playerid));
    SetPlayerInterior(playerid, GetPlayerInterior(playerid));
    return 1;
}
CMD:flip(playerid, params[]) 
{
    if(CheckAccess(playerid, 1, 1)) return 1;
	if(sscanf(params, "d", params[0])) return SCM(playerid, COLOR_LIGHTGREY, !"�����������: /flip [ID ������]");
	if(!IsPlayerLogged{params[0]})return SCM(playerid, COLOR_GREY, !"����� �� �����������");
	if(GetPlayerState(params[0])!=2) return SCM(playerid, COLOR_GREY,"����� �� � ������");
	new cpos = GetPlayerVehicleID(params[0]);
	new Float:X, Float:Y, Float:Z, Float:A;
	GetVehiclePos(cpos, X, Y, Z);
	SetVehiclePos(cpos,X, Y, Z);
	GetVehicleZAngle(cpos, A);
	SetVehicleZAngle(cpos, A);
	RepairVehicle(cpos);

	new senderName[MAX_PLAYER_NAME + 20];
	if(PI[playerid][pAdmin]) format(senderName, sizeof(senderName), "%s #%d", AdminName[PI[playerid][pAdmin]], PI[playerid][pAdminNumber]);
	else format(senderName, sizeof(senderName), "%s", ModerName[PI[playerid][pModer]]);

	SendAdminsMessagef(COLOR_ADMINCHAT, "[%s] %s[%d] ������� ��������� ������ %s[%d]", senderName, PI[playerid][pName], playerid, getName(params[0]), params[0]);
	SCMf(params[0], -1, "%s ������� ��� ���������", PI[playerid][pAdmin] ? "������� ������" : "������� ���������");
	return 1;
}
alias:ans("pm");
CMD:ans(playerid,params[]) 
{
    if(CheckAccess(playerid, 1, 1)) return 1;
	if(sscanf(params,"us[90]",params[0],params[1])) return SCM(playerid, COLOR_LIGHTGREY, !"�����������: /ans [ID ������] [�����]");
	if(!IsPlayerConnected(params[0])) return SCM(playerid, COLOR_GREY, !"����� �� � ����");
	if(!IsPlayerLogged{params[0]}) return SCM(playerid, COLOR_GREY, !"����� �� �����������");
	if(params[0] == playerid) return SCM(playerid, COLOR_GREY, "�� �� ������ �������� ������ ����");

    NotReklama(playerid, params[1]);

    SCMf(params[0], 0x906868FF, "%s ������� ���: {FFFFFF}%s", PI[playerid][pAdmin] ? "������� ������" : "������� ���������", params[1]);

	cef_emit_event(params[0], "cef:capture:sound", CEFINT(1));

	new senderName[MAX_PLAYER_NAME + 20];
	if(PI[playerid][pAdmin]) format(senderName, sizeof(senderName), "%s #%d", AdminName[PI[playerid][pAdmin]], PI[playerid][pAdminNumber]);
	else format(senderName, sizeof(senderName), "%s", ModerName[PI[playerid][pModer]]);

	SendAdminsMessagef(COLOR_ADMINCHAT, "[%s] %s[%d] ������� ������ %s[%d]:{FFFFFF} %s", senderName, PI[playerid][pName], playerid, getName(params[0]), params[0], params[1]);

	if(PI[params[0]][pAdmin] <= 0) 
	{
		PI[playerid][pAdminReports]++;
		UpdatePlayerDataInt(playerid, "AdminReports", PI[playerid][pAdminReports]);
	}
    return 1;
}
CMD:change(playerid,params[]) 
{
    if(CheckAccess(playerid, 5)) return 1;
    if(sscanf(params,"u",params[0])) return SCM(playerid, COLOR_LIGHTGREY, !"�����������: /change [ID ������]");
    if(!IsPlayerConnected(params[0]))return  SCM(playerid, COLOR_GREY, !"����� �� � ����");
	if(!IsPlayerLogged{params[0]})return  SCM(playerid, COLOR_GREY, !"����� �� �����������");
	if(GetPVarInt(params[0],"change_name_status") != 1) return SCM(playerid, COLOR_GREY, !"������ ����� ������� ������ �� ����� ��������");
	mysql_string[0] = EOS, mf(mysql, mysql_string, 69, "SELECT * FROM `accounts` WHERE `Name` = '%e'", CHANGE_NAME[params[0]]);
	mysql_function_query(mysql, mysql_string, true, "CheckName", "ds", params[0], CHANGE_NAME[params[0]]);
	return 1;
}
CMD:warn(playerid,params[]) 
{
    if(CheckAccess(playerid, 4)) return 1;
	if(sscanf(params,"us[32]",params[0],params[1])) return SCM(playerid, COLOR_LIGHTGREY, !"�����������: /warn [ID ������] [�������]");
	if(!IsPlayerConnected(params[0]))return  SCM(playerid, COLOR_GREY, !"����� �� � ����");
	if(!IsPlayerLogged{params[0]})return  SCM(playerid, COLOR_GREY, !"����� �� �����������");
    if(playerid == params[0]) return SCM(playerid, COLOR_GREY, !"�� �� ������ ������ ���� ��������������");
    if(PI[params[0]][pAdmin] > PI[playerid][pAdmin]) return SCM(playerid, COLOR_GREY, !"������ ��������� � �������� �������");
    PI[params[0]][pMember] = 0;
	PI[params[0]][pLeader] = 0;
	PI[params[0]][pRang] = 0;
	PI[params[0]][pAdmin] = 0;
	UpdatePlayerDataInt(playerid, "Admin", PI[params[0]][pAdmin]);

	if(PI[params[0]][pOnCapture] == 1)
	{
		AutoKickCapture(params[0]);
		CheckCount(params[0]);
	}

	if(PI[params[0]][pWarn] < 3) 
	{
	    PI[params[0]][pWarn]++;
	    PI[params[0]][pWarnTime] += 3600;
	    SendAdminsMessagef(COLOR_ADMINCHAT, "[%s #%d] %s ����� �������������� ������ %s [%d/3]. �������: %s", AdminName[PI[playerid][pAdmin]], PI[playerid][pAdminNumber], getName(playerid), getName(params[0]), PI[params[0]][pWarn], params[1]);
	    SendClientMessagef(playerid, COLOR_TOMATO, "������� ������ ����� ��� �������������� [%d/3]. �������: %s", params[1]);
		SCM(params[0], COLOR_LIGHTGREY, !"�� ������ ���� �������������� ��������� �������� �� �������");
		CreatePunishment(playerid, params[0], 2, params[1]);
	    return Kick(params[0]);
	}
	if(PI[params[0]][pWarn] >= 3) 
	{
		mysql_string[0] = EOS, mf(mysql, mysql_string, 190, "INSERT INTO `banlist` ( `name`,`admin`, `day`, `text`, `ip`) VALUES ( '%e', '%e', '7', '%e', '%e')",getName(params[0]),getName(playerid),params[2],PI[params[0]][pLoginIP]);
	    mysql_function_query(mysql, mysql_string, false, "", "");

		Kick(params[0]);
		SendAdminsMessagef(COLOR_TOMATO, "[%s #%d] %s ������������ %s �� 7 ����. �������: 3 ��������������", AdminName[PI[playerid][pAdmin]], PI[playerid][pAdminNumber], getName(playerid),getName(params[0]));
		SendClientMessagef(playerid, COLOR_TOMATO, "������� ������ ������������ ��� �� 7 ����. �������: 3 ��������������", params[1]);
		return 1;
	}
	return 1;
}
CMD:checkoff(playerid,params[]) 
{
    if(CheckAccess(playerid, 5)) return 0;
    if(sscanf(params,"s[24]",params[0])) return SCM(playerid, COLOR_LIGHTGREY, !"�����������: /checkoff [���]");
	mysql_string[0] = EOS, mf(mysql, mysql_string, 70, "SELECT * FROM `accounts` WHERE `Name` = '%e'", params[0]);
 	mysql_function_query(mysql, mysql_string, true, "CheckPlayerOffline", "i", playerid);
   	return 1;
}
CMD:check(playerid,params[]) 
{
    if(CheckAccess(playerid, 3)) return 0;
    if(sscanf(params,"d",params[0])) return SCM(playerid, COLOR_LIGHTGREY, !"�����������: /check [ID]");
	ShowStats(params[0], playerid);
   	return 1;
}
callback: CheckPlayerOffline(playerid) 
{
    new rows, fields, temp[32];
    cache_get_data(rows, fields);
    if(rows) 
	{
        new Name[24], LoginIP[16], RegIP[16], Referal[24], Email[75], RegisterDate[35], LoginDate[35];
		new Donate, ID, JailTime, DemorganTime, MuteTime, VMuteTime, AdminLevel, Level, Skin, SkinMember, Money;
        cache_get_field_content(0, "Name", Name, mysql);
		cache_get_field_content(0, "Referal", Referal, mysql);
		cache_get_field_content(0, "Email", Email, mysql);
		cache_get_field_content(0, "LoginIP", LoginIP, mysql);
		cache_get_field_content(0, "RegIP", RegIP, mysql);
		cache_get_field_content(0, "RegisterDate", RegisterDate, mysql);
		cache_get_field_content(0, "LoginDate", LoginDate, mysql);

		cache_get_field_content(0, "Donate", temp), Donate = strval (temp);
		cache_get_field_content(0, "Money", temp), Money = strval (temp);
		cache_get_field_content(0, "id", temp), ID = strval (temp);
		cache_get_field_content(0, "jailtime", temp), JailTime = strval (temp);
		cache_get_field_content(0, "demorgan_time", temp), DemorganTime = strval (temp);
		cache_get_field_content(0, "mutetime", temp), MuteTime = strval (temp);
		cache_get_field_content(0, "vmutetime", temp), VMuteTime = strval (temp);
		cache_get_field_content(0, "Admin", temp), AdminLevel = strval (temp);
		cache_get_field_content(0, "Level", temp), Level = strval (temp);
		cache_get_field_content(0, "skin", temp), Skin = strval (temp);
		cache_get_field_content(0, "skinm", temp), SkinMember = strval (temp);

		if(AdminLevel == 8) return SCM(playerid, COLOR_GREY, !"�� �� ������ ����������� ���������� �� ���� ��������");
		ShowPlayerDialogf(playerid, 0, DIALOG_STYLE_MSGBOX, !"{ee3366}���������� ������", "��", "", "\
																				\t\t\t{FFFF99}Donate-Points: %d (Account ID: %d)\n\n\
																				{3366cc}�������� ����������\n\
																				{FFFFFF}�������: \t\t\t{FFFF99}%s\n\
																				{FFFFFF}������: \t\t\t{FFFF99}%d\n\
																				{FFFFFF}�������: \t\t\t{FFFF99}%s\n\
																				{FFFFFF}RegIP: \t\t\t\t{FFFF99}%s\n\
																				{FFFFFF}LoginIP: \t\t\t{FFFF99}%s\n\
																				{FFFFFF}�����: \t\t\t\t{FFFF99}%s\n\n\
																				{3366cc}��������� ����������\n\
																				{FFFFFF}���� �����������: \t\t{FFFF99}%s\n\
																				{FFFFFF}���� �����������: \t\t{FFFF99}%s\n\
																				{FFFFFF}DemorganTime: \t\t{FFFF99}%d ���\n\
																				{FFFFFF}JailTime: \t\t\t{FFFF99}%d ���\n\
																				{FFFFFF}MuteTime: \t\t\t{FFFF99}%d ���\n\
																				{FFFFFF}VMuteTime: \t\t\t{FFFF99}%d ���\n\
																				{FFFFFF}������� �����-����: \t\t{FFFF99}%d �������\n\
																				{FFFFFF}�������: \t\t\t{FFFF99}%d\n\
																				{FFFFFF}����: \t\t\t\t{FFFF99}%d\n\
																				{FFFFFF}���� �����������: \t\t\t{FFFF99}%d", 
																				Donate, ID, Name, Money, Referal, RegIP, LoginIP, Email, RegisterDate, LoginDate,
																				DemorganTime, JailTime, MuteTime, VMuteTime, AdminLevel, Level, Skin, SkinMember);

		SendAdminsMessagef(COLOR_ADMINCHAT, "[%s #%d] %s[%d] ������������� ���������� �������� %s", AdminName[PI[playerid][pAdmin]], PI[playerid][pAdminNumber], PI[playerid][pName], playerid, Name);
	}
    else SCM(playerid, COLOR_GREY, !"������� �� ������ � ���� ������");
    return 1;
}
CMD:sp(playerid,params[]) 
{
    if(CheckAccess(playerid, 1, 1)) return 1;
    if(sscanf(params,"u",params[0])) 
	{
		if(GetPVarInt(playerid, "SpecBool") != 1) return SCM(playerid, COLOR_LIGHTGREY, !"�����������: /sp [ID ������]");
		TogglePlayerSpectating(playerid, false);
		SetPlayerPos(playerid, 2095.7141, 1560.8864, -46.5100);
		return 1;
	} 

    if(!IsPlayerConnected(params[0]))return  SCM(playerid, COLOR_GREY, !"����� �� � ����");
	if(!IsPlayerLogged{params[0]})return  SCM(playerid, COLOR_GREY, !"����� �� �����������");
	if(params[0] == playerid) return SCM(playerid, COLOR_GREY, !"�� �� ������ ������� �� ����� �����");
 	if(GetPVarInt(params[0], "SpecBool") == 1) return SCM(playerid, COLOR_GREY, !"����� ��������� � ������ ����������");

	new senderName[MAX_PLAYER_NAME + 20];
	if(PI[playerid][pAdmin]) format(senderName, sizeof(senderName), "%s #%d", AdminName[PI[playerid][pAdmin]], PI[playerid][pAdminNumber]);
	else format(senderName, sizeof(senderName), "%s", ModerName[PI[playerid][pModer]]);

	SendAdminsMessagef(COLOR_GREY, "[%s] %s[%d] ����� ������� �� %s[%d]", senderName, getName(playerid), playerid, getName(params[0]), params[0]);
 	SCM(playerid, COLOR_HINT, "[���������] {FFFFFF}�������� ������: {FFFF33}������� SHIFT ��� ������� /sp");
	/*SCM(playerid, COLOR_HINT, "[���������] {FFFFFF}�������� ������: {FFFF33}������� CTRL");
	SCM(playerid, COLOR_HINT, "[���������] {FFFFFF}���������� ������: {FFFF33}������� CAPSLOCK");*/

	new inter, world, Float:X, Float:Y, Float:Z, Float:FA;
	SetPVarInt(playerid,"specid", params[0]);

	if(GetPVarInt(playerid, "SpecBool") == 0) 
	{
	    GetPlayerHealth(playerid,PI[playerid][pHealthPoints]);
		GetPlayerPos(playerid, X, Y, Z);
		GetPlayerFacingAngle(playerid, FA);
		inter = GetPlayerInterior(playerid);
		world = GetPlayerVirtualWorld(playerid);
		SetPVarInt(playerid, "SpecBool", 1);
		SetPVarFloat(playerid, "SpecX", X);
		SetPVarFloat(playerid, "SpecY", Y);
		SetPVarFloat(playerid, "SpecZ", Z);
		SetPVarFloat(playerid, "SpecFA", FA);
		SetPVarInt(playerid, "SpecInt", inter);
		SetPVarInt(playerid, "SpecWorld", world);
	}
	SetPlayerInterior(playerid,GetPlayerInterior(params[0]));
	SetPlayerVirtualWorld(playerid,GetPlayerVirtualWorld(params[0]));
	TogglePlayerSpectating(playerid, true);
	if(IsPlayerInAnyVehicle(params[0])) 
	{
		new carid = GetPlayerVehicleID(params[0]);
		PlayerSpectateVehicle(playerid, carid);
	}
	else PlayerSpectatePlayer(playerid, params[0]);

	return 1;
}
CMD:givedonate(playerid,params[]) 
{
    if(CheckAccess(playerid, 8)) return 0;
    if(GetPVarInt(playerid,"givedonate") > gettime()) return SCM(playerid, COLOR_GREY, !"������� ����� ������������ ��� � 1 ������");
	if(sscanf(params,"ud",params[0],params[1])) return SCM(playerid, COLOR_LIGHTGREY, !"�����������: /givedonate [id] [ammount]");
    if(!IsPlayerConnected(params[0]))return  SCM(playerid, COLOR_GREY, !"����� �� � ����");
	if(!IsPlayerLogged{params[0]})return  SCM(playerid, COLOR_GREY, !"����� �� �����������");
	if(params[1] > 5000)return  SCM(playerid, COLOR_GREY, !"����� ������ ������ �� 1 �� 5000 ���");

    SetPVarInt(playerid,"givedonate",gettime() + 59);

	PI[params[0]][pDonate] += params[1];
	UpdatePlayerDataInt(params[0], "Donate", PI[params[0]][pDonate]);

	SendAdminsMessagef(COLOR_ADMINCHAT, "[%s #%d] %s[%d] ����� ������ %s[%d] %d �����-�������", AdminName[PI[playerid][pAdmin]], PI[playerid][pAdminNumber], getName(playerid), playerid, getName(params[0]), params[0], params[1]);
	return SCMf(params[0], -1, "������� ������ ����� ��� %d �����-�������", params[0], params[1]);
}
CMD:apanel(playerid) 
{
    if(CheckAccess(playerid, 8)) return 1;
	SCM(playerid, COLOR_GREY, "[Anti-sliv] ��� �������� ����������� � ����-������, � � ������� '��-������'");
	return ShowApanel(playerid);
}
stock ShowApanel(playerid)
{
	new settings[300];
	format(settings, sizeof settings, "\
	1. ����� �� ������-����������\t\t{FFFF99}%s\n\
	2. ��������� ������\t\t{FFFF99}...\n\
	4. ���������� �������� ��������\t\t{FFFF99}...\n\
	5. ���������� �������� RP\t\t{FFFF99}...",
	(Coolldown_Capture) ? ("�������") : ("��������"));
	return ShowPlayerDialog(playerid, 9888, DIALOG_STYLE_LIST, "{ee3366}��������� ������������", settings, "��������", "�������");
}
CMD:speedhack(playerid)
{
	if(CheckAccess(playerid, 1, 1)) return 1;
	SetVehicleSpeed(GetPlayerVehicleID(playerid), 500);
	return 1;
}
CMD:az(playerid)
{
	if(CheckAccess(playerid, 1)) return 1;
	SetPlayerPos(playerid, 2095.6086,1560.5791,-46.5100);
	SetPlayerVirtualWorld(playerid, 0);
	SetPlayerInterior(playerid, 0);
	SetPlayerHealthAC(playerid, 200);
	return 1;
}
CMD:capture_stat(playerid)
{
	if(CheckAccess(playerid, 5)) return 1;

	SCMf(playerid, -1, "pOnCapture - %d", PI[playerid][pOnCapture]);

	new string[1048] = "", count = 0;

    for (new i = 0; i < MAX_PLAYERS; i++)
    {
        if (!IsPlayerConnected(i)) continue;
		if (GangWarInfo[i][gMember] == -1) continue;

        if (GangWarInfo[i][gPlayerID] != INVALID_PLAYER_ID) 
        {
            ShowTeam[playerid][count] = GangWarInfo[i][gPlayerID];
            count++;
            f(string, sizeof(string), "%s{FFFFFF}(Count %d) | {FFFF99}(%s NAME) - (%d ORG) - (%d ID){FFFFFF}\n", 
                   string, count, 
                   getName(GangWarInfo[i][gPlayerID]), GangWarInfo[i][gMember], GangWarInfo[i][gPlayerID]
			);
        }
    }
	return ShowPlayerDialog(playerid, 0, DIALOG_STYLE_MSGBOX, "{ee3366}������ ���������� �������", string, "��", "");
}