//======================[ Anti - Cheat ]======================//
#define AC_MAX_CODES 53
#define AC_MAX_CODE_LENGTH (3 + 1)
#define AC_MAX_CODE_NAME_LENGTH (33 + 1)
#define AC_CODE_TRIGGER_TYPE_DISABLED 0
#define AC_CODE_TRIGGER_TYPE_WARNING 1
#define AC_CODE_TRIGGER_TYPE_KICK 2
#define AC_MAX_TRIGGER_TYPES 3
#define AC_GLOBAL_TRIGGER_TYPE_PLAYER 0
#define AntiCheatKickWithDesync
//======================[ Anti - Cheat ]======================//

stock AC_Kick(playerid, code) return SendAdminsMessagef(COLOR_ADMINCHAT, "[����-��� (������ �������)] %s[%d] (op-code: #%d)", getName(playerid), playerid, code);


static const AC_CODE_NAME[AC_MAX_CODES][AC_MAX_CODE_NAME_LENGTH] = {
	"AirBreak ������",
	"AirBreak � ��",
	"�������� ������",
	"�������� � ��",
	"�������� ����� ��",
	"�������� � �� � ������",
	"�������� pickup",
	"FlyHack ������",
	"FlyHack � ��",
	"SpeedHack �����",
	"SpeedHack � ��",
	"Health hack � ��",
	"Health hack ������",
	"Armour hack",
	"Money hack",
	"Weapon hack",
	"Ammo hack ++",
	"Ammo hack �����������",
	"�������������� �����",
	"GodMode ������",
	"GodMode � ��",
	"Invisible",
	"Lagcomp-spoof",
	"������ �����",
	"������ ���",
	"������� �������",
	"������� �����",
	"Fake-Spawn",
	"Fake-Kill",
	"AimBot",
	"Run hack",
	"CarShot",
	"CarJack",
	"����������",
	"AFK �������",
	"Full Aiming",
 	"Fake NPC",
 	"���������������",
 	"������� ����",
 	"Dialog hack",
 	"��������� hack",
 	"����� ������ ������",
	"SR-Rcon hack",
	"Tuning crasher",
	"Invalid seat crasher",
	"Dialog crasher",
	"Attached object crasher",
	"Weapon Crasher",
	"Connects to one slot",
	"���� ����������� ���������",
	"���� ����� �����",
	"DDos",
	"Nop"
};
new AC_CODE_TRIGGER_TYPE[AC_MAX_CODES] = {
    AC_CODE_TRIGGER_TYPE_WARNING, // Airbreak (onfoot)
    AC_CODE_TRIGGER_TYPE_WARNING, // Airbreak (in vehicle)
    AC_CODE_TRIGGER_TYPE_WARNING, // Teleport (onfoot)
    AC_CODE_TRIGGER_TYPE_WARNING, // Teleport (in vehicle)
    AC_CODE_TRIGGER_TYPE_WARNING, // Teleport (into/between vehicles)
    AC_CODE_TRIGGER_TYPE_WARNING, // Teleport (vehicle to player)
    AC_CODE_TRIGGER_TYPE_WARNING, // Teleport (pickups)
    AC_CODE_TRIGGER_TYPE_WARNING, // FlyHack (onfoot)
    AC_CODE_TRIGGER_TYPE_WARNING, // FlyHack (in vehicle)
    AC_CODE_TRIGGER_TYPE_WARNING, // SpeedHack (onfoot)
    AC_CODE_TRIGGER_TYPE_WARNING, // SpeedHack (in vehicle)
    AC_CODE_TRIGGER_TYPE_WARNING, // Health hack (in vehicle)
    AC_CODE_TRIGGER_TYPE_WARNING, // Health hack (onfoot)
    AC_CODE_TRIGGER_TYPE_WARNING, // Armour hack
    AC_CODE_TRIGGER_TYPE_WARNING, // Money hack
    AC_CODE_TRIGGER_TYPE_WARNING, // Weapon hack
    AC_CODE_TRIGGER_TYPE_WARNING, // Ammo hack (add)
    AC_CODE_TRIGGER_TYPE_WARNING, // Ammo hack (infinite)
    AC_CODE_TRIGGER_TYPE_WARNING, // Special actions hack
    AC_CODE_TRIGGER_TYPE_WARNING, // GodMode from bullets (onfoot)
    AC_CODE_TRIGGER_TYPE_WARNING, // GodMode from bullets (in vehicle)
    AC_CODE_TRIGGER_TYPE_WARNING, // Invisible hack
    AC_CODE_TRIGGER_TYPE_WARNING, // Lagcomp-spoof
    AC_CODE_TRIGGER_TYPE_WARNING, // Tuning hack
    AC_CODE_TRIGGER_TYPE_WARNING, // Parkour mod
    AC_CODE_TRIGGER_TYPE_WARNING, // Quick turn
    AC_CODE_TRIGGER_TYPE_WARNING, // Rapid fire
    AC_CODE_TRIGGER_TYPE_WARNING, // FakeSpawn
    AC_CODE_TRIGGER_TYPE_WARNING, // FakeKill
    AC_CODE_TRIGGER_TYPE_WARNING, // Pro Aim
    AC_CODE_TRIGGER_TYPE_WARNING, // CJ run
    AC_CODE_TRIGGER_TYPE_WARNING, // CarShot
    AC_CODE_TRIGGER_TYPE_WARNING, // CarJack
    AC_CODE_TRIGGER_TYPE_WARNING, // UnFreeze
    AC_CODE_TRIGGER_TYPE_WARNING, // AFK Ghost
    AC_CODE_TRIGGER_TYPE_WARNING, // Full Aiming
    AC_CODE_TRIGGER_TYPE_WARNING, // Fake NPC
    AC_CODE_TRIGGER_TYPE_WARNING, // Reconnect
    AC_CODE_TRIGGER_TYPE_WARNING, // High Ping
    AC_CODE_TRIGGER_TYPE_WARNING, // Dialog Hack
    AC_CODE_TRIGGER_TYPE_WARNING, // Sandbox
    AC_CODE_TRIGGER_TYPE_WARNING, // Invalid Version
    AC_CODE_TRIGGER_TYPE_WARNING, // Rcon hack
    AC_CODE_TRIGGER_TYPE_WARNING, // Tuning crasher
    AC_CODE_TRIGGER_TYPE_WARNING, // Invalid seat crasher
    AC_CODE_TRIGGER_TYPE_WARNING, // Dialog crasher
    AC_CODE_TRIGGER_TYPE_WARNING, // Attached object crasher
    AC_CODE_TRIGGER_TYPE_WARNING, // Weapon crasher
    AC_CODE_TRIGGER_TYPE_WARNING, // Connects to one slot
    AC_CODE_TRIGGER_TYPE_WARNING, // Flood callback functions
    AC_CODE_TRIGGER_TYPE_WARNING, // Flood change seat
    AC_CODE_TRIGGER_TYPE_WARNING, // DDos
    AC_CODE_TRIGGER_TYPE_WARNING // NOP`s
};
callback: OnCheatDetected(playerid, const ip_address[], type, code)
{	
    if(PI[playerid][pPlayerDetecting] >= 20)
    {
        SendClientMessagef(playerid, COLOR_BLACK, "�� ���� ������� �� ���������� � ��������� (#%03d)", code);
        Kick(playerid);
        return 1;
    }
    
    if(PI[playerid][pAdmin] >= 1) return 1;

    if(!IsPlayerConnected(playerid)) return 1;
    if(!IsPlayerLogged{playerid}) return 1;

    switch AC_CODE_TRIGGER_TYPE[code] do
    {
        case AC_CODE_TRIGGER_TYPE_WARNING:
        {
            PI[playerid][pPlayerDetecting]++;

            SendAdminsMessagef(COLOR_ADMINCHAT, "[����-���] ���������� %s[%d] (#%d | �%d - %s).", getName(playerid), playerid, PI[playerid][pPlayerDetecting], code, AC_CODE_NAME[code]);
        }
        case AC_CODE_TRIGGER_TYPE_KICK: 
		{
            SendAdminsMessagef(COLOR_ADMINCHAT, "[����-���] ������ %s[%d] (#%d | �%d - %s).", getName(playerid), playerid, PI[playerid][pPlayerDetecting], code, AC_CODE_NAME[code]);
			SendClientMessagef(playerid, COLOR_BLACK, "�� ���� ������� �� ���������� � ��������� (#%03d)", code);
			Kick(playerid);
		}
        default: return false;
    }
    return 1;
}
stock newac_OnPlayerKeyStateChange(playerid, newkeys)
{
    if (newkeys & KEY_FIRE)
    {
        new weaponid = GetPlayerWeapon(playerid);
        
        if (weaponid == 38)
        {
            if (PI[playerid][pAdmin] <= 0)
            {
                SendClientMessage(playerid, COLOR_BLACK, "�� ���� ������� �� ���������� � ��������� (#991)");
                Kick(playerid);
            }
        }
    }
}