#undef KEY_UP
#undef KEY_DOWN
#undef KEY_LEFT
#undef KEY_RIGHT
#define KEY_UP -128
#define KEY_DOWN 128
#define KEY_LEFT -128
#define KEY_RIGHT 128


new AdminFly[MAX_PLAYERS] = {};

new Float:FlyX, Float:FlyY, Float:FlyZ, Float:FlyA;


Float:GetXYInFrontOfPlayer(playerid, &Float:q, &Float:w, Float:distance)
{
	new Float:a;
	GetPlayerPos(playerid, q, w, a);
    if (GetPlayerState(playerid) == PLAYER_STATE_DRIVER) GetVehicleZAngle(GetPlayerVehicleID(playerid), a);
	else GetPlayerFacingAngle(playerid, a);
	q += (distance * floatsin(-a, degrees));
	w += (distance * floatcos(-a, degrees));
	return a;
}

Float:GetXYBehindPlayer(playerid, &Float:q, &Float:w, Float:distance)
{
	new Float:a;
	GetPlayerPos(playerid, q, w, a);
	if (GetPlayerState(playerid) == PLAYER_STATE_DRIVER) GetVehicleZAngle(GetPlayerVehicleID(playerid), a);
	else GetPlayerFacingAngle(playerid, a);
	q += (distance * -floatsin(-a, degrees));
	w += (distance * -floatcos(-a, degrees));
	return a;
}

callback: FlyTimer()
{
    new keys, updown, leftright;
	for (new playerid = 0, max_players = GetMaxPlayers(); playerid < max_players; ++playerid) 
    {
	    if (IsPlayerConnected(playerid) && !IsPlayerNPC(playerid)) 
        {
	        if (AdminFly[playerid]) 
            {
	        	GetPlayerKeys(playerid, keys, updown, leftright);
	            if(updown == KEY_UP) 
                {
	                if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT) 
                    {
						GetPlayerPos(playerid, FlyX, FlyY, FlyZ);
						GetXYInFrontOfPlayer(playerid, FlyX, FlyY, 5.0);
						SetPlayerPos(playerid, FlyX, FlyY, FlyZ);
						SetCameraBehindPlayer(playerid);
					}
					else if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER) 
                    {
						new playercar = GetPlayerVehicleID(playerid);
						GetVehiclePos(playercar, FlyX, FlyY, FlyZ);
						GetXYInFrontOfPlayer(playerid, FlyX, FlyY, 5.0);
						SetVehiclePos(playercar, FlyX, FlyY, FlyZ);
					}
				}
				else if(updown == KEY_DOWN) 
                {
				    if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT) 
                    {
						GetPlayerPos(playerid, FlyX, FlyY, FlyZ);
						GetXYBehindPlayer(playerid, FlyX, FlyY, 5.0);
						SetPlayerPos(playerid, FlyX, FlyY, FlyZ);
						SetCameraBehindPlayer(playerid);
					}
					else if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER) 
                    {
					    new playercar = GetPlayerVehicleID(playerid);
					    GetVehiclePos(playercar, FlyX, FlyY, FlyZ);
					    GetXYBehindPlayer(playerid, FlyX, FlyY, 5.0);
					    SetVehiclePos(playercar, FlyX, FlyY, FlyZ);
					}
				}
				if(leftright == KEY_LEFT) 
                {
					if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT) 
                    {
						GetPlayerFacingAngle(playerid, FlyA);
						SetPlayerFacingAngle(playerid, FlyA+10);
						SetCameraBehindPlayer(playerid);
					}
					else if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER) 
                    {
					    new playercar = GetPlayerVehicleID(playerid);
					    GetVehicleZAngle(playercar, FlyA);
					    SetVehicleZAngle(playercar, FlyA+10);
					}
				}
				else if(leftright == KEY_RIGHT) 
                {
					if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT) 
                    {
						GetPlayerFacingAngle(playerid, FlyA);
						SetPlayerFacingAngle(playerid, FlyA-10);
						SetCameraBehindPlayer(playerid);
					}
					else if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER) 
                    {
					    new playercar = GetPlayerVehicleID(playerid);
					    GetVehicleZAngle(playercar, FlyA);
						SetVehicleZAngle(playercar, FlyA-10);
					}
				}
				if(keys == KEY_JUMP) 
                {
				    if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT) 
                    {
						GetPlayerPos(playerid, FlyX, FlyY, FlyZ);
						SetPlayerPos(playerid, FlyX, FlyY, FlyZ+5);
						SetCameraBehindPlayer(playerid);
					}
					else if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER) 
                    {
						new playercar = GetPlayerVehicleID(playerid);
						GetVehiclePos(playercar, FlyX, FlyY, FlyZ);
						SetVehiclePos(playercar, FlyX, FlyY, FlyZ+5);
					}
				}
				else if(keys == KEY_SPRINT) 
                {
				    if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT) 
                    {
						GetPlayerPos(playerid, FlyX, FlyY, FlyZ);
						SetPlayerPos(playerid, FlyX, FlyY, FlyZ-5);
						SetCameraBehindPlayer(playerid);
					}
					else if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER) 
                    {
						new playercar = GetPlayerVehicleID(playerid);
						GetVehiclePos(playercar, FlyX, FlyY, FlyZ);
						SetVehiclePos(playercar, FlyX, FlyY, FlyZ-5);
					}
				}
			}
		}
	}
}
//
CMD:fly(playerid)
{
    if(AdminFly[playerid] == 1) 
    { 
        AdminFly[playerid] = 0;
        SCM(playerid, -1, !"Вы вышли из режима полёта");
        TogglePlayerControllable(playerid,true); return 1; 
    } 
    else if(AdminFly[playerid] == 0) 
    { 
        AdminFly[playerid] = 1; 
        SCM(playerid, -1, !"Вы вошли в режим полёта");
        TogglePlayerControllable(playerid,false); return 1; 
    } 
    return 1;
}