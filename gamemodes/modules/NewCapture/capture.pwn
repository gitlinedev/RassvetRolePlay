#define ROUND_TIME 		300
#define START_ROUND		5
#define FINISH_ROUND	5

new ShowTeam[MAX_PLAYERS][7];

new CommandKill[2],
	CommandRounds[2],
	Command[2],
	GangWarStatus,
	WarTime,
	CommadCount[2],
	PointCapture,
	CaptZone;

new EnterCaptureDoor_1,
	ExitCaptureDoor_1,
	EnterCaptureDoor_2,
	ExitCaptureDoor_2,
	EnterCaptureDoor_3,
	ExitCaptureDoor_3,
	EnterCaptureDoor_4,
	ExitCaptureDoor_4;

enum gwInfo
{
    gID,
    gPlayerID,
    gMember,
    gSpawnID,
    gGunID[13],
    gAmmoValue[13]
};
new GangWarInfo[14][gwInfo];

new Float:SpawnPositions[14][4] = {
    {1607.4351,-1260.8749,14.8756,359.1216}, // ��� 1
    {1609.0990,-1260.8530,14.8756,359.3382},
    {1610.5258,-1260.7863,14.8756,359.4837},
    {1612.1359,-1260.7865,14.8756,357.1240},
    {1611.6887,-1258.4590,14.8756,357.7011},
    {1610.1909,-1258.3292,14.8756,357.5043},
    {1607.9747,-1258.1593,14.8756,359.4154},
    {1628.4666,-1215.5222,14.8756,180.5904}, // ��� 2
    {1626.9211,-1215.5515,14.8756,179.4896},
    {1625.6156,-1215.5645,14.8756,178.5987},
    {1624.1788,-1215.5588,14.8756,176.8672},
    {1627.3544,-1217.8766,14.8756,177.6221},
    {1625.8696,-1217.8868,14.8756,176.0474},
    {1624.3450,-1217.8693,14.8756,176.5790}
};

