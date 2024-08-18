static const stock VehicleNames[][] = {
	"BMW X5", "Lincoln Continental ", "Mercedes-Benz Е63","Mercedes-Benz Actros", "ВАЗ 2101", "Mitsubishi Lancer X", "Dumper", "КаМАЗ", "Зил 130","Mercedes GL63","Audi R8","Lada Kalina",
	"Lexus GSF","Nissan Titan 2017","BMW M5","Porsche 911","Ambulance","Скорая помощь","Volkswagen Multivan","ВАЗ 2107","Nissan GTR","Washington","Infiniti JX 35 2013","Mr Whoopee","BF Injection",
	"Hunter","Audi A6","Газель","Инкасатор","ГАЗ-М22","Predator","ЛиАЗ-677М","Rhino","ЗИЛ 131","Hotknife","Trailer","Toyota MarkII","Ikarus 260","ГАЗ-2402",
	"ИЖ-412","Rumpo","RC Bandit","Romero","Packer","Monster","ЗИЗ-45","Squalo","Seasparrow","Pizzaboy","Tram","Trailer","Turismo","Speeder",
	"Reefer","Tropic","Flatbed","ГАЗ-3309","Caddy","Audi A6","Berkley's RC Van","Skimmer","PCJ-600","Faggio","Freeway","RC Baron","RC Raider",
	"BMW 535i","Mercedes GLE","Sanchez","Sparrow","Patriot","Audi A7","Coastguard","Dinghy","ГАЗ-21И","Toyota Land Cruiser","Rustler","ZR3 50","ИЖ-27151","ВАЗ-2114",
	"Toyota Supra","Велосипед","Burrito","ПАЗ-3205","Marquis","ГАЗ 2402","Dozer","Maverick","News Chopper","Chevrolet Niva","FBI Rancher","Virgo","ВАЗ 2109",
	"Jetmax","Hotring","Sandking","ЗАЗ-1102","Police Maverick","Boxville","ГАЗ-53","УАЗ-69","RC Goblin","Hotring A","Mercedes-Benz GLE 63 AMG",
	"Bloodring Banger","Mercedes-Benz GLE 63 AMG","Super GT","ГАЗ-2401"," УАЗ-452","Велик","Горный велик","Beagle","Cropdust","Stunt","КАМАЗ-54115","КАЗ-608В",
	"ВАЗ-21099","РАФ-2203"," ЕРАЗ-672","Shamal","Hydra","ИЖ Планета 5","NRG-500","Урал","Cement Truck","Эвакуатор","Fortune","Cadrona","FBI Truck",
	"Willard","Forklift","Tractor","Combine","Feltzer","Remington","Slamvan","Blade","Freight","Streak","Vortex","М5 F90","Lamborghini Aventador","ВАЗ 2424",
	"Москвич-434","Firetruck","Москвич-400","Москвич-2125","Москвич-2140","Cargobob","ЗАЗ-968А","Sunrise","ГАЗ 31105","Utility","Nevada","УАЗ-3303","ЗАЗ-968М","Monster A",
	"Monster B","Lamborghini Huracan Devo","Acura NSX GT3","Orange Porshe","ИЖ Москвич-427","Elegy","Raindance","RC Tiger","ВАЗ 2108","ВАЗ 2104","Savanna","Bandito","Freight","Trailer",
	"Kart","Mower","Duneride","Sweeper","ГАЗ-М20","Москвич-408","AT-400","ЗИЛ-157","Mercedes-Benz G63 AMG 2019","BMW X5M","BF-400","Newsvan","Tug","Trailer A","Emperor",
	"Восход 3М","Euros","ЛиАЗ-677","Club","Trailer B","Trailer C","Andromada","Dodo","RC Cam","Launch","ГАЗ-2401","ВАЗ 21099",
	"ВАЗ 2114","УАЗ 469","ИЖ-2717","S.W.A.T.","Rolls Royce Phantom 2018","Phoenix","Glendale","Sadler","L Trailer A","L Trailer B",
	"Stair Trailer","ЛАЗ-699Р","Farm Plow","U Trailer"
};

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

