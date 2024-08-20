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
    if (!IsPlayerCops(playerid)) return SCM(playerid, COLOR_GREY, !"Данная команда Вам недоступна");
    if (sscanf(params, "u", targetid)) return SCM(playerid, COLOR_LIGHTGREY, !"Используйте: /arrest [ID игрока]");
    if (!IsPlayerConnected(targetid)) return SCM(playerid, COLOR_GREY, !"Игрок не в сети");
    if (!IsPlayerLogged{targetid}) return SCM(playerid, COLOR_GREY, !"Игрок не авторизован");
    if (PI[playerid][pRang] < 2 && PI[playerid][pMember] != 8) return SCM(playerid, COLOR_GREY, !"Ваш ранг слишком мал для использования данной команды");

    new Float:x, Float:y, Float:z;
    GetPlayerPos(targetid, x, y, z);
    if (!PlayerToPoint(3.0, playerid, x, y, z)) return SCM(playerid, COLOR_GREY, !"Игрок находится слишком далеко");
    if (GetPVarInt(targetid, "PlayerCuffed") == 0) return SCM(playerid, COLOR_GREY, !"Данный игрок должен находиться в наручниках");
    if (PI[targetid][pWanted] == 0) return SCM(playerid, COLOR_GREY, !"Данный игрок не находится в розыске");
    
    if (PlayerToPoint(20.0, playerid, 2422.7039, -1808.4011, 21.9369)) 
    {
        SendFractionMessagef(PI[playerid][pMember], COLOR_YELLOW, "[Всем постам] %s %s арестовал подозреваемого %s", rang_police[PI[playerid][pRang] - 1][frName], getName(playerid), getName(targetid));
        new reward = 3000 * PI[targetid][pWanted];
        GivePlayerMoneyLog(playerid, reward);

        new pay[16];
        format(pay, sizeof(pay), "+%dР", reward);
        SendPlayerRadarNotify(playerid, 99, "green", "Премия за арест преступника", pay, 5);

        if(FollowBy[targetid] != INVALID_PLAYER_ID) 
        {
            SetPVarInt(playerid, "TempFollowBy", -1);
            FollowBy[targetid] = INVALID_PLAYER_ID;
            KillTimer(TimerForPlayer[targetid]);
            TimerForPlayer[targetid] = INVALID_PLAYER_ID;
            ClearAnimations(playerid);
            TogglePlayerControllable(targetid, 1);
            SCMf(playerid, COLOR_GREY, "Вы больше не контролируете %s", PI[targetid][pName]);
            return SCMf(targetid, COLOR_GREY, "%s %s перестал Вас контролировать", rang_police[PI[playerid][pRang]-1][frName], PI[playerid][pName]);
        }

        HidePlayerSpeedometer(targetid);
    } 
    else return SCM(playerid, COLOR_GREY, !"Нужно находиться возле здания Полиции");

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
    if(!IsPlayerInRangeOfPoint(playerid, 1.5, X, Y, Z)) return SCM(playerid, COLOR_GREY, !"Игрок далеко от вас");
    if(!IsPlayerCops(playerid)) return SCM(playerid, COLOR_GREY, !"Данная команда Вам недоступна");
    if(sscanf(params,"u",params[0])) return SCM(playerid, COLOR_LIGHTGREY, !"Используйте: /unmask [ID игрока]");
   	new Float:x,Float:y,Float:z;
	GetPlayerPos(params[0],x,y,z);
	if(!PlayerToPoint(10.0, playerid, x,y,z)) return SCM(playerid, COLOR_GREY, !"Игрок слишком далеко от Вас");
	PI[params[0]][pMaskWorn] = 0;
	SCM(params[0], COLOR_BLUE, !"Полицейский снял с вас маску!");
	SCMf(playerid, COLOR_BLUE, "Вы сняли маску игроку %s",getName(params[0]));
	SendPlayerCenterNotify(playerid, 3, "Маска снята", 5);
    return 1;
}
CMD:su(playerid, params[]) 
{
    if(!IsPlayerCops(playerid)) return SCM(playerid, COLOR_GREY, !"Данная команда Вам недоступна");
    if(sscanf(params, "us[50]", params[0], params[1])) return SCM(playerid, COLOR_LIGHTGREY, !"Используйте: /su [ID игрока] [причина]");
    if(!IsPlayerConnected(params[0]))return  SCM(playerid, COLOR_GREY, !"Игрок не в сети");
	if(!IsPlayerLogged{params[0]})return  SCM(playerid, COLOR_GREY, !"Игрок не авторизован");
	if(params[0] == playerid) return SCM(playerid, COLOR_GREY, !"Нельзя выдать розыск самому себе");
	if(PI[playerid][pMember] == PI[params[0]][pMember]) return SCM(playerid, COLOR_GREY, !"Вы не можете выдать розыск сотруднику Полиции");
	if(PI[playerid][pRang] < 2 && PI[playerid][pMember] != 8) return SCM(playerid, COLOR_GREY, !"Ваш ранг слишком мал для использования данной команды");
	if(PI[params[0]][pWanted] == 6) return SCM(playerid, COLOR_GREY, !"У игрока максимальный уровень розыска");
	PI[params[0]][pWanted]++;
	SetPlayerWantedLevel(params[0],PI[params[0]][pWanted]);
	if(PI[params[0]][pRespect] > 0) PI[params[0]][pRespect]--;
	SendFractionMessagef(PI[playerid][pMember], COLOR_YELLOW, "%s %s[%d] объявил %s[%d] в розыск [%d|6]. Причина: %s.", rang_police[PI[playerid][pRang]-1][frName],getName(playerid),playerid, getName(params[0]),params[0],PI[params[0]][pWanted], params[1]);
	return SCMf(params[0],0x93baffFF, "%s %s[%d] объявил Вас в розыск [%d|6]. Причина: %s", rang_police[PI[playerid][pRang]-1][frName],getName(playerid),playerid,PI[params[0]][pWanted], params[1]);
}
CMD:search(playerid, params[])
{
    new Float: X, Float: Y, Float: Z; GetPlayerPos(playerid, X, Y, Z);
    if(!IsPlayerInRangeOfPoint(playerid, 1.5, X, Y, Z)) return SCM(playerid, COLOR_GREY, !"Игрок далеко от вас");
	if(params[0] == playerid) return SCM(playerid, COLOR_GREY, !"Вы не можете изъять у самого себя");
    if(!IsPlayerCops(playerid)) return SCM(playerid, COLOR_GREY, !"Данная команда Вам недоступна");
    if(sscanf(params,"u", params[0])) return SCM(playerid, COLOR_LIGHTGREY, !"Используйте: /search [ID игрока]");

    new BanGuns[6], weapon_id, ammo;
    for (new i; i <= 12; i++)
    {
        GetPlayerWeaponData(params[0], i, weapon_id, ammo);
        if (weapon_id == 0) continue;
        if(weapon_id == 20 || weapon_id == 21 || weapon_id == 22 || weapon_id == 23 || weapon_id == 24 || weapon_id == 25 || weapon_id == 26 || weapon_id == 27 || weapon_id == 28 || weapon_id == 29 || weapon_id == 30 || weapon_id == 31 || weapon_id == 32 || weapon_id == 33 || weapon_id == 34) 
        {
            BanGuns = "есть";
        }
        else BanGuns = "нет";
    }

    ShowPlayerDialogf(playerid, 2340, DIALOG_STYLE_TABLIST_HEADERS, !"{ee3366}Обыск игрока", !"Далее", !"Закрыть", "\
        Название\tКоличество\n\
        1. Наличные деньги\t\t%d руб\n\
        2. Водительские права\t\t%s\n\
        3. Лицензия на оружие\t\t%s\n\
        4. Запрещенное оружие\t\t%s\n\
        5. Запрещенные вещества\t\t%d ед.\n", 
        PI[params[0]][pMoney], 
        PI[params[0]][pDriveLicense] ? ("{4eaa77}есть{FFFFFF}") : ("{ce6c4f}нет{FFFFFF}"),
        PI[params[0]][pGunLicense] ? ("{4eaa77}есть{FFFFFF}") : ("{ce6c4f}нет{FFFFFF}"),
        BanGuns,
        PI[params[0]][pDrugs]);

    SetPVarInt(playerid, "PoliceSearch", params[0]);

    global_str[0] = EOS, f(global_str, 150, "%s %s произвел обыск %s", NameRang(playerid), getName(playerid), getName(params[0]));
	ProxDetector(30.0, playerid, global_str, 0xFF99CCFF, 0xFF99CCFF, 0xFF99CCFF, 0xFF99CCFF, 0xFF99CCFF);
	SetPlayerChatBubble(playerid, global_str, 0xFF99CCFF, 20.0, 4000);
    return 1;
}
CMD:clear(playerid,params[]) 
{
    if(!IsPlayerCops(playerid)) return SCM(playerid, COLOR_GREY, !"Данная команда Вам недоступна");
    if(PI[playerid][pRang] < 8) return SCM(playerid, COLOR_GREY, !"Снять розыск игрока можно с 8 ранга");
	if(sscanf(params, "u", params[0])) return SCM(playerid, COLOR_LIGHTGREY, !"Используйте: /clear [ID игрока]");
    if(!IsPlayerConnected(params[0]))return  SCM(playerid, COLOR_GREY, !"Игрок не в сети");
	if(!IsPlayerLogged{params[0]})return  SCM(playerid, COLOR_GREY, !"Игрок не авторизован");
    if(PI[params[0]][pWanted] == 0) return SCM(playerid, COLOR_GREY, !"У игрока нет розыска");
	if(!PlayerToPoint(30.0, playerid, 127.5578,1863.0262,-31.9775)) return SCM(playerid, COLOR_GREY, !"Чтобы снять розыск игрока Вы и игрока должны находится в ДЧ");
	if(!PlayerToPoint(30.0, params[0], 127.5578,1863.0262,-31.9775)) return SCM(playerid, COLOR_GREY, !"Чтобы снять розыск игрока Вы и игрока должны находится в ДЧ");

	PI[params[0]][pWanted] = 0;
	SetPlayerWantedLevel(params[0], PI[params[0]][pWanted]);

	SendFractionMessagef(PI[playerid][pMember], COLOR_YELLOW, "%s закрыл уголовное дело %s", getName(playerid), getName(params[0]));
	return SCMf(params[0], COLOR_BLACKBLUE, "%s закрыл ваше уголовное дело", getName(playerid));
}
CMD:cuff(playerid,params[]) 
{
    if(!IsPlayerCops(playerid)) return SCM(playerid, COLOR_GREY, !"Данная команда Вам недоступна");
    if(sscanf(params, "u", params[0])) return SCM(playerid, COLOR_LIGHTGREY, !"Используйте: /cuff [ID игрока]");
    if(!IsPlayerConnected(params[0]))return  SCM(playerid, COLOR_GREY, !"Игрок не в сети");
	if(!IsPlayerLogged{params[0]}) return  SCM(playerid, COLOR_GREY, !"Игрок не авторизован");
	if(PI[playerid][pRang] < 2 && PI[playerid][pMember] != 8) return SCM(playerid, COLOR_GREY, !"Эта команда доступна для 2+ звания.");
	if(PI[playerid][pMember] == PI[params[0]][pMember]) return SCM(playerid, COLOR_GREY, "Вы не можете надеть наручиники на сотрудника Полиции");
	new Float:x,Float:y,Float:z,str[145];
	GetPlayerPos(params[0],x,y,z);
	if(!PlayerToPoint(3.0, playerid, x,y,z)) return SCM(playerid, COLOR_GREY, !"Данный игрок слишком далеко от Вас");
    if(GetPVarInt(params[0],"PlayerCuffed") == 1) return SCM(playerid, COLOR_GREY, !"Данный игрок уже в наручниках");
	SetPlayerSpecialAction(params[0], SPECIAL_ACTION_CUFFED);
	SetPlayerAttachedObject(params[0],5,19418,6,0.020000,0.049999,-0.015000,-11.899997,-13.999941,-103.800086,1.110999,1.042000,1.934998);
	SetPVarInt(params[0],"PlayerCuffed",1);
	FreezePlayer(params[0]);
	SCMf(playerid, 0x4671acff, "Вы надели наручники на %s", getName(playerid));
	format(str,sizeof(str), "%s надел наручники на %s",getName(playerid),getName(params[0]));
 	return ProxDetector(30.0, playerid, str,0xFF99CCFF,0xFF99CCFF,0xFF99CCFF,0xFF99CCFF,0xFF99CCFF);
}
CMD:uncuff(playerid,params[]) 
{
    if(!IsPlayerCops(playerid)) return SCM(playerid, COLOR_GREY, !"Данная команда Вам недоступна");
    if(sscanf(params, "u", params[0])) return SCM(playerid, COLOR_LIGHTGREY, !"Используйте: /uncuff [ID игрока]");
    if(!IsPlayerConnected(params[0]))return  SCM(playerid, COLOR_GREY, !"Игрок не в сети");
	if(!IsPlayerLogged{params[0]}) return  SCM(playerid, COLOR_GREY, !"Игрок не авторизован");
	if(PI[playerid][pRang] < 2 && PI[playerid][pMember] != 8) return SCM(playerid, COLOR_GREY, !"Ваш ранг слишком мал для использования данной команды");
	new Float:x,Float:y,Float:z;
	GetPlayerPos(params[0],x,y,z);
	if(!PlayerToPoint(3.0, playerid, x,y,z)) return SCM(playerid, COLOR_GREY, !"Данный игрок слишком далеко от Вас");
    if(GetPVarInt(params[0],"PlayerCuffed") == 0) return SCM(playerid, COLOR_GREY, !"Данный игрок без наручников");
	SetPlayerSpecialAction(params[0], 0);
	RemovePlayerAttachedObject(params[0], 5);
	DeletePVar(params[0],"PlayerCuffed");
	UnfreezePlayer(params[0]);
	new str[145];
	format(str,sizeof(str),"%s снял наручники с %s",getName(playerid),getName(params[0]));
 	return ProxDetector(30.0, playerid, str,0xFF99CCFF,0xFF99CCFF,0xFF99CCFF,0xFF99CCFF,0xFF99CCFF);
}
CMD:incar(playerid,params[]) 
{
    if(!IsPlayerCops(playerid)) return SCM(playerid, COLOR_GREY, !"Данная команда Вам недоступна");
    if(sscanf(params, "u", params[0])) return SCM(playerid, COLOR_LIGHTGREY, !"Используйте: /incar [ID игрока]");
    if(!IsPlayerConnected(params[0]))return  SCM(playerid, COLOR_GREY, !"Игрок не в сети");
	if(!IsPlayerLogged{params[0]}) return  SCM(playerid, COLOR_GREY, !"Игрок не авторизован");
    if(PI[playerid][pRang] < 2 && PI[playerid][pMember] != 8) return SCM(playerid, COLOR_GREY, !"Ваш ранг слишком мал для использования данной команды");
    if(GetPVarInt(params[0],"PlayerCuffed") == 0) return SCM(playerid, COLOR_GREY, !"Игрок должен находиться в наручниках");
	if(!IsPlayerInAnyVehicle(playerid)) return  SCM(playerid, COLOR_GREY, !"Вы должны находиться в автомобиле");
	new Float:x,Float:y,Float:z;
	new car = GetPlayerVehicleID(playerid);
	GetPlayerPos(params[0],x,y,z);
	if(!PlayerToPoint(5.0, playerid, x,y,z)) return SCM(playerid, COLOR_GREY, !"Данный игрок слишком далеко от Вас");
    if(car == police_car[0] || car == police_car[1] ||car == police_car[2] || car == police_car[3] || car == police_car[4] || car == police_car[5] || car == police_car[6] || car == police_car[7]) 
	{
	    if(GetFreeSeat(car) == -1) return SCM(playerid, COLOR_GREY, !"В машине нет места");
	   
	    new str[25+MAX_PLAYER_NAME*2];
	    
		PutPlayerInVehicleAC(params[0],car,GetFreeSeat(car));
     	FreezePlayer(params[0]);
	    format(str,sizeof(str),"%s затащил в автомобиль %s",getName(playerid),getName(params[0]));
	    ProxDetector(30.0, playerid, str,0xFF99CCFF,0xFF99CCFF,0xFF99CCFF,0xFF99CCFF,0xFF99CCFF);
	}
	else SCM(playerid, COLOR_GREY, !"Данный транспорт не предназначен для перевозки преступников");
	return 1;
}
CMD:uncar(playerid,params[]) 
{
    if(!IsPlayerCops(playerid)) return SCM(playerid, COLOR_GREY, !"Данная команда Вам недоступна");
    if(sscanf(params, "u", params[0])) return SCM(playerid, COLOR_LIGHTGREY, !"Используйте: /uncar [ID игрока]");
    if(!IsPlayerConnected(params[0]))return  SCM(playerid, COLOR_GREY, !"Игрок не в сети");
	if(!IsPlayerLogged{params[0]}) return  SCM(playerid, COLOR_GREY, !"Игрок не авторизован");
    if(PI[playerid][pRang] < 2 && PI[playerid][pMember] != 8) return SCM(playerid, COLOR_GREY, !"Ваш ранг слишком мал для использования данной команды");
    if(!IsPlayerInAnyVehicle(params[0])) return SCM(playerid, COLOR_GREY, !"Игрок должен находиться в транспорте");
	new Float:x,Float:y,Float:z,str[145];
	GetPlayerPos(playerid,x,y,z);
	if(!PlayerToPoint(5.0, playerid, x,y,z)) return SCM(playerid, COLOR_GREY, !"Данный игрок слишком далеко от Вас");
 	UnfreezePlayer(params[0]);
 	SetPlayerPosAC(params[0],x+1.0,y,z);
  	format(str,sizeof(str),"%s вытащил из автомобиля %s",getName(playerid),getName(params[0]));
  	return ProxDetector(30.0, playerid, str,0xFF99CCFF,0xFF99CCFF,0xFF99CCFF,0xFF99CCFF,0xFF99CCFF);
}
CMD:setmark(playerid, params[])
{
    new targetid;
    if (!IsPlayerCops(playerid)) return SCM(playerid, COLOR_GREY, !"Данная команда Вам недоступна");
    if (sscanf(params, "d", targetid)) return SCM(playerid, COLOR_LIGHTGREY, !"Используйте: /setmark [ID игрока]");
    if (!IsPlayerConnected(targetid)) return SCM(playerid, COLOR_GREY, !"Игрок не в сети");
    if (!IsPlayerLogged{targetid}) return SCM(playerid, COLOR_GREY, !"Игрок не авторизован");
    if (GetPlayerInterior(targetid) != 0) return SCM(playerid, COLOR_GREY, !"Игрок находится в интерьере");
    if (PI[targetid][pWanted] == 0) return SCM(playerid, COLOR_GREY, !"Данный игрок не находится в розыске");

    if (GetPVarInt(playerid, "Counting_setmark") > gettime()) return SCM(playerid, COLOR_GREY, !"Данную функцию можно использовать только один раз в минуту");

    new Float:x, Float:y, Float:z;
    GetPlayerPos(targetid, x, y, z);
    SetPVarFloat(playerid, "gps_pos_x", x);
    SetPVarFloat(playerid, "gps_pos_y", y);
    SetPVarFloat(playerid, "gps_pos_z", z);
    DisablePlayerCheckpoint(playerid);
    SetPlayerCheckpoint(playerid, x, y, z, 5.0);

    SCM(playerid, 0x6699cc3FF, !"Последнее местоположение подозреваемого отмечено у Вас на мини-карте");
    SCM(playerid, 0x6699cc3FF, !"Оно будет автоматически обновляться в течение 30 секунд");

    SetPVarInt(playerid, "Counting_setmark", gettime() + 60);
    return 1;
}
CMD:wanted(playerid)
{
    if (!IsPlayerCops(playerid)) return SCM(playerid, COLOR_GREY, !"Данная команда Вам недоступна");

    new str_3[1024], bugfix;
    for (new i = 0; i < MAX_PLAYERS; i++) 
    {
        if (!IsPlayerConnected(i)) continue;
        if (PI[i][pWanted] != 0) 
        {
            bugfix = 1;
            format(str_3, sizeof(str_3), "%s\n{FFFFFF}Дело №%d, имя: %s, уровень розыска: %d\n", str_3, i, PI[i][pName], PI[i][pWanted]);
        }
    }

    if (bugfix == 0) return ShowPlayerDialog(playerid, 0, DIALOG_STYLE_MSGBOX, "{ee3366}Преступники", "Область чиста, преступники не обнаружены!", "Закрыть", "");
    return ShowPlayerDialog(playerid, 0, DIALOG_STYLE_LIST, "{ee3366}Преступники", str_3, "Закрыть", "");
}
CMD:m(playerid,params[]) 
{
    if(sscanf(params, "s[80]", params[0])) return SCM(playerid, COLOR_LIGHTGREY, !"Используйте: /m [текст]");
    if(!IsPlayerCops(playerid)) return SCM(playerid, COLOR_GREY, !"Данная команда Вам недоступна");
    new car = GetPlayerVehicleID(playerid);
	if(GetVehicleModel(car) == 598 || GetVehicleModel(car) == 551 || GetVehicleModel(car) == 427 || GetVehicleModel(car) == 443 || GetVehicleModel(car) == 597 ||
	GetVehicleModel(car) == 427 || GetVehicleModel(car) == 599 || GetVehicleModel(car) == 490) 
    {
	    global_str[0] = EOS, format(global_str, 144, "[М] %s[%d]: %s",getName(playerid),playerid,params[0]);
		ProxDetector(50.0, playerid, global_str, 0xFACC2EFF, 0xFACC2EFF, 0xFACC2EFF, 0xFACC2EFF, 0xFACC2EFF);
	}
	else SCM(playerid, COLOR_GREY, !"Данный транспорт не оснащен мегафоном");
	return 1;
}
CMD:tome(playerid, params[]) 
{
	new id;
	if(!IsPlayerCops(playerid)) return SCM(playerid, COLOR_GREY, !"Данная команда Вам недоступна");
	if(sscanf(params, "u", id)) return SCM(playerid, COLOR_LIGHTGREY, !"Используйте: /tome [ID игрока]"); 
	{
        if(playerid == id) return SCM(playerid, COLOR_GREY, !"Вы не можите сопровождать самого себя ");
        else if(!IsPlayerConnected(id)) return SCM(playerid, COLOR_GREY, !"Игрок не в сети");
        else if(IsPlayerInAnyVehicle(playerid)) return SCM(playerid, COLOR_GREY, !"Вы не можете потащить с машины");
        else if(FollowBy[playerid] != INVALID_PLAYER_ID) return SCM(playerid, COLOR_GREY, !"Вы не можете вести больше игроков");
        else if(GetPVarInt(params[0],"PlayerCuffed") == 1) return SCM(playerid, COLOR_GREY, !"Игрок должен быть в наручниках");
        else if(IsPlayerInAnyVehicle(id)) return SCM(playerid, COLOR_GREY, !"Вы не можете потащить за собой когда игрок в машине");
        new Float: X, Float: Y, Float: Z; GetPlayerPos(id, X, Y, Z);
        if(!IsPlayerInRangeOfPoint(playerid, 1.5, X, Y, Z)) return SCM(playerid, COLOR_GREY, !"Игрок далеко от вас");
        else if(FollowBy[id] != INVALID_PLAYER_ID) 
        {
            SetPVarInt(playerid, "TempFollowBy", -1);
            FollowBy[id] = INVALID_PLAYER_ID;
            KillTimer(TimerForPlayer[id]);
            TimerForPlayer[id] = INVALID_PLAYER_ID;
            ClearAnimations(playerid);
            TogglePlayerControllable(id, 1);
            SCMf(playerid, COLOR_GREY, "Вы больше не контролируете %s", PI[id][pName]);
            return SCMf(id, COLOR_GREY, "%s %s перестал Вас контролировать", rang_police[PI[playerid][pRang]-1][frName], PI[playerid][pName]);
        }
        if(GetPVarInt(playerid, "TempFollowBy") != -1) return SCM(playerid, COLOR_GREY, !"Вы не можете сопровождать больше 2х игроков одновременно");
        FollowBy[id] = playerid;
        SetPVarInt(playerid, "TempFollowBy", id);
        TimerForPlayer[id] = SetTimerEx("FollowToPlayer", 1000, 1, "i", id);
        SCMf(playerid, COLOR_GREY, "Вы начали контролировать игрока %s", PI[id][pName]);
        return SCMf(id, COLOR_GREY, "Сотрудник Полции %s начал Вас контролировать", PI[id][pName]);
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
		SCMf(FollowBy[playerid], COLOR_GREY, "Вы больше не контролируете %s",PI[GetPVarInt(playerid, "TempFollowBy")][pName]);
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
		SCMf(FollowBy[playerid], COLOR_GREY, "Вы больше не контролируете %s",PI[GetPVarInt(playerid, "TempFollowBy")][pName]);
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
		SCMf(FollowBy[playerid], COLOR_GREY, "Вы больше не контролируете %s",PI[GetPVarInt(playerid, "TempFollowBy")][pName]);
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
stock police_OnDialogResponse(playerid, dialogid, response, listitem)
{
    switch(dialogid)
    {
        case 2340:
        {
            if(!response) return DeletePVar(playerid, "PoliceSearch");
	        if(response) 
			{
                new id = GetPVarInt(playerid, "PoliceSearch");

                switch(listitem)
                {
                    case 0: return 1;
                    case 1:
                    {
                        if(PI[id][pDriveLicense] == 0) return SCM(playerid, COLOR_LIGHTGREY, !"У игрока нет лицензии на вождение транспорта");
                        PI[id][pDriveLicense] = 0;
                        SCMf(playerid, COLOR_BLACKBLUE, "Вы изъяли лицензию на вождение у игрока %s", getName(id));
                        SCMf(id, COLOR_BLACKBLUE, "%s %s изъял у Вас лицензию на вождение", NameRang(playerid), getName(playerid));
                    }
                    case 2:
                    {
                        if(PI[id][pGunLicense] == 0) return SCM(playerid, COLOR_LIGHTGREY, !"У игрока нет лицензии на ношение оружия");
                        PI[id][pGunLicense] = 0;
                        SCMf(playerid, COLOR_BLACKBLUE, "Вы изъяли лицензию на ношение оружия у игрока %s", getName(id));
                        SCMf(id, COLOR_BLACKBLUE, "%s %s изъял у Вас лицензию на ношение оружия", NameRang(playerid), getName(playerid));
                    }
                    case 3:
                    {
                        new bangun = 0, weapon_id, ammo;
                        new const forbiddenWeapons[] = {20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34};

                        for (new i = 0; i <= 12; i++)
                        {
                            GetPlayerWeaponData(id, i, weapon_id, ammo);
                            if (weapon_id == 0) continue;

                            for (new j = 0; j < sizeof(forbiddenWeapons); j++)
                            {
                                if (weapon_id == forbiddenWeapons[j])
                                {
                                    bangun = 1;
                                    break;
                                }
                            }
                            if (bangun) break; 
                        }

                        if (bangun == 0) return SCM(playerid, COLOR_LIGHTGREY, !"У игрока нет запрещённого оружия");

                        SCMf(playerid, COLOR_BLACKBLUE, "Вы изъяли запрещённое оружие у игрока %s", getName(id));
                        SCMf(id, COLOR_BLACKBLUE, "%s %s изъял у Вас запрещённое оружие", NameRang(playerid), getName(playerid));

                        ResetWeaponAll(id);
                    }
                    case 4:
                    {
                        if(PI[id][pDrugs] == 0) return SCM(playerid, COLOR_LIGHTGREY, !"У игрока нет веществ");
                        SCMf(playerid, COLOR_BLACKBLUE, "Вы изъяли %d ед. веществ у игрока %s", PI[playerid][pDrugs], getName(id));
                        SCMf(id, COLOR_BLACKBLUE, "%s %s изъял у Вас %d ед. веществ", NameRang(playerid), getName(playerid), PI[playerid][pDrugs]);
                        PI[id][pDrugs] = 0;
                    }
                }
            }
        }
    }
    return 1;
}