new MineInventory[MAX_PLAYERS];
new MineOre[MAX_PLAYERS];
new MineTypeOre[MAX_PLAYERS];
new AntiFloodMine[MAX_PLAYERS];

new OrePrice = 105;
new InvPrice = 20;

new MineClothes;
new MinePoint_1;
new MinePoint_2;
new MinePoint_3;
new MinePoint_4;
new MineDropOre;

new MineOreStock;
new MineCoalStock;
new Text3D: MineInfo;

stock mine_OnDialogResponse(playerid, dialogid, response) 
{
    switch(dialogid) 
	{
        case 4001:
        {
            if(!response) return 1;
            if(response)
            {
                SendClientMessage(playerid, COLOR_JOBYELLOW, !"�� ������ ������ ������");
                SendClientMessage(playerid, COLOR_JOBYELLOW, !"��������� �������� � �������� ���� � �����");

                PI[playerid][pUseAccessory] = 0;
                for(new i; i < 10; i++) RemovePlayerAttachedObject(playerid, i);

		        SetPlayerAttachedObject(playerid, 1, 18634, 14, 0.333391, 0.000000, 0.042249, 358.219909, 268.014739, 170.032974, 2.003867, 1.764811, 1.579773);
		        SetPlayerSkinAC(playerid, 254);

                PI[playerid][pTempJob] = 2;

                PI[playerid][PTempJobValue_1] = 0; 
                PI[playerid][PTempJobValue_2] = 0; 
                PI[playerid][pTempJobMoney] = 0; 

                MineInventory[playerid] = 0;

                MineOre[playerid] = 0;

                SetPVarInt(playerid, "PlayerInDialog", 1);

                CEF__Dialog(playerid, 4003, DIALOG_STYLE_MSGBOX, "{ee3366}��������� ��� ������", "\
                �� ������ ���������� �������������� ���������?\n\n\
                ���������: {000000}250 ���\n\n\
                {696969}��������� ��������� ����������� �������� ��������", "������", "������");

                return 1;
            }
        }
        case 4002:
        {
            if(!response) return 1;
            if(response)
            {
                new skin = GetSkinOfPlayer(playerid);

                new Sum = PI[playerid][PTempJobValue_1]+PI[playerid][PTempJobValue_2];
                new Profit = Sum*InvPrice;
                new Money = Sum*OrePrice;
                
                SendClientMessage(playerid, -1, "�� ��������� ������� ���� (�����)");
                if(MineInventory[playerid] == 1) SendClientMessagef(playerid, -1, "�������� �� �������������� ���������: {FF9900}%d ���", Profit);
                SendClientMessagef(playerid, -1, "������ ����: {FF9900}%d ��", PI[playerid][PTempJobValue_2]);
                SendClientMessagef(playerid, -1, "������ ����: {FF9900}%d ��", PI[playerid][PTempJobValue_1]);
                SendClientMessagef(playerid, -1, "����� ����������: {FF9900}%d ���", Profit+Money);

                GivePlayerMoneyLog(playerid, Profit+Money);

                SetPlayerSkin(playerid, skin);

                PI[playerid][pTempJob] = 0;

                PI[playerid][PTempJobValue_1] = 0; 
                PI[playerid][PTempJobValue_2] = 0; 
                PI[playerid][pTempJobMoney] = 0; 

                MineInventory[playerid] = 0;

                if(IsPlayerAttachedObjectSlotUsed(playerid, 4)) RemovePlayerAttachedObject(playerid, 4);
                if(IsPlayerAttachedObjectSlotUsed(playerid, 1)) RemovePlayerAttachedObject(playerid, 1);
            }
        }
        case 4003:
        {
            if(!response) return DeletePVar(playerid, "PlayerInDialog");
            if(response)
            {
                if(GetPlayerMoneyID(playerid) < 250) return SendClientMessage(playerid, COLOR_GREY, !"� ��� ������������ �����");
                
                MineInventory[playerid] = 1;
                GivePlayerMoneyLog(playerid, -250);

                SendClientMessage(playerid, COLOR_JOBYELLOW, !"�� ������ ��������� ��� ������ �� {3377CC}250 ���");
                cef_emit_event(playerid, "show-center-notify", CEFINT(1), CEFSTR("��������� �������� �������� � ����� ������. ��� ������ ������ �� ��������, ��� ������ ����� �����"));
                
                DeletePVar(playerid, "PlayerInDialog");
                return 1;
            }
        }
    }
    return 1;
}
stock mineOnPlayerPickUpDynamicPickup(playerid, pickupid)
{
    if(AntiFloodMine[playerid] > gettime()) return 1;

    if(pickupid == MineClothes)
	{
		if(PI[playerid][pTempJob] == 0)
		{
			ShowPlayerDialog(playerid, 4001, DIALOG_STYLE_MSGBOX, !"{ee3366}������ ������", !"\
			{FFFFFF}�� ������ ���������� �� ������ �������?\n\
			���� �������� ������ - ������ �������� ���� � ����.\n\n\
			�������� ��������: ���� �� �������� ����������\n\
			�����, ������������ ����� ����� ������������", !"��", !"���");
		}
		else if(PI[playerid][pTempJob] == 2 && GetPVarInt(playerid, "PlayerInDialog") == 0)
		{
			ShowPlayerDialog(playerid, 4002, DIALOG_STYLE_MSGBOX, !"{ee3366}�����", !"\
			{FFFFFF}�� �������, ��� ������ ��������� ������� ����?", !"���������", !"������");
		}
	}
	if(pickupid == MinePoint_1 || pickupid == MinePoint_2 || pickupid == MinePoint_3 || pickupid == MinePoint_4)
	{
		if(PI[playerid][pTempJob] == 2)
		{
            if(MineOre[playerid] == 1) return 1;
            new type = RandomEX(1, 2);
            MineTypeOre[playerid] = type;
	   	    ApplyAnimation(playerid, "BASEBALL", "Bat_4", 4.1, 1, 0, 0, 1, 4800);
            SetTimerEx("TimerGiveMiner", 5000, false, "i", playerid);
		}
	}
    if(pickupid == MineDropOre)
    {
        if(PI[playerid][pTempJob] == 2)
        {
            if(MineOre[playerid] == 0) return 1;

            ApplyAnimation(playerid, "CARRY", "putdwn", 4.0, 0, 0, 0, 1, 1130);

            RemovePlayerAttachedObject(playerid, 4);
            SetPlayerAttachedObject(playerid, 1, 18634, 14, 0.333391, 0.000000, 0.042249, 358.219909, 268.014739, 170.032974, 2.003867, 1.764811, 1.579773);

            if(MineTypeOre[playerid] == 2)
            {
                PI[playerid][PTempJobValue_1] += 1;
                MineCoalStock++;
                SendClientMessagef(playerid, COLOR_JOBYELLOW, "����� ��������� �� �����. ����� ����������: {3377CC}%d �� {FFCD00}�����", PI[playerid][PTempJobValue_1]+PI[playerid][PTempJobValue_2]);
            }
            if(MineTypeOre[playerid] == 1)
            {
                PI[playerid][PTempJobValue_2] += 1;
                MineOreStock++;
                SendClientMessagef(playerid, COLOR_JOBYELLOW, "���� ���������� �� �����. ����� ����������: {3377CC}%d �� {FFCD00}�����", PI[playerid][PTempJobValue_1]+PI[playerid][PTempJobValue_2]);
            }
            MineTypeOre[playerid] = 0;
            MineOre[playerid] = 0;
            UpdateMine();
            return 1;
        }
    }
    AntiFloodMine[playerid] = gettime() + 5;
    return 1;
}
stock mine_OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
    if(PRESSED(KEY_JUMP)) 
	{
        if(MineOre[playerid] == 1)
        {
            if(PI[playerid][pTempJob] == 2)
            {
                if(IsPlayerAttachedObjectSlotUsed(playerid, 4)) RemovePlayerAttachedObject(playerid, 4);
                SetPlayerAttachedObject(playerid, 1, 18634, 14, 0.333391, 0.000000, 0.042249, 358.219909, 268.014739, 170.032974, 2.003867, 1.764811, 1.579773);

                cef_emit_event(playerid, "show-center-notify", CEFINT(2), CEFSTR("�� ������� ����! ���������� ��� ���"));
                ClearAnimations(playerid);
                MineTypeOre[playerid] = 0;
                MineOre[playerid] = 0;
            }
 		}
    }
}
callback: TimerGiveMiner(playerid)
{
    //ClearAnimations(playerid);

    ApplyAnimation(playerid, "CARRY", "crry_prtial", 4.0, 0, 0, 0, 1, 1);

    MineOre[playerid] = 1;
    RemovePlayerAttachedObject(playerid, 1);
    SetPlayerAttachedObject(playerid, 4, 2936, 1, 0.184699, 0.426247, 0.000000, 259.531341, 80.949592, 0.000000, 0.476124, 0.468181, 0.470769);
}
//================================= [ Other ] ==========================//
stock UpdateMine()
{
    new str_mine[135];
    format(str_mine, sizeof str_mine, "{ff9933}�����\n\n\
                                        {FFFFFF}������� �� ������: {ffcc33}%d ��\n\
                                        {FFFFFF}���� �� ������: {cc6666}%d ��", MineOreStock, MineCoalStock);
    UpdateDynamic3DTextLabelText(MineInfo, -1, str_mine);

    mysql_queryf(mysql, "UPDATE `warehouse` SET `metall` = '%d', `coal` = '%d'", false, MineOreStock, MineCoalStock);
    return 1;
}