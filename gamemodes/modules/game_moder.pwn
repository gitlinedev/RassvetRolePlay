static const stock ModerName[4][17] = {
	"Игрок",
 	"Junior Moderator",
 	"Moderator",
 	"Senior Moderator"
};

CMD:makemoder(playerid, params[]) 
{
    if(CheckAdmin(playerid, 8)) return 1;
    if(sscanf(params,"u",params[0])) return SCM(playerid, COLOR_LIGHTGREY, !"Используйте: /makemoder [ID игрока]");
	if(!IsPlayerConnected(params[0])) return  SCM(playerid, COLOR_GREY, !"Игрок не в сети");
	if(!IsPlayerLogged{params[0]}) return  SCM(playerid, COLOR_GREY, !"Игрок не авторизован");
	if(PI[playerid][pAdmin] < PI[params[0]][pAdmin]) return SCM(playerid, COLOR_GREY, !"Нельзя изменить уровень игрового мастера который выше Вас");
	SetPVarInt(playerid, "AdmID", params[0]);
	return ShowPlayerDialog(playerid, 9500, DIALOG_STYLE_LIST, !"{ee3366}Выдача прав игрового модератора", !"\
	Снять права игрового модератора\n\
	1. Junior Moderator\n\
	2. Moderator\n\
	3. Senior Moderator", !"Далее", !"Отмена");
}

stock gm_OnDialogResponse(playerid, dialogid, response, listitem)
{
	switch(dialogid)
	{
		case 9500: 
		{
            if(!response) return 1;
            if(response) 
			{
             	new i = GetPVarInt(playerid, "AdmID");
   				switch(listitem) 
				{
	                case 0: 
					{
	                    PI[i][pModer] = 0;
	                    SCM(playerid, COLOR_YELLOW, !"Вы были сняты с поста игрового модератора!");
	                    SCM(i, COLOR_YELLOW, !"Игровой мастер снял Вас с должности игрового модератора");
	                    UpdatePlayerDataInt(i, "Admin", PI[i][pModer]);
	                }
	                case 1: 
					{
	                    PI[i][pModer] = 1;
	                    SCMf(playerid, COLOR_YELLOW, "Вы изменили уровень игрового модератора для %s[%d], теперь он 'Junior Moderator'", PI[i][pName], i);
	                    SCM(i, COLOR_YELLOW, !"Игровой мастер изменил ваш уровень до Junior Moderator");
	                    UpdatePlayerDataInt(i, "Admin", PI[i][pModer]);
	                }
	                case 2: 
					{
	                    PI[i][pModer] = 2;
	                    SCMf(playerid, COLOR_YELLOW, "Вы изменили уровень игрового модератора для %s[%d], теперь он 'Moderator'", PI[i][pName], i);
	                    SCM(i, COLOR_YELLOW, !"Игровой мастер изменил ваш уровень до Moderator");
	                    UpdatePlayerDataInt(i, "Admin", PI[i][pModer]);
	                }
	                case 3: 
					{
	                    PI[i][pModer] = 3;
	                    SCMf(playerid, COLOR_YELLOW, "Вы изменили уровень игрового модератора для %s[%d], теперь он 'Senior Moderator'", PI[i][pName], i);
	                    SCM(i, COLOR_YELLOW, !"Игровой мастер изменил ваш уровень до Senior Moderator");
	                    UpdatePlayerDataInt(i, "Admin", PI[i][pModer]);
	                }
				}
				if(PI[i][pModer] >= 1) Iter_Add(Moder, playerid);
			}
        }
	}
	return 1;
}
CMD:moders(playerid)
{
 	if(CheckAdmin(playerid, 1, 1)) return 0;

	SCMf(playerid, COLOR_BLUE, "Игровые модераторы онлайн (в сети: %d, из них в АФК: NaN)", Iter_Count(Moder));

	new str_1[512];

	foreach(Moder, i)
	{
		if !PI[i][pModer] *then continue;

		if(GetPVarInt(i, "FlyMode") != 0) format(str_1, sizeof(str_1), "%s[%d] - %s - /re %d- [AFK: %d]. Выговоры [%d/3]", getName(i), i, ModerName[PI[i][pModer]], GetPVarInt(i,"specid"), PI[i][data_AFK], PI[i][pModerWarn]);
		else format(str_1, sizeof(str_1), "%s[%d] - %s - [AFK: %d]. Выговоры [%d/3]", getName(i), i, ModerName[PI[i][pModer]], PI[i][data_AFK], PI[i][pModerWarn]);
		SCM(playerid, COLOR_JOBYELLOW, str_1);

	}
	return 1;
}
/*
stock ShowAdmInfo(playerid, targetid) 
{
	cef_emit_event(playerid, "show-spectate");
	cef_emit_event(playerid, "hide-speed");
	new Float:hp,Float:arm;
	new str_pos[40], str_intvw[60], str_info[60], str_hp[15], str_arm[15];
	GetPlayerHealth(targetid,hp);
	GetPlayerArmour(targetid,arm);
	new Float:x, Float:y, Float:z;
	GetPlayerPos(targetid, x, y, z);
	new hour, minute, second;
	gettime(hour, minute, second);

	format(str_pos,sizeof(str_pos),"%.2f, %.2f, %.2f", x, y, z);
	format(str_intvw,sizeof(str_intvw),"%d/%d", GetPlayerVirtualWorld(targetid), GetPlayerInterior(targetid));
	format(str_info,sizeof(str_info),"%s(%d)(#%d/#1)",PI[targetid][pName], targetid, PI[targetid][pID]);
	format(str_hp,sizeof(str_hp),"%.2f HP", hp);
	format(str_arm,sizeof(str_arm),"%.2f ARM", arm);

	cef_emit_event(playerid, "update-spectate", CEFINT(1), CEFSTR(str_info));
	cef_emit_event(playerid, "update-spectate", CEFINT(2), CEFINT(GetPlayerPing(targetid)));
	cef_emit_event(playerid, "update-spectate", CEFINT(3), CEFINT(GetPlayerFPS(targetid)));
	cef_emit_event(playerid, "update-spectate", CEFINT(4), CEFINT(GetPlayerState(targetid)));
	cef_emit_event(playerid, "update-spectate", CEFINT(5), CEFSTR(str_hp));
	cef_emit_event(playerid, "update-spectate", CEFINT(6), CEFSTR(str_arm));
	cef_emit_event(playerid, "update-spectate", CEFINT(7), CEFSTR(str_intvw));
	cef_emit_event(playerid, "update-spectate", CEFINT(8), CEFSTR(str_pos));
	cef_emit_event(playerid, "update-spectate", CEFINT(9), CEFSTR(Player_Speed(targetid)));
	return 1;
}
stock HideAdmInfo(playerid) cef_emit_event(playerid, "hide-spectate");*/