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

stock CancelRequest(playerid)
{
	if(PI[playerid][pRequest] == 1)
	{
		if(PI[playerid][pRequestFor] != INVALID_PLAYER_ID)
		{
			SCMf(PI[playerid][pRequestFor], COLOR_GREY, "%s ������� ���� �����������", getName(playerid));
			SCMf(playerid, COLOR_GREY, "�� �������� ���� ����������� ��� ������ %s", PI[PI[playerid][pRequestFor]][pName]);

			
			ClearRequest(PI[playerid][pRequestFor]);
			ClearRequest(playerid);
		}
		else if(PI[playerid][pRequestFrom] != INVALID_PLAYER_ID)
		{
			SCMf(PI[playerid][pRequestFrom], COLOR_GREY, "%s ��������� �� ������ �����������", getName(playerid));
			SCMf(playerid, COLOR_GREY, "�� ���������� �� ����������� ������ %s", PI[PI[playerid][pRequestFrom]][pName]);

			ClearRequest(PI[playerid][pRequestFrom]);
			ClearRequest(playerid);
		}
	}
	return 1;
}
stock ClearRequest(playerid)
{
	PI[playerid][pRequest] = 0;
	PI[playerid][pRequestType] = -1;
	PI[playerid][pRequestValue_1] = -1;
	PI[playerid][pRequestValue_2] = -1;
	PI[playerid][pRequestFrom] = INVALID_PLAYER_ID;
	PI[playerid][pRequestFor] = INVALID_PLAYER_ID;
}
stock CheckRequest(playerid)
{
	if(!IsPlayerConnected(PI[playerid][pRequestFrom])) 
	{
		ClearRequest(playerid);
		return SCM(playerid, COLOR_GREY, !"����� �� � ����");
	}
	if(!IsPlayerLogged{PI[playerid][pRequestFrom]}) 
	{
		ClearRequest(playerid);
		return SCM(playerid, COLOR_GREY, !"����� �� �����������");
	}

	new from_player = PI[playerid][pRequestFrom];

	if(PI[playerid][pRequest] == 1)
	{
		switch(PI[playerid][pRequestType])
		{
			case 0:
			{
				new Float:angle, str[144];
				GetPlayerFacingAngle(from_player, angle);
				SetPlayerFacingAngle(playerid, angle + 180);

				ApplyAnimation(from_player,"GANGS","hndshkfa",4.0,0,0,0,0,0,1);
				ApplyAnimation(playerid,"GANGS","hndshkfa",4.0,0,0,0,0,0,1);

				format(str, sizeof(str),"%s ����� ���� %s", getName(from_player), getName(playerid));
			 	ProxDetector(25.0, playerid, str, 0xFF99CCFF, 0xFF99CCFF, 0xFF99CCFF, 0xFF99CCFF, 0xFF99CCFF);
			}
			case 1:
			{
				SetPVarInt(playerid, "FromID", from_player);
				ShowPlayerDialogf(playerid, 7242, DIALOG_STYLE_MSGBOX, !"{ee3366}���������� � �����������", "��������", "�������", "\
					{FFFFFF}���������: %s\n\
					�����������: %s\n\n\
					{FFFF99}�� ������������� ������ �������� � �����������?", 
						getName(from_player), Fraction_Name[PI[from_player][pMember]]);
			}
			case 2:
			{
			 	PI[from_player][pHealPack]--;
				PI[playerid][pHealPack]++;

			    SetPlayerChatBubble(from_player, "������� �������", 0xFF99CCFF, 20.0, 4000);

				format(request_str, 70,"%s ������� ������� %s", getName(from_player), getName(playerid));
			    ProxDetector(25.0, playerid, request_str, 0xFF99CCFF, 0xFF99CCFF, 0xFF99CCFF, 0xFF99CCFF, 0xFF99CCFF);
			}
		}
		ClearRequest(PI[playerid][pRequestFrom]);
		ClearRequest(playerid);
	}
	return 1;
}
stock SendRequestForPlayer(playerid, id, type, value = -1, value_2 = -1)
{
	if(!IsPlayerConnected(id)) 
	{
		ClearRequest(playerid);
		return SCM(playerid, COLOR_GREY, !"����� �� � ����");
	}
	if(!IsPlayerLogged{id}) 
	{
		ClearRequest(playerid);
		return SCM(playerid, COLOR_GREY, !"����� �� �����������");
	}

	PI[playerid][pRequest] = 1;
	PI[id][pRequest] = 1;

	PI[playerid][pRequestFor] = id;
	PI[id][pRequestFrom] = playerid;

	PI[playerid][pRequestValue_1] = value;
	PI[playerid][pRequestValue_2] = value_2;

	PI[playerid][pRequestType] = type;
	PI[id][pRequestType] = type;

	switch(type)
	{
		case 0:
		{
			cef_text[0] = EOS, f(cef_text, 56, "�� ���������� %s ������ ��� ����", getName(id));
			SendPlayerOfferNotify(playerid, 2, cef_text, "", "��������", 25);

			cef_text[0] = EOS, f(cef_text, 52, "%s ��������� ��� ������ ����", getName(playerid));
			SendPlayerOfferNotify(id, 1, cef_text, "�����������", "����������", 15);
		}
		case 1:
		{
			SCMf(playerid, 0x33ceffFF, "�� ���������� %s �������� � ����������� (%s)", getName(id), Fraction_Name[PI[playerid][pMember]]);
			SCMf(id, 0x33ceffFF, "%s %s ��������� ��� �������� � ����������� (%s)", NameRang(playerid), getName(playerid), Fraction_Name[PI[playerid][pMember]]);
		}
		case 2:
		{
			SCMf(playerid, 0x36e96cFF, "�� ���������� %s ����� ���� �������.", getName(id));

			global_str[0] = EOS, format(global_str, 54, "%s ��������� ��� ����� �������", getName(playerid));
			SendPlayerOfferNotify(id, 1, global_str, "�����������", "����������", 15);
		}
		default: 
		{
			ClearRequest(PI[playerid][pRequestFor]);
			ClearRequest(playerid);
		}
	}
	return 1;
}
stock SendR(playerid) return SCM(playerid, -1, !"� ����������");