static const stock AdminName[9][6] = {
	"Игрок",
 	"NGM",
 	"JRGM",
 	"GM",
 	"GM+",
 	"LGM",
 	"SGM",
 	"SGM+",
 	"DEV"
};
static const stock ModerName[4][22] = {
	"Игрок",
 	"Junior Moderator (#1)",
 	"Moderator (#2)",
 	"Senior Moderator (#3)"
};
//========================================================== [ Main ] ========================================================//
#define MOVE_SPEED              125.0
#define ACCEL_RATE              0.03

#define MOVE_FORWARD    		1
#define MOVE_BACK       		2
#define MOVE_LEFT       		3
#define MOVE_RIGHT      		4
#define MOVE_FORWARD_LEFT       5
#define MOVE_FORWARD_RIGHT      6
#define MOVE_BACK_LEFT          7
#define MOVE_BACK_RIGHT         8

#define CAMERA_MODE_NONE    	0
#define CAMERA_MODE_FLY     	1

enum NoClipEnum
{
	CameraMode,
	FlyObject,
	Mode,
	Lrold,
	Udold,
	LastMove,
	Float:Accelmul
}
new NoClip[MAX_PLAYERS][NoClipEnum];
//========================================================== [ Modules stocks ] ========================================================//
stock nc_OnPlayerDeath(playerid)
{
	if(NoClip[playerid][CameraMode] == CAMERA_MODE_FLY) CancelFlyMode(playerid);
}

stock nc_OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	if(NoClip[playerid][CameraMode] == CAMERA_MODE_FLY)
	{
  		if(PRESSED(KEY_SPRINT))
  		{
			NoClip[playerid][Accelmul] += 2.5;
		}
		else if(RELEASED(KEY_SPRINT))
		{
			NoClip[playerid][Accelmul] -= 2.5;
		}
		else if(PRESSED(KEY_WALK))
		{
		    NoClip[playerid][Accelmul] = NoClip[playerid][Accelmul]/10;
		}
		else if(RELEASED(KEY_WALK))
		{
		    NoClip[playerid][Accelmul] = 0.0;
		}
	}
}
stock nc_OnPlayerUpdate(playerid)
{
	if(NoClip[playerid][CameraMode] == CAMERA_MODE_FLY)
	{
		new keys,ud,lr;
		GetPlayerKeys(playerid,keys,ud,lr);

		if(NoClip[playerid][Mode] && (GetTickCount() - NoClip[playerid][LastMove] > 100)) MoveCamera(playerid);
		if(NoClip[playerid][Udold] != ud || NoClip[playerid][Lrold] != lr)
		{
			if((NoClip[playerid][Udold] != 0 || NoClip[playerid][Lrold] != 0) && ud == 0 && lr == 0)
			{   
				StopPlayerObject(playerid, NoClip[playerid][FlyObject]);
				NoClip[playerid][Mode]      = 0;
				NoClip[playerid][Accelmul]  = 0.0;
			}
			else
			{
				NoClip[playerid][Mode] = GetMoveDirectionFromKeys(ud, lr);
				MoveCamera(playerid);
			}
		}
		NoClip[playerid][Udold] = ud; NoClip[playerid][Lrold] = lr;
	}
}
stock nc_ClearPlayerData(playerid)
{
	NoClip[playerid][CameraMode] = CAMERA_MODE_NONE;
	NoClip[playerid][Lrold]	= 0;
	NoClip[playerid][Udold] = 0;
	NoClip[playerid][Mode] = 0;
	NoClip[playerid][LastMove] = 0;
	NoClip[playerid][Accelmul] = 0.0;
}
//========================================================== [ Other stocks ] ========================================================//
stock GetMoveDirectionFromKeys(ud, lr)
{
	new direction = 0;

    if(lr < 0)
	{
		if(ud < 0) 		direction = MOVE_FORWARD_LEFT;
		else if(ud > 0) direction = MOVE_BACK_LEFT;
		else            direction = MOVE_LEFT;
	}
	else if(lr > 0)
	{
		if(ud < 0)      direction = MOVE_FORWARD_RIGHT;
		else if(ud > 0) direction = MOVE_BACK_RIGHT;
		else			direction = MOVE_RIGHT;
	}
	else if(ud < 0) 	direction = MOVE_FORWARD;
	else if(ud > 0) 	direction = MOVE_BACK;

	return direction;
}

