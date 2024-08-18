static const stock VehicleNames[][] = {
	"BMW X5", "Lincoln Continental ", "Mercedes-Benz �63","Mercedes-Benz Actros", "��� 2101", "Mitsubishi Lancer X", "Dumper", "�����", "��� 130","Mercedes GL63","Audi R8","Lada Kalina",
	"Lexus GSF","Nissan Titan 2017","BMW M5","Porsche 911","Ambulance","������ ������","Volkswagen Multivan","��� 2107","Nissan GTR","Washington","Infiniti JX 35 2013","Mr Whoopee","BF Injection",
	"Hunter","Audi A6","������","���������","���-�22","Predator","����-677�","Rhino","��� 131","Hotknife","Trailer","Toyota MarkII","Ikarus 260","���-2402",
	"��-412","Rumpo","RC Bandit","Romero","Packer","Monster","���-45","Squalo","Seasparrow","Pizzaboy","Tram","Trailer","Turismo","Speeder",
	"Reefer","Tropic","Flatbed","���-3309","Caddy","Audi A6","Berkley's RC Van","Skimmer","PCJ-600","Faggio","Freeway","RC Baron","RC Raider",
	"BMW 535i","Mercedes GLE","Sanchez","Sparrow","Patriot","Audi A7","Coastguard","Dinghy","���-21�","Toyota Land Cruiser","Rustler","ZR3 50","��-27151","���-2114",
	"Toyota Supra","���������","Burrito","���-3205","Marquis","��� 2402","Dozer","Maverick","News Chopper","Chevrolet Niva","FBI Rancher","Virgo","��� 2109",
	"Jetmax","Hotring","Sandking","���-1102","Police Maverick","Boxville","���-53","���-69","RC Goblin","Hotring A","Mercedes-Benz GLE 63 AMG",
	"Bloodring Banger","Mercedes-Benz GLE 63 AMG","Super GT","���-2401"," ���-452","�����","������ �����","Beagle","Cropdust","Stunt","�����-54115","���-608�",
	"���-21099","���-2203"," ����-672","Shamal","Hydra","�� ������� 5","NRG-500","����","Cement Truck","���������","Fortune","Cadrona","FBI Truck",
	"Willard","Forklift","Tractor","Combine","Feltzer","Remington","Slamvan","Blade","Freight","Streak","Vortex","�5 F90","Lamborghini Aventador","��� 2424",
	"�������-434","Firetruck","�������-400","�������-2125","�������-2140","Cargobob","���-968�","Sunrise","��� 31105","Utility","Nevada","���-3303","���-968�","Monster A",
	"Monster B","Lamborghini Huracan Devo","Acura NSX GT3","Orange Porshe","�� �������-427","Elegy","Raindance","RC Tiger","��� 2108","��� 2104","Savanna","Bandito","Freight","Trailer",
	"Kart","Mower","Duneride","Sweeper","���-�20","�������-408","AT-400","���-157","Mercedes-Benz G63 AMG 2019","BMW X5M","BF-400","Newsvan","Tug","Trailer A","Emperor",
	"������ 3�","Euros","����-677","Club","Trailer B","Trailer C","Andromada","Dodo","RC Cam","Launch","���-2401","��� 21099",
	"��� 2114","��� 469","��-2717","S.W.A.T.","Rolls Royce Phantom 2018","Phoenix","Glendale","Sadler","L Trailer A","L Trailer B",
	"Stair Trailer","���-699�","Farm Plow","U Trailer"
};

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
	KillTimer(OfferTimer[playerid]);
	if(IsPlayerLogged{playerid}) cef_emit_event(playerid, "cef:remove:notification:offer");
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
	new value = PI[from_player][pRequestValue_1];
	new value_2 =  PI[from_player][pRequestValue_2];

	KillTimer(OfferTimer[playerid]);
	KillTimer(OfferTimer[from_player]);

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
				ShowPlayerDialogf(playerid, 7242, DIALOG_STYLE_MSGBOX, "{ee3366}���������� � �����������", "��������", "�������", "\
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
			case 3:
			{
			 	new PlayerHouse[5];
				if(PI[from_player][pHouse] != -1) format(PlayerHouse, sizeof(PlayerHouse), PI[from_player][pHouse]);
				else format(PlayerHouse, sizeof(PlayerHouse), "---");

				global_str[0] = EOS, f(global_str, 300, "{000000}���\t\t\t\t{ee3366}%s\n\
														{000000}��� � �������\t\t\t%d\n\
														{000000}������������������\t\t%d\n\
														{000000}������� �������\t\t%d\n\
														{000000}����� ����\t\t\t%d",
														PI[from_player][pName],
														PI[from_player][pLevel],
														PI[from_player][pRespect],
														PI[from_player][pWanted],
														PlayerHouse);

				CEF_ShowPlayerDialog(playerid, 0, DIALOG_STYLE_LIST, "{ee3366}�������", global_str, "�������", "");

				SetPlayerChatBubble(playerid, "������������� ���������", 0xFF99CCFF, 20.0, 4000);
			}
			case 4:
			{
			 	ShowPlayerDialogf(playerid, 0, DIALOG_STYLE_LIST, "{ee3366}��������", "�������", "", "\
					��������� ���. ��������: \t�������� �%d\n\
					��������� ��\t\t\t{3377cc}%s\n\
					{FFFFFF}������������ �����: \t\t\t%s\n\
					{FFFFFF}�������� �� ������: \t\t\t%s", 
						PI[from_player][pLicNumber], 
						getName(from_player), 
						PI[from_player][pDriveLicense] ? "{FF6347}-" : "{24ff78}+", 
						PI[from_player][pGunLicense] ? "{FF6347}-" : "{24ff78}+");

				SetPlayerChatBubble(playerid, "������������� ��������", 0xFF99CCFF, 20.0, 4000);
			}
			case 5:
			{
				ShowPlayerDialogf(playerid, 0, DIALOG_STYLE_LIST, !"{ee3366}��������", "�������", "", "\
					{FFFFFF}��� ���. ��������: \t\t�������� �%d\n\
					{FFFFFF}��������� ��\t\t\t{3377cc}%s\n\
					{FFFFFF}�������\t\t\t��������\n\
					{FFFFFF}���������� ���������\t����������\n\
					{FFFFFF}�����������\t\t\t���", 
					PI[from_player][data_MEDNUM], 
					getName(from_player));
			}
			case 6:
			{
				ShowPlayerDialogf(playerid, 0, DIALOG_STYLE_MSGBOX, !"{ee3366}������� �����", !"�������", !"", \
					"{FFFFFF}��������� ����� �. ��������\n\
					��������� ��: {3377cc}%s\n\
					{FFFFFF}������� �����: %s", 
					getName(from_player), 
					(PI[from_player][pMilitaryID]) ? ("����") : ("����"));
			}
			case 7:
			{
				ShowPlayerDialogf(playerid, 0, DIALOG_STYLE_LIST, !"{ee3366}������ �������� �������", !"�������", !"",\
					"1. ��:\t\t\t%d %%\n\
					2. ������:\t\t%d %%\n\
					3. ��-15:\t\t%d %%\n\
					4. ��������:\t\t%d %%\n\
					5. MP5:\t\t\t%d %%\n\
					6. AK-47:\t\t%d %%",
						PI[from_player][pSkillPistol],
						PI[from_player][pSkillSDPistol],
						PI[from_player][pSkillDeagle],
						PI[from_player][pSkillShotgun],
						PI[from_player][pSkillMP5],
						PI[from_player][pSkillAK47]);
				SetPlayerChatBubble(playerid, "������������� ������ �������� �������", 0xFF99CCFF, 20.0, 4000);
			}
			case 8:
			{

			 	PI[from_player][pMask]--;
				PI[playerid][pMask]++;

				global_str[0] = EOS, f(global_str, 70, "%s ������� ����� %s", PI[from_player][pName], getName(playerid));
			    ProxDetector(25.0, playerid, global_str, 0xFF99CCFF, 0xFF99CCFF, 0xFF99CCFF, 0xFF99CCFF, 0xFF99CCFF);
			    SetPlayerChatBubble(from_player, "������� �����", 0xFF99CCFF, 20.0, 4000);
			}
			case 9:
			{
				if(CarInfo[PI[from_player][pLoadVehicleID]][cPremium] == 1)
				{
					if(GetPlayerMoneyID(playerid) < value+value_2)
					{
						SCM(playerid, COLOR_LIGHTGREY, !"� ��� ������������ ����� ��� ������� ������� ���������");
						SCMf(from_player, COLOR_LIGHTGREY, "� ������ %s ������������ �����", getName(playerid));
					}
					else 
					{
						ShowPlayerDialogf(playerid, 9221, DIALOG_STYLE_MSGBOX, !"{ee3366}�������������", !"������", !"�������",\
								"{FFFFFF}�� ������� ��� ������ ������ ����������: {3366cc}'%s'{FFFFFF}, �� {3366cc}%d ���\n {FFFF99}(������� ����� �� ������� ���������: %d ���)",
								VehicleNames[CarInfo[PI[from_player][pLoadVehicleID]][cModel]-400], value+value_2, value_2);
					}
				}
				else 
				{
					if(GetPlayerMoneyID(playerid) < value)
					{
						SCM(playerid, COLOR_LIGHTGREY, !"� ��� ������������ ����� ��� ������� ������� ���������");
						SCMf(from_player, COLOR_LIGHTGREY, "� ������ %s ������������ �����", getName(playerid));
					}
					else 
					{
						ShowPlayerDialogf(playerid, 9221, DIALOG_STYLE_MSGBOX, !"{ee3366}�������������", !"������", !"�������",\
							"{FFFFFF}�� ������� ��� ������ ������ ����������: {3366cc}'%s'{FFFFFF}, �� {3366cc}%d ���", 
							VehicleNames[CarInfo[PI[from_player][pLoadVehicleID]][cModel]-400], value);
					}
				}
				return 1;
			}
			case 10:
			{
				SCMf(from_player, 0xFF99CCFF, "��������� ���� %s ����� ���� �������� �������.", PI[from_player][pName]);
				GivePlayerMoneyLog(playerid, -750);
				GivePlayerMoneyLog(from_player, 400);
				if(PI[playerid][pVIP] == 0) SetPlayerHealthAC(playerid, 100);
				else SetPlayerHealthAC(playerid, 176);
			}
			case 11:
			{
				new money = value;
		        if(GetPlayerMoneyID(playerid) < money) 
				{
				    SCM(playerid, COLOR_GREY, !"� ��� ������������ ����� �� �����");
					SCM(from_player, COLOR_GREY, !"� ������ ������������ ����� �� �����");
					ClearRequest(PI[playerid][pRequestFrom]);
					ClearRequest(playerid);
					return 1;
				}
    			if(GetPlayerMoneyID(from_player) < money) 
				{
					SCM(from_player, COLOR_GREY, !"� ��� ������������ ����� �� �����");
					SCM(playerid, COLOR_GREY, !"� ������ ������������ ����� �� �����");
					ClearRequest(PI[playerid][pRequestFrom]);
					ClearRequest(playerid);
					return 1;
				}

		        new p1 = RandomEX(1,6), p2 = RandomEX(1,6);
				
				if(p1 > p2) 
				{
				    GivePlayerMoneyLog(playerid, -money);
				    GivePlayerMoneyLog(from_player, money);

					SendPlayerCenterNotify(playerid, 2, "�� ���������", 5);
					SendPlayerCenterNotify(from_player, 5, "�� ��������", 5);
				}
				else if(p1 < p2) 
				{
				    GivePlayerMoneyLog(from_player, -money);
				    GivePlayerMoneyLog(playerid, money);

					SendPlayerCenterNotify(from_player, 2, "�� ���������", 5);
					SendPlayerCenterNotify(playerid, 5, "�� ��������", 5);
				}
		        global_str[0] = EOS, f(global_str, 110,"%s � %s ������� ��������� ��������� ������ {FF9966}(%d|%d)", PI[from_player][pName], getName(playerid), p1, p2);
		        ProxDetector(25.0, from_player, global_str, 0xFF99CCFF, 0xFF99CCFF, 0xFF99CCFF, 0xFF99CCFF, 0xFF99CCFF);
			}
			case 12:
			{
				if(GetPlayerMoneyID(playerid) < value) return SCM(playerid, COLOR_GREY, !"� ��� ������������ ����� �� �����");
				GivePlayerMoneyLog(playerid, -value);
				GivePlayerMoneyLog(from_player, value);
				switch(PI[playerid][pJail]) 
				{
    				case 1: 
					{
				        SetPlayerPosAC(playerid, 22.9993,281.1662,12.0260);
					    SetPlayerVirtualWorld(playerid,0);
					    SetPlayerInterior(playerid,0);
						SetPlayerFacingAngle(playerid, 66);
						SetCameraBehindPlayer(playerid);
					    SCM(playerid, 0x9F81F7FF, !"������� ���� ���������� ��� �� ������");
				    }
				}
			}
			case 13:
			{
				if(GetPlayerMoneyID(playerid) < 5000) return SCM(playerid, COLOR_GREY, !"� ��� ������������ ����� �� �����");
				GivePlayerMoneyLog(playerid, -5000);
				GivePlayerMoneyLog(from_player, 5000);
				PI[playerid][pDriveLicense] = 1;
				if(PI[playerid][pLicNumber] == 0) PI[playerid][pLicNumber] = RandomEX(1111111, 6666666);
				SCM(playerid, 0x9F81F7FF, !"�� ������ ������������ ����� �� 5000 ������");
			}
			case 14:
			{
				if(GetPlayerMoneyID(playerid) < 30000) return SCM(playerid, COLOR_GREY, !"� ��� ������������ ����� �� �����");
				GivePlayerMoneyLog(playerid, -30000);
				GivePlayerMoneyLog(from_player, 25000);
				PI[playerid][pGunLicense] = 1;
				if(PI[playerid][pLicNumber] == 0) PI[playerid][pLicNumber] = RandomEX(1111111, 6666666);
				SCM(playerid, 0x9F81F7FF, !"�� ������ �������� �� ������ �� 30000 ������");
			}
			case 15:
			{
				new gun = GetPlayerWeapon(from_player);

				ShowPlayerDialogf(playerid, 8790, DIALOG_STYLE_MSGBOX, !"{ee3366}�������� ������", "�������", "���",\
					"{FFFFFF}��������: %s[%d]\n\
					������: %s (%d ��)\n\n\
					�� ������������� ������ ������� ��� �����������",
					PI[from_player][pName],
					from_player,
					weapon_names[gun],
					value);

				return 1;
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
	if(PI[id][pRequest]) 
	{
		ClearRequest(playerid);
		return SCM(playerid, COLOR_GREY, !"� ������ ��� ���� �������� �����������");
	}

	PI[playerid][pRequest] = 1;
	PI[id][pRequest] = 1;

	PI[playerid][pRequestFor] = id;
	PI[id][pRequestFrom] = playerid;

	PI[playerid][pRequestValue_1] = value;
	PI[playerid][pRequestValue_2] = value_2;

	PI[playerid][pRequestType] = type;
	PI[id][pRequestType] = type;

	OfferTimer[playerid] = SetTimer("ClearOffer", 15*1000, false);
	OfferTimer[id] = SetTimer("ClearOffer", 15*1000, false);

	switch(type)
	{
		case 0:
		{
			cef_text[0] = EOS, f(cef_text, 56, "�� ���������� %s ������ ��� ����", getName(id));
			SendPlayerOfferNotify(playerid, 2, cef_text, "", "��������", 15);

			cef_text[0] = EOS, f(cef_text, 52, "%s ��������� ��� ������ ����", getName(playerid));
			SendPlayerOfferNotify(id, 1, cef_text, "�����������", "����������", 15);
		}
		case 1:
		{
			cef_text[0] = EOS, f(cef_text, 105, "�� ���������� %s �������� � ����������� (%s)", getName(id), Fraction_Name[PI[playerid][pMember]]);
			SendPlayerOfferNotify(playerid, 2, cef_text, "", "��������", 15);

			cef_text[0] = EOS, f(cef_text, 105, "%s %s ��������� ��� �������� � ����������� (%s)", NameRang(playerid), getName(playerid), Fraction_Name[PI[playerid][pMember]]);
			SendPlayerOfferNotify(id, 1, cef_text, "�����������", "����������", 15);
		}
		case 2:
		{
			cef_text[0] = EOS, f(cef_text, 51, "�� ���������� %s ����� ���� �������.", getName(id));
			SendPlayerOfferNotify(playerid, 2, cef_text, "", "��������", 15);

			cef_text[0] = EOS, format(cef_text, 54, "%s ��������� ��� ����� �������", getName(playerid));
			SendPlayerOfferNotify(id, 1, cef_text, "�����������", "����������", 15);
		}
		case 3:
		{
			cef_text[0] = EOS, f(cef_text, 64, "�� ���������� %s �������� ���� ���������", getName(id));
			SendPlayerOfferNotify(playerid, 2, cef_text, "", "��������", 15);

			cef_text[0] = EOS, format(cef_text, 64, "%s ��������� ��� �������� ���� ���������", getName(playerid));
			SendPlayerOfferNotify(id, 1, cef_text, "�����������", "����������", 15);
		}
		case 4:
		{
			cef_text[0] = EOS, f(cef_text, 64, "�� ���������� %s �������� ���� ��������", getName(id));
			SendPlayerOfferNotify(playerid, 2, cef_text, "", "��������", 15);

			cef_text[0] = EOS, format(cef_text, 64, "%s ��������� ��� �������� ���� ��������", getName(playerid));
			SendPlayerOfferNotify(id, 1, cef_text, "�����������", "����������", 15);
		}
		case 5:
		{
			cef_text[0] = EOS, f(cef_text, 64, "�� ���������� %s �������� ���� ���. �����", getName(id));
			SendPlayerOfferNotify(playerid, 2, cef_text, "", "��������", 15);

			cef_text[0] = EOS, format(cef_text, 64, "%s ��������� ��� �������� ���� ���. �����", getName(playerid));
			SendPlayerOfferNotify(id, 1, cef_text, "�����������", "����������", 15);
		}
		case 6:
		{
			cef_text[0] = EOS, f(cef_text, 64, "�� ���������� %s �������� ��� ������� �����", getName(id));
			SendPlayerOfferNotify(playerid, 2, cef_text, "", "��������", 15);

			cef_text[0] = EOS, format(cef_text, 64, "%s ��������� ��� �������� ���� ������� �����", getName(playerid));
			SendPlayerOfferNotify(id, 1, cef_text, "�����������", "����������", 15);
		}
		case 7:
		{
			cef_text[0] = EOS, f(cef_text, 64, "�� ���������� %s �������� ���� ������ ��������", getName(id));
			SendPlayerOfferNotify(playerid, 2, cef_text, "", "��������", 15);

			cef_text[0] = EOS, format(cef_text, 64, "%s ��������� ��� �������� ���� ������ ��������", getName(playerid));
			SendPlayerOfferNotify(id, 1, cef_text, "�����������", "����������", 15);
		}
		case 8:
		{
			cef_text[0] = EOS, f(cef_text, 64, "�� ���������� %s ����� ���� �����", getName(id));
			SendPlayerOfferNotify(playerid, 2, cef_text, "", "��������", 15);

			cef_text[0] = EOS, format(cef_text, 64, "%s ��������� ��� ����� ��� �����", getName(playerid));
			SendPlayerOfferNotify(id, 1, cef_text, "�����������", "����������", 15);
		}
		case 9:
		{
			cef_text[0] = EOS, f(cef_text, 120, "�� ���������� %s ������ ��������� '%s' �� %d ���", getName(id), VehicleNames[CarInfo[PI[playerid][pLoadVehicleID]][cModel]-400], value);
			SendPlayerOfferNotify(playerid, 2, cef_text, "", "��������", 15);

			cef_text[0] = EOS, format(cef_text, 130, "%s ��������� ��� ������ ��������� '%s' �� %d ���", getName(playerid), VehicleNames[CarInfo[PI[playerid][pLoadVehicleID]][cModel]-400], value);
			SendPlayerOfferNotify(id, 1, cef_text, "�����������", "����������", 15);
		}
		case 10:
		{
			cef_text[0] = EOS, f(cef_text, 71, "�� ���������� %s ������ ���� �������� �������.", getName(id));
			SendPlayerOfferNotify(playerid, 2, cef_text, "", "��������", 15);

			cef_text[0] = EOS, format(cef_text, 96, "��������� ���� %s ��������� ��� ������ ���� �������� ������� �� 750 ���.", getName(playerid));
			SendPlayerOfferNotify(id, 1, cef_text, "�����������", "����������", 15);
		}
		case 11:
		{
			cef_text[0] = EOS, f(cef_text, 85, "�� ���������� %s ������� � ����� �� %d ������", getName(id), value);
			SendPlayerOfferNotify(playerid, 2, cef_text, "", "��������", 15);

			cef_text[0] = EOS, format(cef_text, 120, "%s ��������� ��� ������� � ����� �� %d ������", getName(playerid), value);
			SendPlayerOfferNotify(id, 1, cef_text, "�����������", "����������", 15);
		}
		case 12:
		{
			cef_text[0] = EOS, f(cef_text, 100, "�� ���������� ����� �� ������ ������ %s �� %d ������", PI[id][pName], value);
			SendPlayerOfferNotify(playerid, 2, cef_text, "", "��������", 15);

			cef_text[0] = EOS, format(cef_text, 110, "������� %s ��������� ��� ����� �� ������ �� %d ������.", getName(playerid), value);
			SendPlayerOfferNotify(id, 1, cef_text, "�����������", "����������", 15);
		}
		case 13:
		{
			cef_text[0] = EOS, f(cef_text, 88, "�� ���������� ������ ������������ ����� ������ %s �� 5000 ������", PI[id][pName]);
			SendPlayerOfferNotify(playerid, 2, cef_text, "", "��������", 15);

			cef_text[0] = EOS, format(cef_text, 82, "%s ��������� ��� ������ ������������ ����� �� 5000 ������.", getName(playerid));
			SendPlayerOfferNotify(id, 1, cef_text, "�����������", "����������", 15);
		}
		case 14:
		{
			cef_text[0] = EOS, f(cef_text, 89, "�� ���������� ������ �������� �� ������ ������ %s �� 30000 ������", PI[id][pName]);
			SendPlayerOfferNotify(playerid, 2, cef_text, "", "��������", 15);

			cef_text[0] = EOS, format(cef_text, 82, "%s ��������� ��� ������ �������� �� ������ �� 30000 ������.", getName(playerid));
			SendPlayerOfferNotify(id, 1, cef_text, "�����������", "����������", 15);
		}
		case 15:
		{
			new gun_id = GetPlayerWeapon(playerid);

			cef_text[0] = EOS, f(cef_text, 89, "�� ���������� %s ����� � ��� %s (%d ��)",PI[id][pName], weapon_names[gun_id], value);
			SendPlayerOfferNotify(playerid, 2, cef_text, "", "��������", 15);

			cef_text[0] = EOS, format(cef_text, 82, "%s ��������� ��� ����� � ���� %s (%d ��)", getName(playerid), weapon_names[gun_id], value);
			SendPlayerOfferNotify(id, 1, cef_text, "�����������", "����������", 15);
		}
		default: 
		{
			ClearRequest(PI[playerid][pRequestFor]);
			ClearRequest(playerid);
		}
	}
	return 1;
}
callback: ClearOffer(playerid)
{
	ClearRequest(playerid);
}
stock SendR(playerid) return SCM(playerid, -1, "� ����������");