#define BUSINESS_STATS "business_fin"
#define BUSINESS_TABLE "busienss"

enum bInfo {
	data_ID,
	bRentCost,
	bClient,
 	bName[50],
	bOwner[MAX_PLAYER_NAME],
	bOwned,
	bPrice,
	Float:data_ENTERX,
	Float:data_ENTERY,
	Float:data_ENTERZ,
	Float:data_BUYX,
	Float:data_BUYY,
	Float:data_BUYZ,
	Float:data_EXITX,
	Float:data_EXITY,
	Float:data_EXITZ,
	Float:data_TPEXITX,
	Float:data_TPEXITY,
	Float:data_TPEXITZ,
	Float:data_ANGLE,
	bProduct,
	bDays,
	data_LOCK,
	data_TYPE,
	data_CENA,
	bPriceProduct,
	bMoney,
	data_INT,
	data_VW,
	Text3D:data_TEXTBUY,
	Text3D:bTextInfo,
    data_PICKENTER,
    data_PICKEXIT,
    data_MAPICON,
    bCheckPointForBuy,
	bSealedDays,
};
new BizInfo[MAX_BUSINESS][bInfo];
//================================= [ CMD ] ==========================//
CMD:business(playerid) 
{
    if(PI[playerid][pBusiness] == INVALID_BUSINESS_ID) return SCM(playerid, COLOR_GREY, !"� ��� ��� �������");
    if(PI[playerid][pBusiness] != INVALID_BUSINESS_ID) 
    { 
        if(BizInfo[PI[playerid][pBusiness]][bSealedDays] > 0) return SendClientMessage(playerid, COLOR_GREY, !"��� ������ ��������, �� �� ������ ��������� ��");
        BusinessMenu(playerid);
    }
	return 1;
}
CMD:buybusiness(playerid) 
{
    if(PI[playerid][pLevel] < 2) return SCM(playerid, COLOR_GREY, !"������� ������� �������� �� 2 ������");

    for(new b = 0; b < TotalBusiness; b++) 
	{
        if(PlayerToPoint(3.0, playerid, BizInfo[b][data_ENTERX], BizInfo[b][data_ENTERY], BizInfo[b][data_ENTERZ])) 
		{
            if(PI[playerid][pBusiness] != INVALID_BUSINESS_ID) return SCM(playerid, COLOR_GREY, !"� ��� ��� ���� ������");

            if(BizInfo[b][bOwned] == 1) return SCM(playerid, COLOR_GREY, !"���� ������ ��� ������'");
			if(GetPlayerMoneyID(playerid) < BizInfo[b][bPrice]) return SCM(playerid, COLOR_GREY, !"� ��� ������������ ����� �� �����");
			PI[playerid][pBusiness] = b;
			BizInfo[b][bMoney] = 0;
			BizInfo[b][bProduct] = 0;
            BizInfo[b][bOwned] = 1;
            BizInfo[b][bDays] = 3;
            strmid(BizInfo[b][bOwner], getName(playerid), 0, strlen(getName(playerid)), 24);

            GivePlayerMoneyLog(playerid,-BizInfo[b][bPrice]);

            SCM(playerid, COLOR_CORAL, !"�����������! �� ������ ������. �� �������� �������� ��� � ����� - {f6fae4}/gps � ������ �����");
            SCM(playerid, COLOR_CORAL, !"������������ ��������� ����� ������� ����������� � ������� {f6fae4}2-4 ����");
            SCM(playerid, COLOR_CORAL, !"�������� �������� � ������� 5-7 ����, ����� ������ ����� ������.");

	    	ShowPlayerDialog(playerid, 1592, DIALOG_STYLE_MSGBOX, "{ee3366}������� �������", "\
			{FFFFFF}��� ���������� �������� ����������� ������� {3776c8}/business{FFFFFF}.\n\n\
			{FFFFFF}�������� ������ � ����� {3776c8}(/gps 1 8 � /gps 7){FFFFFF} ��� ��������� ����� {3776c8}(������� P){FFFFFF}\n\
			{FFFFFF}�� ��������� ������� ������� �� ����, � ��������� ������ �� ����� ��������!\n\n\
			{FFFF99}���� � ������� �� ����� ��������� � ������� 5-7 ����, �� ����� ��������.", "�������", "������");

            UpdateBusinessData(b);
            SaveBusinessData(b);
           	SavePlayerData(playerid);
           	break;
        }
    }
    return 1;
}
stock SetBusinessUpdate() 
{
	for(new b = 0; b < TotalBusiness; b++) 
	{
		if(BizInfo[b][bOwned] == 1) 
		{
			new fin = RandomEX(100000, 580000);
			BizInfo[b][bMoney] += fin;
			mysql_queryf(mysql, "UPDATE `"BUSINESS_TABLE"` SET `clients` = '0', `bank` = '%d' WHERE `id` = '%d'", false, BizInfo[b][bMoney], b);
			mysql_queryf(mysql, "INSERT INTO `"BUSINESS_STATS"` (`bussines_id`, `people`, `type`, `money`, `data`) VALUES ('%d','%d','0','%d', CURRENT_TIMESTAMP)", false, b, BizInfo[b][bClient], fin);
			BizInfo[b][bClient] = 0;
			SaveBusinessData(b);
		}
        if(BizInfo[b][bSealedDays] > 0)
        {
            BizInfo[b][bSealedDays]--;
            if(BizInfo[b][bSealedDays] == 0)
            {
                new FindPlayer = 0;
                new MoneyBack = BizInfo[b][bPrice]/100*35;

		      	BizInfo[b][bOwned] = 0;
		      	BizInfo[b][bDays] = 0;
                BizInfo[b][bSealedDays] = -1;
                BizInfo[b][bMoney] = 0;

				mysql_queryf(mysql, "DELETE FROM `"BUSINESS_STATS"` WHERE `bussines_id` = '%d'", false, b);

                foreach(Player, i) 
                {
                    new szName[64];
                    if(!IsPlayerConnected(i)) continue;
                    GetPlayerName(i, szName,64);
                    if(!strcmp(BizInfo[b][bOwner], szName, false))
                    {
                        FindPlayer++;
                        SendClientMessage(i, COLOR_LIGHTGREY, !"��� ����������� ������ ��� ������ �����������");
                        PI[i][pBusiness] = INVALID_BUSINESS_ID;
                        GivePlayerMoneyLog(i, MoneyBack);
                        SavePlayerData(i);
                    }
                }
                if(FindPlayer == 0)
                {
                    mysql_queryf(mysql, "UPDATE `accounts` SET `Money` = `Money` + %d, `Business` = '-1' WHERE `Name` = `%s`", false, MoneyBack, BizInfo[b][bOwner]);
                }
			 	strmid(BizInfo[b][bOwner], "None", 0, strlen(BizInfo[b][bOwner]), 24);

				UpdateBusinessData(b);
				SaveBusinessData(b);
            }
        }
        else
        {
            BizInfo[b][bDays]--;
            if(BizInfo[b][bDays] < 1)
            {
                new sDays = RandomEX(2,4);
                BizInfo[b][bSealedDays] = sDays;
                UpdateBusinessData(b);
            }
        }
	}
	BusinessUpdate = 0;
	return 1;
}
stock UpdateBusinessData(b) 
{
    if(BizInfo[b][data_TYPE] == 1) 
	{
	    if(BizInfo[b][bOwned] == 1) 
		{
            if(BizInfo[b][bSealedDays] > 0)
            {
                new str_1[256];
                format(str_1,sizeof(str_1), "\
                {FFFFFF}%s {FFD700}�%d\n\
                {FFFFFF}��������: {FFD700}%s\n\
                {FF6347}������ ��������", BizInfo[b][bName], BizInfo[b][data_ID], BizInfo[b][bOwner]);
                UpdateDynamic3DTextLabelText(BizInfo[b][bTextInfo], -1, str_1);
            }
            else 
            {
                new str_1[256];
                format(str_1,sizeof(str_1), "\
                {FFFFFF}%s {FFD700}�%d\n\
                {FFFFFF}��������: {FFD700}%s\n\
                {FFFFFF}������ ��������: {FFD700}K", BizInfo[b][bName], BizInfo[b][data_ID], BizInfo[b][bOwner]);
                UpdateDynamic3DTextLabelText(BizInfo[b][bTextInfo], -1, str_1);
            }
		}
		else 
		{
			new str_1[256];
			format(str_1,sizeof(str_1), "{FFFFFF}������: {FFD700}%s\n\
										{FFFFFF}���������: {FFD700}%i ���\n\
										{ffffff}�����������: {FFD700}/buybusiness", BizInfo[b][bName], BizInfo[b][bPrice]);
			UpdateDynamic3DTextLabelText(BizInfo[b][bTextInfo], -1, str_1);
		}
	}
	else
	{
		if(BizInfo[b][bOwned] == 1) 
		{
            if(BizInfo[b][bSealedDays] > 0)
            {
                new str_1[256];
                format(str_1,sizeof(str_1), "\
                {FFFFFF}������: {FFD700}%s\n\
                {FFFFFF}��������: {FFD700}%s\n\
                {FF6347}������ ��������", BizInfo[b][bName], BizInfo[b][bOwner]);
                UpdateDynamic3DTextLabelText(BizInfo[b][bTextInfo], -1, str_1);
            }
            else 
            {
                new str_1[256];
                format(str_1,sizeof(str_1), "\
                {FFFFFF}������: {FFD700}%s\n\
                {FFFFFF}��������: {FFD700}%s", BizInfo[b][bName], BizInfo[b][bOwner]);
                UpdateDynamic3DTextLabelText(BizInfo[b][bTextInfo], -1, str_1);
            }
		}
		else 
		{
			new str_1[256];
			format(str_1,sizeof(str_1), "\
			{FFFFFF}������: {FFD700}%s\n\
			{ffffff}���������: {FFD700}%i ���\n\
			{ffffff}�����������: {FFD700}/buybusiness",BizInfo[b][bName],
			BizInfo[b][bPrice]);
			UpdateDynamic3DTextLabelText(BizInfo[b][bTextInfo], -1, str_1);
		}
	}
	return 1;
}
callback: LoadBusiness() 
{
    new rows, fields, temp[256],time = GetTickCount();
    cache_get_data(rows, fields);
	LoadedBiz = cache_get_row_count(mysql);
    
    new str_1[256];
    if(rows) 
	{
    	for(new b = 0; b < rows; b++) 
		{
	        cache_get_field_content(b, "id", temp), BizInfo[b][data_ID] = strval (temp);
	        cache_get_field_content(b, "owner", BizInfo[b][bOwner], mysql, MAX_PLAYER_NAME);
	        cache_get_field_content(b, "name", BizInfo[b][bName], mysql, 50);
	        cache_get_field_content(b, "owned", temp), BizInfo[b][bOwned] = strval (temp);
	        cache_get_field_content(b, "price", temp), BizInfo[b][bPrice] = strval (temp);
	        cache_get_field_content(b, "bank", temp), BizInfo[b][bMoney] = strval (temp);
	        cache_get_field_content(b, "prod", temp), BizInfo[b][bProduct] = strval (temp);
			cache_get_field_content(b, "clients", temp), BizInfo[b][bClient] = strval (temp);
	        cache_get_field_content(b, "type", temp), BizInfo[b][data_TYPE] = strval (temp);
	        cache_get_field_content(b, "cena", temp), BizInfo[b][data_CENA] = strval (temp);
	        cache_get_field_content(b, "price_prod", temp), BizInfo[b][bPriceProduct] = strval (temp);
	        cache_get_field_content(b, "int", temp), BizInfo[b][data_INT] = strval (temp);
	        cache_get_field_content(b, "vw", temp), BizInfo[b][data_VW] = strval (temp);
	        cache_get_field_content(b, "lock", temp), BizInfo[b][data_LOCK] = strval (temp);
	        cache_get_field_content(b, "mapicon", temp), BizInfo[b][data_MAPICON] = strval (temp);
	        cache_get_field_content(b, "enter_x", temp), BizInfo[b][data_ENTERX] = floatstr (temp);
	        cache_get_field_content(b, "enter_y", temp), BizInfo[b][data_ENTERY] = floatstr (temp);
	        cache_get_field_content(b, "enter_z", temp), BizInfo[b][data_ENTERZ] = floatstr (temp);
	        cache_get_field_content(b, "exit_x", temp), BizInfo[b][data_EXITX] = floatstr (temp);
	        cache_get_field_content(b, "exit_y", temp), BizInfo[b][data_EXITY] = floatstr (temp);
	        cache_get_field_content(b, "exit_z", temp), BizInfo[b][data_EXITZ] = floatstr (temp);
	        cache_get_field_content(b, "buy_x", temp), BizInfo[b][data_BUYX] = floatstr (temp);
	        cache_get_field_content(b, "buy_y", temp), BizInfo[b][data_BUYY] = floatstr (temp);
	        cache_get_field_content(b, "buy_z", temp), BizInfo[b][data_BUYZ] = floatstr (temp);
	        cache_get_field_content(b, "exittp_x", temp), BizInfo[b][data_TPEXITX] = floatstr (temp);
	        cache_get_field_content(b, "exittp_y", temp), BizInfo[b][data_TPEXITY] = floatstr (temp);
	        cache_get_field_content(b, "exittp_z", temp), BizInfo[b][data_TPEXITZ] = floatstr (temp);
	        cache_get_field_content(b, "exittp_angle", temp), BizInfo[b][data_ANGLE] = floatstr (temp);

            cache_get_field_content(b, "DayRent", temp), BizInfo[b][bDays] = strval (temp);
            cache_get_field_content(b, "SealedDays", temp), BizInfo[b][bSealedDays] = strval (temp);
            cache_get_field_content(b, "RentCost", temp), BizInfo[b][bRentCost] = strval (temp);
	        
         	TotalBusiness++;

			switch(BizInfo[b][data_TYPE]) 
			{
			    case 1: BizInfo[b][bPriceProduct] = 4, BizInfo[b][data_CENA] = 10;
				case 2: BizInfo[b][bPriceProduct] = 6;
			    case 3: BizInfo[b][bPriceProduct] = 3;
			    case 4: BizInfo[b][bPriceProduct] = 7;
			    case 5: BizInfo[b][bPriceProduct] = 3;
			}

         	if(BizInfo[b][data_TYPE] == 1) 
			{
	     	    if(BizInfo[b][bOwned] == 1) 
				{
                    if(BizInfo[b][bSealedDays] > 0)
                    {
                        format(str_1,sizeof(str_1), "\
                        {FFFFFF}%s {FFD700}�%d\n\
                        {FFFFFF}��������: {FFD700}%s\n\
                        {FF6347}������ ��������", BizInfo[b][bName], BizInfo[b][data_ID], BizInfo[b][bOwner]);
                    }
                    else
                    {
                        format(str_1,sizeof(str_1), "\
                        {FFFFFF}%s {FFD700}�%d\n\
                        {FFFFFF}��������: {FFD700}%s\n\
                        {FFA500}������� �������: K", BizInfo[b][bName], BizInfo[b][data_ID], BizInfo[b][bOwner]);
                    }
                }
				else 
				{
					format(str_1,sizeof(str_1), "{FFFFFF}������: {FFD700}%s\n{FFFFFF}��������� �������: {FFD700}%i ������\n{FFFFFF}�����������: {FFD700}/buybusiness",BizInfo[b][bName], BizInfo[b][bPrice]);
				}
			}
  			else
			{
         	    if(BizInfo[b][bOwned] == 1) 
				{
                    if(BizInfo[b][bSealedDays] > 0)
                    {
                        format(str_1,sizeof(str_1), "\
                        {FFFFFF}������: {FFD700}%s\n\
                        {FFFFFF}��������: {FFD700}%s\n\
                        {FF6347}������ ��������", BizInfo[b][bName], BizInfo[b][bOwner]);
                    }
                    else
                    {
                        format(str_1,sizeof(str_1), "\
                        {FFFFFF}������: {FFD700}%s\n\
                        {FFFFFF}��������: {FFD700}%s", BizInfo[b][bName], BizInfo[b][bOwner]);

                        BizInfo[b][data_PICKEXIT] = CreateDynamicPickup(19132, 23, BizInfo[b][data_EXITX], BizInfo[b][data_EXITY], BizInfo[b][data_EXITZ],BizInfo[b][data_VW]);
                        if(BizInfo[b][data_TYPE] == 2) 
                        {
                            BizInfo[b][bCheckPointForBuy] = CreateDynamicPickup(10270,23,BizInfo[b][data_BUYX], BizInfo[b][data_BUYY], BizInfo[b][data_BUYZ],BizInfo[b][data_VW]);
                            Create3DTextLabel("{FFFFFF}������� 24/7\n{FFD700}������� B", -1, BizInfo[b][data_BUYX], BizInfo[b][data_BUYY], BizInfo[b][data_BUYZ], 3.0, BizInfo[b][data_VW], 0);
                        }
                        else if(BizInfo[b][data_TYPE] == 3) 
                        {
                            BizInfo[b][bCheckPointForBuy] = CreateDynamicPickup(1275,23,BizInfo[b][data_BUYX], BizInfo[b][data_BUYY], BizInfo[b][data_BUYZ],BizInfo[b][data_VW]);
                            Create3DTextLabel("{FFFFFF}������� ������\n{FFD700}������� B", -1, BizInfo[b][data_BUYX], BizInfo[b][data_BUYY], BizInfo[b][data_BUYZ], 3.0, BizInfo[b][data_VW], 0);
                        }
                        else BizInfo[b][bCheckPointForBuy] = CreateDynamicPickup(1239,23,BizInfo[b][data_BUYX], BizInfo[b][data_BUYY], BizInfo[b][data_BUYZ],BizInfo[b][data_VW]);
                    }
				}
				else 
				{
				    format(str_1,sizeof(str_1), "{FFFFFF}������: {FFD700}%s\n{FFFFFF}��������� �������: {FFD700}%i ������\n{FFFFFF}�����������: {FFD700}/buybusiness",BizInfo[b][bName],BizInfo[b][bPrice]);
				    BizInfo[b][data_PICKEXIT] = CreateDynamicPickup(19132, 23, BizInfo[b][data_EXITX], BizInfo[b][data_EXITY], BizInfo[b][data_EXITZ],BizInfo[b][data_VW]);
                    if(BizInfo[b][data_TYPE] == 2) 
					{
						BizInfo[b][bCheckPointForBuy] = CreateDynamicPickup(10270,23,BizInfo[b][data_BUYX], BizInfo[b][data_BUYY], BizInfo[b][data_BUYZ],BizInfo[b][data_VW]);
						Create3DTextLabel("{FFFFFF}������� 24/7\n{FFD700}������� B", -1, BizInfo[b][data_BUYX], BizInfo[b][data_BUYY], BizInfo[b][data_BUYZ], 3.0, BizInfo[b][data_VW], 0);
					}
                    else if(BizInfo[b][data_TYPE] == 3) 
					{
						BizInfo[b][bCheckPointForBuy] = CreateDynamicPickup(1275,23,BizInfo[b][data_BUYX], BizInfo[b][data_BUYY], BizInfo[b][data_BUYZ],BizInfo[b][data_VW]);
						Create3DTextLabel("{FFFFFF}������� ������\n{FFD700}������� B", -1, BizInfo[b][data_BUYX], BizInfo[b][data_BUYY], BizInfo[b][data_BUYZ], 3.0, BizInfo[b][data_VW], 0);
					}
					else BizInfo[b][bCheckPointForBuy] = CreateDynamicPickup(1239,23,BizInfo[b][data_BUYX], BizInfo[b][data_BUYY], BizInfo[b][data_BUYZ],BizInfo[b][data_VW]);
				}
         	}
            BizInfo[b][data_PICKENTER] = CreateDynamicPickup(19132, 23, BizInfo[b][data_ENTERX], BizInfo[b][data_ENTERY], BizInfo[b][data_ENTERZ],-1);
            BizInfo[b][bTextInfo] = CreateDynamic3DTextLabel(str_1, -1,BizInfo[b][data_ENTERX], BizInfo[b][data_ENTERY], BizInfo[b][data_ENTERZ],15.0);
            if(BizInfo[b][data_MAPICON] != -1) BizInfo[b][data_MAPICON] = CreateDynamicMapIcon(BizInfo[b][data_ENTERX], BizInfo[b][data_ENTERY], BizInfo[b][data_ENTERZ], BizInfo[b][data_MAPICON], -1, 0, -1, -1, 200.0);
        }
        if(console_Debbug == 1) printf("[INFO]  Load business. Load: %d b. Time: %d ms.", TotalBusiness, GetTickCount()-time);
  	}
    return 1;
}
//
stock business_OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
    switch(dialogid)
    {
        case 2349:
        {
            if(!response) return callcmd::business(playerid);
			if(response) return 1;
        }
        case 2350: 
        {
            if(!response) return 1;
			if(response) 
            {
				switch(listitem) 
                {
					case 0: ShowBusinessInfo(playerid);
                    case 1: ShowBusinessUpdateMenu(playerid);
					case 2: 
                    {
						new b = PI[playerid][pBusiness];
                        new str_3[1048];
						format(str_3,sizeof(str_3),"\
						{FFFFFF}��� ��������� ������� ������� ����� ��������. ������ ��� � �������\n\
						{FFFFFF}����������� 1 ������ ��������� � ������������ ����������� �������.\n\
						{FFFFFF}���� � ���� ������ ������������� �������� - ������� �� �����.\n\
						{FFFFFF}���������� �� ������ ������ 6 ������ ��������� (����� ������ �� 6 �����)\n\
						{FFFFFF}��������� ����������� ������ ����� � ������ ������������ {FFFF99}(/gps).\n\n\
						{FFFF99}�������� ��������: ���� ����� ����� ��������� ����� 5-7 ����,\n\
						{FFFF99}������ ����� ������ �����������, � ��� - ���������� ����� ��� ���������.\n\n\
						{FFFFFF}��������� �� ������:\t\t {3366cc}%d ����.\n\
						{FFFFFF}����������� ������:\t\t {3366cc}100 ����.\n\
						{FFFFFF}�������� ��� �������:\t\t {3366cc}%d ����.\n\
						{FFFFFF}��������� 1 ������:\t\t {2dc45b}10000 ���\n\n\
						{FFFFFF}������� ���������� ������ ��������� ��� �������:", BizInfo[b][bProduct], 100-BizInfo[b][bProduct]);
			            ShowPlayerDialog(playerid, 2355, DIALOG_STYLE_INPUT, !"{ee3366}���������� ��������",str_3, "������", "�����");
					}
                    case 3:
                    {
                        mysql_string[0] = EOS, f(mysql_string, 85, "SELECT * FROM `"BUSINESS_STATS"` WHERE `bussines_id` = '%d' ORDER BY id DESC;", PI[playerid][pBusiness]);
	                    mysql_tquery(mysql, mysql_string, "ShowBussines", "i", playerid);
                    }
                    case 4:
                    {
                        mysql_string[0] = EOS, f(mysql_string, 85, "SELECT * FROM `"BUSINESS_STATS"` WHERE `bussines_id` = '%d' ORDER BY id DESC;", PI[playerid][pBusiness]);
	                    mysql_tquery(mysql, mysql_string, "ShowBussinesPeople", "i", playerid);
                    }
					case 5: 
                    {
						new b = PI[playerid][pBusiness];

					    DisablePlayerCheckpoint(playerid);
						SetPlayerCheckpoint(playerid, BizInfo[b][data_ENTERX], BizInfo[b][data_EXITY],BizInfo[b][data_ENTERZ]+1,5.0);
				
						SetPVarFloat(playerid, "gps_pos_x", BizInfo[b][data_ENTERX]);
						SetPVarFloat(playerid, "gps_pos_y", BizInfo[b][data_EXITY]);
						SetPVarFloat(playerid, "gps_pos_z", BizInfo[b][data_EXITZ]);

						SCM(playerid,  COLOR_GREY, !"��� ������ ��� ������� �� ����-�����");
					}
					case 6: 
                    {
					    new b = PI[playerid][pBusiness];
						new str_3[185];
						format(str_3,sizeof(str_3),"�� ������� ������� ���� ������ �� {FFFF99}%d ������{FFFFFF}?", BizInfo[b][bPrice]/2);
			            ShowPlayerDialog(playerid, 2354, DIALOG_STYLE_MSGBOX, !"{ee3366}������� �������",str_3, "�������", "������");
					}
				}
			}
        }
        case 2351:
        {
            if(!response) return BusinessMenu(playerid);
			if(response)
			{
			    new b = PI[playerid][pBusiness];
			    if(strval(inputtext) <= 0) return SCM(playerid, COLOR_GREY,"������������ ��������");
				if(strval(inputtext) > BizInfo[b][bMoney]) return SCM(playerid, COLOR_GREY,"������������ ������� �� ������� �������"),Business_Give_Money(playerid);
                BizInfo[b][bMoney] -= strval(inputtext);
				GivePlayerMoneyLog(playerid,strval(inputtext));
				SCMf(playerid,0xc89522FF, "�� �����: %d ������. ������ �������: %d ������",strval(inputtext), BizInfo[b][bMoney]);
				SavePlayerData(playerid);
				SaveBusinessData(b);
			}
        }
		case 2354:
        {
			if(!response) return 1;
			if(response) 
            {
		    	new b = PI[playerid][pBusiness];
		      	BizInfo[b][bOwned] = 0;
		      	BizInfo[b][bDays] = 0;
		      	PI[playerid][pBusiness] = INVALID_BUSINESS_ID;
			 	strmid(BizInfo[b][bOwner], "None", 0, strlen(BizInfo[b][bOwner]), 24);
				GivePlayerMoneyLog(playerid,BizInfo[b][bPrice]/2);
			 	SCMf(playerid, 0xc89522AA, "�� ������� ������ ����������� �� %d ������", BizInfo[b][bPrice]/2);
				UpdateBusinessData(b);
				SaveBusinessData(b);
			  	SavePlayerData(playerid);
   			}
		}
		case 2355: 
        {
  			if(!response) return callcmd::business(playerid);
			if(response) 
            {
                new b = PI[playerid][pBusiness];
                if(strcmp(PI[playerid][pName], BizInfo[b][bOwner], true)) 
                {
		    	    new ProductValue = strval(inputtext);

                    if(ProductValue <= 0) return SCM(playerid, COLOR_GREY, !"����������� ���������� ��������� 1 ��.");
	     			if(BizInfo[b][bProduct] >= 100) return SCM(playerid, COLOR_GREY, !"����� ������� �����");
                    if(ProductValue+BizInfo[b][bProduct] > 100) return SCM(playerid, COLOR_GREY, !"�� ������ ������� ������������ �����");
                    
                    new money = ProductValue*10000;
                    if(GetPlayerMoneyID(playerid) < money) return SCM(playerid, COLOR_GREY, !"� ��� ������������ �� ����� �����");

					GivePlayerMoneyLog(playerid, -money);

					BizInfo[b][bProduct] += ProductValue;

				 	SCMf(playerid, COLOR_GREENNEW, "�� ������ {fe9a7e}%d ��.{00aa33} ���������. ����� ���������: {fe9a7e}%d ��.{00aa33}", ProductValue, BizInfo[b][bProduct]);

					UpdateBusinessData(b);
					SaveBusinessData(b);
					return 1;
				}
			}
		}
    }
    return 1;
}
stock BusinessMenu(playerid) 
{
	ShowPlayerDialog(playerid, 2350, DIALOG_STYLE_LIST, !"{ee3366}���������� ��������", !"\
	1. ����������\n\
    2. ���������� �� ����������\n\
	3. ���������� ��������\n\
    4. ���������� ���������� (�������)\n\
    5. ���������� ���������� (������������)\n\
	6. �������� GPS ����� �� ����-�����\n\
	7. ������� ������", !"�����", !"�������");
	return 1;
}
stock Business_Re_Money(playerid)
{
	SendClientMessage(playerid, COLOR_ADMINCHAT, !"� ����������");
	return 1;
}
stock Business_Give_Money(playerid) 
{
	new str_3[185];
	format(str_3,sizeof(str_3),"�������� �������� 6%\n������� ��������� �����:");
 	ShowPlayerDialog(playerid, 2351, DIALOG_STYLE_INPUT, "{ee3366}C����� �������  �� ����� �������", str_3, "�����", "�����");
	return 1;
}
callback: ShowBussines(playerid)
{
    new rows, fields, temp[10];
    new Data[35], Money, Fin = 0, Float:PercentageChange, Procent[21], Diff, str_1[256*4];
    
    cache_get_data(rows, fields);
    for(new i = 0; i < rows; i++) 
    {
        cache_get_field_content(i, "data", Data, mysql, 35);
        cache_get_field_content(i, "money", temp);
        Money = strval(temp);
        
        if (Fin != 0) 
        {
            Diff = Money - Fin;
            PercentageChange = (Diff / float(Fin)) * 100.0;
        } 
        else 
        {
            PercentageChange = 0.0;
        }

        Fin = Money;

        if (PercentageChange > 0.0) 
        {
            format(Procent, sizeof(Procent), "{2dc45b}+%.2f%%", PercentageChange);
        }
        else if (PercentageChange < 0.0) 
        {
            format(Procent, sizeof(Procent), "{ff6633}%.2f%%", PercentageChange);
        }
        else 
        {
            format(Procent, sizeof(Procent), "{FFFFFF}%.2f%%", PercentageChange);
        }

        format(str_1, sizeof(str_1), "%s%s\t%d ���\t%s\n", str_1, Data, Money, Procent);
    }
    ShowPlayerDialogf(playerid, 0, DIALOG_STYLE_TABLIST_HEADERS, "{ee3366}���������� �������", "�������", "", "����\t�������\t%% � ����������� ���\n%s", str_1);
    return 1;
}
callback: ShowBussinesPeople(playerid)
{
    new rows, fields, temp[10];
    new Data[35], People, LastDayPeople = 0, Float:PercentageChange, Procent[21], Diff, str_1[256*4];
    
    cache_get_data(rows, fields);
    for(new i = 0; i < rows; i++) 
    {
        cache_get_field_content(i, "data", Data, mysql, 35);
        cache_get_field_content(i, "people", temp);
        People = strval(temp);
        
        if (LastDayPeople != 0) 
        {
            Diff = People - LastDayPeople;
            PercentageChange = (Diff / float(LastDayPeople)) * 100.0;
        } 
        else 
        {
            PercentageChange = 0.0;
        }

        LastDayPeople = People;

        if (PercentageChange > 0.0) 
        {
            format(Procent, sizeof(Procent), "{2dc45b}+%.2f%%", PercentageChange);
        }
        else if (PercentageChange < 0.0) 
        {
            format(Procent, sizeof(Procent), "{ff6633}%.2f%%", PercentageChange);
        }
        else 
        {
            format(Procent, sizeof(Procent), "{FFFFFF}%.2f%%", PercentageChange);
        }

        format(str_1, sizeof(str_1), "%s%s\t%d ���\t%s\n", str_1, Data, People, Procent);
    }
    ShowPlayerDialogf(playerid, 0, DIALOG_STYLE_TABLIST_HEADERS, "{ee3366}���������� ������������", "�������", "", "����\t���-�� �����������\t%% � ����������� ���\n%s", str_1);
    return 1;
}
stock ShowBusinessUpdateMenu(playerid)
{
    SendClientMessage(playerid, COLOR_LIGHTGREY, !"������ ����� � ����������");
    ShowPlayerDialog(playerid, 2349, DIALOG_STYLE_TABLIST_HEADERS, !"{ee3366}���������� �� ����������", !"���������\t�������\t����. �������\n\
    {FFFFFF}��������� �����\t{3de87c}0\t{FFD700}4\n\
    {FFFFFF}������� �����\t{3de87c}0\t{FFD700}4\n\
    {FFFFFF}��������\t{3de87c}0\t{FFD700}2\n\
    {FFFFFF}����������� �����\t{3de87c}0\t{FFD700}2", !"�������", !"�����");
    return 1;
}
stock ShowBusinessInfo(playerid) 
{
    new b = PI[playerid][pBusiness];

	new str_3[256*3];
    if(BizInfo[b][data_TYPE] == 1) 
	{
		format(str_3,sizeof(str_3),"\
		��������:\t\t{3173d2}%s\n\
		{FFFFFF}����� �������:\t%d\n\
		{FFFFFF}��������:\t\t%s\n\
		{FFFFFF}���������:\t\t%d ���\n\
		{FFFFFF}�������� �����:\t{3de87c}%d ���\n\
		{FFFFFF}������ ������:\t\t%d �� {FFFF99}(�������� � ����� - /gps)n\
		{FFFFFF}������� �� ������:\t%d �\n\
		{FFFFFF}������:\t\t%d ���\n\
        {FFFFFF}��������:\t\t� {FFFF99}(������ � ������ ������������)",
		BizInfo[b][bName], BizInfo[b][data_ID], BizInfo[b][bOwner], BizInfo[b][bPrice], BizInfo[b][bRentCost], BizInfo[b][bDays], BizInfo[b][bProduct], BizInfo[b][bMoney]);
		ShowPlayerDialog(playerid, 2349, DIALOG_STYLE_MSGBOX, !"{ee3366}���������� � �������", str_3, "�������", "�����");
	}
	else 
	{
		format(str_3,sizeof(str_3),"\
		��������:\t\t{3173d2}%s\n\
		{FFFFFF}����� �������:\t%d\n\
		{FFFFFF}��������:\t\t%s\n\
		{FFFFFF}���������:\t\t%d ���\n\
		{FFFFFF}�������� �����:\t{3de87c}%d ���\n\
		{FFFFFF}������ ������:\t\t%d �� {FFFF99}(�������� � ����� - /gps)\n\
		{FFFFFF}��������� �� ������:\t%d / 100.\n\
		{FFFFFF}������:\t\t%d ���\n\
        {FFFFFF}��������:\t\t� {FFFF99}(������ � ������ ������������)",
		BizInfo[b][bName], BizInfo[b][data_ID], BizInfo[b][bOwner], BizInfo[b][bPrice], BizInfo[b][bRentCost], BizInfo[b][bDays], BizInfo[b][bProduct], BizInfo[b][bMoney]);
		ShowPlayerDialog(playerid, 2349, DIALOG_STYLE_MSGBOX, "{ee3366}���������� � �������", str_3, "�������", "�����");
	}
	return 1;
}
CMD:test_bizfin(playerid)
{
	return SetBusinessUpdate();
}