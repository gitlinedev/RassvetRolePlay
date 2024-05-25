enum kvDates {
	kvID,
	kvOwner_1[MAX_PLAYER_NAME],
	kvOwner_2[MAX_PLAYER_NAME],
	kvOwner_3[MAX_PLAYER_NAME],
	kvOwner_4[MAX_PLAYER_NAME],
	kvOwner_5[MAX_PLAYER_NAME],
	kvOwner_6[MAX_PLAYER_NAME],
	kvOwned[6],
	kvCost,
	kvClass,
	kvDays[6],
	kvLock[6],
	Float:kvExit_X,
	Float:kvExit_Y,
	Float:kvExit_Z,
	Float:kvExit_A,
	Float:kvEnterPosX[6],
	Float:kvEnterPosY[6],
	Float:kvEnterPosZ[6],
	Float:kvExotPosX[6],
	Float:kvExotPosY[6],
	Float:kvExotPosZ[6],
	Float:kvEnterX,
	Float:kvEnterY,
	Float:kvEnterZ,
	Float:kvExitX,
	Float:kvExitY,
	Float:kvExitZ,
	kvPickUPEnter,
	kvPickUPExit,
	kvPickUPEnterKV[6],
	kvPickUPExitKV[6],
	Text3D:kvInfo[6],
	Text3D:kvInfoEnter,
	Text3D:kvInfoExit,
	kvMapIcon
}
new kvData[MAX_KV][kvDates];
new TotalKV;
//
stock kv_OnDialogResponse(playerid, dialogid, response, listitem)
{
    switch(dialogid)
    {
        case 7217: 
		{
		    if(!response) return 1;
			if(response) 
			{
			    if(PI[playerid][pLevel] < 2) return SCM(playerid, COLOR_GREY, "Для преобретения имущества Вы должны иметь как минимум 2 уровень");
				for(new k = 0; k < TotalKV; k++) 
                {
			        new kv;
			        if(PlayerToPoint(3.0, playerid, kvData[kv][kvEnterPosX][k], kvData[kv][kvEnterPosY][k], kvData[kv][kvEnterPosZ][k])) 
                    {
			            if(PI[playerid][data_KV] != INVALID_KV_ID || PI[playerid][data_HOUSE] != INVALID_HOUSE_ID) return SCM(playerid, COLOR_GREY,"У Вас уже есть недвижимость");
			            if(kvData[kv][kvOwned][k] == 1) return SCM(playerid, COLOR_GREY,"У данной квартиры уже есть владелец");
						if(GetPlayerMoneyID(playerid) < kvData[kv][kvCost]) return SCM(playerid, COLOR_GREY,"У Вас недостаточно денег на руках");
						PI[playerid][data_PADIK] = kv;
						PI[playerid][data_KV] = k;
			            kvData[kv][kvOwned][k] = 1;
			            kvData[kv][kvDays][k] = 3;
			            switch(k) 
                        {
							case 0: strmid(kvData[kv][kvOwner_1], PI[playerid][pName], 0, strlen(PI[playerid][pName]), MAX_PLAYER_NAME);
							case 1: strmid(kvData[kv][kvOwner_2], PI[playerid][pName], 0, strlen(PI[playerid][pName]), MAX_PLAYER_NAME);
							case 2: strmid(kvData[kv][kvOwner_3], PI[playerid][pName], 0, strlen(PI[playerid][pName]), MAX_PLAYER_NAME);
							case 3: strmid(kvData[kv][kvOwner_4], PI[playerid][pName], 0, strlen(PI[playerid][pName]), MAX_PLAYER_NAME);
							case 4: strmid(kvData[kv][kvOwner_5], PI[playerid][pName], 0, strlen(PI[playerid][pName]), MAX_PLAYER_NAME);
							case 5: strmid(kvData[kv][kvOwner_6], PI[playerid][pName], 0, strlen(PI[playerid][pName]), MAX_PLAYER_NAME);
						}
			            GivePlayerMoneyLog(playerid,-kvData[kv][kvCost]);
			            SCM(playerid, 0xFFCC33FF, !"Поздравляем Вас с покупкой квартиры! Она была оплачена на 3 дня");
			            SCM(playerid, 0xFFCC33FF, !"Для управления квартирой используйте: /home");
			            SCM(playerid, 0x9F81F7FF, !"Используйте: /setspawn, чтобы изменить место появления");
			            UpdateKVData(kv,k);
			            SaveKVData(kv);
			           	return 1;
			        }
			    }
			    return 1;
			}
		}
        case 7216: 
		{
		    if(!response) return 1;
			if(response) 
			{
			    if(!IsPlayerLogged{playerid}) return 1;
			    if(PI[playerid][pLevel] < 2) return SCM(playerid, COLOR_GREY, !"Для преобретения имущества Вы должны иметь как минимум 2 уровень");
				for(new k = 0; k < TotalKV; k++) 
                {
			        new kv;
			        if(PlayerToPoint(3.0, playerid, kvData[kv][kvEnterPosX][k], kvData[kv][kvEnterPosY][k], kvData[kv][kvEnterPosZ][k])) 
                    {
			            if(PI[playerid][data_KV] != INVALID_KV_ID || PI[playerid][data_HOUSE] != INVALID_HOUSE_ID) return SCM(playerid, COLOR_GREY, !"У Вас уже есть недвижимость");
			            if(kvData[kv][kvOwned][k] == 1) return SCM(playerid, COLOR_GREY, !"У данной квартиры уже есть владелец");
						if(GetPlayerMoneyID(playerid) < kvData[kv][kvCost]) return SCM(playerid, COLOR_GREY, !"У Вас недостаточно денег на руках");
						PI[playerid][data_PADIK] = kv;
						PI[playerid][data_KV] = k;
			            kvData[kv][kvOwned][k] = 1;
			            kvData[kv][kvDays][k] = 3;
			            switch(k)
						{
							case 0: strmid(kvData[kv][kvOwner_1], PI[playerid][pName], 0, strlen(PI[playerid][pName]), MAX_PLAYER_NAME);
							case 1: strmid(kvData[kv][kvOwner_2], PI[playerid][pName], 0, strlen(PI[playerid][pName]), MAX_PLAYER_NAME);
							case 2: strmid(kvData[kv][kvOwner_3], PI[playerid][pName], 0, strlen(PI[playerid][pName]), MAX_PLAYER_NAME);
							case 3: strmid(kvData[kv][kvOwner_4], PI[playerid][pName], 0, strlen(PI[playerid][pName]), MAX_PLAYER_NAME);
							case 4: strmid(kvData[kv][kvOwner_5], PI[playerid][pName], 0, strlen(PI[playerid][pName]), MAX_PLAYER_NAME);
							case 5: strmid(kvData[kv][kvOwner_6], PI[playerid][pName], 0, strlen(PI[playerid][pName]), MAX_PLAYER_NAME);
						}
			            GivePlayerMoneyLog(playerid,-kvData[kv][kvCost]);
			            SCM(playerid,0xFFCC33FF, !"Поздравляем Вас с покупкой квартиры! Она была оплачена на 3 дня");
			            SCM(playerid,0xFFCC33FF, !"Для управления квартирой используйте: /home");
			            SCM(playerid, 0x9F81F7FF, !"Используйте: /setspawn, чтобы изменить место появления");
			            UpdateKVData(kv,k);
			            SaveKVData(kv);
			           	SavePlayerData(playerid);
			           	return 1;
			        }
			    }
			    return 1;
			}
		}
        case 4507: 
        {
			if(!response) return 1;
			if(response) 
            {
			    new kv = PI[playerid][data_PADIK];
				new k = PI[playerid][data_KV];
			    switch(listitem) 
                {
			        case 0: 
                    {
						new class_kv[10],status[18],color[8];
						switch(kvData[kv][kvClass]) 
                        {
							case 0: class_kv = "Хрущёвка";
							case 1: class_kv = "Простая";
							case 2: class_kv = "Элитный";
						}
						switch(kvData[kv][kvLock][k]) 
                        {
							case 0: status = "Квартира откыта";
							case 1: status = "Квартира закрыта";
						}
						switch(kvData[kv][kvLock][k]) 
                        {
							case 0: color = "45c068";
							case 1: color = "ee2121";
						}
						new owner[24];
						switch(k) 
                        {
							case 0: strmid(owner, kvData[kv][kvOwner_1], 0, strlen(kvData[kv][kvOwner_1]), MAX_PLAYER_NAME);
							case 1: strmid(owner, kvData[kv][kvOwner_2], 0, strlen(kvData[kv][kvOwner_2]), MAX_PLAYER_NAME);
							case 2: strmid(owner, kvData[kv][kvOwner_3], 0, strlen(kvData[kv][kvOwner_3]), MAX_PLAYER_NAME);
							case 3: strmid(owner, kvData[kv][kvOwner_4], 0, strlen(kvData[kv][kvOwner_4]), MAX_PLAYER_NAME);
							case 4: strmid(owner, kvData[kv][kvOwner_5], 0, strlen(kvData[kv][kvOwner_5]), MAX_PLAYER_NAME);
							case 5: strmid(owner, kvData[kv][kvOwner_6], 0, strlen(kvData[kv][kvOwner_6]), MAX_PLAYER_NAME);
						}
                        ShowPlayerDialogf(playerid, 0, DIALOG_STYLE_MSGBOX, !"{ee3366}Информация о квартире", !"Закрыть", !"", "\
                            {FFFFFF}Название:\t\t{3377cc}%s\n\
                            {FFFFFF}Номер квартиры:\t%d\n\
                            {FFFFFF}Номер подъезда:\t%d\n\
                            {FFFFFF}Владелец:\t\t%s\n\
                            {FFFFFF}Стоимость:\t\t%d руб\n\
                            {FFFFFF}Статус оплаты:\t\t%d дн\n\
                            {FFFFFF}Статус:\t\t\t{%s}%s",class_kv,k+1,kv+1,owner,kvData[kv][kvCost],kvData[kv][kvDays][k],color,status);
			        }
			        case 1: 
                    {
	 				    if(PlayerToPoint(3.0, playerid, kvData[kv][kvExotPosX][k], kvData[kv][kvExotPosY][k], kvData[kv][kvExotPosZ][k]) || PlayerToPoint(3.0, playerid, kvData[kv][kvEnterPosX][k], kvData[kv][kvEnterPosY][k], kvData[kv][kvEnterPosZ][k]))
						switch(kvData[kv][kvLock][k]) 
                        {
	        				case 0: kvData[kv][kvLock][k] = 1, cef_emit_event(playerid, "show-notify", CEFINT(2), CEFSTR("Вы закрыли свою квартиру"), CEFSTR("c13537"));
       						case 1: kvData[kv][kvLock][k] = 0, cef_emit_event(playerid, "show-notify", CEFINT(3), CEFSTR("Вы открыли свою квартиру"), CEFSTR("487f5f"));
				        }
				        else SCM(playerid, COLOR_GREY, !"Необходимо находиться возле выхода/входа");
			        }
			        case 2:
					{
			            ShowPlayerDialogf(playerid, 4506, DIALOG_STYLE_MSGBOX, !"{ee3366}Продажа квартиры", "Продать", "Отмена", "\
                            {FFFFFF}Вы желаете продать свою квартиру за {FFFF99}%d рублей{FFFFFF}?", kvData[kv][kvCost]/2);
			        }
			    }
			}
  		}
  		case 4506: 
		{
			if(!response) return 1;
			if(response) 
			{
		    	new kv = PI[playerid][data_PADIK];
				new k = PI[playerid][data_KV];
		      	kvData[kv][kvOwned][k] = 0;
		      	kvData[kv][kvDays][k] = 0;
		      	PI[playerid][data_KV] = INVALID_KV_ID;
		      	PI[playerid][data_PADIK] = INVALID_KV_ID;
		      	switch(k) 
                {
					case 0: strmid(kvData[kv][kvOwner_1], "None", 0, strlen(kvData[kv][kvOwner_1]), MAX_PLAYER_NAME);
					case 1: strmid(kvData[kv][kvOwner_2], "None", 0, strlen(kvData[kv][kvOwner_2]), MAX_PLAYER_NAME);
					case 2: strmid(kvData[kv][kvOwner_3], "None", 0, strlen(kvData[kv][kvOwner_3]), MAX_PLAYER_NAME);
					case 3: strmid(kvData[kv][kvOwner_4], "None", 0, strlen(kvData[kv][kvOwner_4]), MAX_PLAYER_NAME);
					case 4: strmid(kvData[kv][kvOwner_5], "None", 0, strlen(kvData[kv][kvOwner_5]), MAX_PLAYER_NAME);
					case 5: strmid(kvData[kv][kvOwner_6], "None", 0, strlen(kvData[kv][kvOwner_6]), MAX_PLAYER_NAME);
				}
				GivePlayerMoneyLog(playerid,kvData[kv][kvCost]/2);
			 	SCMf(playerid, 0xFFCC00AA, "Вы продали свою квартиру государству за %d рублей", kvData[kv][kvCost]/2);
				UpdateKVData(kv,k);
				SaveKVData(kv);
			  	SavePlayerData(playerid);
   			}
		}
    }
    return 1;
}
stock kv_OnPlayerPickUpDynamicPickup(playerid, pickupid)
{
    for(new kv = 0; kv < TotalKV; kv++) 
	{
		if(pickupid == kvData[kv][kvPickUPEnter])
		{
	        SetPVarInt(playerid, "padik", kv);
			SetPlayerPosAC(playerid, 36.0538,1923.8887,1113.7346);
			SetPlayerFacingAngle(playerid, 179.8331);
			SetPlayerInterior(playerid, 1);
			SetPlayerVirtualWorld(playerid, kvData[kv][kvID]);
			SetCameraBehindPlayer(playerid);
			FreezePlayer(playerid);
			SetTimerEx("UnfreezePlayer", 4000, false, "d", playerid);
		}
		if(pickupid == kvData[kv][kvPickUPExit]) 
		{
            SetPlayerPosAC(playerid, kvData[kv][kvExit_X], kvData[kv][kvExit_Y], kvData[kv][kvExit_Z]);
			SetPlayerFacingAngle(playerid, kvData[kv][kvExit_A]);
			SetPlayerInterior(playerid, 0);
			SetPlayerVirtualWorld(playerid, 0);
			SetCameraBehindPlayer(playerid);
			FreezePlayer(playerid);
			SetTimerEx("UnfreezePlayer", 4000, false, "d", playerid);
		}
	}
}
stock kv_OnPlayerKeyStateChange(playerid, newkeys, oldkeys) 
{
    if(PRESSED(KEY_WALK)) 
	{
        for(new k = 0; k < 6; k++)
		{
		    new kv = GetPVarInt(playerid, "padik");
		    if(PlayerToPoint(1.0, playerid, kvData[kv][kvEnterPosX][k], kvData[kv][kvEnterPosY][k], kvData[kv][kvEnterPosZ][k]) && GetPlayerVirtualWorld(playerid) == kvData[kv][kvID])
			{
			    if(kvData[kv][kvLock][k] == 1) return cef_emit_event(playerid, "show-center-notify", CEFINT(2), CEFSTR("Эта квартира закрыта"));
	            SetPlayerPosAC(playerid, kvData[kv][kvExotPosX][k], kvData[kv][kvExotPosY][k], kvData[kv][kvExotPosZ][k]);
				SetPlayerFacingAngle(playerid, 0.0);
				SetPlayerInterior(playerid, k+1);
				SetPlayerVirtualWorld(playerid, kvData[kv][kvID]+k);
				SetCameraBehindPlayer(playerid);
				FreezePlayer(playerid);
				SetTimerEx("UnfreezePlayer", 4000, false, "d", playerid);
	            return true;
			}
			else if(PlayerToPoint(1.0, playerid, kvData[kv][kvExotPosX][k], kvData[kv][kvExotPosY][k], kvData[kv][kvExotPosZ][k]) && GetPlayerVirtualWorld(playerid) == kvData[kv][kvID]+k)
			{
				SetPlayerPosAC(playerid, kvData[kv][kvEnterPosX][k], kvData[kv][kvEnterPosY][k], kvData[kv][kvEnterPosZ][k]);
				SetPlayerFacingAngle(playerid, 0.0);
				SetPlayerInterior(playerid, 1);
				SetPlayerVirtualWorld(playerid, kvData[kv][kvID]);
				SetCameraBehindPlayer(playerid);
				FreezePlayer(playerid);
				SetTimerEx("UnfreezePlayer", 4000, false, "d", playerid);
				return true;
			}
		}
    }
    return 1;
}
//======================================================================
CMD:home(playerid) 
{
    if(PI[playerid][data_HOUSE] == INVALID_HOUSE_ID && PI[playerid][data_KV] == INVALID_KV_ID) return SCM(playerid, COLOR_GREY, !"У Вас нет дома или квартиры");
	if(PI[playerid][data_HOUSE] != INVALID_HOUSE_ID) ShowPlayerDialog(playerid, dialog_HOUSE, DIALOG_STYLE_LIST, "{ee3366}Дом", "Информация\nОткрыть/закрыть дом\nПродать дом", "Выбрать", "Отмена");
	else ShowPlayerDialog(playerid, 4507, DIALOG_STYLE_LIST, "{ee3366}Квартира", "Информация\nОткрыть/закрыть квартиру\nПродать квартиру", "Выбрать", "Отмена");
	return 1;
}
CMD:buykv(playerid) 
{
	if(PI[playerid][pLevel] < 2) return SCM(playerid, COLOR_GREY, "Для преобретения имущества Вы должны иметь как минимум 2 уровень");
	for(new k = 0; k < TotalKV; k++)
    {
        new kv = GetPlayerVirtualWorld(playerid)-1;
        if(kv == -1) break;
        if(PlayerToPoint(3.0, playerid, kvData[kv][kvEnterPosX][k], kvData[kv][kvEnterPosY][k], kvData[kv][kvEnterPosZ][k]))
        {
            if(PI[playerid][data_KV] != INVALID_KV_ID || PI[playerid][data_HOUSE] != INVALID_HOUSE_ID) return SCM(playerid, COLOR_GREY, !"У Вас уже есть недвижимость");
            if(kvData[kv][kvOwned][k] == 1) return SCM(playerid, COLOR_GREY, !"У данной квартиры уже есть владелец");
			if(GetPlayerMoneyID(playerid) < kvData[kv][kvCost]) return SCM(playerid, COLOR_GREY, !"У Вас недостаточно денег на руках");
			PI[playerid][data_PADIK] = kv;
			PI[playerid][data_KV] = k;
            kvData[kv][kvOwned][k] = 1;
            kvData[kv][kvDays][k] = 3;
            switch(k)
			{
				case 0: strmid(kvData[kv][kvOwner_1], getName(playerid), 0, strlen(getName(playerid)), MAX_PLAYER_NAME);
				case 1: strmid(kvData[kv][kvOwner_2], getName(playerid), 0, strlen(getName(playerid)), MAX_PLAYER_NAME);
				case 2: strmid(kvData[kv][kvOwner_3], getName(playerid), 0, strlen(getName(playerid)), MAX_PLAYER_NAME);
				case 3: strmid(kvData[kv][kvOwner_4], getName(playerid), 0, strlen(getName(playerid)), MAX_PLAYER_NAME);
				case 4: strmid(kvData[kv][kvOwner_5], getName(playerid), 0, strlen(getName(playerid)), MAX_PLAYER_NAME);
				case 5: strmid(kvData[kv][kvOwner_6], getName(playerid), 0, strlen(getName(playerid)), MAX_PLAYER_NAME);
			}
            GivePlayerMoneyLog(playerid,-kvData[kv][kvCost]);
			SCM(playerid, COLOR_CORAL, !"Поздравляем! Вы купили дом");
			ShowPlayerDialog(playerid, 0, DIALOG_STYLE_MSGBOX, !"{ee3366}Покупка жилья", !"{FFFFFF}Для управления недвижимостью используйте команду /home\nОплата дома производится в банке (/gps 1 5). Не забудьте\nвовремя платить за него, в противном случае он будет опечатан!", "Закрыть", "");
            SaveKVData(kv);
			UpdateKVData(kv, k);
           	return true;
        }
    }
    return true;
}
stock SaveKVData(kv) 
{
	new str_q[512];
	new str_q2[512];
	str_q = "UPDATE `kvartiry` SET ";
	acc_str_strcat(str_q, sizeof(str_q), "owner1", kvData[kv][kvOwner_1]);
	acc_str_strcat(str_q, sizeof(str_q), "owner2", kvData[kv][kvOwner_2]);
	acc_str_strcat(str_q, sizeof(str_q), "owner3", kvData[kv][kvOwner_3]);
	acc_str_strcat(str_q, sizeof(str_q), "owner4", kvData[kv][kvOwner_4]);
	acc_str_strcat(str_q, sizeof(str_q), "owner5", kvData[kv][kvOwner_5]);
	acc_str_strcat(str_q, sizeof(str_q), "owner6", kvData[kv][kvOwner_6]);
	acc_int_strcat(str_q, sizeof(str_q), "owned1", kvData[kv][kvOwned][0]);
	acc_int_strcat(str_q, sizeof(str_q), "owned2", kvData[kv][kvOwned][1]);
	acc_int_strcat(str_q, sizeof(str_q), "owned3", kvData[kv][kvOwned][2]);
	acc_int_strcat(str_q, sizeof(str_q), "owned4", kvData[kv][kvOwned][3]);
	acc_int_strcat(str_q, sizeof(str_q), "owned5", kvData[kv][kvOwned][4]);
	acc_int_strcat(str_q, sizeof(str_q), "owned6", kvData[kv][kvOwned][5]);
	acc_int_strcat(str_q, sizeof(str_q), "lock1", kvData[kv][kvLock][0]);
	acc_int_strcat(str_q, sizeof(str_q), "lock2", kvData[kv][kvLock][1]);
	acc_int_strcat(str_q, sizeof(str_q), "lock3", kvData[kv][kvLock][2]);
	acc_int_strcat(str_q, sizeof(str_q), "lock4", kvData[kv][kvLock][3]);
	acc_int_strcat(str_q, sizeof(str_q), "lock5", kvData[kv][kvLock][4]);
	acc_int_strcat(str_q, sizeof(str_q), "lock6", kvData[kv][kvLock][5]);
	acc_int_strcat(str_q, sizeof(str_q), "day1", kvData[kv][kvDays][0]);
	acc_int_strcat(str_q, sizeof(str_q), "day2", kvData[kv][kvDays][1]);
	acc_int_strcat(str_q, sizeof(str_q), "day3", kvData[kv][kvDays][2]);
	acc_int_strcat(str_q, sizeof(str_q), "day4", kvData[kv][kvDays][3]);
	acc_int_strcat(str_q, sizeof(str_q), "day5", kvData[kv][kvDays][4]);
	acc_int_strcat(str_q, sizeof(str_q), "day6", kvData[kv][kvDays][5]);
	strdel(str_q, strlen(str_q)-1, strlen(str_q));
	format(str_q2,sizeof(str_q2)," WHERE `id` = '%d' LIMIT 1",kvData[kv][kvID]);
	strcat(str_q, str_q2);
	mysql_function_query(mysql, str_q, true, "", "");
	return 1;
}
stock UpdateKVData(kv, k) 
{
	DestroyDynamic3DTextLabel(kvData[kv][kvInfo][k]);
    new owner[MAX_PLAYER_NAME], class_kv[9],str[174];
	switch(k) 
    {
		case 0: strmid(owner, kvData[kv][kvOwner_1], 0, strlen(kvData[kv][kvOwner_1]), MAX_PLAYER_NAME);
		case 1: strmid(owner, kvData[kv][kvOwner_2], 0, strlen(kvData[kv][kvOwner_2]), MAX_PLAYER_NAME);
		case 2: strmid(owner, kvData[kv][kvOwner_3], 0, strlen(kvData[kv][kvOwner_3]), MAX_PLAYER_NAME);
		case 3: strmid(owner, kvData[kv][kvOwner_4], 0, strlen(kvData[kv][kvOwner_4]), MAX_PLAYER_NAME);
		case 4: strmid(owner, kvData[kv][kvOwner_5], 0, strlen(kvData[kv][kvOwner_5]), MAX_PLAYER_NAME);
		case 5: strmid(owner, kvData[kv][kvOwner_6], 0, strlen(kvData[kv][kvOwner_6]), MAX_PLAYER_NAME);
	}
	switch(kvData[kv][kvClass]) 
    {
	    case 0: class_kv = "Хрущёвка";
	    case 1: class_kv = "Простая";
	    case 2: class_kv = "Элитный";
	}
	if(kvData[kv][kvOwned][k] == 0) 
    {
        format(str,sizeof(str), "\
		{ffffff}Номер квартиры: {ffffff}№%d\n\
		{ffffff}Название: {ffffff}%s\n\
		{ffffff}Стоимость: {ffffff}%d рублей\n\
		{ffffff}Используйте: {3377cc}/buykv",k+1, class_kv, kvData[kv][kvCost]);
        kvData[kv][kvInfo][k] = CreateDynamic3DTextLabel(str, -1, kvData[kv][kvEnterPosX][k], kvData[kv][kvEnterPosY][k], kvData[kv][kvEnterPosZ][k], 5.0,INVALID_PLAYER_ID,INVALID_VEHICLE_ID,0,kvData[kv][kvID]);
    }
    else 
    {
		format(str,sizeof(str), "\
		{ffffff}Номер квартиры: {ffffff}№%d\n\
		{ffffff}Название: {FFFFFF}%s\n\
		{ffffff}Владелец: {3377cc}%s\n\
		Стоимость: {3377cc}%d руб",k+1, class_kv, owner, kvData[kv][kvCost]);
        kvData[kv][kvInfo][k] = CreateDynamic3DTextLabel(str, -1, kvData[kv][kvEnterPosX][k], kvData[kv][kvEnterPosY][k], kvData[kv][kvEnterPosZ][k], 5.0,INVALID_PLAYER_ID,INVALID_VEHICLE_ID,0,kvData[kv][kvID]);
	}
	new kk;
	for(new kq = 0; kq < 6; kq++) 
    {
		if(kvData[kv][kvOwned][kq] != 0) kk++;
		/*{}
		else kk++;*/
	}
	if(kk == 6) 
    {
	    DestroyDynamicMapIcon(kvData[kv][kvMapIcon]);
		kvData[kv][kvMapIcon] = CreateDynamicMapIcon(kvData[kv][kvEnterX], kvData[kv][kvEnterY], kvData[kv][kvEnterZ], 32, -1, 0, -1, -1, 100.0);
	}
	else 
    {
	    DestroyDynamicMapIcon(kvData[kv][kvMapIcon]);
		kvData[kv][kvMapIcon] = CreateDynamicMapIcon(kvData[kv][kvEnterX], kvData[kv][kvEnterY], kvData[kv][kvEnterZ], 31, -1, 0, -1, -1, 100.0);
	}
	return 1;
}
callback: LoadKV() 
{
    new rows, fields, temp[256], time = GetTickCount(), str[256], str1[64];
    cache_get_data(rows, fields);
	LoadedKV = cache_get_row_count(mysql);
    if(rows) 
	{
    	for(new kv = 0; kv < rows; kv++) 
		{
	        cache_get_field_content(kv, "id", temp), kvData[kv][kvID] = strval (temp);
         	cache_get_field_content(kv, "owner1", kvData[kv][kvOwner_1], mysql, MAX_PLAYER_NAME);
	        cache_get_field_content(kv, "owner2", kvData[kv][kvOwner_2], mysql, MAX_PLAYER_NAME);
	        cache_get_field_content(kv, "owner3", kvData[kv][kvOwner_3], mysql, MAX_PLAYER_NAME);
	        cache_get_field_content(kv, "owner4", kvData[kv][kvOwner_4], mysql, MAX_PLAYER_NAME);
	        cache_get_field_content(kv, "owner5", kvData[kv][kvOwner_5], mysql, MAX_PLAYER_NAME);
	        cache_get_field_content(kv, "owner6", kvData[kv][kvOwner_6], mysql, MAX_PLAYER_NAME);
            cache_get_field_content(kv, "owned1", temp), kvData[kv][kvOwned][0] = strval (temp);
	        cache_get_field_content(kv, "owned2", temp), kvData[kv][kvOwned][1] = strval (temp);
	        cache_get_field_content(kv, "owned3", temp), kvData[kv][kvOwned][2] = strval (temp);
	        cache_get_field_content(kv, "owned4", temp), kvData[kv][kvOwned][3] = strval (temp);
	        cache_get_field_content(kv, "owned5", temp), kvData[kv][kvOwned][4] = strval (temp);
	        cache_get_field_content(kv, "owned6", temp), kvData[kv][kvOwned][5] = strval (temp);
	        cache_get_field_content(kv, "Cost", temp), kvData[kv][kvCost] = strval (temp);
	        cache_get_field_content(kv, "lock1", temp), kvData[kv][kvLock][0] = strval (temp);
	        cache_get_field_content(kv, "lock2", temp), kvData[kv][kvLock][1] = strval (temp);
	        cache_get_field_content(kv, "lock3", temp), kvData[kv][kvLock][2] = strval (temp);
	        cache_get_field_content(kv, "lock4", temp), kvData[kv][kvLock][3] = strval (temp);
	        cache_get_field_content(kv, "lock5", temp), kvData[kv][kvLock][4] = strval (temp);
	        cache_get_field_content(kv, "lock6", temp), kvData[kv][kvLock][5] = strval (temp);
	        cache_get_field_content(kv, "day1", temp), kvData[kv][kvDays][0] = strval (temp);
	        cache_get_field_content(kv, "day2", temp), kvData[kv][kvDays][1] = strval (temp);
	        cache_get_field_content(kv, "day3", temp), kvData[kv][kvDays][2] = strval (temp);
	        cache_get_field_content(kv, "day4", temp), kvData[kv][kvDays][3] = strval (temp);
	        cache_get_field_content(kv, "day5", temp), kvData[kv][kvDays][4] = strval (temp);
	        cache_get_field_content(kv, "day6", temp), kvData[kv][kvDays][5] = strval (temp);
	        cache_get_field_content(kv, "Class", temp), kvData[kv][kvClass] = strval (temp);
	        cache_get_field_content(kv, "enter_x", temp), kvData[kv][kvEnterX] = floatstr (temp);
	        cache_get_field_content(kv, "enter_y", temp), kvData[kv][kvEnterY] = floatstr (temp);
	        cache_get_field_content(kv, "enter_z", temp), kvData[kv][kvEnterZ] = floatstr (temp);
	        cache_get_field_content(kv, "exit_x", temp), kvData[kv][kvExitX] = floatstr (temp);
	        cache_get_field_content(kv, "exit_y", temp), kvData[kv][kvExitY] = floatstr (temp);
	        cache_get_field_content(kv, "exit_z", temp), kvData[kv][kvExitZ] = floatstr (temp);
			// Вход в инт
            kvData[kv][kvEnterPosX][0] = 32.7846;
            kvData[kv][kvEnterPosY][0] = 1906.9014;
            kvData[kv][kvEnterPosZ][0] = 1116.1168;
            kvData[kv][kvEnterPosX][1] = 37.1719;
            kvData[kv][kvEnterPosY][1] = 1906.7296;
            kvData[kv][kvEnterPosZ][1] = 1116.1168;
            kvData[kv][kvEnterPosX][2] = 44.9090;
            kvData[kv][kvEnterPosY][2] = 1908.8892;
            kvData[kv][kvEnterPosZ][2] = 1116.1168;
            kvData[kv][kvEnterPosX][3] = 37.5377;
            kvData[kv][kvEnterPosY][3] = 1927.5522;
            kvData[kv][kvEnterPosZ][3] = 1120.9175;
            kvData[kv][kvEnterPosX][4] = 31.3240;
            kvData[kv][kvEnterPosY][4] = 1924.9763;
            kvData[kv][kvEnterPosZ][4] = 1120.9175;
            kvData[kv][kvEnterPosX][5] = 33.4195;
            kvData[kv][kvEnterPosY][5] = 1927.6848;
            kvData[kv][kvEnterPosZ][5] = 1120.9175;
            // Выход из инт
            kvData[kv][kvExotPosX][0] = 1113.1810;
            kvData[kv][kvExotPosY][0] = 1525.8893;
            kvData[kv][kvExotPosZ][0] = 905.8036;
            kvData[kv][kvExotPosX][1] = 1113.1810;
            kvData[kv][kvExotPosY][1] = 1525.8893;
            kvData[kv][kvExotPosZ][1] = 905.8036;
            kvData[kv][kvExotPosX][2] = 1113.1810;
            kvData[kv][kvExotPosY][2] = 1525.8893;
            kvData[kv][kvExotPosZ][2] = 905.8036;
            kvData[kv][kvExotPosX][3] = 1113.1810;
            kvData[kv][kvExotPosY][3] = 1525.8893;
            kvData[kv][kvExotPosZ][3] = 905.8036;
            kvData[kv][kvExotPosX][4] = 1113.1810;
            kvData[kv][kvExotPosY][4] = 1525.8893;
            kvData[kv][kvExotPosZ][4] = 905.8036;
            kvData[kv][kvExotPosX][5] = 1113.1810;
            kvData[kv][kvExotPosY][5] = 1525.8893;
            kvData[kv][kvExotPosZ][5] = 905.8036;
	        cache_get_field_content(kv, "ExitPos_X", temp), kvData[kv][kvExit_X] = floatstr (temp);
	        cache_get_field_content(kv, "ExitPos_Y", temp), kvData[kv][kvExit_Y] = floatstr (temp);
	        cache_get_field_content(kv, "ExitPos_Z", temp), kvData[kv][kvExit_Z] = floatstr (temp);
	        cache_get_field_content(kv, "ExitPos_A", temp), kvData[kv][kvExit_A] = floatstr (temp);
	        TotalKV++;
            kvData[kv][kvPickUPEnter] = CreateDynamicPickup(1272, 23, kvData[kv][kvEnterX], kvData[kv][kvEnterY], kvData[kv][kvEnterZ],0);
			kvData[kv][kvPickUPExit] = CreateDynamicPickup(1318, 23, 35.8316,1927.6235,1113.7346,kvData[kv][kvID]);
			format(str1,sizeof(str1), "{FFFFFF}Подъезд {ee3366}№%d\n{FFFFFF}Кол-во квартир: {ee3366}7",kv+1);
   			kvData[kv][kvInfoEnter] = CreateDynamic3DTextLabel(str1, -1, kvData[kv][kvEnterX], kvData[kv][kvEnterY], kvData[kv][kvEnterZ], 5.0,INVALID_PLAYER_ID,INVALID_VEHICLE_ID,0,0);
   			kvData[kv][kvInfoExit] = CreateDynamic3DTextLabel("{FFFFFF}Для выхода нажмите 'L.ALT'", -1, kvData[kv][kvExitX], kvData[kv][kvExitY], kvData[kv][kvExitZ], 5.0,INVALID_PLAYER_ID,INVALID_VEHICLE_ID,0,kvData[kv][kvID]);
			new owner[MAX_PLAYER_NAME], class_kv[9],kk;
			for(new k = 0; k < 6; k++) 
            {
				switch(k) 
                {
				    case 0: strmid(owner, kvData[kv][kvOwner_1], 0, strlen(kvData[kv][kvOwner_1]), MAX_PLAYER_NAME);
				    case 1: strmid(owner, kvData[kv][kvOwner_2], 0, strlen(kvData[kv][kvOwner_2]), MAX_PLAYER_NAME);
				    case 2: strmid(owner, kvData[kv][kvOwner_3], 0, strlen(kvData[kv][kvOwner_3]), MAX_PLAYER_NAME);
				    case 3: strmid(owner, kvData[kv][kvOwner_4], 0, strlen(kvData[kv][kvOwner_4]), MAX_PLAYER_NAME);
				    case 4: strmid(owner, kvData[kv][kvOwner_5], 0, strlen(kvData[kv][kvOwner_5]), MAX_PLAYER_NAME);
				    case 5: strmid(owner, kvData[kv][kvOwner_6], 0, strlen(kvData[kv][kvOwner_6]), MAX_PLAYER_NAME);
				}
				switch(kvData[kv][kvClass]) 
                {
				    case 0: class_kv = "Хрущёвка";
				    case 1: class_kv = "Простая";
				    case 2: class_kv = "Элитный";
				}
				kvData[kv][kvPickUPEnterKV][k] = CreateDynamicPickup(1277, 23, kvData[kv][kvEnterPosX][k], kvData[kv][kvEnterPosY][k], kvData[kv][kvEnterPosZ][k], kvData[kv][kvID]);
				kvData[kv][kvPickUPExitKV][k] = CreateDynamicPickup(1272, 23, kvData[kv][kvExotPosX][k], kvData[kv][kvExotPosY][k], kvData[kv][kvExotPosZ][k], kvData[kv][kvID]+k);
				if(kvData[kv][kvOwned][k] == 1) 
                {
			        kk++;
			        format(str,sizeof(str), "\
					{ffffff}Номер квартиры: {ffffff}№%d\n\
					{ffffff}Название: {FFFFFF}%s\n\
					{ffffff}Владелец: {3377cc}%s\n\
					Стоимость: {3377cc}%d руб",k+1, class_kv, owner, kvData[kv][kvCost]);
		 	        kvData[kv][kvInfo][k] = CreateDynamic3DTextLabel(str, -1, kvData[kv][kvEnterPosX][k], kvData[kv][kvEnterPosY][k], kvData[kv][kvEnterPosZ][k], 5.0,INVALID_PLAYER_ID,INVALID_VEHICLE_ID,0,kvData[kv][kvID]);
			    }
			    else 
                {
                    format(str,sizeof(str), "\
					{ffffff}Номер квартиры: {ffffff}№%d\n\
					{ffffff}Название: {ffffff}%s\n\
					{ffffff}Стоимость: {ffffff}%d рублей\n\
					{ffffff}Используйте: {3377cc}/buykv",k+1, class_kv, kvData[kv][kvCost]);
		 	        kvData[kv][kvInfo][k] = CreateDynamic3DTextLabel(str, -1, kvData[kv][kvEnterPosX][k], kvData[kv][kvEnterPosY][k], kvData[kv][kvEnterPosZ][k], 5.0,INVALID_PLAYER_ID,INVALID_VEHICLE_ID,0,kvData[kv][kvID]);
			    }
			}
			if(kk == 6) kvData[kv][kvMapIcon] = CreateDynamicMapIcon(kvData[kv][kvEnterX], kvData[kv][kvEnterY], kvData[kv][kvEnterZ], 32, -1, 0, -1, -1, 100.0);
			else kvData[kv][kvMapIcon] = CreateDynamicMapIcon(kvData[kv][kvEnterX], kvData[kv][kvEnterY], kvData[kv][kvEnterZ], 31, -1, 0, -1, -1, 100.0);
        }
        if(console_Debbug == 1) printf("[INFO]  Load kvartiry. Load: %d b. Time: %d ms.",TotalKV,GetTickCount()-time);
  	}
    return 1;
}
//=========================================================================
CMD:addkv(playerid) 
{
    if(CheckAdmin(playerid, 8)) return 1;
	ShowPlayerDialog(playerid, 3988, DIALOG_STYLE_MSGBOX, !"{ee3366}Добавление подъезда", !"{FFFFFF}Вы желаете добавить подъезд?", !"Да", !"Отмена");
	return 1;
}
CMD:tpplayer(playerid) 
{
    if(CheckAdmin(playerid, 8)) return 1;
	if(GetPVarInt(playerid, "AddKV") == 0 && GetPVarInt(playerid, "addhouse") == 0) return SCM(playerid, COLOR_GREY, !"Вы не начали добавлять подъезд / дом");
	new Float:x, Float:y, Float:z, Float:a;
    GetPlayerPos(playerid, x, y, z);
    GetPlayerFacingAngle(playerid, a);
  	SetPVarFloat(playerid, "ExitTPX", x);
  	SetPVarFloat(playerid, "ExitTPY", y);
  	SetPVarFloat(playerid, "ExitTPZ", z);
  	SetPVarFloat(playerid, "ExitTPA", a);
  	SCM(playerid, COLOR_YELLOW, !"Встаньте на место, где будет находиться подъезд и введите (/tpkv)");
	return 1;
}
CMD:tpkv(playerid) 
{
    if(CheckAdmin(playerid, 8)) return 1;
	if(GetPVarInt(playerid, "addkv") == 0) return SCM(playerid, COLOR_GREY, !"Вы не начали добавлять подъезд");
	new Float:x, Float:y, Float:z;
	GetPlayerPos(playerid, x, y, z);
	SetPVarFloat(playerid,"aEnterX",x);
	SetPVarFloat(playerid,"aEnterY",y);
	SetPVarFloat(playerid,"aEnterZ",z);
	return AddKV(playerid);
}
stock AddKV(playerid) 
{
    new Float:EnterX = GetPVarFloat(playerid, "aEnterX");
    new Float:EnterY = GetPVarFloat(playerid, "aEnterY");
    new Float:EnterZ = GetPVarFloat(playerid, "aEnterZ");

    new Float:ExitX = GetPVarFloat(playerid, "ExitTPX");
    new Float:ExitY = GetPVarFloat(playerid, "ExitTPY");
    new Float:ExitZ = GetPVarFloat(playerid, "ExitTPZ");
    new Float:ExitA = GetPVarFloat(playerid, "ExitTPA");

	mysql_tqueryf(mysql, "\
        INSERT INTO `kvartiry` ( `enter_x`, `enter_y`, `enter_z`, `ExitPos_X`, `ExitPos_Y`, `ExitPos_Z`, `ExitPos_A`)\
            VALUES\
        ( '%f', '%f', '%f', '%f', '%f', '%f', '%f')", EnterX, EnterY, EnterZ, ExitX, ExitY, ExitZ, ExitA);

    CreateDynamicMapIcon(GetPVarFloat(playerid, "aEnterX"), GetPVarFloat(playerid, "aEnterY"), GetPVarFloat(playerid, "aEnterZ"), 31, -1, 0, -1, -1, 100.0);
    CreateDynamicPickup(1273, 23, GetPVarFloat(playerid, "aEnterX"), GetPVarFloat(playerid, "aEnterY"), GetPVarFloat(playerid, "aEnterZ"),-1);
	return 1;
}