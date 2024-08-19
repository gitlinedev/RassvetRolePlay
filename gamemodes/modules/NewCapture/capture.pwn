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
    {1607.4351,-1260.8749,14.8756,359.1216}, // ОПГ 1
    {1609.0990,-1260.8530,14.8756,359.3382},
    {1610.5258,-1260.7863,14.8756,359.4837},
    {1612.1359,-1260.7865,14.8756,357.1240},
    {1611.6887,-1258.4590,14.8756,357.7011},
    {1610.1909,-1258.3292,14.8756,357.5043},
    {1607.9747,-1258.1593,14.8756,359.4154},
    {1628.4666,-1215.5222,14.8756,180.5904}, // ОПГ 2
    {1626.9211,-1215.5515,14.8756,179.4896},
    {1625.6156,-1215.5645,14.8756,178.5987},
    {1624.1788,-1215.5588,14.8756,176.8672},
    {1627.3544,-1217.8766,14.8756,177.6221},
    {1625.8696,-1217.8868,14.8756,176.0474},
    {1624.3450,-1217.8693,14.8756,176.5790}
};

//========================== [ название орг ] ========================== //
static const stock Fraction_Name[MAX_FRACTIONS][32] = {
	"Гражданский",
	"Правительство",
 	"Войсковая часть",
 	"Полиция",
 	"БЦРБ",
 	"Скинхеды",
 	"Гопота",
 	"Кавказцы"
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

						SendClientMessagef(i, COLOR_YELLOW, "Попытка {%s}ОПГ %s{FFFF00} захватить территорию {%s}ОПГ %s{FFFF00} завершилась неуспешно", ColorTeam[Command[0]], Fraction_Name[Command[0]], ColorTeam[Command[1]], Fraction_Name[Command[1]]);
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

						SendClientMessagef(i, COLOR_YELLOW, "Попытка {%s}ОПГ %s{FFFF00} захватить территорию {%s}ОПГ %s{FFFF00} завершилась успешно", ColorTeam[Command[0]], Fraction_Name[Command[0]], ColorTeam[Command[1]], Fraction_Name[Command[1]]);
						ClearCapture();
					}
				}
				GangWarStatus = 0;
			}
			else
			{
				WarTime = START_ROUND;
				GangWarStatus = 2; // начало раунда 

				for(new i = 0; i < MAX_PLAYERS; i++)
				{
					if(PI[i][pMember] == Command[0] || PI[i][pMember] == Command[1])
					{
						cef_emit_event(i, "cef:capture:start", CEFSTR("начало раунда"), CEFINT(WarTime));
						if(PI[i][pOnCapture] == 1)
						{
							WaitToStart(i);
						}
					}
				}
			}
		}
	}
	if(GangWarStatus == 2) // начало раунда (1)
	{
		WarTime--;
		if(WarTime <= 0)
		{
			RoundStart(3, "раунд 1");
		}
	}
	if(GangWarStatus == 3) // перый раунд
	{
		WarTime--;

		if(CommandKill[0] == CommadCount[1] || CommandKill[1] == CommadCount[0])
		{
			Round(4, "завершение битвы");
		}
	}
	if(GangWarStatus == 4) // конец раунда (1)
	{
		WarTime--;
		if(WarTime <= 0)
		{
			RoundFinish(5, "начало раунда", 0);
		}
	}
	if(GangWarStatus == 5) // начало раунда (2)
	{
		WarTime--;
		if(WarTime <= 0)
		{
			RoundStart(6, "раунд 2");
		}
	}
	if(GangWarStatus == 6) // второй раунд
	{
		WarTime--;

		if(CommandKill[0] >= CommadCount[1] || CommandKill[1] >= CommadCount[0])
		{
			Round(7, "завершение битвы");
		}
	}
	if(GangWarStatus == 7) // конец раунда (2)
	{
		WarTime--;
		if(WarTime <= 0)
		{
			RoundFinish(8, "начало раунда", 0);
		}
	}
	if(GangWarStatus == 8) // начало раунда (3)
	{
		WarTime--;
		if(WarTime <= 0)
		{
			RoundStart(9, "раунд 3");
		}
	}
	if(GangWarStatus == 9) // третий раунд
	{
		WarTime--;

		if(CommandKill[0] >= CommadCount[1] || CommandKill[1] >= CommadCount[0])
		{
			Round(10, "завершение битвы");
		}	
	}
	if(GangWarStatus == 10) // конец раунда (3)
	{
		WarTime--;
		if(WarTime <= 0)
		{
			RoundFinish(11, "начало раунда", 0);
		}
	}
	if(GangWarStatus == 11) // начало раунда (3)
	{
		WarTime--;
		if(WarTime <= 0)
		{
			RoundStart(12, "раунд 4");
		}
	}
	if(GangWarStatus == 12) // четвертый раунд
	{
		WarTime--;

		if(CommandKill[0] >= CommadCount[1] || CommandKill[1] >= CommadCount[0])
		{
			Round(13, "завершение битвы");
		}			
	}
	if(GangWarStatus == 13) // конец раунда (4)
	{
		WarTime--;
		if(WarTime <= 0)
		{
			RoundFinish(14, "начало раунда", 0);
		}
	}
	if(GangWarStatus == 14) // начало раунда (5)
	{
		WarTime--;
		if(WarTime <= 0)
		{
			RoundStart(15, "раунд 5");
		}
	}
	if(GangWarStatus == 15) // пятый раунд
	{
		WarTime--;

		if(CommandKill[0] >= CommadCount[1] || CommandKill[1] >= CommadCount[0])
		{
			Round(16, "завершение битвы");
		}	
	}
	if(GangWarStatus == 16) // конец раунда (5)
	{
		WarTime--;
		if(WarTime <= 0)
		{
			RoundFinish(17, "начало раунда", 1);
		}
	}
	if(GangWarStatus == 17) // начало раунда (6)
	{
		WarTime--;
		if(WarTime <= 0)
		{
			RoundStart(18, "раунд 6");
		}
	}
	if(GangWarStatus == 18) // шестой раунд
	{
		WarTime--;

		if(CommandKill[0] >= CommadCount[1] || CommandKill[1] >= CommadCount[0])
		{
			Round(19, "завершение битвы");
		}	
	}
	if(GangWarStatus == 19) // конец раунда (6)
	{
		WarTime--;
		if(WarTime <= 0)
		{
			RoundFinish(20, "начало раунда", 1);
		}
	}
	if(GangWarStatus == 20) // начало раунда (7)
	{
		WarTime--;
		if(WarTime <= 0)
		{
			RoundStart(21, "раунд 7");
		}
	}
	if(GangWarStatus == 21) // седьмой раунд 
	{
		WarTime--;

		if(CommandKill[0] >= CommadCount[1] || CommandKill[1] >= CommadCount[0])
		{
			Round(22, "завершение битвы");
		}	
	}
	if(GangWarStatus == 22) // конец раунда (7)
	{
		WarTime--;
		if(WarTime <= 0)
		{
			RoundFinish(23, "начало раунда", 1);
		}
	}
	if(GangWarStatus == 23) // начало раунда (8)
	{
		WarTime--;
		if(WarTime <= 0)
		{
			RoundStart(24, "раунд 8");
		}
	}
	if(GangWarStatus == 24) // восьмой раунд
	{
		WarTime--;

		if(CommandKill[0] >= CommadCount[1] || CommandKill[1] >= CommadCount[0])
		{
			Round(25, "завершение битвы");
		}
	}
	if(GangWarStatus == 25) // конец раунда (8)
	{
		WarTime--;
		if(WarTime <= 0)
		{
			RoundFinish(26, "начало раунда", 1);
		}
	}
	if(GangWarStatus == 26) // начало раунда (9)
	{
		WarTime--;
		if(WarTime <= 0)
		{
			RoundStart(27, "раунд 9");
		}
	}
	if(GangWarStatus == 27) //  последний раунд
	{
		WarTime--;

		if(CommandKill[0] >= CommadCount[1] || CommandKill[1] >= CommadCount[0])
		{
			Round(28, "завершение битвы");
		}	
	}
	if(GangWarStatus == 28) // итоги
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
				SendClientMessagef(i, COLOR_YELLOW, "Попыка {%s}ОПГ %s{FFFF00} захватить территорию {%s}ОПГ %s{FFFF00} завершилась неуспешно", ColorTeam[Command[0]], Fraction_Name[Command[0]], ColorTeam[Command[1]], Fraction_Name[Command[1]]);
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
				SendClientMessagef(i, COLOR_YELLOW, "Попыка {%s}ОПГ %s{FFFF00} захватить территорию {%s}ОПГ %s{FFFF00} завершилась успешно", ColorTeam[Command[0]], Fraction_Name[Command[0]], ColorTeam[Command[1]], Fraction_Name[Command[1]]);
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
stock WaitToStart(playerid) // начало раундов
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

				if(!AddPlayerToCapture(playerid) && count >= 7) return SendClientMessage(playerid, COLOR_LIGHTGREY, "Свободных мест уже нет (7/7)");
				else 
				{
					if(GangWarStatus > 1) return SendClientMessage(playerid, COLOR_LIGHTGREY, "Захват территории уже начался");
					SendFractionMessagef(PI[playerid][pMember], 0x69b867FF, "[R] %s %s[%d] присоединился к участникам стрелы (%d/7)", NameRang(playerid), getName(playerid), playerid, count + 1);
				}
            }
        }
		case 4903:
		{
			if(!response) return 1;
			if(response)
			{
				new id = ShowTeam[playerid][listitem];

				if(PI[id][pOnCapture] == 0) return SendClientMessage(playerid, COLOR_LIGHTGREY, !"Данный игрок не принимает участие в захвате территории");
				if(PI[id][pOnCapture] == 1 && GangWarStatus >= 2) return SendClientMessage(playerid, COLOR_LIGHTGREY, !"Вы не можете исключить игрока, когда идёт захват за территорию");
                    
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

				SendFractionMessagef(PI[playerid][pMember], COLOR_TOMATO, "[R] %s %s[%d] исключил %s %s[%d] из участников стрелы (%d/7)",\
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

		SendFractionMessagef(PI[playerid][pMember], COLOR_TOMATO, "[R] %s %s[%d] автоматически исключен из участников стрелы (%d/7)",\
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
						SendClientMessagef(i, COLOR_YELLOW, "Попыка {%s}ОПГ %s{FFFF00} захватить территорию {%s}ОПГ %s{FFFF00} завершилась неуспешно", ColorTeam[Command[0]], Fraction_Name[Command[0]], ColorTeam[Command[1]], Fraction_Name[Command[1]]);
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
						SendClientMessagef(i, COLOR_YELLOW, "Попыка {%s}ОПГ %s{FFFF00} захватить территорию {%s}ОПГ %s{FFFF00} завершилась успешно", ColorTeam[Command[0]], Fraction_Name[Command[0]], ColorTeam[Command[1]], Fraction_Name[Command[1]]);
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
	PointCapture = CreatePickup(1314, 23, 1581.4766,-1194.2380,14.9259, -1); // инвайт на капт
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
    if(!IsPlayerOPG(playerid))  return SCM(playerid, COLOR_GREY, !"Вы не состоите в ОПГ");
    if(PI[playerid][pRang] < 7) return SCM(playerid, COLOR_GREY, !"Данную команду можно использовать с 7-го ранга");
	new gz = GetPlayerGangZone(playerid);
	if(gz == -1) return SCM(playerid, COLOR_GREY, !"Вы не находитесь ни в одной из зон");
    if(GetPVarInt(playerid,"Counting_Capture") > gettime()) return SCM(playerid, COLOR_GREY, !"Команду можно использовать раз в 1 минуту");
    SetPVarInt(playerid,"Counting_Capture",gettime() + 59);

    new hour, minute, second;
    gettime(hour, minute, second);
    
    if(Coolldown_Capture == 1) 
	{
		if(!((hour >= 12 && hour <= 19) && minute == 0) && !(hour >= 20 && hour <= 23) && !(hour >= 0 && hour <= 9))
		{
			return SCM(playerid, COLOR_GREY, !"Захват территорий для вашей ОПГ доступен в 12:00, 13:00, 14:00, 15:00, 16:00, 17:00, 18:00, 20:00, 21:00, 22:00, 23:00");
		}
	}

	if(GangWarStatus == 1) return SCM(playerid, COLOR_GREY, !"В данный момент уже идет война за территорию");
    if(gz_info[gz][gzopg] == PI[playerid][pMember]) return SCM(playerid, COLOR_GREY, !"Вы не можете захватить свою территорию");

	switch(gz_info[gz][gzopg]) 
	{
	    case 5: if(m_skinhead > 1) return SCM(playerid, COLOR_GREY, !"В данной ОПГ замороженны захваты территорий");
		case 6: if(m_gopota > 1) return SCM(playerid, COLOR_GREY, !"В данной ОПГ замороженны захваты территорий");
		case 7: if(m_kavkaz > 1) return SCM(playerid, COLOR_GREY, !"В данной ОПГ замороженны захваты территорий");
	}
	switch(PI[playerid][pMember]) 
	{
	    case 5: if(m_skinhead > 1) return SCM(playerid, COLOR_GREY, !"В Вашей ОПГ замороженны захваты территорий");
		case 6: if(m_gopota > 1) return SCM(playerid, COLOR_GREY, !"В Вашей ОПГ замороженны захваты территорий");
		case 7: if(m_kavkaz > 1) return SCM(playerid, COLOR_GREY, !"В Вашей ОПГ замороженны захваты территорий");
	}
    if(gz_info[gz][gzid] == 101) return 1;

	CaptureStart(gz, playerid);

	SCM(playerid, COLOR_YELLOW, !"За инициацию захвата территории Вы получите вознаграждение в PayDay"); 
	foreach(new i:Player) 
	{
	    if(PI[i][pMember] == Command[0] || PI[i][pMember] == Command[1])
		{
			SCMf(i, COLOR_YELLOW, "%s {%s} %s[%d] (%s){FFFF00} забил стрелу за территорию {%s}(%s)", \
				NameRang(playerid), ColorTeam[Command[0]], getName(playerid), playerid, Fraction_Name[PI[playerid][pMember]], ColorTeam[Command[1]], Fraction_Name[Command[1]]);

			SCM(i, COLOR_YELLOW, !"Территория отмечена на карте красным мигающим прямоугольником");
			SCM(i, COLOR_YELLOW, !"Место стрелы отмечено у Вас на мини-карте (/gps 5 5)");

			cef_emit_event(i, "cef:capture:visible", CEFINT(true));
			cef_emit_event(i, "cef:capture:gang:name", CEFINT(1), CEFSTR(Fraction_Name[Command[0]]));
			cef_emit_event(i, "cef:capture:gang:name", CEFINT(2), CEFSTR(Fraction_Name[Command[1]]));
			cef_emit_event(i, "cef:capture:gang:score", CEFINT(1), CEFINT(0));
			cef_emit_event(i, "cef:capture:gang:score", CEFINT(2), CEFINT(0));
			cef_emit_event(i, "cef:capture:start", CEFSTR("подготовка к битве"), CEFINT(60));

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
	if(GangWarStatus <= 0) return SCM(playerid, COLOR_LIGHTGREY, !"В данный момент не проходит захват территории");

    new string[1048] = "", count = 0;

    for (new i = 0; i < MAX_PLAYERS; i++)
    {
        if (!IsPlayerConnected(i)) continue;
		if (GangWarInfo[i][gMember] == -1) continue;

        if (GangWarInfo[i][gMember] == PI[playerid][pMember]) 
        {
            ShowTeam[playerid][count] = GangWarInfo[i][gPlayerID];
            count++;
            f(string, sizeof(string), "%s%d\t%s[%d]\t%s[%d]\t%d мс\n", 
                   string, count, 
                   PI[GangWarInfo[i][gPlayerID]][pName], GangWarInfo[i][gPlayerID], 
                   NameRang(GangWarInfo[i][gPlayerID]), PI[GangWarInfo[i][gPlayerID]][pRang], 
                   GetPlayerPing(GangWarInfo[i][gPlayerID])
			);
        }
    }

    if (count == 0) 
    {
        ShowPlayerDialog(playerid, 0, DIALOG_STYLE_MSGBOX, "{ee3366}Участники стрелы", "{FFFFFF}Список участников пуст.", "Закрыть", "");
    } 
    else 
    {
        new str_1[512*2];
        format(str_1, sizeof(str_1), "№\tИгрок\tРанг\tПинг\n%s", string);
        CEF_ShowPlayerDialog(playerid, 
                         (PI[playerid][pCaptureManager] == 1 || PI[playerid][pRang] >= 9) ? 4903 : 0, 
                         DIALOG_STYLE_TABLIST_HEADERS, "{ee3366}Участники стрелы", 
                         str_1, 
                         (PI[playerid][pCaptureManager] == 1 || PI[playerid][pRang] >= 9) ? "Исключить" : "Закрыть", 
                         "Закрыть");
    }
    return 1;
}
CMD:clead(playerid, params[]) 
{
    if (PI[playerid][pRang] <= 10) 
        return SCM(playerid, COLOR_GREY, !"Данная команда доступна лидерам организаций");

    new targetid;
    if (sscanf(params, "u", targetid)) 
        return SCM(playerid, COLOR_LIGHTGREY, !"Используйте: /clead [ID игрока]");

    if (!IsPlayerConnected(targetid))
        return SCM(playerid, COLOR_GREY, !"Игрок не в сети");

    if(!IsPlayerLogged{targetid})
        return SCM(playerid, COLOR_GREY, !"Игрок не авторизован");

    if (PI[playerid][pMember] != PI[targetid][pMember]) 
        return SCM(playerid, COLOR_GREY, !"Данный игрок не состоит в Вашей организации");

    if (PI[targetid][pCaptureManager] == 0) 
    {
        new Cache: result, query[128];
        mysql_format(mysql, query, sizeof query, 
            "SELECT * FROM accounts WHERE member='%d' AND CaptureManager='1'", PI[playerid][pMember]);
        result = mysql_query(mysql, query, true);

        if (cache_num_rows() >= 3) 
        {
            cache_delete(result);
            return SendClientMessage(playerid, COLOR_GREY, !"Максимум можно иметь 3 смотрящих за захватом территории");
        }
        cache_delete(result);

        SendFractionMessagef(PI[playerid][pMember], 0x69b867FF,\
            "[R] %s %s[%d] назначил смотрящим за стрелой %s %s[%d]",\
            NameRang(playerid), getName(playerid), playerid,\
            NameRang(targetid), getName(targetid), targetid);

        PI[targetid][pCaptureManager] = 1;
    } 
    else 
    {
        SendFractionMessagef(PI[playerid][pMember], COLOR_TOMATO,\
            "[R] %s %s[%d] снял смотрящего за стрелой %s %s[%d]",\
            NameRang(playerid), getName(playerid), playerid,\
            NameRang(targetid), getName(targetid), targetid);

        PI[targetid][pCaptureManager] = 0;
    }

    UpdatePlayerDataInt(targetid, "CaptureManager", PI[targetid][pCaptureManager]);

    return 1;
}
