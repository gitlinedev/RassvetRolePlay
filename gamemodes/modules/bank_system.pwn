new transfer_log[512];
//=======================================================================================
stock ShowBankMoney(playerid) 
{
	ShowPlayerDialogf(playerid, 2345, DIALOG_STYLE_MSGBOX, !"{ee3366}������ �����", !"�������", !"�����", "\
    {FFFFFF}�� ����� ���������� �����: {33dd66}%d ������", PI[playerid][pBank]);
	return 1;
}
stock ShowTransferBankMoney(playerid)
{
    ShowPlayerDialog(playerid, 7969, DIALOG_STYLE_INPUT, !"{ee3366}������� �� ������ ����", !"\
    {FFFFFF}������� ����� ����������� ����� � ����� ��������\n\
    ����� �������. �������� ��� �������� �������� {3377cc}2%\n\n\
    {FFFF99}������ ����� ��� ��������: 1000, 25000\n\n\
    {696969}����������: ����� ����� - ��� ���������� �����\n\
    ���������� �����. �� ������� ��� � ID ������", !"�����", !"�����");
    return 1;
}
stock ShowTransferBankomatMoney(playerid)
{
    ShowPlayerDialog(playerid, 7969, DIALOG_STYLE_INPUT, !"{ee3366}������� �� ������ ����", !"\
    {FFFFFF}������� ����� ����������� ����� � ����� ��������\n\
    ����� �������. �������� ��� �������� �������� {3377cc}2%\n\n\
    {FFFF99}������ ����� ��� ��������: 1000, 25000\n\n\
    {696969}����������: ����� ����� - ��� ���������� �����\n\
    ���������� �����. �� ������� ��� � ID ������", !"�����", !"�����");
    return 1;
}
stock bank_OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
    switch(dialogid)
    {
        case 2345:
        {
            if(!response) return callcmd::bank(playerid);
		    if(response) return 1;
        }
        case 7999: 
		{
		    if(!response) return 1;
		    if(response) 
			{
			    switch(listitem) 
				{
      				case 0: ShowPlayerDialog(playerid, 7998, DIALOG_STYLE_LIST, !"{ee3366}���������� �����", !"\
                    1. ������ ������� �� �����\n\
                    2. ���������� �����\n\
                    3. ������ ������ �����\n\
                    4. ��������� 20 ��������\n\
                    5. ������� �� ������ ����\n\
                    6. ��������� ���� ��������\n\
                    7. ������ �������  �� �����  ������� / ���\n\
                    8. ���������� �����  ������� / ���\n\
                    9. ������ �������", "�����", "�������");

      				case 1: ShowPlayerDialog(playerid, 7997, DIALOG_STYLE_LIST, "{ee3366}������ ������", "\
                    1. �������� ��� / ��������\n\
                    2. �������� ������ / ���", "�����", "�������");

      				case 3: SCM(playerid, COLOR_YELLOW, !"����������. �������� ���� �� {921dd1}"NAMESERVER"");
			    }
			}
		}
        case 8997: 
		{
            if(!response) return 1;
			if(response) 
			{
			    switch(listitem)
				{
			        case 0: 
					{
					    if(PI[playerid][pHouse] == INVALID_HOUSE_ID && PI[playerid][pFloat] == INVALID_KV_ID) return SCM(playerid, COLOR_GREY, !"� ��� ��� ���� ��� ��������");
						if(PI[playerid][pHouse] != INVALID_HOUSE_ID) 
						{
							new h = PI[playerid][pHouse];
						 	ShowPlayerDialogf(playerid, 7950, DIALOG_STYLE_INPUT, "{ee3366}������ �����", "���������", "�����", "\
							{FFFFFF}����� ����: %d\n\
							{FFFFFF}������ ������: %d / 30 ����\n\
							{FFFF99}���������� - 1499 ��� / ����\n\n\
							{FFFFFF}������� ���������� ���� ��� ������", HOUSE_DATA[h][data_ID], HOUSE_DATA[h][data_DAY]);
				        }
				        else if(PI[playerid][pFloat] != INVALID_KV_ID) 
						{
							new kv = PI[playerid][data_PADIK],k = PI[playerid][pFloat];
						 	ShowPlayerDialogf(playerid, 7951, DIALOG_STYLE_INPUT, "{ee3366}������ �����", "���������", "�����","\
							{FFFFFF}����� ��������: %d\n\
							{FFFFFF}������ ������: %d / 30 ��\n\
							{FFFF99}���������� - 1299 ��� / ����\n\n\
							{FFFFFF}������� ���������� ���� ��� ������", kvData[kv][kvID], kvData[kv][kvDays][k]);
				        }
					}
					case 1: 
					{
					    if(PI[playerid][pBusiness] == INVALID_BUSINESS_ID) return SCM(playerid, COLOR_GREY,"� ��� ��� ������� ��� ���");
						new b = GetBusinessIndexByID(PI[playerid][pBusiness]);
						ShowPlayerDialogf(playerid, 7952, DIALOG_STYLE_INPUT, "{ee3366}������ �������", "���������", "�����","\
						{FFFFFF}����� �������: %d\n\
						{FFFFFF}������ ������: %d / 30 ����\n\
						{FFFF99}����� - 3999 ������\n\n\
						{FFFFFF}������� ���������� ���� ��� ������", BizInfo[b][bID], BizInfo[b][bDays]);
					}
				}
			}
        }
        case 8998: 
		{
            if(!response) return 1;
			if(response) 
			{
			    switch(listitem) 
				{
			        case 0: ShowBankMoney(playerid);
			        case 1: ShowPlayerDialog(playerid, 7367, DIALOG_STYLE_INPUT, "{ee3366}������ ��������", "{FFFFFF}�������� �������� {3377cc}4%\n{FFFFFF}������� ��������� �����", "�����", "�����");
			        case 2: ShowPlayerDialog(playerid, 7368, DIALOG_STYLE_INPUT, "{ee3366}���������� �����", "{FFFFFF}������� ������ �����:\t", "���������", "�����");
			        case 3: ShowTransferBankomatMoney(playerid);
			        case 4: ShowPlayerDialog(playerid, 9001, DIALOG_STYLE_LIST, "{ee3366}���������� ��������", "1. 100 ���\n2. 500 ���\n3. 3000 ���\n4. 5000 ���\n5. 10000 ���", "���������", "�����");
				}
			}
        }
        case 7367:
        {
            if(!response) return callcmd::bank(playerid);
			if(response) 
			{
			    if(strval(inputtext) <= 0) return ShowPlayerDialog(playerid, 7967, DIALOG_STYLE_INPUT, "{ee3366}������ ��������", "�������� �������� {3377cc}4%\n{FFFFFF}������� ��������� �����", "�����", "�����");
			    new Sum = strval(inputtext)+strval(inputtext)/100*4;
                if(Sum > PI[playerid][pBank]) return SCMf(playerid, COLOR_GREY, "C ������ ������� ��������� {FF6347}%d ���", strval(inputtext)+strval(inputtext)/100*2);
			    
                new OldBank = PI[playerid][pBank];

				PI[playerid][pBank] -= Sum;
				GivePlayerMoneyLog(playerid, strval(inputtext));
                UpdatePlayerDataInt(playerid, "bank", PI[playerid][pBank]);

				new money[25];
				format(money, sizeof money, "+%dP", strval(inputtext));
				cef_emit_event(playerid, "show-notify-no-img", CEFSTR("������ ����� �� �����  � �����"), CEFSTR("4ea650"), CEFSTR(money));

				ShowPlayerDialogf(playerid, 2345, DIALOG_STYLE_MSGBOX, !"{ee3366}�������� ���������", !"�������", !"�����", "\
					{FFFFFF}������ ������: {ff6633}%d ���\n\
					{FFFFFF}����� ������: {3366cc}%d ���\n\
					{FFFFFF}��������: {ff6633}%d ���\n\
					{FFFFFF}�����: {3366cc}%d ���", OldBank, PI[playerid][pBank], strval(inputtext)/100*2, strval(inputtext));
                
                transfer_log[0] = EOS, f(transfer_log, 57, "- ������ %d ��� (�������� 2%%: %d ���)", strval(inputtext), strval(inputtext)/100*2);
                TransferBank_log(playerid, strval(inputtext), transfer_log);
			}
        }
        case 7368:
        {
            if(!response) return callcmd::bank(playerid);
			if(response) 
            {
			    if(strval(inputtext) <= 0) return ShowPlayerDialog(playerid, 7968, DIALOG_STYLE_INPUT, "{ee3366}���������� �����", "{FFFFFF}������� ������ �����:", "�����", "�������");
			    if(strval(inputtext) > GetPlayerMoneyID(playerid)) return SCM(playerid, COLOR_GREY, !"� ��� ������������ ����� �� �����");
				
                new OldBank = PI[playerid][pBank];

				PI[playerid][pBank] += strval(inputtext);
				GivePlayerMoneyLog(playerid,-strval(inputtext));
                UpdatePlayerDataInt(playerid, "bank", PI[playerid][pBank]);

				new money[25];
				format(money, sizeof money, "-%dP", strval(inputtext));
				cef_emit_event(playerid, "show-notify-no-img", CEFSTR("��������� ����� � �����"), CEFSTR("ed3245"), CEFSTR(money));

				ShowPlayerDialogf(playerid, 2345, DIALOG_STYLE_MSGBOX, !"{ee3366}�������� ���������", !"�������", !"�����", "\
					{FFFFFF}������ ������: {ff6633}%d ���\n\
					{FFFFFF}����� ������: {3366cc}%d ���\n\
					{FFFFFF}���������: {3366cc}%d ���", OldBank, PI[playerid][pBank], strval(inputtext));
                
                transfer_log[0] = EOS, f(transfer_log, 40, "+ ���������� %d ���", strval(inputtext));
                TransferBank_log(playerid, strval(inputtext), transfer_log);
			}
        }
        case 8999: 
		{
		    if(!response) return 1;
		    if(response) 
			{
			    switch(listitem) 
				{
      				case 0: ShowPlayerDialog(playerid, 8998, DIALOG_STYLE_LIST, "{ee3366}��������", "1. ������ ������ �����\n2. ����� ������ �� �����\n3. ��������� ����\n4. ��������� ������ �� ������ ����\n5. �������� ������ �� ���� ��������", "�������", "������");
      				case 1: ShowPlayerDialog(playerid, 8997, DIALOG_STYLE_LIST, "{ee3366}������ ������", "1. �������� ��� / ��������\n2. �������� ������ / ���", "�������", "������");
      				case 3: SCM(playerid, COLOR_YELLOW, !"����������. �������� ���� �� {921dd1}"NAMESERVER"");
			    }
			}
		}
        case 7998: 
        {
            if(!response) return 1;
			if(response) 
            {
			    switch(listitem) 
                {
			        case 0: ShowPlayerDialog(playerid, 7967, DIALOG_STYLE_INPUT, "{ee3366}������ ��������", "{FFFFFF}�������� �������� {3377cc}2%\n{FFFFFF}������� ��������� �����", "�����", "�����");
			        case 1: ShowPlayerDialog(playerid, 7968, DIALOG_STYLE_INPUT, "{ee3366}���������� �����", "{FFFFFF}������� ������ �����:\t", "���������", "�����");
                    case 2: ShowBankMoney(playerid);
                    case 3: ShowLastTransferLog(playerid, 20);
                    case 4: ShowTransferBankMoney(playerid);
			        case 5: ShowPlayerDialog(playerid, 9001, DIALOG_STYLE_LIST, "{ee3366}���������� ��������", "1. 100 ���\n2. 500 ���\n3. 3000 ���\n4. 5000 ���\n5. 10000 ���", "���������", "�����");
					case 6:BusinessGiveMoney(playerid);
					case 7:Business_Re_Money(playerid);
                    case 8: return 1;
				}
			}
        }
        case 7967:
        {
            if(!response) return callcmd::bank(playerid);
			if(response) 
			{
			    if(strval(inputtext) <= 0) return ShowPlayerDialog(playerid, 7967, DIALOG_STYLE_INPUT, "{ee3366}������ ��������", "�������� �������� {3377cc}2%\n{FFFFFF}������� ��������� �����", "�����", "�����");
			    new Sum = strval(inputtext)+strval(inputtext)/100*2;
                if(Sum > PI[playerid][pBank]) return SCMf(playerid, COLOR_GREY, "C ������ ������� ��������� {FF6347}%d ���", strval(inputtext)+strval(inputtext)/100*2);
			    
                new OldBank = PI[playerid][pBank];

				PI[playerid][pBank] -= Sum;
				GivePlayerMoneyLog(playerid, strval(inputtext));
                UpdatePlayerDataInt(playerid, "bank", PI[playerid][pBank]);

				new money[25];
				format(money, sizeof money, "+%dP", strval(inputtext));
				cef_emit_event(playerid, "show-notify-no-img", CEFSTR("������ ����� �� �����  � �����"), CEFSTR("4ea650"), CEFSTR(money));

				ShowPlayerDialogf(playerid, 2345, DIALOG_STYLE_MSGBOX, !"{ee3366}�������� ���������", !"�������", !"�����", "\
					{FFFFFF}������ ������: {ff6633}%d ���\n\
					{FFFFFF}����� ������: {3366cc}%d ���\n\
					{FFFFFF}��������: {ff6633}%d ���\n\
					{FFFFFF}�����: {3366cc}%d ���", OldBank, PI[playerid][pBank], strval(inputtext)/100*2, strval(inputtext));
                
                transfer_log[0] = EOS, f(transfer_log, 57, "- ������ %d ��� (�������� 2%%: %d ���)", strval(inputtext), strval(inputtext)/100*2);
                TransferBank_log(playerid, strval(inputtext), transfer_log);
			}
        }
        case 7968:
        {
            if(!response) return callcmd::bank(playerid);
			if(response) 
            {
			    if(strval(inputtext) <= 0) return ShowPlayerDialog(playerid, 7968, DIALOG_STYLE_INPUT, "{ee3366}���������� �����", "{FFFFFF}������� ������ �����:", "�����", "�������");
			    if(strval(inputtext) > GetPlayerMoneyID(playerid)) return SCM(playerid, COLOR_GREY, !"� ��� ������������ ����� �� �����");
				
                new OldBank = PI[playerid][pBank];

				PI[playerid][pBank] += strval(inputtext);
				GivePlayerMoneyLog(playerid,-strval(inputtext));
                UpdatePlayerDataInt(playerid, "bank", PI[playerid][pBank]);

				new money[25];
				format(money, sizeof money, "-%dP", strval(inputtext));
				cef_emit_event(playerid, "show-notify-no-img", CEFSTR("��������� ����� � �����"), CEFSTR("ed3245"), CEFSTR(money));

				ShowPlayerDialogf(playerid, 2345, DIALOG_STYLE_MSGBOX, !"{ee3366}�������� ���������", !"�������", !"�����", "\
					{FFFFFF}������ ������: {ff6633}%d ���\n\
					{FFFFFF}����� ������: {3366cc}%d ���\n\
					{FFFFFF}���������: {3366cc}%d ���", OldBank, PI[playerid][pBank], strval(inputtext));
                
                transfer_log[0] = EOS, f(transfer_log, 40, "+ ���������� %d ���", strval(inputtext));
                TransferBank_log(playerid, strval(inputtext), transfer_log);
			}
        }
        case 7969:
        {
            if(!response) return callcmd::bank(playerid);
			if(response)
            {
                new BankID, Cash;
				sscanf(inputtext, "p<,>dd", BankID, Cash);

                if(Cash < 100) return SCM(playerid, COLOR_GREY, !"����������� ����� ��� �������� {ff6633}100 ������"), ShowTransferBankMoney(playerid);
				if(Cash+Cash/100*2 > PI[playerid][pBank]) return SCM(playerid, COLOR_GREY, !"� ��� ������������ �������"), ShowTransferBankMoney(playerid);
				if(BankID == PI[playerid][pID]) return SCM(playerid, COLOR_GREY, !"�� �� ������ ��������� ������ �� ���� ����"), ShowTransferBankMoney(playerid);
				if(Cash > 500000) return SCM(playerid, COLOR_GREY, !"�� �� ������ ��������� ����� 500000 ������ �� ������ ����"), ShowTransferBankMoney(playerid);
    			//if(PI[playerid][pBankTransfer] > gettime()) return SCM(playerid, COLOR_GREY, !"������� � ����� �������� ��� � ���");

                new Cache: result, query[47];
                mysql_format(mysql, query, sizeof query, "SELECT `Name` FROM accounts WHERE id='%d'", BankID);
                result = mysql_query(mysql, query, true);

                if(cache_num_rows() > 0) cache_get_field_content(0, "Name", PI[playerid][pTempBankName], mysql, MAX_PLAYER_NAME);
                else 
                {
                    SCM(playerid, COLOR_GREY, !"������ ����� ����������� ����� �� ������");
					return ShowTransferBankMoney(playerid);
                }
                cache_delete(result);

                ShowPlayerDialogf(playerid, 7970, DIALOG_STYLE_MSGBOX, !"{ee3366}������� �� ������ ���� (�������������)", !"�����", !"�����", "\
                {FFFFFF}�����������: %s (���� �%d)\n\
                ����������: {33dd66}%s (���� �%d)\n\
                {FFFFFF}�����: %d ���\n\
                ��������: %d ���\n\
                ������� �����: %d ���\n\n\
                {FFFF99}����������, ����������� ����������.\n\
                ����� �������� �� �� ������� �������� �.\n\n\
                {696969}��� ��� ����������: ����� ����� - �� ID ������", getName(playerid), PI[playerid][pID],
                                                                    PI[playerid][pTempBankName], BankID,
                                                                    Cash, Cash/100*2, PI[playerid][pBank]-Cash);

                PI[playerid][pTempBankID] = BankID;
                PI[playerid][pTempBankCash] = Cash;
				return 1;
			}
        }
        case 7970:
        {
            if(!response) 
            {
                PI[playerid][pTempBankID] = INVALID_PLAYER_ID;
                PI[playerid][pTempBankCash] = -1;
                callcmd::bank(playerid);
                return 1;
            }
            if(response)
            {
                new id = INVALID_PLAYER_ID, Commission = PI[playerid][pTempBankCash]/100*2;

                if(PI[playerid][pTempBankCash]+Commission > PI[playerid][pBank])
                {
                    PI[playerid][pTempBankID] = INVALID_PLAYER_ID;
                    PI[playerid][pTempBankCash] = -1;
                    return SCMf(playerid, COLOR_GREY, "� ��� ������������ ������� �� ���������� �����, ��� �������� ��������� {ff6633}%d ������ (� ���������)", PI[playerid][pTempBankCash]+Commission);
                }
                foreach(Player, i)
                {
                    if(IsPlayerConnected(i))
                    {
                        new szName[24];
                        GetPlayerName(i, szName, sizeof(szName));
                        if(!strcmp(PI[playerid][pTempBankName], szName, false))
                        {
                            id = i;
                            break;
                        }
                    }
                }
                if(id == INVALID_PLAYER_ID)
                {
                    mysql_queryf(mysql, "UPDATE `accounts` SET `bank`=`bank`+%d WHERE id = '%d'", false, PI[playerid][pTempBankCash], PI[playerid][pTempBankID]);
                }
                else
                {
                    PI[id][pBank] += PI[playerid][pTempBankCash];
                    UpdatePlayerDataInt(id, "bank", PI[id][pBank]);
				    SendClientMessagef(id, 0x62d44dFF, "[����] %s ������ �� ��� ���� {FFFF99}%d ������{62d44d}, ������ �����: {FFFF99}%d ������", getName(playerid), PI[playerid][pTempBankCash], PI[id][pBank]);
                }
                PI[playerid][pBank] -= PI[playerid][pTempBankCash]+Commission;
                UpdatePlayerDataInt(playerid, "bank", PI[playerid][pBank]);

                transfer_log[0] = EOS, f(transfer_log, 84, "- ������� %d ��� �� ���� �%d (�������� 2%%: %d ���)", PI[playerid][pTempBankCash], PI[playerid][pTempBankID], Commission);
                TransferBank_log(playerid, PI[playerid][pTempBankCash], transfer_log);
                transfer_log[0] = EOS, f(transfer_log, 37, "+ ������� %d ��� �� ����� �%d", PI[playerid][pTempBankCash], PI[playerid][pID]);
                TransferBank_log(playerid, PI[playerid][pTempBankCash], transfer_log, PI[playerid][pTempBankID]);

                ShowPlayerDialogf(playerid, 2345, DIALOG_STYLE_MSGBOX, !"{ee3366}������� ��������", !"�������", !"�����", "\
                {FFFFFF}�� �����:\t\t�%d\n\
                �� ����:\t\t�%d\n\
                �����:\t\t%d ���\n\
                ��������:\t\t%d ���\n\
                ������� �����:\t%d ���", PI[playerid][pID], PI[playerid][pTempBankID], PI[playerid][pTempBankCash], Commission, PI[playerid][pBank]);

                PI[playerid][pTempBankID] = INVALID_PLAYER_ID;
                PI[playerid][pTempBankCash] = -1;
            }
        }
        case 9001: 
		{
            if(!response) return 1;
			if(response) 
			{
                if(PI[playerid][pPhone] == 0) return SCM(playerid, COLOR_GREY, !"� ��� ��� ��������");

                new OldNumberMoney = PI[playerid][pNumberMoney];

                switch(listitem)
                {
                    case 0:
                    {
                        if(100 > PI[playerid][pBank]) return SCM(playerid, COLOR_GREY, !"� ��� ������������ ����� �� ���������� �����");
                        PI[playerid][pBank] -= 100;
                        PI[playerid][pNumberMoney] += 100;
                        UpdatePlayerDataInt(playerid, "bank", PI[playerid][pBank]);
                        UpdatePlayerDataInt(playerid, "number_m", PI[playerid][pNumberMoney]);
                    }
                    case 1:
                    {
                        if(500 > PI[playerid][pBank]) return SCM(playerid, COLOR_GREY, !"� ��� ������������ ����� �� ���������� �����");
                        PI[playerid][pBank] -= 500;
                        PI[playerid][pNumberMoney] += 500;
                        UpdatePlayerDataInt(playerid, "bank", PI[playerid][pBank]);
                        UpdatePlayerDataInt(playerid, "number_m", PI[playerid][pNumberMoney]);
                    }
                    case 2:
                    {
                        if(3000 > PI[playerid][pBank]) return SCM(playerid, COLOR_GREY, !"� ��� ������������ ����� �� ���������� �����");
                        PI[playerid][pBank] -= 3000;
                        PI[playerid][pNumberMoney] += 3000;
                        UpdatePlayerDataInt(playerid, "bank", PI[playerid][pBank]);
                        UpdatePlayerDataInt(playerid, "number_m", PI[playerid][pNumberMoney]);
                    }
                    case 3:
                    {
                        if(5000 > PI[playerid][pBank]) return SCM(playerid, COLOR_GREY, !"� ��� ������������ ����� �� ���������� �����");
                        PI[playerid][pBank] -= 5000;
                        PI[playerid][pNumberMoney] += 5000;
                        UpdatePlayerDataInt(playerid, "bank", PI[playerid][pBank]);
                        UpdatePlayerDataInt(playerid, "number_m", PI[playerid][pNumberMoney]);
                    }
                    case 4:
                    {
                        if(10000 > PI[playerid][pBank]) return SCM(playerid, COLOR_GREY, !"� ��� ������������ ����� �� ���������� �����");
                        PI[playerid][pBank] -= 10000;
                        PI[playerid][pNumberMoney] += 10000;
                        UpdatePlayerDataInt(playerid, "bank", PI[playerid][pBank]);
                        UpdatePlayerDataInt(playerid, "number_m", PI[playerid][pNumberMoney]);
                    }
                }
                ShowPlayerDialogf(playerid, 2345, DIALOG_STYLE_MSGBOX, !"{ee3366}�������� ���������", !"�������", !"�����", "\
                    {FFFFFF}������ ������ ��������: {ff6633}%d\n\
                    {FFFFFF}����� ������ ��������: {3366cc}%d\n\
                    {FFFFFF}���������: {3366cc}100 ���", OldNumberMoney, PI[playerid][pNumberMoney]);
			}
        }
        case 2351:
        {
            if(!response) return callcmd::bank(playerid);
			if(response)
			{
                if(PI[playerid][pBusiness] == INVALID_BUSINESS_ID) return SCM(playerid, COLOR_GREY, !"� ��� ��� �������");
                
			    new b = PI[playerid][pBusiness];

			    if(strval(inputtext) < 100) return SCM(playerid, COLOR_GREY, !"����������� ����� ��� ������ 100 ���");
				if(strval(inputtext)+strval(inputtext)/100*6 > BizInfo[b][bMoney]) return SCM(playerid, COLOR_GREY, !"������������ ������� �� ������� �������"), BusinessGiveMoney(playerid);

                new OldBizMoney = BizInfo[b][bMoney];

                BizInfo[b][bMoney] -= strval(inputtext);
				GivePlayerMoneyLog(playerid, strval(inputtext));

				ShowPlayerDialogf(playerid, 2345, DIALOG_STYLE_MSGBOX, !"{ee3366}�������� ���������", !"�������", !"�����", "\
                    {FFFFFF}������ ������ �������: {ff6633}%d ���\n\
                    {FFFFFF}����� ������ �������: {3366cc}%d ���\n\
                    {FFFFFF}��������: \t\t{ff6633}%d ���\n\
                    {FFFFFF}�����: \t\t{3366cc}%d ���", OldBizMoney, BizInfo[b][bMoney], strval(inputtext)/100*6, strval(inputtext));

				SaveBusinessData(b);
			}
        }
    }
    return 1;
}
stock TransferBank_log(playerid, money, text[], account_id = 0)
{
    new day, month, year, date_str[30];
    getdate(year, month, day);

    f(date_str, sizeof(date_str), "%d %s %d �.", day, monthNames[month-1], year);

    mysql_string[0] = EOS;

    if(account_id == 0)
    {
        format(mysql_string, 230, "\
        INSERT INTO `transferlogs`(`player`, `money`, `text`, `date`)\
            VALUES\
        ('%d', '%d', '%s', '%s')", PI[playerid][pID], money, text, date_str);
    }
    else 
    {
        format(mysql_string, 230, "\
        INSERT INTO `transferlogs`(`player`, `money`, `text`, `date`)\
            VALUES\
        ('%d', '%d', '%s', '%s')", account_id, money, text, date_str);
    }

    mysql_tquery(mysql, mysql_string, "", "");
    return 1;
}
stock ShowLastTransferLog(playerid, value = 10)
{
    new transfers;
    mysql_queryf(mysql, "SELECT `text`, `date` FROM `transferlogs` WHERE `player` = '%d' ORDER by `id` DESC LIMIT %d", true, PI[playerid][pID], value);
	transfers = cache_get_row_count(mysql);
	if(!transfers) return SCM(playerid, COLOR_GREY, !"� ��� ������� �� ���� ���������� ��������");

    global_str[0] = EOS; 
    new text[110], transfer_date[25];
    
    for(new i; i < transfers; i++)
    {
        cache_get_row(i, 0, text, mysql);
        cache_get_row(i, 1, transfer_date, mysql);

        format(global_str, 512, "%s\n%s\t%s", global_str, transfer_date, text);
    }
    ShowPlayerDialogf(playerid, 2345, DIALOG_STYLE_TABLIST_HEADERS, !"{ee3366}��������� 20 ��������", !"�������", !"�����", "����\t����������\n%s", global_str);
    return 1;
}
//===============================================
CMD:bank(playerid) 
{
	if(PI[playerid][pLevel] < 2) return SCM(playerid, COLOR_GREY,"������������ ���������� ������� ����� ������ �� 2 ������");
    if(PlayerToPoint(1.0, playerid, 1534.6836,1820.4808,578.6213) || PlayerToPoint(1.0, playerid, 1537.8619,1820.2335,578.6213) || PlayerToPoint(1.0, playerid, 1540.8298,1820.5121,578.6213)) 
	{
		ShowPlayerDialogf(playerid, 7999, DIALOG_STYLE_LIST, !"{ee3366}����", !"�������", !"", "\
		1. ���������� ����� {ff6633}(� %d)\n\
		{FFFFFF}2. ������ ���������\n\
		3. ����������� ������", PI[playerid][pID]);
	}
	else return 1;
	return 1;
}