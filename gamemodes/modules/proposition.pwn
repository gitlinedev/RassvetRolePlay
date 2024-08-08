static const stock VehicleNames[][] = {
	"BMW X5","Audi A6 C8","Mersedec Akula","Lexus GX460","BMW M5 F90 2021","Mercedes-Benz E63","�����-���","����� ��������","Audi A6 2019","Mercedes GL63","Audi R8","Lada Kalina",
	"Lexus GSF","Nissan Titan 2017","BMW M5","Porsche 911","Ambulance","������ ������","Volkswagen Multivan","��� 2107","Nissan GTR","Washington","Infiniti JX 35 2013","Mr Whoopee","BF Injection",
	"Hunter","Audi A6","������","���������","���-�22","Predator","����-677�","Rhino","��� 131","Hotknife","Trailer","Toyota MarkII","Ikarus 260","���-2402",
	"��-412","Rumpo","RC Bandit","Romero","Packer","Monster","���-45","Squalo","Seasparrow","Pizzaboy","Tram","Trailer","Turismo","Speeder",
	"Reefer","Tropic","Flatbed","���-3309","Caddy","Audi A6","Berkley's RC Van","Skimmer","PCJ-600","Faggio","Freeway","RC Baron","RC Raider",
	"BMW 535i","Mercedes GLE","Sanchez","Sparrow","Patriot","Audi A7","Coastguard","Dinghy","���-21�","Toyota Land Cruiser","Rustler","ZR3 50","��-27151","���-2114",
	"Toyota Supra","���������","Burrito","���-3205","Marquis","��� 2402","Dozer","Maverick","News Chopper","Chevrolet Niva","FBI Rancher","Virgo","��� 2109",
	"Jetmax","Hotring","Sandking","���-1102","Police Maverick","Boxville","���-53","���-69","RC Goblin","Hotring A","Mersedes Benz E200",
	"Bloodring Banger","Rancher","Super GT","���-2401"," ���-452","�����","������ �����","Beagle","Cropdust","Stunt","�����-54115","���-608�",
	"���-21099","���-2203"," ����-672","Shamal","Hydra","�� ������� 5","NRG-500","����","Cement Truck","���������","Fortune","Cadrona","FBI Truck",
	"Willard","Forklift","Tractor","Combine","Feltzer","Remington","Slamvan","Blade","Freight","Streak","Vortex","�5 F90","Bugatti Chiron","��� 2424",
	"�������-434","Firetruck","�������-400","�������-2125","�������-2140","Cargobob","���-968�","Sunrise","��� 31105","Utility","Nevada","���-3303","���-968�","Monster A",
	"Monster B","Lamborghini Huracan Devo","Acura NSX GT3","Orange Porshe","�� �������-427","Elegy","Raindance","RC Tiger","��� 2108","��� 2104","Savanna","Bandito","Freight","Trailer",
	"Kart","Mower","Duneride","Sweeper","���-�20","�������-408","AT-400","���-157","Mersedes G65","BMW X5M","BF-400","Newsvan","Tug","Trailer A","Emperor",
	"������ 3�","Euros","����-677","Club","Trailer B","Trailer C","Andromada","Dodo","RC Cam","Launch","���-2401","��� 21099",
	"��� 2114","��� 469","��-2717","S.W.A.T.","Alpha","Phoenix","Glendale","Sadler","L Trailer A","L Trailer B",
	"Stair Trailer","���-699�","Farm Plow","U Trailer"
};

