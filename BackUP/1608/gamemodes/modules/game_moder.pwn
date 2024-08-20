static const stock ModerName[4][17] = {
	"Игрок",
 	"Junior Moderator",
 	"Moderator",
 	"Senior Moderator"
};

CMD:makemoder(playerid, params[]) 
{
    if(CheckAccess(playerid, 8)) return 1;
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
	                    SCMf(i, COLOR_YELLOW, "Игровой мастер %s снял Вас с должности игрового модератора", getName(playerid));
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
 	if(CheckAccess(playerid, 1, 1)) return 0;

	SCMf(playerid, COLOR_BLUE, "Игровые модераторы онлайн (в сети: %d, из них в АФК: NaN)", Iter_Count(Moder));

	new str_1[512];

	foreach(Moder, i)
	{
		if !PI[i][pModer] *then continue;

		if(GetPVarInt(i, "SpecBool") != 0) format(str_1, sizeof(str_1), "%s[%d] - %s - /re %d- [AFK: %d]. Выговоры [%d/3] (Репорты: %d)", getName(i), i, ModerName[PI[i][pModer]], GetPVarInt(i,"SpecID"), PI[i][pAFK], PI[i][pModerWarn], PI[i][pAdminReports]);
		else format(str_1, sizeof(str_1), "%s[%d] - %s - [AFK: %d]. Выговоры [%d/3] (Репорты: %d)", getName(i), i, ModerName[PI[i][pModer]], PI[i][pAFK], PI[i][pModerWarn], PI[i][pAdminReports]);
		SCM(playerid, COLOR_JOBYELLOW, str_1);

	}
	return 1;
}