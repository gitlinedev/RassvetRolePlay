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

CMD:setrang(playerid, params[])
{
	if(PI[playerid][pMember] <= 0) return 0;
    if(PI[playerid][pRang] < 9) return SCM(playerid, COLOR_GREY, !"������ ������� �������� ������ ������� � ������������");

    if(sscanf(params,"rs[3]",  params[0], params[1])) return SCM(playerid, COLOR_LIGHTGREY, !"�����������: /setrang [ID ������] [+/-]");

    if(PI[params[0]][pRankUPTime] > gettime()) return SendClientMessage(playerid, COLOR_GREY, !"��������/�������� ����� ��� � 24 ����");
    if(PI[params[0]][pRang] == 10) return SCM(playerid, COLOR_GREY, !"�� �� ������ �������� ���� ������");

    if(PI[playerid][pRang] == 9) 
    {
        if(params[1] == 43) if(PI[params[0]][pRang]+1 > 8) return SCM(playerid, COLOR_GREY, !"�� �� ������ ������ ���� ������ 8");
    }

    if(PI[playerid][pRang] <= PI[params[0]][pRang]) return SCM(playerid, COLOR_GREY, !"�� �� ������ ��������� ������ ������ ������ � ����");
    if(PI[params[0]][pMember] != PI[playerid][pMember]) return SCM(playerid, COLOR_GREY, !"����� ���������� � ������ �����������!");
    if(!IsPlayerConnected(params[0])) return SCM(playerid, COLOR_GREY, !"����� �� ������");

    new oldrang = PI[params[0]][pRang];

    if(params[1] == 43) // �������� 
    {
        if(PI[params[0]][pRang]+1 > 9) return SendClientMessagef(playerid, COLOR_LIGHTGREY, !"�� �� ������ �������� ����� ������, ��� ��� ��� ���� ����� 9 ��� ������");
        PI[params[0]][pRang]++;
        SetRang("log_setrang", getName(playerid), PI[params[0]][pRang], getName(params[0]), "�������");
    }
    else if(params[1] == 45) // ��������
    {
        if(PI[params[0]][pRang]-1 < 1) return SendClientMessagef(playerid, COLOR_LIGHTGREY, !"�� �� ������ �������� ����� ������, ��� ��� ��� ���� ����� 1");
        PI[params[0]][pRang]--;
        SetRang("log_setrang", getName(playerid), PI[params[0]][pRang], getName(params[0]), "�������");
    }
	SendFractionMessagef(PI[playerid][pMember], 0x9eceffFF, "[R] %s %s[%d] %s ���� %s[%d] �� %s[%d]",\
		NameRang(playerid), getName(playerid), playerid, oldrang < PI[params[0]][pRang] ? ("�������"):("�������"),\
		getName(params[0]), params[0], NameRang(params[0]), PI[params[0]][pRang]);

	UpdatePlayerDataInt(params[0], "rank", PI[params[0]][pRang]);
	UpdatePlayerDataInt(params[0], "RankUPTime", gettime()+86400);
	SavePlayerData(params[0]);
	return 1;
}
//================================ [ ������ ] =================================//
callback: EditGroup(playerid) 
{
    new rows, fields, temp[5];
    new GroupName[MAX_PLAYER_NAME], Default;
    new str_tablist[1024];
    cache_get_data(rows, fields);

    format(str_tablist, sizeof(str_tablist), "{FFFF99}������� ������\n");

    for(new i = 0; i < rows; i++) 
    {
        cache_get_field_content(i, "group_name", GroupName, mysql, MAX_PLAYER_NAME);
		cache_get_field_content(i, "default", temp), Default = strval (temp);

		if(Default == 1)
		{
			strcat(str_tablist, "{FFFF99}", sizeof(str_tablist));
            strcat(str_tablist, GroupName, sizeof(str_tablist));
            strcat(str_tablist, "[�����������]{FFFFFF}", sizeof(str_tablist));
		}

        format(str_tablist, sizeof(str_tablist), "%s%s\n", str_tablist, GroupName);
    }

    ShowPlayerDialog(playerid, 3211, DIALOG_STYLE_LIST, "{ee3366}���������� ��������", str_tablist, "��������", "");
    return 1;
}
stock EditGroups(playerid) 
{
	ShowPlayerDialog(playerid, 3212, DIALOG_STYLE_LIST, !"{ee3366}���������� ��������",
	"1. ����������\n\
	2. ������ ����������\n\
	3. ������� �����������\n\
	4. �������� ������� ����\n\
	5. �������� ������� ����\n\
	6. �������������\n\
	{FFFF99}7. �������", !"�������", !"�������");
}
CMD:setgroup(playerid,params[]) 
{
    if(PI[playerid][pRang] < 9) return SCM(playerid, COLOR_GREY, !"������ ������� �������� ������� ����������� � �� ������������");
    if(sscanf(params, "u",params[0])) return SendClientMessage (playerid, COLOR_GREY, !"�����������: /setgroup [ID ������]");
	if(!IsPlayerConnected(params[0])) return  SCM(playerid, COLOR_GREY, !"����� �� � ����");
	if(!IsPlayerLogged{params[0]}) return SCM(playerid, COLOR_GREY, !"����� �� �����������");
    if(PI[playerid][pMember] != PI[params[0]][pMember]) return SCM(playerid, COLOR_GREY, !"������ ����� �� ������� � ����� �����������");
	SetPVarInt(playerid, "idgroup", params[0]);

	mysql_string[0] = EOS, f(mysql_string, 70, "SELECT * FROM `group` WHERE `fraction` = '%d'", PI[playerid][pMember]);
    mysql_tquery(mysql, mysql_string, "SetGroup", "i", playerid);

	SetPVarInt(playerid, "idg", params[0]);
	return 1;
}
callback: SetGroup(playerid) 
{
    new rows, fields, temp[5];
    new GroupName[45], Default, str_1[512], str_3[640]; 

    cache_get_data(rows, fields);
    str_1[0] = EOS; 

	new PlayerGroupID = PI[GetPVarInt(playerid, "idg")][pGroupID];
    for (new i = 0; i < rows; i++) 
    {
        new groupid;
		cache_get_field_content(i, "id", temp), groupid = strval (temp);
		cache_get_field_content(i, "default", temp), Default = strval (temp);
        cache_get_field_content(i, "group_name", GroupName, mysql, sizeof(GroupName) - 1);

        if (groupid == PlayerGroupID)
        {
            strcat(str_1, "{33dd66}", sizeof(str_1));
            strcat(str_1, GroupName, sizeof(str_1));
            strcat(str_1, "{FFFFFF}", sizeof(str_1));
        }
		else if(Default == 1)
		{
			strcat(str_1, "{FFFF99}", sizeof(str_1));
            strcat(str_1, GroupName, sizeof(str_1));
            strcat(str_1, "[�����������]{FFFFFF}", sizeof(str_1));
		}
        else
        {
            strcat(str_1, GroupName, sizeof(str_1));
        }
        
        strcat(str_1, "\n", sizeof(str_1)); 
    }

    format(str_3, sizeof(str_3), "{FFFF99}������� �� ������\n%s", str_1);
    ShowPlayerDialog(playerid, 3210, DIALOG_STYLE_LIST, "{ee3366}����� ������ ������", str_3, "�������", "������");
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
	        cache_get_field_content(g, "default", temp), group[g][g_STANDART] = strval (temp);
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
		if(SkinM == 236 || SkinM == 117 || SkinM == 118) return SCM(playerid, COLOR_GREY, !"�� �� ������ ������ ������ ������");
	}


	PI[id][pGroupID] = GroupID;
	UpdatePlayerDataInt(id, "GroupID", PI[id][pGroupID]);
	strmid(PI[id][pGroupName], GroupName, 0, strlen(GroupName), 25);

	SendFractionMessagef(PI[playerid][pMember], 0x69b867FF, "[R] %s %s[%d] ������� %s %s[%d] � ������ ('%s')",\ 
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
callback: InfoGroup(playerid) 
{
    new rows, fields,gname[32],temp[60],g,m,stand;
    cache_get_data(rows, fields);
    for(new i = 0; i < rows; i++) 
	{
		cache_get_field_content(i, "group_name", gname, mysql, 32);
		cache_get_field_content(g, "skin_m", temp), m = strval (temp);
		cache_get_field_content(g, "skin_g", temp), g = strval (temp);
		cache_get_field_content(g, "default", temp), stand = strval (temp);
		new standart[64];
		switch(stand) 
		{
			case 0: format(standart,sizeof(standart),"���");
			case 1: format(standart,sizeof(standart),"��");
		}
		new skinm[64];
		switch(m) 
		{
			case 0: format(skinm,sizeof(skinm),"���");
			case 1..311: format(skinm,sizeof(skinm),"%d", m);
		}
		new sking[64];
		switch(g) 
		{
			case 0: format(sking,sizeof(sking),"���");
			case 1..311: format(sking,sizeof(sking),"%d", g);
		}
		new str_i[144];
		format(str_i,sizeof(str_i),"\
		{FFFFFF}��������: {3377cc}%s{FFFFFF}\n\
		������� ����: {3377cc}%s{FFFFFF}\n\
		������� ����: {3377cc}%s{FFFFFF}\n\
		�����������: {3377cc}%s{FFFFFF}",gname,skinm,sking,standart);
		ShowPlayerDialog(playerid, 0, DIALOG_STYLE_MSGBOX, !"{ee3366}���������� � ������", str_i, "�������", "");
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
	ShowPlayerDialogf(playerid,0, DIALOG_STYLE_TABLIST_HEADERS, "{ee3366}������ ���������� ����������� � �������", "�������", "", "���\t����\t��������� ����\n%s",str_1);
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
    if(rows) ShowPlayerDialog(playerid, 0, DIALOG_STYLE_MSGBOX, !"{ee3366}������", !"{AFAFAF}� ����� ����������� ��� ���� ����������� ������.\n\
                                                                                    {FFFF99}�� ������ ������������� � ��� �� �������� ����.", !"�������", !"");
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
		SCMf(playerid, COLOR_GREENNEW, "�� ������� ������� ������ {FFFF00}('%s'){00aa33} �����������", GroupName);
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

		if(Skin > 0) SCMf(playerid, COLOR_GREENNEW, "�� ������� �������� ���� � ������ {FFFF00}('%s'){00aa33} �� {FFFF00}('%d')", GroupName, Skin);
		else SCMf(playerid, COLOR_GREENNEW, "�� ������� �������� ���� � ������ {FFFF00}('%s')", GroupName);
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

		if(Skin > 0) SCMf(playerid, COLOR_GREENNEW, "�� ������� �������� ���� � ������ {FFFF00}('%s'){00aa33} �� {FFFF00}('%d')", GroupName, Skin);
		else SCMf(playerid, COLOR_GREENNEW, "�� ������� �������� ���� � ������ {FFFF00}('%s')", GroupName);
	}
	return 1;
}
callback: CheckDelete(playerid) 
{
    new rows, fields, Default, GroupName[32], temp[32];
    cache_get_data(rows, fields);
    for(new i = 0; i < rows; i++) 
    {
		cache_get_field_content(i, "default", temp), Default = strval(temp);
		cache_get_field_content(i, "group_name", GroupName, mysql, 32);
		if(Default != 1) 
        {
			mysql_string[0] = EOS, mysql_format(mysql, mysql_string, 110, "SELECT * FROM `group` WHERE `fraction` = '%d' AND `group_name` = '%e'", PI[playerid][pMember], GroupName);
			mysql_function_query(mysql, mysql_string, true, "DeleteGroup", "i", playerid);
		}
		else ShowPlayerDialog(playerid, 0, DIALOG_STYLE_MSGBOX, !"{ee3366}������", !"{FFFFFF}������ ������� ����������� ������!\n\
                                                                                    {FFFF99}�� ������ ������������� � ��� �� �������� ����.", !"�������", !"");
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
		SendFractionMessagef(PI[playerid][pMember], COLOR_TOMATO, "[R] %s ������ ������ '%s'", getName(playerid), GroupName);
		SCMf(playerid, COLOR_GREENNEW, "�� ������� ������� ������ {FFFF00}('%s')", GroupName);
        mysql_queryf(mysql, "DELETE FROM `group` WHERE `fraction` = '%d' AND `group_name` = '%e'", false, PI[playerid][pMember], GroupName);
	}
	return 1;
}
CMD:l(playerid,params[]) 
{
    if(PI[playerid][pLeader] < 1) return 1;
    if(sscanf(params,"s[90]",params[0])) return SCM(playerid, COLOR_LIGHTGREY, !"�����������: /l [�����]");
    global_str[0] = EOS, f(global_str, 144, "[L] %s %s[%d]: %s", Fraction_Name[PI[playerid][pMember]], getName(playerid),playerid,params[0]);
    SendLeaderMessage(0xCD9B6AFF, global_str);
    return 1;
}
alias:ll("lb");
CMD:ll(playerid,params[]) 
{
    if(PI[playerid][pLeader] < 1) return 1;
    if(sscanf(params,"s[90]",params[0])) return SCM(playerid, COLOR_LIGHTGREY, !"�����������: /lb [�����]");
    global_str[0] = EOS, f(global_str, 144, "(( [L] %s %s[%d]: %s ))", Fraction_Name[PI[playerid][pMember]], getName(playerid),playerid,params[0]);
    SendLeaderMessage(0xCD9B6AFF, global_str);
    return 1;
}
stock SendLeaderMessage(color, text[]) 
{
 	for(new i = 0; i < MAX_PLAYERS; i++) 
	{
	    if(!IsPlayerConnected(i)) continue;
		if(PI[i][pLeader] >= 1) SCM(i, color, text);
	}
	return 1;
}
CMD:offuntwarn(playerid, params[]) 
{
	if(sscanf(params, "s[24]", params[0])) return SCM(playerid, COLOR_LIGHTGREY, !"�����������: /offuntwarn [���]");
 	if(params[0] == getName(playerid)) return SCM(playerid, COLOR_GREY, !"�� �� ������ ����� ������� ����");

	mysql_string[0] = EOS, f(mysql_string, 68, "SELECT * FROM `accounts` WHERE `Name` = '%e'", params[0]);
    mysql_tquery(mysql, mysql_string, "OffUnTwarn", "i", playerid);
	return 1;
}
callback: OffUnTwarn(playerid) 
{
    new rows, fields, temp[32];
    cache_get_data(rows, fields);
    if(rows) 
	{
	    new PlayerName[24], Warns, members, ranks;
	    cache_get_field_content(0, "Name", PlayerName, mysql);
		cache_get_field_content(0, "twarn", temp), Warns = strval (temp);
		cache_get_field_content(0, "member", temp), members = strval (temp);
		cache_get_field_content(0, "rank", temp), ranks = strval (temp);

	    if(ranks == 10 && PI[playerid][pRang] == 9) return SCM(playerid, COLOR_GREY, !"�� �� ������ ����� ������� ������");
		if(members != PI[playerid][pMember]) return SCM(playerid, COLOR_GREY, !"����� ������ �������� � ����� �����������");
	    if(Warns == 0) return SCM(playerid, COLOR_GREY, !"����� �� ����� ���������");

		Warns--;
        SendFractionMessagef(PI[playerid][pMember], COLOR_TOMATO, "(( %s %s[%d] ���� ������� ������� %s [%d/3] ))", NameRang(playerid), getName(playerid), playerid, PlayerName, Warns);
		mysql_queryf(mysql, "UPDATE `accounts` SET `twarn` = '%d' WHERE `Name` = '%e'", false, Warns, PlayerName);
	}
	else SCM(playerid, COLOR_GREY, !"����� �� ������");
	return 1;
}
CMD:uninvite(playerid,params[]) 
{
	if(PI[playerid][pRang] < 9) return SCM(playerid, COLOR_GREY, !"������ ������� ��� ����������");
    if(sscanf(params,"us[60]", params[0], params[1])) return SCM(playerid, COLOR_LIGHTGREY, !"�����������: /uninvite [ID ������] [�������]");
    if(params[0] == playerid) return SCM(playerid, COLOR_GREY, !"������ ������������ �� ����� ����");
	if(!IsPlayerConnected(params[0]))return  SCM(playerid, COLOR_GREY, !"����� �� � ����");
	if(!IsPlayerLogged{params[0]})return  SCM(playerid, COLOR_GREY, !"����� �� �����������");
    if(PI[playerid][pMember] != PI[params[0]][pMember]) return SCM(playerid, COLOR_GREY, !"������ ����� �� ������� � ����� �����������");
	if(PI[params[0]][pLeader] != 0) return SCM(playerid, COLOR_GREY, !"������ ��������� � ������");
	if(PI[playerid][pRang] == PI[params[0]][pRang]) return SCM(playerid, COLOR_GREY, !"������ ��������� � �������� � �������� �����-�� ����");

	SetPVarString(playerid, "ReasonUninvite", params[1]);
	SetPVarInt(playerid, "IDUninvite", params[0]);

	return ShowPlayerDialogf(playerid, 9800, DIALOG_STYLE_MSGBOX, !"{ee3366}������� ������", "��", "���", "�� ������ ������� {3377cc}%s %s\n{FFFFFF}������� ����������: {3377cc}%s\n\n{696969}�������� ��������: �������� ��� �������� ����� ����������!", NameRang(params[0]), getName(params[0]), params[1]);
}
CMD:uninviteoff(playerid,params[]) 
{
    if(PI[playerid][pRang] < 10) return SCM(playerid, COLOR_GREY, !"������ ������� �������� ������� �����������");
    new param_name[24];
	if(sscanf(params, "s[144]", param_name)) return SCM(playerid, COLOR_LIGHTGREY, !"�����������: /uninviteoff [���]");
    foreach(Player, i) 
	{
	    new szName[64];
	    if(!IsPlayerConnected(i)) continue;
	    GetPlayerName(i,szName,64);
	    if(!strcmp(param_name, szName, false)) return SCM(playerid, COLOR_GREY, !"���� ����� � ����, ����������� /uninvite");
    }
	if(GetString(param_name, getName(playerid))) return SCM(playerid, COLOR_GREY, !"�� �� ������ ������� ����");

	mysql_string[0] = EOS, f(mysql_string, 68, "SELECT * FROM `accounts` WHERE `Name` = '%e'", param_name);
    mysql_tquery(mysql, mysql_string, "OfflineUnInvite", "is", playerid, param_name);
	return 1;
}
callback: OfflineUnInvite(playerid, PlayerName[]) 
{
    new rows, fields, temp[32];
    cache_get_data(rows, fields);
    if(rows) 
	{
	    new members;
		cache_get_field_content(0, "member", temp), members = strval (temp);
		if(members != PI[playerid][pMember]) return SCM(playerid, COLOR_GREY, !"����� ������ �������� � ����� �����������");

		new res[18];
	    format(res, sizeof(res), "���������� �������");
		SetPVarString(playerid, "text_wbook", res);

		mysql_string[0] = EOS, f(mysql_string, 68, "SELECT * FROM `accounts` WHERE name = '%e'", PlayerName);
    	mysql_tquery(mysql, mysql_string, "WbookOff", "is", playerid, PlayerName);

        SendFractionMessagef(PI[playerid][pMember], COLOR_TOMATO, "(( %s %s[%d] ������ ������� %s ))", NameRang(playerid), getName(playerid), playerid, PlayerName);

		mysql_queryf(mysql, "UPDATE `accounts` SET `member` = '0', `rank` = '0', `leader` = '0', `GroupID` = '0', `twarn` = '0' WHERE `Name` = '%e'", false, PlayerName);
	}
	else SCM(playerid, COLOR_GREY, !"����� �� ������");
	return 1;
}

stock org_OnDialogResponse(playerid, dialogid, response)
{
	switch(dialogid)
	{
		case 9800: 
		{
			if(!response) 
			{
				DeletePVar(playerid, "IDUninvite");
				DeletePVar(playerid, "ReasonUninvite");
				return 1;
			}
			if(response) 
			{
				new id = GetPVarInt(playerid, "IDUninvite");
				
				new text[24];
				GetPVarString(playerid,"ReasonUninvite", text, sizeof(text));
				FixSVarString(text);

				new year, month, day;
				getdate(year, month, day);

				mysql_string[0] = EOS, mf(mysql, mysql_string, 350, "\
					INSERT INTO `wbook`(`w_player`,`w_fraction`,`w_name`,`w_reason`,`w_rank`,`w_day`,`w_mes`,`w_year`,`w_dal`,`w_reas`,`w_dalrank`)\
						VALUES\
					('%d','%d','%s','����������','%d','%d','%d','%d','%s','%s','%s')",\
					PI[id][pID], PI[id][pMember], PI[id][pName], PI[id][pRang], day, month, year, PI[playerid][pRang], text, NameRang(playerid));

				mysql_function_query(mysql, mysql_string, false, "", "");

				if(PI[playerid][pMember] == 2 && PI[id][pRang] >= 3) 
				{
					if(PI[id][pMilitaryID] == 0) 
					{
						SCM(id, COLOR_GREEN, !"�� ��������� � ����� � �������� ������� �����");
						PI[id][pMilitaryID] = 1;
					}
				}
				if(PI[id][pMember] == Command[0] || PI[id][pMember] == Command[1])
				{
					if(PI[id][pOnCapture] == 1)
					{
						AutoKickCapture(id);
						CheckCount(id);
					}
					cef_emit_event(id, "cef:capture:visible", CEFINT(false));
				}

				SendFractionMessagef(PI[playerid][pMember], COLOR_TOMATO, "[R] %s %s ������ �� ����������� %s %s. �������: %s",\
					NameRang(playerid), PI[playerid][pName], NameRang(id), PI[id][pName], text);

				PI[id][pMember] = 0;
				PI[id][pRang] = 0;
				PI[id][pTwarn] = 0;
				PI[id][pLeader] = 0;
				PI[id][pProgressMetall] = 0;
	            PI[id][pProgressDrugs] = 0;
	            PI[id][pProgressAmmo] = 0;
	            PI[id][pProgressCarGrabber] = 0;
	            PI[id][pProgressSellGun] = 0;
	            PI[id][pProgressCapture] = 0;
	            PI[id][pCaptureManager] = 0;

				PI[id][pMedCard] = 0;

				if(IsPlayerInAnyVehicle(id) && GetPlayerState(id) == PLAYER_STATE_DRIVER) 
				{
					new Float:x, Float:y, Float:z;
				 	GetPlayerPos(id,x,y,z);
				 	SetPlayerPosAC(id,x,y,z+2);
				}
				for(new g; g <= totalgz; g++) GangZoneHideForPlayer(id, g);
				GangZoneStopFlashForPlayer(id, WarZone);
				SetPlayerTeam(id, NO_TEAM);
				SetPlayerSkinAC(id,PI[id][pSkin]);
				SetPlayerColorEx(id);
				SavePlayerData(id);
				ClearGroup(id);

				DeletePVar(playerid, "IDUninvite");
				DeletePVar(playerid, "ReasonUninvite");
			}
		}
	}
	return 1;
}