stock CancelRequest(playerid)
{
	if(PI[playerid][pRequest] == 1)
	{
		if(PI[playerid][pRequestFor] != INVALID_PLAYER_ID)
		{
			SCMf(PI[playerid][pRequestFor], COLOR_GREY, "%s отменил свое предложение", getName(playerid));
			SCMf(playerid, COLOR_GREY, "Вы отменили свое предложение для игрока %s", PI[PI[playerid][pRequestFor]][pName]);

			
			ClearRequest(PI[playerid][pRequestFor]);
			ClearRequest(playerid);
		}
		else if(PI[playerid][pRequestFrom] != INVALID_PLAYER_ID)
		{
			SCMf(PI[playerid][pRequestFrom], COLOR_GREY, "%s отказался от Вашего предложения", getName(playerid));
			SCMf(playerid, COLOR_GREY, "Вы отказались от предложения игрока %s", PI[PI[playerid][pRequestFrom]][pName]);

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
		return SCM(playerid, COLOR_GREY, !"Игрок не в сети");
	}
	if(!IsPlayerLogged{PI[playerid][pRequestFrom]}) 
	{
		ClearRequest(playerid);
		return SCM(playerid, COLOR_GREY, !"Игрок не авторизован");
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

				format(str, sizeof(str),"%s пожал руку %s", getName(from_player), getName(playerid));
			 	ProxDetector(25.0, playerid, str, 0xFF99CCFF, 0xFF99CCFF, 0xFF99CCFF, 0xFF99CCFF, 0xFF99CCFF);
			}
			case 1:
			{
				SetPVarInt(playerid, "FromID", from_player);
				ShowPlayerDialogf(playerid, 7242, DIALOG_STYLE_MSGBOX, "{ee3366}Вступление в организацию", "Вступить", "Закрыть", "\
					{FFFFFF}Пригласил: %s\n\
					Организация: %s\n\n\
					{FFFF99}Вы действительно хотите вступить в организацию?", 
						getName(from_player), Fraction_Name[PI[from_player][pMember]]);
			}
			case 2:
			{
			 	PI[from_player][pHealPack]--;
				PI[playerid][pHealPack]++;

			    SetPlayerChatBubble(from_player, "передал аптечку", 0xFF99CCFF, 20.0, 4000);

				format(request_str, 70,"%s передал аптечку %s", getName(from_player), getName(playerid));
			    ProxDetector(25.0, playerid, request_str, 0xFF99CCFF, 0xFF99CCFF, 0xFF99CCFF, 0xFF99CCFF, 0xFF99CCFF);
			}
			case 3:
			{
			 	new PlayerHouse[5];
				if(PI[from_player][pHouse] != -1) format(PlayerHouse, sizeof(PlayerHouse), PI[from_player][pHouse]);
				else format(PlayerHouse, sizeof(PlayerHouse), "---");

				global_str[0] = EOS, f(global_str, 300, "{000000}Имя\t\t\t\t{ee3366}%s\n\
														{000000}Лет в области\t\t\t%d\n\
														{000000}Законнопослушность\t\t%d\n\
														{000000}Уровень розыска\t\t%d\n\
														{000000}Номер дома\t\t\t%d",
														PI[from_player][pName],
														PI[from_player][pLevel],
														PI[from_player][pRespect],
														PI[from_player][pWanted],
														PlayerHouse);

				CEF_ShowPlayerDialog(playerid, 0, DIALOG_STYLE_LIST, "{ee3366}Паспорт", global_str, "Закрыть", "");

				SetPlayerChatBubble(playerid, "просматривает документы", 0xFF99CCFF, 20.0, 4000);
			}
			case 4:
			{
			 	ShowPlayerDialogf(playerid, 0, DIALOG_STYLE_LIST, "{ee3366}Лицензии", "Закрыть", "", "\
					Автошкола птг. Батырево: \tДокумент №%d\n\
					Гражданин РФ\t\t\t{3377cc}%s\n\
					{FFFFFF}Водительские права: \t\t\t%s\n\
					{FFFFFF}Лицензия на оружие: \t\t\t%s", 
						PI[from_player][pLicNumber], 
						getName(from_player), 
						PI[from_player][pDriveLicense] ? "{FF6347}-" : "{24ff78}+", 
						PI[from_player][pGunLicense] ? "{FF6347}-" : "{24ff78}+");

				SetPlayerChatBubble(playerid, "просматривает лицензии", 0xFF99CCFF, 20.0, 4000);
			}
			case 5:
			{
				ShowPlayerDialogf(playerid, 0, DIALOG_STYLE_LIST, !"{ee3366}Лицензии", "Закрыть", "", "\
					{FFFFFF}ЦРБ птг. Батырево: \t\tДокумент №%d\n\
					{FFFFFF}Гражданин РФ\t\t\t{3377cc}%s\n\
					{FFFFFF}Анализы\t\t\tПройдены\n\
					{FFFFFF}Физическое состояние\tНормальное\n\
					{FFFFFF}Зависимость\t\t\tНет", 
					PI[from_player][data_MEDNUM], 
					getName(from_player));
			}
			case 6:
			{
				ShowPlayerDialogf(playerid, 0, DIALOG_STYLE_MSGBOX, !"{ee3366}Военный билет", !"Закрыть", !"", \
					"{FFFFFF}Войсковая часть г. Батырево\n\
					Гражданин РФ: {3377cc}%s\n\
					{FFFFFF}Военный билет: %s", 
					getName(from_player), 
					(PI[from_player][pMilitaryID]) ? ("есть") : ("нету"));
			}
			case 7:
			{
				ShowPlayerDialogf(playerid, 0, DIALOG_STYLE_LIST, !"{ee3366}Навыки владения оружием", !"Закрыть", !"",\
					"1. ТТ:\t\t\t%d %%\n\
					2. Тайзер:\t\t%d %%\n\
					3. ПЛ-15:\t\t%d %%\n\
					4. Дробовик:\t\t%d %%\n\
					5. MP5:\t\t\t%d %%\n\
					6. AK-47:\t\t%d %%",
						PI[from_player][pSkillPistol],
						PI[from_player][pSkillSDPistol],
						PI[from_player][pSkillDeagle],
						PI[from_player][pSkillShotgun],
						PI[from_player][pSkillMP5],
						PI[from_player][pSkillAK47]);
				SetPlayerChatBubble(playerid, "просматривает навыки владения оружием", 0xFF99CCFF, 20.0, 4000);
			}
			case 8:
			{

			 	PI[from_player][pMask]--;
				PI[playerid][pMask]++;

				global_str[0] = EOS, f(global_str, 70, "%s передал маску %s", PI[from_player][pName], getName(playerid));
			    ProxDetector(25.0, playerid, global_str, 0xFF99CCFF, 0xFF99CCFF, 0xFF99CCFF, 0xFF99CCFF, 0xFF99CCFF);
			    SetPlayerChatBubble(from_player, "передал маску", 0xFF99CCFF, 20.0, 4000);
			}
			case 9:
			{
				if(CarInfo[PI[from_player][pLoadVehicleID]][cPremium] == 1)
				{
					if(GetPlayerMoneyID(playerid) < value+value_2)
					{
						SCM(playerid, COLOR_LIGHTGREY, !"У Вас недостаточно денег для покупки данного траспорта");
						SCMf(from_player, COLOR_LIGHTGREY, "У игрока %s недостаточно денег", getName(playerid));
					}
					else 
					{
						ShowPlayerDialogf(playerid, 9221, DIALOG_STYLE_MSGBOX, !"{ee3366}Подтверждение", !"Купить", !"Закрыть",\
								"{FFFFFF}Вы уверены что хотите купить траснсопрт: {3366cc}'%s'{FFFFFF}, за {3366cc}%d руб\n {FFFF99}(включая налог на премиум транспорт: %d руб)",
								VehicleNames[CarInfo[PI[from_player][pLoadVehicleID]][cModel]-400], value+value_2, value_2);
					}
				}
				else 
				{
					if(GetPlayerMoneyID(playerid) < value)
					{
						SCM(playerid, COLOR_LIGHTGREY, !"У Вас недостаточно денег для покупки данного траспорта");
						SCMf(from_player, COLOR_LIGHTGREY, "У игрока %s недостаточно денег", getName(playerid));
					}
					else 
					{
						ShowPlayerDialogf(playerid, 9221, DIALOG_STYLE_MSGBOX, !"{ee3366}Подтверждение", !"Купить", !"Закрыть",\
							"{FFFFFF}Вы уверены что хотите купить траснсопрт: {3366cc}'%s'{FFFFFF}, за {3366cc}%d руб", 
							VehicleNames[CarInfo[PI[from_player][pLoadVehicleID]][cModel]-400], value);
					}
				}
				return 1;
			}
			case 10:
			{
				SCMf(from_player, 0xFF99CCFF, "Сотрудник БЦРБ %s провёл курс платного лечения.", PI[from_player][pName]);
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
				    SCM(playerid, COLOR_GREY, !"У Вас недостаточно денег на руках");
					SCM(from_player, COLOR_GREY, !"У игрока недостаточно денег на руках");
					ClearRequest(PI[playerid][pRequestFrom]);
					ClearRequest(playerid);
					return 1;
				}
    			if(GetPlayerMoneyID(from_player) < money) 
				{
					SCM(from_player, COLOR_GREY, !"У Вас недостаточно денег на руках");
					SCM(playerid, COLOR_GREY, !"У игрока недостаточно денег на руках");
					ClearRequest(PI[playerid][pRequestFrom]);
					ClearRequest(playerid);
					return 1;
				}

		        new p1 = RandomEX(1,6), p2 = RandomEX(1,6);
				
				if(p1 > p2) 
				{
				    GivePlayerMoneyLog(playerid, -money);
				    GivePlayerMoneyLog(from_player, money);

					SendPlayerCenterNotify(playerid, 2, "Вы проиграли", 5);
					SendPlayerCenterNotify(from_player, 5, "Вы выиграли", 5);
				}
				else if(p1 < p2) 
				{
				    GivePlayerMoneyLog(from_player, -money);
				    GivePlayerMoneyLog(playerid, money);

					SendPlayerCenterNotify(from_player, 2, "Вы проиграли", 5);
					SendPlayerCenterNotify(playerid, 5, "Вы выиграли", 5);
				}
		        global_str[0] = EOS, f(global_str, 110,"%s и %s бросили несколько игральных костей {FF9966}(%d|%d)", PI[from_player][pName], getName(playerid), p1, p2);
		        ProxDetector(25.0, from_player, global_str, 0xFF99CCFF, 0xFF99CCFF, 0xFF99CCFF, 0xFF99CCFF, 0xFF99CCFF);
			}
			case 12:
			{
				if(GetPlayerMoneyID(playerid) < value) return SCM(playerid, COLOR_GREY, !"У Вас недостаточно денег на руках");
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
					    SCM(playerid, 0x9F81F7FF, !"Адвокат смог освободить Вас из тюрьмы");
				    }
				}
			}
			case 13:
			{
				if(GetPlayerMoneyID(playerid) < 5000) return SCM(playerid, COLOR_GREY, !"У Вас недостаточно денег на руках");
				GivePlayerMoneyLog(playerid, -5000);
				GivePlayerMoneyLog(from_player, 5000);
				PI[playerid][pDriveLicense] = 1;
				if(PI[playerid][pLicNumber] == 0) PI[playerid][pLicNumber] = RandomEX(1111111, 6666666);
				SCM(playerid, 0x9F81F7FF, !"Вы купили водительские права за 5000 рублей");
			}
			case 14:
			{
				if(GetPlayerMoneyID(playerid) < 30000) return SCM(playerid, COLOR_GREY, !"У Вас недостаточно денег на руках");
				GivePlayerMoneyLog(playerid, -30000);
				GivePlayerMoneyLog(from_player, 25000);
				PI[playerid][pGunLicense] = 1;
				if(PI[playerid][pLicNumber] == 0) PI[playerid][pLicNumber] = RandomEX(1111111, 6666666);
				SCM(playerid, 0x9F81F7FF, !"Вы купили лицензию на оружие за 30000 рублей");
			}
			case 15:
			{
				new gun = GetPlayerWeapon(from_player);

				ShowPlayerDialogf(playerid, 8790, DIALOG_STYLE_MSGBOX, !"{ee3366}Передача оружия", "Принять", "Нет",\
					"{FFFFFF}Владелец: %s[%d]\n\
					Оружие: %s (%d пт)\n\n\
					Вы действительно хотите принять это предложение",
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
		return SCM(playerid, COLOR_GREY, !"Игрок не в сети");
	}
	if(!IsPlayerLogged{id}) 
	{
		ClearRequest(playerid);
		return SCM(playerid, COLOR_GREY, !"Игрок не авторизован");
	}
	if(PI[id][pRequest]) 
	{
		ClearRequest(playerid);
		return SCM(playerid, COLOR_GREY, !"У игрока уже есть активное предложение");
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
			cef_text[0] = EOS, f(cef_text, 56, "Вы предложили %s пожать Вам руку", getName(id));
			SendPlayerOfferNotify(playerid, 2, cef_text, "", "ОТМЕНИТЬ", 15);

			cef_text[0] = EOS, f(cef_text, 52, "%s предложил Вам пожать руку", getName(playerid));
			SendPlayerOfferNotify(id, 1, cef_text, "СОГЛАСИТЬСЯ", "ОТКАЗАТЬСЯ", 15);
		}
		case 1:
		{
			cef_text[0] = EOS, f(cef_text, 105, "Вы предложили %s вступить в организацию (%s)", getName(id), Fraction_Name[PI[playerid][pMember]]);
			SendPlayerOfferNotify(playerid, 2, cef_text, "", "ОТМЕНИТЬ", 15);

			cef_text[0] = EOS, f(cef_text, 105, "%s %s предложил Вам вступить в организацию (%s)", NameRang(playerid), getName(playerid), Fraction_Name[PI[playerid][pMember]]);
			SendPlayerOfferNotify(id, 1, cef_text, "СОГЛАСИТЬСЯ", "ОТКАЗАТЬСЯ", 15);
		}
		case 2:
		{
			cef_text[0] = EOS, f(cef_text, 51, "Вы предложили %s взять вашу аптечку.", getName(id));
			SendPlayerOfferNotify(playerid, 2, cef_text, "", "ОТМЕНИТЬ", 15);

			cef_text[0] = EOS, format(cef_text, 54, "%s предложил Вам взять аптечку", getName(playerid));
			SendPlayerOfferNotify(id, 1, cef_text, "СОГЛАСИТЬСЯ", "ОТКАЗАТЬСЯ", 15);
		}
		case 3:
		{
			cef_text[0] = EOS, f(cef_text, 64, "Вы предложили %s показать ваши документы", getName(id));
			SendPlayerOfferNotify(playerid, 2, cef_text, "", "ОТМЕНИТЬ", 15);

			cef_text[0] = EOS, format(cef_text, 64, "%s предложил Вам показать свои документы", getName(playerid));
			SendPlayerOfferNotify(id, 1, cef_text, "СОГЛАСИТЬСЯ", "ОТКАЗАТЬСЯ", 15);
		}
		case 4:
		{
			cef_text[0] = EOS, f(cef_text, 64, "Вы предложили %s показать ваши лицензии", getName(id));
			SendPlayerOfferNotify(playerid, 2, cef_text, "", "ОТМЕНИТЬ", 15);

			cef_text[0] = EOS, format(cef_text, 64, "%s предложил Вам показать свои лицензии", getName(playerid));
			SendPlayerOfferNotify(id, 1, cef_text, "СОГЛАСИТЬСЯ", "ОТКАЗАТЬСЯ", 15);
		}
		case 5:
		{
			cef_text[0] = EOS, f(cef_text, 64, "Вы предложили %s показать вашу мед. карту", getName(id));
			SendPlayerOfferNotify(playerid, 2, cef_text, "", "ОТМЕНИТЬ", 15);

			cef_text[0] = EOS, format(cef_text, 64, "%s предложил Вам показать свою мед. карту", getName(playerid));
			SendPlayerOfferNotify(id, 1, cef_text, "СОГЛАСИТЬСЯ", "ОТКАЗАТЬСЯ", 15);
		}
		case 6:
		{
			cef_text[0] = EOS, f(cef_text, 64, "Вы предложили %s показать ваш военный билет", getName(id));
			SendPlayerOfferNotify(playerid, 2, cef_text, "", "ОТМЕНИТЬ", 15);

			cef_text[0] = EOS, format(cef_text, 64, "%s предложил Вам показать свой военный билет", getName(playerid));
			SendPlayerOfferNotify(id, 1, cef_text, "СОГЛАСИТЬСЯ", "ОТКАЗАТЬСЯ", 15);
		}
		case 7:
		{
			cef_text[0] = EOS, f(cef_text, 64, "Вы предложили %s показать ваши навыки стрельбы", getName(id));
			SendPlayerOfferNotify(playerid, 2, cef_text, "", "ОТМЕНИТЬ", 15);

			cef_text[0] = EOS, format(cef_text, 64, "%s предложил Вам показать свои навыки стрельбы", getName(playerid));
			SendPlayerOfferNotify(id, 1, cef_text, "СОГЛАСИТЬСЯ", "ОТКАЗАТЬСЯ", 15);
		}
		case 8:
		{
			cef_text[0] = EOS, f(cef_text, 64, "Вы предложили %s взять вашу маску", getName(id));
			SendPlayerOfferNotify(playerid, 2, cef_text, "", "ОТМЕНИТЬ", 15);

			cef_text[0] = EOS, format(cef_text, 64, "%s предложил Вам взять его маску", getName(playerid));
			SendPlayerOfferNotify(id, 1, cef_text, "СОГЛАСИТЬСЯ", "ОТКАЗАТЬСЯ", 15);
		}
		case 9:
		{
			cef_text[0] = EOS, f(cef_text, 120, "Вы предложили %s купить транспорт '%s' за %d руб", getName(id), VehicleNames[CarInfo[PI[playerid][pLoadVehicleID]][cModel]-400], value);
			SendPlayerOfferNotify(playerid, 2, cef_text, "", "ОТМЕНИТЬ", 15);

			cef_text[0] = EOS, format(cef_text, 130, "%s предложил Вам купить транспорт '%s' за %d руб", getName(playerid), VehicleNames[CarInfo[PI[playerid][pLoadVehicleID]][cModel]-400], value);
			SendPlayerOfferNotify(id, 1, cef_text, "СОГЛАСИТЬСЯ", "ОТКАЗАТЬСЯ", 15);
		}
		case 10:
		{
			cef_text[0] = EOS, f(cef_text, 71, "Вы предложили %s пройти курс платного лечения.", getName(id));
			SendPlayerOfferNotify(playerid, 2, cef_text, "", "ОТМЕНИТЬ", 15);

			cef_text[0] = EOS, format(cef_text, 96, "Сотрудник БЦРБ %s предложил Вам пройти курс платного лечения за 750 руб.", getName(playerid));
			SendPlayerOfferNotify(id, 1, cef_text, "СОГЛАСИТЬСЯ", "ОТКАЗАТЬСЯ", 15);
		}
		case 11:
		{
			cef_text[0] = EOS, f(cef_text, 85, "Вы предложили %s сыграть в кости на %d рублей", getName(id), value);
			SendPlayerOfferNotify(playerid, 2, cef_text, "", "ОТМЕНИТЬ", 15);

			cef_text[0] = EOS, format(cef_text, 120, "%s предложил Вам сыграть в кости на %d рублей", getName(playerid), value);
			SendPlayerOfferNotify(id, 1, cef_text, "СОГЛАСИТЬСЯ", "ОТКАЗАТЬСЯ", 15);
		}
		case 12:
		{
			cef_text[0] = EOS, f(cef_text, 100, "Вы предложили выйти из тюрьмы игроку %s за %d рублей", PI[id][pName], value);
			SendPlayerOfferNotify(playerid, 2, cef_text, "", "ОТМЕНИТЬ", 15);

			cef_text[0] = EOS, format(cef_text, 110, "Адвокат %s предложил Вам выйти из тюрьмы за %d рублей.", getName(playerid), value);
			SendPlayerOfferNotify(id, 1, cef_text, "СОГЛАСИТЬСЯ", "ОТКАЗАТЬСЯ", 15);
		}
		case 13:
		{
			cef_text[0] = EOS, f(cef_text, 88, "Вы предложили купить водительские права игроку %s за 5000 рублей", PI[id][pName]);
			SendPlayerOfferNotify(playerid, 2, cef_text, "", "ОТМЕНИТЬ", 15);

			cef_text[0] = EOS, format(cef_text, 82, "%s предложил Вам купить водительские права за 5000 рублей.", getName(playerid));
			SendPlayerOfferNotify(id, 1, cef_text, "СОГЛАСИТЬСЯ", "ОТКАЗАТЬСЯ", 15);
		}
		case 14:
		{
			cef_text[0] = EOS, f(cef_text, 89, "Вы предложили купить лицензию на оружие игроку %s за 30000 рублей", PI[id][pName]);
			SendPlayerOfferNotify(playerid, 2, cef_text, "", "ОТМЕНИТЬ", 15);

			cef_text[0] = EOS, format(cef_text, 82, "%s предложил Вам купить лицензию на оружие за 30000 рублей.", getName(playerid));
			SendPlayerOfferNotify(id, 1, cef_text, "СОГЛАСИТЬСЯ", "ОТКАЗАТЬСЯ", 15);
		}
		case 15:
		{
			new gun_id = GetPlayerWeapon(playerid);

			cef_text[0] = EOS, f(cef_text, 89, "Вы предложили %s взять у Вас %s (%d пт)",PI[id][pName], weapon_names[gun_id], value);
			SendPlayerOfferNotify(playerid, 2, cef_text, "", "ОТМЕНИТЬ", 15);

			cef_text[0] = EOS, format(cef_text, 82, "%s предложил Вам взять у него %s (%d пт)", getName(playerid), weapon_names[gun_id], value);
			SendPlayerOfferNotify(id, 1, cef_text, "СОГЛАСИТЬСЯ", "ОТКАЗАТЬСЯ", 15);
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
stock SendR(playerid) return SCM(playerid, -1, "В разработке");