stock SendRequestForPlayer(playerid, id, type, value = 0, value_2 = 0) 
{

	PI[playerid][pRequestType] = type;
	PI[id][pRequestType] = type;

	PI[playerid][pRequestIDFor] = id;
	PI[id][pRequestIDFrom] = playerid;

	new gun_id = GetPlayerWeapon(playerid);

	if(type == 1)
	{
		if(CarInfo[PI[playerid][pLoadVehicleID]][cPremium] == 1)
		{
			//  {CCCCCC}(������� ����� �� ������� ���������: %d ���) �������
			SCMf(id, 0x33ceffFF, "%s ��������� ��� ������ ��������� '%s' �� %d ���", getName(playerid), VehicleNames[CarInfo[PI[playerid][pLoadVehicleID]][cModel]-400], value+value_2);
			SCM(id, COLOR_LIGHTGREY, !"����������� {43d778}Y{CCCCCC} ����� ����������� ��� {ff6633}N{CCCCCC}");
		}
		else 
		{
			SCMf(id, 0x33ceffFF, "%s ��������� ��� ������ ��������� '%s' �� %d ���", getName(playerid), VehicleNames[CarInfo[PI[playerid][pLoadVehicleID]][cModel]-400], value);
			SCM(id, COLOR_LIGHTGREY, !"����������� {43d778}Y{CCCCCC} ����� ����������� ��� {ff6633}N{CCCCCC}");
		}
	}
	if(type == 2)
	{
		SCMf(playerid, 0x36e96cFF, "�� ���������� %s ����� ���� �������.", PI[id][pName]);

		global_str[0] = EOS, format(global_str, 50, "%s ��������� ��� ����� �������", getName(playerid));
		SendPlayerOfferNotify(id, global_str, "�����������", "����������", 15);
	}
	if(type == 3)
	{
		SCMf(playerid, 0x36e96cFF, "�� ���������� %s ����� ���� �����.", PI[id][pName]);
		SCMf(id, 0x33ceffFF, "%s ��������� ��� ����� �����",getName(playerid));
		SCM(id, COLOR_LIGHTGREY, !"����������� {43d778}Y{CCCCCC} ����� ����������� ��� {ff6633}N{CCCCCC}");
	}
	if(type == 4)
	{
		SCMf(playerid, 0x36e96cFF, "�� ���������� ������ ���� %s",PI[id][pName]);
		SCMf(id, 0x33ceffFF, "%s ��������� ��� ������ ����.", getName(playerid));
		SCM(id, COLOR_LIGHTGREY, !"����������� {43d778}Y{CCCCCC} ����� ����������� ��� {ff6633}N{CCCCCC}");
	}
	if(type == 5)
	{
		SCMf(playerid, 0x36e96cFF, "�� ���������� ������ ���� %s", PI[id][pName]);
		SCMf(id, 0x33ceffFF, "%s ��������� ��� ������ ����.", getName(playerid));
		SCM(id, COLOR_LIGHTGREY, !"����������� {43d778}Y{CCCCCC} ����� ����������� ��� {ff6633}N{CCCCCC}");
	}
	if(type == 6)
	{
		SCMf(playerid, 0x36e96cFF, "�� ���������� ��������� �� ���� ���. ����� %s", PI[id][pName]);
		SCMf(id, 0x33ceffFF, "%s ��������� ��� ��������� �� ��� ���. �����.", getName(playerid));
		SCM(id, COLOR_LIGHTGREY, !"����������� {43d778}Y{CCCCCC} ����� ����������� ��� {ff6633}N{CCCCCC}");
	}
	if(type == 7)
	{
		SCMf(playerid, 0x36e96cFF, "�� ���������� ��������� �� ���� �������� %s", PI[id][pName]);
		SCMf(id, 0x33ceffFF, "%s ��������� ��� ��������� �� ��� ��������.", getName(playerid));
		SCM(id, COLOR_LIGHTGREY, !"����������� {43d778}Y{CCCCCC} ����� ����������� ��� {ff6633}N{CCCCCC}");
	}
	if(type == 8)
	{
		SCMf(playerid, 0x36e96cFF, "�� ���������� %s ������� � ����� �� {73B461}%d ������{FFFFFF}", PI[id][pName] ,value);
		SCMf(id, 0x33ceffFF, "%s ��������� ��� ������� � ����� �� {73B461}%d ������{FFFFFF}", getName(playerid), value);
		SCM(id, COLOR_LIGHTGREY, !"����������� {43d778}Y{CCCCCC} ����� ����������� ��� {ff6633}N{CCCCCC}");
	}
	if(type == 9)
	{
		SCMf(playerid, 0x36e96cFF, "�� ���������� ��������� �� ��� ������� %s", PI[id][pName]);
		SCMf(id, 0x33ceffFF, "%s ��������� ��� ��������� �� ��� �������.", getName(playerid));
		SCM(id, COLOR_LIGHTGREY, !"����������� {43d778}Y{CCCCCC} ����� ����������� ��� {ff6633}N{CCCCCC}");
	}
	if(type == 10)
	{
		SCMf(playerid, 0x36e96cFF, "�� ���������� ��������� �� ���� ������ �������� ������� %s",PI[id][pName]);
		SCMf(id, 0x33ceffFF, "%s ��������� ��� ��������� �� ��� ������ �������� �������.",getName(playerid));
		SCM(id, COLOR_LIGHTGREY, !"����������� {43d778}Y{CCCCCC} ����� ����������� ��� {ff6633}N{CCCCCC}");
	}
	if(type == 11)
	{
		SCM(id, COLOR_LIGHTGREY, !"����������� {43d778}Y{CCCCCC} ����� ����������� ��� {ff6633}N{CCCCCC}");
	}
	if(type == 12)
	{
		SCMf(playerid, 0x36e96cFF, "�� ���������� ����� �� ������ ������ %s �� {73B461}%d{FFFFFF} ������",PI[id][pName], value);
		SCMf(id, 0x33ceffFF, "������� %s ��������� ��� ����� �� ������ ��  {73B461}%d{FFFFFF} ������.",getName(playerid), value);
		SCM(id, COLOR_LIGHTGREY, !"����������� {43d778}Y{CCCCCC} ����� ����������� ��� {ff6633}N{CCCCCC}");
	}
	if(type == 13)
	{
		SCMf(playerid, 0x36e96cFF, "�� ���������� ������ �������� �� ������ ������ %s �� 30000 ������",PI[id][pName]);
		SCMf(id, 0x33ceffFF, "%s ��������� ��� ������ �������� �� ������ �� 30000 ������.",getName(playerid));
		SCM(id, COLOR_LIGHTGREY, !"����������� {43d778}Y{CCCCCC} ����� ����������� ��� {ff6633}N{CCCCCC}");
	}
	if(type == 14)
	{
		SCMf(playerid, 0x36e96cFF, "�� ���������� ������ ������������ ����� ������ %s �� 5000 ������",PI[id][pName]);
		SCMf(id, 0x33ceffFF, "%s ��������� ��� ������ ������������ ����� �� 5000 ������.",getName(playerid));
		SCM(id, COLOR_LIGHTGREY, !"����������� {43d778}Y{CCCCCC} ����� ����������� ��� {ff6633}N{CCCCCC}");	
	}
	if(type == 15)
	{
		new cena = GetPVarInt(playerid, "cena")/GetPVarInt(playerid, "pt");
		SCMf(playerid, 0x36e96cFF, "�� ���������� %s ������ � ��� %s (%d ��) �� %d ��� (%d �� 1 ��)", PI[id][pName], weapon_names[gun_id], value, GetPVarInt(playerid, "cena"), cena);
		SCMf(id, 0x33ceffFF, "%s ��������� ��� ������ � ���� %s (%d ��) �� %d ��� (%d �� 1 ��)", getName(playerid), weapon_names[gun_id], value, GetPVarInt(playerid, "cena"), cena);
		SCM(id, COLOR_LIGHTGREY, !"����������� {43d778}Y{CCCCCC} ����� ����������� ��� {ff6633}N{CCCCCC}");	
	}
	if(type == 16)
	{
		SCMf(playerid, 0x36e96cFF, "�� ���������� %s ����� � ��� %s (%d ��)",PI[id][pName], weapon_names[gun_id], value);
		SCMf(id, 0x33ceffFF, "%s ��������� ��� ����� � ���� %s (%d ��)",getName(playerid), weapon_names[gun_id], value);
		SCM(id, COLOR_LIGHTGREY, !"����������� {43d778}Y{CCCCCC} ����� ����������� ��� {ff6633}N{CCCCCC}");	
	}
	if(type == 17)
	{
		SCMf(playerid, 0x36e96cFF, "�� ���������� %s ������ ���� �������� �������.",PI[id][pName]);
		SCMf(id, 0x33ceffFF, "��������� ���� %s ��������� ��� ������ ���� �������� ������� �� 2500 ���.",getName(playerid));
		SCM(id, COLOR_LIGHTGREY, !"����������� {43d778}Y{CCCCCC} ����� ����������� ��� {ff6633}N{CCCCCC}");
	}
	return 1;	
}
stock CheckRequest(playerid)
{
	new from_player = PI[playerid][pRequestIDFrom]; // �� ������ (������)

	if(from_player != -1)
	{
		if(!IsPlayerConnected(from_player)) return SCM(playerid, COLOR_GREY, !"����� ����� �� ����");
		if(from_player == playerid) return ClearProposition(playerid);

		new type = PI[playerid][pRequestType];
		new value_1 = PI[from_player][pRequestValue];
		new value_2 = PI[from_player][pRequestValueTwo];

		new clear = 0;

		if(ProxDetectorS(10.0, playerid, from_player)) 
		{
			if(type == 1)
			{
				if(CarInfo[PI[from_player][pLoadVehicleID]][cPremium] == 1)
				{
					if(GetPlayerMoneyID(playerid) < value_1+value_2)
					{
						SCM(playerid, COLOR_LIGHTGREY, !"� ��� ������������ ����� ��� ������� ������� ���������");
						SCMf(from_player, COLOR_LIGHTGREY, "� ������ %s ������������ �����", getName(playerid));
					}
					else 
					{
						clear = 1;
						return ShowPlayerDialogf(playerid, 9221, DIALOG_STYLE_MSGBOX, !"{ee3366}�������������", !"������", !"�������",\
								"{FFFFFF}�� ������� ��� ������ ������ ����������: {3366cc}'%s'{FFFFFF}, �� {3366cc}%d ���\n {FFFF99}(������� ����� �� ������� ���������: %d ���)",
								VehicleNames[CarInfo[PI[from_player][pLoadVehicleID]][cModel]-400], value_1+value_2, value_2);
					}
				}
				else 
				{
					if(GetPlayerMoneyID(playerid) < value_1)
					{
						SCM(playerid, COLOR_LIGHTGREY, !"� ��� ������������ ����� ��� ������� ������� ���������");
						SCMf(from_player, COLOR_LIGHTGREY, "� ������ %s ������������ �����", getName(playerid));
					}
					else 
					{
						clear = 1;
						return ShowPlayerDialogf(playerid, 9221, DIALOG_STYLE_MSGBOX, !"{ee3366}�������������", !"������", !"�������",\
							"{FFFFFF}�� ������� ��� ������ ������ ����������: {3366cc}'%s'{FFFFFF}, �� {3366cc}%d ���", 
							VehicleNames[CarInfo[PI[from_player][pLoadVehicleID]][cModel]-400], value_1);
					}
				}
			}
			if(type == 2)
			{
                new str[145];
			 	PI[from_player][pHealPack]--;
				PI[playerid][pHealPack]++;
				format(str,sizeof(str),"%s ������� ������� %s",PI[from_player][pName], getName(playerid));
			    ProxDetector(25.0, playerid, str, 0xFF99CCFF, 0xFF99CCFF, 0xFF99CCFF, 0xFF99CCFF, 0xFF99CCFF);
			    SetPlayerChatBubble(from_player, "������� �������", 0xFF99CCFF, 20.0, 4000);
			}
			if(type == 3)
			{
				new str[145];
			 	PI[from_player][data_MASK]--;
				PI[playerid][data_MASK]++;
				format(str,sizeof(str),"%s ������� ����� %s",PI[from_player][pName], getName(playerid));
			    ProxDetector(25.0, playerid, str, 0xFF99CCFF, 0xFF99CCFF, 0xFF99CCFF, 0xFF99CCFF, 0xFF99CCFF);
			    SetPlayerChatBubble(from_player, "������� �����", 0xFF99CCFF, 20.0, 4000);
			}
			if(type == 4)
			{
				new Float:angle, str[144];
				GetPlayerFacingAngle(from_player, angle);
				SetPlayerFacingAngle(playerid, angle + 180);
				ApplyAnimation(from_player,"GANGS","hndshkfa",4.0,0,0,0,0,0,1);
				ApplyAnimation(playerid,"GANGS","hndshkfa",4.0,0,0,0,0,0,1);
				format(str, sizeof(str),"%s ����� ���� %s", PI[from_player][pName], getName(playerid));
			 	ProxDetector(25.0, playerid, str, 0xFF99CCFF, 0xFF99CCFF, 0xFF99CCFF, 0xFF99CCFF, 0xFF99CCFF);
			}
			if(type == 5)
			{
				new Float:angle, str[144];
				GetPlayerFacingAngle(from_player, angle);
				SetPlayerFacingAngle(playerid, angle + 180);
				ApplyAnimation(from_player,"GANGS","hndshkfa",4.0,0,0,0,0,0,1);
				ApplyAnimation(playerid,"GANGS","hndshkfa",4.0,0,0,0,0,0,1);
				format(str, sizeof(str),"%s ����� ���� %s", PI[from_player][pName], getName(playerid));
			 	ProxDetector(25.0, playerid, str, 0xFF99CCFF, 0xFF99CCFF, 0xFF99CCFF, 0xFF99CCFF, 0xFF99CCFF);
			}
			if(type == 6)
			{
				new str_3[285];
				format(str_3,sizeof(str_3),"��� ���. ��������: \t\t\t�������� �%d\n\
				��������� ��\t\t\t{3377cc}%s\n\
				{FFFFFF}�������\t\t\t��������\n\
				{FFFFFF}���������� ���������\t\t\t����������\n\
				{FFFFFF}�����������\t\t\t���", PI[from_player][data_MEDNUM], PI[from_player][pName]);
				return ShowPlayerDialog(playerid,0, DIALOG_STYLE_LIST, "{ee3366}��������", str_3, "�������", "");
			}
			if(type == 7)
			{
				new licb[40+1], licg[40+1];
				switch(PI[from_player][pDriveLicense]) {
     				case 1: format(licb,sizeof(licb),"{FFFFFF}������������ �����: \t\t\t{FF6347}-");
					case 2: format(licb,sizeof(licb),"{FFFFFF}������������ �����: \t\t\t{24ff78}+");
				}
				switch(PI[from_player][pGunLicense]) {
     				case 1: format(licg,sizeof(licg),"{FFFFFF}�������� �� ������: \t\t\t{FF6347}-");
					case 2: format(licg,sizeof(licg),"{FFFFFF}�������� �� ������: \t\t\t{24ff78}+");
				}
				new str_3[285];
				format(str_3,sizeof(str_3),"��������� ���. ��������: \t\t\t�������� �%d\n��������� ��\t\t\t{3377cc}%s\n%s\n%s", PI[from_player][data_LICNUM], PI[from_player][pName], licb, licg);
				ShowPlayerDialog(playerid,0, DIALOG_STYLE_MSGBOX, PI[from_player][pName], str_3, "�������", "");
			}
			if(type == 8)
			{
				new money = value_1;
		        if(GetPlayerMoneyID(from_player) < money) 
				{
					ClearProposition(from_player);
				    SCM(from_player, COLOR_GREY, !"� ��� ������������ ����� �� �����");
					return 1;
				}
    			if(GetPlayerMoneyID(playerid) < money) 
				{
					ClearProposition(from_player);
					SCM(playerid, COLOR_GREY, !"� ������ ������������ ����� �� �����");
					return 1;
				}
		        new p1 = RandomEX(1,12);
		        new p2 = RandomEX(1,12);
				if(p1 > p2) {
				    GivePlayerMoneyLog(playerid, -money);
				    GivePlayerMoneyLog(from_player, money);
					cef_emit_event(from_player, "show-center-notify", CEFINT(5), CEFSTR("�� ��������"));
		    		cef_emit_event(playerid, "show-center-notify", CEFINT(3), CEFSTR("�� ���������"));
				}
				else if(p1 < p2) {
				    GivePlayerMoneyLog(playerid, money);
				    GivePlayerMoneyLog(from_player, -money);
					cef_emit_event(playerid, "show-center-notify", CEFINT(5), CEFSTR("�� ��������"));
		    		cef_emit_event(from_player, "show-center-notify", CEFINT(3), CEFSTR("�� ���������"));
				}
				else
				{}
		        new str[145];
				format(str,sizeof(str),"%s � %s ������� ��������� ��������� ������ {FF9966}(%d|%d)",PI[from_player][pName],getName(playerid), p1,p2);
		        ProxDetector(25.0, from_player, str, 0xFF99CCFF,0xFF99CCFF,0xFF99CCFF,0xFF99CCFF,0xFF99CCFF);
			}
			if(type == 9)
			{
				new playerhouse[5];
				if(PI[from_player][data_HOUSE] != -1) format(playerhouse,sizeof(playerhouse),PI[from_player][data_HOUSE]);
				else format(playerhouse,sizeof(playerhouse),"---");
				new dialog[256];
				format(dialog,sizeof(dialog),"���\t\t\t\t%s\n��� � �������\t\t\t%d\n������������������\t\t%d\n������� �������\t\t%d\n{FFFFFF}����� ����\t\t\t%d\n{FFFFFF}����� ������\t\t%s",PI[from_player][pName],PI[from_player][pLevel],PI[from_player][pRespect],PI[from_player][pWanted],playerhouse,PI[from_player][data_JOB]);
				ShowPlayerDialog(playerid,0, DIALOG_STYLE_LIST, "{ee3366}�������", dialog, "�������", "");
				SetPlayerChatBubble(playerid, "������������� ���������", 0xFF99CCFF, 20.0, 4000);
			}
			if(type == 10)
			{
				new dialog[256];
				format(dialog,sizeof(dialog),"1. ��:\t\t\t%d %%\n2. ������\t%d %%\n3. Desert Eagle:\t\t%d %%\n4. ��������:\t\t\t%d\n5. �������������� ��������:\t\t\t%d %%\n6. ��-47:\t\t%d %%", PI[from_player][pSkillPistol],PI[from_player][pSkillSDPistol],PI[from_player][pSkillDeagle],PI[from_player][pSkillShotgun],PI[from_player][pSkillMP5],PI[from_player][data_AK47]);
				ShowPlayerDialog(playerid, 0, DIALOG_STYLE_LIST, "{ee3366}������ �������� �������", dialog, "�������", "");
			 	SetPlayerChatBubble(playerid, "������������� ������ �������� �������", 0xFF99CCFF, 20.0, 4000);
			}
			if(type == 11)
			{
				pDialogCurrectTime[playerid] = gettime() + 5;
				pDialogTimer[playerid] = SetTimerEx("DialogTimerInvite", 500, true, "i", playerid);
			    SetPVarInt(playerid, "from_player",from_player);
				return 1;
			}
			if(type == 12)
			{
				if(GetPlayerMoneyID(playerid) < value_1) return SCM(playerid, COLOR_GREY, !"� ��� ������������ ����� �� �����");
				GivePlayerMoneyLog(playerid,-value_1);
				GivePlayerMoneyLog(from_player,value_1);
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
			if(type == 13)
			{
				if(GetPlayerMoneyID(playerid) < 30000) return SCM(playerid, COLOR_GREY, !"� ��� ������������ ����� �� �����");
				GivePlayerMoneyLog(playerid,-30000);
				GivePlayerMoneyLog(from_player,3000);
				PI[playerid][pGunLicense] = 1;
				if(PI[playerid][data_LICNUM] == 0) PI[playerid][data_NUMBER] = RandomEX(1111111, 6666666);
				SCM(playerid, 0x9F81F7FF, !"�� ������ �������� �� ������ �� 30000 ������");
			}
			if(type == 14)
			{
				if(GetPlayerMoneyID(playerid) < 5000) return SCM(playerid, COLOR_GREY, !"� ��� ������������ ����� �� �����");
				GivePlayerMoneyLog(playerid,-5000);
				GivePlayerMoneyLog(from_player,5000);
				PI[playerid][pDriveLicense] = 1;
				if(PI[playerid][data_LICNUM] == 0) PI[playerid][data_NUMBER] = RandomEX(1111111, 6666666);
				SCM(playerid, 0x9F81F7FF, !"�� ������ ������������ ����� �� 5000 ������");
			}
			if(type == 15)
			{
				pDialogCurrectTime[playerid] = gettime() + 5;
				pDialogTimer[playerid] = SetTimerEx("DialogTimerGiveGun", 500, true, "i", playerid);
				SetPVarInt(playerid, "from_player", from_player);
				SetPVarInt(playerid, "value_1", value_1);
			}
			if(type == 16)
			{
				pDialogCurrectTime[playerid] = gettime() + 5;
				pDialogTimer[playerid] = SetTimerEx("DialogTimerSellGun", 500, true, "i", playerid);
				SetPVarInt(playerid, "from_player", from_player);
				SetPVarInt(playerid, "value_1", value_1);
			}
			if(type == 17)
			{
				SCMf(from_player, 0xFF99CCFF, !"��������� ���� %s ����� ���� �������� �������.",PI[from_player][pName]);
				GivePlayerMoneyLog(playerid, -2500);
				GivePlayerMoneyLog(from_player, 5000);
				if(PI[playerid][data_VIP] == 0) SetPlayerHealthAC(playerid, 100);
				else SetPlayerHealthAC(playerid, 176);
			}
			if(clear == 0) ClearProposition(from_player);
		}
		else SCM(playerid, COLOR_LIGHTGREY, !"������ ����� ������� ������ �� ���");
	}
	return 1;
}
stock ClearProposition(playerid) 
{
	cef_emit_event(playerid, "cef:remove:notification:offer");
	PI[playerid][pRequestIDFrom] = -1;
	PI[playerid][pRequestType] = -1;
	PI[playerid][pRequestIDFor] = -1;
	PI[playerid][pRequestValue] = -1; 
	PI[playerid][pRequestValueTwo] = -1;
	return 1;
}
stock CancelRequest(playerid)
{
	if(PI[playerid][pRequestIDFor] != -1) // ���
	{
		SCMf(PI[playerid][pRequestIDFor], COLOR_GREY, "%s ������� ���� �����������", getName(playerid));
		SCMf(playerid, COLOR_GREY, "�� �������� ���� ����������� ��� ������ %s", PI[PI[playerid][pRequestIDFor]][pName]);

		ClearProposition(PI[playerid][pRequestIDFor]);
	}
	else if (PI[playerid][pRequestIDFrom] != -1) // ��
	{
		SCMf(PI[playerid][pRequestIDFrom], COLOR_GREY, "%s ��������� �� ������ �����������", getName(playerid));
		SCMf(playerid, COLOR_GREY, "�� ���������� �� ����������� ������ %s", PI[PI[playerid][pRequestIDFrom]][pName]);

		ClearProposition(PI[playerid][pRequestIDFrom]);
	}
	ClearProposition(playerid);
	return 1;
}