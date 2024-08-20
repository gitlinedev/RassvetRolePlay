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

		if(GetPVarInt(i, "SpecBool") != 0) format(str_1, sizeof(str_1), "%s[%d] - %s - /re %d- [AFK: %d]. �������� [%d/3] (�������: %d)", getName(i), i, ModerName[PI[i][pModer]], GetPVarInt(i,"SpecID"), PI[i][pAFK], PI[i][pModerWarn], PI[i][pAdminReports]);
		else format(str_1, sizeof(str_1), "%s[%d] - %s - [AFK: %d]. �������� [%d/3] (�������: %d)", getName(i), i, ModerName[PI[i][pModer]], PI[i][pAFK], PI[i][pModerWarn], PI[i][pAdminReports]);
		SCM(playerid, COLOR_JOBYELLOW, str_1);

	}
	return 1;
}