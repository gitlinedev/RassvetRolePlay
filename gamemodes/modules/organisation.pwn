CMD:setrang(playerid, params[])
{
	if(PI[playerid][pMember] <= 0) return 0;
    if(PI[playerid][pRang] < 9) return SCM(playerid, COLOR_GREY, !"Данная команда доступна только лидерам и заместителям");

    if(sscanf(params,"rs[3]",  params[0], params[1])) return SCM(playerid, COLOR_LIGHTGREY, !"Используйте: /setrang [ID игрока] [+/-]");

    if(PI[params[0]][pRankUPTime] > gettime()) return SendClientMessage(playerid, COLOR_GREY, !"Понижать/повышать можно раз в 24 часа");
    if(PI[params[0]][pRang] == 10) return SCM(playerid, COLOR_GREY, !"Вы не можете изменять ранг лидеру");

    if(PI[playerid][pRang] == 9) 
    {
        if(params[1] == 43) if(PI[params[0]][pRang]+1 > 8) return SCM(playerid, COLOR_GREY, !"Вы не можете выдать ранг больше 8");
    }

    if(PI[playerid][pRang] <= PI[params[0]][pRang]) return SCM(playerid, COLOR_GREY, !"Вы не можете управлять рангом игрока схожим с Вами");
    if(PI[params[0]][pMember] != PI[playerid][pMember]) return SCM(playerid, COLOR_GREY, !"Игрок находиться в другой организации!");
    if(!IsPlayerConnected(params[0])) return SCM(playerid, COLOR_GREY, !"Игрок не найден");

    new oldrang = PI[params[0]][pRang];

    if(params[1] == 43) // повысить 
    {
        if(PI[params[0]][pRang]+1 > 9) return SendClientMessagef(playerid, COLOR_LIGHTGREY, !"Вы не можете повысить этого игрока, так как его ранг равен 9 или больше");
        PI[params[0]][pRang]++;
        SetRang("log_setrang", getName(playerid), PI[params[0]][pRang], getName(params[0]), "повысил");
    }
    else if(params[1] == 45) // понизить
    {
        if(PI[params[0]][pRang]-1 < 1) return SendClientMessagef(playerid, COLOR_LIGHTGREY, !"Вы не можете понизить этого игрока, так как его ранг равен 1");
        PI[params[0]][pRang]--;
        SetRang("log_setrang", getName(playerid), PI[params[0]][pRang], getName(params[0]), "понизил");
    }
	SendFractionMessagef(PI[playerid][pMember], 0x9eceffFF, "[R] %s %s[%d] %s ранг %s[%d] до %s[%d]",\
		NameRang(playerid), getName(playerid), playerid, oldrang < PI[params[0]][pRang] ? ("понизил"):("повысил"),\
		getName(params[0]), params[0], NameRang(params[0]), PI[params[0]][pRang]);

	SCMf(params[0], 0x9eceffFF, "%s %s[%d] %s Ваш ранг до %s[%d]", NameRang(playerid), getName(playerid), playerid, oldrang < PI[params[0]][pRang] ? ("понизил"):("повысил"), NameRang(params[0]), PI[params[0]][pRang]);
	SCMf(playerid, 0x9eceffFF, "Вы %s %s[%d] до %s[%d]", oldrang > PI[params[0]][pRang] ? ("понизили"):("повысили"), getName(params[0]), params[0], NameRang(params[0]), PI[params[0]][pRang]);
	UpdatePlayerDataInt(params[0], "rank", PI[params[0]][pRang]);
	UpdatePlayerDataInt(params[0], "RankUPTime", gettime()+86400);
	SavePlayerData(params[0]);
	return 1;
}
//================================ [ группы ] =================================//
callback: EditGroup(playerid) 
{
    new rows, fields;
    new gname[MAX_PLAYER_NAME];
    new str_tablist[1024];
    cache_get_data(rows, fields);

    format(str_tablist, sizeof(str_tablist), "{FFFF99}Создать группу\n");

    for(new i = 0; i < rows; i++) 
    {
        cache_get_field_content(i, "group_name", gname, mysql, MAX_PLAYER_NAME);
        format(str_tablist, sizeof(str_tablist), "%s%s\n", str_tablist, gname);
    }

    ShowPlayerDialog(playerid, 3211, DIALOG_STYLE_LIST, "{ee3366}Управление группами", str_tablist, "Изменить", "");
    return 1;
}
stock EditGroups(playerid) 
{
	ShowPlayerDialog(playerid, 3212, DIALOG_STYLE_LIST, !"{ee3366}Управление группами",
	"1. Информация\n\
	2. Список участников\n\
	3. Сделать стандартной\n\
	4. Изменить мужской скин\n\
	5. Изменить женский скин\n\
	6. Переименовать\n\
	{FFFF99}7. Удалить", !"Выбрать", !"Закрыть");
}
CMD:setgroup(playerid,params[]) 
{
    if(PI[playerid][pRang] < 9) return SCM(playerid, COLOR_GREY, !"Данная команда доступна лидерам организаций и их заместителям");
    if(sscanf(params, "u",params[0])) return SendClientMessage (playerid, COLOR_GREY, !"Используйте: /setgroup [ID игрока]");
	if(!IsPlayerConnected(params[0])) return  SCM(playerid, COLOR_GREY, !"Игрок не в сети");
	if(!IsPlayerLogged{params[0]}) return SCM(playerid, COLOR_GREY, !"Игрок не авторизован");
    if(PI[playerid][pMember] != PI[params[0]][pMember]) return SCM(playerid, COLOR_GREY, !"Данный игрок не состоит в Вашей организации");
	SetPVarInt(playerid, "idgroup", params[0]);

	mysql_string[0] = EOS, f(mysql_string, 70, "SELECT * FROM `group` WHERE `fraction` = '%d'", PI[playerid][pMember]);
    mysql_tquery(mysql, mysql_string, "SetGroup", "i", playerid);

	SetPVarInt(playerid, "idg", params[0]);
	return 1;
}
callback: SetGroup(playerid) 
{
    new rows, fields, temp[5];
    new GroupName[45], str_1[512], str_3[640]; 

    cache_get_data(rows, fields);
    str_1[0] = EOS; 

	new PlayerGroupID = PI[GetPVarInt(playerid, "idg")][pGroupID];
    for (new i = 0; i < rows; i++) 
    {
        new groupid;
		cache_get_field_content(i, "id", temp), groupid = strval (temp);
        cache_get_field_content(i, "group_name", GroupName, mysql, sizeof(GroupName) - 1);

        if (groupid == PlayerGroupID)
        {
            strcat(str_1, "{33dd66}", sizeof(str_1));
            strcat(str_1, GroupName, sizeof(str_1));
            strcat(str_1, "{FFFFFF}", sizeof(str_1));
        }
        else
        {
            strcat(str_1, GroupName, sizeof(str_1));
        }
        
        strcat(str_1, "\n", sizeof(str_1)); 
    }

    format(str_3, sizeof(str_3), "{FFFF99}Удалить из группы\n%s", str_1);
    ShowPlayerDialog(playerid, 3210, DIALOG_STYLE_LIST, "{ee3366}Выбор группы игрока", str_3, "Выбрать", "Отмена");
    return 1;
}
callback: LoadGroups() 
{
    new rows, fields, temp[60],time = GetTickCount();
    cache_get_data(rows, fields);
    if(rows) 
	{
    	for(new g = 0; g < rows; g++) 
		{
	        cache_get_field_content(g, "id", temp), group[g][g_ID] = strval (temp);
	        cache_get_field_content(g, "fraction", group[g][g_FRACTION], mysql, MAX_PLAYER_NAME);
	        cache_get_field_content(g, "group_name", group[g][g_NAME], mysql, 50);
	        cache_get_field_content(g, "skin_m", temp), group[g][g_SKIN] = strval (temp);
	        cache_get_field_content(g, "skin_g", temp), group[g][g_SKING] = strval (temp);
	        cache_get_field_content(g, "standart", temp), group[g][g_STANDART] = strval (temp);
	    }
        printf("[INFO]  Load group. Load: %d g. Time: %d ms.",TotalGroup,GetTickCount()-time);
  	}
    return 1;
}
callback: SetGroupPlayer(playerid) 
{
    new rows, fields, GroupID, temp[32], GroupName[32], SkinM, SkinF, id = GetPVarInt(playerid, "idg");
    cache_get_data(rows, fields);
    for(new i = 0; i < rows; i++) 
	{
		cache_get_field_content(i, "id", temp), GroupID = strval(temp);
		cache_get_field_content(i, "group_name", GroupName, mysql, 32);
		cache_get_field_content(i, "skin_m", temp), SkinM = strval(temp);
		cache_get_field_content(i, "skin_g", temp), SkinF = strval(temp);
	}
	if(PI[id][pRang] != 10) 
	{
		if(SkinM == 236 || SkinM == 117 || SkinM == 118) return SCM(playerid, COLOR_GREY, !"Вы не можете выдать группу лидера");
	}


	PI[id][pGroupID] = GroupID;
	UpdatePlayerDataInt(id, "GroupID", PI[id][pGroupID]);
	strmid(PI[id][pGroupName], GroupName, 0, strlen(GroupName), 25);

	SendFractionMessagef(PI[playerid][pMember], 0x69b867FF, "[R] %s %s[%d] включил %s %s[%d] в группу ('%s')",\ 
		NameRang(playerid), getName(playerid),playerid, NameRang(id), PI[id][pName], id, PI[id][pGroupName]);

	
	if(PI[id][pRang] < 10)
	{
		if(PI[id][pSex] == 1)
		{
		    if(SkinM > 0) PI[id][pOrgSkin] = SkinM;
		}
		if(PI[id][pSex] == 2)
		{
		    if(SkinF > 0) PI[id][pOrgSkin] = SkinF;
		}
		SetPlayerSkinAC(id, PI[id][pOrgSkin]);
	}
	DeletePVar(playerid, "idg");
	return 1;
}
callback: PlayerGroup(playerid) 
{
    new rows, fields, GroupName[45];
    cache_get_data(rows, fields);
    for(new i = 0; i < rows; i++) 
	{
        if(rows) 
		{
			cache_get_field_content(i, "group_name", GroupName, mysql, 44);
			strmid(PI[playerid][pGroupName], GroupName, 0, strlen(GroupName), 25);
		}
		else 
		{
		    PI[playerid][pGroupID] = -1;
			UpdatePlayerDataInt(playerid, "GroupID", PI[playerid][pGroupID]);
		}
	}
    return 1;
}
callback: InfoGroup(playerid) {
    new rows, fields,gname[32],temp[60],g,m,stand;
    cache_get_data(rows, fields);
    for(new i = 0; i < rows; i++) {
		cache_get_field_content(i, "group_name", gname, mysql, 32);
		cache_get_field_content(g, "skin_m", temp), m = strval (temp);
		cache_get_field_content(g, "skin_g", temp), g = strval (temp);
		cache_get_field_content(g, "standart", temp), stand = strval (temp);
		new standart[64];
		switch(stand) {
			case 0: format(standart,sizeof(standart),"Нет");
			case 1: format(standart,sizeof(standart),"Да");
		}
		new skinm[64];
		switch(m) {
			case 0: format(skinm,sizeof(skinm),"Нет");
			case 1..311: format(skinm,sizeof(skinm),"%d", m);
		}
		new sking[64];
		switch(g) {
			case 0: format(sking,sizeof(sking),"Нет");
			case 1..311: format(sking,sizeof(sking),"%d", g);
		}
		new str_i[144];
		format(str_i,sizeof(str_i),"\
		{FFFFFF}Название: {3377cc}%s{FFFFFF}\n\
		Мужской скин: {3377cc}%s{FFFFFF}\n\
		Женский скин: {3377cc}%s{FFFFFF}\n\
		Стандартная: {3377cc}%s{FFFFFF}",gname,skinm,sking,standart);
		ShowPlayerDialog(playerid, 0, DIALOG_STYLE_MSGBOX, !"{ee3366}Информация о группе", str_i, "Закрыть", "");
	}
    return 1;
}
callback: AllMGroup(playerid) 
{
    new rows, fields,temp[10];
    new name[MAX_PLAYER_NAME], rank, LoginDate[30], str_1[512];
    cache_get_data(rows, fields);
    for(new i = 0; i < rows; i++) 
	{
		cache_get_field_content(i, "name", name, mysql, MAX_PLAYER_NAME);
		cache_get_field_content(i, "LoginDate", LoginDate, mysql, 30);
		cache_get_field_content(i, "rank", temp), rank = strval (temp);
		format(str_1,sizeof(str_1),"%s {FFFFFF}%s\t%d\t%s\n", str_1, name, rank, LoginDate);
	}
	ShowPlayerDialogf(playerid,0, DIALOG_STYLE_TABLIST_HEADERS, "{ee3366}Список участников организации с группой", "Закрыть", "", "Имя\tРанг\tПоследний вход\n%s",str_1);
	return 1;
}
callback: IDGroup(playerid) 
{
    new rows, fields, temp[10], GroupID;
    cache_get_data(rows, fields);
    for(new i = 0; i < rows; i++) 
	{
		cache_get_field_content(i, "id", temp), GroupID = strval (temp);
	}
    mysql_string[0] = EOS, f(mysql_string, 48, "SELECT * FROM `accounts` WHERE `GID` = '%d'", GroupID);
    mysql_tquery(mysql, mysql_string, "AllMGroup", "i", playerid);
	return 1;
}
callback: CheckStandart(playerid) 
{
    new rows, fields;
    cache_get_data(rows, fields);
    if(rows) ShowPlayerDialog(playerid, 0, DIALOG_STYLE_MSGBOX, !"{ee3366}Ошибка", !"{AFAFAF}В Вашей организации уже есть стандартная группа.\n\
                                                                                    {FFFF99}Вы можете переименовать её или же изменить скин.", !"Закрыть", !"");
    else 
    {
		new GroupName[24];
		GetPVarString(playerid,"gtext", GroupName, sizeof(GroupName));
		FixSVarString(GroupName);

        mysql_string[0] = EOS, f(mysql_string, 110, "SELECT * FROM `group` WHERE `fraction` = '%d' AND `group_name` = '%e'", PI[playerid][pMember], GroupName);
        mysql_tquery(mysql, mysql_string, "SetStandart", "i", playerid);

		DeletePVar(playerid, "gtext");
	}
	return 1;
}
callback: SetStandart(playerid) 
{
    new rows, fields, GroupName[32];
    cache_get_data(rows, fields);
    for(new i = 0; i < rows; i++) 
    {
		cache_get_field_content(i, "group_name", GroupName, mysql, 32);
        mysql_queryf(mysql, "UPDATE `group` SET `standart` = '1' WHERE `group_name` = '%e' AND `fraction` = '%d'", false, GroupName, PI[playerid][pMember]);
		SCMf(playerid, COLOR_GREENNEW, "Вы успешно сделали группу {FFFF00}('%s'){00aa33} стандартной", GroupName);
	}
	return 1;
}
callback: SetPlayerStandartGroup(playerid) 
{
    new rows, fields, temp[10];
    new skinMale, skinFemale, groupID, GroupName[25];

    cache_get_data(rows, fields);
    for(new i = 0; i < rows; i++) 
	{
		cache_get_field_content(i, "id", temp), groupID = strval (temp);
		cache_get_field_content(i, "skin_m", temp), skinMale = strval(temp);
		cache_get_field_content(i, "skin_g", temp), skinFemale = strval(temp);
		cache_get_field_content(i, "group_name", GroupName, mysql, 25);
		strmid(PI[playerid][pGroupName], GroupName, 0, strlen(GroupName), 25);

		PI[playerid][pGroupID] = groupID;
		UpdatePlayerDataInt(playerid, "GroupID", PI[playerid][pGroupID]);

		if(PI[playerid][pRang] != 10)
		{
			if(PI[playerid][pSex] == 1)
			{
				PI[playerid][pOrgSkin] = skinMale;
				SetPlayerSkinAC(playerid, PI[playerid][pOrgSkin]);
			}
			if(PI[playerid][pSex] == 2)
			{
				PI[playerid][pOrgSkin] = skinFemale;
				SetPlayerSkinAC(playerid, PI[playerid][pOrgSkin]);
			}
		}
	}
	return 1;
}
callback: ChangeSkinM(playerid)
{
    new rows, fields, GroupName[32], Skin = GetPVarInt(playerid, "Temp_GroupSkin");
    cache_get_data(rows, fields);
    for(new i = 0; i < rows; i++) 
    {
		cache_get_field_content(i, "group_name", GroupName, mysql, 32);

        mysql_queryf(mysql, "UPDATE `group` SET `skin_m` = '%d' WHERE `group_name` = '%e' AND `fraction` = '%d'", false, Skin, GroupName, PI[playerid][pMember]);

		if(Skin > 0) SCMf(playerid, COLOR_GREENNEW, "Вы успешно изменили скин в группе {FFFF00}('%s'){00aa33} на {FFFF00}('%d')", GroupName, Skin);
		else SCMf(playerid, COLOR_GREENNEW, "Вы успешно сбросили скин в группе {FFFF00}('%s')", GroupName);
	}
	return 1;
}
callback: ChangeSkinG(playerid) 
{
    new rows, fields, GroupName[32], Skin = GetPVarInt(playerid, "Temp_GroupSkin");
    cache_get_data(rows, fields);
    for(new i = 0; i < rows; i++) 
    {
		cache_get_field_content(i, "group_name", GroupName, mysql, 32);

        mysql_queryf(mysql, "UPDATE `group` SET `skin_g` = '%d' WHERE `group_name` = '%e' AND `fraction` = '%d'", false, Skin, GroupName, PI[playerid][pMember]);

		if(Skin > 0) SCMf(playerid, COLOR_GREENNEW, "Вы успешно изменили скин в группе {FFFF00}('%s'){00aa33} на {FFFF00}('%d')", GroupName, Skin);
		else SCMf(playerid, COLOR_GREENNEW, "Вы успешно сбросили скин в группе {FFFF00}('%s')", GroupName);
	}
	return 1;
}
callback: CheckDelete(playerid) 
{
    new rows, fields, Default, GroupName[32], temp[32];
    cache_get_data(rows, fields);
    for(new i = 0; i < rows; i++) 
    {
		cache_get_field_content(i, "standart", temp), Default = strval(temp);
		cache_get_field_content(i, "group_name", GroupName, mysql, 32);
		if(Default != 1) 
        {
			mysql_string[0] = EOS, mysql_format(mysql, mysql_string, 110, "SELECT * FROM `group` WHERE `fraction` = '%d' AND `group_name` = '%e'", PI[playerid][pMember], GroupName);
			mysql_function_query(mysql, mysql_string, true, "DeleteGroup", "i", playerid);
		}
		else ShowPlayerDialog(playerid, 0, DIALOG_STYLE_MSGBOX, !"{ee3366}Ошибка", !"{FFFFFF}Нельзя удалить стандартную группу!\n\
                                                                                    {FFFF99}Вы можете переименовать её или же изменить скин.", !"Закрыть", !"");
	}
	return 1;
}
callback: DeleteGroup(playerid) 
{
    new rows, fields, GroupName[32];
    cache_get_data(rows, fields);
    for(new i = 0; i < rows; i++) 
    {
		cache_get_field_content(i, "group_name", GroupName, mysql, 32);
		SendFractionMessagef(PI[playerid][pMember], COLOR_TOMATO, "[R] %s удалил группу '%s'", getName(playerid), GroupName);
		SCMf(playerid, COLOR_GREENNEW, "Вы успешно удалили группу {FFFF00}('%s')", GroupName);
        mysql_queryf(mysql, "DELETE FROM `group` WHERE `fraction` = '%d' AND `group_name` = '%e'", false, PI[playerid][pMember], GroupName);
	}
	return 1;
}