//========================== [ �������� ��� ] ========================== //
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
static const stock ColorTeam[MAX_FRACTIONS][7] = {
	"FFFFFF",
	"ffeb9c",
 	"009900",
 	"2222FF",
 	"ff99cc",
 	"663399",
 	"66CCFF",
 	"339933"
};
//======================================= [ STOCKS ] ===================================//
stock capture_SecondTimer()
{
    if(GangWarStatus == 1)
	{
		WarTime--;

		if(WarTime == 0)
		{
			CommadCount[0] = GetCountonGanwWar(Command[0]);
			CommadCount[1] = GetCountonGanwWar(Command[1]);

			if(CommadCount[0] <= 0)
			{
				for(new i = 0; i < MAX_PLAYERS; i++)
				{
					if(PI[i][pMember] == Command[0] || PI[i][pMember] == Command[1])
					{
						GangZoneStopFlashForPlayer(i, WarZone);
						GangZoneHideForPlayer(i, WarZone);
						GangZoneShowForPlayer(i, WarZone, GetColorZone(Command[1]));
						
						cef_emit_event(i, "cef:capture:visible", CEFINT(false));

						if(PI[i][pOnCapture] == 1) PI[i][pOnCapture] = 0;

						SendClientMessagef(i, COLOR_YELLOW, "������� {%s}��� %s{FFFF00} ��������� ���������� {%s}��� %s{FFFF00} ����������� ���������", ColorTeam[Command[0]], Fraction_Name[Command[0]], ColorTeam[Command[1]], Fraction_Name[Command[1]]);
						ClearCapture();
					}
				}
				GangWarStatus = 0;
			}
			else if(CommadCount[1] <= 0)
			{
				for(new i = 0; i < MAX_PLAYERS; i++)
				{
					if(PI[i][pMember] == Command[0] || PI[i][pMember] == Command[1])
					{
						GangZoneStopFlashForPlayer(i, WarZone);
						gz_info[WarZone][gzopg] = Command[0];
						GangZoneHideForPlayer(i, WarZone);
						GangZoneShowForPlayer(i, WarZone, GetColorZone(Command[0]));
						SaveGZ(Command[0], WarZone);

						cef_emit_event(i, "cef:capture:visible", CEFINT(false));

						if(PI[i][pOnCapture] == 1) PI[i][pOnCapture] = 0;

						SendClientMessagef(i, COLOR_YELLOW, "������� {%s}��� %s{FFFF00} ��������� ���������� {%s}��� %s{FFFF00} ����������� �������", ColorTeam[Command[0]], Fraction_Name[Command[0]], ColorTeam[Command[1]], Fraction_Name[Command[1]]);
						ClearCapture();
					}
				}
				GangWarStatus = 0;
			}
			else
			{
				WarTime = START_ROUND;
				GangWarStatus = 2; // ������ ������ 

				for(new i = 0; i < MAX_PLAYERS; i++)
				{
					if(PI[i][pMember] == Command[0] || PI[i][pMember] == Command[1])
					{
						cef_emit_event(i, "cef:capture:start", CEFSTR("������ ������"), CEFINT(WarTime));
						if(PI[i][pOnCapture] == 1)
						{
							WaitToStart(i);
						}
					}
				}
			}
		}
	}
	if(GangWarStatus == 2) // ������ ������ (1)
	{
		WarTime--;
		if(WarTime <= 0)
		{
			RoundStart(3, "����� 1");
		}
	}
	if(GangWarStatus == 3) // ����� �����
	{
		WarTime--;

		if(CommandKill[0] == CommadCount[1] || CommandKill[1] == CommadCount[0])
		{
			Round(4, "���������� �����");
		}
	}
	if(GangWarStatus == 4) // ����� ������ (1)
	{
		WarTime--;
		if(WarTime <= 0)
		{
			RoundFinish(5, "������ ������", 0);
		}
	}
	if(GangWarStatus == 5) // ������ ������ (2)
	{
		WarTime--;
		if(WarTime <= 0)
		{
			RoundStart(6, "����� 2");
		}
	}
	if(GangWarStatus == 6) // ������ �����
	{
		WarTime--;

		if(CommandKill[0] >= CommadCount[1] || CommandKill[1] >= CommadCount[0])
		{
			Round(7, "���������� �����");
		}
	}
	if(GangWarStatus == 7) // ����� ������ (2)
	{
		WarTime--;
		if(WarTime <= 0)
		{
			RoundFinish(8, "������ ������", 0);
		}
	}
	if(GangWarStatus == 8) // ������ ������ (3)
	{
		WarTime--;
		if(WarTime <= 0)
		{
			RoundStart(9, "����� 3");
		}
	}
	if(GangWarStatus == 9) // ������ �����
	{
		WarTime--;

		if(CommandKill[0] >= CommadCount[1] || CommandKill[1] >= CommadCount[0])
		{
			Round(10, "���������� �����");
		}	
	}
	if(GangWarStatus == 10) // ����� ������ (3)
	{
		WarTime--;
		if(WarTime <= 0)
		{
			RoundFinish(11, "������ ������", 0);
		}
	}
	if(GangWarStatus == 11) // ������ ������ (3)
	{
		WarTime--;
		if(WarTime <= 0)
		{
			RoundStart(12, "����� 4");
		}
	}
	if(GangWarStatus == 12) // ��������� �����
	{
		WarTime--;

		if(CommandKill[0] >= CommadCount[1] || CommandKill[1] >= CommadCount[0])
		{
			Round(13, "���������� �����");
		}			
	}
	if(GangWarStatus == 13) // ����� ������ (4)
	{
		WarTime--;
		if(WarTime <= 0)
		{
			RoundFinish(14, "������ ������", 0);
		}
	}
	if(GangWarStatus == 14) // ������ ������ (5)
	{
		WarTime--;
		if(WarTime <= 0)
		{
			RoundStart(15, "����� 5");
		}
	}
	if(GangWarStatus == 15) // ����� �����
	{
		WarTime--;

		if(CommandKill[0] >= CommadCount[1] || CommandKill[1] >= CommadCount[0])
		{
			Round(16, "���������� �����");
		}	
	}
	if(GangWarStatus == 16) // ����� ������ (5)
	{
		WarTime--;
		if(WarTime <= 0)
		{
			RoundFinish(17, "������ ������", 1);
		}
	}
	if(GangWarStatus == 17) // ������ ������ (6)
	{
		WarTime--;
		if(WarTime <= 0)
		{
			RoundStart(18, "����� 6");
		}
	}
	if(GangWarStatus == 18) // ������ �����
	{
		WarTime--;

		if(CommandKill[0] >= CommadCount[1] || CommandKill[1] >= CommadCount[0])
		{
			Round(19, "���������� �����");
		}	
	}
	if(GangWarStatus == 19) // ����� ������ (6)
	{
		WarTime--;
		if(WarTime <= 0)
		{
			RoundFinish(20, "������ ������", 1);
		}
	}
	if(GangWarStatus == 20) // ������ ������ (7)
	{
		WarTime--;
		if(WarTime <= 0)
		{
			RoundStart(21, "����� 7");
		}
	}
	if(GangWarStatus == 21) // ������� ����� 
	{
		WarTime--;

		if(CommandKill[0] >= CommadCount[1] || CommandKill[1] >= CommadCount[0])
		{
			Round(22, "���������� �����");
		}	
	}
	if(GangWarStatus == 22) // ����� ������ (7)
	{
		WarTime--;
		if(WarTime <= 0)
		{
			RoundFinish(23, "������ ������", 1);
		}
	}
	if(GangWarStatus == 23) // ������ ������ (8)
	{
		WarTime--;
		if(WarTime <= 0)
		{
			RoundStart(24, "����� 8");
		}
	}
	if(GangWarStatus == 24) // ������� �����
	{
		WarTime--;

		if(CommandKill[0] >= CommadCount[1] || CommandKill[1] >= CommadCount[0])
		{
			Round(25, "���������� �����");
		}
	}
	if(GangWarStatus == 25) // ����� ������ (8)
	{
		WarTime--;
		if(WarTime <= 0)
		{
			RoundFinish(26, "������ ������", 1);
		}
	}
	if(GangWarStatus == 26) // ������ ������ (9)
	{
		WarTime--;
		if(WarTime <= 0)
		{
			RoundStart(27, "����� 9");
		}
	}
	if(GangWarStatus == 27) //  ��������� �����
	{
		WarTime--;

		if(CommandKill[0] >= CommadCount[1] || CommandKill[1] >= CommadCount[0])
		{
			Round(28, "���������� �����");
		}	
	}
	if(GangWarStatus == 28) // �����
	{
		WarTime--;
		if(WarTime <= 0)
		{
			FinishWar();
		}
	}
}
stock FinishWar()
{
	if(CommandRounds[0] < CommandRounds[1])
	{
		for(new i = 0; i < MAX_PLAYERS; i++)
		{
			if(PI[i][pMember] == Command[0] || PI[i][pMember] == Command[1])
			{
				GangZoneStopFlashForPlayer(i, WarZone);
				new col;
				switch(Command[1]) {
					case 5: col = 0x663399BB;
					case 6: col = 0x66CCFFBB;
					case 7: col = 0x339933AA;
				}
				GangZoneHideForPlayer(i, WarZone);
				GangZoneShowForPlayer(i, WarZone, col);
				
				cef_emit_event(i, "cef:capture:visible", CEFINT(false));
				cef_emit_event(i, "cef:kill:list:clear");

				TogglePlayerControllable(i, true);
				SendClientMessagef(i, COLOR_YELLOW, "������ {%s}��� %s{FFFF00} ��������� ���������� {%s}��� %s{FFFF00} ����������� ���������", ColorTeam[Command[0]], Fraction_Name[Command[0]], ColorTeam[Command[1]], Fraction_Name[Command[1]]);
				ClearCapture();
			}
		}
		for(new i = 0; i < MAX_PLAYERS; i++)
		{
			if(PI[i][pOnCapture] == 1)
			{
				if(PI[i][pMember] == Command[0] || PI[i][pMember] == Command[1])
				{
					SetPlayerPos(i, 1612.1749,-1209.9526,15.0275);
					SetPlayerFacingAngle(i, 1.0154);

					PI[i][pOnCapture] = 0;
					PI[i][pDeathOnCapture] = 0;
				}
			}
		}
		GangWarStatus = 0;
	}
	if(CommandRounds[0] > CommandRounds[1])
	{
		for(new i = 0; i < MAX_PLAYERS; i++)
		{
			if(PI[i][pMember] == Command[0] || PI[i][pMember] == Command[1])
			{
				GangZoneStopFlashForPlayer(i, WarZone);
				gz_info[WarZone][gzopg] = Command[0];
				new col;
				switch(Command[0]) 
				{
					case 5: col = 0x663399BB;
					case 6: col = 0x66CCFFBB;
					case 7: col = 0x339933AA;
				}
				GangZoneHideForPlayer(i, WarZone);
				GangZoneShowForPlayer(i, WarZone, col);
				SaveGZ(Command[0], WarZone);

				cef_emit_event(i, "cef:capture:visible", CEFINT(false));
				cef_emit_event(i, "cef:kill:list:clear");

				TogglePlayerControllable(i, true);
				SendClientMessagef(i, COLOR_YELLOW, "������ {%s}��� %s{FFFF00} ��������� ���������� {%s}��� %s{FFFF00} ����������� �������", ColorTeam[Command[0]], Fraction_Name[Command[0]], ColorTeam[Command[1]], Fraction_Name[Command[1]]);
				ClearCapture();
			}
		}
		for(new i = 0; i < MAX_PLAYERS; i++)
		{
			if(PI[i][pOnCapture] == 1)
			{
				if(PI[i][pMember] == Command[0] || PI[i][pMember] == Command[1])
				{
					SetPlayerPos(i, 1612.1749,-1209.9526,15.0275);
					SetPlayerFacingAngle(i, 1.0154);

					PI[i][pOnCapture] = 0;
					PI[i][pDeathOnCapture] = 0;
				}
			}
		}
		GangWarStatus = 0;
	}
}
stock FinishRoundPlayer(playerid)
{
	if(PI[playerid][pDeathOnCapture] == 1) SetTimerEx("DeathFinishRoundPlayer", 4900, false, "d", playerid);
	else {
		TogglePlayerControllable(playerid, false);
		SetTimerEx("NoDeathFinishRoundPlayer", 4900, false, "d", playerid);
	}
}
stock RoundStart(round, name[])
{
	CommandKill[0] = 0;
	CommandKill[1] = 0;

	GangWarStatus = round;
	WarTime = ROUND_TIME;

	for(new i = 0; i < MAX_PLAYERS; i++)
	{
		if(PI[i][pMember] == Command[0] || PI[i][pMember] == Command[1])
		{
			cef_emit_event(i, "cef:kill:list:clear");
			cef_emit_event(i, "cef:capture:start", CEFSTR(name), CEFINT(WarTime));
		}
	}
}
stock RoundFinish(round, name[], type)
{
	if(type == 0)
	{
		CommandKill[0] = 0;
		CommandKill[1] = 0;

		GangWarStatus = round;
		WarTime = START_ROUND;

		for(new i = 0; i < MAX_PLAYERS; i++)
		{
			if(PI[i][pMember] == Command[0] || PI[i][pMember] == Command[1])
			{
				cef_emit_event(i, "cef:capture:start", CEFSTR(name), CEFINT(WarTime));
			}
		}
	}
	else
	{
		if(CommandRounds[0] == 5 || CommandRounds[1] == 5)
		{
			FinishWar();
		}	
		else
		{
			if(WarTime <= 0)
			{
				CommandKill[0] = 0;
				CommandKill[1] = 0;

				GangWarStatus = round;
				WarTime = START_ROUND;

				for(new i = 0; i < MAX_PLAYERS; i++)
				{
					if(PI[i][pMember] == Command[0] || PI[i][pMember] == Command[1])
					{
						cef_emit_event(i, "cef:capture:start", CEFSTR(name), CEFINT(WarTime));
					}
				}
			}
		}
	}
}
stock Round(round, name[])
{
	if(CommandKill[0] == CommadCount[1]) 
	{
		for(new i = 0; i < MAX_PLAYERS; i++) 
		{
			if(PI[i][pMember] == Command[0] && PI[i][pDeathOnCapture] == 0)
			{
				TogglePlayerControllable(i, false);
			}
		}
		CommandRounds[0]++;
	}
	else if(CommandKill[1] == CommadCount[0]) 
	{
		for(new i = 0; i < MAX_PLAYERS; i++) 
		{
			if(PI[i][pMember] == Command[1] && PI[i][pDeathOnCapture] == 0)
			{
				TogglePlayerControllable(i, false);
			}
		}
		CommandRounds[1]++;
	}

	for(new i = 0; i < MAX_PLAYERS; i++) 
	{
		if(PI[i][pMember] == Command[0] && PI[i][pOnCapture] == 1) FinishRoundPlayer(i);
		if(PI[i][pMember] == Command[1] && PI[i][pOnCapture] == 1) FinishRoundPlayer(i);
	}

	GangWarStatus = round;
	WarTime = FINISH_ROUND;

	for(new i; i < MAX_PLAYERS; i++) 
	{
		if(PI[i][pMember] == Command[0] || PI[i][pMember] == Command[1])
		{
			cef_emit_event(i, "cef:capture:start", CEFSTR(name), CEFINT(WarTime));
			cef_emit_event(i, "cef:capture:gang:score", CEFINT(1), CEFINT(CommandRounds[0]));
			cef_emit_event(i, "cef:capture:gang:score", CEFINT(2), CEFINT(CommandRounds[1]));
		}
	}
}
callback: DeathFinishRoundPlayer(playerid)
{
	new id = GetPlayerID(playerid);

	for(new i = 0; i < 13; i++)  {
	    if(PI[playerid][data_GUN][i] != 0 && PI[playerid][data_AMMO][i] != 0) GivePlayerWeapon(playerid, PI[playerid][data_GUN][i], PI[playerid][data_AMMO][i]);
	}

	SetPlayerPos(playerid, SpawnPositions[GangWarInfo[id][gSpawnID]][0], SpawnPositions[GangWarInfo[id][gSpawnID]][1], SpawnPositions[GangWarInfo[id][gSpawnID]][2]);
	SetPlayerFacingAngle(playerid, SpawnPositions[GangWarInfo[id][gSpawnID]][3]);
	SetCameraBehindPlayer(playerid);

	TogglePlayerControllable(playerid, false);
	SetPlayerHealthAC(playerid, 176);

	return SetTimerEx("StartWar", 5000, false, "d", playerid);
}
callback: NoDeathFinishRoundPlayer(playerid)
{
	new id = GetPlayerID(playerid);

	SetPlayerPos(playerid, SpawnPositions[GangWarInfo[id][gSpawnID]][0], SpawnPositions[GangWarInfo[id][gSpawnID]][1], SpawnPositions[GangWarInfo[id][gSpawnID]][2]);
	SetPlayerFacingAngle(playerid, SpawnPositions[GangWarInfo[id][gSpawnID]][3]);
	SetCameraBehindPlayer(playerid);

	TogglePlayerControllable(playerid, false);
	SetPlayerHealthAC(playerid, 176);

	return SetTimerEx("StartWar", 5000, false, "d", playerid);
}
stock WaitToStart(playerid) // ������ �������
{
	new id = GetPlayerID(playerid);

	SetPlayerPos(playerid, SpawnPositions[GangWarInfo[id][gSpawnID]][0], SpawnPositions[GangWarInfo[id][gSpawnID]][1], SpawnPositions[GangWarInfo[id][gSpawnID]][2]);
	SetPlayerFacingAngle(playerid, SpawnPositions[GangWarInfo[id][gSpawnID]][3]);
	SetCameraBehindPlayer(playerid);

	TogglePlayerControllable(playerid, false);
	SetPlayerHealthAC(playerid, 176);

	SetTimerEx("StartWar", 5000, false, "d", playerid);
}
callback: StartWar(playerid)
{
	PI[playerid][pDeathOnCapture] = 0;
	TogglePlayerControllable(playerid, true);
	cef_emit_event(playerid, "cef:capture:sound", CEFINT(1));
}
stock GetColorZone(team)
{
	new col;
	switch(team) 
	{
		case 5: col = 0x663399BB;
		case 6: col = 0x66CCFFBB;
		case 7: col = 0x339933AA;
	}
	return col;
}
stock capture_OnDialogResponse(playerid, dialogid, response, listitem)
{
    switch(dialogid)
    {
        case 4901:
        {
            if(!response) return 1;
            if(response)
            {
				new count = GetCountonGanwWar(PI[playerid][pMember]);

				if(!AddPlayerToCapture(playerid) && count >= 7) return SendClientMessage(playerid, COLOR_LIGHTGREY, "��������� ���� ��� ��� (7/7)");
				else 
				{
					if(GangWarStatus > 1) return SendClientMessage(playerid, COLOR_LIGHTGREY, "������ ���������� ��� �������");
					SendFractionMessagef(PI[playerid][pMember], 0x69b867FF, "[R] %s %s[%d] ������������� � ���������� ������ (%d/7)", NameRang(playerid), getName(playerid), playerid, count + 1);
				}
            }
        }
		case 4903:
		{
			if(!response) return 1;
			if(response)
			{
				new id = ShowTeam[playerid][listitem];

				if(PI[id][pOnCapture] == 0) return SendClientMessage(playerid, COLOR_LIGHTGREY, !"������ ����� �� ��������� ������� � ������� ����������");
				if(PI[id][pOnCapture] == 1 && GangWarStatus >= 2) return SendClientMessage(playerid, COLOR_LIGHTGREY, !"�� �� ������ ��������� ������, ����� ��� ������ �� ����������");
                    
				for (new i = 0; i < sizeof(GangWarInfo); i++)
				{
					if(GangWarInfo[i][gPlayerID] == id)
					{
						GangWarInfo[i][gPlayerID] = INVALID_PLAYER_ID;
						GangWarInfo[i][gMember] = -1;
						GangWarInfo[i][gSpawnID] = -1;
					}
				}
				PI[id][pOnCapture] = 0;

				new count = GetCountonGanwWar(PI[playerid][pMember]);

				SendFractionMessagef(PI[playerid][pMember], COLOR_TOMATO, "[R] %s %s[%d] �������� %s %s[%d] �� ���������� ������ (%d/7)",\
					NameRang(playerid), getName(playerid), playerid, NameRang(id), getName(id), id, count);
			}
		}
    }
    return 1;
}
stock AutoKickCapture(playerid)
{
	if(PI[playerid][pOnCapture] == 1 && GangWarStatus >= 1)
	{
		if(PI[playerid][pMember] == Command[0]) CommadCount[0]--;
		else if(PI[playerid][pMember] == Command[1]) CommadCount[1]--;

		for (new i = 0; i < sizeof(GangWarInfo); i++)
		{
			if(GangWarInfo[i][gPlayerID] == playerid)
			{
				GangWarInfo[i][gPlayerID] = INVALID_PLAYER_ID;
				GangWarInfo[i][gMember] = -1;
				GangWarInfo[i][gSpawnID] = -1;
			}
		}
		PI[playerid][pOnCapture] = 0;
		new count = GetCountonGanwWar(PI[playerid][pMember]);

		SendFractionMessagef(PI[playerid][pMember], COLOR_TOMATO, "[R] %s %s[%d] ������������� �������� �� ���������� ������ (%d/7)",\
			NameRang(playerid), getName(playerid), playerid, count);
	}
}
stock CheckCount(playerid)
{
	if(GangWarStatus > 1)
	{
		if(CommadCount[0] <= 0 || CommadCount[1] <= 0)
		{			
			if(PI[playerid][pMember] == Command[0] && CommadCount[0] <= 0)
			{
				for(new i = 0; i < MAX_PLAYERS; i++)
				{
					if(PI[i][pMember] == Command[0] || PI[i][pMember] == Command[1])
					{
						GangZoneStopFlashForPlayer(i, WarZone);
						new col;
						switch(Command[1]) 
						{
							case 5: col = 0x663399BB;
							case 6: col = 0x66CCFFBB;
							case 7: col = 0x339933AA;
						}
						GangZoneHideForPlayer(i, WarZone);
						GangZoneShowForPlayer(i, WarZone, col);

						cef_emit_event(i, "cef:capture:visible", CEFINT(false));

						TogglePlayerControllable(i, true);
						SendClientMessagef(i, COLOR_YELLOW, "������ {%s}��� %s{FFFF00} ��������� ���������� {%s}��� %s{FFFF00} ����������� ���������", ColorTeam[Command[0]], Fraction_Name[Command[0]], ColorTeam[Command[1]], Fraction_Name[Command[1]]);
						ClearCapture();
					}
					if(PI[i][pOnCapture] == 1)
					{
						if(PI[i][pMember] == Command[0] || PI[i][pMember] == Command[1])
						{
							SetPlayerPos(i, 1612.1749,-1209.9526,15.0275);
							SetPlayerFacingAngle(i, 1.0154);

							PI[i][pOnCapture] = 0;
							PI[i][pDeathOnCapture] = 0;
						}
					}
				}
				GangWarStatus = 0;
			}
			if(PI[playerid][pMember] == Command[1] && CommadCount[1] <= 0)
			{
				for(new i = 0; i < MAX_PLAYERS; i++)
				{
					if(PI[i][pMember] == Command[0] || PI[i][pMember] == Command[1])
					{
						GangZoneStopFlashForPlayer(i, WarZone);
						gz_info[WarZone][gzopg] = Command[0];
						new col;
						switch(Command[0]) 
						{
							case 5: col = 0x663399BB;
							case 6: col = 0x66CCFFBB;
							case 7: col = 0x339933AA;
						}
						GangZoneHideForPlayer(i, WarZone);
						GangZoneShowForPlayer(i, WarZone, col);
						SaveGZ(Command[0], WarZone);

						cef_emit_event(i, "cef:capture:visible", CEFINT(false));

						TogglePlayerControllable(i, true);
						SendClientMessagef(i, COLOR_YELLOW, "������ {%s}��� %s{FFFF00} ��������� ���������� {%s}��� %s{FFFF00} ����������� �������", ColorTeam[Command[0]], Fraction_Name[Command[0]], ColorTeam[Command[1]], Fraction_Name[Command[1]]);
						ClearCapture();
					}
					if(PI[i][pOnCapture] == 1)
					{
						if(PI[i][pMember] == Command[0] || PI[i][pMember] == Command[1])
						{
							SetPlayerPos(i, 1612.1749,-1209.9526,15.0275);
							SetPlayerFacingAngle(i, 1.0154);

							PI[i][pOnCapture] = 0;
							PI[i][pDeathOnCapture] = 0;
						}
					}
				}
				GangWarStatus = 0;
			}
		}
	}
}
stock capture_OnPlayerDisconnect(playerid)
{
	if(PI[playerid][pOnCapture] == 1 && GangWarStatus >= 1)
	{
		AutoKickCapture(playerid);
		CheckCount(playerid);
	}
}
stock AddPlayerToCapture(playerid)
{
    new spawnID;
    new count = GetCountonGanwWar(PI[playerid][pMember]);

    if (count >= 7) 
    {
        return 0;
    }

    if(PI[playerid][pMember] == Command[0])
    {
        for (spawnID = 0; spawnID <= 6; spawnID++)
        {
            new isFree = true;
            for (new i = 0; i < sizeof(GangWarInfo); i++)
            {
                if (GangWarInfo[i][gSpawnID] == spawnID)
                {
                    isFree = false;
                    break;
                }
            }
            if (isFree)
            {
                for (new i = 0; i < sizeof(GangWarInfo); i++)
                {
                    if (GangWarInfo[i][gPlayerID] == INVALID_PLAYER_ID)
                    {
                        GangWarInfo[i][gMember] = PI[playerid][pMember];
                        GangWarInfo[i][gPlayerID] = playerid;
                        GangWarInfo[i][gSpawnID] = spawnID;
                        PI[playerid][pOnCapture] = 1;
                        return 1;
                    }
                }
            }
        }
    }
    else if(PI[playerid][pMember] == Command[1])
    {
        for (spawnID = 7; spawnID <= 14; spawnID++)
        {
            new isFree = true;
            for (new i = 0; i < sizeof(GangWarInfo); i++)
            {
                if (GangWarInfo[i][gSpawnID] == spawnID)
                {
                    isFree = false;
                    break;
                }
            }
            if (isFree)
            {
                for (new i = 0; i < sizeof(GangWarInfo); i++)
                {
                    if (GangWarInfo[i][gPlayerID] == INVALID_PLAYER_ID)
                    {
                        GangWarInfo[i][gMember] = PI[playerid][pMember];
                        GangWarInfo[i][gPlayerID] = playerid;
                        GangWarInfo[i][gSpawnID] = spawnID;
                        PI[playerid][pOnCapture] = 1;
                        return 1;
                    }
                }
            }
        }
    }
    return 0;
}
stock GetPlayerID(playerid)
{
    for (new i = 0; i < sizeof(GangWarInfo); i++)
    {
        if(GangWarInfo[i][gPlayerID] == playerid)
        {
            return i;   
        }
    }
    return 0;
}
stock GetCountonGanwWar(org)
{
	new count;
    for (new i = 0; i < sizeof(GangWarInfo); i++)
    {
        if(GangWarInfo[i][gMember] == org)
        {
            count++;
        }
    }
    return count;
}
stock ClearCapture()
{
	for (new i = 0; i < sizeof(GangWarInfo); i++)
    {
		GangWarInfo[i][gMember] = -1;
		GangWarInfo[i][gPlayerID] = INVALID_PLAYER_ID;
		GangWarInfo[i][gSpawnID] = -1;
    }
	CommandRounds[0] = 0;
	CommandRounds[0] = 0;
	CommandKill[0] = 0;
	CommandKill[0] = 0;
	CommadCount[0] = 0;
	CommadCount[1] = 0;
}
stock capture_OnPlayerPickUpPickup(playerid, pickupid)
{
	if(pickupid == EnterCaptureDoor_1)
	{
		SetPlayerPos(playerid, 1604.3113,-1226.3220,19.3756);
		SetPlayerFacingAngle(playerid, 179.5126);
	}
	if(pickupid == ExitCaptureDoor_1)
	{
		SetPlayerPos(playerid, 1601.1157,-1220.9907,18.9455);
		SetPlayerFacingAngle(playerid, 0.0506);
	}
	if(pickupid == EnterCaptureDoor_2)
	{
		SetPlayerPos(playerid, 1604.3705,-1248.8694,19.3756);
		SetPlayerFacingAngle(playerid, 359.1553);
	}
	if(pickupid == ExitCaptureDoor_2)
	{
		SetPlayerPos(playerid, 1601.3778,-1248.5814,18.9381);
		SetPlayerFacingAngle(playerid, 357.6634);
	}
	//========
	if(pickupid == EnterCaptureDoor_3)
	{
		SetPlayerPos(playerid, 1631.7888,-1227.8033,19.3756);
		SetPlayerFacingAngle(playerid, 179.8580);
	}
	if(pickupid == ExitCaptureDoor_3)
	{
		SetPlayerPos(playerid, 1634.6638,-1226.7799,18.9381);
		SetPlayerFacingAngle(playerid, 180.7958);
	}
	//========
	if(pickupid == EnterCaptureDoor_4)
	{
		SetPlayerPos(playerid, 1631.7452,-1249.8218,19.3756);
		SetPlayerFacingAngle(playerid, 358.6725);
	}
	if(pickupid == ExitCaptureDoor_4)
	{
		SetPlayerPos(playerid, 1634.6162,-1248.2965,18.9455);
		SetPlayerFacingAngle(playerid, 359.9435);
	}
	return 1;
}
stock capture_OnGameModeInit()
{
	PointCapture = CreatePickup(1314, 23, 1581.4766,-1194.2380,14.9259, -1); // ������ �� ����
	//======================================
	EnterCaptureDoor_1 = CreatePickup(1318, 23, 1602.2643,-1224.1396,19.3209, -1);
	ExitCaptureDoor_1 = CreatePickup(1318, 23, 1603.4683,-1224.2054,19.3756, -1);

	EnterCaptureDoor_2 = CreatePickup(1318, 23, 1602.2136,-1251.9309,18.9381, -1);
	ExitCaptureDoor_2 = CreatePickup(1318, 23, 1603.4685,-1252.0131,19.3756, -1);

	EnterCaptureDoor_3 = CreatePickup(1318, 23, 1633.8176,-1224.1461,19.3209, -1);
	ExitCaptureDoor_3 = CreatePickup(1318, 23, 1632.8224,-1224.2566,19.3756, -1);

	EnterCaptureDoor_4 = CreatePickup(1318, 23, 1633.8164,-1251.9113,19.3209, -1);
	ExitCaptureDoor_4 = CreatePickup(1318, 23, 1632.8217,-1251.9086,19.3756, -1);
}
stock CaptureStart(gz, playerid)
{
	PI[playerid][pPayDayMoney] += 8000;
	PI[playerid][pProgressCapture]+= 1;

	GangWarStatus = 1;
	//
	WarTime = 60;
	WarZone = gz;
	//
	CommandKill[0]= 0;
	CommandKill[1]= 0;
	CommandRounds[0] = 0;
	CommandRounds[1] = 0;

	Command[0] = PI[playerid][pMember];
	Command[1] = gz_info[gz][gzopg];
}
//===============================================================[ CMD ]===============================================================//
cmd:capture(playerid) 
{
    if(!IsPlayerOPG(playerid))  return SCM(playerid, COLOR_GREY, !"�� �� �������� � ���");
    if(PI[playerid][pRang] < 7) return SCM(playerid, COLOR_GREY, !"������ ������� ����� ������������ � 7-�� �����");
	new gz = GetPlayerGangZone(playerid);
	if(gz == -1) return SCM(playerid, COLOR_GREY, !"�� �� ���������� �� � ����� �� ���");
    if(GetPVarInt(playerid,"Counting_Capture") > gettime()) return SCM(playerid, COLOR_GREY, !"������� ����� ������������ ��� � 1 ������");
    SetPVarInt(playerid,"Counting_Capture",gettime() + 59);

    new hour, minute, second;
    gettime(hour, minute, second);
    
    if(Coolldown_Capture == 1) 
	{
		if(!((hour >= 12 && hour <= 19) && minute == 0) && !(hour >= 20 && hour <= 23) && !(hour >= 0 && hour <= 9))
		{
			return SCM(playerid, COLOR_GREY, !"������ ���������� ��� ����� ��� �������� � 12:00, 13:00, 14:00, 15:00, 16:00, 17:00, 18:00, 20:00, 21:00, 22:00, 23:00");
		}
	}

	if(GangWarStatus == 1) return SCM(playerid, COLOR_GREY, !"� ������ ������ ��� ���� ����� �� ����������");
    if(gz_info[gz][gzopg] == PI[playerid][pMember]) return SCM(playerid, COLOR_GREY, !"�� �� ������ ��������� ���� ����������");

	switch(gz_info[gz][gzopg]) 
	{
	    case 5: if(m_skinhead > 1) return SCM(playerid, COLOR_GREY, !"� ������ ��� ����������� ������� ����������");
		case 6: if(m_gopota > 1) return SCM(playerid, COLOR_GREY, !"� ������ ��� ����������� ������� ����������");
		case 7: if(m_kavkaz > 1) return SCM(playerid, COLOR_GREY, !"� ������ ��� ����������� ������� ����������");
	}
	switch(PI[playerid][pMember]) 
	{
	    case 5: if(m_skinhead > 1) return SCM(playerid, COLOR_GREY, !"� ����� ��� ����������� ������� ����������");
		case 6: if(m_gopota > 1) return SCM(playerid, COLOR_GREY, !"� ����� ��� ����������� ������� ����������");
		case 7: if(m_kavkaz > 1) return SCM(playerid, COLOR_GREY, !"� ����� ��� ����������� ������� ����������");
	}
    if(gz_info[gz][gzid] == 101) return 1;

	CaptureStart(gz, playerid);

	SCM(playerid, COLOR_YELLOW, !"�� ��������� ������� ���������� �� �������� �������������� � PayDay"); 
	foreach(new i:Player) 
	{
	    if(PI[i][pMember] == Command[0] || PI[i][pMember] == Command[1])
		{
			SCMf(i, COLOR_YELLOW, "%s {%s} %s[%d] (%s){FFFF00} ����� ������ �� ���������� {%s}(%s)", \
				NameRang(playerid), ColorTeam[Command[0]], getName(playerid), playerid, Fraction_Name[PI[playerid][pMember]], ColorTeam[Command[1]], Fraction_Name[Command[1]]);

			SCM(i, COLOR_YELLOW, !"���������� �������� �� ����� ������� �������� ���������������");
			SCM(i, COLOR_YELLOW, !"����� ������ �������� � ��� �� ����-����� (/gps 5 5)");

			cef_emit_event(i, "cef:capture:visible", CEFINT(true));
			cef_emit_event(i, "cef:capture:gang:name", CEFINT(1), CEFSTR(Fraction_Name[Command[0]]));
			cef_emit_event(i, "cef:capture:gang:name", CEFINT(2), CEFSTR(Fraction_Name[Command[1]]));
			cef_emit_event(i, "cef:capture:gang:score", CEFINT(1), CEFINT(0));
			cef_emit_event(i, "cef:capture:gang:score", CEFINT(2), CEFINT(0));
			cef_emit_event(i, "cef:capture:start", CEFSTR("���������� � �����"), CEFINT(60));

			GangZoneFlashForPlayer(i, gz, 0xFF000055);	
		}
	}
	for(new g; g < totalgz; g++) 
	{
	    if(gz_info[g][gzid] == 101) 
		{
			CaptZone = GangZoneCreate(gz_info[g][gzminx], gz_info[g][gzminy], gz_info[g][gzmaxx], gz_info[g][gzmaxy]);
			foreach(new i:Player) if(PI[i][pMember] >= 5 && PI[i][pMember] <= 7) GangZoneShowForPlayer(i, g, 0xFF000055);
	    }
	}
	return 1;
}
CMD:cteam(playerid, params[]) 
{
	if(GangWarStatus <= 0) return SCM(playerid, COLOR_LIGHTGREY, !"� ������ ������ �� �������� ������ ����������");

    new string[1048] = "", count = 0;

    for (new i = 0; i < MAX_PLAYERS; i++)
    {
        if (!IsPlayerConnected(i)) continue;
		if (GangWarInfo[i][gMember] == -1) continue;

        if (GangWarInfo[i][gMember] == PI[playerid][pMember]) 
        {
            ShowTeam[playerid][count] = GangWarInfo[i][gPlayerID];
            count++;
            f(string, sizeof(string), "%s%d\t%s[%d]\t%s[%d]\t%d ��\n", 
                   string, count, 
                   PI[GangWarInfo[i][gPlayerID]][pName], GangWarInfo[i][gPlayerID], 
                   NameRang(GangWarInfo[i][gPlayerID]), PI[GangWarInfo[i][gPlayerID]][pRang], 
                   GetPlayerPing(GangWarInfo[i][gPlayerID])
			);
        }
    }

    if (count == 0) 
    {
        ShowPlayerDialog(playerid, 0, DIALOG_STYLE_MSGBOX, "{ee3366}��������� ������", "{FFFFFF}������ ���������� ����.", "�������", "");
    } 
    else 
    {
        new str_1[512*2];
        format(str_1, sizeof(str_1), "�\t�����\t����\t����\n%s", string);
        CEF_ShowPlayerDialog(playerid, 
                         (PI[playerid][pCaptureManager] == 1 || PI[playerid][pRang] >= 9) ? 4903 : 0, 
                         DIALOG_STYLE_TABLIST_HEADERS, "{ee3366}��������� ������", 
                         str_1, 
                         (PI[playerid][pCaptureManager] == 1 || PI[playerid][pRang] >= 9) ? "���������" : "�������", 
                         "�������");
    }
    return 1;
}
CMD:clead(playerid, params[]) 
{
    if (PI[playerid][pRang] <= 10) 
        return SCM(playerid, COLOR_GREY, !"������ ������� �������� ������� �����������");

    new targetid;
    if (sscanf(params, "u", targetid)) 
        return SCM(playerid, COLOR_LIGHTGREY, !"�����������: /clead [ID ������]");

    if (!IsPlayerConnected(targetid))
        return SCM(playerid, COLOR_GREY, !"����� �� � ����");

    if(!IsPlayerLogged{targetid})
        return SCM(playerid, COLOR_GREY, !"����� �� �����������");

    if (PI[playerid][pMember] != PI[targetid][pMember]) 
        return SCM(playerid, COLOR_GREY, !"������ ����� �� ������� � ����� �����������");

    if (PI[targetid][pCaptureManager] == 0) 
    {
        new Cache: result, query[128];
        mysql_format(mysql, query, sizeof query, 
            "SELECT * FROM accounts WHERE member='%d' AND CaptureManager='1'", PI[playerid][pMember]);
        result = mysql_query(mysql, query, true);

        if (cache_num_rows() >= 3) 
        {
            cache_delete(result);
            return SendClientMessage(playerid, COLOR_GREY, !"�������� ����� ����� 3 ��������� �� �������� ����������");
        }
        cache_delete(result);

        SendFractionMessagef(PI[playerid][pMember], 0x69b867FF,\
            "[R] %s %s[%d] �������� ��������� �� ������� %s %s[%d]",\
            NameRang(playerid), getName(playerid), playerid,\
            NameRang(targetid), getName(targetid), targetid);

        PI[targetid][pCaptureManager] = 1;
    } 
    else 
    {
        SendFractionMessagef(PI[playerid][pMember], COLOR_TOMATO,\
            "[R] %s %s[%d] ���� ���������� �� ������� %s %s[%d]",\
            NameRang(playerid), getName(playerid), playerid,\
            NameRang(targetid), getName(targetid), targetid);

        PI[targetid][pCaptureManager] = 0;
    }

    UpdatePlayerDataInt(targetid, "CaptureManager", PI[targetid][pCaptureManager]);

    return 1;
}
