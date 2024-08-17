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

				CEF_ShowPlayerDialog(playerid, 0, DIALOG_STYLE_MSGBOX, "{ee3366}Паспорт", global_str, "Закрыть", "");

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
		default: 
		{
			ClearRequest(PI[playerid][pRequestFor]);
			ClearRequest(playerid);
		}
	}
	return 1;
}
stock SendR(playerid) return SCM(playerid, -1, !"В разработке");