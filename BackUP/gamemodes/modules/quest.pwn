new RentMotoTimerToDetroy[MAX_PLAYERS];
// ������� �������
stock nosov_OnPlayerKeyStateChange(playerid, newkeys)
{
    if(newkeys == 1024)
    {
        if(IsPlayerInRangeOfPoint(playerid, 3.0, 1469.9095,2050.7461,12.5316)) 
        {
            ShowPlayerDialog(playerid, 3434, DIALOG_STYLE_LIST, "{ee3366}�������������� � ��������", "\
            1. ������ ������, ����������?\n\
            2. ������� ��� ����\n\
            3. ���� ���������� �����", "�����", "�������");
        }
    }
    return 1;
}
stock qeust_OnDialogResponse(playerid, dialogid, response, listitem)
{
    switch(dialogid) 
	{
        case 3434:
        {
            if(!response) return 1;
            if(response)
            {
                switch(listitem)
                {
                    case 0: ShowPlayerDialog(playerid, 0, DIALOG_STYLE_MSGBOX, "{ee3366}����������", "{FFFFFF}����! ��� �-�� ���� �������� ������? ������ ��������. �������, �������.\n��� ���� ����� ���� ���-��� (������� /help). �������, ��� ���� �������. �����!", "�������", "");
                    case 1: SendClientMessage(playerid, COLOR_LIGHTGREY, !"������������ ��� �� �������� ������� ��� �������");
                    case 2: 
                    {
                        CEF_ShowPlayerDialogNew(playerid, 3435, "{ee3366}������",\
                            "��-��, ��� � ���� � ������ ���� ������, �� ��������� ������ ��� � ����\n\n��������� ������: <strong>250 ���</strong>",\
                            "���� �� �������� ����� � �� ��������� � ���� � ������� 90 ������ �� ��������. ", "����������", "������");
                    }
                }
            }
        }
        case 3435:
        {
            if(!response) return 1;
            if(response)
            {
                if(PI[playerid][pRentMoto] != INVALID_VEHICLE_ID) return SendClientMessage(playerid, COLOR_GREY, !"�� ��� ���������� �����");
 				if(GetPlayerMoneyID(playerid) < 450) return SendClientMessage(playerid, COLOR_GREY, !"� ��� ������������ ����� ��� ������");
				SendClientMessage(playerid, 0x00aa33AA, !"�� ���������� ����� � �������� ������� '�������' �� 250 ������");

                GivePlayerMoneyLog(playerid, -250);

				PI[playerid][pRentMoto] = CreateVehicle(462, 1483.1671,2054.8171,12.5316,269.5321, 1, 1, 3600);
				PutPlayerInVehicleAC(playerid, PI[playerid][pRentMoto], 0);
            }
        }
    }
    return 1;
}
callback: ArendMotoDestroy(playerid) 
{
	SendClientMessage(playerid, COLOR_GREY, !"�� �� ���� �� ����� � ������� 90 ������, �� ��� ������������");
	DestroyVehicle(PI[playerid][pRentMoto]);
	return PI[playerid][pRentMoto] = INVALID_VEHICLE_ID;
}