new TimetTheftCartridges[MAX_PLAYERS];

callback: TheftCartridges(playerid)
{
	if(!PlayerToPoint(4.0, playerid, -2569.5515, 450.8403, 10.9216)) return KillTimer(TimetTheftCartridges[playerid]);
    if(army_wh[2] == 0) return SendClientMessage(playerid, COLOR_GREY, !"����� ����������� '�������� �����' ������ ������� ��������"), KillTimer(TimetTheftCartridges[playerid]);
	switch(PI[playerid][pMember]) 
	{
		case 5,6,7: 
		{
			if(army_wh[1] > 0) 
			{
				if(PI[playerid][pVIP] == 0)
				{
				    if(PI[playerid][pAmmo] < 400)
					{
						new patr,str[47];
						patr = RandomEX(2,5);
						PI[playerid][pAmmo] += patr;
						if(PI[playerid][pAmmo] > 400) PI[playerid][pAmmo] = 400;
						if(PI[playerid][pMetall] > 40) PI[playerid][pMetall] = 40;
						army_wh[1] -= patr;
						SaveWarehouse();
						UpdatePlayerDataInt(playerid, "met", PI[playerid][pMetall]);
						UpdatePlayerDataIntNoLog(playerid, "patr", PI[playerid][pAmmo]);

						format(str, sizeof(str), "��������� ��������: %d / 400 ��", PI[playerid][pAmmo]);
						SendPlayerHudNotify(playerid, 3, "artichoke", str, 5);

						HidePlayerSpeedometer(playerid);
				    }
					else SCM(playerid, COLOR_GREY, !"� ��� ������ ������� ��������, ����� ������ ���");
				}
				else
				{
				    if(PI[playerid][pAmmo] < 800)
					{
						new patr,str[47];
						patr = RandomEX(2,5);
						PI[playerid][pAmmo] += patr;
						if(PI[playerid][pAmmo] > 800) PI[playerid][pAmmo] = 800;
						if(PI[playerid][pMetall] > 80) PI[playerid][pMetall] = 80;
						army_wh[1] -= patr;
						SaveWarehouse();
						UpdatePlayerDataInt(playerid, "met", PI[playerid][pMetall]);
						UpdatePlayerDataIntNoLog(playerid, "patr", PI[playerid][pAmmo]);

						format(str, sizeof(str), "��������� ��������: %d / 800 ��", PI[playerid][pAmmo]);
						SendPlayerHudNotify(playerid, 3, "artichoke", str, 5);

						HidePlayerSpeedometer(playerid);
					}
				    else SCM(playerid, COLOR_GREY, !"� ��� ������ ������� ��������, ����� ������ ���");
				}
			}
			global_str[0] = EOS, f(global_str, 100, "{f18c2b}��������� �����\n\n{FFFFFF}������: %d ��.\n{fccf39}�������: %d ��.",army_wh[0],army_wh[1]);
			UpdateDynamic3DTextLabelText(army_sklad_text, -1, global_str);
		}
	}
	return 1;
}
callback: CloseArmyStorageDoor(playerid) 
{
	MoveObject(VchSkladGate, 1568.80, 1809.53, 16.25, 1.9, 0.00, 0.00, 90.00);
	return KillTimer(ArmyStorageDoorTimer);
}