stock MoveCamera(playerid)
{
	new Float:FV[3], Float:CP[3];
	GetPlayerCameraPos(playerid, CP[0], CP[1], CP[2]);
    GetPlayerCameraFrontVector(playerid, FV[0], FV[1], FV[2]);

	if(NoClip[playerid][Accelmul] <= 1) NoClip[playerid][Accelmul] += ACCEL_RATE;

	new Float:speed = MOVE_SPEED * NoClip[playerid][Accelmul];

	new Float:X, Float:Y, Float:Z;
	GetNextCameraPosition(NoClip[playerid][Mode], CP, FV, X, Y, Z);
	MovePlayerObject(playerid, NoClip[playerid][FlyObject], X, Y, Z, speed);

	NoClip[playerid][LastMove] = GetTickCount();
	return 1;
}
stock GetNextCameraPosition(move_mode, Float:CP[3], Float:FV[3], &Float:X, &Float:Y, &Float:Z)
{
    #define OFFSET_X (FV[0]*6000.0)
	#define OFFSET_Y (FV[1]*6000.0)
	#define OFFSET_Z (FV[2]*6000.0)
	switch(move_mode)
	{
		case MOVE_FORWARD:
		{
			X = CP[0]+OFFSET_X;
			Y = CP[1]+OFFSET_Y;
			Z = CP[2]+OFFSET_Z;
		}
		case MOVE_BACK:
		{
			X = CP[0]-OFFSET_X;
			Y = CP[1]-OFFSET_Y;
			Z = CP[2]-OFFSET_Z;
		}
		case MOVE_LEFT:
		{
			X = CP[0]-OFFSET_Y;
			Y = CP[1]+OFFSET_X;
			Z = CP[2];
		}
		case MOVE_RIGHT:
		{
			X = CP[0]+OFFSET_Y;
			Y = CP[1]-OFFSET_X;
			Z = CP[2];
		}
		case MOVE_BACK_LEFT:
		{
			X = CP[0]+(-OFFSET_X - OFFSET_Y);
 			Y = CP[1]+(-OFFSET_Y + OFFSET_X);
		 	Z = CP[2]-OFFSET_Z;
		}
		case MOVE_BACK_RIGHT:
		{
			X = CP[0]+(-OFFSET_X + OFFSET_Y);
 			Y = CP[1]+(-OFFSET_Y - OFFSET_X);
		 	Z = CP[2]-OFFSET_Z;
		}
		case MOVE_FORWARD_LEFT:
		{
			X = CP[0]+(OFFSET_X  - OFFSET_Y);
			Y = CP[1]+(OFFSET_Y  + OFFSET_X);
			Z = CP[2]+OFFSET_Z;
		}
		case MOVE_FORWARD_RIGHT:
		{
			X = CP[0]+(OFFSET_X  + OFFSET_Y);
			Y = CP[1]+(OFFSET_Y  - OFFSET_X);
			Z = CP[2]+OFFSET_Z;
		}
	}
}

stock CancelFlyMode(playerid)
{
	PI[playerid][pFlyMode] = 0;
	CancelEdit(playerid);
	TogglePlayerSpectating(playerid, false);

	DestroyPlayerObject(playerid, NoClip[playerid][FlyObject]);
	NoClip[playerid][CameraMode] = CAMERA_MODE_NONE;
	return 1;
}
stock FlyMode(playerid)
{
	new Float:X, Float:Y, Float:Z;
	GetPlayerPos(playerid, X, Y, Z);

	PI[playerid][pFlyX] = X;
	PI[playerid][pFlyY] = Y;
	PI[playerid][pFlyZ] = Z;

	NoClip[playerid][FlyObject] = CreatePlayerObject(playerid, 19300, X, Y, Z, 0.0, 0.0, 0.0);

	TogglePlayerSpectating(playerid, true);

	AttachCameraToPlayerObject(playerid, NoClip[playerid][FlyObject]);

	PI[playerid][pFlyMode] = 1;
	NoClip[playerid][CameraMode] = CAMERA_MODE_FLY;

	return 1;
}
//========================================================== [ cmd ] ========================================================//
CMD:fly(playerid,params[])
{
	if(CheckAccess(playerid, 1, 1)) return 1;
    
	if(PI[playerid][pFlyMode] == 1) 
	{
		new senderName[MAX_PLAYER_NAME + 20];
		if(PI[playerid][pAdmin]) format(senderName, sizeof(senderName), "%s #%d", AdminName[PI[playerid][pAdmin]], PI[playerid][pAdminNumber]);
		else format(senderName, sizeof(senderName), "%s", ModerName[PI[playerid][pModer]]);

		SendAdminsMessagef(COLOR_ADMINCHAT, "[%s] %s[%d] вышел из режима полета", senderName, PI[playerid][pName], playerid);

		CancelFlyMode(playerid);

		new skin = GetSkinOfPlayer(playerid);

		SetPlayerVirtualWorld(playerid, PI[playerid][pFlyVirtualWorld]);
		SetPlayerInterior(playerid, PI[playerid][pFlyInt]);

		SetSpawnInfoEx(playerid, skin, PI[playerid][pFlyX], PI[playerid][pFlyY], PI[playerid][pFlyZ], 180.0);
	}
	else 
	{
		new senderName[MAX_PLAYER_NAME + 20];
		if(PI[playerid][pAdmin]) format(senderName, sizeof(senderName), "%s #%d", AdminName[PI[playerid][pAdmin]], PI[playerid][pAdminNumber]);
		else format(senderName, sizeof(senderName), "%s", ModerName[PI[playerid][pModer]]);

		SendAdminsMessagef(COLOR_ADMINCHAT, "[%s] %s[%d] вошел в режим полета", senderName, PI[playerid][pName], playerid);

		FlyMode(playerid);
		SCM(playerid, 0xdbdbdbFF, "Зажмите {ff7139}LEFT SHIFT{dbdbdb} чтобы лететь быстрее или {ff7139}LEFT ALT{dbdbdb} чтобы лететь медленнее");
	}
	return true;
}