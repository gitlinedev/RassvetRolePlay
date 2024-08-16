#define ROUND_TIME 		300
#define START_ROUND		7
#define FINISH_ROUND	7

new ShowTeam[MAX_PLAYERS][7];

new CommandKill[2],
	CommandRounds[2],
	Command[2],
	GangWarStatus,
	WarTime,
	CommadCount[2],
	PointCapture,
	CaptZone;

new EnterCaptureZone,
	ExitCaptureZone,
	EnterCaptureDoor_1,
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
    {1540.9475,-1268.9381,14.9656,356.0040}, // ОПГ 1
    {1539.1700,-1268.3915,14.9656,356.5047},
    {1537.4194,-1268.3647,14.9656,356.3199},
    {1537.4728,-1270.2788,14.9656,358.6558},
    {1539.0555,-1270.2362,14.9656,354.8898},
    {1541.3853,-1270.3041,14.9656,352.4788},
    {1541.4683,-1272.0131,14.9656,352.2399},
    {1556.7186,-1228.5701,14.9656,182.5103}, // ОПГ 2
    {1555.2203,-1228.6348,14.9656,177.2398},
    {1553.3282,-1228.5397,14.9656,171.9693},
    {1553.4354,-1226.6405,14.9656,166.6988},
    {1555.3833,-1226.6838,14.9656,177.8266},
    {1557.3243,-1226.5961,14.9656,172.5561},
    {1554.0076,-1224.5449,14.9656,175.6308}
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
	if(GangWarStatus == 2) // начало раунда
	{
		WarTime--;
		if(WarTime <= 0)
		{
			CommandKill[0] = 0;
			CommandKill[1] = 0;

			GangWarStatus = 3; // раунд 1
			WarTime = ROUND_TIME;
			for(new i = 0; i < MAX_PLAYERS; i++)
			{
				if(PI[i][pMember] == Command[0] || PI[i][pMember] == Command[1])
				{
					cef_emit_event(i, "cef:kill:list:clear");
					cef_emit_event(i, "cef:capture:start", CEFSTR("раунд 1"), CEFINT(WarTime));
				}
			}
		}
	}
	if(GangWarStatus == 3) // раунд
	{
		WarTime--;

		if(CommandKill[0] == CommadCount[1] || CommandKill[1] == CommadCount[0])
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
				if(PI[i][pMember] == Command[0] && PI[i][pOnCapture] == 1) FinishRound(i);
				if(PI[i][pMember] == Command[1] && PI[i][pOnCapture] == 1) FinishRound(i);
			}

			GangWarStatus = 4;
			WarTime = FINISH_ROUND;

			for(new i; i < MAX_PLAYERS; i++) 
			{
				if(PI[i][pMember] == Command[0] || PI[i][pMember] == Command[1])
				{
					cef_emit_event(i, "cef:capture:start", CEFSTR("завершение раунда"), CEFINT(WarTime));
					cef_emit_event(i, "cef:capture:gang:score", CEFINT(1), CEFINT(CommandRounds[0]));
					cef_emit_event(i, "cef:capture:gang:score", CEFINT(2), CEFINT(CommandRounds[1]));
				}
			}
		}
	}
	if(GangWarStatus == 4) // конец раунда
	{
		WarTime--;
		if(WarTime <= 0)
		{
			CommandKill[0] = 0;
			CommandKill[1] = 0;

			GangWarStatus = 5; // раунд 2
			WarTime = START_ROUND;

			for(new i = 0; i < MAX_PLAYERS; i++)
			{
				if(PI[i][pMember] == Command[0] || PI[i][pMember] == Command[1])
				{
					cef_emit_event(i, "cef:capture:start", CEFSTR("начало раунда"), CEFINT(WarTime));
				}
			}
		}
	}
	if(GangWarStatus == 5) // начало
	{
		WarTime--;
		if(WarTime <= 0)
		{
			CommandKill[0] = 0;
			CommandKill[1] = 0;

			GangWarStatus = 6; // раунд 2
			WarTime = ROUND_TIME;

			for(new i = 0; i < MAX_PLAYERS; i++)
			{
				if(PI[i][pMember] == Command[0] || PI[i][pMember] == Command[1])
				{
					cef_emit_event(i, "cef:kill:list:clear");
					cef_emit_event(i, "cef:capture:start", CEFSTR("раунд 2"), CEFINT(WarTime));
				}
			}
		}
	}
	if(GangWarStatus == 6) // раунд 2
	{
		WarTime--;

		if(CommandKill[0] == CommadCount[1] || CommandKill[1] == CommadCount[0])
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
				if(PI[i][pMember] == Command[0] && PI[i][pOnCapture] == 1) FinishRound(i);
				if(PI[i][pMember] == Command[1] && PI[i][pOnCapture] == 1) FinishRound(i);
			}

			GangWarStatus = 7;
			WarTime = FINISH_ROUND;


			for(new i; i < MAX_PLAYERS; i++) 
			{
				if(PI[i][pMember] == Command[0] || PI[i][pMember] == Command[1])
				{
					cef_emit_event(i, "cef:capture:start", CEFSTR("завершение раунда"), CEFINT(WarTime));
					cef_emit_event(i, "cef:capture:gang:score", CEFINT(1), CEFINT(CommandRounds[0]));
					cef_emit_event(i, "cef:capture:gang:score", CEFINT(2), CEFINT(CommandRounds[1]));
				}
			}
		}
	}
	if(GangWarStatus == 7) // завершение раунд 2
	{
		WarTime--;
		if(WarTime <= 0)
		{
			CommandKill[0] = 0;
			CommandKill[1] = 0;

			GangWarStatus = 8;
			WarTime = START_ROUND;

			for(new i = 0; i < MAX_PLAYERS; i++)
			{
				if(PI[i][pMember] == Command[0] || PI[i][pMember] == Command[1])
				{
					cef_emit_event(i, "cef:capture:start", CEFSTR("начало раунда"), CEFINT(WarTime));
				}
			}
		}
	}
	if(GangWarStatus == 8) // начало
	{
		WarTime--;
		if(WarTime <= 0)
		{
			CommandKill[0] = 0;
			CommandKill[1] = 0;

			GangWarStatus = 9; // раунд 3
			WarTime = ROUND_TIME;

			for(new i = 0; i < MAX_PLAYERS; i++)
			{
				if(PI[i][pMember] == Command[0] || PI[i][pMember] == Command[1])
				{
					cef_emit_event(i, "cef:kill:list:clear");
					cef_emit_event(i, "cef:capture:start", CEFSTR("раунд 3"), CEFINT(WarTime));
				}
			}
		}
	}
	if(GangWarStatus == 9) // раунд 3
	{
		WarTime--;

		if(CommandKill[0] == CommadCount[1] || CommandKill[1] == CommadCount[0])
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
				if(PI[i][pMember] == Command[0] && PI[i][pOnCapture] == 1) FinishRound(i);
				if(PI[i][pMember] == Command[1] && PI[i][pOnCapture] == 1) FinishRound(i);
			}

			GangWarStatus = 10;
			WarTime = FINISH_ROUND;


			for(new i; i < MAX_PLAYERS; i++) 
			{
				if(PI[i][pMember] == Command[0] || PI[i][pMember] == Command[1])
				{
					cef_emit_event(i, "cef:capture:start", CEFSTR("завершение раунда"), CEFINT(WarTime));
					cef_emit_event(i, "cef:capture:gang:score", CEFINT(1), CEFINT(CommandRounds[0]));
					cef_emit_event(i, "cef:capture:gang:score", CEFINT(2), CEFINT(CommandRounds[1]));
				}
			}
		}	
	}
	if(GangWarStatus == 10) // завершение
	{
		WarTime--;
		if(WarTime <= 0)
		{
			CommandKill[0] = 0;
			CommandKill[1] = 0;

			GangWarStatus = 11; // раунд 3
			WarTime = START_ROUND;

			for(new i = 0; i < MAX_PLAYERS; i++)
			{
				if(PI[i][pMember] == Command[0] || PI[i][pMember] == Command[1])
				{
					cef_emit_event(i, "cef:capture:start", CEFSTR("начало раунда"), CEFINT(WarTime));
				}
			}
		}
	}
	if(GangWarStatus == 11) // начало
	{
		WarTime--;
		if(WarTime <= 0)
		{
			CommandKill[0] = 0;
			CommandKill[1] = 0;

			GangWarStatus = 12; // раунд 4
			WarTime = ROUND_TIME;

			for(new i = 0; i < MAX_PLAYERS; i++)
			{
				if(PI[i][pMember] == Command[0] || PI[i][pMember] == Command[1])
				{
					cef_emit_event(i, "cef:kill:list:clear");
					cef_emit_event(i, "cef:capture:start", CEFSTR("раунд 4"), CEFINT(WarTime));
				}
			}
		}
	}
	if(GangWarStatus == 12) // раунд 4
	{
		WarTime--;

		if(CommandKill[0] == CommadCount[1] || CommandKill[1] == CommadCount[0])
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
				if(PI[i][pMember] == Command[0] && PI[i][pOnCapture] == 1) FinishRound(i);
				if(PI[i][pMember] == Command[1] && PI[i][pOnCapture] == 1) FinishRound(i);
			}

			GangWarStatus = 13;
			WarTime = FINISH_ROUND;

			for(new i; i < MAX_PLAYERS; i++) 
			{
				if(PI[i][pMember] == Command[0] || PI[i][pMember] == Command[1])
				{
					cef_emit_event(i, "cef:capture:start", CEFSTR("завершение раунда"), CEFINT(WarTime));
					cef_emit_event(i, "cef:capture:gang:score", CEFINT(1), CEFINT(CommandRounds[0]));
					cef_emit_event(i, "cef:capture:gang:score", CEFINT(2), CEFINT(CommandRounds[1]));
				}
			}
		}		
	}
	if(GangWarStatus == 13) // завершение
	{
		WarTime--;
		if(WarTime <= 0)
		{
			CommandKill[0] = 0;
			CommandKill[1] = 0;

			GangWarStatus = 14; // раунд 4
			WarTime = START_ROUND;

			for(new i = 0; i < MAX_PLAYERS; i++)
			{
				if(PI[i][pMember] == Command[0] || PI[i][pMember] == Command[1])
				{
					cef_emit_event(i, "cef:capture:start", CEFSTR("начало раунда"), CEFINT(WarTime));
				}
			}
		}
	}
	if(GangWarStatus == 14) // начало
	{
		WarTime--;
		if(WarTime <= 0)
		{
			CommandKill[0] = 0;
			CommandKill[1] = 0;

			GangWarStatus = 15; // раунд 5
			WarTime = ROUND_TIME;

			for(new i = 0; i < MAX_PLAYERS; i++)
			{
				if(PI[i][pMember] == Command[0] || PI[i][pMember] == Command[1])
				{
					cef_emit_event(i, "cef:kill:list:clear");
					cef_emit_event(i, "cef:capture:start", CEFSTR("раунд 5"), CEFINT(WarTime));
				}
			}
		}
	}
	if(GangWarStatus == 15) // ласт раунд
	{
		WarTime--;

		if(CommandKill[0] == CommadCount[1] || CommandKill[1] == CommadCount[0])
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

			GangWarStatus = 16;
			WarTime = FINISH_ROUND;

			for(new i; i < MAX_PLAYERS; i++) 
			{
				cef_emit_event(i, "cef:capture:start", CEFSTR("завершение раунда"), CEFINT(WarTime));
				if(PI[i][pMember] == Command[0] || PI[i][pMember] == Command[1])
				{
					cef_emit_event(i, "cef:capture:gang:score", CEFINT(1), CEFINT(CommandRounds[0]));
					cef_emit_event(i, "cef:capture:gang:score", CEFINT(2), CEFINT(CommandRounds[1]));
				}
			}	
		}		
	}
	if(GangWarStatus == 16) // завершение last
	{
		WarTime--;
		if(WarTime <= 0)
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
							SetPlayerPos(i, 1540.8573,-1219.3041,15.0275);
							SetPlayerFacingAngle(i, 359.3068);

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
							SetPlayerPos(i, 1540.8573,-1219.3041,15.0275);
							SetPlayerFacingAngle(i, 359.3068);

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
stock FinishRound(playerid)
{
	if(PI[playerid][pDeathOnCapture] == 1)
	{
		SetTimerEx("DeathFinishRound", 4900, false, "d", playerid);
	}
	else 
	{
		TogglePlayerControllable(playerid, false);
		SetTimerEx("NoDeathFinishRound", 4900, false, "d", playerid);
	}
}
callback: DeathFinishRound(playerid)
{
	for(new i = 0; i < 13; i++) 
	{
	    if(PI[playerid][data_GUN][i] != 0 && PI[playerid][data_AMMO][i] != 0) GivePlayerWeapon(playerid, PI[playerid][data_GUN][i], PI[playerid][data_AMMO][i]);
	}
	SetPlayerHealthAC(playerid, 176);
	TogglePlayerControllable(playerid, false);

	new id = GetPlayerID(playerid);

	SetPlayerPos(playerid, SpawnPositions[GangWarInfo[id][gSpawnID]][0], SpawnPositions[GangWarInfo[id][gSpawnID]][1], SpawnPositions[GangWarInfo[id][gSpawnID]][2]);
	SetPlayerFacingAngle(playerid, SpawnPositions[GangWarInfo[id][gSpawnID]][3]);

	SetTimerEx("UnWairToStart", 5000, false, "d", playerid);
	return 1;
}
callback: NoDeathFinishRound(playerid)
{
	SetPlayerHealthAC(playerid, 176);
	TogglePlayerControllable(playerid, false);

	new id = GetPlayerID(playerid);

	SetPlayerPos(playerid, SpawnPositions[GangWarInfo[id][gSpawnID]][0], SpawnPositions[GangWarInfo[id][gSpawnID]][1], SpawnPositions[GangWarInfo[id][gSpawnID]][2]);
	SetPlayerFacingAngle(playerid, SpawnPositions[GangWarInfo[id][gSpawnID]][3]);

	SetTimerEx("UnWairToStart", 5000, false, "d", playerid);
	return 1;
}
stock WaitToStart(playerid) // начало раундов
{
	TogglePlayerControllable(playerid, false);
	new id = GetPlayerID(playerid);
	SetPlayerPos(playerid, SpawnPositions[GangWarInfo[id][gSpawnID]][0], SpawnPositions[GangWarInfo[id][gSpawnID]][1], SpawnPositions[GangWarInfo[id][gSpawnID]][2]);
	SetPlayerFacingAngle(playerid, SpawnPositions[GangWarInfo[id][gSpawnID]][3]);
	SetTimerEx("UnWairToStart", 5000, false, "d", playerid);
}
callback: UnWairToStart(playerid)
{
	cef_emit_event(playerid, "cef:capture:sound", CEFINT(1));

	PI[playerid][pDeathOnCapture] = 0;

	TogglePlayerControllable(playerid, true);

	cef_emit_event(playerid, "cef:capture:sound", CEFINT(2));
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
                if(!AddPlayerToCapture(playerid)) return SendClientMessage(playerid, COLOR_LIGHTGREY, !"Свободных мест уже нет (7/7)");
                else 
                {
                    static name[24];
                    SetString(name, NameRang(playerid));
                    name = NameRang(playerid);
                    
					new count = GetCountonGanwWar(PI[playerid][pMember]);

                    SendFractionMessagef(PI[playerid][pMember], 0x69b867FF, "[R] %s %s[%d] присоединился к участникам стрелы (%d/7)",\
                        name, getName(playerid), playerid, count);
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
						GangWarInfo[i][gPlayerID] = -1;
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
		for (new i = 0; i < sizeof(GangWarInfo); i++)
		{
			if(GangWarInfo[i][gPlayerID] == playerid)
			{
				GangWarInfo[i][gPlayerID] = -1;
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
		if(CommadCount[0] <= 0 && CommadCount[1] <= 0)
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

						cef_emit_event(playerid, "cef:capture:visible", CEFINT(false));

						TogglePlayerControllable(i, true);
						SendClientMessagef(i, COLOR_YELLOW, "Попыка {%s}ОПГ %s{FFFF00} захватить территорию {%s}ОПГ %s{FFFF00} завершилась неуспешно", ColorTeam[Command[0]], Fraction_Name[Command[0]], ColorTeam[Command[1]], Fraction_Name[Command[1]]);
						ClearCapture();
					}
					if(PI[i][pOnCapture] == 1)
					{
						if(PI[i][pMember] == Command[0] || PI[i][pMember] == Command[1])
						{
							SetPlayerPos(i, 1540.8573,-1219.3041,15.0275);
							SetPlayerFacingAngle(i, 359.3068);

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

						cef_emit_event(playerid, "cef:capture:visible", CEFINT(false));

						TogglePlayerControllable(i, true);
						SendClientMessagef(i, COLOR_YELLOW, "Попыка {%s}ОПГ %s{FFFF00} захватить территорию {%s}ОПГ %s{FFFF00} завершилась успешно", ColorTeam[Command[0]], Fraction_Name[Command[0]], ColorTeam[Command[1]], Fraction_Name[Command[1]]);
						ClearCapture();
					}
					if(PI[i][pOnCapture] == 1)
					{
						if(PI[i][pMember] == Command[0] || PI[i][pMember] == Command[1])
						{
							SetPlayerPos(i, 1540.8573,-1219.3041,15.0275);
							SetPlayerFacingAngle(i, 359.3068);

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
	if(PI[playerid][pOnCapture] == 1 && GangWarStatus == 1)
	{
		for (new i = 0; i < sizeof(GangWarInfo); i++)
		{
			if(GangWarInfo[i][gPlayerID] == playerid)
			{
				GangWarInfo[i][gPlayerID] = -1;
				GangWarInfo[i][gMember] = -1;
				GangWarInfo[i][gSpawnID] = -1;
			}
		}
		PI[playerid][pOnCapture] = 0;
		new count = GetCountonGanwWar(PI[playerid][pMember]);

		SendFractionMessagef(PI[playerid][pMember], 0x69b867FF, "[R] %s %s[%d] автоматически исключен из участников стрелы (%d/7)",\
			NameRang(playerid), getName(playerid), playerid, count);

		if(PI[playerid][pMember] == Command[0]) CommadCount[0]--;
		else if(PI[playerid][pMember] == Command[1]) CommadCount[1]--;

		CheckCount(playerid);
	}
}
stock AddPlayerToCapture(playerid)
{
    new spawnID;
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
                    if (GangWarInfo[i][gPlayerID] == -1)
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
                    if (GangWarInfo[i][gPlayerID] == -1)
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
    for (new i = 0; i < sizeof(GangWarInfo); i++)
    {
        if(GangWarInfo[i][gPlayerID] == -1)
        {
            GangWarInfo[i][gMember] = PI[playerid][pMember];
            GangWarInfo[i][gPlayerID] = playerid;
            GangWarInfo[i][gSpawnID] = spawnID;
			PI[playerid][pOnCapture] = 1;
            return 1;   
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
		GangWarInfo[i][gMember] = 0;
		GangWarInfo[i][gPlayerID] = -1;
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
	if(pickupid == EnterCaptureZone)
	{
		SetPlayerPos(playerid, 1553.9015,-1225.0206,14.9656);
		SetPlayerFacingAngle(playerid, 179.2438);
	}
	if(pickupid == ExitCaptureZone)
	{
		SetPlayerPos(playerid, 1554.2072,-1219.5502,15.0275);
		SetPlayerFacingAngle(playerid, 356.7402);
	}
	if(pickupid == EnterCaptureDoor_1)
	{
		SetPlayerPos(playerid, 1532.5198,-1238.2073,19.4656);
		SetPlayerFacingAngle(playerid, 177.8960);
	}
	if(pickupid == ExitCaptureDoor_1)
	{
		SetPlayerPos(playerid, 1530.0110,-1231.6013,19.0355);
		SetPlayerFacingAngle(playerid, 356.3745);
	}
	if(pickupid == EnterCaptureDoor_2)
	{
		SetPlayerPos(playerid, 1532.2991,-1258.0167,19.4656);
		SetPlayerFacingAngle(playerid, 356.7891);
	}
	if(pickupid == ExitCaptureDoor_2)
	{
		SetPlayerPos(playerid, 1529.9167,-1259.8959,19.0281);
		SetPlayerFacingAngle(playerid, 357.1078);
	}
	//========
	if(pickupid == EnterCaptureDoor_3)
	{
		SetPlayerPos(playerid, 1560.7437,-1237.8176,19.4656);
		SetPlayerFacingAngle(playerid, 174.3279);
	}
	if(pickupid == ExitCaptureDoor_3)
	{
		SetPlayerPos(playerid, 1563.2208,-1237.3262,19.0281);
		SetPlayerFacingAngle(playerid, 179.9927);
	}
	//========
	if(pickupid == EnterCaptureDoor_4)
	{
		SetPlayerPos(playerid, 1560.4148,-1260.1898,19.4656);
		SetPlayerFacingAngle(playerid, 0.0959);
	}
	if(pickupid == ExitCaptureDoor_4)
	{
		SetPlayerPos(playerid, 1563.2253,-1260.3306,19.0355);
		SetPlayerFacingAngle(playerid, 354.9521);
	}
	return 1;
}
stock capture_OnGameModeInit()
{
	PointCapture = CreatePickup(1314, 23, 1510.0564,-1204.5079,14.9259, -1); // инвайт на капт
	//======================================
	EnterCaptureZone = CreatePickup(1318, 23, 1553.8845,-1221.9240,15.0275, -1);
	ExitCaptureZone = CreatePickup(1318, 23, 1553.9001,-1223.2344,14.9656, -1);
	//======================================
	EnterCaptureDoor_1 = CreatePickup(1318, 23, 1530.8042,-1234.5511,19.4109, -1);
	ExitCaptureDoor_1 = CreatePickup(1318, 23, 1532.0082,-1234.4371,19.4656, -1);

	EnterCaptureDoor_2 = CreatePickup(1318, 23, 1530.8037,-1262.2297,19.4109, -1);
	ExitCaptureDoor_2 = CreatePickup(1318, 23, 1532.0082,-1262.0437,19.4656, -1);

	EnterCaptureDoor_3 = CreatePickup(1318, 23, 1562.3562,-1234.5476,19.4109, -1);
	ExitCaptureDoor_3 = CreatePickup(1318, 23, 1561.3597,-1234.7960,19.4656, -1);

	EnterCaptureDoor_4 = CreatePickup(1318, 23, 1562.3563,-1262.2466,19.4109, -1);
	ExitCaptureDoor_4 = CreatePickup(1318, 23, 1561.3624,-1262.2516,19.4656, -1);
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

    new warname[15];
	if(gz_info[gz][gzopg] == 5) warname = "'Скинхеды'";
	if(gz_info[gz][gzopg] == 6) warname = "'Гопота'";
	if(gz_info[gz][gzopg] == 7) warname = "'Кавказцы'";

	PI[playerid][pPayDayMoney] += 2000;
	PI[playerid][pProgressCapture]+= 1;

	GangWarStatus = 1;
	//
	WarTime = 270;
	WarZone = gz;
	//
	CommandKill[0]= 0;
	CommandKill[1]= 0;
	Command[0] = PI[playerid][pMember];
	Command[1] = gz_info[gz][gzopg];

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
			cef_emit_event(i, "cef:capture:start", CEFSTR("подготовка к битве"), CEFINT(300));

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
    new string[1048] = "", count = 0;

    for (new i = 0; i < MAX_PLAYERS; i++)
    {
        if (!IsPlayerConnected(i)) continue;
        if (GangWarInfo[i][gMember] == PI[playerid][pMember]) 
        {
            ShowTeam[playerid][count] = GangWarInfo[i][gPlayerID];
            count++;
            format(string, sizeof(string), "%s%d\t%s[%d]\t%s[%d]\t%d мс\n", 
                   string, count, 
                   PI[GangWarInfo[i][gPlayerID]][pName], GangWarInfo[i][gPlayerID], 
                   NameRang(GangWarInfo[i][gPlayerID]), PI[GangWarInfo[i][gPlayerID]][pRang], 
                   GetPlayerPing(GangWarInfo[i][gPlayerID]));
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
        ShowPlayerDialog(playerid, 
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
    if (PI[playerid][pRang] < 9) 
        return SCM(playerid, COLOR_GREY, !"Данная команда доступна лидерам организаций и их заместителям");

    new targetid;
    if (sscanf(params, "u", targetid)) 
        return SCM(playerid, COLOR_LIGHTGREY, !"Используйте: /clead [ID игрока]");

    if (!IsPlayerConnected(targetid))
        return SCM(playerid, COLOR_GREY, !"Игрок не в сети");

    if (!IsPlayerLogged[targetid])
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
