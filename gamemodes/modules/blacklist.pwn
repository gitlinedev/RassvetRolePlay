stock bl_OnDialogResponse(playerid, dialogid, response, listitem, inputtext[]) 
{
    switch(dialogid)
    {
        case 7887:
		{
			if(!response) return 1;
			if(response)
			{
	   	        switch(listitem) 
				{
					case 0: ShowPlayerDialog(playerid, 3126, DIALOG_STYLE_INPUT, "{ee3366}�������� � ������ ������", "{FFFFFF}������� ��� ������ � ������� ����� �������\n{FFFF99}��������: Fedor_Badrov, ���\n\n{696969}����� ����� ����� � �� �� 15 ����", "��������", "������");
					case 1: ShowPlayerDialog(playerid, 3125, DIALOG_STYLE_INPUT, "{ee3366}׸���� ������", "{FFFFFF}������� ��� ������, �������� ������ ������� �� ������� ������:", "�������", "�����");
					default: 
					{
						new str_q[135];
						mysql_format(mysql,str_q,sizeof(str_q),"SELECT * FROM `fractions_blacklist` WHERE `bl_name` = '%e' AND `bl_fraction` = '%d' LIMIT 1",inputtext,PI[playerid][pMember]);
						mysql_function_query(mysql, str_q, true, "BlackListCheck", "ds", playerid, inputtext);
					}
				}
			}
		}
        case 3127: 
        {
			if(!response) return callcmd::lmenu(playerid);
   	        switch(listitem)
            {
				case 0: ShowPlayerDialog(playerid, 3126, DIALOG_STYLE_INPUT, !"{ee3366}�������� � ������ ������", !"{FFFFFF}������� ��� ������ � ������� ����� �������\n{FFFF99}��������: Fedor_Badrov, ���\n\n{696969}����� ����� ����� � �� �� 15 ����", !"��������", !"������");
				case 1: ShowPlayerDialog(playerid, 3125, DIALOG_STYLE_INPUT, !"{ee3366}׸���� ������", !"{FFFFFF}������� ��� ������, �������� ������ ������� �� ������� ������\n{FFFF99}��������: Fedor_Badrov", !"�������", !"�����");
			}
		}
		case 3128:
		{
		    if(PI[playerid][pAdmin] < 4) return SCM(playerid, COLOR_GREY, !"��� ������ ������� ������� ������ �����������, ���������� � ������� ��������.");
			if(!response)return ShowPlayerDialog (playerid, 3127, DIALOG_STYLE_LIST, !"{ee3366}׸���� ������", !"1. �������� � ��\n2. ������ �� ��", !"�������", !"�����");

            mysql_tqueryf(mysql, "DELETE FROM `fractions_blacklist` WHERE `bl_fraction` = '%d'", PI[playerid][pMember]);

			SCM(playerid, COLOR_YELLOW, !"׸���� ������ ������� ������.");
			ShowPlayerDialog(playerid, 3127, DIALOG_STYLE_LIST, !"{ee3366}׸���� ������", !"1. �������� � ��\n2. ������ �� ��", !"�������", !"�����");
		}
		case 3126:
		{
			new name[25], reason[33];
			sscanf(inputtext, "p<,>s[24]s[32]", name, reason);

            mysql_string[0] = EOS, f(mysql_string, 115, "SELECT * FROM `fractions_blacklist` WHERE bl_fraction = '%d' AND bl_name = '%s' LIMIT 1", PI[playerid][pMember], name);
	        mysql_tquery(mysql, mysql_string, "GiveBlackList", "ds", playerid, name);

		    SetPVarString(playerid, "reason_bl", reason);
		}
		case 3125:
		{
			if(!response) return ShowPlayerDialog(playerid, 3127, DIALOG_STYLE_LIST, "{ee3366}׸���� ������", "1. �������� � ��\n2. ������ �� ��", "�������", "�����");
			
            if(!strlen(inputtext)) 
                return ShowPlayerDialog(playerid, 3125, DIALOG_STYLE_INPUT, !"{ee3366}׸���� ������", !"{FFFFFF}�������� ������ ��������!\n\n\
                                                        {FFFF99}������� ��� ������, �������� ������ ������� �� ������� ������:", !"�������", !"�����");
			if(IsTextInvalid(inputtext)) 
                return ShowPlayerDialog(playerid, 3125, DIALOG_STYLE_INPUT, !"{ee3366}׸���� ������", !"{FFFFFF}�������� ������ ��������!\n\n\
                                                        {FFFF99}������� ��� ������, �������� ������ ������� �� ������� ������:", !"�������", !"�����");
			if(strlen(inputtext) < 6 || strlen (inputtext) > 24) 
                return ShowPlayerDialog(playerid, 3125, DIALOG_STYLE_INPUT, !"{ee3366}׸���� ������", !"{FFFFFF}�������� ������ ��������!\n\n\
                                                        {FFFF99}������� ��� ������, �������� ������ ������� �� ������� ������:", !"�������", !"�����");
			
            mysql_string[0] = EOS, f(mysql_string, 116, "SELECT * FROM `fractions_blacklist` WHERE `bl_name` = '%e' AND `bl_fraction`='%d' LIMIT 1", inputtext, PI[playerid][pMember]);
	        mysql_tquery(mysql, mysql_string, "CheckBlackList", "ds", playerid, inputtext);

		}
		case 7874:
		{
		  	if(!response) return 1;

			new name[45];
			GetPVarString(playerid,"name_bl", name, 45);

            mysql_string[0] = EOS, f(mysql_string, 116, "SELECT * FROM `fractions_blacklist` WHERE `bl_name` = '%e' AND `bl_fraction`='%d' LIMIT 1", name, PI[playerid][pMember]);
	        mysql_tquery(mysql, mysql_string, "CheckBlackList", "ds", playerid, name);
		}
    }
    return 1;
}
callback: CheckBlackListBl(playerid) 
{
	new rows, fields;
    cache_get_data(rows, fields);
    if(rows) 
    {
	    if(PI[playerid][pRang] < 9) return SCM(playerid, COLOR_GREY, !"������ ������� ��� ����������");
        mysql_string[0] = EOS, f(mysql_string, 66, "SELECT * FROM `fractions_blacklist` WHERE `bl_fraction` = '%d'", PI[playerid][pMember]);
	    mysql_tquery(mysql, mysql_string, "BlackList", "d", playerid);
	}
	else ShowPlayerDialog(playerid, 3127, DIALOG_STYLE_LIST, "{ee3366}׸���� ������", "1. �������� � ��\n2. ������ �� ��", "�������", "�����");
	return 1;
}
callback: BlackList(playerid) 
{
    new rows, fields;
    global_str = "";
    static Name[MAX_PLAYER_NAME]; Name = "";
    new DialogName[50];

    cache_get_data(rows, fields);
    for(new i = 0; i < rows; i++) 
    {
		cache_get_field_content(i, "bl_name", Name, mysql, MAX_PLAYER_NAME);
		format(global_str, sizeof(global_str),"%s%s\n", global_str, Name);
	}

    format(DialogName, sizeof(DialogName), "{ee3366}�������� %d �� %d ������� (��������: 1)", rows, rows);
	format(global_str, sizeof(global_str), "׸���� ������\n{FFFF99}1. �������� � ��\n{FFFF99}2. ������ �� ��{FFFFFF}\n%s", global_str);

	ShowPlayerDialog(playerid, 7887, DIALOG_STYLE_TABLIST_HEADERS, DialogName, global_str, "�������", "");
	return 1;
}
callback: CheckBlackList(playerid, name[]) 
{
	new rows, fields;
	cache_get_data(rows, fields);
	if(rows) 
    {
        mysql_tqueryf(mysql, "DELETE FROM `fractions_blacklist` WHERE `bl_name` = '%s' AND `bl_fraction` = '%d'", name, PI[playerid][pMember]);
		SCMf(playerid, COLOR_GREENNEW, "�� ������ �� ������� ������ {FFFF33}%s.", name);

		switch(PI[playerid][pMember]) 
		{
		    case 1: SendFractionMessagef(PI[playerid][pMember], 0xff6633FF, "[R] %s %s[%d] ����� %s �� ������� ������ �����������.",rang_gov[PI[playerid][pRang]-1][frName],getName(playerid),playerid,name);
		    case 2: SendFractionMessagef(PI[playerid][pMember], 0xff6633FF, "[R] %s %s[%d] ����� %s �� ������� ������ �����������.",rang_army[PI[playerid][pRang]-1][frName],getName(playerid),playerid,name);
		    case 3: SendFractionMessagef(PI[playerid][pMember], 0xff6633FF, "[R] %s %s[%d] ����� %s �� ������� ������ �����������.",rang_police[PI[playerid][pRang]-1][frName],getName(playerid),playerid,name);
		    case 4: SendFractionMessagef(PI[playerid][pMember], 0xff6633FF, "[R] %s %s[%d] ����� %s �� ������� ������ �����������.",rang_hospital[PI[playerid][pRang]-1][frName],getName(playerid),playerid,name);
	     	case 5: SendFractionMessagef(PI[playerid][pMember], 0xff6633FF, "[R] %s %s[%d] ����� %s �� ������� ������ �����������.",rang_skinhead[PI[playerid][pRang]-1][frName],getName(playerid),playerid,name);
	   		case 6: SendFractionMessagef(PI[playerid][pMember], 0xff6633FF, "[R] %s %s[%d] ����� %s �� ������� ������ �����������.",rang_gopota[PI[playerid][pRang]-1][frName],getName(playerid),playerid,name);
		    case 7: SendFractionMessagef(PI[playerid][pMember], 0xff6633FF, "[R] %s %s[%d] ����� %s �� ������� ������ �����������.",rang_kavkaz[PI[playerid][pRang]-1][frName],getName(playerid),playerid,name);
		}

		ShowPlayerDialog(playerid, 3127, DIALOG_STYLE_LIST, "׸���� ������", "1. �������� � ��\n2. ������ �� ��", "�������", "�����");
	}
	else 
    {
		SCMf(playerid, COLOR_GREY, "����� %s �� ������ � ��.", name);
		ShowPlayerDialog(playerid, 3127, DIALOG_STYLE_LIST, "׸���� ������", "1. �������� � ��\n2. ������ �� ��", "�������", "�����");
	}
	return 1;
}
callback: CheckBlackListPlayer(playerid)
{
	new rows, fields;
    cache_get_data(rows, fields);
    if(rows) 
    {
        mysql_string[0] = EOS, f(mysql_string, 85, "SELECT * FROM `fractions_blacklist` WHERE `bl_name` = '%e'", getName(playerid));
	    mysql_tquery(mysql, mysql_string, "LoadBlackListForPlayer", "d", playerid);
	}
	else ShowPlayerDialog(playerid, 0, DIALOG_STYLE_MSGBOX, !"{ee3366}׸���� ������ �����������", "{FFFFFF}�� �� �������� � ������ ������ �� ����� �����������", "�������", "");
	return 1;
}
callback: LoadBlackListForPlayer(playerid) 
{
    new rows, fields, temp[15], from[32], reas[32], rank[32], day, fracname5;
    cache_get_data(rows, fields);

	new str_1[256+64];

    for(new i = 0; i < rows; i++) 
    {
		cache_get_field_content(i, "bl_dob", from, mysql, 32);
		cache_get_field_content(i, "bl_day", temp), day = strval(temp);
		cache_get_field_content(i, "bl_fraction", temp), fracname5 = strval(temp);
		cache_get_field_content(i, "bl_reason", reas, mysql, 32);
		cache_get_field_content(i, "bl_rank", rank, mysql, 32);
		new fracname[64];
		switch(fracname5) 
        {
			case 1: fracname = "�������������";
			case 2: fracname = "��������� �����";
			case 3: fracname = "�������";
   			case 4: fracname = "����";
			case 5: fracname = "��������";
			case 6: fracname = "������";
			case 7: fracname = "��������";
  		}
		format(str_1,sizeof(str_1),"%s%s (%s %s)\t%d ����\t%s\n", str_1, fracname, rank, from, day, reas);
	}
	ShowPlayerDialogf(playerid, 0, DIALOG_STYLE_TABLIST_HEADERS, "{ee3366}׸���� ������ �����������", "�������", "", "�����������(�������)\t�������� ����\t�������\n%s", str_1);
	return 1;
}
callback: BlackListCheck(playerid, name[]) 
{
	new rows, fields,temp[516],dob[64],day,reas[64],rank[64],bl_name[64],bl_name2[64];

    cache_get_data(rows, fields);

	new str_3[512];

    for(new i = 0; i < rows; i++) 
    {
        cache_get_field_content(i, "bl_name", bl_name, mysql, 63);
		cache_get_field_content(i, "bl_dob", dob, mysql, 63);
		cache_get_field_content(i, "bl_day", temp), day = strval(temp);
		cache_get_field_content(i, "bl_reason", reas, mysql, 63);
		cache_get_field_content(i, "bl_rank", rank, mysql, 63);
		cache_get_field_content(i, "bl_name2", bl_name2, mysql, 63);

		format(str_3,sizeof(str_3),"%s{FFFFFF}��� �� ������ ��������: {3377cc}\t%s\n\
		{FFFFFF}��� � ������ ������: {3377cc}\t%s\n\
		{FFFFFF}��� � ������ ������: {3377cc}\t%s %s\n\
		{FFFFFF}��������� �����: \t{3377cc}\t%d ����\n\
		{FFFFFF}�������: \t\t\t{3377cc}%s\n\n\
		{696969}�� ������ ������� ������ �� ������� ������ �����������?", str_3, bl_name, bl_name2,rank, dob,day,reas);
		SetPVarString(playerid, "name_bl", name);
	}
	ShowPlayerDialog(playerid, 7874, DIALOG_STYLE_MSGBOX, !"{ee3366}׸���� ������ �����������", str_3, "��", "�������");
	return 1;
}
callback: GiveBlackList(playerid, name[]) 
{
	new rows, fields;
    cache_get_data(rows, fields);
    if(rows) SCM(playerid, COLOR_GREY, !"������ ����� ��� ��������� � ������ ������ ����� �����������");
	else 
	{
		mysql_string[0] = EOS, f(mysql_string, 69, "SELECT * FROM `accounts` WHERE `Name` = '%e'", name);
	    mysql_tquery(mysql, mysql_string, "InsertBlackList", "ds", playerid, name);
	}
	return 1;
}
callback: InsertBlackList(playerid, PlayerName[]) 
{
    new rows, fields;
    cache_get_data(rows, fields);
    if(!rows) return SCM(playerid, COLOR_GREY, !"�� ����� �������� ���, ��� �� ����� ������� ���.");
    if(rows) 
	{
		new text[32];
		GetPVarString(playerid, "reason_bl", text, sizeof(text));
		FixSVarString(text);

	    new ltext[12];
		switch(PI[playerid][pRang]) 
		{
			case 9: ltext = "�����������";
			case 10: ltext = "�����";
  		}

		mysql_tqueryf(mysql, "\
		INSERT INTO `fractions_blacklist`(`bl_fraction`,`bl_name`,`bl_day`,`bl_reason`,`bl_dob`,`bl_rank`,`bl_name2`) \
			VALUES\
		('%d','%s','15','%s','%s','%s','%s')", PI[playerid][pMember], PlayerName, text, getName(playerid), ltext, PlayerName);

		switch(PI[playerid][pMember]) 
		{
		    case 1: SendFractionMessagef(PI[playerid][pMember], 0xff6633FF, "[R] %s %s[%d] ������� %s � ������ ������ �� 15 ����. �������: %s.",rang_gov[PI[playerid][pRang]-1][frName],getName(playerid),playerid,PlayerName,text);
		    case 2: SendFractionMessagef(PI[playerid][pMember], 0xff6633FF, "[R] %s %s[%d] ������� %s � ������ ������ �� 15 ����. �������: %s.",rang_army[PI[playerid][pRang]-1][frName],getName(playerid),playerid,PlayerName,text);
		    case 3: SendFractionMessagef(PI[playerid][pMember], 0xff6633FF, "[R] %s %s[%d] ������� %s � ������ ������ �� 15 ����. �������: %s.",rang_police[PI[playerid][pRang]-1][frName],getName(playerid),playerid,PlayerName,text);
		    case 4: SendFractionMessagef(PI[playerid][pMember], 0xff6633FF, "[R] %s %s[%d] ������� %s � ������ ������ �� 15 ����. �������: %s.",rang_hospital[PI[playerid][pRang]-1][frName],getName(playerid),playerid,PlayerName,text);
	     	case 5: SendFractionMessagef(PI[playerid][pMember], 0xff6633FF, "[R] %s %s[%d] ������� %s � ������ ������ �� 15 ����. �������: %s.",rang_skinhead[PI[playerid][pRang]-1][frName],getName(playerid),playerid,PlayerName,text);
	   		case 6: SendFractionMessagef(PI[playerid][pMember], 0xff6633FF, "[R] %s %s[%d] ������� %s � ������ ������ �� 15 ����. �������: %s.",rang_gopota[PI[playerid][pRang]-1][frName],getName(playerid),playerid,PlayerName,text);
		    case 7: SendFractionMessagef(PI[playerid][pMember], 0xff6633FF, "[R] %s %s[%d] ������� %s � ������ ������ �� 15 ����. �������: %s.",rang_kavkaz[PI[playerid][pRang]-1][frName],getName(playerid),playerid,PlayerName,text);
		}
		DeletePVar(playerid, "reason_bl");
	}
	return 1;
}
CMD:allleaders(playerid,params[]) 
{
    if(CheckAdmin(playerid, 5)) return 1;
	mysql_function_query(mysql, "SELECT * FROM `accounts` WHERE `leader` != '0'", true, "LoadAllLeaders", "d", playerid);
	return 1;
}
//==============================[CMD] ===============================//
CMD:bl(playerid) 
{
    if(PI[playerid][pRang] < 9) return SCM(playerid, COLOR_GREY, !"������ ������� ��� ����������");
    global_str[0] = EOS, f(global_str, 63, "SELECT * FROM `fractions_blacklist` WHERE bl_fraction = '%d'", PI[playerid][pMember]);
    mysql_tquery(mysql, global_str, "CheckBlackListBl", "d", playerid);
	return 1;
}