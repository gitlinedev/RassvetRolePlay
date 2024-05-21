//
#define SIM_CARD    300
#define PHONE       5500
#define FIX_CAR     1500
#define MASK        300
#define BALLON      400
#define PHOTO       600
#define HEALPACK    200
#define FLOWERS     600
#define PIZZA       400
#define CHIPS       150
//==================================[ stocks ] ====================================//
stock ShowShopMenu(playerid)
{
    ShowPlayerDialogf(playerid, 3520, DIALOG_STYLE_LIST, !"{ee3366}������� 24/7", !"������", !"�������", "\
	1. ����� (� �����)\t\t\t\t{ebeb8e}%d ���.\n\
	{ffffff}2. ����� (� �����)\t\t\t\t{ebeb8e}%d ���.\n\
	{ffffff}3. ����� ������ '�������� ���� ���'\t\t{ebeb8e}%d ���.\n\
	{ffffff}4. ����������� �������\t\t\t{ebeb8e}%d ���.\n\
	{ffffff}5. ����������\t\t\t\t\t{ebeb8e}%d ���.\n\
	{ffffff}6. �������� � �������\t\t\t\t{ebeb8e}%d ���.\n\
	{ffffff}7. �����\t\t\t\t\t{ebeb8e}%d ���.\n\
	{ffffff}8. bPhoneXX\t\t\t\t\t{ebeb8e}%d ���.\n\
	{ffffff}9. SIM ������ (6 ����)\t\t\t\t{ebeb8e}%d ���.\n\
	{ffffff}9. ��������� �����\t\t\t\t{ebeb8e}%d ���.", CHIPS, PIZZA, FLOWERS, HEALPACK, PHOTO, BALLON, MASK, PHONE, SIM_CARD, FIX_CAR);
    return 1;
}
stock ShowArmyShop(playerid)
{
    new hour, Discount = 0;
    gettime(hour);
    if(hour == 23 || hour == 00 || hour == 1  || hour == 2  || hour == 3  || hour == 4  || hour == 5  || hour == 6  || hour == 7) Discount++;

    if(Discount == 0)
    {
        ShowPlayerDialogf(playerid, 5070, DIALOG_STYLE_LIST, !"{ee3366}��������� �������", !"������", !"�������", "\
        1. ����������� �������\t{33cc99}%d ���\n\
        2. �����\t\t\t\t{33cc99}%d ���", HEALPACK, MASK);
    }
    else 
    {
        ShowPlayerDialogf(playerid, 5070, DIALOG_STYLE_LIST, !"{ee3366}��������� �������", !"������", !"�������", "\
        1. ����������� �������\t{33cc99}%d ��� [������ ������ 50%%]\n\
        2. �����\t\t\t\t{33cc99}%d ��� [������ ������ 50%%]", HEALPACK/2, MASK/2);
    }
    return 1;
}
//==================================[ dialogs ]=====================================//
stock shop_OnDialogResponse(playerid, dialogid, response, listitem, inputtext[]) 
{
    switch(dialogid)
    {
        case 6989:
		{
		    new b = GetPVarInt(playerid,"business");
		    if(!response) return ShowShopMenu(playerid);
		    if(response)
		    {
				if(BizInfo[b][bProduct] <= 0  || BizInfo[b][bOwned] == 0) return SendClientMessage(playerid, COLOR_GREY, !"� ������� ������������ ���������");

				if(GetPlayerMoneyID(playerid) < PHONE) return SCM(playerid, COLOR_GREY, !"� ��� ������������ ����� �� �����");
				if(PI[playerid][data_PHONE] == 1) return SCM(playerid, COLOR_GREY, !"� ��� ��� ���� �������");
				GivePlayerMoneyLog(playerid, -PHONE);

                PI[playerid][data_PHONE] = 1;

				UpdateBusinessData(b);
				cef_emit_event(playerid, "show-notify-no-img", CEFSTR("������� ���������� ��������"), CEFSTR("fb4949"), CEFSTR("-5500P"));
				ShowPlayerDialog(playerid, 0, DIALOG_STYLE_MSGBOX, !"{ee3366}������� ���������� ��������", "{FFFFFF}�����������!\n�� ������ ������� {3366cc}bPhone XX{FFFFFF}\n�� �������� ���������� SIM-�����", "�������", "�����");
				SCM(playerid, 0x00AA33FF, !"����� ������� ���� �������� ����������� {FF9977}������� P");
			}
		}
		case 6990:
		{
			new b = GetPVarInt(playerid,"business");
		    if(!response) return ShowShopMenu(playerid);
		    if(response)
		    {
                if(BizInfo[b][bProduct] <= 0  || BizInfo[b][bOwned] == 0) return SendClientMessage(playerid, COLOR_GREY, !"� ������� ������������ ���������");

				if(strlen(inputtext) == 0) return ShowPlayerDialog(playerid, 6990, DIALOG_STYLE_INPUT, "{ee3366}������� ������ ��������", "{FFFFFF}������� ������ {3366cc}6-�������{FFFFFF} ����� ��������\n����� SIM-����� ������� ������� (��� e� �������).\n{696969}�������� ��� �������� ����� ����������", "������", "�����");
				if(strlen(inputtext) < 6 || strlen(inputtext) > 6) return SCM(playerid, COLOR_GREY, !"����� ������ 6 �������"), ShowPlayerDialog(playerid, 6990, DIALOG_STYLE_INPUT, "{ee3366}������� ������ ��������", "������� ������ {3366cc}6-�������{FFFFFF} ����� ��������\n����� SIM-����� ������� ������� (��� e� �������).\n{696969}�������� ��� �������� ����� ����������", "������", "�����");

                if(PI[playerid][data_PHONE] == 0) return SCM(playerid, COLOR_GREY, !"������� ������ �������");
				if(GetPlayerMoneyID(playerid) < PHONE) return SCM(playerid, COLOR_GREY, !"� ��� ������������ ����� �� �����");
				SetPVarInt(playerid, "simcard", strval(inputtext));

                mysql_string[0] = EOS, f(mysql_string, 55, "SELECT * FROM `accounts` WHERE `number` = '%d'", strval(inputtext));
                mysql_tquery(mysql, mysql_string, "CheckSimCard", "i", playerid);
			}
		}
		case 5070: 
        {
		    if(!response) return 1;
		    if(response) 
            {
                new hour, Discount = 0;
                gettime(hour);
                if(hour == 23 || hour == 00 || hour == 1  || hour == 2  || hour == 3  || hour == 4  || hour == 5  || hour == 6  || hour == 7) Discount++;

		        switch(listitem) 
                {
		            case 0:
					{
					    if(PI[playerid][pHealPack] == 3) return ShowArmyShop(playerid), SCM(playerid, COLOR_GREY, !"�� ������ ������ �� ����� 3� �������");
						if(Discount == 0) 
                        {
                            if(GetPlayerMoneyID(playerid) < HEALPACK) return ShowArmyShop(playerid), SCM(playerid, COLOR_GREY, !"� ��� ������������ ����� �� �����"); 
						    GivePlayerMoneyLog(playerid, HEALPACK);

                            new cef[10]; f(cef, 10, "-%d�", HEALPACK);
                            cef_emit_event(playerid, "show-notify-no-img", CEFSTR("������� ���. ������� (/healme)"), CEFSTR("fb4949"), CEFSTR(cef));
                            SCMf(playerid, 0x00AA33FF, "�� ������ ���. �������{fe9a7e} (%d �� 3){00aa33} �� {fe9a7e}200 ������", PI[playerid][pHealPack]);
                        }
                        else 
                        {
                            if(GetPlayerMoneyID(playerid) < HEALPACK/2) return ShowArmyShop(playerid), SCM(playerid, COLOR_GREY, !"� ��� ������������ ����� �� �����"); 
						    GivePlayerMoneyLog(playerid, HEALPACK/2);
                            new cef[10]; f(cef, 10, "-%d�", HEALPACK/2);
                            cef_emit_event(playerid, "show-notify-no-img", CEFSTR("������� ���. ������� (/healme)"), CEFSTR("fb4949"), CEFSTR(cef));
                            SCMf(playerid, 0x00AA33FF, "�� ������ ���. �������{fe9a7e} (%d �� 3){00aa33} �� {fe9a7e}200 ������", PI[playerid][pHealPack]);
                        }

						PI[playerid][pHealPack]++;
						UpdatePlayerDataInt(playerid, "healthchest", PI[playerid][pHealPack],10245);
						SCM(playerid, 0x00AA33FF, "����� ����������� ����������� {fe9a7e}/healme{00aa33}, �������� ������� ������ {fe9a7e}/givechest");
						ShowArmyShop(playerid);
					}
					case 1:
					{
                        if(PI[playerid][data_MASK] >= 1) return ShowArmyShop(playerid), SCM(playerid, COLOR_GREY, !"�� �� ������ ���������� ����� 1-� �����");
                        if(Discount == 0) 
                        {
                            if(GetPlayerMoneyID(playerid) < MASK) return ShowArmyShop(playerid), SCM(playerid, COLOR_GREY, !"� ��� ������������ ����� �� �����");
                            GivePlayerMoneyLog(playerid,-MASK);
                            new cef[10]; f(cef, 10, "-%d�", MASK);
                            cef_emit_event(playerid, "show-notify-no-img", CEFSTR("������� �����"), CEFSTR("fb4949"), CEFSTR(cef));
                        }
                        else
                        {
                            if(GetPlayerMoneyID(playerid) < MASK/2) return ShowArmyShop(playerid), SCM(playerid, COLOR_GREY, !"� ��� ������������ ����� �� �����");
                            GivePlayerMoneyLog(playerid,-MASK/2);
                            new cef[10]; f(cef, 10, "-%d�", MASK/2);
                            cef_emit_event(playerid, "show-notify-no-img", CEFSTR("������� �����"), CEFSTR("fb4949"), CEFSTR(cef));
                        }
						PI[playerid][data_MASK]++;
						SCM(playerid, 0x00AA33FF, "�� ������ ����� �� {ff9977}150 ���{00aa33}. ����� ������ � ����������� /mask");
						ShowArmyShop(playerid);
					}
			    }
			}
		}
        case 3520: 
		{
		    new b = GetPVarInt(playerid,"business");
		    if(!response) return 1;
			if(response) 
			{
                if(BizInfo[b][bProduct] <= 0  || BizInfo[b][bOwned] == 0) return SendClientMessage(playerid, COLOR_GREY, !"� ������� ������������ ���������");
			    switch(listitem) 
				{
			        case 0: 
                    {
                        SendClientMessage(playerid, COLOR_LIGHTGREY, !"� ����������");
                        SCM(playerid, 0x00AA33FF, !"�� ������ '�����' (�����: {FF9977}1 ��{00AA33}). ����� �������� ����������� {FF9977}/eat");
                    }
			        case 1: 
                    {
                        SendClientMessage(playerid, COLOR_LIGHTGREY, !"� ����������");
                        SCM(playerid, 0x00AA33FF, !"�� ������ '�����' (�����: {FF9977}1 ��{00AA33}). ����� �������� ����������� {FF9977}/eat");
                    }
			        case 2: 
                    {
						if(GetPlayerMoneyID(playerid) < FLOWERS) return SCM(playerid, COLOR_GREY, !"� ��� ������������ ����� �� �����");
						GivePlayerMoneyLog(playerid, -FLOWERS);
						GiveWeapon(playerid, 14, 1);
					    UpdateBusinessData(b);
						new cef[10]; f(cef, 10, "-%d�", FLOWERS);
                        cef_emit_event(playerid, "show-notify-no-img", CEFSTR("������� ������"), CEFSTR("fb4949"), CEFSTR(cef));
						SCM(playerid, 0x00AA33FF, !"�� ������ ����� ������. ����� �������� ����������� {FF9977}/flowers");
						ShowShopMenu(playerid);
					}
					case 3:
					{
					    if(PI[playerid][pHealPack] == 3) return SCM(playerid, COLOR_GREY, !"�� ������ ������ �� ����� 3� �������");
						if(GetPlayerMoneyID(playerid) < HEALPACK) return SCM(playerid, COLOR_GREY, !"� ��� ������������ ����� �� �����");
						GivePlayerMoneyLog(playerid,-HEALPACK);
						PI[playerid][pHealPack]++;
						UpdatePlayerDataInt(playerid, "healthchest", PI[playerid][pHealPack],10245);
					    UpdateBusinessData(b);
                        new cef[10]; f(cef, 10, "-%d�", HEALPACK);
						cef_emit_event(playerid, "show-notify-no-img", CEFSTR("������� ���. ������� (/healme)"), CEFSTR("fb4949"), CEFSTR(cef));
						SCMf(playerid, 0x00AA33FF, "�� ������ ���. �������{FF9977} (%d �� 3){00AA33} �� {FF9977}%d ������", PI[playerid][pHealPack], HEALPACK);
						SCM(playerid, 0x00AA33FF, !"����� ����������� ����������� {FF9977}/healme{00AA33}, �������� ������� ������ {FF9977}/givechest");
						ShowShopMenu(playerid);
					}
					case 4:
					{
						if(GetPlayerMoneyID(playerid) < PHOTO) return SCM(playerid, COLOR_GREY, !"� ��� ������������ ����� �� �����");
						GivePlayerMoneyLog(playerid,-PHOTO);
						GiveWeapon(playerid, 43, 20);
					    UpdateBusinessData(b);
                        new cef[10]; f(cef, 10, "-%d�", PHOTO);
						cef_emit_event(playerid, "show-notify-no-img", CEFSTR("������� �����������"), CEFSTR("fb4949"), CEFSTR(cef));
						SCM(playerid, 0x00AA33FF, !"�� ������ ����������.");
						ShowShopMenu(playerid);
					}
					case 5:
					{
						if(GetPlayerMoneyID(playerid) < BALLON) return SCM(playerid, COLOR_GREY, !"� ��� ������������ ����� �� �����");
						GivePlayerMoneyLog(playerid,-BALLON);
						GiveWeapon(playerid, 41, 1000);
					    UpdateBusinessData(b);
                        new cef[10]; f(cef, 10, "-%d�", BALLON);
						cef_emit_event(playerid, "show-notify-no-img", CEFSTR("������� ��������� � �������"), CEFSTR("fb4949"), CEFSTR(cef));
						SCM(playerid, 0x00AA33FF, !"�� ������ �������� � �������.");
						ShowShopMenu(playerid);
					}
					case 6:
					{
					    if(PI[playerid][data_MASK] >= 1) return SCM(playerid, COLOR_GREY, !"�� �� ������ ���������� ����� 1-� �����");
						if(GetPlayerMoneyID(playerid) < MASK) return SCM(playerid, COLOR_GREY, !"� ��� ������������ ����� �� �����");
						GivePlayerMoneyLog(playerid,-MASK);
						PI[playerid][data_MASK]++;
					    UpdateBusinessData(b);
                        new cef[10]; f(cef, 10, "-%d�", MASK);
						cef_emit_event(playerid, "show-notify-no-img", CEFSTR("������� �����"), CEFSTR("fb4949"), CEFSTR(cef));
						SCMf(playerid, 0x00AA33FF, "�� ������ ����� �� {FF9977}%d ���{00AA33}. ����� ������ � ����������� {FF9977}/mask", MASK);
						ShowShopMenu(playerid);
					}
					case 7: 
                    {
                        ShowPlayerDialogf(playerid, 6989, DIALOG_STYLE_MSGBOX, !"{ee3366}������� ��������", !"������", !"�����", "\
                        {FFFFFF}�� ������������� ������ ������ {3366cc}bPhone XX{ffffff} �� {3366cc}%d ���{ffffff}?\n\
                        ����� ������� ������� ������� (��� ��� �������).\n\
                        {696969}�������� ��� �������� ����� ����������", PHONE);
                    }
                    case 8: 
                    {
                        ShowPlayerDialog(playerid, 6990, DIALOG_STYLE_INPUT, "{ee3366}������� ������ ��������", !"\
                        {FFFFFF}������� ������ {3366cc}6-�������{ffffff} ����� ��������\n\
                        ����� SIM-����� ������� ������� (��� e� �������).\n\
                        {696969}�������� ��� �������� ����� ����������", !"������", !"�����");
                    }
                    case 9:
					{
						if(PI[playerid][data_FIXCOMPL] >= 3) return SCM(playerid, COLOR_GREY, !"�� �� ������ ���������� ����� 3 ���.����������.");
						if(GetPlayerMoneyID(playerid) < FIX_CAR) return SCM(playerid, COLOR_GREY, !"� ��� ������������ ��� �������!");

                        new cef[10]; f(cef, 10, "-%d�", FIX_CAR);
						cef_emit_event(playerid, "show-notify-no-img", CEFSTR("������� ���.��������"), CEFSTR("fb4949"), CEFSTR(cef));
						SCM(playerid, 0x00AA33FF, !"�� ������ ���.�������� {FF9977}1500� ���{00AA33}. ����� ��� ������������ {FF9977}/fix");

						GivePlayerMoneyLog(playerid, -FIX_CAR);
						PI[playerid][data_FIXCOMPL] += 1;
						ShowShopMenu(playerid);
					}
			    }
			}
		}
    }
    return 1;
}
callback: CheckSimCard(playerid) 
{
	new rows;
	rows = cache_num_rows();
    
    if(rows) return ShowPlayerDialog(playerid, 6990, DIALOG_STYLE_INPUT, "{ee3366}������� ������ ��������", "{FFFFFF}������� ������ {3377cc}6-�������{FFFFFF} ����� ��������\n����� SIM-����� ������� ������� (��� e� �������).\n{696969}�������� ��� �������� ����� ����������", "������", "�����");
	else
	{
		new b = GetPVarInt(playerid,"business");
        if(BizInfo[b][bProduct] <= 0  || BizInfo[b][bOwned] == 0) return SendClientMessage(playerid, COLOR_GREY, !"� ������� ������������ ���������");
        
		GivePlayerMoneyLog(playerid,-SIM_CARD);
		PI[playerid][data_NUMBER] = GetPVarInt(playerid,"simcard");
		UpdatePlayerDataInt(playerid, "number", PI[playerid][data_NUMBER], 28023);
		cef_emit_event(playerid, "show-notify-no-img", CEFSTR("������� ���-�����"), CEFSTR("fb4949"), CEFSTR("-300P"));
		ShowPlayerDialogf(playerid, 0, DIALOG_STYLE_MSGBOX, !"{ee3366}������� SIM-�����", "�������", "�����", "{FFFFFF}�����������!\n�� ������ SIM-����� c ������� {3377cc}%d", GetPVarInt(playerid,"simcard"));
		UpdateBusinessData(b);
	}
	return 1;
}