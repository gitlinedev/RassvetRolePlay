forward Float:GetDistanceBetweenPlayers(p1, p2);
public Float:GetDistanceBetweenPlayers(p1, p2) 
{
    new Float:x1,Float:y1,Float:z1,Float:x2,Float:y2,Float:z2;
    if(!IsPlayerConnected(p1) || !IsPlayerConnected(p2)) return -1.00;
    GetPlayerPos(p1,x1,y1,z1);
    GetPlayerPos(p2,x2,y2,z2);
    return floatsqroot(floatpower(floatabs(floatsub(x2,x1)),2)+floatpower(floatabs(floatsub(y2,y1)),2)+floatpower(floatabs(floatsub(z2,z1)),2));
}

CMD:arrest(playerid, params[])
{
    new targetid;
    if (!IsPlayerCops(playerid)) return SCM(playerid, COLOR_GREY, !"������ ������� ��� ����������");
    if (sscanf(params, "u", targetid)) return SCM(playerid, COLOR_LIGHTGREY, !"�����������: /arrest [ID ������]");
    if (!IsPlayerConnected(targetid)) return SCM(playerid, COLOR_GREY, !"����� �� � ����");
    if (!IsPlayerLogged{targetid}) return SCM(playerid, COLOR_GREY, !"����� �� �����������");
    if (PI[playerid][pRang] < 2 && PI[playerid][pMember] != 8) return SCM(playerid, COLOR_GREY, !"��� ���� ������� ��� ��� ������������� ������ �������");

    new Float:x, Float:y, Float:z;
    GetPlayerPos(targetid, x, y, z);
    if (!PlayerToPoint(3.0, playerid, x, y, z)) return SCM(playerid, COLOR_GREY, !"����� ��������� ������� ������");
    if (GetPVarInt(targetid, "PlayerCuffed") == 0) return SCM(playerid, COLOR_GREY, !"������ ����� ������ ���������� � ����������");
    if (PI[targetid][pWanted] == 0) return SCM(playerid, COLOR_GREY, !"������ ����� �� ��������� � �������");
    
    if (PlayerToPoint(20.0, playerid, 2422.7039, -1808.4011, 21.9369)) 
    {
        SendFractionMessagef(PI[playerid][pMember], COLOR_YELLOW, "[���� ������] %s %s ��������� �������������� %s", rang_police[PI[playerid][pRang] - 1][frName], getName(playerid), getName(targetid));
        new reward = 3000 * PI[targetid][pWanted];
        GivePlayerMoneyLog(playerid, reward);

        new pay[16];
        format(pay, sizeof(pay), "+%d�", reward);
        SendPlayerRadarNotify(playerid, 99, "green", "������ �� ����� �����������", pay, 5);

        if(FollowBy[targetid] != INVALID_PLAYER_ID) 
        {
            SetPVarInt(playerid, "TempFollowBy", -1);
            FollowBy[targetid] = INVALID_PLAYER_ID;
            KillTimer(TimerForPlayer[targetid]);
            TimerForPlayer[targetid] = INVALID_PLAYER_ID;
            ClearAnimations(playerid);
            TogglePlayerControllable(targetid, 1);
            SCMf(playerid, COLOR_GREY, "�� ������ �� ������������� %s", PI[targetid][pName]);
            return SCMf(targetid, COLOR_GREY, "%s %s �������� ��� ��������������", rang_police[PI[playerid][pRang]-1][frName], PI[playerid][pName]);
        }

        HidePlayerSpeedometer(targetid);
    } 
    else return SCM(playerid, COLOR_GREY, !"����� ���������� ����� ������ �������");

    PI[targetid][pJail] = 1;
    PI[targetid][pJailTime] = 600 * PI[targetid][pWanted];
    UnfreezePlayer(targetid);
    PI[targetid][pWanted] = 0;
    SetPlayerWantedLevel(targetid, 0);
    PlayerSpawn(targetid);
    SetPlayerSpecialAction(targetid, 0);
    RemovePlayerAttachedObject(targetid, 5);
    ResetWeaponAll(targetid);
    
    return DeletePVar(targetid, "PlayerCuffed");
}
CMD:unmask(playerid, params[])
{
    new Float: X, Float: Y, Float: Z; GetPlayerPos(playerid, X, Y, Z);
    if(!IsPlayerInRangeOfPoint(playerid, 1.5, X, Y, Z)) return SCM(playerid, COLOR_GREY, !"����� ������ �� ���");
    if(!IsPlayerCops(playerid)) return SCM(playerid, COLOR_GREY, !"������ ������� ��� ����������");
    if(sscanf(params,"u",params[0])) return SCM(playerid, COLOR_LIGHTGREY, !"�����������: /unmask [ID ������]");
   	new Float:x,Float:y,Float:z;
	GetPlayerPos(params[0],x,y,z);
	if(!PlayerToPoint(10.0, playerid, x,y,z)) return SCM(playerid, COLOR_GREY, !"����� ������� ������ �� ���");
	PI[params[0]][pMaskWorn] = 0;
	SCM(params[0], COLOR_BLUE, !"����������� ���� � ��� �����!");
	SCMf(playerid, COLOR_BLUE, "�� ����� ����� ������ %s",getName(params[0]));
	SendPlayerCenterNotify(playerid, 3, "����� �����", 5);
    return 1;
}
CMD:su(playerid, params[]) 
{
    if(!IsPlayerCops(playerid)) return SCM(playerid, COLOR_GREY, !"������ ������� ��� ����������");
    if(sscanf(params, "us[50]", params[0], params[1])) return SCM(playerid, COLOR_LIGHTGREY, !"�����������: /su [ID ������] [�������]");
    if(!IsPlayerConnected(params[0]))return  SCM(playerid, COLOR_GREY, !"����� �� � ����");
	if(!IsPlayerLogged{params[0]})return  SCM(playerid, COLOR_GREY, !"����� �� �����������");
	if(params[0] == playerid) return SCM(playerid, COLOR_GREY, !"������ ������ ������ ������ ����");
	if(PI[playerid][pMember] == PI[params[0]][pMember]) return SCM(playerid, COLOR_GREY, !"�� �� ������ ������ ������ ���������� �������");
	if(PI[playerid][pRang] < 2 && PI[playerid][pMember] != 8) return SCM(playerid, COLOR_GREY, !"��� ���� ������� ��� ��� ������������� ������ �������");
	if(PI[params[0]][pWanted] == 6) return SCM(playerid, COLOR_GREY, !"� ������ ������������ ������� �������");
	PI[params[0]][pWanted]++;
	SetPlayerWantedLevel(params[0],PI[params[0]][pWanted]);
	if(PI[params[0]][pRespect] > 0) PI[params[0]][pRespect]--;
	SendFractionMessagef(PI[playerid][pMember], COLOR_YELLOW, "%s %s[%d] ������� %s[%d] � ������ [%d|6]. �������: %s.", rang_police[PI[playerid][pRang]-1][frName],getName(playerid),playerid, getName(params[0]),params[0],PI[params[0]][pWanted], params[1]);
	return SCMf(params[0],0x93baffFF, "%s %s[%d] ������� ��� � ������ [%d|6]. �������: %s", rang_police[PI[playerid][pRang]-1][frName],getName(playerid),playerid,PI[params[0]][pWanted], params[1]);
}
CMD:search(playerid, params[])
{
    new Float: X, Float: Y, Float: Z; GetPlayerPos(playerid, X, Y, Z);
    if(!IsPlayerInRangeOfPoint(playerid, 1.5, X, Y, Z)) return SCM(playerid, COLOR_GREY, !"����� ������ �� ���");
    if(!IsPlayerCops(playerid)) return SCM(playerid, COLOR_GREY, !"������ ������� ��� ����������");
   	if(params[0] == playerid) return SCM(playerid, COLOR_GREY, !"�� �� ������ �������� ������ ����");
    if(sscanf(params,"u",params[0])) return SCM(playerid, COLOR_LIGHTGREY, !"�����������: /chest [ID ������]");
    SetPlayerChatBubble(playerid, "���������� ������!", 0xFF99CCFF, 20.0, 4000);
    new str[145];
   	format(str,sizeof(str),"%s ����� ��������� �������� ������ ��������� ����",getName(playerid));
 	ProxDetector(30.0, playerid, str,0xFF99CCFF,0xFF99CCFF,0xFF99CCFF,0xFF99CCFF,0xFF99CCFF);
 	format(str,sizeof(str),"��������� �������� �� ����� (%s)",getName(playerid));
 	ProxDetector(30.0, playerid, str,0xFF99CCFF,0xFF99CCFF,0xFF99CCFF,0xFF99CCFF,0xFF99CCFF);
	format(str,sizeof(str),"������� (%s)",getName(playerid));
 	ProxDetector(30.0, playerid, str,0xFF99CCFF,0xFF99CCFF,0xFF99CCFF,0xFF99CCFF,0xFF99CCFF);
 	SCMf(playerid, -1, "___________________________________________", PI[params[0]]);
	SCMf(playerid, -1, "�� ������� �������� ���������� %s:", getName(params[0]));
	SCMf(playerid, -1, "������ � �������: {ff0000}%d{08008d}", PI[params[0]][pAmmo]);
	SCMf(playerid, -1, "���������� � �������: {ff0000}%d{08008d}", PI[params[0]][pDrugs]);
	SCMf(playerid, -1, "�������: {ff0000}%d",PI[params[0]][pMetall]);
	ApplyAnimation(playerid,"COP_AMBIENT","Coplook_watch",4.1,0,0,0,0,0);
	SCMf(playerid, -1, "___________________________________________", PI[params[0]]);
   	format(str,sizeof(str),"����������� %s ������� ����� � ���������� %s",getName(playerid),getName(params[0]));
    return 1;
}
CMD:remove(playerid, params[])
{
    new Float: X, Float: Y, Float: Z; GetPlayerPos(playerid, X, Y, Z);
    if(!IsPlayerInRangeOfPoint(playerid, 1.5, X, Y, Z)) return SCM(playerid, COLOR_GREY, !"����� ������ �� ���");
	if(params[0] == playerid) return SCM(playerid, COLOR_GREY, !"�� �� ������ ������ � ������ ����");
    if(!IsPlayerCops(playerid)) return SCM(playerid, COLOR_GREY, !"������ ������� ��� ����������");
    if(sscanf(params,"u",params[0])) return SCM(playerid, COLOR_LIGHTGREY, !"�����������: /remove [ID ������]");
    PI[params[0]][pAmmo] = 0;
    PI[params[0]][pDrugs] = 0;
    PI[params[0]][data_AMMO] = 0;
    return 1;
}
CMD:clear(playerid,params[]) 
{
    if(!IsPlayerCops(playerid)) return SCM(playerid, COLOR_GREY, !"������ ������� ��� ����������");
    if(PI[playerid][pRang] < 8) return SCM(playerid, COLOR_GREY, !"����� ������ ������ ����� � 8 �����");
	if(sscanf(params, "u", params[0])) return SCM(playerid, COLOR_LIGHTGREY, !"�����������: /clear [ID ������]");
    if(!IsPlayerConnected(params[0]))return  SCM(playerid, COLOR_GREY, !"����� �� � ����");
	if(!IsPlayerLogged{params[0]})return  SCM(playerid, COLOR_GREY, !"����� �� �����������");
    if(PI[params[0]][pWanted] == 0) return SCM(playerid, COLOR_GREY, !"� ������ ��� �������");
	if(!PlayerToPoint(30.0, playerid, 127.5578,1863.0262,-31.9775)) return SCM(playerid, COLOR_GREY, !"����� ����� ������ ������ �� � ������ ������ ��������� � ��");
	if(!PlayerToPoint(30.0, params[0], 127.5578,1863.0262,-31.9775)) return SCM(playerid, COLOR_GREY, !"����� ����� ������ ������ �� � ������ ������ ��������� � ��");
	PI[params[0]][pWanted] = 0;
	SetPlayerWantedLevel(params[0],PI[params[0]][pWanted]);
	SendFractionMessagef(PI[playerid][pMember], COLOR_YELLOW, "%s ������ ��������� ���� %s",getName(playerid),getName(params[0]));
	return SCMf(params[0], 0x0099ccFF, "%s ������ ���� ��������� ����",getName(playerid));
}
CMD:cuff(playerid,params[]) 
{
    if(!IsPlayerCops(playerid)) return SCM(playerid, COLOR_GREY, !"������ ������� ��� ����������");
    if(sscanf(params, "u", params[0])) return SCM(playerid, COLOR_LIGHTGREY, !"�����������: /cuff [ID ������]");
    if(!IsPlayerConnected(params[0]))return  SCM(playerid, COLOR_GREY, !"����� �� � ����");
	if(!IsPlayerLogged{params[0]}) return  SCM(playerid, COLOR_GREY, !"����� �� �����������");
	if(PI[playerid][pRang] < 2 && PI[playerid][pMember] != 8) return SCM(playerid, COLOR_GREY, !"��� ������� �������� ��� 2+ ������.");
	if(PI[playerid][pMember] == PI[params[0]][pMember]) return SCM(playerid, COLOR_GREY, "�� �� ������ ������ ���������� �� ���������� �������");
	new Float:x,Float:y,Float:z,str[145];
	GetPlayerPos(params[0],x,y,z);
	if(!PlayerToPoint(3.0, playerid, x,y,z)) return SCM(playerid, COLOR_GREY, !"������ ����� ������� ������ �� ���");
    if(GetPVarInt(params[0],"PlayerCuffed") == 1) return SCM(playerid, COLOR_GREY, !"������ ����� ��� � ����������");
	SetPlayerSpecialAction(params[0], SPECIAL_ACTION_CUFFED);
	SetPlayerAttachedObject(params[0],5,19418,6,0.020000,0.049999,-0.015000,-11.899997,-13.999941,-103.800086,1.110999,1.042000,1.934998);
	SetPVarInt(params[0],"PlayerCuffed",1);
	FreezePlayer(params[0]);
	SCMf(playerid, 0x4671acff, "�� ������ ��������� �� %s", getName(playerid));
	format(str,sizeof(str), "%s ����� ��������� �� %s",getName(playerid),getName(params[0]));
 	return ProxDetector(30.0, playerid, str,0xFF99CCFF,0xFF99CCFF,0xFF99CCFF,0xFF99CCFF,0xFF99CCFF);
}
CMD:uncuff(playerid,params[]) 
{
    if(!IsPlayerCops(playerid)) return SCM(playerid, COLOR_GREY, !"������ ������� ��� ����������");
    if(sscanf(params, "u", params[0])) return SCM(playerid, COLOR_LIGHTGREY, !"�����������: /uncuff [ID ������]");
    if(!IsPlayerConnected(params[0]))return  SCM(playerid, COLOR_GREY, !"����� �� � ����");
	if(!IsPlayerLogged{params[0]}) return  SCM(playerid, COLOR_GREY, !"����� �� �����������");
	if(PI[playerid][pRang] < 2 && PI[playerid][pMember] != 8) return SCM(playerid, COLOR_GREY, !"��� ���� ������� ��� ��� ������������� ������ �������");
	new Float:x,Float:y,Float:z;
	GetPlayerPos(params[0],x,y,z);
	if(!PlayerToPoint(3.0, playerid, x,y,z)) return SCM(playerid, COLOR_GREY, !"������ ����� ������� ������ �� ���");
    if(GetPVarInt(params[0],"PlayerCuffed") == 0) return SCM(playerid, COLOR_GREY, !"������ ����� ��� ����������");
	SetPlayerSpecialAction(params[0], 0);
	RemovePlayerAttachedObject(params[0], 5);
	DeletePVar(params[0],"PlayerCuffed");
	UnfreezePlayer(params[0]);
	new str[145];
	format(str,sizeof(str),"%s ���� ��������� � %s",getName(playerid),getName(params[0]));
 	return ProxDetector(30.0, playerid, str,0xFF99CCFF,0xFF99CCFF,0xFF99CCFF,0xFF99CCFF,0xFF99CCFF);
}
CMD:incar(playerid,params[]) 
{
    if(!IsPlayerCops(playerid)) return SCM(playerid, COLOR_GREY, !"������ ������� ��� ����������");
    if(sscanf(params, "u", params[0])) return SCM(playerid, COLOR_LIGHTGREY, !"�����������: /incar [ID ������]");
    if(!IsPlayerConnected(params[0]))return  SCM(playerid, COLOR_GREY, !"����� �� � ����");
	if(!IsPlayerLogged{params[0]}) return  SCM(playerid, COLOR_GREY, !"����� �� �����������");
    if(PI[playerid][pRang] < 2 && PI[playerid][pMember] != 8) return SCM(playerid, COLOR_GREY, !"��� ���� ������� ��� ��� ������������� ������ �������");
    if(GetPVarInt(params[0],"PlayerCuffed") == 0) return SCM(playerid, COLOR_GREY, !"����� ������ ���������� � ����������");
	if(!IsPlayerInAnyVehicle(playerid)) return  SCM(playerid, COLOR_GREY, !"�� ������ ���������� � ����������");
	new Float:x,Float:y,Float:z;
	new car = GetPlayerVehicleID(playerid);
	GetPlayerPos(params[0],x,y,z);
	if(!PlayerToPoint(5.0, playerid, x,y,z)) return SCM(playerid, COLOR_GREY, !"������ ����� ������� ������ �� ���");
    if(car == police_car[0] || car == police_car[1] ||car == police_car[2] || car == police_car[3] || car == police_car[4] || car == police_car[5] || car == police_car[6] || car == police_car[7]) 
	{
	    if(GetFreeSeat(car) == -1) return SCM(playerid, COLOR_GREY, !"� ������ ��� �����");
	   
	    new str[25+MAX_PLAYER_NAME*2];
	    
		PutPlayerInVehicleAC(params[0],car,GetFreeSeat(car));
     	FreezePlayer(params[0]);
	    format(str,sizeof(str),"%s ������� � ���������� %s",getName(playerid),getName(params[0]));
	    ProxDetector(30.0, playerid, str,0xFF99CCFF,0xFF99CCFF,0xFF99CCFF,0xFF99CCFF,0xFF99CCFF);
	}
	else SCM(playerid, COLOR_GREY, !"������ ��������� �� ������������ ��� ��������� ������������");
	return 1;
}
CMD:uncar(playerid,params[]) 
{
    if(!IsPlayerCops(playerid)) return SCM(playerid, COLOR_GREY, !"������ ������� ��� ����������");
    if(sscanf(params, "u", params[0])) return SCM(playerid, COLOR_LIGHTGREY, !"�����������: /uncar [ID ������]");
    if(!IsPlayerConnected(params[0]))return  SCM(playerid, COLOR_GREY, !"����� �� � ����");
	if(!IsPlayerLogged{params[0]}) return  SCM(playerid, COLOR_GREY, !"����� �� �����������");
    if(PI[playerid][pRang] < 2 && PI[playerid][pMember] != 8) return SCM(playerid, COLOR_GREY, !"��� ���� ������� ��� ��� ������������� ������ �������");
    if(!IsPlayerInAnyVehicle(params[0])) return SCM(playerid, COLOR_GREY, !"����� ������ ���������� � ����������");
	new Float:x,Float:y,Float:z,str[145];
	GetPlayerPos(playerid,x,y,z);
	if(!PlayerToPoint(5.0, playerid, x,y,z)) return SCM(playerid, COLOR_GREY, !"������ ����� ������� ������ �� ���");
 	UnfreezePlayer(params[0]);
 	SetPlayerPosAC(params[0],x+1.0,y,z);
  	format(str,sizeof(str),"%s ������� �� ���������� %s",getName(playerid),getName(params[0]));
  	return ProxDetector(30.0, playerid, str,0xFF99CCFF,0xFF99CCFF,0xFF99CCFF,0xFF99CCFF,0xFF99CCFF);
}
CMD:setmark(playerid, params[])
{
    new targetid;
    if (!IsPlayerCops(playerid)) return SCM(playerid, COLOR_GREY, !"������ ������� ��� ����������");
    if (sscanf(params, "d", targetid)) return SCM(playerid, COLOR_LIGHTGREY, !"�����������: /setmark [ID ������]");
    if (!IsPlayerConnected(targetid)) return SCM(playerid, COLOR_GREY, !"����� �� � ����");
    if (!IsPlayerLogged{targetid}) return SCM(playerid, COLOR_GREY, !"����� �� �����������");
    if (GetPlayerInterior(targetid) != 0) return SCM(playerid, COLOR_GREY, !"����� ��������� � ���������");
    if (PI[targetid][pWanted] == 0) return SCM(playerid, COLOR_GREY, !"������ ����� �� ��������� � �������");

    if (GetPVarInt(playerid, "Counting_setmark") > gettime()) return SCM(playerid, COLOR_GREY, !"������ ������� ����� ������������ ������ ���� ��� � ������");

    new Float:x, Float:y, Float:z;
    GetPlayerPos(targetid, x, y, z);
    SetPVarFloat(playerid, "gps_pos_x", x);
    SetPVarFloat(playerid, "gps_pos_y", y);
    SetPVarFloat(playerid, "gps_pos_z", z);
    DisablePlayerCheckpoint(playerid);
    SetPlayerCheckpoint(playerid, x, y, z, 5.0);

    SCM(playerid, 0x6699cc3FF, !"��������� �������������� �������������� �������� � ��� �� ����-�����");
    SCM(playerid, 0x6699cc3FF, !"��� ����� ������������� ����������� � ������� 30 ������");

    SetPVarInt(playerid, "Counting_setmark", gettime() + 60);
    return 1;
}
CMD:wanted(playerid)
{
    if (!IsPlayerCops(playerid)) return SCM(playerid, COLOR_GREY, !"������ ������� ��� ����������");

    new str_3[1024], bugfix;
    for (new i = 0; i < MAX_PLAYERS; i++) 
    {
        if (!IsPlayerConnected(i)) continue;
        if (PI[i][pWanted] != 0) 
        {
            bugfix = 1;
            format(str_3, sizeof(str_3), "%s\n{FFFFFF}���� �%d, ���: %s, ������� �������: %d\n", str_3, i, PI[i][pName], PI[i][pWanted]);
        }
    }

    if (bugfix == 0) return ShowPlayerDialog(playerid, 0, DIALOG_STYLE_MSGBOX, "{ee3366}�����������", "������� �����, ����������� �� ����������!", "�������", "");
    return ShowPlayerDialog(playerid, 0, DIALOG_STYLE_LIST, "{ee3366}�����������", str_3, "�������", "");
}
CMD:m(playerid,params[]) 
{
    if(sscanf(params, "s[80]", params[0])) return SCM(playerid, COLOR_LIGHTGREY, !"�����������: /m [�����]");
    if(!IsPlayerCops(playerid)) return SCM(playerid, COLOR_GREY, !"������ ������� ��� ����������");
    new car = GetPlayerVehicleID(playerid);
	if(GetVehicleModel(car) == 598 || GetVehicleModel(car) == 551 || GetVehicleModel(car) == 427 || GetVehicleModel(car) == 443 || GetVehicleModel(car) == 597 ||
	GetVehicleModel(car) == 427 || GetVehicleModel(car) == 599 || GetVehicleModel(car) == 490) 
    {
	    global_str[0] = EOS, format(global_str, 144, "[�] %s[%d]: %s",getName(playerid),playerid,params[0]);
		ProxDetector(50.0, playerid, global_str, 0xFACC2EFF, 0xFACC2EFF, 0xFACC2EFF, 0xFACC2EFF, 0xFACC2EFF);
	}
	else SCM(playerid, COLOR_GREY, !"������ ��������� �� ������� ���������");
	return 1;
}
CMD:tome(playerid, params[]) 
{
	new id;
	if(!IsPlayerCops(playerid)) return SCM(playerid, COLOR_GREY, !"������ ������� ��� ����������");
	if(sscanf(params, "u", id)) return SCM(playerid, COLOR_LIGHTGREY, !"�����������: /tome [ID ������]"); 
	{
        if(playerid == id) return SCM(playerid, COLOR_GREY, !"�� �� ������ ������������ ������ ���� ");
        else if(!IsPlayerConnected(id)) return SCM(playerid, COLOR_GREY, !"����� �� � ����");
        else if(IsPlayerInAnyVehicle(playerid)) return SCM(playerid, COLOR_GREY, !"�� �� ������ �������� � ������");
        else if(FollowBy[playerid] != INVALID_PLAYER_ID) return SCM(playerid, COLOR_GREY, !"�� �� ������ ����� ������ �������");
        else if(GetPVarInt(params[0],"PlayerCuffed") == 1) return SCM(playerid, COLOR_GREY, !"����� ������ ���� � ����������");
        else if(IsPlayerInAnyVehicle(id)) return SCM(playerid, COLOR_GREY, !"�� �� ������ �������� �� ����� ����� ����� � ������");
        new Float: X, Float: Y, Float: Z; GetPlayerPos(id, X, Y, Z);
        if(!IsPlayerInRangeOfPoint(playerid, 1.5, X, Y, Z)) return SCM(playerid, COLOR_GREY, !"����� ������ �� ���");
        else if(FollowBy[id] != INVALID_PLAYER_ID) 
        {
            SetPVarInt(playerid, "TempFollowBy", -1);
            FollowBy[id] = INVALID_PLAYER_ID;
            KillTimer(TimerForPlayer[id]);
            TimerForPlayer[id] = INVALID_PLAYER_ID;
            ClearAnimations(playerid);
            TogglePlayerControllable(id, 1);
            SCMf(playerid, COLOR_GREY, "�� ������ �� ������������� %s", PI[id][pName]);
            return SCMf(id, COLOR_GREY, "%s %s �������� ��� ��������������", rang_police[PI[playerid][pRang]-1][frName], PI[playerid][pName]);
        }
        if(GetPVarInt(playerid, "TempFollowBy") != -1) return SCM(playerid, COLOR_GREY, !"�� �� ������ ������������ ������ 2� ������� ������������");
        FollowBy[id] = playerid;
        SetPVarInt(playerid, "TempFollowBy", id);
        TimerForPlayer[id] = SetTimerEx("FollowToPlayer", 1000, 1, "i", id);
        SCMf(playerid, COLOR_GREY, "�� ������ �������������� ������ %s", PI[id][pName]);
        return SCMf(id, COLOR_GREY, "��������� ������ %s ����� ��� ��������������", PI[id][pName]);
    }
}
callback: FollowToPlayer(playerid)
{
    static AnimShot[MAX_PLAYERS];
    if(!IsPlayerConnected(FollowBy[playerid]))
    {
        KillTimer(TimerForPlayer[playerid]);
        TimerForPlayer[playerid] = INVALID_PLAYER_ID;
        FollowBy[playerid] = INVALID_PLAYER_ID;
        TogglePlayerControllable(playerid, 1);
        ClearAnimations(playerid);
        AnimShot[playerid] = false;
        return 1;
    }
    else if(!IsPlayerConnected(playerid))
    {
		SCMf(FollowBy[playerid], COLOR_GREY, "�� ������ �� ������������� %s",PI[GetPVarInt(playerid, "TempFollowBy")][pName]);
        SetPVarInt(FollowBy[playerid], "TempFollowBy", -1);
        KillTimer(TimerForPlayer[playerid]);
        TimerForPlayer[playerid] = INVALID_PLAYER_ID;
        AnimShot[playerid] = false;
        FollowBy[playerid] = INVALID_PLAYER_ID;
        return 1;
    }
    else if(FollowBy[playerid] == MAX_PLAYERS)
    {
        KillTimer(TimerForPlayer[playerid]);
        TimerForPlayer[playerid] = INVALID_PLAYER_ID;
        AnimShot[playerid] = false;
        TogglePlayerControllable(playerid, 1);
        ClearAnimations(playerid);
        return 1;
    }
    else if(IsPlayerInAnyVehicle(playerid))
    {
		SCMf(FollowBy[playerid], COLOR_GREY, "�� ������ �� ������������� %s",PI[GetPVarInt(playerid, "TempFollowBy")][pName]);
        SetPVarInt(FollowBy[playerid], "TempFollowBy", -1);
        KillTimer(TimerForPlayer[playerid]);
        TimerForPlayer[playerid] = INVALID_PLAYER_ID;
        AnimShot[playerid] = false;
        FollowBy[playerid] = INVALID_PLAYER_ID;
        return 1;
    }
    else if(GetPlayerVirtualWorld(FollowBy[playerid]) != GetPlayerVirtualWorld(playerid) || GetPlayerInterior(FollowBy[playerid]) != GetPlayerInterior(playerid))
    {
        new Float: X, Float: Y, Float: Z;
        GetPlayerPos(FollowBy[playerid], X, Y, Z);
        SetPlayerPos(playerid, X, Y, Z);
        SetPlayerVirtualWorld(playerid, GetPlayerVirtualWorld(FollowBy[playerid]));
        SetPlayerInterior(playerid, GetPlayerInterior(FollowBy[playerid]));
        TogglePlayerControllable(playerid, 0);
        AnimShot[playerid] = false;
        return 1;
    }
    new Float: GotDistance = GetDistanceBetweenPlayers(playerid, FollowBy[playerid]);
    if(GotDistance < 0.95)
    {
        TogglePlayerControllable(playerid, 0);
        SetPlayerToFacePlayer(playerid, FollowBy[playerid]);
        AnimShot[playerid] = false;
        return 1;
    }
    else if(GotDistance > 29.0)
    {
		SCMf(FollowBy[playerid], COLOR_GREY, "�� ������ �� ������������� %s",PI[GetPVarInt(playerid, "TempFollowBy")][pName]);
        SetPVarInt(FollowBy[playerid], "TempFollowBy", -1);
        TogglePlayerControllable(playerid, 1);
        ClearAnimations(playerid);
        KillTimer(TimerForPlayer[playerid]);
        TimerForPlayer[playerid] = INVALID_PLAYER_ID;
        FollowBy[playerid] = INVALID_PLAYER_ID;
        return 1;
    }
    else
    {
        TogglePlayerControllable(playerid, 1);
        SetPlayerToFacePlayer(playerid, FollowBy[playerid]);
        ApplyAnimation(playerid, "ped", "WALK_civi", 6.0, 1, 1, 1, 1, 0, 1);
    }
    return 1;
}