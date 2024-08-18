static const stock ModerName[4][17] = {
	"�����",
 	"Junior Moderator",
 	"Moderator",
 	"Senior Moderator"
};

CMD:makemoder(playerid, params[]) 
{
    if(CheckAccess(playerid, 8)) return 1;
    if(sscanf(params,"u",params[0])) return SCM(playerid, COLOR_LIGHTGREY, !"�����������: /makemoder [ID ������]");
	if(!IsPlayerConnected(params[0])) return  SCM(playerid, COLOR_GREY, !"����� �� � ����");
	if(!IsPlayerLogged{params[0]}) return  SCM(playerid, COLOR_GREY, !"����� �� �����������");
	if(PI[playerid][pAdmin] < PI[params[0]][pAdmin]) return SCM(playerid, COLOR_GREY, !"������ �������� ������� �������� ������� ������� ���� ���");
	SetPVarInt(playerid, "AdmID", params[0]);
	return ShowPlayerDialog(playerid, 9500, DIALOG_STYLE_LIST, !"{ee3366}������ ���� �������� ����������", !"\
	����� ����� �������� ����������\n\
	1. Junior Moderator\n\
	2. Moderator\n\
	3. Senior Moderator", !"�����", !"������");
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
	                    SCM(playerid, COLOR_YELLOW, !"�� ���� ����� � ����� �������� ����������!");
	                    SCMf(i, COLOR_YELLOW, "������� ������ %s ���� ��� � ��������� �������� ����������", getName(playerid));
	                    UpdatePlayerDataInt(i, "Admin", PI[i][pModer]);
	                }
	                case 1: 
					{
	                    PI[i][pModer] = 1;
	                    SCMf(playerid, COLOR_YELLOW, "�� �������� ������� �������� ���������� ��� %s[%d], ������ �� 'Junior Moderator'", PI[i][pName], i);
	                    SCM(i, COLOR_YELLOW, !"������� ������ ������� ��� ������� �� Junior Moderator");
	                    UpdatePlayerDataInt(i, "Admin", PI[i][pModer]);
	                }
	                case 2: 
					{
	                    PI[i][pModer] = 2;
	                    SCMf(playerid, COLOR_YELLOW, "�� �������� ������� �������� ���������� ��� %s[%d], ������ �� 'Moderator'", PI[i][pName], i);
	                    SCM(i, COLOR_YELLOW, !"������� ������ ������� ��� ������� �� Moderator");
	                    UpdatePlayerDataInt(i, "Admin", PI[i][pModer]);
	                }
	                case 3: 
					{
	                    PI[i][pModer] = 3;
	                    SCMf(playerid, COLOR_YELLOW, "�� �������� ������� �������� ���������� ��� %s[%d], ������ �� 'Senior Moderator'", PI[i][pName], i);
	                    SCM(i, COLOR_YELLOW, !"������� ������ ������� ��� ������� �� Senior Moderator");
	                    UpdatePlayerDataInt(i, "Admin", PI[i][pModer]);
	                }
				}
				if(PI[i][pModer] >= 1) Iter_Add(Moder, playerid);
			}
        }
		case 2840:
		{
			if(!response) return 1;
			if(response)
   			{
				switch(listitem)
				{
				    case 0: 
					{
						ShowPlayerDialog(playerid, 0, DIALOG_STYLE_LIST, !"{ee3366}������� �������� ����������", !"\
						mhelp - ������� ����������\n\
						flip - �������� ������\n\
						sp - ������� �� �������\n\
						spawn - ���������� ������\n\
						goto - ����������������� � ������\n\
						a - ����� ���\n\
						tp (F2) - ���� ������������\n\
						gethere - ��������������� ������ � ����\n\
						slap - ��������� ������\n\
						ans - �������� ������", !"�������", !"");
					}
					case 1: 
					{
						ShowPlayerDialog(playerid, 0, DIALOG_STYLE_LIST, !"{ee3366}������� �������� ����������", !"\
						unjail - ��������� �� ���������\n\
						jail - �������� ������ � ������\n\
						unprison - ��������� �� ������\n\
						skin - ������ ����\n\
						unmute - ����� ���������� ���������� ����\n\
						mute - ������ ���������� ��������� ����\n\
						spawncar - ���������� ����������\n\
						setfuel - ���������� ������� ������� ������\n\
						agivelic - ������ ������������ �����\n\
						getcar - ��������������� ���������� � ����\n\
						giveskill - ������ ������ �������� ������", !"�������", !"");
					}
					case 2: 
					{
						ShowPlayerDialog(playerid, 0, DIALOG_STYLE_LIST, !"{ee3366}������� �������� ����������", !"\
						veh - ������� ����������\n\
						dveh - ������� ����������\n\
						givevb - ������ ������ ������� �����\n\
						setarm - ������ �����\n\
						setmember - ������ ���� � �����������\n\
						vmute - ������ ���������� ���������� ����\n\
						unvmute - ����� ���������� ���������� ����\n\
						kick - ������� ������", !"�������", !"");
					}
				}
			}
		}
	}
	return 1;
}
CMD:moders(playerid)
{
 	if(CheckAccess(playerid, 1, 1)) return 0;

	SCMf(playerid, COLOR_BLUE, "������� ���������� ������ (� ����: %d, �� ��� � ���: NaN)", Iter_Count(Moder));

	new str_1[512];

	foreach(Moder, i)
	{
		if !PI[i][pModer] *then continue;

		if(GetPVarInt(i, "FlyMode") != 0) format(str_1, sizeof(str_1), "%s[%d] - %s - /re %d- [AFK: %d]. �������� [%d/3]", getName(i), i, ModerName[PI[i][pModer]], GetPVarInt(i,"specid"), PI[i][pAFK], PI[i][pModerWarn]);
		else format(str_1, sizeof(str_1), "%s[%d] - %s - [AFK: %d]. �������� [%d/3]", getName(i), i, ModerName[PI[i][pModer]], PI[i][pAFK], PI[i][pModerWarn]);
		SCM(playerid, COLOR_JOBYELLOW, str_1);

	}
	return 1;
}

CMD:mhelp(playerid) 
{
	if(CheckAccess(playerid, 1, 1)) return 0;
    new dialog[123];
	format(dialog, sizeof(dialog), "1. Junior Moderator%s%s", (PI[playerid][pModer] >= 2) ? ("\n2. Moderator") : (""), (PI[playerid][pModer] >= 3) ? ("\n3. Senior Moderator") : (""));
	return ShowPlayerDialog(playerid, 2840, DIALOG_STYLE_LIST, "{ee3366}������� �������� ����������", dialog, "�������", "�������");
}