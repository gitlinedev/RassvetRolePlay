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
    AC_CODE_TRIGGER_TYPE_KICK, // Health hack (in vehicle)
    AC_CODE_TRIGGER_TYPE_KICK, // Health hack (onfoot)
    AC_CODE_TRIGGER_TYPE_KICK, // Armour hack
    AC_CODE_TRIGGER_TYPE_KICK, // Money hack
    AC_CODE_TRIGGER_TYPE_KICK, // Weapon hack
    AC_CODE_TRIGGER_TYPE_KICK, // Ammo hack (add)
    AC_CODE_TRIGGER_TYPE_KICK, // Ammo hack (infinite)
    AC_CODE_TRIGGER_TYPE_KICK, // Special actions hack
    AC_CODE_TRIGGER_TYPE_WARNING, // GodMode from bullets (onfoot)
    AC_CODE_TRIGGER_TYPE_WARNING, // GodMode from bullets (in vehicle)
    AC_CODE_TRIGGER_TYPE_KICK, // Invisible hack
    AC_CODE_TRIGGER_TYPE_KICK, // Lagcomp-spoof
    AC_CODE_TRIGGER_TYPE_KICK, // Tuning hack
    AC_CODE_TRIGGER_TYPE_WARNING, // Parkour mod
    AC_CODE_TRIGGER_TYPE_KICK, // Quick turn
    AC_CODE_TRIGGER_TYPE_KICK, // Rapid fire
    AC_CODE_TRIGGER_TYPE_KICK, // FakeSpawn
    AC_CODE_TRIGGER_TYPE_KICK, // FakeKill
    AC_CODE_TRIGGER_TYPE_WARNING, // Pro Aim
    AC_CODE_TRIGGER_TYPE_WARNING, // CJ run
    AC_CODE_TRIGGER_TYPE_WARNING, // CarShot
    AC_CODE_TRIGGER_TYPE_WARNING, // CarJack
    AC_CODE_TRIGGER_TYPE_KICK, // UnFreeze
    AC_CODE_TRIGGER_TYPE_WARNING, // AFK Ghost
    AC_CODE_TRIGGER_TYPE_WARNING, // Full Aiming
    AC_CODE_TRIGGER_TYPE_KICK, // Fake NPC
    AC_CODE_TRIGGER_TYPE_KICK, // Reconnect
    AC_CODE_TRIGGER_TYPE_WARNING, // High Ping
    AC_CODE_TRIGGER_TYPE_KICK, // Dialog Hack
    AC_CODE_TRIGGER_TYPE_KICK, // Sandbox
    AC_CODE_TRIGGER_TYPE_KICK, // Invalid Version
    AC_CODE_TRIGGER_TYPE_KICK, // Rcon hack
    AC_CODE_TRIGGER_TYPE_KICK, // Tuning crasher
    AC_CODE_TRIGGER_TYPE_KICK, // Invalid seat crasher
    AC_CODE_TRIGGER_TYPE_KICK, // Dialog crasher
    AC_CODE_TRIGGER_TYPE_KICK, // Attached object crasher
    AC_CODE_TRIGGER_TYPE_KICK, // Weapon crasher
    AC_CODE_TRIGGER_TYPE_KICK, // Connects to one slot
    AC_CODE_TRIGGER_TYPE_KICK, // Flood callback functions
    AC_CODE_TRIGGER_TYPE_KICK, // Flood change seat
    AC_CODE_TRIGGER_TYPE_KICK, // DDos
    AC_CODE_TRIGGER_TYPE_KICK // NOP`s
};
stock OnCheatDetected(playerid, code)
{	
    switch AC_CODE_TRIGGER_TYPE[code] do
    {
        case AC_CODE_TRIGGER_TYPE_WARNING:
        {
            PI[playerid][pPlayerDetecting]++;

			global_str[0] = EOS;
            f(global_str, 256, "[����-���] ���������� %s[%d] (#%d/%d %s).", getName(playerid), playerid, PI[playerid][pLevel], code, PI[playerid][pPlayerDetecting], AC_CODE_NAME[code]);
            SendAdminsMessage(COLOR_ADMINCHAT, global_str);
        }
        case AC_CODE_TRIGGER_TYPE_KICK: 
		{
            PI[playerid][pPlayerDetecting]++;

			global_str[0] = EOS;
            f(global_str, 256, "[����-���] ������ %s[%d] (#%d/%d %s).", getName(playerid), playerid, PI[playerid][pLevel], code, PI[playerid][pPlayerDetecting], AC_CODE_NAME[code]);
            SendAdminsMessage(COLOR_ADMINCHAT, global_str);
			SendClientMessagef(playerid, COLOR_BLACK, "�� ���� ������� �� ���������� � ��������� (#%03d)", code);
			Kick(playerid);
		}
        default: return false;
    }
    return 1;
}