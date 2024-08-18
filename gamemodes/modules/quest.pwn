new RentMotoTimerToDetroy[MAX_PLAYERS];
// СИСТЕМА КВЕСТОВ
stock nosov_OnPlayerKeyStateChange(playerid, newkeys)
{
    if(newkeys == 1024)
    {
        if(IsPlayerInRangeOfPoint(playerid, 3.0, 1469.9095,2050.7461,12.5316)) 
        {
            ShowPlayerDialog(playerid, 3434, DIALOG_STYLE_LIST, "{ee3366}Взаимодействие с дурачком", "\
            1. Можете помочь, пожалуйста?\n\
            2. Задания для меня\n\
            3. Хочу арендовать мопед", "Далее", "Закрыть");
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
                    case 0: ShowPlayerDialog(playerid, 0, DIALOG_STYLE_MSGBOX, "{ee3366}Информация", "{FFFFFF}Хаха! Это я-то тебе помогать должен? Скорее наоборот. Впрочем, неважно.\nДля этих целей есть кое-что (команда /help). Полагаю, это тебе поможет. Апчхи!", "Закрыть", "");
                    case 1: SendClientMessage(playerid, COLOR_LIGHTGREY, !"Разработчики ещё не добавили задания для игроков");
                    case 2: 
                    {
                        CEF_ShowPlayerDialogNew(playerid, 3435, "{ee3366}Аренда",\
                            "Да-да, это я сдаю в аренду свои мопеды, не спрашивай откуда они у меня\n\nСтоимость аренды: <strong>250 руб</strong>",\
                            "Если вы покинете мопед и не вернетесь в него в течении 90 секунд он исчезнет. ", "Арендовать", "Отмена");
                    }
                }
            }
        }
        case 3435:
        {
            if(!response) return 1;
            if(response)
            {
                if(PI[playerid][pRentMoto] != INVALID_VEHICLE_ID) return SendClientMessage(playerid, COLOR_GREY, !"Вы уже арендовали мопед");
 				if(GetPlayerMoneyID(playerid) < 450) return SendClientMessage(playerid, COLOR_GREY, !"У Вас недостаточно денег для аренды");
				SendClientMessage(playerid, 0x00aa33AA, !"Вы арендовали мопед у местного дурочка 'Василий' за 250 рублей");

                GivePlayerMoneyLog(playerid, -250);

				PI[playerid][pRentMoto] = CreateVehicle(462, 1483.1671,2054.8171,12.5316,269.5321, 1, 1, 3600);
                CarInfo[PI[playerid][pRentMoto]][cFuel] = 50;
				PutPlayerInVehicleAC(playerid, PI[playerid][pRentMoto], 0);
            }
        }
    }
    return 1;
}
callback: ArendMotoDestroy(playerid) 
{
	SendClientMessage(playerid, COLOR_GREY, !"Вы не сели на мопед в течении 90 секунд, он был отбуксирован");
	DestroyVehicle(PI[playerid][pRentMoto]);
	return PI[playerid][pRentMoto] = INVALID_VEHICLE_ID;
}