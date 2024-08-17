new vMaxOnline;
    //vYesterdayOnline;
    //vWeekOnline;

callback: LoadVKInfo()
{
	new rows, fields, temp[10],time = GetTickCount();
    cache_get_data(rows, fields);
    if(rows) 
	{
		cache_get_field_content(0, "max_online", temp), vMaxOnline = strval (temp);
		//cache_get_field_content(0, "yesterday_online", temp), vYesterdayOnline = strval (temp);
		//cache_get_field_content(0, "week_online", temp), vWeekOnline = strval (temp);
		printf("[INFO]  LoadVKInfo. Time: %d ms.",GetTickCount()-time);
	}
	return 1;
}

stock CheckOnline()
{
    new TempOnline = 0;
    foreach(new i:Player) 
    {
        TempOnline++;
    }

    if(vMaxOnline < TempOnline)
    {
        vMaxOnline = TempOnline;
        mysql_tqueryf(mysql, "UPDATE vk_bot SET max_online=%d WHERE id=1", vMaxOnline);
    }
}