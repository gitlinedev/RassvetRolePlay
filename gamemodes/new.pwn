@include_a_samp_();
@include_a_samp_()
{
    #emit    stack    0x7FFFFFFF
    #emit    inc.s    cellmax
    static const ___[][] = {"protected from", "deamx"};
    #emit    retn
    #emit    load.s.pri    ___
    #emit    proc
    #emit    proc
    #emit    fill    cellmax
    #emit    proc
    #emit    stack    1
    #emit    stor.alt    ___
    #emit    strb.i    2
    #emit    switch    4
    #emit    retn
L1:
	#emit    jump    L1
	#emit    zero    cellmin
}
new 
	global_str[4097],
	cef_text[256],
	SQL_STRING[4097],
	request_str[512],
	chat_str[256],
	mysql_string[1048*2];

#include <a_samp>

#undef MAX_PLAYERS
#define MAX_PLAYERS 500

#include Pawn.CMD
#include streamer
#include sampvoice
#include a_mysql
#include sscanf2
#include crashdetect
#include mxdate
#include fmt
#include CRP
#include KeyListener
#include foreach
#include cef
#include a_http
#include nex-ac

#define SCM SendClientMessage
#define SCMf SendClientMessagef
#define mf mysql_format
#define f format

#define mysql_tqueryf(%0,%1,%2)         	SQL_STRING[0] = EOS, mysql_format(%0, SQL_STRING, sizeof(SQL_STRING), %1, %2) && mysql_tquery(%0, SQL_STRING)// && printf(%1,%2)
#define mysql_queryf(%0,%1,%2,%3) 	    	SQL_STRING[0] = EOS, mysql_format(mysql, SQL_STRING, sizeof(SQL_STRING), %1, %3) && mysql_query(%0, SQL_STRING, %2)// && printf(%1,%2)
#define SendAdminsMessagef(%0,%1,%2) 		global_str[0] = EOS, format(global_str, 256, %1, %2) && SendAdminsMessage(%0, global_str)
#define SendFractionMessagef(%0,%1,%2,%3) 	global_str[0] = EOS, format(global_str, 256, %2, %3) && SendFractionMessage(%0, %1, global_str)
#define SendDepMessagef(%0,%1,%2) 			global_str[0] = EOS, format(global_str, 256, %1, %2) && SendDepMessage(%0, global_str)
#define getName(%0)  						PI[%0][pName]


main() {
	print("\n____________________________\n");
	print("Rassvet RolePlay");
	print("Sairus Games © 2024'");
	print("\n____________________________");
}

//======================[ клиент - настройки ]======================//
new Coolldown_Capture = 1;
new XDON = 2;
//======================[ Настройки сервера ]======================//
#define VK                 "rassvet_fun"
#define FREE               "rassvet_fun"
#define FORUM              "forum-rassvet-rp.ru"
#define SITE               "rassvet-rp.ru"
#define NAMESERVER 		   "Rassvet RP"
#define NAMEVIP 		   "Рассвет Плюс"
#define ENERGO 		       "RassvetEnegrgy"
#define GAMEMODENAME 	   "Main"
#define VIP_TAG			   "R+"
//======================[ Конфигурация ТС ]======================//
#define GARAGE_INT_MERIYA 1
#define GARAGE_INT_MVD 2
#define GARAGE_INT_CRB 3
#define GARAGE_INT_VCH 4
#define GARAGE_INT_GOPOTA 5
#define GARAGE_INT_SKINHEAD 6
#define GARAGE_INT_OFFCLUB 7
//======================[ Максы ]======================//
#define MAX_BANS 				5000
#define MAX_VIP					8000
#define MAX_KV   				600
#define MAX_HOUSES      		150
#define MAX_BUSINESS            150
#define MAX_GROUP	            500
#define MAX_OWNABLECARS 		2000
//======================[ Цвета ]======================//
#define COLOR_BLUE              0x33AAFFFF
#define COLOR_LIGHTBLUE 		0x6495EDFF
#define COLOR_WHITE 		    0xFFFFFFFF
#define COLOR_GREY		 		0xAFAFAFAA
#define COLOR_GREENNEW			0x00aa33AA
#define COLOR_YELLOW			0xFFFF00FF
#define COLOR_LIGHTYELLOW		0xFFFF99FF
#define COLOR_TOMATO      		0xFF6347FF
#define COLOR_BLACK             0x5e5e5eFF
#define COLOR_GREY              0xAFAFAFAA
#define COLOR_GREEN 			0x42B02CFF
#define COLOR_LIGHTGREEN 		0x9ACD32FF	
#define COLOR_BLACKBLUE			0x3366ccFF
#define COLOR_HINT 				0x6699ffFF
#define COLOR_LIGHTORANGE 		0xff6633FF
#define COLOR_LIGHTGREY 		0xCCCCCCFF
#define COLOR_LIGHTBLUE_2 		0x66CCFFFF
#define COLOR_CORAL 			0x468a93FF
#define COLOR_MALINOVKA         0xee3366FF
#define COLOR_BLACKRED 			0xcc3366FF
#define COLOR_ADMINCHAT         0x8fbedb00
#define COLOR_JOBYELLOW 		0xffcd00FF
//======================[ Система Тайзера]======================//
#define TAZE_WEAPON 23 3 	// ID оружия на тазер, 3 - дубинка
#define TAZE_TIMER 15 		// через сколько разморозит
#define TAZE_LOSEHP 1 		// 1 - не терять хп при ударе тазером, 0 - терять
//======================[ Новыя хуйня ]======================//
FixSVarString(str[], size = sizeof(str)) for (new i = 0; ((str[i] &= 0xFF) != '\0') && (++i != size);) {}
//======================[ Макросы ]======================//
#define NONE_3D_TEXT 						(Text3D:-1)
#define PRESSED(%0) 						(((newkeys & (%0)) == (%0)) && ((oldkeys & (%0)) != (%0)))
#define RELEASED(%0) 						(((newkeys & (%0)) != (%0)) && ((oldkeys & (%0)) == (%0)))
#define callback:%0(%1)						forward %0(%1) ; public %0(%1)
//======================[ Система походки ]======================//
#define WALK_DEFAULT    		0
#define WALK_NORMAL     		1
#define WALK_PED        		2
#define WALK_GANGSTA    		3
#define WALK_GANGSTA2   		4
#define WALK_OLD        		5
#define WALK_FAT_OLD    		6
#define WALK_FAT        		7
#define WALK_LADY       		8
#define WALK_LADY2      		9
#define WALK_WHORE      		10
#define WALK_WHORE2     		11
#define WALK_DRUNK      		12
#define WALK_BLIND      		13
//======================[ Other ]======================//
#define KEY_AIM 				(128)
#define MAX_FRACTIONS         	8
#define INVALID_KV_ID 			-1
#define INVALID_HOUSE_ID 		-1
#define INVALID_BUSINESS_ID 	-1
#define INVALID_JB_ID           -1
#define INVALID_AB_ID           -1
#define cena_24                 5
#define cena_azs                3
#define cena_clothes            2
#define cena_gun                6
#define cena_eat                2
#define GATES_CLOSED  			1
#define GATES_OPEN      		2
#define MAX_GANGZONE 			104
#define AC_MAX_CODES 					53
#define AC_MAX_CODE_LENGTH 				(3 + 1)
#define AC_MAX_CODE_NAME_LENGTH 		(33 + 1)
#define AC_CODE_TRIGGER_TYPE_DISABLED 	0
#define AC_CODE_TRIGGER_TYPE_WARNING 	1
#define AC_CODE_TRIGGER_TYPE_KICK 		2
#define AC_MAX_TRIGGER_TYPES			3
#define AC_GLOBAL_TRIGGER_TYPE_PLAYER 	0
//===============================[ Iterator ]=======================================//
new Iterator: Admin<MAX_PLAYERS>;
new Iterator: Moder<MAX_PLAYERS>;
//===============================[ Loaded ]=======================================//
new LoadedHouse;
new LoadedBiz;
new LoadedKV;
new LoadedOwnable;
//===============================[ OTHER ]=======================================//
new ShowCar[MAX_PLAYERS][15];
new AccessCar[MAX_PLAYERS][15];
//
new	bool:IsPlayerLogged[MAX_PLAYERS char];
new	bool:RegisterNow[MAX_PLAYERS char];

new const monthNames[12][9] = {
    "январь", "февраль", "март", "апрель",
    "май", "июнь", "июль", "август",
    "сентябрь", "октябрь", "ноябрь", "декабрь"
};
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
static const stock ModerName[4][17] = {
	"Игрок",
 	"Junior Moderator",
 	"Moderator",
 	"Senior Moderator"
};
static const stock Fraction_Name[MAX_FRACTIONS][32] = {
	"Гражданский",
	"Правительство",
 	"Войсковая часть",
 	"Полиция",
 	"БЦРБ",
 	"Скинхеды",
 	"Гопота",
 	"Кавказцы"
};
enum E_WEATHER_DATA {
	weather_name[25],
	weather_id,
	weather_degrees
};
new Float:Bankomats[4][3] = {
	{1797.31, 2503.82, 15.48},
	{2114.6213, 1802.0273, 12.2200},
	{2382.6541, 1955.5677, 15.8600},
	{2328.0881, -1805.9023, 22.4540}
};
new weather[][E_WEATHER_DATA] = {
	{"ясная погода", 18, 31},
	{"облачная погода", 18, 16},
	{"гром", 18, 17},
	{"сильный ветер", 18, 21},
	{"ясная погода", 18, 36}
};
enum SL {
	member,
	rang,
	f_name[20]
}
static pPickupID[MAX_PLAYERS];
new setleader_config[][SL] = {

	{1, 10,"Правительство"},
	{2, 10,"Войсковая часть"},
	{3, 10,"Полиция"},
	{4, 10,"БЦРБ"},
	{5, 10,"Скинхеды"},
	{6, 10,"Гопота"},
	{7, 10,"Кавказцы"}
};
enum StopWar {
	frac_id,
	org_name[20]
}
new StopWar_cfg[][StopWar] = {

	{5,"Скинхеды"},
	{6,"Гопота"},
	{7,"Кавказцы"}
};
new SelectSkinM[][] = {
	{134},
	{135},
	{137},
	{230},
	{239}
};
new SelectSkinF[][] = {
	{196},
	{197},
	{199}
};
static const stock VehicleNames[][] = {
	"BMW X5", "Lincoln Continental ", "Mercedes-Benz Е63","Mercedes-Benz Actros", "ВАЗ 2101", "Mitsubishi Lancer X", "Dumper", "КаМАЗ", "Зил 130","Mercedes GL63","Audi R8","Lada Kalina",
	"Lexus GSF","Nissan Titan 2017","BMW M5","Porsche 911","Ambulance","Скорая помощь","Volkswagen Multivan","ВАЗ 2107","Nissan GTR","Washington","Infiniti JX 35 2013","Mr Whoopee","BF Injection",
	"Hunter","Audi A6","Газель","Инкасатор","ГАЗ-М22","Predator","ЛиАЗ-677М","Rhino","ЗИЛ 131","Hotknife","Trailer","Toyota MarkII","Ikarus 260","ГАЗ-2402",
	"ИЖ-412","Rumpo","RC Bandit","Romero","Packer","Monster","ЗИЗ-45","Squalo","Seasparrow","Pizzaboy","Tram","Trailer","Turismo","Speeder",
	"Reefer","Tropic","Flatbed","ГАЗ-3309","Caddy","Audi A6","Berkley's RC Van","Skimmer","PCJ-600","Faggio","Freeway","RC Baron","RC Raider",
	"BMW 535i","Mercedes GLE","Sanchez","Sparrow","Patriot","Audi A7","Coastguard","Dinghy","ГАЗ-21И","Toyota Land Cruiser","Rustler","ZR3 50","ИЖ-27151","ВАЗ-2114",
	"Toyota Supra","Велосипед","Burrito","ПАЗ-3205","Marquis","ГАЗ 2402","Dozer","Maverick","News Chopper","Chevrolet Niva","FBI Rancher","Virgo","ВАЗ 2109",
	"Jetmax","Hotring","Sandking","ЗАЗ-1102","Police Maverick","Boxville","ГАЗ-53","УАЗ-69","RC Goblin","Hotring A","Mercedes-Benz GLE 63 AMG",
	"Bloodring Banger","Mercedes-Benz GLE 63 AMG","Super GT","ГАЗ-2401"," УАЗ-452","Велик","Горный велик","Beagle","Cropdust","Stunt","КАМАЗ-54115","КАЗ-608В",
	"ВАЗ-21099","РАФ-2203"," ЕРАЗ-672","Shamal","Hydra","ИЖ Планета 5","NRG-500","Урал","Cement Truck","Эвакуатор","Fortune","Cadrona","FBI Truck",
	"Willard","Forklift","Tractor","Combine","Feltzer","Remington","Slamvan","Blade","Freight","Streak","Vortex","М5 F90","Lamborghini Aventador","ВАЗ 2424",
	"Москвич-434","Firetruck","Москвич-400","Москвич-2125","Москвич-2140","Cargobob","ЗАЗ-968А","Sunrise","ГАЗ 31105","Utility","Nevada","УАЗ-3303","ЗАЗ-968М","Monster A",
	"Monster B","Lamborghini Huracan Devo","Acura NSX GT3","Orange Porshe","ИЖ Москвич-427","Elegy","Raindance","RC Tiger","ВАЗ 2108","ВАЗ 2104","Savanna","Bandito","Freight","Trailer",
	"Kart","Mower","Duneride","Sweeper","ГАЗ-М20","Москвич-408","AT-400","ЗИЛ-157","Mercedes-Benz G63 AMG 2019","BMW X5M","BF-400","Newsvan","Tug","Trailer A","Emperor",
	"Восход 3М","Euros","ЛиАЗ-677","Club","Trailer B","Trailer C","Andromada","Dodo","RC Cam","Launch","ГАЗ-2401","ВАЗ 21099",
	"ВАЗ 2114","УАЗ 469","ИЖ-2717","S.W.A.T.","Rolls Royce Phantom 2018","Phoenix","Glendale","Sadler","L Trailer A","L Trailer B",
	"Stair Trailer","ЛАЗ-699Р","Farm Plow","U Trailer"
};
enum gangzone {
	gzid,
	Float:gzminx,
	Float:gzminy,
	Float:gzmaxx,
	Float:gzmaxy,
	gzopg,
	standart_opg,
}

new OfferTimer[MAX_PLAYERS];
new SetMarkerTimer[MAX_PLAYERS];

new const weapon_names[][] = {
/*  0 */{"Кулак"},                      /*  1 */{"Кастет"},                     /*  2 */{"Клюшка для гольфа"},
/*  3 */{"Полицейская дубинка"},        /*  4 */{"Нож"},                        /*  5 */{"Бейсбольная бита"},
/*  6 */{"Лопата"},                     /*  7 */{"Кий"},                        /*  8 */{"Катана"},
/*  9 */{"Бензопила"},                  /* 10 */{"Большой дилдо"},              /* 11 */{"Малый дилдо"},
/* 12 */{"Большой вибратор"},           /* 13 */{"Малый вибратор"},             /* 14 */{"Цветы"},
/* 15 */{"Трость"},                     /* 16 */{"Граната"},                    /* 17 */{"Слезоточивый газ"},
/* 18 */{"Коктейль Молотова"},          /* 19 */{""},							/* 20 */{""},										/* 21 */{""}, 				/* 22 */{"ТТ"},
/* 23 */{"Тайзер"},            			/* 24 */{"ПЛ-15"},				/* 25 */{"Дробовик"},
/* 26 */{"Обрез"},                      /* 27 */{"Автоматический дробовик"},    /* 28 */{"Узи"},
/* 29 */{"MP5"},                        /* 30 */{"АК-47"},                      /* 31 */{"M4"},
/* 32 */{"TEC-9"},                      /* 33 */{"Винтовка"},                   /* 34 */{"Снайперская винтовка"},
/* 35 */{"Гранатомёт"},                 /* 36 */{"Самонаводящийся гранатомёт"}, /* 37 */{"Огнемёт"},
/* 38 */{"Пулемёт"},                    /* 39 */{"Взрывпакет"},                 /* 40 */{"Детонатор"},
/* 41 */{"Баллончик с краской"},        /* 42 */{"Огнетушитель"},               /* 43 */{"Фотоаппарат"},
/* 44 */{"Прибор ночного видения"},     /* 45 */{"Тепловизор"},                 /* 46 */{"Парашют"}
};
static const stock ColorTeam[MAX_FRACTIONS][7] = {
	"FFFFFF",
	"ffeb9c",
 	"009900",
 	"2222FF",
 	"ff99cc",
 	"663399",
 	"66CCFF",
 	"339933"
};
new SkinMale[][] = {
	{134, 999},
	{137, 999},
	{230, 999},
	{239, 999},
	{134, 2000},
	{212, 2000},
	{200, 5000},
	{160, 2000},
	{49, 7500},
	{40, 7500},
	{241, 9999},
	{137, 30000},
	{273, 30000},
	{264, 39000},
	{254, 40000},
	{249, 45000},
	{23,  55000},
	{181, 75000},
	{42, 100000},
	{149, 129000},
	{223, 149000},
	{43, 149000},
	{137, 210000},
	{294, 340000},
	{174, 400000},
	{185, 450000},
	{208, 499999}
};
new SkinFeMale[][] = {
	{129, 999},
	{130, 999},
	{77, 999},
	{152, 5000},
	{157, 5000},
	{56, 5000},
	{145, 7500},
	{151, 7500},
	{40, 10000},
	{41, 10000},
	{55, 20000},
	{87, 30000},
	{93, 35000},
	{139, 50000},
	{141, 75000},
	{85, 90000},
	{12, 100000},
	{201, 149000},
	{246, 179000}
};
enum carColors {
	colorCar,
	hexColor[7],
}
new colorVeh[53][carColors] = {
	{0,"000000"},
	{1,"F5F5F5"},
	{2,"2A77A1"},
	{3,"840410"},
	{4,"263739"},
	{5,"86446E"},
	{6,"D78E10"},
	{7,"4C75B7"},
	{8,"BDBEC6"},
	{9,"5E7072"},
	{10,"46597A"},
	{16,"335F3F"},
	{17,"730E1A"},
	{18,"7B0A2A"},
	{19,"9F9D94"},
	{20,"3B4E78"},
	{21,"732E3E"},
	{22,"691E3B"},
	{23,"96918C"},
	{24,"515459"},
	{32,"8494ab"},
	{40,"473532"},
	{44,"193826"},
	{79,"0e316d"},
	{87,"395a83"},
    {100,"406C8F"},
	{101,"1F253B"},
	{102,"AB9276"},
	{103,"134573"},
	{104,"96816C"},
	{105,"64686A"},
	{106,"105082"},
	{107,"A19983"},
	{108,"385694"},
	{109,"525661"},
	{110,"7F6956"},
	{111,"8C929A"},
	{112,"596E87"},
	{113,"473532"},
	{114,"44624F"},
	{115,"730A27"},
	{116,"223457"},
	{117,"640D1B"},
	{118,"A3ADC6"},
	{119,"695853"},
	{120,"9B8B80"},
	{121,"620B1C"},
	{122,"5B5D5E"},
	{123,"624428"},
	{124,"731827"},
	{125,"1B376D"},
	{126,"EC6AAE"},
	{161,"993e4d"}
};
enum color_info {
	ciCar,
	ciTD,
}
new color_veh[48][color_info] = {

	{1,0xF5F5F5FF},
	{2,0x2A77A1FF},
	{3,0x840410FF},
	{4,0x263739FF},
	{5,0x86446EFF},
	{6,0xD78E10FF},
	{7,0x4C75B7FF},
	{8,0xBDBEC6FF},
	{9,0x5E7072FF},
	{10,0x46597AFF},
    {0,0x000000FF},
    {100,0x406C8FFF},
	{101,0x1F253BFF},
	{102,0xAB9276FF},
	{103,0x134573FF},
	{104,0x96816CFF},
	{105,0x64686AFF},
	{106,0x105082FF},
	{107,0xA19983FF},
	{108,0x385694FF},
	{109,0x525661FF},
	{110,0x7F6956FF},
	{111,0x8C929AFF},
	{112,0x596E87FF},
	{113,0x473532FF},
	{114,0x44624FFF},
	{115,0x730A27FF},
	{116,0x223457FF},
	{117,0x640D1BFF},
	{118,0xA3ADC6FF},
	{119,0x695853FF},
	{120,0x9B8B80FF},
	{121,0x620B1CFF},
	{122,0x5B5D5EFF},
	{123,0x624428FF},
	{124,0x731827FF},
	{125,0x1B376DFF},
	{126,0xEC6AAEFF},
	{109,0x525661FF},
	{16,0x335F3FFF},
	{17,0x730E1AFF},
	{18,0x7B0A2AFF},
	{19,0x9F9D94FF},
	{20,0x3B4E78FF},
	{21,0x732E3EFF},
	{22,0x691E3BFF},
	{23,0x96918CFF},
	{24,0x515459FF}

};
new PLAYER_COLOR_TEAM[10] = {
	0xFFFFFFFF, //
	0xffeb9cFF, // Правительство
	0x009900FF, // армия
	0x2222FFFF, // полиция
	0xff99ccFF, // больница
	0x663399BB, // скинхеды
	0x66CCFFFF, // гопота
	0x339933AA, // кавказ
	0x339999FF, // фсб
	0xd93434FF // сми
};
enum CC {
	COLOR[10]
}
new PLAYER_COLOR_CHAT[10][CC] = {
	"{FFFFFF}",
	"{ffeb9c}", // Правительство
	"{009900}", // армия
	"{2222FF}", // полиция
	"{FF99CC}", // больница
	"{663399}", // скинхеды
	"{66CCFF}", // гопота
	"{339933}", // кавказ
	"{339999}", // фсб
	"{d93434}" // сми
};
enum Dealership_Info {
	asModel,
	asClass[16],
	asDonate,
	asSpeed
};
new DealershipCars[41][Dealership_Info] = {
	{541,"Высокий",900,190},
	{503,"Высокий",685,119},
	{402,"Высокий",675,119},
	{405,"Высокий",670,102},
	{410,"Высокий",529,103},
	{415,"Высокий",570,107},
	{400,"Высокий",500,93},
	{579,"Высокий",915,149},
	{516,"Высокий",850,132},
	{522,"Высокий",430,114},
	{534,"Высокий",470,94},
	{540,"Высокий",570,133},
	{559,"Высокий",520,145},
	{560,"Высокий",1050,162},
	{458,"Высокий",705,122},
	{487,"Высокий",1380,160},
	{401,"Высокий",649,300},
	{403,"Средний",250,56},
	{479,"Средний",420,79},
	{411,"Средний",200,80},
	{413,"Средний",199,61},
	{418,"Средний",150,83},
	{419,"Средний",450,83},
	{422,"Средний",350,69},
	{426,"Средний",290,79},
	{514,"Средний",130,57},
	{523,"Средний",155,105},
	{529,"Средний",115,83},
	{551,"Средний",120,92},
	{555,"Средний",100,81},
	{489,"Низкий",30,35},
	{436,"Низкий",35,65},
	{445,"Низкий",50,69},
	{509,"Низкий",5,60},
	{510,"Низкий",10,60},
	{521,"Низкий",55,101},
	{528,"Низкий",43,98},
	{547,"Низкий",36,92},
	{461,"Низкий",55,98},
	{463,"Низкий",60,105},
	{468,"Низкий",60,103}
};
enum hInfo {
    data_ID,
    data_OWNER[MAX_PLAYER_NAME],
	data_DAY,
	data_CLASS,
	data_OWNED,
	data_PRICE,
	Float:data_CARX,
	Float:data_CARY,
	Float:data_CARZ,
	Float:data_CARANGLE,
	Float:data_ENTERX,
	Float:data_ENTERY,
	Float:data_ENTERZ,
	Float:data_EXITX,
	Float:data_EXITY,
	Float:data_EXITZ,
	data_INT,
	data_LOCK,
	data_PICKUPENTER,
	data_MAPICON,
};
enum E_TELEPORT_STRUCT
{
	T_NAME[65],
	Float: T_PICKUP_POS_X,
	Float: T_PICKUP_POS_Y,
	Float: T_PICKUP_POS_Z,
	T_PICKUP_VIRTUAL_WORLD,
	Float: T_POS_X,
	Float: T_POS_Y,
	Float: T_POS_Z,
	Float: T_ANGLE,
	T_INTERIOR,
	T_VIRTUAL_WORLD,
};
enum frInfo {
	frName[24]
}
enum aname {
	aName[24]
}
new nname[][aname] = {

	{"Fedor_Novosadov"},
    {"Oleg_Duskin"},
    {"Vasily_Evanov"},
    {"Vitaly_Federov"},
    {"Pavel_Karpin"},
    {"Vasily_Rudnitskin"},
    {"Iosif_Falin"},
    {"Leonid_Bunin"},
    {"Dmitry_Bogdanov"},
    {"Spartak_Topolskin"},
    {"Boris_Gurkin"},
	{"Daniil_Rusakov"},
	{"Kirill_Markov"},
	{"Nikita_Prokopov"},
	{"Leonid_Litvin"},
	{"Gavriil_Slutzkov"},
	{"Timur_Zaleskov"},
	{"Pyotr_Sokolkin"},
	{"Ivan_Popovichev"},
	{"Roman_Urbanov"},
	{"Valentin_Doroshin"},
	{"Timur_Novosadov"},
	{"Matvei_Dolin"},
	{"Veniamin_Burdin"},
	{"Rostislav_Orlov"},
	{"Illarion_Rodin"},
	{"Pyotr_Bogdanov"},
	{"Boris_Romanov"},
	{"Ignat_Krupskin"},
	{"Rostislav_Orlov"},
	{"Illarion_Rodin"},
	{"Pyotr_Bogdanov"},
	{"Boris_Romanov"},
	{"Ignat_Krupskin"},
	{"Artur_Primackov"},
	{"Anatoly_Urbanov"},
	{"Albert_Wolskov"},
	{"Alexander_Markowkin"},
	{"Spartak_Kravin"},
	{"Igor_Polskov"},
	{"Timur_Topolskin"},
	{"Timur_Topolskin"},
	{"Afanasy_Kristov"},
	{"German_Petrovichev"},
	{"David_Elin"},
	{"Boris_Tunick"},
	{"Artur_Chaplin"},
	{"Vasily_Sokolkin"},
	{"Valentin_Dubov"},
	{"Spartak_Shubin"},
	{"Abram_Lazarov"},
	{"Robert_Sokolin"},
	{"Robert_Markow"},
	{"Stepan_Darin"},
	{"Viktor_Sadowin"},
	{"Gerasim_Olshanin"},
	{"Pavel_Burdin"},
	{"Albert_Russak"},
	{"Mark_Lukin"},
	{"Igor_Below"},
	{"Yegor_Shubin"},
	{"Marat_Petrow"},
	{"Maxim_Romanowskin"},
	{"Yan_Levin"},
	{"Peter_Levin"},
	{"Marat_Dubstov"}
};
new rang_gov[10][frInfo] = {
    {"Стажёр"},
    {"Водитель"},
    {"Охраник"},
    {"Секретарь"},
    {"Адвокат"},
    {"Налоговый инспектор"},
    {"Помощник Депутата"},
    {"Депутат"},
    {"Вице-Губернатор"},
    {"Губернатор"}
};
new rang_army[10][frInfo] = {
    {"Рядовой"},
    {"Ефрейтор"},
    {"Сержант"},
    {"Прапорщик"},
    {"Мл.Лейтенант"},
    {"Лейтенант"},
    {"Капитан"},
    {"Майор"},
    {"Подполковник"},
    {"Полковник"}
};
new rang_police[10][frInfo] = {
    {"Рядовой"},
    {"Сержант"},
    {"Старшина"},
    {"Прапорщик"},
    {"Мл. Лейтенант"},
    {"Лейтенант"},
    {"Капитан"},
    {"Майор"},
    {"Подполковник"},
    {"Полковник"}
};
new rang_hospital[10][frInfo] = {
    {"Травматолог"},
    {"Отоларинголог"},
    {"Психолог"},
    {"Нарколог"},
    {"Сексолог"},
    {"Ортопед"},
    {"Хирург"},
    {"Онколог"},
    {"Зам.Главного Врача"},
    {"Главный Врач"}
};
new rang_skinhead[10][frInfo] = {
    {"Чмо"},
    {"Пес"},
    {"Торпеда"},
    {"Косой"},
    {"Гвоздь"},
    {"Монгол"},
    {"Доцент"},
    {"Дрег"},
    {"Князь"},
    {"Отец"}
};
new rang_gopota[10][frInfo] = {
    {"Урод"},
    {"Недоделок"},
    {"Хорь"},
    {"Костыль"},
    {"Колька"},
    {"Матёрый"},
    {"Весёлый"},
    {"Рейнджер"},
    {"Директор"},
    {"Отец"}
};
new rang_kavkaz[10][frInfo] = {
    {"Шкура"},
    {"Лычкобой"},
    {"Шнырь"},
    {"Дюбель"},
    {"Тугрик"},
    {"Цыган"},
    {"Интелегент"},
    {"Скал"},
    {"Король"},
    {"Отец"}
};
//================================ [ Переменные ] ======================================//
new Gate;
new GateMove = 0;
new GatePravo;
new GatePravoMove = 0;
new VertletVh[MAX_PLAYERS];
new targplayer[MAX_PLAYERS];
new VertletPolice[MAX_PLAYERS];
new VertletPravo[MAX_PLAYERS];

new TextReset[MAX_PLAYERS];
new NPC_ALL[30],
	NPC_DED,
	NPC_VCH,
	FollowBy[MAX_PLAYERS],
	TimerForPlayer[MAX_PLAYERS],
	WeatherServer,
	bool:pCBugging[MAX_PLAYERS],
	ptmCBugFreezeOver[MAX_PLAYERS],
	ptsLastFiredWeapon[MAX_PLAYERS],
	dalnoboy_trayler[MAX_PLAYERS],
	dalnoboy_car[MAX_PLAYERS],
	gz_info[MAX_GANGZONE][gangzone],
	bool:payday[MAX_PLAYERS],
	Text3D:vehicletext,
	vehicle_static[99],
	WarZone,
	WarZoneCube,
	SkinPost,
	SkinPostTimer,
	GopotaPost,
	GopotaPostTimer,
	KavkazPost,
	KavkazPostTimer,
    ArmyGateOne,
	ArmyGateTwo,
	ArmyGateWatherTwo,
	ArmyGateWatherOne,
	ArmyGateOneTimer,
	ArmyGateOneTimerWather,
	BolkaVorotaTimer,
	PravoVorotaTimer,
	PoliceVorota1,
	PoliceVorotaTimer,
	ArmyStorageDoorTimer,
	dalnaboy_check_pricep[MAX_PLAYERS],
	metall_buy,
	drugs_buy,
	totalgz,
	Dalnoboy_pickup,
	vhodtirkavkaz,
	vihodtirkavkaz,
	vhodtirgopota,
	vihodtirgopota,
	vhodtirskinhed,
	vihodtirskinhed,
	vhodtirvch,
	vihodtirvch,
	vhodtirpravo,
	vihodtirpravo,
	opgintvhod_offklub,
	opgintvihod_offklub,
	opgintvhod_gopota,
	opgintvihod_gopota,
	opgintvhod_skinhead,
	opgintvihod_skinhead,
	VhodArmy1,
	VhodArmy2,
	ArmyShop,
	ExitArmyShop,
	MeriyaGarageVhod,
	MeriyaGarageVihod,
	MVDGarageVhod,
	MVDGarageVihod,
	CRBGarageVhod,
	CRBGarageVihod,
	VchGarageVhod,
	VchGarageVihod,
	GopotaGarageVhod,
	GopotaGarageVihod,
	SkinheadGarageVhod,
	SkinheadGarageVihod,
	OffClubGarageVhod,
	OffClubGarageVihod,
	VhodArmyKazarmy,
	VihodArmyKazarmy,
	VhodArmyStolovaya,
	VihodArmyStolovaya,
	ArmyStolovaya,
	EatPolice,
	EatPolice1,
	VihodVoenkomat,
	SpeedometerUpdate[MAX_PLAYERS],
	VhodMeriya,
	VihodMeriya,
	VhodPravoKrisha,
	VihodPravoKrisha,
	VhodLiftMeriya,
	VihodLiftMeriya,
	VhodKaznaPickup,
	VihodKaznaPickup,
	Kazna_GiveMoney,
	vxoddchmvd0,
    vxoddchmvd1,
	VhodSportzalPolice,
    VihodSportzalPolice,
   	CRBinfo,
	VCHinfo1,
	VCHinfo,
	Pravoinfo,
	Pravoinfo1,
	MVDinfo,
	VhodUchastokMVD0,
	VhodUchastokMVD1,
	MVD_givegun_pickup,
	Pravo_givegun_pickup,
	EnterArmyShop,
	vch_givegun_pickup,

	PalataExit,
	PalataEnter_1,
	PalataEnter_2,
	PalataEnter_3,
	PalataEnter_4,

	LiftMedical_1,
	LiftMedical_2,
	LiftMedicalPersonal_1,
	LiftMedicalPersonal_2,
	LiftMedicalPersonal_3,

	MineEnter,
	MineExit,
	Ordinatorskaya_Enter,
    Ordinatorskaya_Exit,
	ac_gun[MAX_PLAYERS][13],
	Text:AutoSalon_Stats[3],
	Text:AutoSalon_Button[3],
	Text:AutoSalon_ButtonColor[2],
	Text:AutoSalon_Color[48],
	bool:MPStatus,
	bool:MPTeamKill,
	Float:gomp_pos[3],
	help_spawn,
	engine,
	lights_text,
	alarm,
	doors_text,
	bonnet,
	boot,
	objective,
	Menu:SelectSkin,
	mysql,
	global_minute,
	restartserver,
	BusinessUpdate,
	PickupAutoSchool,
	bool:shield[MAX_PLAYERS],
	Float:oldposX[MAX_PLAYERS],Float:oldposY[MAX_PLAYERS],Float:oldposZ[MAX_PLAYERS],
	PlayerText:buy_clothes_m[MAX_PLAYERS],
	Text:buy_clothes[6],
    Text:GZ[1],
	police_barrier[2],
	police_barrier_status[2],
	BCRDEnter,
	BCRDExit,
	CRBPickCard,
	Casino_Enter,
	Casino_Exit,
	PAR_vhod,
	AutoSchool_Enter,
	AutoSchool_Exit,
	AutoSchool_Info,
	AutoSchool_Test,
	vhodbank,
	vihodbank,
	army_wh[3],
	m_gopota,
	m_skinhead,
	m_kavkaz,
	skinhead_wh[4],
	gopota_wh[4],
	kavkaz_wh[4],
	smi_money,
	skinhead_sklad,
	Text3D:skinhead_sklad_text,
	gopota_sklad,
	HOUSE_DATA[MAX_HOUSES][hInfo],
	TotalHouses,
	TotalBusiness,
	TotalGroup,
	TotalBans,
	TotalG,
	Text3D:gopota_sklad_text,
	kavkaz_sklad,
	Text3D:kavkaz_sklad_text,
	army_sklad,
	gov_car[10],
	army_car[10],
	police_car[10],
	hospital_car[10],
	skinhead_car[10],
	gopota_car[10],
	rasform[MAX_PLAYERS],
	kavkaz_car[10],
	pick_bank[3],
	CheckCarHP,
	CHANGE_NAME[MAX_PLAYERS],
	ArmyStorageZone,
	Text3D:army_sklad_text,
	VchSkladGate,
	VchSkladGateTimer,
	spawn_vihod,
	spawn_vhod;
//======================[ Группы ]======================//
enum GROUP_DATA
{
	g_ID,
	g_NAME[24],
	g_FRACTION,
	g_SKIN,
	g_SKING,
	g_STANDART
};
new group[MAX_GROUP][GROUP_DATA];
//======================[ Игроки ]======================//
enum P_DATA
{
	pID,
	data_UID,
	pGroupID,
	pAdminReports,
	pCinematicMode,
	pDeathOnCapture,
	pRentMoto,
	pAdminEvents,
	pAdminWarn,	
	pModerWarn,
	pRankUPTime,
	pAdminNumber,
	pStartJob,
	pCarGift,
	pName[MAX_PLAYER_NAME],
	pRegIP[32+1],
	pLoginIP[32+1],
	pPassword[32+1],
	pEmail[51],
	pGroupName[30],
	data_TAG[50+1],
	pReferal[MAX_PLAYER_NAME],
	pLogDateDat,
	pLogDateMonth,
	pLogDateYear,
 	pSex,
	pSkin,
    pMoney,
	pAdmin,
	pModer,
	pVKNotif,
	data_PRIZETIME,
	data_PRIZEGIVE,
	data_SendName[MAX_PLAYER_NAME],
	pLevel,
	pMember,
	data_BL,
	pLeader,
	pRang,
	pRang9,
	pOrgSkin,
	pTakeAcs,
	data_TRANSFER,
	data_TRANSFER_FRAC,
	data_TRANSFER_RANG,
	pExp,
	pMute,
	pMuteTime,
	pVmute,
	pVmuteTime,
	pWarn,
	pWarnTime,
	pPayDayMoney,
	pBank,
	pDriveLicense,
	pGunLicense,
	pLicNumber,
	pBusiness,
	pHouse,
	pAmmo,
	pDrugs,
	pUserDrugs,
	pWanted,
	pRespect,
	pNumber,
	pNumberMoney,
	pPhoneStatus,
	pCanisters,
	pMetall,
	pJailTime,
	pJail,
 	pDonate,
	pAccessory_10,
	pAccessory_9,
	pAccessory_8,
	pAccessory_7,
	pAccessory_6,
	pAccessory_5,
	pAccessory_4,
	pAccessory_3,
	pAccessory_2,
	pAccessory_1,
	pUseAccessory,
	pPhone,
	pPhoneBook,
	pSatiety,
	Float:pHealthPoints,
	Float:pArmour,
	data_MED,
	data_MEDNUM,
	data_SPAWN,
	pHospital,
 	pDemorgan,
 	pDemorganTime,
	pWeaponLock,
	pSkillPistol,
	pSkillSDPistol,
	pSkillDeagle,
	pSkillShotgun,
	pSkillMP5,
	pSkillAK47,
	pSkillRifle,
	data_JOB,
	data_PADIK,
	pFloat,
	pSchoolTestLvl[10],
	pProgressMetall,
	pProgressDrugs,
	pProgressAmmo,
	pProgressCarGrabber,
	pCaptureManager,
	pOnCapture,
	pProgressSellGun,
	pProgressCapture,
	pPromoCodeUse,
	pPromoCode,
	Float:pLeavePosX,
	Float:pLeavePosY,
	Float:pLeavePosZ,
	// NO SAVE
	pAdminChat,
	pAdminWatherDriver,
	pAdminNoReload,
	pCaptureKills,
	pCaptureValue,
	pPlayerDetecting,
	pAdminStatus,
	pChangeSkin,
	pSelectSkin,
	bool:data_ANIM,
	data_WALK_TIMER,
	data_WALK_STYLE,
	data_3SECOND,
	data_TESTER,
	data_MINUTE,
	data_PLAYER_TIMER_ID,
	LoadCefInformation,
	pAFK,
	data_PU,
	data_ASH_CAR,
	data_ASH_TEST,
	data_CHEK,
	pLoadVehicleID,
	pHealPack,
	pHealthPackKD,
	pMask,
	pMaskWorn,
	data_CALL,
	bool:data_CLICKTD,
	bool:data_CLOTHESMENU,
	bool:pInAutoSalon,
	pAutoSalonCar,
	pChangerAutoSalon,
	pChangerAutoSalonb,
	pAutoSalonColor,
	bool:data_EFIR,
	data_911_1,
    data_911_2,
    data_GUN[13],
	data_AMMO[13],
	data_PUTPATR,
	data_PUTMET,
	pVIP,
	data_TIME,
	pVkontakteID,
	pMilitaryID,
	pMedCard,
	Float:pOnMPX,
	Float:pOnMPY,
	Float:pOnMPZ,
	pOnMP,
	pTwarn,
	pFixPack,
	//TEMP INFO
	pSetMarker,
	Float:pRun,
	pFlyMode,
	pFlyInt,
	pFlyVirtualWorld,
	Float:pFlyX,
	Float:pFlyY,
	Float:pFlyZ,
	pTempJob,
	PTempJobValue_1,
	PTempJobValue_2,
	pTempJobMoney,
	pTempStopWar,
	pTempMember,
	pTempBankID,
	pTempBankCash,
	pTempBankName[MAX_PLAYER_NAME],
	// Предложения
	pRequest,
	pRequestType,
	pRequestValue_1,
	pRequestValue_2,
	pRequestFrom,
	pRequestFor
};
new PI[MAX_PLAYERS][P_DATA];
enum BanData {
	pID,
	pDay
}
new BansData[MAX_BANS][BanData];
enum playerBanGun 
{
	pID,
	pDay
}
new BanGun[MAX_BANS][playerBanGun];

enum 
{
	dialog_KONCERT,
	dialog_SETNAME,
	dialog_ABACK,
	dialog_REGISTER,
	dialog_EMAIL,
	dialog_LOGIN,
	dialog_BGUN,
	dialog_REFERAL,
	dialog_TOKIN,
	dialog_SEX,
	dialog_DISCONNECT,
	dialog_ANIM,
	dialog_SETTING,
	dialog_SETTING_1,
	dialog_SETTING_2,
	dialog_CHANGE_NAME,
	dialog_COMMAND,
	dialog_REPORT,
	dialog_BAN,
	dialog_ADMINS,
	dialog_WARNTIME,
	dialog_DONATE,
	dialog_TAKE,
	dialog_DONATE_VIP,
	dialog_CONVERT,
	dialog_SPAWNHELP,
	dialog_SPAWNLAST,
	dialog_SETSKIN,
	dialog_SETSKINDEV,
	dialog_HOUSE,
	dialog_SELL_HOUSE,
	dialog_ENTER_HOUSE,
	dialog_EXIT_HOUSE,
	dialog_ASH_TEST,
	dialog_BUYGUN,
	dialog_BUYGUN_1,
	dialog_ADD_HOUSE,
	dialog_ADD_HOUSE_1,
	dialog_ADD_HOUSE_2,
	dialog_ADD_HOUSE_3,
	dialog_EAT_MENU,
	dialog_BANK,
	dialog_PERERAS,
	dialog_SELLCAR_1,
	dialog_SKLAD,
	dialog_SKLAD_1,
	dialog_SKLAD_2,
	dialog_SKLAD_3,
	dialog_SKLAD_4,
	dialog_SKLAD_5,
	dialog_SKLAD_6,
	dialog_MAKEGUN,
	dialog_MAKEGUN_1,
	dialog_GUN_POLICE,
	dialog_ADMCOMMAND,
	dialog_TP,
    Dialog_offpas,
	dialog_schoolinfo,
	dialog_schooltest,
	dialog_schooltest1,
	dialog_schooltest2,
	dialog_schooltest3,
	dialog_schooltest4,
	dialog_schoolclose,
	dialog_dalnoboy,
	dialog_bcrbjob,
	dialog_skladjob,
	dialog_salonjob,
	dialog_dbjob,
	dialog_gorajob,
	dialog_GIVEGUNPRAVO,
	dialog_SETGZ
};
//
enum cInfo
{
    cID,
    cOwner[25],
	cModel,
	cTemp, 
	cPremium,
	cColor_1,
	cColor_2,
	Float:cPos_X,
	Float:cPos_Y,
	Float:cPos_Z,
    Float:cPos_A,
 	cFuel,
	cCost,
	cNoPark,
	cLock,
	cKey,
	cMetall,
	cAmmo,
	cEngineStatus,
	cLamp,
	cLoad,
	cLoadValue,
	cRent,
	cCreate,
	cAutoSchool
};
new CarInfo[MAX_OWNABLECARS][cInfo];
//
static PedMale[5] = {14,20,21,22,24};
static PedFeMale[6] = {10,12,13,31,38,39};
//=============================== [ МОДУЛЬНАЯ СИСТЕМА ] ====================================//
#include "modules/vk.pwn"
#include "modules/capture.pwn"
#include "modules/proposition.pwn"
#include "modules/quest.pwn"
#include "modules/blacklist.pwn"
#include "modules/business.pwn"
#include "modules/showmenu.pwn"
#include "modules/army.pwn"
#include "modules/admin.pwn"
#include "modules/mine.pwn"
#include "modules/cef.pwn"
//#include "modules/apartments.pwn"
#include "modules/floats.pwn"
#include "modules/voicechat.pwn"
#include "modules/mapping.pwn"
#include "modules/game_moder.pwn"
#include "modules/organisation.pwn"
#include "modules/anticheat.pwn"
#include "modules/stamina.pwn"
#include "modules/fly.pwn"
#include "modules/bank_system.pwn"
#include "modules/police.pwn"
//=========================================================================================//
stock GivePlayerMetall(playerid, amount)
{
    if(IsPlayerConnected(playerid))
	{
	    PI[playerid][pMetall] += amount;
		UpdatePlayerDataInt(playerid, "met", PI[playerid][pMetall]);
    }
}
stock Float:PointToPoint(Float:x,Float:y,Float:z,Float:x2,Float:y2,Float:z2)
{
	return floatsqroot(floatpower(floatabs(floatsub(x2,x)),2)+floatpower(floatabs(floatsub(y2,y)),2)+floatpower(floatabs(floatsub(z2,z)),2));
}
stock GetVehicleSpeed(vehicleid) 
{
    new Float:Px,Float:Py,Float:Pz;
    GetVehicleVelocity(vehicleid,Px,Py,Pz);
    return floatround(floatsqroot(Px*Px+Py*Py+Pz*Pz) * 100.0);
}
callback: RespawnVehicles() 
{
	DestroyVehicle(army_car[0]);
	DestroyVehicle(army_car[1]);
	DestroyVehicle(army_car[2]);
	DestroyVehicle(army_car[3]);
	DestroyVehicle(army_car[4]);
	DestroyVehicle(army_car[5]);
	DestroyVehicle(army_car[6]);
	DestroyVehicle(army_car[7]);
	DestroyVehicle(army_car[8]);
	DestroyDynamic3DTextLabel(vehicletext);
	DestroyVehicle(hospital_car[1]);
	DestroyVehicle(hospital_car[2]);
	DestroyVehicle(hospital_car[3]);
	DestroyVehicle(hospital_car[4]);
	DestroyVehicle(hospital_car[5]);
	DestroyVehicle(hospital_car[6]);
	DestroyVehicle(hospital_car[7]);
	DestroyVehicle(gov_car[1]);
	DestroyVehicle(gov_car[2]);
	DestroyVehicle(gov_car[3]);
	DestroyVehicle(gov_car[4]);
	DestroyVehicle(gov_car[5]);
	DestroyVehicle(gov_car[6]);
	DestroyVehicle(gov_car[7]);
	DestroyVehicle(police_car[1]);
	DestroyVehicle(police_car[2]);
	DestroyVehicle(police_car[3]);
	DestroyVehicle(police_car[4]);
	DestroyVehicle(police_car[5]);
	DestroyVehicle(police_car[6]);
	DestroyVehicle(police_car[7]);
	DestroyVehicle(skinhead_car[1]);
	DestroyVehicle(skinhead_car[2]);
	DestroyVehicle(skinhead_car[3]);
	DestroyVehicle(skinhead_car[4]);
	DestroyVehicle(skinhead_car[5]);
	DestroyVehicle(skinhead_car[6]);
	DestroyVehicle(skinhead_car[7]);
	DestroyVehicle(gopota_car[1]);
	DestroyVehicle(gopota_car[2]);
	DestroyVehicle(gopota_car[3]);
	DestroyVehicle(gopota_car[4]);
	DestroyVehicle(gopota_car[5]);
	DestroyVehicle(gopota_car[6]);
	DestroyVehicle(gopota_car[7]);
	DestroyVehicle(kavkaz_car[1]);
	DestroyVehicle(kavkaz_car[2]);
	DestroyVehicle(kavkaz_car[3]);
	DestroyVehicle(kavkaz_car[4]);
	DestroyVehicle(kavkaz_car[5]);
	DestroyVehicle(kavkaz_car[6]);
	DestroyVehicle(kavkaz_car[7]);
	DestroyVehicle(VertletVh[1]);
	DestroyVehicle(VertletVh[2]);
	DestroyVehicle(VertletVh[3]);
	DestroyVehicle(VertletPravo[1]);
	DestroyVehicle(VertletPravo[2]);
	DestroyVehicle(VertletPolice[1]);
	DestroyVehicle(VertletPolice[2]);
	DestroyVehicle(VertletPolice[3]);
	LoadOrgCars();
	return 1;
}
stock LoadStaticCars() 
{
	GetVehicleParamsEx(vehicle_static[0],engine,lights_text,alarm,doors_text,bonnet,boot,objective);
	SetVehicleParamsEx(vehicle_static[0],engine,lights_text,alarm,true,bonnet,boot,objective);
	GetVehicleParamsEx(vehicle_static[1],engine,lights_text,alarm,doors_text,bonnet,boot,objective);
	SetVehicleParamsEx(vehicle_static[1],engine,lights_text,alarm,true,bonnet,boot,objective);
	GetVehicleParamsEx(vehicle_static[2],engine,lights_text,alarm,doors_text,bonnet,boot,objective);
	SetVehicleParamsEx(vehicle_static[2],engine,lights_text,alarm,true,bonnet,boot,objective);
	GetVehicleParamsEx(vehicle_static[3],engine,lights_text,alarm,doors_text,bonnet,boot,objective);
	SetVehicleParamsEx(vehicle_static[3],engine,lights_text,alarm,true,bonnet,boot,objective);
	GetVehicleParamsEx(vehicle_static[4],engine,lights_text,alarm,doors_text,bonnet,boot,objective);
	SetVehicleParamsEx(vehicle_static[4],engine,lights_text,alarm,true,bonnet,boot,objective);
	return 1;
}
stock LoadOrgCars() 
{
	army_car[0] = -1;
	army_car[1] = -1;
 	army_car[2] = -1;
	army_car[3] = -1;
	army_car[4] = -1;
	army_car[5] = -1;
	army_car[6] = -1;
	army_car[7] = -1;
	army_car[8] = -1;
	VertletVh[1] = -1;
	VertletVh[2] = -1;
	VertletVh[3] = -1;
    hospital_car[1] = -1;
    hospital_car[2] = -1;
    hospital_car[3] = -1;
    hospital_car[4] = -1;
    hospital_car[5] = -1;
    hospital_car[6] = -1;
    hospital_car[7] = -1;
    gov_car[1] = -1;
    gov_car[2] = -1;
    gov_car[3] = -1;
    gov_car[4] = -1;
    gov_car[5] = -1;
    gov_car[6] = -1;
    gov_car[7] = -1;
    police_car[1] = -1;
    police_car[2] = -1;
    police_car[3] = -1;
    police_car[4] = -1;
    police_car[5] = -1;
    police_car[6] = -1;
    police_car[7] = -1;
    skinhead_car[1] = -1;
    skinhead_car[2] = -1;
    skinhead_car[3] = -1;
    skinhead_car[4] = -1;
    skinhead_car[5] = -1;
    skinhead_car[6] = -1;
    skinhead_car[7] = -1;
    gopota_car[1] = -1;
    gopota_car[2] = -1;
    gopota_car[3] = -1;
    gopota_car[4] = -1;
    gopota_car[5] = -1;
    gopota_car[6] = -1;
    gopota_car[7] = -1;
    kavkaz_car[1] = -1;
    kavkaz_car[2] = -1;
    kavkaz_car[3] = -1;
    kavkaz_car[4] = -1;
    kavkaz_car[5] = -1;
    kavkaz_car[6] = -1;
    kavkaz_car[7] = -1;
   	army_car[0] = CreateVehicle(578, 1675.6893,1666.9424,15.5597,0.8229, 1, 1, -1);
	army_car[1] = CreateVehicle(599, -152.6144,628.7219,-50.1706,356.2022, 1, 1, -1);
 	army_car[2] = CreateVehicle(597, -148.8862,628.6601,-50.1706,357.1905, 1, 1, -1);
	army_car[3] = CreateVehicle(597, -140.8531,629.0610,-50.1706,355.4791, 1, 1, -1);
	army_car[4] = CreateVehicle(598, -136.9894,629.2422,-50.1706,358.5539, 1, 1, -1);
	army_car[5] = CreateVehicle(598, -129.2403,628.5641,-50.1706,359.4196, 1, 1, -1);
	army_car[6] = CreateVehicle(598, -128.5097,653.4676,-50.1706,181.3475, 1, 1, -1);
	army_car[7] = CreateVehicle(598, -135.6245,653.2039,-50.1706,176.8134, 1, 1, -1);
	army_car[8] = CreateVehicle(601, 1671.6355,1667.8109,15.6293,1.1148, 1, 1, -1);

	VertletVh[1] = CreateVehicle(548, -2661.7263,435.8972,11.1828,359.9406, 1, 1, -1);
	VertletVh[2] = CreateVehicle(548, -2698.5901,435.8012,11.2348,0.0000, 1, 1, -1);
	VertletVh[3] = CreateVehicle(548, -2736.1858,435.5855,11.2284,0.0000, 1, 1, -1);

   	SetVehicleVirtualWorld(army_car[1], GARAGE_INT_VCH);
    LinkVehicleToInterior(army_car[1], 1);
   	SetVehicleVirtualWorld(army_car[2], GARAGE_INT_VCH);
    LinkVehicleToInterior(army_car[2], 1);
   	SetVehicleVirtualWorld(army_car[3], GARAGE_INT_VCH);
    LinkVehicleToInterior(army_car[3], 1);
   	SetVehicleVirtualWorld(army_car[4], GARAGE_INT_VCH);
    LinkVehicleToInterior(army_car[4], 1);
   	SetVehicleVirtualWorld(army_car[5], GARAGE_INT_VCH);
    LinkVehicleToInterior(army_car[5], 1);
   	SetVehicleVirtualWorld(army_car[6], GARAGE_INT_VCH);
    LinkVehicleToInterior(army_car[6], 1);
   	SetVehicleVirtualWorld(army_car[7], GARAGE_INT_VCH);
    LinkVehicleToInterior(army_car[7], 1);
	new textmz[144];
	format(textmz,sizeof(textmz),"{2d69b4}МЗКТ\n{33dd66}Патроны: {33dd66}%d/10000 шт.\n{33dd66}Металл: {33dd66}%d/10000 кг.", CarInfo[army_car[0]][cAmmo], CarInfo[army_car[0]][cMetall]);
	vehicletext = CreateDynamic3DTextLabel(textmz, 0x3366FFFF, 1749.4796,1750.9102,15.4706, 15, INVALID_PLAYER_ID, army_car[0], 0, -1);
    hospital_car[1] = CreateVehicle(416, -152.6144,628.7219,-50.1706,356.2022, 1, 1, -1);
    hospital_car[2] = CreateVehicle(416, -148.8862,628.6601,-50.1706,357.1905, 1, 1, -1);
    hospital_car[3] = CreateVehicle(416, -140.8531,629.0610,-50.1706,355.4791, 1, 1, -1);
    hospital_car[4] = CreateVehicle(416, -136.9894,629.2422,-50.1706,358.5539, 1, 1, -1);
    hospital_car[5] = CreateVehicle(416, -129.2403,628.5641,-50.1706,359.4196, 1, 1, -1);
    hospital_car[6] = CreateVehicle(551, -128.5097,653.4676,-50.1706,181.3475, 1, 1, -1);
    hospital_car[7] = CreateVehicle(551, -135.6245,653.2039,-50.1706,176.8134, 1, 1, -1);
   	SetVehicleVirtualWorld(hospital_car[1], GARAGE_INT_CRB);
    LinkVehicleToInterior(hospital_car[1], 1);
   	SetVehicleVirtualWorld(hospital_car[2], GARAGE_INT_CRB);
    LinkVehicleToInterior(hospital_car[2], 1);
   	SetVehicleVirtualWorld(hospital_car[3], GARAGE_INT_CRB);
    LinkVehicleToInterior(hospital_car[3], 1);
   	SetVehicleVirtualWorld(hospital_car[4], GARAGE_INT_CRB);
    LinkVehicleToInterior(hospital_car[4], 1);
   	SetVehicleVirtualWorld(hospital_car[5], GARAGE_INT_CRB);
    LinkVehicleToInterior(hospital_car[5], 1);
   	SetVehicleVirtualWorld(hospital_car[6], GARAGE_INT_CRB);
    LinkVehicleToInterior(hospital_car[6], 1);
   	SetVehicleVirtualWorld(hospital_car[7], GARAGE_INT_CRB);
    LinkVehicleToInterior(hospital_car[7], 1);
    gov_car[1] = CreateVehicle(551, -152.6144,628.7219,-50.1706,356.2022, 0, 0, -1);
    gov_car[2] = CreateVehicle(494, -148.8862,628.6601,-50.1706,357.1905, 1, 1, -1);
    gov_car[3] = CreateVehicle(494, -140.8531,629.0610,-50.1706,355.4791, 1, 1, -1);
    gov_car[4] = CreateVehicle(418, -136.9894,629.2422,-50.1706,358.5539, 1, 1, -1);
    gov_car[5] = CreateVehicle(418, -129.2403,628.5641,-50.1706,359.4196, 1, 1, -1);
    gov_car[6] = CreateVehicle(479, -128.5097,653.4676,-50.1706,181.3475, 1, 1, -1);
    gov_car[7] = CreateVehicle(480, -135.6245,653.2039,-50.1706,176.8134, 1, 1, -1);
   	VertletPravo[1] = CreateVehicle(487, 1936.0822,-2222.1443,44.4434,0.0005, 1, 1, -1);
	VertletPravo[2] = CreateVehicle(487, 1888.0077,-2222.6887,44.4357,0.0009, 1, 1, -1);
   	SetVehicleVirtualWorld(gov_car[1], GARAGE_INT_MERIYA);
    LinkVehicleToInterior(gov_car[1], 1);
   	SetVehicleVirtualWorld(gov_car[2], GARAGE_INT_MERIYA);
    LinkVehicleToInterior(gov_car[2], 1);
   	SetVehicleVirtualWorld(gov_car[3], GARAGE_INT_MERIYA);
    LinkVehicleToInterior(gov_car[3], 1);
   	SetVehicleVirtualWorld(gov_car[4], GARAGE_INT_MERIYA);
    LinkVehicleToInterior(gov_car[4], 1);
   	SetVehicleVirtualWorld(gov_car[5], GARAGE_INT_MERIYA);
    LinkVehicleToInterior(gov_car[5], 1);
   	SetVehicleVirtualWorld(gov_car[6], GARAGE_INT_MERIYA);
    LinkVehicleToInterior(gov_car[6], 1);
   	SetVehicleVirtualWorld(gov_car[7], GARAGE_INT_MERIYA);
    LinkVehicleToInterior(gov_car[7], 1);
    police_car[1] = CreateVehicle(599, -152.6144,628.7219,-50.1706,356.2022, 1, 1, -1);
    police_car[2] = CreateVehicle(596, -148.8862,628.6601,-50.1706,357.1905, 1, 1, -1);
    police_car[3] = CreateVehicle(597, -140.8531,629.0610,-50.1706,355.4791, 1, 1, -1);
    police_car[4] = CreateVehicle(597, -136.9894,629.2422,-50.1706,358.5539, 1, 1, -1);
    police_car[5] = CreateVehicle(598, -129.2403,628.5641,-50.1706,359.4196, 1, 1, -1);
    police_car[6] = CreateVehicle(598, -128.5097,653.4676,-50.1706,181.3475, 1, 1, -1);
    police_car[7] = CreateVehicle(598, -135.6245,653.2039,-50.1706,176.8134, 1, 1, -1);
   	VertletPolice[1] = CreateVehicle(497, 2423.1506,-1826.6251,35.5234,0.0005, 1, 1, -1);
	VertletPolice[2] = CreateVehicle(497, 2399.3569,-1827.4559,35.5158,0.0010, 1, 1, -1);
	VertletPolice[3] = CreateVehicle(497, 2378.3765,-1827.9022,35.5158,360.0000, 1, 1, -1);
   	SetVehicleVirtualWorld(police_car[1], GARAGE_INT_MVD);
    LinkVehicleToInterior(police_car[1], 1);
   	SetVehicleVirtualWorld(police_car[2], GARAGE_INT_MVD);
    LinkVehicleToInterior(police_car[2], 1);
   	SetVehicleVirtualWorld(police_car[3], GARAGE_INT_MVD);
    LinkVehicleToInterior(police_car[3], 1);
   	SetVehicleVirtualWorld(police_car[4], GARAGE_INT_MVD);
    LinkVehicleToInterior(police_car[4], 1);
   	SetVehicleVirtualWorld(police_car[5], GARAGE_INT_MVD);
    LinkVehicleToInterior(police_car[5], 1);
   	SetVehicleVirtualWorld(police_car[6], GARAGE_INT_MVD);
    LinkVehicleToInterior(police_car[6], 1);
   	SetVehicleVirtualWorld(police_car[7], GARAGE_INT_MVD);
    LinkVehicleToInterior(police_car[7], 1);
    // ТС СКИНХЕДОВ
    skinhead_car[1] = CreateVehicle(404, -120.1114,628.1298,-50.3746,0.0683, 1, 1, -1);
    skinhead_car[2] = CreateVehicle(492, -128.7444,628.2188,-50.3748,359.2198, 1, 1, -1);
    skinhead_car[3] = CreateVehicle(504, -136.2352,628.0240,-50.3748,0.9594, 1, 1, -1);
    skinhead_car[4] = CreateVehicle(418, -148.8755,628.7747,-50.3747,0.1094, 1, 1, -1);
    skinhead_car[5] = CreateVehicle(422, -120.1441,653.5405,-50.3746,179.6092, 1, 1, -1);
    skinhead_car[6] = CreateVehicle(475, -128.5931,653.5984,-50.3746,179.5707, 1, 1, -1);
    skinhead_car[7] = CreateVehicle(400, -136.2937,653.7285,-50.3743,180.1815, 1, 1, -1);
   	SetVehicleVirtualWorld(skinhead_car[1], GARAGE_INT_SKINHEAD);
    LinkVehicleToInterior(skinhead_car[1], 1);
   	SetVehicleVirtualWorld(skinhead_car[2], GARAGE_INT_SKINHEAD);
    LinkVehicleToInterior(skinhead_car[2], 1);
   	SetVehicleVirtualWorld(skinhead_car[3], GARAGE_INT_SKINHEAD);
    LinkVehicleToInterior(skinhead_car[3], 1);
   	SetVehicleVirtualWorld(skinhead_car[4], GARAGE_INT_SKINHEAD);
    LinkVehicleToInterior(skinhead_car[4], 1);
   	SetVehicleVirtualWorld(skinhead_car[5], GARAGE_INT_SKINHEAD);
    LinkVehicleToInterior(skinhead_car[5], 1);
   	SetVehicleVirtualWorld(skinhead_car[6], GARAGE_INT_SKINHEAD);
    LinkVehicleToInterior(skinhead_car[6], 1);
   	SetVehicleVirtualWorld(skinhead_car[7], GARAGE_INT_SKINHEAD);
    LinkVehicleToInterior(skinhead_car[7], 1);
	// ТС ГОПОТЫ
    gopota_car[1] = CreateVehicle(404, -120.1114,628.1298,-50.3746,0.0683, 13, 13, -1);
    gopota_car[2] = CreateVehicle(492, -128.7444,628.2188,-50.3748,359.2198, 13, 13, -1);
    gopota_car[3] = CreateVehicle(504, -136.2352,628.0240,-50.3748,0.9594, 13, 13, -1);
    gopota_car[4] = CreateVehicle(418, -148.8755,628.7747,-50.3747,0.1094, 13, 13, -1);
    gopota_car[5] = CreateVehicle(422, -120.1441,653.5405,-50.3746,179.6092, 13, 13, -1);
    gopota_car[6] = CreateVehicle(475, -128.5931,653.5984,-50.3746,179.5707, 13, 13, -1);
    gopota_car[7] = CreateVehicle(400, -136.2937,653.7285,-50.3743,180.1815, 13, 13, -1);
   	SetVehicleVirtualWorld(gopota_car[1], GARAGE_INT_GOPOTA);
    LinkVehicleToInterior(gopota_car[1], 1);
   	SetVehicleVirtualWorld(gopota_car[2], GARAGE_INT_GOPOTA);
    LinkVehicleToInterior(gopota_car[2], 1);
   	SetVehicleVirtualWorld(gopota_car[3], GARAGE_INT_GOPOTA);
    LinkVehicleToInterior(gopota_car[3], 1);
   	SetVehicleVirtualWorld(gopota_car[4], GARAGE_INT_GOPOTA);
    LinkVehicleToInterior(gopota_car[4], 1);
   	SetVehicleVirtualWorld(gopota_car[5], GARAGE_INT_GOPOTA);
    LinkVehicleToInterior(gopota_car[5], 1);
   	SetVehicleVirtualWorld(gopota_car[6], GARAGE_INT_GOPOTA);
    LinkVehicleToInterior(gopota_car[6], 1);
   	SetVehicleVirtualWorld(gopota_car[7], GARAGE_INT_GOPOTA);
    LinkVehicleToInterior(gopota_car[7], 1);
	// ТС Кавказцев
    kavkaz_car[1] = CreateVehicle(404, -120.1114,628.1298,-50.3746,0.0683, 0, 0, -1);
    kavkaz_car[2] = CreateVehicle(492, -128.7444,628.2188,-50.3748,359.2198, 0, 0, -1);
    kavkaz_car[3] = CreateVehicle(504, -136.2352,628.0240,-50.3748,0.9594, 0, 0, -1);
    kavkaz_car[4] = CreateVehicle(418, -148.8755,628.7747,-50.3747,0.1094, 0, 0, -1);
    kavkaz_car[5] = CreateVehicle(422, -120.1441,653.5405,-50.3746,179.6092, 0, 0, -1);
    kavkaz_car[6] = CreateVehicle(475, -128.5931,653.5984,-50.3746,179.5707, 0, 0, -1);
    kavkaz_car[7] = CreateVehicle(400, -136.2937,653.7285,-50.3743,180.1815, 0, 0, -1);
   	SetVehicleVirtualWorld(kavkaz_car[1], GARAGE_INT_OFFCLUB);
    LinkVehicleToInterior(kavkaz_car[1], 1);
   	SetVehicleVirtualWorld(kavkaz_car[2], GARAGE_INT_OFFCLUB);
    LinkVehicleToInterior(kavkaz_car[2], 1);
   	SetVehicleVirtualWorld(kavkaz_car[3], GARAGE_INT_OFFCLUB);
    LinkVehicleToInterior(kavkaz_car[3], 1);
   	SetVehicleVirtualWorld(kavkaz_car[4], GARAGE_INT_OFFCLUB);
    LinkVehicleToInterior(kavkaz_car[4], 1);
   	SetVehicleVirtualWorld(kavkaz_car[5], GARAGE_INT_OFFCLUB);
    LinkVehicleToInterior(kavkaz_car[5], 1);
   	SetVehicleVirtualWorld(kavkaz_car[6], GARAGE_INT_OFFCLUB);
    LinkVehicleToInterior(kavkaz_car[6], 1);
   	SetVehicleVirtualWorld(kavkaz_car[7], GARAGE_INT_OFFCLUB);
    LinkVehicleToInterior(kavkaz_car[7], 1);
    CarInfo[army_car[0]][cFuel] = 50;
    CarInfo[army_car[1]][cFuel] = 50;
    CarInfo[army_car[2]][cFuel] = 50;
    CarInfo[army_car[3]][cFuel] = 50;
    CarInfo[army_car[4]][cFuel] = 50;
    CarInfo[army_car[5]][cFuel] = 50;
    CarInfo[army_car[6]][cFuel] = 50;
    CarInfo[army_car[7]][cFuel] = 50;
	CarInfo[army_car[8]][cFuel] = 50;
    CarInfo[hospital_car[1]][cFuel] = 50;
    CarInfo[hospital_car[2]][cFuel] = 50;
    CarInfo[hospital_car[3]][cFuel] = 50;
    CarInfo[hospital_car[4]][cFuel] = 50;
    CarInfo[hospital_car[5]][cFuel] = 50;
    CarInfo[hospital_car[6]][cFuel] = 50;
    CarInfo[hospital_car[7]][cFuel] = 50;
    CarInfo[VertletVh[1]][cFuel] = 50;
    CarInfo[VertletVh[2]][cFuel] = 50;
    CarInfo[VertletVh[3]][cFuel] = 50;
    CarInfo[gov_car[1]][cFuel] = 50;
    CarInfo[gov_car[2]][cFuel] = 50;
    CarInfo[gov_car[3]][cFuel] = 50;
    CarInfo[gov_car[4]][cFuel] = 50;
    CarInfo[gov_car[5]][cFuel] = 50;
    CarInfo[gov_car[6]][cFuel] = 50;
    CarInfo[gov_car[7]][cFuel] = 50;
    CarInfo[police_car[1]][cFuel] = 50;
    CarInfo[police_car[2]][cFuel] = 50;
    CarInfo[police_car[3]][cFuel] = 50;
    CarInfo[police_car[4]][cFuel] = 50;
    CarInfo[police_car[5]][cFuel] = 50;
    CarInfo[police_car[6]][cFuel] = 50;
    CarInfo[police_car[7]][cFuel] = 50;
    CarInfo[skinhead_car[1]][cFuel] = 50;
    CarInfo[skinhead_car[2]][cFuel] = 50;
    CarInfo[skinhead_car[3]][cFuel] = 50;
    CarInfo[skinhead_car[4]][cFuel] = 50;
    CarInfo[skinhead_car[5]][cFuel] = 50;
    CarInfo[skinhead_car[6]][cFuel] = 50;
    CarInfo[skinhead_car[7]][cFuel] = 50;
    CarInfo[gopota_car[1]][cFuel] = 50;
    CarInfo[gopota_car[2]][cFuel] = 50;
    CarInfo[gopota_car[3]][cFuel] = 50;
    CarInfo[gopota_car[4]][cFuel] = 50;
    CarInfo[gopota_car[5]][cFuel] = 50;
    CarInfo[gopota_car[6]][cFuel] = 50;
    CarInfo[gopota_car[7]][cFuel] = 50;
    CarInfo[kavkaz_car[1]][cFuel] = 50;
    CarInfo[kavkaz_car[2]][cFuel] = 50;
    CarInfo[kavkaz_car[3]][cFuel] = 50;
    CarInfo[kavkaz_car[4]][cFuel] = 50;
    CarInfo[kavkaz_car[5]][cFuel] = 50;
    CarInfo[kavkaz_car[6]][cFuel] = 50;
    CarInfo[kavkaz_car[7]][cFuel] = 50;
	return 1;
}
stock SaveGZ(gzopg1, gz)
{
    mysql_string[0] = EOS, mf(mysql, mysql_string, 65, "UPDATE `gangzone` SET `gzopg` = '%d' WHERE `gzid` = '%d'", gzopg1, gz_info[gz][gzid]);
	mysql_function_query(mysql, mysql_string, false, "", "");
	return 1;
}
stock GivePlayerHealth(playerid, Float:health) 
{
	new Float:hp;
	GetPlayerHealth(playerid, hp);
	SetPlayerHealthAC(playerid,hp+health);
}
stock GivePlayerArmour(playerid,Float:Armour, Float:Armplayer)
{
    if(Armplayer+Armour < 0) SetPlayerArmour(playerid, 0);
	else SetPlayerArmour(playerid, Armplayer+Armour);
}
public OnPlayerTakeDamage(playerid, issuerid, Float:amount, weaponid, bodypart) return 1;
public OnPlayerGiveDamage(playerid, damagedid, Float:amount, weaponid, bodypart) 
{
    if(PI[playerid][pMember] == 3) 
	{
		if(weaponid == 23 || weaponid == 3)
		{
			new Float:health, Float:x, Float:y, Float:z;
			GetPlayerHealth(damagedid,health);
			GetPlayerPos(damagedid, x, y, z); ClearAnimations(damagedid);

			SCMf(playerid,  COLOR_BLACKBLUE, "Вы успешно оглушили игрока: %s", PI[damagedid][pName]);
			SCMf(damagedid, COLOR_BLACKBLUE, "Сотрудник Полиции %s оглушил вас на 15 секунд", PI[playerid][pName]);

			TogglePlayerControllable(damagedid, 0);
			SetTimerEx("TazerEffect", 15*1000, false, "d", damagedid);

			ApplyAnimation(damagedid, "PED", "COWER", 4.0, 1, 0, 0, 0, 0);

			SetPlayerHealth(damagedid, health+amount);
		}
	}
	new Float:Health, Float:hpcar, CarID = INVALID_VEHICLE_ID;
	GetPlayerHealth(damagedid, Health);

	if(GetPlayerState(damagedid) == PLAYER_STATE_DRIVER) 
	{
		CarID = GetPlayerVehicleID(damagedid);
		GetVehicleHealth(CarID, hpcar);
	}
	if(playerid != INVALID_PLAYER_ID) 
	{
		PlayerPlaySound(playerid, 6401, 0.0, 0.0, 10.0);
		
		if(PI[playerid][pOnMP] == 0 && MPTeamKill == false) 
		{
			if(PI[playerid][pMember] == 0) return 1;
			if(PI[damagedid][pMember] == PI[playerid][pMember] && GetPlayerVirtualWorld(playerid) == 0) 
			{
				if(IsPlayerInAnyVehicle(damagedid)) SetVehicleHealth(CarID, hpcar);
				SetPlayerHealthAC(damagedid, Health);
				SCMf(playerid, COLOR_GREY, "Урон заблокирован: игрок %s[%d] является вашим союзником", PI[damagedid][pName], damagedid);
				return 0;
			}
		}
		if(PI[damagedid][pAdminStatus] == 1) 
		{
			SetPlayerHealthAC(damagedid, 250);
			if(IsPlayerInAnyVehicle(damagedid)) SetVehicleHealth(CarID, hpcar);
			SCM(playerid, COLOR_GREY, !"Урон заблокирован: игрок является Игровым Мастером");
			return 0;
		}
		if(!IsPlayerCops(playerid)) 
		{
			if(IsPlayerGreenZone(damagedid))
			{
				if(IsPlayerInAnyVehicle(damagedid)) SetVehicleHealth(CarID, hpcar);
				SCMf(playerid, COLOR_GREY, "Урон заблокирован: игрок %s[%d] находится в Зелёной Зоне", PI[damagedid][pName],damagedid);
				SetPlayerHealthAC(damagedid, Health);
				return 0;
			}
			else if(IsPlayerGreenZone(playerid))
			{
				if(IsPlayerInAnyVehicle(damagedid)) SetVehicleHealth(CarID, hpcar);
				SCM(playerid, COLOR_GREY, !"Урон заблокирован: вы находитесь в Зелёной Зоне");
				SetPlayerHealthAC(damagedid, Health);
				SetPlayerArmedWeapon(playerid, 0);
				return 0;
			}
		}
	}
	return 1;
}
callback: CheckDalnaboyPricep(playerid) return 1;
stock IsTextInvalid(text[]) 
{
	if(strfind(text, "'", true) != -1) return 1;
	if(strfind(text, "=", true) != -1) return 1;
	if(strfind(text, "%", true) != -1) return 1;
	if(strfind(text, "&", true) != -1) return 1;
	if(strfind(text, "*", true) != -1) return 1;
	if(strfind(text, "(", true) != -1) return 1;
	if(strfind(text, ")", true) != -1) return 1;
	if(strfind(text, ",", true) != -1) return 1;
	if(strfind(text, "`", true) != -1) return 1;
	if(strfind(text, ";", true) != -1) return 1;
	if(strfind(text, "|", true) != -1) return 1;
	return 0;
}
callback: ArmyGateClose() 
{
	MoveObject(ArmyGateOne, -2660.59, 266.60, 12.32, 1.00, 0.00, 0.00);
	MoveObject(ArmyGateTwo, -2665.55, 266.60, 12.32, 1.00, 0.00, 0.00);
	return KillTimer(ArmyGateOneTimer);
}
callback: ArmyGateCloseWather() 
{
	MoveObject(ArmyGateWatherTwo, -2764.77, 406.67, 12.35, 1.00, 0.00, -90.00);
	MoveObject(ArmyGateWatherOne, -2764.75, 401.72, 12.35, 1.00, 0.00, -90.00);
	return KillTimer(ArmyGateOneTimerWather);
}
callback: BolkaVorotaClose() 
{
    MoveObject(Gate,2123.1838, 1798.8187, 12.5628, 2.5,  0.00, 0.00, 90.00);
	return KillTimer(BolkaVorotaTimer);
}
callback: PravoVorotaClose()
{
    MoveObject(GatePravo,1872.55, -2228.84, 11.91, 2.5,  0.00, 0.00, 0.00);///закрытое
	return KillTimer(PravoVorotaTimer);
}
callback: PoliceVorotaClose() 
{
	MoveObject(PoliceVorota1,1891.89, 1724.66, 15.69, 2.5,   0.00, 0.00, 92.00);
	return KillTimer(PoliceVorotaTimer);
}
callback: SkinPostClose() 
{
	MoveObject(SkinPost,1461.0179, 2340.8840, 12.5690, 1, 0.00, 90.00, 90.00);
	return KillTimer (SkinPostTimer);
}
callback: GopotaPostClose() 
{
	MoveObject(GopotaPost,2221.4264, -2578.8955, 21.6831, 1, 0.30, -90.00, -1.56);
	return KillTimer (GopotaPostTimer);
}
callback: KavkazPostClose() 
{
	MoveObject(KavkazPost,-336.7794, -1084.9222, 40.9260, 1,0.00, 90.00, -31.41);
	return KillTimer (KavkazPostTimer);
}

public OnPlayerWeaponShot(playerid, weaponid, hittype, hitid, Float:fX, Float:fY, Float:fZ) 
{
	return 1;
}
public OnVehicleDamageStatusUpdate(vehicleid, playerid) 
{
    new Float:hp;
    new carid = GetPlayerVehicleID(playerid);
    GetVehicleHealth(carid, hp);
    if(hp > 351) 
	{
		SendPlayerCenterNotify(playerid, 2, "Авария (двигатель заглох)", 5);
		GetVehicleParamsEx(carid,engine,lights_text,alarm,doors_text,bonnet,boot,objective);
		SetVehicleParamsEx(carid,false,lights_text,alarm,doors_text,bonnet,boot,objective);
		CarInfo[carid][cEngineStatus] = 0;

		new Float:x, Float:y, Float:z;
		GetPlayerPos(playerid, x, y, z);
		switch(random(2)) 
		{
		    case 0: PlayerPlaySound(playerid, 1148, x, y, z);
		    case 1: PlayerPlaySound(playerid, 1009, x, y, z);
			case 2: PlayerPlaySound(playerid, 1009, x, y, z);
		}
    }
    return 1;
}
stock GetString(const param1[], const param2[])
{
    return !strcmp(param1, param2, false);
}
callback: SetRandomWeather() 
{
	new rand = random(sizeof weather);
	SendClientMessageToAllf(COLOR_GREEN, "[Прогноз погоды] в области ожидается %s (+%d °С)", weather[rand][weather_name], weather[rand][weather_degrees]);
    WeatherServer = weather[rand][weather_id];
	return SetWeather(WeatherServer);
}
stock ConnectMySQL()
{
    new currenttime = GetTickCount();

	new sql = 0;
	if(!sql) mysql = mysql_connect("127.0.0.1", "gs269723", "gs269723", "6CKII67VlSAR"); // основа (0)
	else mysql = mysql_connect("127.0.0.1", "gs87610", "gs87610", "cs0gy97c"); // тест (1)

	switch(mysql_errno())
	{
		case 0: print("Подключение к базе данных удалось");
	    case 1044: return print("Подключение к базе данных не удалось [Указано несуществующее имя пользователя]");
	    case 1045: return print("Подключение к базе данных не удалось [Указан неправильный пароль]");
	    case 1049: return print("Подключение к базе данных не удалось [Указана несуществующая база данных]");
	    case 2003: return print("Подключение к базе данных не удалось [Хостинг с базой данных недоступен]");
	    case 2005: return print("Подключение к базе данных не удалось [Указан неправильный адрес хостинга]");
	    default: return printf("Подключение к базе данных не удалось [Неизвестная ошибка. Код ошибки: %d]", mysql_errno());
	}
	//mysql_log(LOG_ALL); 
	mysql_log(LOG_ERROR | LOG_WARNING);

	mysql_query(mysql, "SET NAMES 'cp1251'", false);
	mysql_set_charset("cp1251", mysql);
    printf("=======> mysql connect %d", mysql);
	//
	mysql_function_query(mysql, "SELECT * FROM `warehouse`",true, "LoadWarehouse", "");
	mysql_function_query(mysql, "SELECT * FROM `group`",true, "LoadGroups", "");
	mysql_function_query(mysql, "SELECT * FROM `kvartiry`",true, "LoadKV", "");
	mysql_function_query(mysql, "SELECT * FROM `houses`",true, "LoadHouses", "");
	mysql_function_query(mysql, "SELECT * FROM `business`",true, "LoadBusiness", "");
	mysql_function_query(mysql, "SELECT * FROM `gangzone`",true, "LoadGZ", "");
	mysql_function_query(mysql, "SELECT * FROM `vk_bot`",true, "LoadVKInfo", "");
	//
    printf("MySQL загрузился за %i ms", GetTickCount() - currenttime);
    SendRconCommand("ackslimit 10000");
	SendRconCommand("messageholelimit 10000");

	EnableAntiCheat(39, 0);
	EnableAntiCheat(3, 0);
	EnableAntiCheat(6, 0);
	EnableAntiCheat(12, 0);
    return true;
}
public OnGameModeInit()
{
	new currenttime = GetTickCount();
	//=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
	Iter_Clear(Admin);
	Iter_Clear(Moder);
	SetGameModeText(GAMEMODENAME);
	//=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
	gstream = SvCreateGStream(COLOR_GREEN, "");
	SvDebug(SV_FALSE);
	//=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
	cef_subscribe("cefstudio:callback:dialog:response", "CallbackDialogResponse"); 
	cef_subscribe("cef:select:clothes", "CEF_SelectClothes");
	//=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
	ClearCapture();
	//=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-	
	CheckCarHP = SetTimer("CheckCarHealth", 1000, 1);
	SetTimer("SecondTimer", 1000, true);
	SetTimer("MinutTimer", 1000*60, true);
	SetTimer("ChangeServer0", 500, false);
	SetTimer("FlyTimer", 100, 1);
	//
	RunTimer = SetTimer("RunCheck", 10, 1);
	//=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
	ArmyStorageZone = CreateDynamicCircle(-2569.5022, 450.7665, 5.0, -1, -1, -1);
	WarZoneCube = CreateDynamicCube(1540.5142, -1188.6774, 1.9030, 1647.0428, -1296.2592, 45.9030, 0, 0, -1);
	//=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
	SetNameTagDrawDistance(30.0);
	LimitPlayerMarkerRadius(70.0);
	EnableStuntBonusForAll(0);
	DisableInteriorEnterExits();
	ManualVehicleEngineAndLights();
	ShowPlayerMarkers(2);
   	SetGravity(0.008);
	//=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
	LoadTextDraws();
	LoadOrgCars();
	LoadStaticCars();
	ConnectMySQL();

	LoadMappingModule();
	
	//=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
	SelectSkin = CreateMenu("Victim", 1, 50.0, 160.0, 90.0);
	SetMenuColumnHeader(SelectSkin, 0, "Choose skin");
	AddMenuItem(SelectSkin,0,"> Next");
	AddMenuItem(SelectSkin,0,"< Back");
	AddMenuItem(SelectSkin,0,"Select");
	//=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

	new hour, minute, second;
	gettime(hour, minute, second);
	SetWorldTime(hour);
	
	for(new i = 0; i < MAX_VEHICLES; i++) 
	{
		ClearCarData(i);
		CarInfo[i][cFuel] = 50;
	}
	//FMT
	fmt_toggle_crp_mode(true);
	fmt_toggle_dialog_callback(true);
	//FMT
	restartserver = 0;
	BusinessUpdate = 0;

	capture_OnGameModeInit();
	//stamina_OnGameModeInit();
	//=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
	army_sklad_text = CreateDynamic3DTextLabel("{f18c2b}Армейский склад", -1, -2569.5925,450.9106,10.9316, 20,INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, 0);
	Create3DTextLabel("{FFFFFF}Помощь для новичков", -1, 2748.1580,-2458.2456,21.6890, 10.0, 0);

	PickupAutoSchool = CreateDynamicPickup(1239, 23, 1915.1434, 2232.8154, 16.2557, 0);
	help_spawn = CreateDynamicCP(2748.1580,-2458.2456,21.6890,1.0,0,0,-1,5.0);

	police_barrier_status[0] = GATES_CLOSED;
	police_barrier_status[1] = GATES_CLOSED;

	for(new i;i < sizeof(Bankomats); i ++) CreateDynamicPickup(1212, 1, Bankomats[i][0], Bankomats[i][1], Bankomats[i][2], -1);
	CreateObject(2942, 1796.85, 2503.71, 15.46,   0.00, 0.00, 127.04); // Банкомат Спавн

	CreateDynamicMapIcon(-394.8579,-1364.6385,41.0626, 17, -1, 0, -1, -1, 400.0);// Военкомат
	CreateDynamicMapIcon(2110.635498,1816.722412,11.805241, 22, -1, 0, -1, -1, 400.0);// болька
	CreateDynamicMapIcon(1798.9729, 2495.8669, 15.9816, 11, -1, 0, -1, -1, 400.0);// Автобусник
	CreateDynamicMapIcon(1795.1661,2039.2810,15.8942, 52, -1, 0, -1, -1, 400.0);// банк Батырёво
	CreateDynamicMapIcon(2325.5154,-1803.9813,22.4540, 55, -1, 0, -1, -1, 400.0);// автосалон
	CreateDynamicMapIcon(2313.8247,-1924.8029,22.4338, 25, -1, 0, -1, -1, 400.0);// казино
	CreateDynamicMapIcon(2379.2959,-932.5500,2.0722, 14, -1, 0, -1, -1, 400.0);// ферма
	CreateDynamicMapIcon(1452.3639,2344.3074,12.8216, 59, -1, 0, -1, -1, 400.0);// скинхеды
	CreateDynamicMapIcon(2215.5708,-2597.6665,21.9600, 58, -1, 0, -1, -1, 400.0);// гопота
	CreateDynamicMapIcon(-330.6854,-1078.4684,41.1221, 60, -1, 0, -1, -1, 400.0);// кавказ
	CreateDynamicMapIcon(1966.9902,-2604.1121,10.8149, 51, -1, 0, -1, -1, 400.0);// дальнобой
	CreateDynamicMapIcon(2416.2463,-1848.5751,21.9369, 30, -1, 0, -1, -1, 400.0);// мусарная
	CreateDynamicMapIcon(2196.3562,-1925.6718,18.8125, 19, -1, 0, -1, -1, 400.0);// коцертная сцена
	CreateDynamicMapIcon(1587.7664,-1236.9204,15.0275, 18, -1, 0, -1, -1, 400.0);// каптера
	CreateDynamicMapIcon(-567.8601,-1313.1066,41.3625, 7, -1, 0, -1, -1, 400.0);// автошкола
	//для 968
	CreateObject(966, 1460.99, 2340.94, 11.76,   0.00, 0.00, -90.00);//скины
	CreateObject(966, -336.63, -1084.92, 40.11,   0.00, 0.00, 147.42);//кавказ
	//
	SkinPost = CreateObject(968,1461.0179, 2340.8840, 12.5690, 0.00, 90.00, 90.00);
	GopotaPost = CreateObject(968,2221.4264, -2578.8955, 21.6831, 0.30, -90.00, -1.56);
 	KavkazPost = CreateObject(968,-336.7794, -1084.9222, 40.9260, 0.00, 90.00, -31.43);
	ArmyGateOne = CreateObject(16227, -2660.59, 266.60, 12.32, 0.00, 0.00, 0.00);
	ArmyGateTwo = CreateObject(16227, -2665.55, 266.60, 12.32, 0.00, 0.00, 0.00);

	ArmyGateWatherTwo = CreateObject(16227, -2764.77, 406.67, 12.35, 0.00, 0.00, -90.00);
	ArmyGateWatherOne = CreateObject(16227, -2764.75, 401.72, 12.35, 0.00, 0.00, -90.00);
	return printf("OnGameModeInit загрузился за %i ms", GetTickCount() - currenttime);
}
public OnGameModeExit()
{
	SaveServer();
	if (gstream) SvDeleteStream(gstream);
	KillTimer(CheckCarHP);
	KillTimer(RunTimer);
	DisconnectMySQL();
	return 1;
}
stock DisconnectMySQL()
{
    mysql_close(mysql);
}
public OnPlayerRequestClass(playerid, classid) 
{
	if(IsPlayerLogged{playerid})
	{
		SettingSpawn(playerid);
		SetSpawnInfo(playerid, 255, 0, 0, 10, 0, 0, 0, 0, 0, 0, 0, 0);
	}
	return 0;
}
public OnPlayerConnect(playerid)
{	
	//16282 16315	
	GetPlayerName(playerid, PI[playerid][pName], MAX_PLAYER_NAME);
	GetPlayerIp(playerid,PI[playerid][pLoginIP], 32);
	getdate(PI[playerid][pLogDateYear], PI[playerid][pLogDateMonth], PI[playerid][pLogDateDat]);
	CheckOnline();
	PI[playerid][data_PLAYER_TIMER_ID] = SetTimerEx("PlayerUpdate", 1000, true, "d", playerid);
	
	if (SvGetVersion(playerid) == SV_NULL) SCM(playerid, COLOR_HINT, "[SV-client] {FFFFFF}загрузка плагина произошла {FFFF33}неуспешно (NULL)");
    else if (SvHasMicro(playerid) == SV_FALSE) SCM(playerid, COLOR_HINT, "[SV-client] {FFFFFF}загрузка плагина произошла {FFFF33}c ошибкой (MIC)");
    else if ((lstream[playerid] = SvCreateDLStreamAtPlayer(40.0, SV_INFINITY, playerid, 0xff0000ff, "Voice")))
    {
        if (gstream) SvAttachListenerToStream(gstream, playerid);
        SvAddKey(playerid, 0x58);
    }

	PI[playerid][pRun] = 120.0;

    SetPlayerColor(playerid, 0xB5BBBA00);
	//
	PreloadAnimLib(playerid,"CARRY");
	PreloadAnimLib(playerid,"BASEBALL");
	//

	ClearPlayerData(playerid);

	mysql_string[0] = EOS, mf(mysql, mysql_string, 150, "SELECT `ID`, `Password`, `VkontakteID` FROM accounts WHERE Name = '%e' LIMIT 1;", getName(playerid));
    mysql_tquery(mysql, mysql_string, "GetPlayerDataMysql", "d", playerid);

	RemoveBuild(playerid);
	return 1;
}
stock CheckStatus(playerid)
{
	SetPlayerPos(playerid, 1884.4066,2060.7212,15.9926);
	SetPlayerCameraPos(playerid, 1879.8835, 2068.9236, 26.1405);
	SetPlayerCameraLookAt(playerid, 1879.0103, 2069.4077, 25.9805);

	SetPlayerSkinAC(playerid, 23);
	TogglePlayerControllable(playerid, false);
	SetPlayerVirtualWorld(playerid, playerid+10);

	mysql_string[0] = EOS, mf(mysql, mysql_string, 76, "SELECT * FROM `banlist` WHERE `name` = '%e' LIMIT 1", getName(playerid));
    mysql_tquery(mysql, mysql_string, "CheckBan", "d", playerid);
	return 1;
}
callback: GetPlayerDataMysql(playerid) 
{
	if(cache_get_row_count(mysql) > 0) {
		PI[playerid][pID] = cache_get_row_int(0, 0, mysql);
	}
	else {
		PI[playerid][pID] = -1;
	}
	return LoadVoiceChat(playerid);
}
public OnPlayerEnterDynamicArea(playerid, areaid) 
{
	if(areaid == ArmyStorageZone) 
	{
		if(army_wh[2] == 1) 
		{
			TimetTheftCartridges[playerid] = SetTimerEx("TheftCartridges", 2000, true, "d", playerid);
			SetPlayerCheckpoint(playerid, -2569.5022, 450.7665, 12.9216, 5);
		}
		else return SendClientMessage(playerid, COLOR_GREY, !"Склад организации 'Воинская часть' закрыт игровым мастером");
    }
	return 1;
}
public OnPlayerEnterDynamicCP(playerid,checkpointid) 
{
    if(checkpointid == help_spawn) return ShowPlayerDialog(playerid, dialog_SPAWNHELP, DIALOG_STYLE_LIST, "{ee3366}Помощь", "С чего начать играть?", "Выбрать", "Отмена");
 	if(checkpointid == army_sklad) return 1;
	return 1;
}
public OnPlayerDisconnect(playerid, reason) 
{
	printf("Player Disconnect %s | start", getName(playerid));

	cef_destroy_browser(playerid, MAIN_CEF);
	cef_destroy_browser(playerid, DIALOG_CEF);
	capture_OnPlayerDisconnect(playerid);
	//==============================================//
    KillTimer(PI[playerid][data_PLAYER_TIMER_ID]);
	KillTimer(PI[playerid][LoadCefInformation]);
	//==============================================//
    if(lstream[playerid])
    {
        SvDeleteStream(lstream[playerid]);
        lstream[playerid] = SV_NULL;
    }
	//==============================================//
	DeletePVar(playerid, "HintHutton");
	DeletePVar(playerid, "PlayerCuffed");
	DeletePVar(playerid, "ChoosingSkin");
	PI[playerid][pDeathOnCapture] = 0;
	PI[playerid][pSchoolTestLvl] = 0;

	if(PI[playerid][pTempJob] == 1) 
	{
		DestroyVehicle(dalnoboy_trayler[playerid]);
        DestroyVehicle(dalnoboy_car[playerid]);
        KillTimer(dalnaboy_check_pricep[playerid]);
    }
	if(PI[playerid][pAdminStatus] == 1)
	{
		if(PI[playerid][pAdmin] == 0) PI[playerid][pAdminStatus] = 0;
	}
	//==============================================//
    if(GetPVarInt(playerid,"PlayerCuffed") == 1) 
	{
		if(PI[playerid][pWanted] >= 1)
		{
			PI[playerid][pJail] = 1;
			PI[playerid][pJailTime] = 1800;
			PI[playerid][pWanted] = 0;
			SendClientMessageToAllf(COLOR_TOMATO, "%s вышел из игры при задержании (+30 минут ареста)", PI[playerid][pName]);
		}
 	}
	if(PI[playerid][pRequest] == 1)
	{
		KillTimer(OfferTimer[playerid]);
		if(PI[playerid][pRequestFor] != INVALID_PLAYER_ID)
		{
			ClearRequest(PI[playerid][pRequestFor]);
			ClearRequest(playerid);
		}
		if(PI[playerid][pRequestFrom] != INVALID_PLAYER_ID)
		{
			ClearRequest(PI[playerid][pRequestFrom]);
			ClearRequest(playerid);
		}
	}
	if(PI[playerid][pSetMarker] == 1)
	{
		KillTimer(SetMarkerTimer[playerid]);
	}
	if(PI[playerid][pRentMoto] != INVALID_VEHICLE_ID) DestroyVehicle(PI[playerid][pRentMoto]);
	if(PI[playerid][pLoadVehicleID] != INVALID_VEHICLE_ID) 
	{
		ClearVehicleData(PI[playerid][pLoadVehicleID]);
		DestroyVehicle(PI[playerid][pLoadVehicleID]);
		SaveOwnableCar(PI[playerid][pLoadVehicleID]);
		LoadedOwnable--;
	}
	if(PI[playerid][pInAutoSalon] == true) 
	{
 		DestroyVehicle(PI[playerid][pAutoSalonCar]);
		PI[playerid][pAutoSalonCar] = INVALID_VEHICLE_ID;
		HideAutoSalonMenu(playerid);
	}
	//==============================================//
	SavePlayerData(playerid);
	UpdatePlayerDataInt(playerid, "Online", 0);

	new szDisconnectReason[3][] = {
        "Таймаут/Краш",
        "Выход",
        "Кик/Бан"
    };
	if(PI[playerid][pAdmin] >= 1) 
	{
		SendAdminsMessagef(COLOR_ADMINCHAT, "[%s #%d] %s[%d] вышел с сервера. Причина: %s", AdminName[PI[playerid][pAdmin]], PI[playerid][pAdminNumber], PI[playerid][pName],playerid,szDisconnectReason[reason]);
		Iter_Remove(Admin, playerid);
	}
	else if(PI[playerid][pModer] >= 1) 
	{
		SendAdminsMessagef(COLOR_ADMINCHAT, "[%s] %s[%d] вышел с сервера. Причина: %s", ModerName[PI[playerid][pModer]], PI[playerid][pName], playerid, szDisconnectReason[reason]);
		Iter_Remove(Moder, playerid);
	}
	return printf("Player Disconnect %s", getName(playerid));
}
public OnPlayerDeath(playerid, killerid, reason)
{
	nc_OnPlayerDeath(playerid);

	PI[playerid][pMaskWorn] = 0;
    PI[playerid][pSchoolTestLvl] = 0;

	if(!PI[playerid][pJail] && !PI[playerid][pDemorgan] && PI[playerid][pDeathOnCapture] == 0)
	{
		if(PI[playerid][pOnMP] == 0)
		{
			if(PI[playerid][pMember] == 2) 
			{
				SendClientMessagef(playerid, COLOR_GREEN, !"Ваш персонаж погиб. Сейчас вас ожидает процесс восстановления в казарме.");
				PlayerHospital(playerid);
			}
			else PlayerHospital(playerid);
			TogglePlayerControllable(playerid, true);
		}
	}
    if(playerid != 65535 && killerid != 65535) 
	{
		if(IsPlayerCops(killerid) && PI[playerid][pWanted] != 0) 
		{
			SendFractionMessagef(PI[killerid][pMember], COLOR_YELLOW, "[Всем постам] %s %s  арестовал подозреваемого %s", rang_police[PI[killerid][pRang]-1][frName],PI[killerid][pName],PI[playerid][pName]);
			PI[playerid][pJail] = 1;
	 		PI[playerid][pJailTime] = 600*PI[playerid][pWanted];
	 		PI[playerid][pWanted] = 0;
			UnfreezePlayer(playerid);
			SetPlayerWantedLevel(playerid,PI[playerid][pWanted]);
			PlayerSpawn(playerid);
			SetPlayerSpecialAction(playerid, 0);
			RemovePlayerAttachedObject(playerid, 5);
			DeletePVar(playerid,"PlayerCuffed");
			GivePlayerMoneyLog(killerid,3000*PI[playerid][pWanted]);
			new pay[20];
			format(pay,sizeof(pay),"+%dР",3000*PI[playerid][pWanted]);
			cef_emit_event(killerid, "show-notify-no-img", CEFSTR("Премия за арест преступника"), CEFSTR("418055"), CEFSTR(pay));
		}
		else if(GangWarStatus >= 2)  
		{
			if(IsPlayerInRangeOfPoint(playerid, 75.0, 1616.7029,-1238.1493,19.3756) && IsPlayerInRangeOfPoint(killerid, 75.0, 1616.7029,-1238.1493,19.3756)) 
			{
				if(PI[playerid][pMember] == Command[0])  
				{
					if(PI[killerid][pMember] == Command[1]) 
					{
						new gun = GetPlayerWeapon(killerid);

						SCM(killerid, COLOR_YELLOW, !"За участие в стреле Вы получите вознаграждение в следующий PayDay");

						PI[playerid][pPayDayMoney] += 1500;
						CommandKill[1]++;

						PI[playerid][pDeathOnCapture] = 1;
						SetPlayerHealthAC(playerid, 176);

						new killer[32], killed[32];
						format(killer, 32, "{%s}%s[%d]", ColorTeam[PI[killerid][pMember]], getName(killerid), killerid);
						format(killed, 32, "{%s}%s[%d]", ColorTeam[PI[playerid][pMember]], getName(playerid), playerid);
						
						for(new i; i < MAX_PLAYERS; i++) 
						{
							if(PI[i][pMember] == Command[0] || PI[i][pMember] == Command[1])
							{
								cef_emit_event(i, "cef:kill:list:add", CEFSTR(killer), CEFINT(gun), CEFSTR(killed));
							}
						}

						if(PI[playerid][pMember] == Command[0]) PlayerSpawn(playerid);
						return true;
					}
				}
				if(PI[playerid][pMember] == Command[1]) 
				{
					if(PI[killerid][pMember] == Command[0]) 
					{
						new gun = GetPlayerWeapon(killerid);

						SCM(killerid, COLOR_YELLOW, !"За участие в стреле Вы получите вознаграждение в следующий PayDay");

						PI[playerid][pPayDayMoney] += 1500;
						CommandKill[0]++;

						PI[playerid][pDeathOnCapture] = 1;
						SetPlayerHealthAC(playerid, 176);

						new killer[32], killed[32];
						format(killer, 32, "{%s}%s[%d]", ColorTeam[PI[killerid][pMember]], getName(killerid), killerid);
						format(killed, 32, "{%s}%s[%d]", ColorTeam[PI[playerid][pMember]], getName(playerid), playerid);
						
						for(new i; i < MAX_PLAYERS; i++) 
						{
							if(PI[i][pMember] == Command[0] || PI[i][pMember] == Command[1])
							{
								cef_emit_event(i, "cef:kill:list:add", CEFSTR(killer), CEFINT(gun), CEFSTR(killed));
							}
						}

						if(PI[playerid][pMember] == Command[1]) PlayerSpawn(playerid);
						return true;
					}
				}
			}
		}
		else if(!IsPlayerCops(killerid) && PI[killerid][pMember] != 2) 
		{
		    if(PI[killerid][pWanted] < 6) 
			{
				PI[killerid][pWanted]++;
				SetPlayerWantedLevel(killerid, PI[killerid][pWanted]);
				SCMf(killerid, COLOR_TOMATO, "Ваш уровень розыска повышен за убийство игрока %s[%d]",PI[playerid][pName], playerid);
				if(PI[killerid][pRespect] > -100) PI[killerid][pRespect]--;
			}
		}
	}
	if(PI[playerid][pDeathOnCapture] == 0) 
	{
		if(PI[playerid][pOnMP] == 0)
		{
			if(PI[playerid][pJail] == 0 || PI[playerid][pDemorgan] == 0) 
			{
				PI[playerid][pHospital] = 1;
				SendPlayerCenterNotify(playerid, 1, "Вы попали в больницу", 5);
			}
			PI[playerid][pHealthPoints] = 5;
		}
		else
		{
			PI[playerid][pHospital] = 0;
			PI[playerid][pHealthPoints] = 176;
			SendPlayerCenterNotify(playerid, 1, "Вы были перемещены к начальной точке входа на МП.", 5);
			PlayerSpawn(playerid);
		}
	}

    ResetWeaponAll(playerid);

	if(!IsPlayerLogged{playerid}) return AC_Kick(playerid, 5);

 	foreach(new i:Player) if(PI[i][pAdmin] >= 1 || PI[i][pModer] >= 1) SendDeathMessageToPlayer(i, killerid, playerid, reason);
	return 1;
}

public OnVehicleSpawn(vehicleid) return DestroyVehicle(vehicleid);
public OnVehicleDeath(vehicleid, killerid) return RespawnVehicles();

public OnPlayerText(playerid, text[])
{
	if(!IsPlayerLogged{playerid}) return false;

    if(TextReset[playerid] > 0)
	{
  		SCM(playerid, COLOR_BLACK, !"Пожалуйста, подождите пару секунд...");
		return 0;
	}

	if(PI[playerid][pMute] == 1)
	{
		SCM(playerid, COLOR_GREY, !"Ваш чат заблокирован. Посмотреть время до разблокировки (/time)");
		return false;
	}
	if(CheckString(text)) PlayerGetsChatBan(playerid, text);
	
	SetTimerEx("ClearData", 1000,0,"d", playerid);
	TextReset[playerid] = 1;

 	NotReklama(playerid, text);

	chat_str[0] = EOS;

	if(PI[playerid][pAdminStatus] == 1) 
	{
  		f(chat_str, 144, "Игровой Мастер: {FFFFFF}%s", text);
		ProxDetector(30.0, playerid, chat_str, 0xDD3366FF, 0xDD3366FF, 0xDD3366FF, 0xDD3366FF ,0xDD3366FF);

		SetPlayerChatBubble(playerid, text, 0x81a4cdFF, 20.0, 3000);
		if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT && GetPVarInt(playerid,"UseAnim") == 0) 
		{
	 		ApplyAnimation(playerid,"PED","IDLE_chat",4.1,0,1,1,1,1);
			if(PI[playerid][data_ANIM] == false) SetTimerEx("anim_OFF", 1400, 0, "d", playerid);
			PI[playerid][data_ANIM] = true;
 		}
		return 0;
	}
	if(PI[playerid][data_CALL] != -1 && PI[PI[playerid][data_CALL]][data_CALL] == playerid) 
	{
        SCMf(PI[playerid][data_CALL], COLOR_YELLOW, "[Звонок]%s: %s",PI[playerid][pName],text);
		SCMf(playerid, COLOR_GREY, "[Звонок] %s: %s",PI[PI[PI[playerid][data_CALL]][data_CALL]][pName],text);
		return 0;
 	}
 	if(!strcmp(text,"xD",true)) 
	{
		f(chat_str, 50, "%s валяется от смеха", PI[playerid][pName]);
		ProxDetector(20.0, playerid, chat_str, 0xFF99CCFF,0xFF99CCFF,0xFF99CCFF,0xFF99CCFF,0xFF99CCFF);
		SetPlayerChatBubble(playerid, "валяется от смеха", 0xFF99CCFF, 20.0, 4000);
		return 0;
	}
	if(!strcmp(text,"(",true)) 
	{
		f(chat_str, 36, "%s грустит", PI[playerid][pName]);
		ProxDetector(20.0, playerid, chat_str, 0xFF99CCFF,0xFF99CCFF,0xFF99CCFF,0xFF99CCFF,0xFF99CCFF);
		SetPlayerChatBubble(playerid, "грустит", 0xFF99CCFF, 20.0, 4000);
		return 0;
	}
	if(!strcmp(text,"((",true)) 
	{
		f(chat_str, 50, "%s сильно расстроился", PI[playerid][pName]);
		ProxDetector(20.0, playerid, chat_str, 0xFF99CCFF,0xFF99CCFF,0xFF99CCFF,0xFF99CCFF,0xFF99CCFF);
		SetPlayerChatBubble(playerid, "сильно расстроился", 0xFF99CCFF, 20.0, 4000);
		return 0;
	}
	if(!strcmp(text,"чВ",true)) 
	{
		f(chat_str, 48, "%s валяется от смеха", PI[playerid][pName]);
		ProxDetector(20.0, playerid, chat_str, 0xFF99CCFF,0xFF99CCFF,0xFF99CCFF,0xFF99CCFF,0xFF99CCFF);
		SetPlayerChatBubble(playerid, "валяется от смеха", 0xFF99CCFF, 20.0, 4000);
		return 0;
	}
	if(!strcmp(text,")",true)) 
	{
		f(chat_str, 39, "%s улыбается", PI[playerid][pName]);
		ProxDetector(20.0, playerid, chat_str, 0xFF99CCFF,0xFF99CCFF,0xFF99CCFF,0xFF99CCFF,0xFF99CCFF);
		SetPlayerChatBubble(playerid, "улыбается", 0xFF99CCFF, 20.0, 4000);
		return 0;
	}
	if(!strcmp(text,"))",true)) 
	{
		f(chat_str, 39, "%s смеётся", PI[playerid][pName]);
		ProxDetector(20.0, playerid, chat_str, 0xFF99CCFF,0xFF99CCFF,0xFF99CCFF,0xFF99CCFF,0xFF99CCFF);
		SetPlayerChatBubble(playerid, "смеётся", 0xFF99CCFF, 20.0, 4000);
		return 0;
	}
	if(PI[playerid][pMaskWorn] == 1) 
	{
		if(PI[playerid][pVIP] != 0) 
		{
			f(chat_str, 144, "- %s {121212}(%s)[%d] {FFA500}["VIP_TAG"]", text, PI[playerid][pName], playerid);
			ProxDetector(30.0, playerid, chat_str, COLOR_WHITE, COLOR_WHITE, COLOR_WHITE, COLOR_WHITE, COLOR_WHITE);
			SetPlayerChatBubble(playerid, text, 0x9db7ddFF, 20.0, 4000);
			if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT && GetPVarInt(playerid,"UseAnim") == 0) 
			{
				ApplyAnimation(playerid,"PED","IDLE_chat",4.1,0,1,1,1,1);
				if(PI[playerid][data_ANIM] == false) SetTimerEx("AnimationOff", 1400, 0, "d", playerid);
				PI[playerid][data_ANIM] = true;
			}
			return 0;
		}
		else 
		{
			f(chat_str, 144, "- %s {121212}(%s)[%d]", text, PI[playerid][pName], playerid);
			ProxDetector(30.0, playerid, chat_str, COLOR_WHITE, COLOR_WHITE, COLOR_WHITE, COLOR_WHITE, COLOR_WHITE);
			SetPlayerChatBubble(playerid, text, 0x9db7ddFF, 20.0, 4000);
			if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT && GetPVarInt(playerid,"UseAnim") == 0) 
			{
				ApplyAnimation(playerid,"PED","IDLE_chat",4.1,0,1,1,1,1);
				if(PI[playerid][data_ANIM] == false) SetTimerEx("AnimationOff", 1400, 0, "d", playerid);
				PI[playerid][data_ANIM] = true;
			}
			return 0;
		}
	}
	if(PI[playerid][pVIP] != 0) 
	{
	    f(chat_str, 144, "- %s %s(%s)[%d] {FFA500}["VIP_TAG"]", text, PLAYER_COLOR_CHAT[PI[playerid][pMember]][COLOR], PI[playerid][pName], playerid);
		ProxDetector(30.0, playerid, chat_str, COLOR_WHITE, COLOR_WHITE, COLOR_WHITE, COLOR_WHITE, COLOR_WHITE);
		SetPlayerChatBubble(playerid, text, 0x9db7ddFF, 20.0, 4000);
		if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT && GetPVarInt(playerid,"UseAnim") == 0) 
		{
	 	    ApplyAnimation(playerid,"PED","IDLE_chat",4.1,0,1,1,1,1);
			if(PI[playerid][data_ANIM] == false) SetTimerEx("AnimationOff", 1400, 0, "d", playerid);
			PI[playerid][data_ANIM] = true;
	 	}
	 	return 0;
	}
    f(chat_str, 144, "- %s %s(%s)[%d]", text, PLAYER_COLOR_CHAT[PI[playerid][pMember]][COLOR], PI[playerid][pName], playerid);
	ProxDetector(30.0, playerid, chat_str, COLOR_WHITE, COLOR_WHITE, COLOR_WHITE, COLOR_WHITE, COLOR_WHITE);
	SetPlayerChatBubble(playerid, text, 0x9db7ddFF, 20.0, 4000);
	if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT && GetPVarInt(playerid,"UseAnim") == 0) 
	{
 	    ApplyAnimation(playerid,"PED","IDLE_chat",4.1,0,1,1,1,1);
		if(PI[playerid][data_ANIM] == false) SetTimerEx("AnimationOff", 1400, 0, "d", playerid);
		PI[playerid][data_ANIM] = true;
 	}
	return 0;
}
public OnPlayerCommandText(playerid, cmdtext[]) return 0;
public OnPlayerEnterVehicle(playerid, vehicleid, ispassenger) 
{
	if(PI[playerid][pRentMoto] != INVALID_VEHICLE_ID) 
	{
		if(vehicleid == PI[playerid][pRentMoto])
		{
			return KillTimer(RentMotoTimerToDetroy[playerid]);
		}
	}
	//if(!IsAPlane(vehicleid) && !IsAVelik(vehicleid)) ShowPlayerSpeedometer(playerid); 
	return 1;
}
public OnPlayerExitVehicle(playerid, vehicleid) 
{
	if(PI[playerid][pRentMoto] != INVALID_VEHICLE_ID) 
	{
	    if(vehicleid == PI[playerid][pRentMoto]) 
		{
			SendClientMessage(playerid, COLOR_GREY, !"У Вас есть 90 секунд, чтобы сесть на мопед. Иначе аренда завершится");
			RentMotoTimerToDetroy[playerid] = SetTimerEx("ArendMotoDestroy", 90000, false, "i", playerid);
		}
	}
	//if(!IsAPlane(vehicleid) && !IsAVelik(vehicleid)) HidePlayerSpeedometer(playerid);
    GetPlayerPos(playerid,oldposX[playerid],oldposY[playerid],oldposZ[playerid]);
	return 1;
}
public OnPlayerStateChange(playerid, newstate, oldstate) 
{
    new carid = GetPlayerVehicleID(playerid);
	if(newstate == PLAYER_STATE_DRIVER) 
	{
		if(!IsAPlane(carid) && !IsAVelik(carid)) ShowPlayerSpeedometer(playerid); 
	}
	if(newstate == PLAYER_STATE_ONFOOT) if(!IsAPlane(carid) && !IsAVelik(carid)) HidePlayerSpeedometer(playerid);
    if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER) 
	{
        if(PI[playerid][pDriveLicense] == 0 && PI[playerid][data_ASH_TEST] == 0) 
		{
            if(!IsAVelik(carid)) 
			{
				SCM(playerid, COLOR_GREY, !"У Вас нет водитеських прав");
             	RemovePlayerFromVehicle(playerid);
             	HidePlayerSpeedometer(playerid);
 			}
        }
        if(carid == gov_car[0] || carid == gov_car[1] || carid == gov_car[2] || carid == gov_car[3] || carid == gov_car[4] ||
		carid == gov_car[5] || carid == gov_car[6] || carid == gov_car[7]) 
		{
	        if(PI[playerid][pMember] != 1) 
			{
	            SCM(playerid, COLOR_GREY, !"Данный транспорт Вам недоступен"); 
				HidePlayerSpeedometer(playerid);
             	return RemovePlayerFromVehicleAC(playerid);
	        }
	    }
	    if(carid == army_car[0]) 
		{
	        if(PI[playerid][pMember] != 2) 
			{
	        	if(PI[playerid][pRang] < 2) 
				{
					SCM(playerid, COLOR_GREY, !"Этот транспорт можно использовать с 2 ранга"); 
					HidePlayerSpeedometer(playerid);
             		RemovePlayerFromVehicleAC(playerid);
             		return 1;
				}
	            SCM(playerid, COLOR_GREY, !"Этот транспорт пренадлежит организации Войсковая часть"); 
				HidePlayerSpeedometer(playerid);
             	return RemovePlayerFromVehicleAC(playerid);
	        }
	    }
	    if(carid == army_car[1] || carid == army_car[2] || carid == army_car[3] || carid == army_car[4] || carid == army_car[5] || carid == army_car[6] || carid == army_car[7] || carid == army_car[8]) 
		{
	        if(PI[playerid][pMember] != 2) 
			{
	            SCM(playerid, COLOR_GREY, !"Этот транспорт пренадлежит организации Кавказцы"); 
				HidePlayerSpeedometer(playerid);
             	return RemovePlayerFromVehicleAC(playerid);
	        }
	    }
	    if(carid == police_car[0] || carid == police_car[1] ||carid == police_car[2] ||
		carid == police_car[3] || carid == police_car[4] || carid == police_car[5] || carid == police_car[6] ||
		carid == police_car[7]) 
		{
	        if(PI[playerid][pMember] != 3) 
			{
	            SCM(playerid, COLOR_GREY, !"Этот транспорт пренадлежит организации Кавказцы"); 
				HidePlayerSpeedometer(playerid);
             	return RemovePlayerFromVehicleAC(playerid);
	        }
	    }
	    if(carid == hospital_car[0] || carid == hospital_car[1] || carid == hospital_car[2] || carid == hospital_car[3] ||
		carid == hospital_car[4] || carid == hospital_car[5] || carid == hospital_car[6] || carid == hospital_car[7]) 
		{
	        if(PI[playerid][pMember] != 4) 
			{
	            SCM(playerid, COLOR_GREY, !"Этот транспорт пренадлежит организации БЦРБ"); 
				HidePlayerSpeedometer(playerid);
             	return RemovePlayerFromVehicleAC(playerid);
	        }
	    }
	    if(carid == skinhead_car[0] || carid == skinhead_car[1] || carid == skinhead_car[2] || carid == skinhead_car[3]
		|| carid == skinhead_car[4] || carid == skinhead_car[5] || carid == skinhead_car[6] || carid == skinhead_car[7]) 
		{
	        if(PI[playerid][pMember] != 5) 
			{
	            SCM(playerid, COLOR_GREY, !"Этот транспорт пренадлежит организации Скинхеды"); 
				HidePlayerSpeedometer(playerid);
             	RemovePlayerFromVehicleAC(playerid);
				return 1;
	        }
	    }
	    if(carid == skinhead_car[3] || carid == skinhead_car[4]) 
		{
	        if(PI[playerid][pRang] < 5) 
			{
	            SCM(playerid, COLOR_GREY, !"Этот транспорт можно использовать с 5 ранга"); 
				HidePlayerSpeedometer(playerid);
             	return RemovePlayerFromVehicleAC(playerid);
	        }
	    }
	    if(carid == skinhead_car[6]) 
		{
	        if(PI[playerid][pRang] < 8) 
			{
	            SCM(playerid, COLOR_GREY, !"Данный транспорт доступен с 8 ранга"); 
				HidePlayerSpeedometer(playerid);
             	return RemovePlayerFromVehicleAC(playerid);
	        }
	    }
	    if(carid == skinhead_car[5]) 
		{
	        if(PI[playerid][pRang] < 6) 
			{
	            SCM(playerid, COLOR_GREY, !"Данный транспорт доступен с 6 ранга"); 
				HidePlayerSpeedometer(playerid);
             	return RemovePlayerFromVehicleAC(playerid);
	        }
	    }
	    if(carid == skinhead_car[7]|| carid == skinhead_car[6]) 
		{
	        if(PI[playerid][pRang] < 9) 
			{
	            SCM(playerid, COLOR_GREY, !"Данный транспорт доступен с 9 ранга"); 
				HidePlayerSpeedometer(playerid);
             	return RemovePlayerFromVehicleAC(playerid);
	        }
	    }
	    if(carid == gopota_car[0] || carid == gopota_car[1] || carid == gopota_car[2] || carid == gopota_car[3]
		|| carid == gopota_car[4] || carid == gopota_car[5] || carid == gopota_car[6] || carid == gopota_car[7]) 
		{
	        if(PI[playerid][pMember] != 6) 
			{
	            SCM(playerid, COLOR_GREY, !"Этот транспорт пренадлежит организации Гопота"); 
				HidePlayerSpeedometer(playerid);
             	RemovePlayerFromVehicleAC(playerid);
				return 1;
	        }
	    }
	    if(carid == gopota_car[3] || carid == gopota_car[4]) 
		{
	        if(PI[playerid][pRang] < 5) 
			{
	            SCM(playerid, COLOR_GREY, !"Этот транспорт можно использовать с 5 ранга");
				HidePlayerSpeedometer(playerid);
             	return RemovePlayerFromVehicleAC(playerid);
	        }
	    }
	    if(carid == gopota_car[6]) 
		{
	        if(PI[playerid][pRang] < 8) 
			{
	            SCM(playerid, COLOR_GREY, !"Данный транспорт доступен с 8 ранга"); 
				HidePlayerSpeedometer(playerid);
             	return RemovePlayerFromVehicleAC(playerid);
	        }
	    }
	    if(carid == gopota_car[5]) {
	        if(PI[playerid][pRang] < 6) {
	            SCM(playerid, COLOR_GREY, !"Данный транспорт доступен с 6 ранга"); 
				HidePlayerSpeedometer(playerid);
             	return RemovePlayerFromVehicleAC(playerid);
	        }
	    }
	    if(carid == gopota_car[7]|| carid == gopota_car[6]) 
		{
	        if(PI[playerid][pRang] < 9) 
			{
	            SCM(playerid, COLOR_GREY, !"Данный транспорт доступен с 9 ранга"); 
				HidePlayerSpeedometer(playerid);
             	return RemovePlayerFromVehicleAC(playerid);
	        }
	    }
	    if(carid == kavkaz_car[0] || carid == kavkaz_car[1] || carid == kavkaz_car[2] || carid == kavkaz_car[3]
		|| carid == kavkaz_car[4] || carid == kavkaz_car[5] || carid == kavkaz_car[6] || carid == kavkaz_car[7]) 
		{
	        if(PI[playerid][pMember] != 7) 
			{
	            SCM(playerid, COLOR_GREY, !"Этот транспорт пренадлежит организации Кавказцы"); 
				HidePlayerSpeedometer(playerid);
             	RemovePlayerFromVehicleAC(playerid);
				return 1;
	        }
	    }
	    if(carid == kavkaz_car[3] || carid == kavkaz_car[4]) 
		{
	        if(PI[playerid][pRang] < 5) 
			{
	            SCM(playerid, COLOR_GREY, !"Этот транспорт можно использовать с 5 ранга"); 
				HidePlayerSpeedometer(playerid);
             	return RemovePlayerFromVehicleAC(playerid);
	        }
	    }
	    if(carid == kavkaz_car[6]) 
		{
	        if(PI[playerid][pRang] < 8) 
			{
	            SCM(playerid, COLOR_GREY, !"Данный транспорт доступен с 8 ранга"); 
				HidePlayerSpeedometer(playerid);
             	return RemovePlayerFromVehicleAC(playerid);
	        }
	    }
	    if(carid == kavkaz_car[5]) 
		{
	        if(PI[playerid][pRang] < 6) 
			{
	            SCM(playerid, COLOR_GREY, !"Данный транспорт доступен с 6 ранга"); 
				HidePlayerSpeedometer(playerid);
             	return RemovePlayerFromVehicleAC(playerid);
	        }
	    }
	    if(carid == kavkaz_car[7]|| carid == kavkaz_car[6]) 
		{
	        if(PI[playerid][pRang] < 9) 
			{
	            SCM(playerid, COLOR_GREY, !"Данный транспорт доступен с 9 ранга"); 
				HidePlayerSpeedometer(playerid);
             	return RemovePlayerFromVehicleAC(playerid);
	        }
	    }
    }
	return 1;
}
public OnPlayerEnterCheckpoint(playerid) 
{
    if(PlayerToPoint(5.0, playerid, GetPVarFloat(playerid, "gps_pos_x"),GetPVarFloat(playerid, "gps_pos_y"),GetPVarFloat(playerid, "gps_pos_z"))) 
	{
	    DisablePlayerCheckpoint(playerid);
	    DeletePVar(playerid, "gps_pos_x");
	    DeletePVar(playerid, "gps_pos_y");
	    DeletePVar(playerid, "gps_pos_z");
     	return SCM(playerid, COLOR_GREEN, !"Вы достигли точки назначения");
	}
	return 1;
}
public OnPlayerLeaveCheckpoint(playerid) return 1;
public OnPlayerEnterRaceCheckpoint(playerid) 
{
	if(PlayerToPoint(10.0, playerid, -2351.3767,258.0399,23.6756) ||
	PlayerToPoint(10.0, playerid, 2978.3062,-720.5325,12.7500) ||
	PlayerToPoint(10.0, playerid, 2325.0569,-264.0050,1.6073) ||
	PlayerToPoint(10.0, playerid, 1976.2108,1652.2156,15.9200) ||
	PlayerToPoint(10.0, playerid, -442.7106,-1575.0638,40.9470)) 
	{
		if(PI[playerid][pTempJob] == 1) 
		{
		    if(!IsTrailerAttachedToVehicle(GetPlayerVehicleID(playerid))) return SCM(playerid, COLOR_GREY, !"Вы не доставили прицеп");
			SCM(playerid, COLOR_YELLOW, !"Вы доставили груз, работа была завершена.");
			DestroyVehicle(GetVehicleTrailer(GetPlayerVehicleID(playerid)));
            GivePlayerMoneyLog(playerid, 95000);
            PI[playerid][pTempJob] = 0;
            DisablePlayerRaceCheckpoint(playerid);
        	KillTimer(dalnaboy_check_pricep[playerid]);
	        return 1;
		}
	}
	return 1;
}
public OnPlayerLeaveRaceCheckpoint(playerid) return 1;
public OnRconCommand(cmd[]) return 1;
public OnPlayerRequestSpawn(playerid) 
{
	if(!IsPlayerLogged{playerid})
	{
	    SCM(playerid, COLOR_HINT, !"[Подсказка] {FFFFFF}Для авторизации на нашем сервере введите пароль");
	    Kick(playerid);
	    return 0;
	}
	return 1;
}
public OnPlayerPickUpDynamicPickup(playerid, pickupid) 
{
    if(!IsValidDynamicPickup(pickupid) || pPickupID[playerid]) return 0;
    pPickupID[playerid] = pickupid;
    SetPVarInt(playerid,"pickup",pickupid);

	kv_OnPlayerPickUpDynamicPickup(playerid, pickupid);
	
	for(new g = 0; g < TotalBusiness; g++) 
	{
		if(pickupid == BizInfo[g][data_PICKENTER]) 
		{
			if(BizInfo[g][bSealedDays] > 0) return SendClientMessage(playerid, COLOR_LIGHTGREY, !"Вы не можете зайти в этот бизнес, так-как он опечатан");
			
			BizInfo[g][bClient]++;
			SetPVarInt(playerid, "business", g);

			if(BizInfo[g][data_LOCK] == 0 || BizInfo[g][bOwned] != 1) 
			{
                if(BizInfo[g][data_TYPE] == 2) 
				{
					SetPlayerFacingAngle(playerid, 178.0463);
       				SetCameraBehindPlayer(playerid);
					SetPlayerPosAC(playerid,578.4819,84.4839,382.6700);
				}
   				if(BizInfo[g][data_TYPE] == 3) SetPlayerPosAC(playerid,204.5834,870.3509,1019.1500), SetCameraBehindPlayer(playerid);
				if(BizInfo[g][data_TYPE] == 6) 
				{
					if(GetPVarInt(playerid,"kdpickup") > gettime()) return 1;
					return ShowPlayerDialog(playerid, 9229, DIALOG_STYLE_MSGBOX, !"{ee3366}Автосалон", !"{FFFFFF}Вы действительно хотите попасть в автосалон?", "Да", "Нет");
				}
				else 
				{
					SetPlayerInterior(playerid, BizInfo[g][data_INT]);
					SetPlayerVirtualWorld(playerid, BizInfo[g][data_VW]);
					FreezePlayer(playerid);
					SetTimerEx("UnfreezePlayer", 4000, false, "d", playerid);
				}
            }
            else if(BizInfo[g][data_TYPE] != 1) SendPlayerCenterNotify(playerid, 2, "Этот бизенес закрыт", 5);
        }
        if(pickupid == BizInfo[g][data_PICKEXIT]) 
		{
	        SetPlayerPosAC(playerid,BizInfo[g][data_TPEXITX], BizInfo[g][data_TPEXITY], BizInfo[g][data_TPEXITZ]);
	        SetPlayerFacingAngle(playerid, BizInfo[g][data_ANGLE]);
	        SetCameraBehindPlayer(playerid);
            SetPlayerInterior(playerid,0);
            SetPlayerVirtualWorld(playerid,0);
			DeletePVar(playerid, "business");
		}
    }
	if(pickupid == metall_buy) ShowPlayerDialog(playerid, 9189, DIALOG_STYLE_INPUT, "{ee3366}Покупка металла", "{FFFFFF}Введите колличество металла, которое Вы хотите купить:\n{ffff99}Стоимость 1 кг: 30 руб", "Купить", "Закрыть");
	if(pickupid == drugs_buy) ShowPlayerDialog(playerid, 5414, DIALOG_STYLE_INPUT, "{ee3366}Покупка веществ", "{FFFFFF}Введите колличество веществ, которое Вы хотите купить:\n{ffff99}Стоимость 1 г: 50 руб", "Купить", "Закрыть");
	//информационные пикапы
	
	//информационный пикап ВЧ
	if(pickupid == VCHinfo) {
        return ShowPlayerDialog(playerid, 0, DIALOG_STYLE_MSGBOX, "{ee3366}Информация о призыве", "\
		{ffff99}1. Название организации\n\
		{ffffff}Войсковая часть\n\
		\n\
		{ffff99}2. Критерии для вступление в организацию\n\
		{ffffff}- Не состоять в других организациях\n\
		{ffffff}- Отсутствие предупреждений\n\
		{ffffff}- 2 уровень персонажа\n\
		{ffffff}- 8 ед. законопослушности\n\
	 	{ffffff}- Отсутствие розыска\n\
	 	{ffffff}- Наличие медицинской справки\n\
	 	\n\
	 	{ffff99}3. Время проведения\n\
        {ffffff}Следите за новостями в области\n\
		{ff0000}\n\
		{ffff99}4. Место проведения\n\
	 	{ffffff}Военкомат в пгт. Бусаево", "Закрыть", "");
	}
	//информационный пикап ВЧ-1
	if(pickupid == VCHinfo1) {
        return ShowPlayerDialog(playerid, 0, DIALOG_STYLE_MSGBOX, "{ee3366}Информация о призыве", "\
		{ffff99}1. Название организации\n\
		{ffffff}Войсковая часть\n\
		\n\
		{ffff99}2. Критерии для вступление в организацию\n\
		{ffffff}- Не состоять в других организациях\n\
		{ffffff}- Отсутствие предупреждений\n\
		{ffffff}- 2 уровень персонажа\n\
		{ffffff}- 8 ед. законопослушности\n\
	 	{ffffff}- Отсутствие розыска\n\
	 	{ffffff}- Наличие медицинской справки\n\
	 	\n\
	 	{ffff99}3. Время проведения\n\
        {ffffff}Следите за новостями в области\n\
		{ff0000}\n\
		{ffff99}4. Место проведения\n\
	 	{ffffff}Военкомат в пгт. Бусаево", "Закрыть", "");
	}
	//информационный пикап БЦРБ
	if(pickupid == CRBinfo) {
        return ShowPlayerDialog(playerid, 0, DIALOG_STYLE_MSGBOX, "{ee3366}Информация о собеседование", "\
		{ffff99}1. Название организации\n\
		{ffffff}БЦРБ\n\
		\n\
		{ffff99}2. Критерии для вступление в организацию\n\
		{ffffff}- Не состоять в других организациях\n\
		{ffffff}- Отсутствие предупреждений\n\
		{ffffff}- 3 уровень персонажа\n\
		{ffffff}- 8 ед. законопослушности\n\
	 	{ffffff}- Отсутствие розыска\n\
	 	{ffffff}- Наличие медицинской справки\n\
	 	\n\
	 	{ffff99}3. Время проведения\n\
        {ffffff}Следите за новостями в области\n\
		{ff0000}\n\
		{ffff99}4. Место проведения\n\
	 	{ffffff}Больница пгт.Батырево", "Закрыть", "");
	}
	//информационный пикап Правительства области
	if(pickupid == Pravoinfo) {
        return ShowPlayerDialog(playerid, 0, DIALOG_STYLE_MSGBOX, "{ee3366}Информация о собеседование", "\
		{ffff99}1. Название организации\n\
		{ffffff}Правительство области\n\
		\n\
		{ffff99}2. Критерии для вступление в организацию\n\
		{ffffff}- Не состоять в других организациях\n\
		{ffffff}- Отсутствие предупреждений\n\
		{ffffff}- 4 уровень персонажа\n\
		{ffffff}- 20 ед. законопослушности\n\
	 	{ffffff}- Отсутствие розыска\n\
	 	{ffffff}- Наличие медицинской справки\n\
	 	\n\
	 	{ffff99}3. Время проведения\n\
        {ffffff}Следите за новостями в области\n\
		{ff0000}\n\
		{ffff99}4. Место проведения\n\
	 	{ffffff}Мерия в г. Южном", "Закрыть", "");
	}
	if(pickupid == Pravoinfo1) {
        return ShowPlayerDialog(playerid, 0, DIALOG_STYLE_MSGBOX, "{ee3366}Информация о собеседование", "\
		{ffff99}1. Название организации\n\
		{ffffff}Правительство области\n\
		\n\
		{ffff99}2. Критерии для вступление в организацию\n\
		{ffffff}- Не состоять в других организациях\n\
		{ffffff}- Отсутствие предупреждений\n\
		{ffffff}- 4 уровень персонажа\n\
		{ffffff}- 20 ед. законопослушности\n\
	 	{ffffff}- Отсутствие розыска\n\
	 	{ffffff}- Наличие медицинской справки\n\
	 	\n\
	 	{ffff99}3. Время проведения\n\
        {ffffff}Следите за новостями в области\n\
		{ff0000}\n\
		{ffff99}4. Место проведения\n\
	 	{ffffff}Мерия в г. Южном", "Закрыть", "");
	}
	//информационный пикап Министерства Внутренних Дел (МВД)
	if(pickupid == MVDinfo) 
	{
        return ShowPlayerDialog(playerid, 0, DIALOG_STYLE_MSGBOX, !"{ee3366}Информация о собеседование", "\
		{ffff99}1. Название организации\n\
		{ffffff}Полиция\n\
		\n\
		{ffff99}2. Критерии для вступление в организацию\n\
		{ffffff}- Не состоять в других организациях\n\
		{ffffff}- Отсутствие предупреждений\n\
		{ffffff}- 5 уровень персонажа\n\
		{ffffff}- 20 ед. законопослушности\n\
	 	{ffffff}- Отсутствие розыска\n\
	 	{ffffff}- Наличие военного билета\n\
	 	{ffffff}- Наличие медицинской справки\n\
	 	\n\
	 	{ffff99}3. Время проведения\n\
        {ffffff}Следите за новостями в области\n\
		{ff0000}\n\
		{ffff99}4. Место проведения\n\
	 	{ffffff}Здание организации", "Закрыть", "");
    }
	if(pickupid == CRBPickCard) 
	{
		if(PI[playerid][pMedCard] != 0) return SCM(playerid, COLOR_GREY, !"У Вас уже есть медицинская карта");
		ShowPlayerDialog(playerid, 5413, DIALOG_STYLE_MSGBOX, !"{ee3366}Покупка медицинской карты", "\
		{FFFFFF}Вы действительно хотите преобрести медицинскую карту за {FFFF99}750 рублей?", "Да", "Нет");
	}
	for(new h = 0; h < TotalHouses; h++) 
	{
		if(HOUSE_DATA[h][data_PICKUPENTER] == pickupid) 
		{
			SetPVarInt(playerid, "house", h);
	       	if(HOUSE_DATA[h][data_OWNED] == 1) 
			{
		  		return ShowPlayerDialogf(playerid, dialog_ENTER_HOUSE, DIALOG_STYLE_MSGBOX, !"{ee3366}Дом куплен", "Войти", "Отмена", "{FFFFFF}Номер дома: %d\nВладелец: {3274c7}%s\n{FFFFFF}Название: Морской\n{FFFFFF}Стоимость: %d руб\n{FFFFFF}Кварплата: 1499 руб / день", h+1, HOUSE_DATA[h][data_OWNER], HOUSE_DATA[h][data_PRICE], HOUSE_DATA[h][data_DAY]);
			}
	    	else 
			{
		     	return ShowPlayerDialogf(playerid, 7900, DIALOG_STYLE_MSGBOX, !"{ee3366}Дом продаётся", "Купить", "Отмена", "{FFFFFF}Номер дома: %d\nНазвание: Морской\nСтоимость: %d рублей\nКварплата: 1499 руб / день",h+1,HOUSE_DATA[h][data_PRICE]);
			}
		}
	}
	if(pickupid == AutoSchool_Info) 
	{
		ShowPlayerDialog(playerid, dialog_schoolinfo, DIALOG_STYLE_MSGBOX, !"{ee3366}Справочник", "\
		{FFFFFF}Общие правила ПДД:\n\n\
		1. Максимальная скорость в неселенных пунктах - 60 км/час\n\
		2. Если Вас остановил инспектор ДПС, Вы должны остановится, спросить удостоверение инспектора и предъявить права и документы на Ваше ТС.\n\
		3. Обгон разрешен если:\n\
		3.1. Водитель не загромождает Вам обзор встречной полосы\n\
		3.2. Скорость водителя обгоняемого ТС, не выше чем 100 км/час.\n\
		4. Водителю ТС запрещается водить транспорт будучи не трезвым.\n\n\
		Желаем Вам удачи, приятной игры на {FFA500}"NAMESERVER"", "Закрыть", "");
		return 1;
	}
	if(pickupid == AutoSchool_Test) 
	{
	    if(PI[playerid][pDriveLicense] == 1) return SCM(playerid, COLOR_LIGHTGREY, !"У Вас уже есть водительские права");
	    PI[playerid][pSchoolTestLvl] = 0;
		return ShowPlayerDialog(playerid, dialog_schooltest, DIALOG_STYLE_MSGBOX, !"{ee3366}Автошкола", !"{FFFFFF}Вы действительно хотите сдать экзамен на водительские права?", "Да", "Нет");
	}
	if(pickupid == Dalnoboy_pickup) 
	{
	    if(PI[playerid][pDriveLicense] != 1) return SCM(playerid, COLOR_GREY, !"У Вас нет водительских прав");
	    if(PI[playerid][pLevel] < 3) return SCM(playerid, COLOR_GREY, !"Работа дальнобойщика доступна с 3-го уровня");
	    if(PI[playerid][pTempJob] == 2) return SCM(playerid, COLOR_GREY, !"Вы уже работаете дальнобойщиком");
	    PI[playerid][pSchoolTestLvl] = 0;
		return ShowPlayerDialog(playerid, dialog_dalnoboy, DIALOG_STYLE_MSGBOX, !"{ee3366}Дальнобойщики", !"{FFFFFF}Вы действительно хотите устроиться на работу дальнобойщиком?", "Да", "Нет");
	}
	if(pickupid == PAR_vhod) 
	{
	    SetPlayerVirtualWorld(playerid, 0);
	    SetPlayerInterior(playerid, 0);
	    SetPlayerPos(playerid, 2134.3328,-1969.9320,258.1160);
		SetPlayerFacingAngle(playerid, 269.9082);
		SetCameraBehindPlayer(playerid);
		return Freeze(playerid);
	}
	if(pickupid == AutoSchool_Enter) 
	{
	    SetPlayerVirtualWorld(playerid, 1);
	    SetPlayerInterior(playerid, 1);
	    SetPlayerPos(playerid, 2260.9907,2718.0132,1122.4604);
		SetPlayerFacingAngle(playerid, 179.4687);
		SetCameraBehindPlayer(playerid);
		return Freeze(playerid);
	}
	if(pickupid == AutoSchool_Exit) 
	{
	    SetPlayerVirtualWorld(playerid, 0);
	    SetPlayerInterior(playerid, 0);
	    SetPlayerPos(playerid, -571.3687,-1317.9279,41.3625);
		SetPlayerFacingAngle(playerid, 329.5674);
		SetCameraBehindPlayer(playerid);
		return Freeze(playerid);
	}
	if(pickupid == VhodMeriya) 
	{
	    SetPlayerVirtualWorld(playerid, 12);
	    SetPlayerInterior(playerid, 12);
	    SetPlayerPos(playerid, 1158.0021,2572.6350,1112.4800);
		SetPlayerFacingAngle(playerid, 179.0270);
		SetCameraBehindPlayer(playerid);
		return Freeze(playerid);
	}
	if(pickupid == VihodMeriya) 
	{
	    SetPlayerVirtualWorld(playerid, 0);
	    SetPlayerInterior(playerid, 0);
	    SetPlayerPos(playerid, 1824.3256,2095.8198,15.8522);
		SetPlayerFacingAngle(playerid, 270.6051);
		SetCameraBehindPlayer(playerid);
		return Freeze(playerid);
	}
	if(pickupid == VhodPravoKrisha) 
	{
	    SetPlayerVirtualWorld(playerid, 0);
	    SetPlayerInterior(playerid, 0);
	    SetPlayerPos(playerid, 1906.9309,-2219.6975,43.2401);
		SetPlayerFacingAngle(playerid, 181.6943);
		SetCameraBehindPlayer(playerid);
		return Freeze(playerid);
	}
	if(pickupid == VihodPravoKrisha) 
	{
	    SetPlayerVirtualWorld(playerid, -1);
	    SetPlayerInterior(playerid, -1);
	    SetPlayerPos(playerid, -31.8093,1815.1261,-35.9791);
		SetPlayerFacingAngle(playerid, 267.0909);
		SetCameraBehindPlayer(playerid);
		return Freeze(playerid);
	}
	if(pickupid == spawn_vihod) 
	{
	    SetPlayerVirtualWorld(playerid, 0);
	    SetPlayerInterior(playerid, 0);
	    SetPlayerPos(playerid, 1474.5623,2052.7285,12.5316);
		SetPlayerFacingAngle(playerid, 0.2259);
		SetCameraBehindPlayer(playerid);
		return Freeze(playerid);
	}	
	if(pickupid == spawn_vhod) 
	{
	    SetPlayerVirtualWorld(playerid, 0);
	    SetPlayerInterior(playerid, 0);
	    SetPlayerPos(playerid, 1600.1017,2024.5760,-55.7341);
		SetPlayerFacingAngle(playerid,180.1992);
		SetCameraBehindPlayer(playerid);
		return Freeze(playerid);
	}	
	if(pickupid == VhodLiftMeriya) 
	{
		if(PI[playerid][pMember] != 1) return SCM(playerid, COLOR_GREY, !"Вы не являетесь сотрудником Правительства");
	    SetPlayerVirtualWorld(playerid, 13);
	    SetPlayerInterior(playerid, 13);
	    SetPlayerPos(playerid, -35.3435,1814.9761,-35.9791);
		SetPlayerFacingAngle(playerid, 269.7230);
		SetCameraBehindPlayer(playerid);
		return Freeze(playerid);
	}
	if(pickupid == VihodLiftMeriya) 
	{
	    SetPlayerVirtualWorld(playerid, 0);
	    SetPlayerInterior(playerid, 0);
	    SetPlayerPos(playerid, 1907.5306,-2233.1201,11.2457);
		SetPlayerFacingAngle(playerid, 178.2872);
		SetCameraBehindPlayer(playerid);
		return Freeze(playerid);
	}
	if(pickupid == VhodKaznaPickup) 
	{
		if(PI[playerid][pMember] == 1) 
		{
			if(PI[playerid][pRang] == 10) 
			{
			    SetPlayerVirtualWorld(playerid, 13);
			    SetPlayerInterior(playerid, 13);
			    SetPlayerPos(playerid, -1359.5652,1240.2517,2102.4299);
				SetPlayerFacingAngle(playerid, 268.3569);
				SetCameraBehindPlayer(playerid);
				Freeze(playerid);
			}
		}
		else return SCM(playerid, COLOR_GREY, !"В это помещение может войти только Губернатор");
		return 1;
	}
	if(pickupid== VihodKaznaPickup) 
	{
	    SetPlayerVirtualWorld(playerid, 13);
	    SetPlayerInterior(playerid, 13);
	    SetPlayerPos(playerid, 1149.9795,2565.3928,1112.4800);
		SetPlayerFacingAngle(playerid, 271.4862);
		SetCameraBehindPlayer(playerid);
		return Freeze(playerid);
	}
	if(pickupid == Kazna_GiveMoney) 
	{
		if(PI[playerid][pRang] < 9) return SCM(playerid, COLOR_GREY, !"Казна города доступна лидеру организаций и его заместителям");
		if(GetPVarInt(playerid,"Counting_Treasury") > gettime()) return SCM(playerid, COLOR_GREY, !"Деньги из казны можно брать раз в 5 минут");
		ShowPlayerDialog(playerid, 3456, DIALOG_STYLE_MSGBOX, !"{ee3366}Казна", "{FFFFFF}Вы можете взять 5000 рублей из общей казны.\n\
						Обратите внимание на то, что Вам разрешено брать лишь 5000 рублей в 5 минут", 
						"Выбрать", "Закрыть"
		);
	}
	if(pickupid == VhodArmy1) 
	{
	    SetPlayerVirtualWorld(playerid, 1);
	    SetPlayerInterior(playerid, 1);
	    SetPlayerPos(playerid, 2491.6360, 212.7043, 1502.4700);
		SetPlayerFacingAngle(playerid, 359.0);
		SetCameraBehindPlayer(playerid);
		return Freeze(playerid);
	}
	if(pickupid == VhodArmy2) {
	    SetPlayerVirtualWorld(playerid, 0);
	    SetPlayerInterior(playerid, 0);
	    SetPlayerPos(playerid, -457.1503,-1493.2516,41.0700);
		SetPlayerFacingAngle(playerid, 139.1754);
		SetCameraBehindPlayer(playerid);
		return Freeze(playerid);
	}
	if(pickupid == VhodArmyKazarmy) {
        if(PI[playerid][pMember] != 2) return SCM(playerid, COLOR_GREY, !"Вход в казармы доступен только военным");
	    SetPlayerVirtualWorld(playerid, -5);
	    SetPlayerInterior(playerid, -5);
	    SetPlayerPos(playerid, 742.7545,1510.1522,2002.1899);
		SetPlayerFacingAngle(playerid, 0.8219);
		SetCameraBehindPlayer(playerid);
		return Freeze(playerid);
	}
	if(pickupid == VihodArmyKazarmy) 
	{
		if(PI[playerid][pHospital] == 1) return SCM(playerid, COLOR_GREY, !"Вы должны пройти курс восстановления");
	    SetPlayerVirtualWorld(playerid, 0);
	    SetPlayerInterior(playerid, 0);
	    SetPlayerPos(playerid, -2585.1865,316.2705,12.1611);
		SetPlayerFacingAngle(playerid, 359.7137);
		SetCameraBehindPlayer(playerid);
		return Freeze(playerid);
	}
	if(pickupid  == VhodArmyStolovaya) 
	{
		if(PI[playerid][pMember] != 2) return SCM(playerid, COLOR_GREY, !"Вход в столовую доступен только военным");
	    SetPlayerVirtualWorld(playerid, -6);
	    SetPlayerInterior(playerid, -6);
	    SetPlayerPos(playerid, -2434.6191,1808.5900,2053.4800);
		SetPlayerFacingAngle(playerid, 180.2651);
		SetCameraBehindPlayer(playerid);
		return Freeze(playerid);
	}
	if(pickupid == VihodArmyStolovaya) 
	{
	    SetPlayerVirtualWorld(playerid, 0);
	    SetPlayerInterior(playerid, 0);
	    SetPlayerPos(playerid, -2563.2021,356.7684,12.1115);
		SetPlayerFacingAngle(playerid, 92.6570);
		SetCameraBehindPlayer(playerid);
		return Freeze(playerid);
	}
	if(pickupid == 	vhodtirkavkaz)
	{
	    SetPlayerVirtualWorld(playerid, -5);
	    SetPlayerInterior(playerid, -5);
	    SetPlayerPos(playerid, -146.5389,1816.7775,-5.9800);
		SetPlayerFacingAngle(playerid, 181.4917);
		SetCameraBehindPlayer(playerid);
		return Freeze(playerid);
	}
	if(pickupid == 	vihodtirkavkaz) 
	{
	    SetPlayerVirtualWorld(playerid, 0);
	    SetPlayerInterior(playerid, 0);
	    SetPlayerPos(playerid, -358.2168,-1182.2168,41.0009);
		SetPlayerFacingAngle(playerid, 144.0298);
		SetCameraBehindPlayer(playerid);
		return Freeze(playerid);
	}
	if(pickupid == 	vhodtirgopota) {
	    SetPlayerVirtualWorld(playerid, -4);
	    SetPlayerInterior(playerid, -4);
	    SetPlayerPos(playerid, -146.5389,1816.7775,-5.9800);
		SetPlayerFacingAngle(playerid, 181.4917);
		SetCameraBehindPlayer(playerid);
		return Freeze(playerid);
	}
	if(pickupid == 	vihodtirgopota) {
	    SetPlayerVirtualWorld(playerid, 0);
	    SetPlayerInterior(playerid, 0);
	    SetPlayerPos(playerid, 2251.6357,-2595.9426,21.9417);
		SetPlayerFacingAngle(playerid, 91.4771);
		SetCameraBehindPlayer(playerid);
		return Freeze(playerid);
	}
	if(pickupid == 	vhodtirskinhed) {
	    SetPlayerVirtualWorld(playerid, -3);
	    SetPlayerInterior(playerid, -3);
	    SetPlayerPos(playerid, -146.5389,1816.7775,-5.9800);
		SetPlayerFacingAngle(playerid, 181.4917);
		SetCameraBehindPlayer(playerid);
		return Freeze(playerid);
	}
	if(pickupid == 	vihodtirskinhed) {
	    SetPlayerVirtualWorld(playerid, 0);
	    SetPlayerInterior(playerid, 0);
	    SetPlayerPos(playerid, 1401.2567,2396.5078,13.3801);
		SetPlayerFacingAngle(playerid, 176.5042);
		SetCameraBehindPlayer(playerid);
		return Freeze(playerid);
	}
	if(pickupid == 	vhodtirvch) 
	{
	    SetPlayerVirtualWorld(playerid, 3);
	    SetPlayerInterior(playerid, 3);
	    SetPlayerPos(playerid, -146.5389,1816.7775,-5.9800);
		SetPlayerFacingAngle(playerid, 181.4917);
		SetCameraBehindPlayer(playerid);
		return Freeze(playerid);
	}
	if(pickupid == 	vihodtirvch) {
	    SetPlayerVirtualWorld(playerid, 0);
	    SetPlayerInterior(playerid, 0);
	    SetPlayerPos(playerid,-2637.2041,312.9039,11.0944);
		SetPlayerFacingAngle(playerid, 92.3226);
		SetCameraBehindPlayer(playerid);
		return Freeze(playerid);
	}
	if(pickupid == 	vhodtirpravo) {
	    SetPlayerVirtualWorld(playerid, -1);
	    SetPlayerInterior(playerid, -1);
	    SetPlayerPos(playerid, -146.5389,1816.7775,-5.9800);
		SetPlayerFacingAngle(playerid, 181.4917);
		SetCameraBehindPlayer(playerid);
		return Freeze(playerid);
	}
	if(pickupid == 	vihodtirpravo) {
	    SetPlayerVirtualWorld(playerid, 0);
	    SetPlayerInterior(playerid, 0);
	    SetPlayerPos(playerid, 1908.1782,-2205.6362,11.2457);
		SetPlayerFacingAngle(playerid, 0.7915);
		SetCameraBehindPlayer(playerid);
		return Freeze(playerid);
	}
	if(pickupid == EatPolice || pickupid == EatPolice1 || pickupid == ArmyStolovaya) return ShowPlayerDialog(playerid, 3898, DIALOG_STYLE_LIST, "{ee3366}Пищевой автомат", "1. Кока Кола\n2. Шоколадка сникерс\n3. Энергетик '"ENERGO"'", "Выбрать", "Закрыть");
	if(pickupid == VihodVoenkomat) {
	    SetPlayerVirtualWorld(playerid, 0);
	    SetPlayerInterior(playerid, 0);
	    SetPlayerPos(playerid, 1915.7534,2302.0249,15.5697);
		SetPlayerFacingAngle(playerid, 120.3523);
		SetCameraBehindPlayer(playerid);
		return Freeze(playerid);
	}
	if(pickupid == vhodbank) {
	    SetPlayerVirtualWorld(playerid, 92);
	    SetPlayerInterior(playerid, 92);
	    SetPlayerPos(playerid, 1536.0514,1811.5703,578.6213);
		SetPlayerFacingAngle(playerid, 359.6876);
		SetCameraBehindPlayer(playerid);
		return Freeze(playerid);
	}
	if(pickupid == vihodbank) {
	    SetPlayerVirtualWorld(playerid, 0);
	    SetPlayerInterior(playerid, 0);
	    SetPlayerPos(playerid, 1794.86,2041.26,15.87);
		SetPlayerFacingAngle(playerid, 357.97);
		SetCameraBehindPlayer(playerid);
		return Freeze(playerid);
	}
	if(pickupid == Casino_Enter) {
	    SetPlayerVirtualWorld(playerid, 12);
	    SetPlayerInterior(playerid, 12);
	    SetPlayerPos(playerid, 594.3975,-107.5603,728.1457);
		SetPlayerFacingAngle(playerid, 270.6073);
		SetCameraBehindPlayer(playerid);
		return Freeze(playerid);
	}
	if(pickupid == Casino_Exit) 
	{
	    SetPlayerVirtualWorld(playerid, 0);
	    SetPlayerInterior(playerid, 0);
	    SetPlayerPos(playerid, 2321.9126,-1933.5485,21.9573);
		SetPlayerFacingAngle(playerid, 2.6703);
		SetCameraBehindPlayer(playerid);
		return Freeze(playerid);
	}
	if(pickupid == PalataEnter_1) 
	{
	    SetPlayerVirtualWorld(playerid, 1);
	    SetPlayerInterior(playerid, 1);
	    SetPlayerPos(playerid, 2105.5593,1462.6266,-47.5200);
		SetPlayerFacingAngle(playerid, 178.9202);
		SetCameraBehindPlayer(playerid);
		return Freeze(playerid);
    }
	if(pickupid == PalataEnter_2) 
	{
	    SetPlayerVirtualWorld(playerid, 1);
	    SetPlayerInterior(playerid, 2);
	    SetPlayerPos(playerid, 2105.5593,1462.6266,-47.5200);
		SetPlayerFacingAngle(playerid, 178.9202);
		SetCameraBehindPlayer(playerid);
		return Freeze(playerid);
    }
	if(pickupid == PalataEnter_3) 
	{
	    SetPlayerVirtualWorld(playerid, 1);
	    SetPlayerInterior(playerid, 3);
	    SetPlayerPos(playerid, 2105.5593,1462.6266,-47.5200);
		SetPlayerFacingAngle(playerid, 178.9202);
		SetCameraBehindPlayer(playerid);
		return Freeze(playerid);
    }
	if(pickupid == PalataEnter_4) 
	{
	    SetPlayerVirtualWorld(playerid, 1);
	    SetPlayerInterior(playerid, 4);
	    SetPlayerPos(playerid, 2105.5593,1462.6266,-47.5200);
		SetPlayerFacingAngle(playerid, 178.9202);
		SetCameraBehindPlayer(playerid);
		return Freeze(playerid);
    }
	if(pickupid == PalataExit) 
	{
		if(PI[playerid][pHospital] == 1) return SCM(playerid, COLOR_GREY, !"Вы должны пройти курс восстановления");

		switch(GetPlayerInterior(playerid))
		{
			case 1:
			{
				SetPlayerPos(playerid, 2147.0642, 1494.2797, -47.5522);
				SetPlayerFacingAngle(playerid, 179.5594);
			}
			case 2:
			{
				SetPlayerPos(playerid, 2144.4939,1495.2432,-47.5522);
				SetPlayerFacingAngle(playerid, 177.8755);
			}
			case 3:
			{
				SetPlayerPos(playerid, 2144.3362,1493.7542,-47.5522);
				SetPlayerFacingAngle(playerid, 356.4270);
			}
			case 4:
			{
				SetPlayerPos(playerid, 2147.3728,1494.1027,-47.5522);
				SetPlayerFacingAngle(playerid, 357.2792);
			}
		}

	    SetPlayerVirtualWorld(playerid, 1);
	    SetPlayerInterior(playerid, 1);
		SetCameraBehindPlayer(playerid);
		return Freeze(playerid);
    }
    if(pickupid == Ordinatorskaya_Enter) 
	{
  		if(PI[playerid][pMember] != 4) return SCM(playerid, COLOR_GREY, !"Вы не являетесь сотрудником БЦРБ");
	    SetPlayerVirtualWorld(playerid, 0);
	    SetPlayerInterior(playerid, 2);
  		SetPlayerPos(playerid, -2848.6548,2814.5430,1002.1600);
		SetPlayerFacingAngle(playerid, 269.7516);
		SetCameraBehindPlayer(playerid);
		return Freeze(playerid);
    }
    if(pickupid == Ordinatorskaya_Exit) 
	{
	    SetPlayerVirtualWorld(playerid, 1);
	    SetPlayerInterior(playerid, 1);
  		SetPlayerPos(playerid, -688.8541,1662.8464,1002.0200);
		SetPlayerFacingAngle(playerid, 180.3450);
		SetCameraBehindPlayer(playerid);
		return Freeze(playerid);
    }
    if(pickupid == BCRDEnter)
    {
	    SetPlayerVirtualWorld(playerid, 1);
	    SetPlayerInterior(playerid, 1);

  		SetPlayerPos(playerid, 2147.1094,1530.8121,-47.2944);
		SetPlayerFacingAngle(playerid, 357.9888);
		SetCameraBehindPlayer(playerid);
		Freeze(playerid);
		return true;
    }
	if(pickupid == LiftMedical_1)
    {
	    SetPlayerVirtualWorld(playerid, 1);
	    SetPlayerInterior(playerid, 1);

  		SetPlayerPos(playerid, 2149.9568,1494.5905,-47.5522);
		SetPlayerFacingAngle(playerid, 89.7152);
		SetCameraBehindPlayer(playerid);
		Freeze(playerid);
		return true;
    }
	if(pickupid == LiftMedical_2)
    {
	    SetPlayerVirtualWorld(playerid, 1);
	    SetPlayerInterior(playerid, 1);

  		SetPlayerPos(playerid, 2164.1282,1535.7817,-47.2944);
		SetPlayerFacingAngle(playerid, 90.6740);
		SetCameraBehindPlayer(playerid);
		Freeze(playerid);
		return true;
    }
	if(pickupid == LiftMedicalPersonal_1 || pickupid == LiftMedicalPersonal_2 || pickupid == LiftMedicalPersonal_3)
    {
		if(PI[playerid][pMember] != 4) return SCM(playerid, COLOR_GREY, !"Вы не являетесь сотрудником БЦРБ");
		ShowPlayerDialog(playerid, 1932, DIALOG_STYLE_LIST, "{ee3366}Лифт", "1 этаж\n2 этаж\n3 этаж", "Вызвать", "Закрыть");
		return true;
    }
   	if(pickupid == BCRDExit)
    {
	    SetPlayerVirtualWorld(playerid, 0);
	    SetPlayerInterior(playerid, 0);

  		SetPlayerPos(playerid, 2107.5298,1821.8654,12.0540);
		SetPlayerFacingAngle(playerid, 90.9506);
		SetCameraBehindPlayer(playerid);
		Freeze(playerid);
		return true;
    }
    if(pickupid == MineEnter)
    {
	    SetPlayerVirtualWorld(playerid, 1);
	    SetPlayerInterior(playerid, 1);

  		SetPlayerPos(playerid, 2055.6670,1642.0542,-40.6281);
		SetPlayerFacingAngle(playerid, 178.9299);
		SetCameraBehindPlayer(playerid);
		Freeze(playerid);
		return true;
    }
   	if(pickupid == MineExit)
    {
		if(PI[playerid][pTempJob] == 2) return SendClientMessage(playerid, COLOR_GREY, !"Для начала закончите рабочий день");
	    SetPlayerVirtualWorld(playerid, 0);
	    SetPlayerInterior(playerid, 0);

  		SetPlayerPos(playerid, 2795.5710,2710.9250,14.9075);
		SetPlayerFacingAngle(playerid, 190.3421);
		SetCameraBehindPlayer(playerid);
		Freeze(playerid);
		return true;
    }
    if(pickupid == opgintvhod_offklub) 
	{
        if(PI[playerid][pMember] != 7) return SCM(playerid, COLOR_GREY, !"Вы не являетесь участником ОПГ Кавказ");
	    SetPlayerVirtualWorld(playerid, 1);
	    SetPlayerInterior(playerid, 1);
	    
  		SetPlayerPos(playerid, -2126.8423,2391.8218,1501.8101);
		SetPlayerFacingAngle(playerid, 358.7969);
		SetCameraBehindPlayer(playerid);
		Freeze(playerid);
		SetTimerEx("UnfreezePlayer", 4000, false, "d", playerid);
		return Freeze(playerid);
    }
  	if(pickupid == opgintvihod_offklub) {
	    SetPlayerVirtualWorld(playerid, 0);
	    SetPlayerInterior(playerid, 0);
  		SetPlayerPos(playerid, -320.3986,-1075.6229,41.1194);
		SetPlayerFacingAngle(playerid, 149.2962);
		SetCameraBehindPlayer(playerid);
		Freeze(playerid);
		SetTimerEx("UnfreezePlayer", 4000, false, "d", playerid);
		return Freeze(playerid);
    }
    if(pickupid == opgintvhod_gopota) {
    	if(PI[playerid][pMember] != 6) return SCM(playerid, COLOR_GREY, !"Вы не являетесь участником ОПГ Гопота");
	    SetPlayerVirtualWorld(playerid, 2);
	    SetPlayerInterior(playerid, 2);
  		SetPlayerPos(playerid, -2126.8423,2391.8218,1501.8101);
		SetPlayerFacingAngle(playerid, 358.7969);
		SetCameraBehindPlayer(playerid);
		return Freeze(playerid);
    }
    if(pickupid == opgintvihod_gopota) {
	    SetPlayerVirtualWorld(playerid, 0);
	    SetPlayerInterior(playerid, 0);
  		SetPlayerPos(playerid, 2216.0371,-2594.6599,21.9600);
		SetPlayerFacingAngle(playerid, 357.6554);
		SetCameraBehindPlayer(playerid);
		return Freeze(playerid);
    }
    if(pickupid == opgintvhod_skinhead) 
	{
    	if(PI[playerid][pMember] != 5) return SCM(playerid, COLOR_GREY, !"Вы не являетесь участником ОПГ Скинхедов");
	    SetPlayerVirtualWorld(playerid, 3);
	    SetPlayerInterior(playerid, 3);
  		SetPlayerPos(playerid, -2126.8423,2391.8218,1501.8101);
		SetPlayerFacingAngle(playerid, 358.7969);
		SetCameraBehindPlayer(playerid);
		return Freeze(playerid);
    }
    if(pickupid == opgintvihod_skinhead) 
	{
	    SetPlayerVirtualWorld(playerid, 0);
	    SetPlayerInterior(playerid, 0);
  		SetPlayerPos(playerid, 1444.3300,2351.3674,12.8216);
		SetPlayerFacingAngle(playerid, 268.1378);
		SetCameraBehindPlayer(playerid);
		return Freeze(playerid);
    }
	if(pickupid == skinhead_sklad && PI[playerid][pMember] == 5) return ShowPlayerDialog(playerid, dialog_SKLAD, DIALOG_STYLE_LIST, "{ee3366}Склад ОПГ", "1. Взять металл\n2. Взять патроны\n3. Взять вещества\n4. Положить металл\n5. Положить патроны\n6. Положить вещества", "Выбрать", "Отмена");
	if(pickupid == gopota_sklad && PI[playerid][pMember] == 6) return ShowPlayerDialog(playerid, dialog_SKLAD, DIALOG_STYLE_LIST, "{ee3366}Склад ОПГ", "1. Взять металл\n2. Взять патроны\n3. Взять вещества\n4. Положить металл\n5. Положить патроны\n6. Положить вещества", "Выбрать", "Отмена");
	if(pickupid == kavkaz_sklad && PI[playerid][pMember] == 7) return ShowPlayerDialog(playerid, dialog_SKLAD, DIALOG_STYLE_LIST, "{ee3366}Склад ОПГ", "1. Взять металл\n2. Взять патроны\n3. Взять вещества\n4. Положить металл\n5. Положить патроны\n6. Положить вещества", "Выбрать", "Отмена");
    if(pickupid == vxoddchmvd0) {
		if(PI[playerid][pMember] != 3) return SCM(playerid, COLOR_GREY, !"Вы не являетесь сотрудником Полиции");
        SetPlayerVirtualWorld(playerid, -1);
        SetPlayerInterior(playerid, -1);
        SetPlayerPos(playerid, 137.5166,1895.2310,-31.9697);
        SetPlayerFacingAngle(playerid, 169.2762);
        SetCameraBehindPlayer(playerid);
		FreezePlayer(playerid);
		SetTimerEx("UnfreezePlayer", 4000, false, "d", playerid);
    }
    if(pickupid == vxoddchmvd1) {
        SetPlayerVirtualWorld(playerid, 0);
        SetPlayerInterior(playerid, 0);
        SetPlayerPos(playerid, 2418.7007,-1809.6227,21.9341);
        SetPlayerFacingAngle(playerid, 1.3724);
        SetCameraBehindPlayer(playerid);
		FreezePlayer(playerid);
		SetTimerEx("UnfreezePlayer", 4000, false, "d", playerid);
    }
    if(pickupid == VhodSportzalPolice) {
		if(PI[playerid][pMember] != 3) return SCM(playerid, COLOR_GREY, !"Вы не являетесь сотрудником Полиции");
        SetPlayerVirtualWorld(playerid, -1);
        SetPlayerInterior(playerid, -1);
        SetPlayerPos(playerid, 140.6302,1981.2865,-16.3778);
        SetPlayerFacingAngle(playerid, 267.6423);
        SetCameraBehindPlayer(playerid);
		FreezePlayer(playerid);
		SetTimerEx("UnfreezePlayer", 4000, false, "d", playerid);
    }
    if(pickupid == VihodSportzalPolice) {
        SetPlayerVirtualWorld(playerid, 0);
        SetPlayerInterior(playerid, 0);
        SetPlayerPos(playerid, 2384.8337,-1799.6332,21.9341);
        SetPlayerFacingAngle(playerid, 173.3940);
        SetCameraBehindPlayer(playerid);
		FreezePlayer(playerid);
		SetTimerEx("UnfreezePlayer", 4000, false, "d", playerid);
    }
	if(pickupid == MeriyaGarageVhod) {
	    if(PI[playerid][pMember] != 1) return SCM(playerid, COLOR_GREY, !"Вы не являетесь сотрудником Правительство");
 		SetPlayerVirtualWorld(playerid, 1);
	    SetPlayerInterior(playerid, 1);
	    SetPlayerPos(playerid, -166.5044,627.3314,-50.1706);
		SetPlayerFacingAngle(playerid, 271.0976);
		SetCameraBehindPlayer(playerid);
		return Freeze(playerid);
	}
	if(pickupid == MeriyaGarageVihod) {
 		SetPlayerVirtualWorld(playerid, 0);
	    SetPlayerInterior(playerid, 0);
	    SetPlayerPos(playerid, 1874.0914,-2211.9246,11.2510);
		SetPlayerFacingAngle(playerid, 179.2040);
		SetCameraBehindPlayer(playerid);
		return Freeze(playerid);
	}
	if(pickupid == EnterArmyShop) 
	{
	    if(PI[playerid][pMember] != 2) return SCM(playerid, COLOR_GREY, !"Вы не являетесь сотрудником Войсковой Части");
 		SetPlayerVirtualWorld(playerid, 0);
	    SetPlayerInterior(playerid, 0);
	    SetPlayerPos(playerid, -1412.4888,383.8317,419.1073);
		SetPlayerFacingAngle(playerid, 357.1213);
		SetCameraBehindPlayer(playerid);
		return Freeze(playerid);
	}
	if(pickupid == ExitArmyShop) 
	{
 		SetPlayerVirtualWorld(playerid, 0);
	    SetPlayerInterior(playerid, 0);
	    SetPlayerPos(playerid, -2604.8157,356.3453,12.1580);
		SetPlayerFacingAngle(playerid, 269.3736);
		SetCameraBehindPlayer(playerid);
		return Freeze(playerid);
	}
	if(pickupid == Pravo_givegun_pickup) 
	{
		if(PI[playerid][pMember] != 1) return SCM(playerid, COLOR_GREY, "У Вас нет доступа к этому складу");
		ShowPlayerDialog(playerid, dialog_GIVEGUNPRAVO, DIALOG_STYLE_LIST, "{ee3366}Получение оружия", "1. ПЛ-15\n2. Тайзер\n3. AKС-74У", "Получить", "Отмена");
	}
	if(pickupid == ArmyShop) 
	{
		if(PI[playerid][pMember] != 2) return SCM(playerid, COLOR_GREY, !"У Вас нет доступа к армейскому магазину");
		ShowArmyShop(playerid);
	}
	if(pickupid == MVDGarageVhod) {
	    if(PI[playerid][pMember] != 3) return SCM(playerid, COLOR_GREY, !"Вы не являетесь сотрудником Полиции");
 		SetPlayerVirtualWorld(playerid, 2);
	    SetPlayerInterior(playerid, 1);
	    SetPlayerPos(playerid, -166.5044,627.3314,-50.1706);
		SetPlayerFacingAngle(playerid, 271.0976);
		SetCameraBehindPlayer(playerid);
		return Freeze(playerid);
	}
	if(pickupid == MVDGarageVihod) {
 		SetPlayerVirtualWorld(playerid, 0);
	    SetPlayerInterior(playerid, 0);
	    SetPlayerPos(playerid, 2438.2107,-1799.6512,21.9369);
		SetPlayerFacingAngle(playerid, 88.3939);
		SetCameraBehindPlayer(playerid);
		return Freeze(playerid);
	}
	if(pickupid == CRBGarageVhod)
	{
	    if(PI[playerid][pMember] != 4) return SCM(playerid, COLOR_GREY, !"Вы не являетесь сотрудником БЦРБ");
 		SetPlayerVirtualWorld(playerid, 3);
	    SetPlayerInterior(playerid, 1);
	    SetPlayerPos(playerid, -166.5044,627.3314,-50.1706);
		SetPlayerFacingAngle(playerid, 271.0976);
		SetCameraBehindPlayer(playerid);
		return Freeze(playerid);
	}
	if(pickupid == CRBGarageVihod)
	{
 		SetPlayerVirtualWorld(playerid, 0);
	    SetPlayerInterior(playerid, 0);
	    SetPlayerPos(playerid, 2141.0293,1806.8695,12.2200);
		SetPlayerFacingAngle(playerid, 181.3150);
		SetCameraBehindPlayer(playerid);
		return Freeze(playerid);
	}
	if(pickupid == VchGarageVhod)
	{
	    if(PI[playerid][pMember] != 8)
        if(PI[playerid][pMember] != 2) return SCM(playerid, COLOR_GREY, !"Вы не являетесь Сотрудником Воинской части");
 		SetPlayerVirtualWorld(playerid, 4);
	    SetPlayerInterior(playerid, 1);
	    SetPlayerPos(playerid, -166.5044,627.3314,-50.1706);
		SetPlayerFacingAngle(playerid, 271.0976);
		SetCameraBehindPlayer(playerid);
		return Freeze(playerid);
	}
	if(pickupid == VchGarageVihod)
	{
 		SetPlayerVirtualWorld(playerid, 0);
	    SetPlayerInterior(playerid, 0);
	    SetPlayerPos(playerid, -2754.8423,351.2632,10.9850);
		SetPlayerFacingAngle(playerid, 269.9922);
		SetCameraBehindPlayer(playerid);
		return Freeze(playerid);
	}
    if(pickupid == GopotaGarageVhod)
    {
	    if(PI[playerid][pMember] != 6) return SCM(playerid, COLOR_GREY, !"Вы не являетесь участником ОПГ Гопота");
 		SetPlayerVirtualWorld(playerid, 5);
	    SetPlayerInterior(playerid, 1);
	    SetPlayerPos(playerid, -166.5044,627.3314,-50.1706);
		SetPlayerFacingAngle(playerid, 271.0976);
		SetCameraBehindPlayer(playerid);
		return Freeze(playerid);
    }
	if(pickupid == GopotaGarageVihod)
	{
 		SetPlayerVirtualWorld(playerid, 0);
	    SetPlayerInterior(playerid, 0);
	    SetPlayerPos(playerid, 2241.0183,-2585.5557,21.9600);
		SetPlayerFacingAngle(playerid, 91.1827);
		SetCameraBehindPlayer(playerid);
		return Freeze(playerid);
	}
    if(pickupid == SkinheadGarageVhod)
    {
	    if(PI[playerid][pMember] != 5) return SCM(playerid, COLOR_GREY, !"Вы не являетесь участником ОПГ Скинхеды");
 		SetPlayerVirtualWorld(playerid, 6);
	    SetPlayerInterior(playerid, 1);
	    SetPlayerPos(playerid, -166.5044,627.3314,-50.1706);
		SetPlayerFacingAngle(playerid, 271.0976);
		SetCameraBehindPlayer(playerid);
		return Freeze(playerid);
    }
	if(pickupid == SkinheadGarageVihod)
	{
 		SetPlayerVirtualWorld(playerid, 0);
	    SetPlayerInterior(playerid, 0);
	    SetPlayerPos(playerid, 1453.0161,2359.5623,12.8316);
		SetPlayerFacingAngle(playerid, 180.3604);
		SetCameraBehindPlayer(playerid);
		return Freeze(playerid);
	}
	if(pickupid == OffClubGarageVhod)
	{
	    if(PI[playerid][pMember] != 7) return SCM(playerid, COLOR_GREY, !"Вы не являетесь участником ОПГ Кавказцы");
 		SetPlayerVirtualWorld(playerid, 7);
	    SetPlayerInterior(playerid, 1);
	    SetPlayerPos(playerid, -166.5044,627.3314,-50.1706);
		SetPlayerFacingAngle(playerid, 271.0976);
		SetCameraBehindPlayer(playerid);
		return Freeze(playerid);
	}
	if(pickupid == OffClubGarageVihod)
	{
 		SetPlayerVirtualWorld(playerid, 0);
	    SetPlayerInterior(playerid, 0);
	    SetPlayerPos(playerid,  -314.1159,-1086.3938,41.1115);
		SetPlayerFacingAngle(playerid, 58.8672);
		SetCameraBehindPlayer(playerid);
		return Freeze(playerid);
	}
	// МВД #2
    if(pickupid == VhodUchastokMVD0) {
        SetPlayerVirtualWorld(playerid, -1);
        SetPlayerInterior(playerid, -1);
        SetPlayerPos(playerid, 126.3267,1853.6423,-31.9775);
        SetPlayerFacingAngle(playerid, 353.6208);
        SetCameraBehindPlayer(playerid);
		FreezePlayer(playerid);
		SetTimerEx("UnfreezePlayer", 4000, false, "d", playerid);
    }
    if(pickupid == VhodUchastokMVD1) {
        SetPlayerVirtualWorld(playerid, 0);
        SetPlayerInterior(playerid, 0);
        SetPlayerPos(playerid, 2401.9204,-1846.5687,21.9369);
        SetPlayerFacingAngle(playerid, 175.3953);
        SetCameraBehindPlayer(playerid);
		FreezePlayer(playerid);
		SetTimerEx("UnfreezePlayer", 4000, false, "d", playerid);
    }
	if(pickupid == MVD_givegun_pickup) 
	{
		if(PI[playerid][pMember] != 3) return SCM(playerid, COLOR_GREY, !"У Вас нет доступа к этому складу");
		ShowPlayerDialog(playerid, 7622, DIALOG_STYLE_LIST, "{ee3366}Государственный склад", "1. Взять аптечки\n2. Взять оружие", "Взять", "Закрыть");
	}
	if(pickupid == vch_givegun_pickup) 
	{
		if(PI[playerid][pMember] != 2) return SCM(playerid, COLOR_GREY, !"У Вас нет доступа к этому складу");
		ShowPlayerDialog(playerid, 7621, DIALOG_STYLE_LIST, "{ee3366}Оружейный склад", "1. Лопата\t\t1+\t1\n2. Бронижелет\t\t2+\t-\n3. ПЛ-15\t\t1+\t35\n4. AKC-74Y\t\t1+\t90\n5. AK-47\t\t2+\t90\n6. Country Rifle\t\t3+\t10", "Взять", "Закрыть");
	}
    if(pickupid == PickupAutoSchool) 
	{
	    if(PI[playerid][pDriveLicense] == 1) return SCM(playerid, COLOR_GREY, !"У Вас уже есть водительские права");
		if(PI[playerid][data_ASH_TEST] == 1) return SCM(playerid, COLOR_GREY, !"Вы уже проходите тест");
        ShowPlayerDialog(playerid, dialog_ASH_TEST, DIALOG_STYLE_MSGBOX, !"{ee3366}Экзамен по вождению", "Вы желаете получить водительские права?\nСтоимость экзамена: 5000 рублей", "Начать", "Отмена");
		return 1;
	}
	return 1;
}
callback: CBugFreezeOver(playerid) 
{
	TogglePlayerControllable(playerid, true);
	pCBugging[playerid] = false;
	return 1;
}
public OnPlayerSelectedMenuRow(playerid, row) 
{
    if(GetPlayerMenu(playerid) == SelectSkin) 
	{
   		switch(row) 
		{
      		case 0: 
			{
      		    if(PI[playerid][pSex] == 1) 
				{
					PI[playerid][pChangeSkin]++;
		 			if(PI[playerid][pChangeSkin] >= 5) PI[playerid][pChangeSkin] = 0;
					SetPlayerSkinAC(playerid, PedMale[PI[playerid][pChangeSkin]]);
		 		}
		  		else 
				{
					PI[playerid][pChangeSkin]++;
		 			if(PI[playerid][pChangeSkin] >= 6) PI[playerid][pChangeSkin] = 0;
					SetPlayerSkinAC(playerid, PedFeMale[PI[playerid][pChangeSkin]]);
		 		}
                ShowMenuForPlayer(SelectSkin, playerid);
            }
            case 1: 
			{
            	if(PI[playerid][pSex] == 1) 
				{
		  			PI[playerid][pChangeSkin]--;
		  			if(PI[playerid][pChangeSkin] <= -1) PI[playerid][pChangeSkin] = 4;
		            SetPlayerSkinAC(playerid, PedMale[PI[playerid][pChangeSkin]]);
				}
				else 
				{
		    		PI[playerid][pChangeSkin]--;
			     	if(PI[playerid][pChangeSkin] <= -1) PI[playerid][pChangeSkin] = 5;
			 		SetPlayerSkinAC(playerid, PedFeMale[PI[playerid][pChangeSkin]]);
		      	}
                ShowMenuForPlayer(SelectSkin, playerid);
            }
        }
    }
	return 1;
}
public OnPlayerExitedMenu(playerid) return 1;
public OnPlayerInteriorChange(playerid, newinteriorid, oldinteriorid) return 1;
public OnPlayerKeyStateChange(playerid, newkeys, oldkeys) 
{
	mine_OnPlayerKeyStateChange(playerid, newkeys, oldkeys);
	nosov_OnPlayerKeyStateChange(playerid, newkeys);
	kv_OnPlayerKeyStateChange(playerid, newkeys, oldkeys);
	nc_OnPlayerKeyStateChange(playerid, newkeys, oldkeys);

	if(PRESSED(KEY_WALK)) 
	{
		if(IsPlayerInAnyVehicle(playerid) && GetPlayerState(playerid) == PLAYER_STATE_DRIVER) 
		{
		   new veh = GetPlayerVehicleID(playerid);
		   new engine1,lights1,alarm1,doors_text1,bonnet1,boot1,objective1;
		   GetVehicleParamsEx(veh,engine1,lights1,alarm1,doors_text1,bonnet1,boot1,objective1);

		   if(CarInfo[veh][cLamp] == 0) 
		   {
		      SetVehicleParamsEx(veh,engine1,VEHICLE_PARAMS_ON,alarm1,doors_text1,bonnet1,boot1,objective1);
		      CarInfo[veh][cLamp] = 1;
		   }
		   else {
		      SetVehicleParamsEx(veh,engine1,VEHICLE_PARAMS_OFF,alarm1,doors_text1,bonnet1,boot1,objective1);
		      CarInfo[veh][cLamp] = 0;
		   }
		}
	    for(new h = 0; h < TotalHouses; h++)
		{
	    	if(PlayerToPoint(1.5, playerid, HOUSE_DATA[h][data_EXITX], HOUSE_DATA[h][data_EXITY], HOUSE_DATA[h][data_EXITZ]) && GetPlayerVirtualWorld(playerid) == HOUSE_DATA[h][data_ID]) 
			{
	            ShowPlayerDialog(playerid, dialog_EXIT_HOUSE, DIALOG_STYLE_MSGBOX, !"{ee3366}Дом", "{FFFFFF}Вы желаете покинуть дом?", "Выйти", "Отмена");
	            return 1;
	        }
		}
	}
 	if ((newkeys & KEY_AIM) && (newkeys & KEY_WALK))
	{
		if(GetPlayerTargetPlayer(playerid) != INVALID_PLAYER_ID)
		{
	  		ShowTargetMenu(playerid);
		}
	}
	if(newkeys == 1 || PRESSED(1)) {
        new Weap[2];
        GetPlayerWeaponData(playerid, 4, Weap[0], Weap[1]);
        SetPlayerArmedWeapon(playerid, Weap[0]);
    }
    if(IsAtBankomat(playerid,0.5)) 
	{
		if(GetPVarInt(playerid,"kdpickupbank") > gettime()) return 1;
		SetPVarInt(playerid,"kdpickupbank",gettime() + 3);
		ShowPlayerDialogf(playerid, 8999, DIALOG_STYLE_LIST, !"{ee3366}Банкомат", !"Далее", !"Закрыть", "1. Банковская карта {FFFF99}(№ %d)\n2. Оплата имущества\n3. Медицинские услуги", PI[playerid][pID]);
	}
    if(!pCBugging[playerid] && GetPlayerState(playerid) == PLAYER_STATE_ONFOOT || !pCBugging[playerid] && GetPlayerState(playerid) == 1) {
		if(PRESSED(KEY_FIRE)) {
			switch(GetPlayerWeapon(playerid)) {
				case WEAPON_DEAGLE, WEAPON_SHOTGUN, WEAPON_SNIPER: {
					ptsLastFiredWeapon[playerid] = gettime();
				}
			}
		}
		else if(PRESSED(KEY_CROUCH)) 
		{
			if((gettime() - ptsLastFiredWeapon[playerid]) < 1) 
			{
				TogglePlayerControllable(playerid, false);
				pCBugging[playerid] = true;
				KillTimer(ptmCBugFreezeOver[playerid]);  
				ptmCBugFreezeOver[playerid] = SetTimerEx("CBugFreezeOver", 950, false, "i", playerid);
			}
		}
	}
    if(PRESSED(16)) 
	{
	    if(GetPVarInt(playerid, "UseAnim") == 1) 
		{
		    ClearAnim(playerid);
		    DeletePVar(playerid, "UseAnim");
		    return 1;
		}
	}
    if (((newkeys & KEY_WALK && newkeys & KEY_UP) || (newkeys & KEY_WALK && newkeys & KEY_DOWN) || (newkeys & KEY_WALK && newkeys & KEY_LEFT) || (newkeys & KEY_WALK && newkeys & KEY_RIGHT))
    || ((oldkeys & KEY_WALK && newkeys & KEY_UP) || (oldkeys & KEY_WALK && newkeys & KEY_DOWN) || (oldkeys & KEY_WALK && newkeys & KEY_LEFT) || (oldkeys & KEY_WALK && newkeys & KEY_RIGHT))
    || ((newkeys & KEY_WALK && oldkeys & KEY_UP) || (newkeys & KEY_WALK && oldkeys & KEY_DOWN) || (newkeys & KEY_WALK && oldkeys & KEY_LEFT) || (newkeys & KEY_WALK && oldkeys & KEY_RIGHT))
    && GetPlayerState(playerid) == PLAYER_STATE_ONFOOT) 
	{
    	PI[playerid][data_WALK_TIMER] = SetTimerEx("WalkAnim",200,0,"d",playerid);
	}
	if(newkeys == 262144) 
	{
        if(PlayerToPoint(3.0, playerid, 2132.8718,1790.2057,12.0000) || PlayerToPoint(3.0, playerid, 1994.8816,976.9962,15.4012) || PlayerToPoint(3.0, playerid, 1789.6417,2493.6338,15.9816)) return ShowPlayerDialog(playerid, 3898, DIALOG_STYLE_LIST, "{ee3366}Торговец дед", "1. Кока Кола\n2. Шоколадка сникерс\n3. Энергетик '"ENERGO"'", "Выбрать", "Закрыть");
	}
	if(newkeys == 1024 && !IsPlayerInAnyVehicle(playerid) || newkeys == 2 && IsPlayerInAnyVehicle(playerid))
	{
		if(PI[playerid][pMember] == 4)
		{
			if(IsPlayerInRangeOfPoint( playerid, 3.0, 2122.7444,1794.2056,12.0534)) ///нажатие
			{
				if(GateMove == 0)
				{
					MoveObject(Gate, 2123.1992, 1804.0350, 12.5628, 2.5); ///открытие
					GateMove = 1;
				}
				else if(GateMove == 1)
				{
					MoveObject(Gate, 2123.1838, 1798.8187, 12.5628, 2.5,  0.00, 0.00, 90.00); ///закрытие
					GateMove = 0;
					BolkaVorotaTimer = SetTimer("BolkaVorotaClose", 7000, 0);
				}
			}
		}
	}
	if(newkeys == 1024 && !IsPlayerInAnyVehicle(playerid) || newkeys == 2 && IsPlayerInAnyVehicle(playerid))
	{
		if(PI[playerid][pMember] == 1)
		{
			if(IsPlayerInRangeOfPoint( playerid, 3.0, 1877.44, -2229.77, 11.25))///радиус нажатия
			{
				if(GatePravoMove == 0)
				{
					MoveObject(GatePravo, 1880.8799, -2228.7432, 11.9105, 2.5);//открытие
					GateMove = 1;
				}
				else if(GatePravoMove == 1)
				{
					MoveObject(GatePravo, 1872.5520, -2228.8486, 11.9105, 2.5,  0.00, 0.00, 0.00);///закрытие
					GatePravoMove = 0;
					PravoVorotaTimer = SetTimer("PravoVorotaClose", 7000, 0);
				}
			}
		}
	}
	if(newkeys == 2 && IsPlayerInAnyVehicle(playerid)) 
	{
		new carid = GetPlayerVehicleID(playerid);
		if(PI[playerid][pMember] == 1) 
		{
			if(IsPlayerInRangeOfPoint(playerid, 7.0, 1789.5536,2078.9685,15.8538)) 
			{
				if(carid == gov_car[0] || carid == gov_car[1] || carid == gov_car[2] || carid == gov_car[3] || carid == gov_car[4] ||
				carid == gov_car[5] || carid == gov_car[6] || carid == gov_car[7]) 
				{
					new vehicle = GetPlayerVehicleID(playerid);
	           		SetVehiclePos(vehicle, -164.6677,651.2881,-50.1762);
		 	        LinkVehicleToInterior(vehicle, 1);
		 	        SetVehicleVirtualWorld(vehicle, 1);
		 	        SetVehicleZAngle(vehicle, 181.0058);
		 	        SetPlayerPosAC(playerid, -164.6677,651.2881,-50.1762);
	         		SetPlayerVirtualWorld(playerid, 1);
		    		SetPlayerInterior(playerid, 1);
		    		PutPlayerInVehicle(playerid, vehicle, 0);
				}
	 	    }
	 	    if(IsPlayerInRangeOfPoint(playerid, 7.0, -165.3361,625.0273,-50.1706)) 
			{
				new vehicle = GetPlayerVehicleID(playerid);
				SetVehiclePos(vehicle, 1870.2343,-2214.6035,10.7737);
				LinkVehicleToInterior(vehicle, 0);
				SetVehicleVirtualWorld(vehicle, 0);
				SetVehicleZAngle(vehicle, 179.7689);
				SetPlayerPosAC(playerid, 1870.2343,-2214.6035,10.7737);
				SetPlayerVirtualWorld(playerid, 0);
				SetPlayerInterior(playerid, 0);
				PutPlayerInVehicle(playerid, vehicle, 0);
	 	    }
	 	}
	 	if(PI[playerid][pMember] == 2) 
		{
			if(IsPlayerInRangeOfPoint(playerid, 7.0, -2754.5576,351.0330,10.5823)) 
			{
		 	    if(carid == army_car[0] || carid == army_car[1] ||
				carid == army_car[2] || carid == army_car[3] || carid == army_car[4] || carid == army_car[5] ||
				carid == army_car[6] || carid == army_car[7]) 
				{
					new vehicle = GetPlayerVehicleID(playerid);
	           		SetVehiclePos(vehicle, -164.6677,651.2881,-50.1762+2);
		 	        SetVehicleVirtualWorld(vehicle, 4);
		 	        LinkVehicleToInterior(vehicle, 1);
		 	        SetVehicleZAngle(vehicle, 181.0058);
	           		SetPlayerPosAC(playerid, -164.6677,651.2881,-50.1762+2);
	         		SetPlayerVirtualWorld(playerid, 4);
		    		SetPlayerInterior(playerid, 1);
		    		PutPlayerInVehicle(playerid, vehicle, 0);
	    		}
	 	    }
	 	    if(IsPlayerInRangeOfPoint(playerid, 7.0, -165.3361,625.0273,-50.1706))
			{
				new vehicle = GetPlayerVehicleID(playerid);
				SetVehiclePos(vehicle, -2748.1858,342.4038,11.5815);
				LinkVehicleToInterior(vehicle, 0);
				SetVehicleVirtualWorld(vehicle, 0);
				SetVehicleZAngle(vehicle, 272.7158);
				SetPlayerPosAC(playerid, 1-2748.1858,342.4038,11.5815);
				SetPlayerVirtualWorld(playerid, 0);
				SetPlayerInterior(playerid, 0);
				PutPlayerInVehicle(playerid, vehicle, 0);
	 	    }
	 	}
	 	if(PI[playerid][pMember] == 3) 
		{
	 	    if(IsPlayerInRangeOfPoint(playerid, 7.0, -264.6449,-1565.3790,41.1352)) 
			{
				if(carid == police_car[0] || carid == police_car[1] ||carid == police_car[2] ||
				carid == police_car[3] || carid == police_car[4] || carid == police_car[5] || carid == police_car[6] ||
				carid == police_car[7]) 
				{
					new vehicle = GetPlayerVehicleID(playerid);
		 	        SetVehiclePos(vehicle, -164.6677,651.2881,-50.1762);
		 	        LinkVehicleToInterior(vehicle, 1);
		 	        SetVehicleVirtualWorld(vehicle, 2);
		 	        SetVehicleZAngle(vehicle, 181.0058);
		 	        SetPlayerPosAC(playerid, -164.6677,651.2881,-50.1762);
	         		SetPlayerVirtualWorld(playerid, 2);
		    		SetPlayerInterior(playerid, 1);
		    		PutPlayerInVehicle(playerid, vehicle, 0);
				}
	 	    }
	 	    if(IsPlayerInRangeOfPoint(playerid, 7.0, -165.3361,625.0273,-50.1706)) 
			{
				new vehicle = GetPlayerVehicleID(playerid);
	 	        SetVehiclePos(vehicle, 2436.7822,-1794.5037,21.9369);
	 	        LinkVehicleToInterior(vehicle, 0);
	 	        SetVehicleVirtualWorld(vehicle, 0);
	 	        SetVehicleZAngle(vehicle, 90.7041);
	 	        SetPlayerPosAC(playerid, 2436.7822,-1794.5037,21.9369);
         		SetPlayerVirtualWorld(playerid, 0);
	    		SetPlayerInterior(playerid, 0);
	    		PutPlayerInVehicle(playerid, vehicle, 0);
	 	    }
	 	}
	 	if(PI[playerid][pMember] == 4) 
		{
	 	    if(IsPlayerInRangeOfPoint(playerid, 7.0, 2148.02,1808.58,12.22)) 
			{
				if(carid == hospital_car[0] || carid == hospital_car[1] || carid == hospital_car[2] || carid == hospital_car[3] ||
				carid == hospital_car[4] || carid == hospital_car[5] || carid == hospital_car[6] || carid == hospital_car[7])
				{
					new vehicle = GetPlayerVehicleID(playerid);
		 	        SetVehiclePos(vehicle, -164.6677,651.2881,-50.1762);
		 	        LinkVehicleToInterior(vehicle, 1);
		 	        SetVehicleVirtualWorld(vehicle, 3);
		 	        SetVehicleZAngle(vehicle, 181.0058);
		 	        SetPlayerPosAC(playerid, -164.6677,651.2881,-50.1762);
	         		SetPlayerVirtualWorld(playerid, 3);
		    		SetPlayerInterior(playerid, 1);
		    		PutPlayerInVehicle(playerid, vehicle, 0);
				}
	 	    }
	 	    if(IsPlayerInRangeOfPoint(playerid, 7.0, -165.3361,625.0273,-50.1706)) 
			{
				new vehicle = GetPlayerVehicleID(playerid);
	 	        SetVehiclePos(vehicle, 2147.23,1804.75,12.29);
	 	        LinkVehicleToInterior(vehicle, 0);
	 	        SetVehicleVirtualWorld(vehicle, 0);
	 	        SetVehicleZAngle(vehicle, 176.13);
	 	        SetPlayerPosAC(playerid, 2147.23,1804.75,12.29);
         		SetPlayerVirtualWorld(playerid, 0);
	    		SetPlayerInterior(playerid, 0);
	    		PutPlayerInVehicle(playerid, vehicle, 0);
	 	    }
	 	}
	 	if(PI[playerid][pMember] == 5)
	 	{
	 	    if(IsPlayerInRangeOfPoint(playerid, 7.0, 2332.3850,1780.7386,0.7965))
	 	    {
				if(carid == skinhead_car[0] || carid == skinhead_car[1] || carid == skinhead_car[2] || carid == skinhead_car[3]
				|| carid == skinhead_car[4] || carid == skinhead_car[5] || carid == skinhead_car[6] || carid == skinhead_car[7])
				{
					new vehicle = GetPlayerVehicleID(playerid);
		 	        SetVehiclePos(vehicle, 318.8180, 1481.3219, 802.5327);
		 	        LinkVehicleToInterior(vehicle, 1);
		 	        SetVehicleVirtualWorld(vehicle, 6);
		 	        SetVehicleZAngle(vehicle, 269.1992);

		 	        SetPlayerPosAC(playerid, 318.8180, 1481.3219, 806.5327);
	         		SetPlayerVirtualWorld(playerid, 6);
		    		SetPlayerInterior(playerid, 1);

		    		PutPlayerInVehicle(playerid, vehicle, 0);
				}
	 	    }
	 	    if(IsPlayerInRangeOfPoint(playerid, 7.0, -165.3361,625.0273,-50.1706))
	 	    {
					new vehicle = GetPlayerVehicleID(playerid);
		 	        SetVehiclePos(vehicle, 1448.9690,2357.9080,12.6469);
		 	        LinkVehicleToInterior(vehicle, 0);
		 	        SetVehicleVirtualWorld(vehicle, 0);
		 	        SetVehicleZAngle(vehicle, 179.4722);

		 	        SetPlayerPosAC(playerid, 1448.9690,2357.9080,12.6469);
	         		SetPlayerVirtualWorld(playerid, 0);
		    		SetPlayerInterior(playerid, 0);

		    		PutPlayerInVehicle(playerid, vehicle, 0);
	 	    }
	 	}
	 	if(PI[playerid][pMember] == 6)
	 	{
	 	    if(IsPlayerInRangeOfPoint(playerid, 7.0, 1369.5155,1715.0671,3.6247))
	 	    {
		 	    if(carid == gopota_car[0] || carid == gopota_car[1] || carid == gopota_car[2] || carid == gopota_car[3]
				|| carid == gopota_car[4] || carid == gopota_car[5] || carid == gopota_car[6] || carid == gopota_car[7])
				{
					new vehicle = GetPlayerVehicleID(playerid);
		 	        SetVehiclePos(vehicle, 318.8180, 1481.3219, 802.5327);
		 	        LinkVehicleToInterior(vehicle, 1);
		 	        SetVehicleVirtualWorld(vehicle, 5);
		 	        SetVehicleZAngle(vehicle, 269.1992);

		 	        SetPlayerPosAC(playerid, 318.8180, 1481.3219, 806.5327);
	         		SetPlayerVirtualWorld(playerid, 5);
		    		SetPlayerInterior(playerid, 1);

		    		PutPlayerInVehicle(playerid, vehicle, 0);
	    		}
	 	    }
	 	    if(IsPlayerInRangeOfPoint(playerid, 7.0, -165.3361,625.0273,-50.1706))
	 	    {
					new vehicle = GetPlayerVehicleID(playerid);
		 	        SetVehiclePos(vehicle,2238.1350,-2589.9907,21.9561);
		 	        LinkVehicleToInterior(vehicle, 0);
		 	        SetVehicleVirtualWorld(vehicle, 0);
		 	        SetVehicleZAngle(vehicle, 87.3234);

		 	        SetPlayerPosAC(playerid, 2238.1350,-2589.9907,21.9561);
	         		SetPlayerVirtualWorld(playerid, 0);
		    		SetPlayerInterior(playerid, 0);

		    		PutPlayerInVehicle(playerid, vehicle, 0);
	 	    }
	 	}
	 	if(PI[playerid][pMember] == 7)
	 	{
	 	    if(IsPlayerInRangeOfPoint(playerid, 7.0, -562.5096,-1392.1708,41.1858))
	 	    {
		 	    if(carid == kavkaz_car[0] || carid == kavkaz_car[1] || carid == kavkaz_car[2] || carid == kavkaz_car[3]
				|| carid == kavkaz_car[4] || carid == kavkaz_car[5] || carid == kavkaz_car[6] || carid == kavkaz_car[7])
				{
					new vehicle = GetPlayerVehicleID(playerid);
		 	        SetVehiclePos(vehicle, 318.8180, 1481.3219, 802.5327);
		 	        LinkVehicleToInterior(vehicle, 1);
		 	        SetVehicleVirtualWorld(vehicle, 7);
		 	        SetVehicleZAngle(vehicle, 269.1992);

		 	        SetPlayerPosAC(playerid, 318.8180, 1481.3219, 806.5327);
	         		SetPlayerVirtualWorld(playerid, 7);
		    		SetPlayerInterior(playerid, 1);

		    		PutPlayerInVehicle(playerid, vehicle, 0);
	    		}
	 	    }
	 	    if(IsPlayerInRangeOfPoint(playerid, 7.0, -165.3361,625.0273,-50.1706))
	 	    {
					new vehicle = GetPlayerVehicleID(playerid);
		 	        SetVehiclePos(vehicle, -313.0711,-1082.5269,40.9257);
		 	        LinkVehicleToInterior(vehicle, 0);
		 	        SetVehicleVirtualWorld(vehicle, 0);
		 	        SetVehicleZAngle(vehicle, 59.0459);

		 	        SetPlayerPosAC(playerid, -313.0711,-1082.5269,40.9257);
	         		SetPlayerVirtualWorld(playerid, 0);
		    		SetPlayerInterior(playerid, 0);

		    		PutPlayerInVehicle(playerid, vehicle, 0);
	 	    }
	 	}
	 	if(PI[playerid][pMember] == 2) 
		{
	 	    if(IsPlayerInRangeOfPoint(playerid, 20.0, -2663.1333, 267.0166, 10.9281)) 
			{
	 	        MoveObject(ArmyGateOne, -2655.70, 266.60, 12.32, 1.00, 0.00, 0.00);
	 	        MoveObject(ArmyGateTwo, -2670.42, 266.60, 12.32, 1.00, 0.00, 0.00);
	 	        ArmyGateOneTimer = SetTimer("ArmyGateClose", 10000, 0);
			}
			if(IsPlayerInRangeOfPoint(playerid, 20.0, -2764.9651,404.3636,10.9195)) 
			{
	 	        MoveObject(ArmyGateWatherTwo, -2764.76, 411.59, 12.35, 1.00, 0.00, -90.00);
	 	        MoveObject(ArmyGateWatherOne, -2764.79, 396.81, 12.35, 1.00, 0.00, -90.00);
	 	        ArmyGateOneTimerWather = SetTimer("ArmyGateCloseWather", 10000, 0);
			}
	 	}
		if(PI[playerid][pMember] == 5)
		{
		    if(IsPlayerInRangeOfPoint(playerid, 15.0, 1461.0179, 2340.8840, 12.5690)) 
			{
		        MoveObject(SkinPost,1461.0179, 2340.8840, 12.5690, 1, 0.00, 0.00, 90.00);
		        SkinPostTimer = SetTimer ("SkinPostClose", 6500, 0);
			}
		}
		if(PI[playerid][pMember] == 6)
		{
		    if(IsPlayerInRangeOfPoint(playerid, 15.0, 2217.1287,-2578.8123,21.9700)) 
			{
		        MoveObject(GopotaPost, 2221.2864, -2578.8955, 21.5631, 1, 0.00, 0.00, 0.00);
		        GopotaPostTimer = SetTimer ("GopotaPostClose", 6500, 0);
			}
		}
		if(PI[playerid][pMember] == 7)
		{
		    if(IsPlayerInRangeOfPoint(playerid, 15.0, -336.7794, -1084.9222, 40.9260)) 
			{
		        MoveObject(KavkazPost, -336.7794, -1084.9222, 40.9260, 1, 0.00, 0.00, -31.43);
		        KavkazPostTimer = SetTimer ("KavkazPostClose", 6500, 0);
			}
		}
	}
	if((newkeys & KEY_FIRE) || ( (newkeys & KEY_AIM) && (oldkeys & KEY_AIM) && (newkeys & KEY_SECONDARY_ATTACK))) 
	{
	    if(IsPlayerInRangeOfPoint(playerid, 100.0, 2085.7090,1819.6904,12.1208) && GetPlayerVirtualWorld(playerid) == 0 || // БЦРБ
		PlayerToKvadrat(playerid, 1784, 2060.5, 1878, 2132.5) && GetPlayerVirtualWorld(playerid) == 0 || // Правительство
		PlayerToKvadrat(playerid, 1765, 2476.5, 1846, 2536.5) && GetPlayerVirtualWorld(playerid) == 0 || // рудник
		PlayerToKvadrat(playerid, 601, -107.4, 728, 89.7) && GetPlayerVirtualWorld(playerid) == 0 || // казино
		PlayerToKvadrat(playerid, 1771.5, 1418.1666259765625, 1871.5, 1518.1666259765625) && GetPlayerVirtualWorld(playerid) == 0) // автошкола
		{
		    if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER) 
			{
		        if(PI[playerid][pMember] != 3) 
				{
	   				TogglePlayerControllable(playerid, false);
	 		 		SetTimerEx("UnfreezePlayer", 1300, false, "i", playerid);
					ClearAnimations(playerid);
				}
			}
		}
		if(GetPlayerInterior(playerid) != 0) 
		{
  			if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER) 
			{
      			if(PI[playerid][pMember] != 3) 
				{
					TogglePlayerControllable(playerid, false);
			 		SetTimerEx("UnfreezePlayer", 1300, false, "i", playerid);
					ClearAnimations(playerid);
				}
			}
		}
 	}
	if(IsPlayerInAnyVehicle(playerid) && GetPlayerState(playerid) == PLAYER_STATE_DRIVER) 
	{
        new carid = GetPlayerVehicleID(playerid);
        if(!IsAVelik(carid)) 
		{
			if(PRESSED(4)) 
			{
				if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER) 
				{
					switch(CarInfo[carid][cLamp]) 
					{
						case 0: {
							GetVehicleParamsEx(carid,engine,lights_text,alarm,doors_text,bonnet,boot,objective);
							SetVehicleParamsEx(carid,engine,true,alarm,doors_text,bonnet,boot,objective);
							CarInfo[carid][cLamp] = 1;
						}
						case 1: 
						{
							GetVehicleParamsEx(carid,engine,lights_text,alarm,doors_text,bonnet,boot,objective);
							SetVehicleParamsEx(carid,engine,false,alarm,doors_text,bonnet,boot,objective);
							CarInfo[carid][cLamp] = 0;
						}
					}
				}
				return 1;
			}
		}
	}
	if(IsPlayerInAnyVehicle(playerid) && GetPlayerState(playerid) == PLAYER_STATE_DRIVER) 
	{
	    if(PlayerToPoint(10.0, playerid,  37.8415,305.3781,12.0264))
	    {
			if(!IsPlayerCops(playerid)) return SCM(playerid, COLOR_GREY, !"Данное действие Вам недоступно");
			if(police_barrier_status[0] == GATES_CLOSED) 
			{
			    PlayerPlaySound(playerid, 41603, 0.0, 0.0, 0.0);
				MoveObject(police_barrier[0], 39.51, 308.39, 11.85+0.0004, 0.0004, 0.00, 0.00, 67.30);
	            police_barrier_status[0] = GATES_OPEN;
            }
            else 
			{
                PlayerPlaySound(playerid, 41603, 0.0, 0.0, 0.0);
	            police_barrier_status[0] = GATES_CLOSED;
	            MoveObject(police_barrier[0], 39.51, 308.39, 11.85-0.0004, 0.0004, 0.00, 270.00, 67.30);
            }
			return 1;
		}
		else if(PlayerToPoint(10.0, playerid,  214.54, 1503.96, 11.75)) 
		{
			if(!IsPlayerCops(playerid)) return SCM(playerid, COLOR_GREY, !"Данное действие Вам недоступно");
			if(police_barrier_status[1] == GATES_CLOSED) 
			{
			    PlayerPlaySound(playerid, 41603, 0.0, 0.0, 0.0);
				MoveObject(police_barrier[1], 214.54, 1503.96, 11.75+0.0004, 0.0004, 0.00, 0.00, 78.00);
	            police_barrier_status[1] = GATES_OPEN;
            }
            else 
			{
                PlayerPlaySound(playerid, 41603, 0.0, 0.0, 0.0);
	            police_barrier_status[1] = GATES_CLOSED;
	            MoveObject(police_barrier[1], 214.54, 1503.96, 11.75-0.0004, 0.0004, 0.00, 270.00, 78.00);
            }
			return 1;
		}
	}
	return 1;
}
callback: VchSkladGateClose() 
{
    MoveObject(VchSkladGate, 1568.80, 1809.53, 16.25, 2.5, 0.0, 0.0, 90.0);
    KillTimer(VchSkladGateTimer);
    return 1;
}
public OnRconLoginAttempt(ip[], password[], success) 
{
    if(success || !success) 
	{
    	new YouIP[16];
     	for(new i = 0; i <= MAX_PLAYERS; i++) 
		{
       		if(IsPlayerConnected(i)) 
			{
     			GetPlayerIp(i, YouIP, sizeof(YouIP));
     			if(!strcmp(ip, YouIP, true)) 
				{
                   printf("[INFO] %s attemp is RCON",ip);
				   SendAdminsMessagef(COLOR_GREY, "<Warning> Игрок %s[%d] попытался войти в RCON", getName(i), i);
                   return 1;
               }
           }
       }
	}
	return 1;
}
callback: NoRoof(playerid) 
{
    new carid = GetPlayerSurfingVehicleID(playerid);
    if(carid != INVALID_VEHICLE_ID ) 
	{
        new Float:speed = GetVehicleSpeed(carid);
        new cm=GetVehicleModel(carid);
        switch(cm) 
		{
            case 430,446,452,453,454,472,473,484,493,595, 548:{return 1;}
            default:{}
        }
        if(speed > 5) 
		{
            new Float:slx, Float:sly, Float:slz;
            GetPlayerPos(playerid, slx, sly, slz);
            SetPlayerPos(playerid, slx+2.5, sly+2.5, slz+0.5);
            ApplyAnimation(playerid, "ped", "BIKE_fallR", 4.0, 0, 1, 0, 0, 0,0);
            SetTimerEx("anim2", 1100, 0, "d", playerid);
        }
    }
    return 1;
}
callback: anim2(playerid) return ApplyAnimation(playerid, "ped", "getup", 4.0, 0, 1, 0, 0, 0,0);
public OnPlayerUpdate(playerid) 
{

	nc_OnPlayerUpdate(playerid);


    SetPlayerColor(playerid, (PI[playerid][pMaskWorn] != 0) ? 0x33333300 : PLAYER_COLOR_TEAM[PI[playerid][pMember]]);

    if (PlayerToPoint(4.0, playerid, 1469.9095,2050.7461,12.5316) && GetPVarInt(playerid, "HintHutton") == 0)
    {
        SetPVarInt(playerid, "HintHutton", 1);
        SendPlayerHelpKeyNotify(playerid, 1, "ALT", "Нажмите чтобы поговорить с Василием!", 5);
    }
    else if (!PlayerToPoint(4.0, playerid, 1469.9095,2050.7461,12.5316) && GetPVarInt(playerid, "HintHutton") == 1)
    {
        cef_emit_event(playerid, "hide-button");
        SetPVarInt(playerid, "HintHutton", 0);
    }

    if (GetPlayerInterior(playerid) != 0) 
    {
        SetPlayerWeather(playerid, 10);
        SetPlayerTime(playerid, 12, 0);
    }
    else 
    {
        new hour, minute, second;
        gettime(hour, minute, second);
        SetPlayerWeather(playerid, WeatherServer);
        SetPlayerTime(playerid, hour, 0);
    }
	NoRoof(playerid);
	if(pPickupID[playerid]) 
	{
        new pickupid = pPickupID[playerid];
        if(!IsValidDynamicPickup(pickupid)) pPickupID[playerid] = 0;
        else 
		{
            new Float:pos_x, Float:pos_y, Float:pos_z;
            Streamer_GetFloatData(STREAMER_TYPE_PICKUP, pickupid, E_STREAMER_X, pos_x);
            Streamer_GetFloatData(STREAMER_TYPE_PICKUP, pickupid, E_STREAMER_Y, pos_y);
            Streamer_GetFloatData(STREAMER_TYPE_PICKUP, pickupid, E_STREAMER_Z, pos_z);
            if(!IsPlayerInRangeOfPoint(playerid, 2.0, pos_x, pos_y, pos_z)) pPickupID[playerid] = 0;
        }
    }
	if(PI[playerid][pAFK] > 60)
	{
		AutoKickCapture(playerid);
	}
    if(PI[playerid][pAFK] > 1) SetPlayerChatBubble(playerid, "", -1, 20.0, 1100);
    PI[playerid][pAFK] = -1;
	return 1;
}
callback: TazerEffect(damagedid)
{
    TogglePlayerControllable(damagedid, 1);
    ClearAnimations(damagedid);
    return 1;
}
public OnPlayerStreamOut(playerid, forplayerid) return 1;
public OnVehicleStreamIn(vehicleid, forplayerid) return 1;
public OnVehicleStreamOut(vehicleid, forplayerid) return 1; //tp
public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[]) 
{
	static inputtextsave[256];
	inputtextsave[0] = EOS;

	mysql_escape_string(inputtext, inputtextsave);

	for new i; i < strlen(inputtextsave); i++ do
	{
		switch inputtextsave[i] do
		{
			case 'A'..'Z', 'a'..'z', 'А'..'Я', 'а'..'я', '0'..'9', ' ', '>', '<', '(', ')', '/', '+', '-','_', '?', '!', '.', ',', '@': continue;
			default: inputtextsave[i] = ' ';
		}
	}
	
	for new i; i < strlen(inputtextsave); i ++ do
	{
		if inputtextsave[i] == '%' *then inputtextsave[i] = '#';
		else if inputtextsave[i] == '{' && inputtextsave[i+7] == '}' *then strdel(inputtextsave, i, i+8);
	}
	while(strfind(inputtext,"~k",true) != -1) // фикс краша игроков через 	 (GXT CODE)
	{
		strdel(inputtext, strfind(inputtext, "~k", true), strfind(inputtext,"~k", true)+2);
	}

	mine_OnDialogResponse(playerid, dialogid, response);
	admins_OnDialogResponse(playerid, dialogid, response, listitem); 
	qeust_OnDialogResponse(playerid, dialogid, response, listitem);
	business_OnDialogResponse(playerid, dialogid, response, listitem, inputtext);
	bl_OnDialogResponse(playerid, dialogid, response, listitem, inputtext);
	shop_OnDialogResponse(playerid, dialogid, response, listitem, inputtext);
	capture_OnDialogResponse(playerid, dialogid, response, listitem);
	bank_OnDialogResponse(playerid, dialogid, response, listitem, inputtext);
	kv_OnDialogResponse(playerid, dialogid, response, listitem);
	gm_OnDialogResponse(playerid, dialogid, response, listitem);
	org_OnDialogResponse(playerid, dialogid, response);

	switch(dialogid) 
	{
	    case dialog_REGISTER: 
		{
	    	if(!response)  
			{
				PlayerRegistration(playerid);
			}
			if(response) 
			{
			    if(strlen(inputtextsave) == 0) 
				{
					PlayerRegistration(playerid);
				}
				if(strlen(inputtextsave) < 6 || strlen(inputtextsave) > 30) 
				{
					 SCM(playerid, 0xFF6347FF, !"[Внимание]: {FFFFFF}Длина пароля должна быть от 6 до 30 символов"); 
					 PlayerRegistration(playerid);
				}
        		for(new i = strlen(inputtextsave); i != 0; --i)
				switch(inputtextsave[i]) 
				{
					case 'А'..'Я', 'а'..'я', ',', '`', '=': return SCM(playerid, 0xFF6347FF, !"[Внимание]: {FFFFFF}Разрешено использовать только латинские буквы и цифры"),PlayerRegistration(playerid);
				}
				GetPlayerIp(playerid,PI[playerid][pRegIP],32);
				strmid(PI[playerid][pPassword], inputtextsave, 0, strlen(inputtextsave), 30);

				ShowPlayerDialog(playerid, dialog_EMAIL, DIALOG_STYLE_INPUT, "{ee3366}Почта", "\
				{FFFFFF}Введите адрес Вашей {ee3366}электронной почты{FFFFFF}\n\
				Он нужен для восстановления доступа к аккаунту\n\
				В случае его взлома или если забудете пароль\n\n\
				{ee3366}Убедитесь в правильности ввода Вашей почты", "Далее", "");
			}
		}
		case dialog_EMAIL: 
		{
            if(response || !response) 
			{
                if(!strlen(inputtext)) return ShowPlayerDialog(playerid, dialog_EMAIL, DIALOG_STYLE_INPUT, "{ee3366}Почта", "\
																											{FFFFFF}Введите адрес Вашей {ee3366}электронной почты{FFFFFF}\n\
																											Он нужен для восстановления доступа к аккаунту\n\
																											В случае его взлома или если забудете пароль\n\n\
																											{ee3366}Убедитесь в правильности ввода Вашей почты", "Далее", "");
                if(strfind(inputtext, "@", true) == -1 || strfind(inputtext, "\n", true) != -1 || strfind(inputtext, ".", true) == -1) 
				{
	 				ShowPlayerDialog(playerid, dialog_EMAIL, DIALOG_STYLE_INPUT, "{ee3366}Почта", "\
																				  {FFFFFF}Введите адрес Вашей {ee3366}электронной почты{FFFFFF}\n\
																				  Он нужен для восстановления доступа к аккаунту\n\
																				  В случае его взлома или если забудете пароль\n\n\
				    															  {ee3366}Убедитесь в правильности ввода Вашей почты", "Далее", "");
                    return true;
                }
                strmid(PI[playerid][pEmail], inputtext, 0, strlen(inputtext), 50);
                ShowPlayerDialog(playerid, dialog_SEX, DIALOG_STYLE_MSGBOX, !"{ee3366}Выбор пола", "{FFFFFF}Выберете пол вашего персонажа", "Мужской", "Женский");
            }
        }
		case 398:
		{
			if(!response) return 1;
	        new carid = ShowCar[playerid][listitem];
			
			new Premium, Float: X, Float: Y, Float: Z, Cache: result, query[140];

			mf(mysql, query, sizeof query, "SELECT * FROM ownable WHERE ID='%d'", carid);
			result = mysql_query(mysql, query, true);

			if(cache_num_rows())
			{

				X = cache_get_field_content_float(0, "Pos_X", mysql);
				Y = cache_get_field_content_float(0, "Pos_Y", mysql);
				Z = cache_get_field_content_float(0, "Pos_Z", mysql);

				Premium = cache_get_field_content_int(0, "Premium", mysql);
			}
			cache_delete(result);

			if(Premium == 0) 
			{
				if(PI[playerid][pHouse] == INVALID_HOUSE_ID && PI[playerid][pFloat] == INVALID_KV_ID && AccessCar[playerid][listitem] == 1) 
					return SendClientMessage(playerid, COLOR_GREY, !"Доступ к машине ограничен, купите дом или квартиру чтобы загрузить это транспортное средство.");
			}

			SetPVarInt(playerid, "LoadCar", carid);

			if(PlayerToPoint(20.0, playerid, X, Y, Z)) 
			{
				ShowPlayerDialog(playerid, 400, DIALOG_STYLE_MSGBOX, !"{ee3366}Загрузка транспорта", "{FFFFFF}Вы находитесь рядом с парковкой Вашего транспорта.\n\n{FFFF99}Хотите загрузить его?", "Далее", "Назад");
			}
			else ShowPlayerDialog(playerid, 399, DIALOG_STYLE_MSGBOX, !"{ee3366}Отметить транспорт", "{FFFFFF}Вы находитесь слишком далеко от своего транспорта\n\n{FFFF99}Вы хотите его отметить на мини-карте?", "Далее", "Назад");
		}
		case 399:	
		{
	        if(!response) return DeletePVar(playerid, "LoadCar"), callcmd::cars(playerid);
	        if(response) 
			{
				new carid = GetPVarInt(playerid, "LoadCar");

				new Float: X, Float: Y, Float: Z, Cache: result, query[140];

				mf(mysql, query, sizeof query, "SELECT * FROM ownable WHERE ID='%d'", carid);
				result = mysql_query(mysql, query, true);

				if(cache_num_rows())
				{
					X = cache_get_field_content_float(0, "Pos_X", mysql);
					Y = cache_get_field_content_float(0, "Pos_Y", mysql);
					Z = cache_get_field_content_float(0, "Pos_Z", mysql);
				}
				cache_delete(result);

				SetPVarFloat(playerid, "gps_pos_x", X);
				SetPVarFloat(playerid, "gps_pos_y", Y);
				SetPVarFloat(playerid, "gps_pos_z", Z);

	        	DisablePlayerCheckpoint(playerid);
				SetPlayerCheckpoint(playerid, X, Y, Z+1,5.0);
				DeletePVar(playerid, "LoadCar");
			}
		}
		case 400:	
		{
	        if(!response) return DeletePVar(playerid, "LoadCar"), callcmd::cars(playerid);
	        if(response) 
			{
				if(PI[playerid][pLoadVehicleID] != INVALID_VEHICLE_ID) DestroyVehicle(PI[playerid][pLoadVehicleID]);

				new carid = GetPVarInt(playerid, "LoadCar");
				new Cache: result, query[140];

				mf(mysql, query, sizeof query, "SELECT * FROM ownable WHERE ID='%d'", carid);
				result = mysql_query(mysql, query, true);

				if(cache_num_rows())
				{

					PI[playerid][pLoadVehicleID] = CreateVehicle(\
																cache_get_field_content_int(0, "Model", mysql),
																cache_get_field_content_float(0, "Pos_X", mysql),  
																cache_get_field_content_float(0, "Pos_Y", mysql),  
																cache_get_field_content_float(0, "Pos_Z", mysql)+1, 
																cache_get_field_content_float(0, "Pos_A", mysql), 
																cache_get_field_content_int(0, "Color_1", mysql), 
																cache_get_field_content_int(0, "Color_2", mysql), 60000);

					CarInfo[PI[playerid][pLoadVehicleID]][cID] = cache_get_field_content_int(0, "ID", mysql);
					CarInfo[PI[playerid][pLoadVehicleID]][cModel] = cache_get_field_content_int(0, "Model", mysql);
					CarInfo[PI[playerid][pLoadVehicleID]][cPos_X] = cache_get_field_content_float(0, "Pos_X", mysql);
					CarInfo[PI[playerid][pLoadVehicleID]][cPos_Y] = cache_get_field_content_float(0, "Pos_Y", mysql);
					CarInfo[PI[playerid][pLoadVehicleID]][cPos_Z] = cache_get_field_content_float(0, "Pos_Z", mysql);
					CarInfo[PI[playerid][pLoadVehicleID]][cPos_A] = cache_get_field_content_float(0, "Pos_A", mysql);
					CarInfo[PI[playerid][pLoadVehicleID]][cColor_1] = cache_get_field_content_int(0, "Color_1", mysql);
					CarInfo[PI[playerid][pLoadVehicleID]][cColor_2] = cache_get_field_content_int(0, "Color_2", mysql);
					cache_get_field_content(0, "Owner", CarInfo[PI[playerid][pLoadVehicleID]][cOwner], mysql);
					CarInfo[PI[playerid][pLoadVehicleID]][cLock] = cache_get_field_content_int(0, "Lock", mysql);
					CarInfo[PI[playerid][pLoadVehicleID]][cCost] = cache_get_field_content_int(0, "Cost", mysql);
					CarInfo[PI[playerid][pLoadVehicleID]][cNoPark] = cache_get_field_content_int(0, "NoPark", mysql);
					CarInfo[PI[playerid][pLoadVehicleID]][cFuel] = cache_get_field_content_int(0, "Fuel", mysql);
					CarInfo[PI[playerid][pLoadVehicleID]][cPremium] = cache_get_field_content_int(0, "Premium", mysql);
					CarInfo[PI[playerid][pLoadVehicleID]][cTemp] = cache_get_field_content_int(0, "Temp", mysql);
					CarInfo[PI[playerid][pLoadVehicleID]][cKey] = cache_get_field_content_int(0, "Key", mysql);
				}
				cache_delete(result);
				//======================================
				if(CarInfo[PI[playerid][pLoadVehicleID]][cLock] == 1) SetVehicleParamsEx(PI[playerid][pLoadVehicleID], false,lights_text,alarm,true,bonnet,boot,objective);
				else SetVehicleParamsEx(PI[playerid][pLoadVehicleID], false,lights_text,alarm,false,bonnet,boot,objective);
				//======================================
				DisablePlayerCheckpoint(playerid);
				SetPlayerCheckpoint(playerid, CarInfo[PI[playerid][pLoadVehicleID]][cPos_X], CarInfo[PI[playerid][pLoadVehicleID]][cPos_Y], CarInfo[PI[playerid][pLoadVehicleID]][cPos_Z]+1,5.0);
				
				LoadedOwnable++;

				SetPVarFloat(playerid, "gps_pos_x", CarInfo[PI[playerid][pLoadVehicleID]][cPos_X]);
				SetPVarFloat(playerid, "gps_pos_y", CarInfo[PI[playerid][pLoadVehicleID]][cPos_Y]);
				SetPVarFloat(playerid, "gps_pos_z", CarInfo[PI[playerid][pLoadVehicleID]][cPos_Z]);

				SCM(playerid,  COLOR_GREY, !"Ваш транспорт загружен, место спавна отмечено на мини-карте");

				DeletePVar(playerid, "LoadCar");
		    }
			else SCM(playerid, COLOR_GREY, !"Транспорт был припаркован слишком далеко");
		}
		case 401: 
		{
			if(!response) return 1;
	        if(response) 
			{
	        	switch(listitem) 
				{
					case 0: CarPass(playerid, playerid);
					case 1: CarInformation(playerid);
					case 2: callcmd::lock(playerid);
					case 3: callcmd::key(playerid); // ключи
					case 4: 
					{
						ShowPlayerDialog(playerid, 404, DIALOG_STYLE_LIST, "{ee3366}Управление транспортом", "1. Открыть / закрыть багажник\n2. Открыть / закрыть капот", "Далее", "Назад");
					}
					case 5: ShowPlayerDialog(playerid, 403, DIALOG_STYLE_LIST, "{ee3366}Отбуксировать транспорт", "1. Отбуксировать к дому / квартире\n2. Отбуксировать к автосалону", "Далее", "Назад");
					case 6: 
					{
						if(PI[playerid][pLoadVehicleID] == INVALID_VEHICLE_ID) return SendClientMessage(playerid, COLOR_GREY, !"У Вас не загружен не один автомобиль!");
						new Float:x, Float:y, Float:z;
						GetVehiclePos(PI[playerid][pLoadVehicleID], x, y, z);

						DisablePlayerCheckpoint(playerid);
						SetPlayerCheckpoint(playerid, x, y, z+1,5.0);

						SendClientMessage(playerid, COLOR_GREEN, !"Ваш транспорт отмечен у Вас на мини-карте!");
					}
					case 7: callcmd::park(playerid);
					case 8: callcmd::sellcar(playerid);
	        		case 9: ShowPlayerDialog(playerid, 402, DIALOG_STYLE_MSGBOX, !"{ee3366}Отметить транспорт", "{FFFFFF}Вы действительно хотите выгрузить свой личный транспорт?\n\nПри следующий загрузке, машина будет загружена на месте её парковки.", "Да", "Нет");
				}
	        }
	    }
	    case 402: 
		{
			if(!response) return 1;
	        if(response) 
			{
				if(PI[playerid][pLoadVehicleID] != INVALID_VEHICLE_ID) 
				{
					DestroyVehicle(PI[playerid][pLoadVehicleID]);

					ClearVehicleData(PI[playerid][pLoadVehicleID]);

					LoadedOwnable--;

					PI[playerid][pLoadVehicleID] = INVALID_VEHICLE_ID;
					SCM(playerid, COLOR_GREEN, !"Ваш личный транспорт выгружен");
				}
			}
	    }
	    case 403: 
		{
			if(!response) return 1;
	        if(response) 
			{
				switch(listitem) 
				{
				    case 0: 
					{
						if(PI[playerid][pHouse] == INVALID_HOUSE_ID && PI[playerid][pFloat] == INVALID_KV_ID) 
							return SCM(playerid, COLOR_GREY, !"У Вас нет дома или квартиры");

						GivePlayerMoneyLog(playerid, 750);
						SendClientMessage(playerid, -1, "Напомните если забыл дописать :/");
				    }
				    case 1: GivePlayerMoneyLog(playerid, 1500), SetVehiclePos(PI[playerid][pLoadVehicleID], 2303.4094, -1822.8162, 22.2802);
				}
			}
	    }
	    case 404: // ДОПИСАТЬ
		{
			if(!response) return 1;
	        if(response) 
			{
				switch(listitem) 
				{
					case 0:
					{
						new carid = GetPlayerVehicleID(playerid);
						GetVehicleParamsEx(carid, engine, lights_text, alarm, doors_text, bonnet, boot, objective);
						SetVehicleParamsEx(carid, engine, lights_text, alarm, doors_text, (bonnet == 1 ? 0 : 1), boot, objective);
					}
					case 1:
					{
						new carid = GetPlayerVehicleID(playerid);
						GetVehicleParamsEx(carid, engine, lights_text, alarm, doors_text, bonnet, boot, objective);
    					SetVehicleParamsEx(carid, engine, lights_text, alarm, doors_text, bonnet, (boot == 1 ? 0 : 1), objective);
					}
				}
			}
	    }
		case 5050: 
		{
			if(!response) return 1;
			if(response) 
			{
				switch(listitem) 
				{
					case 0: PromoCodeUse(playerid);
				}
			}
		}
		case 5060: 
		{
			if(!response) return callcmd::menu(playerid);
			if(response) 
			{
				switch(listitem) 
				{
					case 0: callcmd::referal(playerid);
					case 1: ShowMySQLReferals(playerid);
				}
			}
		}
		case 5051: 
		{
			if(!response) return 1;
			if(response) 
			{
				SCM(playerid, COLOR_GREY, !"Производим проверку...");
				f(global_str, 70, "SELECT * FROM `promocodes` WHERE `name`='%s'", inputtext);
				mysql_tquery(mysql, global_str, "MysqlPromoCheck", "i", playerid);
			}
		}
		case 9229: 
		{
			if(!response) return 1;
			if(response) 
			{
				SetPVarInt(playerid,"kdpickup",gettime() + 3);

				SCM(playerid, COLOR_TOMATO, !"Чтобы покинуть автосалон нажмите клавишу 'ESC'");
				PI[playerid][pChangerAutoSalon] = 0;
				SetPlayerPosAC(playerid,294.8927,1720.3408-20,11.8301);
				InterpolateCameraPos(playerid, 287.2545,1720.2989,13.1431, 287.2545,1720.2989,13.1431, 1000);
				InterpolateCameraLookAt(playerid, 287.2545,1720.2989,13.1431, 287.2545,1720.2989,13.1431, 1000);
				FreezePlayer(playerid);
				SetTimerEx("UnfreezePlayer", 4000, false, "d", playerid);
				PI[playerid][pAutoSalonCar] = CreateVehicle(DealershipCars[PI[playerid][pChangerAutoSalon]][asModel], 294.8927,1720.3408,11.8301,22.2060, 0, 0, 36000);
				SetVehicleVirtualWorld(PI[playerid][pAutoSalonCar], playerid);
				SetPlayerVirtualWorld(playerid, playerid);
				ShowAutoSalonMenu(playerid);
				return 1;
			}
		}
		case 9888: 
		{
		    if(!response) return 1;
		    if(response) 
			{
		        switch(listitem) 
				{
		            case 0: 
					{
		                if(Coolldown_Capture == 1) 
						{
							SCM(playerid, COLOR_GREENNEW, !"Вы выключили задержки на захваты территорий");
							Coolldown_Capture = 0;
							return 1;
						}
						if(Coolldown_Capture == 0) 
						{
							SCM(playerid, COLOR_GREENNEW, !"Вы включили задержки на захваты территорий");
							Coolldown_Capture = 1;
							return 1;
						}
		            }
					case 1: 
					{
						if(GetPVarInt(playerid,"kdsaveplayer") > gettime()) return SCM(playerid, COLOR_GREENNEW, !"{FFFF00}[Anti-Lag]{00aa33} сохранять сервер можно только раз в 10 секунд");
						SaveServer();
						SCM(playerid, COLOR_GREENNEW, !"Вы сохранили весь сервер");
						SetPVarInt(playerid,"kdsaveplayer",gettime() + 10);
					}
					case 2: SendRconCommand("hostname "NAMESERVER" | Открытие сервера");
					case 3: SendRconCommand("hostname "NAMESERVER" | Первый сервер / Обновление");
				}
			}
		}
		case dialog_LOGIN: 
		{
			if(!strlen(inputtextsave)) 
			{
				SCM(playerid, 0xFF6347FF, !"[Внимание]: {FFFFFF}Введите пароль от этого аккаунта");
				return PlayerLogin(playerid);
			}
			if(strlen(inputtextsave) < 6 || strlen(inputtextsave) > 30) 
			{
				SCM(playerid, 0xFF6347FF, !"[Внимание]: {FFFFFF}Длина пароля должна быть от 6 до 30 символов");
				return PlayerLogin(playerid);
			}
			for(new i = strlen(inputtextsave); i != 0; --i) 
			{
				switch(inputtextsave[i]) 
				{
					case 'А'..'Я', 'а'..'я': 
					{
						SCM(playerid, 0xFF6347FF, !"[Внимание]: {FFFFFF}Разрешено использовать только латинские буквы и цифры");
						return PlayerLogin(playerid);
					}
				}
			}
			strmid(PI[playerid][pPassword], inputtextsave, 0, strlen(inputtextsave), 30);

			mysql_string[0] = EOS, mf(mysql, mysql_string, 115, "SELECT * FROM `accounts` WHERE `Name` = '%e' AND `Password` = md5('%s')", PI[playerid][pName], inputtextsave);
			mysql_tquery(mysql, mysql_string, "LoadPlayerData", "i", playerid);
		}
  		case dialog_SEX: 
		{
  		    if(!response) PI[playerid][pSex] = 2;
  		    if(response) PI[playerid][pSex] = 1;
  		    ShowPlayerDialog(playerid, dialog_REFERAL, DIALOG_STYLE_INPUT, !"{ee3366}Реферальная система", !"\
			{FFFFFF}Если Вы узнали о нашем сервере от своего друга\n\
			то можете ввести его ник в нижнем окошке\n\n\
			{FFFF99}При достижении 3-го уровня Вы получите призы!", "Далее", "Пропустить");
  		}
		case dialog_REFERAL: 
		{
			if(!response)
			{
				strmid(PI[playerid][pReferal], "No Referal", 0, strlen("No Referal"), 24);

				SetPVarInt(playerid, "ChoosingSkin", 1);
				SetSpawnInfo(playerid, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
				return SpawnPlayer(playerid);
			}
		    if(response) 
			{
		        for(new i = strlen(inputtext); i != 0; --i)
				switch(inputtext[i]) 
				{
					case 'А'..'Я', 'а'..'я', ',', '`', '=': 
					{
						SCM(playerid, COLOR_GREEN, !"Разрешено использовать только латинские буквы и цифры");
						ShowPlayerDialog(playerid, dialog_REFERAL, DIALOG_STYLE_INPUT, !"{ee3366}Реферальная система", !"\
						{FFFFFF}Если Вы узнали о нашем сервере от своего друга\n\
						то можете ввести его ник в нижнем окошке\n\n\
						{FFFF99}При достижении 3-го уровня Вы получите призы!", "Далее", "Пропустить");
						return 1;
					}
				}
		        if(strfind(inputtext, PI[playerid][pName], true) != -1) 
				{
					ShowPlayerDialog(playerid, dialog_REFERAL, DIALOG_STYLE_INPUT, !"{ee3366}Реферальная система", !"\
					{FFFFFF}Если Вы узнали о нашем сервере от своего друга\n\
					то можете ввести его ник в нижнем окошке\n\n\
					{FFFF99}При достижении 3-го уровня Вы получите призы!", "Далее", "Пропустить");
					return 1;
				}
				SCM(playerid, COLOR_GREY, !"Производим проверку...");
				mysql_string[0] = EOS, f(mysql_string, 69, "SELECT * FROM `accounts` WHERE `Name`='%s'", inputtext);
				mysql_tquery(mysql, mysql_string, "MysqlReferalCheck", "is", playerid, inputtext);
      		}
		}
		case 8009: 
		{
			if(!response) return ShowMainMenu(playerid);
            if(response) return ShowMainMenu(playerid);
        }
        case 9827: 
		{
            if(response) 
			{
                if(!IsPlayerLogged{playerid}) return 1;
				if(strlen(inputtext) == 0) return SCM(playerid, COLOR_GREY, !"Никнейм должен содержать как минимум 1 символ");
                SendAdminsMessagef(COLOR_ADMINCHAT, "[%s #%d] %s[%d] установил себе временный никнейм (%s)", AdminName[PI[playerid][pAdmin]], PI[playerid][pAdminNumber], PI[playerid][pName], playerid, (inputtext));
                SetPlayerName(playerid, inputtext);
            }
        }
		case 9881: 
		{
			if(!response) return 1;
			if(response) 
			{
				if(PI[playerid][pPhone] == 0) return SCM(playerid, COLOR_GREY, !"Сначала купите телефон");
				if(PI[playerid][pDonate] < 150) return ShowPlayerDialog(playerid, 0, DIALOG_STYLE_MSGBOX, !"{ee3366}Ошибка", !"{FFFFFF}Для покупки 4-х значного номера телефона требуется 150 донат-поинтов.", "Закрыть", "");
  		    	if(strlen(inputtext) == 0) return ShowPlayerDialog(playerid, 9881, DIALOG_STYLE_INPUT, "{ee3366}Покупка 4-х значного номера", "Введите желаем номер в окне ниже.", "Купить", "Отмена");
				if(strlen(inputtext) < 4 || strlen(inputtext) > 4) return SCM(playerid, COLOR_GREY, !"Длина номера 4 символа"), ShowPlayerDialog(playerid, 9881, DIALOG_STYLE_INPUT, "{ee3366}Покупка 4х значного номера", "Введите желаем номер в окне ниже.", "Купить", "Отмена");
				PI[playerid][pDonate] -= 150;
				PI[playerid][pNumber] = strval(inputtext);
				UpdatePlayerDataInt(playerid, "number", PI[playerid][pNumber]);
				UpdatePlayerDataInt(playerid, "Donate", PI[playerid][pDonate]);
				SCM(playerid, 0x33ccffFF, "Успешная покупка, списано 150 донат-поинтов.");
			}
		}
		case 9880: 
		{
			if(!response) return 1;
			if(response) 
			{
				switch(listitem) 
				{
		            case 0: 
					{
						if(PI[playerid][pDonate] < 150*XDON) return ShowPlayerDialog(playerid, 0, DIALOG_STYLE_MSGBOX, !"{ee3366}Ошибка", !"{FFFFFF}Для покупки прав игрового мастера 1-го уровня недостаточно донат-поинтов", "Закрыть", "");
						PI[playerid][pDonate] -= 150*XDON;
						PI[playerid][pAdmin] = 1;
						UpdatePlayerDataInt(playerid, "Admin", PI[playerid][pAdmin]);
						UpdatePlayerDataInt(playerid, "Donate", PI[playerid][pDonate]);
						SCMf(playerid, 0x33ccffFF, "Успешная покупка, списано %d донат-поинтов.",150*XDON);
		            }
		            case 1: 
					{
						if(PI[playerid][pDonate] < 300*XDON) return ShowPlayerDialog(playerid, 0, DIALOG_STYLE_MSGBOX, !"{ee3366}Ошибка", !"{FFFFFF}Для покупки прав игрового мастера 2-го уровня недостаточно донат-поинтов", "Закрыть", "");
						PI[playerid][pDonate] -= 300*XDON;
						PI[playerid][pAdmin] = 2;
						UpdatePlayerDataInt(playerid, "Admin", PI[playerid][pAdmin]);
						UpdatePlayerDataInt(playerid, "Donate", PI[playerid][pDonate]);
						SCMf(playerid, 0x33ccffFF, "Успешная покупка, списано %d донат-поинтов.", 300*XDON);
		            }
		            case 2: 
					{
						if(PI[playerid][pDonate] < 450*XDON) return ShowPlayerDialog(playerid, 0, DIALOG_STYLE_MSGBOX, !"{ee3366}Ошибка", !"{FFFFFF}Для покупки прав игрового мастера 3-го уровня недостаточно донат-поинтов", "Закрыть", "");
						PI[playerid][pDonate] -= 450*XDON;
						PI[playerid][pAdmin] = 3;
						UpdatePlayerDataInt(playerid, "Admin", PI[playerid][pAdmin]);
						UpdatePlayerDataInt(playerid, "Donate", PI[playerid][pDonate]);
						SCMf(playerid, 0x33ccffFF, "Успешная покупка, списано %d донат-поинтов.",450*XDON);
					}
					case 3: 
					{
						if(PI[playerid][pDonate] < 600*XDON) return ShowPlayerDialog(playerid, 0, DIALOG_STYLE_MSGBOX, !"{ee3366}Ошибка", !"{FFFFFF}Для покупки прав игрового мастера 4-го уровня недостаточно донат-поинтов", "Закрыть", "");
						PI[playerid][pDonate] -= 600*XDON;
						PI[playerid][pAdmin] = 4;
						UpdatePlayerDataInt(playerid, "Admin", PI[playerid][pAdmin]);
						UpdatePlayerDataInt(playerid, "Donate", PI[playerid][pDonate]);
						SCMf(playerid, 0x33ccffFF, "Успешная покупка, списано %d донат-поинтов.", 600*XDON);
					}
					case 4: 
					{
						if(PI[playerid][pDonate] < 750*XDON) return ShowPlayerDialog(playerid, 0, DIALOG_STYLE_MSGBOX, !"{ee3366}Ошибка", !"{FFFFFF}Для покупки прав игрового мастера 5-го уровня недостаточно донат-поинтов", "Закрыть", "");
						PI[playerid][pDonate] -= 750*XDON;
						PI[playerid][pAdmin] = 5;
						UpdatePlayerDataInt(playerid, "Admin", PI[playerid][pAdmin]);
						UpdatePlayerDataInt(playerid, "Donate", PI[playerid][pDonate]);
						SCMf(playerid, 0x33ccffFF, "Успешная покупка, списано %d донат-поинтов.",750*XDON);
					}
					case 5: 
					{
						if(PI[playerid][pDonate] < 900*XDON) return ShowPlayerDialog(playerid, 0, DIALOG_STYLE_MSGBOX, !"{ee3366}Ошибка", !"{FFFFFF}Для покупки прав игрового мастера 6-го уровня недостаточно донат-поинтов", "Закрыть", "");
						PI[playerid][pDonate] -= 900*XDON;
						PI[playerid][pAdmin] = 6;
						UpdatePlayerDataInt(playerid, "Admin", PI[playerid][pAdmin]);
						UpdatePlayerDataInt(playerid, "Donate", PI[playerid][pDonate]);
						SCMf(playerid, 0x33ccffFF, "Успешная покупка, списано %d донат-поинтов.", 900*XDON);
					}	
					case 6:
					{
						if(PI[playerid][pDonate] < 1150*XDON) return ShowPlayerDialog(playerid, 0, DIALOG_STYLE_MSGBOX, !"{ee3366}Ошибка", !"{FFFFFF}Для покупки прав игрового мастера 7-го уровня недостаточно донат-поинтов", "Закрыть", "");
						PI[playerid][pDonate] -= 1150*XDON;
						PI[playerid][pAdmin] = 7;
						UpdatePlayerDataInt(playerid, "Admin", PI[playerid][pAdmin]);
						UpdatePlayerDataInt(playerid, "Donate", PI[playerid][pDonate]);
						SCMf(playerid, 0x33ccffFF, "Успешная покупка, списано %d донат-поинтов.",1150*XDON);
					}							
		        }
			}
		}
		case 9882: 
		{
			if(!response) return 1;
			if(response) 
			{
			    if(PI[playerid][pDonate] < 50) return ShowPlayerDialog(playerid, 0, DIALOG_STYLE_MSGBOX, !"{ee3366}Ошибка", !"{FFFFFF}Для смены игрового никнейма требуется 50 донат-поинтов.", "Закрыть", "");
		    	if(strlen(inputtext) == 0) return ShowPlayerDialog(playerid, 9882, DIALOG_STYLE_INPUT, "{ee3366}Изменение никнейма", "{FFFFFF}Вы собераетесь изменить игровой никнейм своего персонажа\n\n{ff6633}Обратите внимание, что если Вы измените никнейм во время\nпроверки на Вас жалобы, Вы будете заблокированы на 7 дней.", "Изменить", "Назад");
				if(strlen(inputtext) < 5 || strlen(inputtext) > 24) return SCM(playerid, COLOR_GREY, !"Длина ника от 5 до 24 символов"), ShowPlayerDialog(playerid, 9882, DIALOG_STYLE_INPUT, "{ee3366}Изменение никнейма", "{FFFFFF}Вы собераетесь изменить игровой никнейм своего персонажа\n\n{ff6633}Обратите внимание, что если Вы измените никнейм во время\nпроверки на Вас жалобы, Вы будете заблокированы на 7 дней.", "Изменить", "Назад");
        		for(new i = strlen(inputtext); i != 0; --i)
				switch(inputtext[i]) 
				{
					case 'А'..'Я', 'а'..'я', ' ','-':
					return ShowPlayerDialog(playerid, 9882, DIALOG_STYLE_INPUT, "{ee3366}Изменение никнейма", "{FFFFFF}Вы собераетесь изменить игровой никнейм своего персонажа\n\n{ff6633}Обратите внимание, что если Вы измените никнейм во время\nпроверки на Вас жалобы, Вы будете заблокированы на 7 дней.", "Изменить", "Назад");
				}
				strmid(CHANGE_NAME[playerid], inputtext, 0, strlen(inputtext), MAX_PLAYER_NAME);
				SetPVarInt(playerid, "change_name_status", 1);

				mysql_string[0] = EOS, mf(mysql, mysql_string, 71, "SELECT * FROM `accounts` WHERE `Name` = '%e'", CHANGE_NAME[playerid]);
				mysql_tquery(mysql, mysql_string, "CheckNameDonate", "ds", playerid, CHANGE_NAME[playerid]);
			}
		}
		case 9884: 
		{
		    if(!response) return 1;
		    if(response) 
			{
				if(PI[playerid][pDonate] < 100) return ShowPlayerDialog(playerid, 0, DIALOG_STYLE_MSGBOX, !"{ee3366}Ошибка", !"{FFFFFF}Для покупки всех навыков стрельбы требуется 100 донат-поинтов.", "Закрыть", "");
				PI[playerid][pSkillPistol] = 100;
				PI[playerid][pSkillSDPistol] = 100;
				PI[playerid][pSkillDeagle] = 100;
				PI[playerid][pSkillShotgun] = 100;
				PI[playerid][pSkillMP5] = 100;
				PI[playerid][pSkillAK47] = 100;
				PI[playerid][pSkillRifle] = 100;
				SetPlayerSkills(playerid);
				PI[playerid][pDonate] -= 100;
				SCM(playerid, 0x33ccffFF, "Успешная покупка, списано 100 донат-поинтов.");
			}
		}
		case 9883: {
		    if(!response) return 1;
		    if(response) {
		        if(PI[playerid][pDonate] < 60) return ShowPlayerDialog(playerid, 0, DIALOG_STYLE_MSGBOX, !"{ee3366}Ошибка", !"{FFFFFF}Для снятия предупреждения требуется 60 донат-поинтов.", "Закрыть", "");
				if(PI[playerid][pWarn] == 0) return SCM(playerid, COLOR_GREY, !"У Вас нет предупреждений");
				PI[playerid][pWarn] = 0;
		        PI[playerid][pWarnTime] = 0;
		        PI[playerid][pDonate] -= 60;
				SCM(playerid, 0x33ccffFF, "Успешная покупка, списано 60 донат-поинтов.");
			}
		}
		case 7891: 
		{
			if(!response) ShowTakeAks(playerid); 
		    if(response) ShowTakeAks(playerid);  
		}
		case 3988: 
		{
         	if(!response) return 1;
    		if(response) 
			{
                SetPVarInt(playerid, "AddKV", 1);
				SCM(playerid, COLOR_YELLOW, !"Встанте на место, где будет появляться игрок после выхода из подъезда {3366cc}(/tpplayer)");
			}
		}
		case dialog_CONVERT: 
		{
		    if(!response) return 1;
		    if(response) {
		        if(strval(inputtext) <= 0) return SCM(playerid, COLOR_GREY, !"Недопустимое значение");
		        if(strval(inputtext) > PI[playerid][pDonate]) return ShowPlayerDialog(playerid, 0, DIALOG_STYLE_MSGBOX, !"{ee3366}Ошибка", !"{FFFFFF}У Вас нет такой суммы донат-поинтов для конвертации!", "Закрыть", "");
				PI[playerid][pDonate] -= strval(inputtext);
				GivePlayerMoneyLog(playerid,strval(inputtext)*3000);
				SCMf(playerid, 0x33ccffFF, "Успешная покупка, списано %d донат-поинтов.",strval(inputtext));
			}

		}
		case dialog_COMMAND: 
		{
            if(!response) return ShowMainMenu(playerid);
			if(response) 
			{
			    switch(listitem) 
				{
			        case 0: ShowPlayerDialog(playerid, 0, DIALOG_STYLE_MSGBOX,"{ee3366}Общие","{FFFFFF}/me - показать действие\
							/do - показать действие от 3-го лица\n\
							/try - действие игрока (random)\n\
							/anim - список анимаций\n\
							/eject - выбросить из машины\n\
							/pay - передать деньги\n\
							/lic - показать лицензии\n\
							/pass - показать паспорт\n\
							/skills - показать свои навыки\n\
							/hi - приветствие\n\
							/setspawn - сменить спавн\n\
							/leaders - лидеры онлайн", "Закрыть", "");
					case 1: 
					{
	 				    if(PI[playerid][pHouse] == INVALID_HOUSE_ID && PI[playerid][pFloat] == INVALID_KV_ID) return SCM(playerid, COLOR_GREY, !"У Вас нет дома или квартиры");
						ShowPlayerDialog(playerid, 0, DIALOG_STYLE_MSGBOX,"{ee3366}Недвижимость","\
						{FFFFFF}/home - панель управления дома/квартиры\n\
						/car - доставить транспорт к дому", "Закрыть", "");
					}
					case 2: 
					{
	 				    if(PI[playerid][pBusiness] == INVALID_BUSINESS_ID) return SCM(playerid, COLOR_GREY, !"У вас нет бизнеса");
						ShowPlayerDialog(playerid, 0, DIALOG_STYLE_MSGBOX,"{ee3366}Недвижимость","{FFFFFF}/business - панель управления бизнеса", "Закрыть", "");
					}
					case 3: ShowPlayerDialog(playerid, 0, DIALOG_STYLE_MSGBOX,"{ee3366}Автомобиль","\
							{FFFFFF}/lock - закрыть/открыть автомобиль\n\
							CTRL - завести или заглушить двигатель\n\
							ALT - включить или выключить фары\n\
							/sellcar - продать личный автомобиль", "Закрыть", "");
			        case 4: return 1;
					case 5: 
					{
                        if(PI[playerid][pMember] == 0) return SCM(playerid, COLOR_GREY, !"Вы не состоите в организации");
						switch(PI[playerid][pMember]) 
						{
							case 1: ShowPlayerDialog(playerid, 0, DIALOG_STYLE_MSGBOX,"{ee3366}Организация","\
									{FFFFFF}/r - чат организации\n\
									/rr - OOC чат организации\n\
									/d - чат депортамента\n\
									/members - члены организации онлайн\n\
									/free - освободить игрока из тюрьмы (для адвокатов)\n\
									/givelic - продать лицензии (для секретарей)", "Закрыть", "");
							case 2: ShowPlayerDialog(playerid, 0, DIALOG_STYLE_MSGBOX,"{ee3366}Организация","\
									{FFFFFF}/r - чат организации\n\
									/rr - OOC чат организации\n\
									/d - чат депортамента\n\
									/members - члены организации онлайн\n\
									/putammo - разгрузить грузовик\n\
									/put - положить металл/патроны в грузовик\n\
									/makegun - создать оружие", "Закрыть", "");
							case 3: ShowPlayerDialog(playerid, 0, DIALOG_STYLE_MSGBOX,"{ee3366}Организация","\
									{FFFFFF}/r - чат организации\n\
									/rr - OOC чат организации\n\
									/d - чат депортамента\n\
									/members - члены организации online\n\
									/su - выдать розыск\n\
									/clear - обнулировать розыск\n\
									/cuff - надеть наручники\n\
									/uncuff - снять наручники\n\
									/incar - посадить игрока в машину\n\
									/uncar - вытащить игрка из машины\n\
									/arrest - провести арест\n\
									/wanted - список преступников\n\
									/setmark - поиск преступника\n\
									/tc - принять вызов", "Закрыть", "");
							case 4: ShowPlayerDialog(playerid, 0, DIALOG_STYLE_MSGBOX,"{ee3366}Организация", "\
									{FFFFFF}/r - чат организации\n\
									/rr - OOC чат организации\n\
									/d - чат депортамента\n\
									/members - члены организации онлайн\n\
									/heal - предложить курс лечения", "Закрыть", "");
							case 5,6,7: ShowPlayerDialog(playerid, 0, DIALOG_STYLE_MSGBOX,"{ee3366}Организация", "\
										{FFFFFF}/r - чат организации\n\
										/rr - OOC чат организации\n\
										/members - члены организации онлайн\n\
										/capture - начать захват территории\n\
										/gun - создать оружие", "Закрыть", "");
							case 8: ShowPlayerDialog(playerid, 0, DIALOG_STYLE_MSGBOX,"{ee3366}Организация", "\
										{FFFFFF}/r - чат организации\n\
										/rr - OOC чат организации\n\
										/d - чат депортамента\n\
										/members - члены организации онлайн\n\
										/news - панель новостей", "Закрыть", "");
						}
					}
			        case 6: 
					{
						ShowPlayerDialog(playerid, 0, DIALOG_STYLE_TABLIST_HEADERS, !"{ee3366}Лидеры и заместители", "\
								Команда\tОписание\n\
								{FFFFFF}/l\tРация лидеров\n\
								/ll (/lb)\tOOC рация лидеров\n\
								/bl\tЧёрный список организации\n\
								/lname\tНайти игрока по старому никнейму\n\
								/twarn\tВыдать выговор\n\
								/clead\tНазначить на должность смотрящего за стрелой\n\
								/invite\tПринять игрока в организацию\n\
								/setskin\tИзменить ранг игрока\n\
								/setrang\tИзменить ранг игрока\n\
								/untwarn\tСнять выговор\n\
								/uninvite\tУволить игрока из организации\n\
								/offtwarn\tВыдать выговор оффлайн\n\
								/setgroup\tИзменить группу игрока\n\
								/transfers\tСписок заявок на перевод\n\
								/promotion\tУзнать информацию о заданиях игрока\n\
								/offuntwarn\tСнять выговор оффлайн\n\
								/allmembers\tПоказать всех участников организации\n\
								/uninviteoff\tУволить оффлайн игрока из организации\n\
								/offpromotion\tУзнать информацию о заданиях игрока оффлайн", "Закрыть", "");
					}
			    }
			}
		}
        case dialog_GUN_POLICE: 
		{
			if(!response) return 1;
			if(response) 
			{
			    switch(listitem) 
				{
			        case 0: 
					{
    					if(PI[playerid][pMember] == 3 && PI[playerid][pRang] == 1) return SCM(playerid, COLOR_GREY,"На первом ранге данное оружие недоступно");
						GiveWeapon(playerid, 24, 50);
					}
			        case 1: 
					{
					    if(PI[playerid][pMember] == 3 && PI[playerid][pRang] == 1) return SCM(playerid, COLOR_GREY,"На первом ранге данное оружие недоступно");
						GiveWeapon(playerid, 29, 250);
					}
			        case 2:GiveWeapon(playerid, 3, 1);
			        case 3:SetPlayerHealthAC(playerid, 100);
			        case 4:SetPlayerArmourAC(playerid, 100);
			        case 5: 
					{
			            if(shield[playerid] == false) 
						{
	                        SetPlayerAttachedObject(playerid, 1, 18637, 14, 0.0, 0.0, 0.0, 0.0, 180.0, 180.0);
	                        shield[playerid] = true;
	                    }
			        }
			        case 6:GiveWeapon(playerid, 12, 1);
			    }
			    if(PI[playerid][pMember] == 3 || PI[playerid][pMember] == 8) return ShowPlayerDialog(playerid, dialog_GUN_POLICE, DIALOG_STYLE_LIST, "{ee3366}Склад", "Убойный пистолет (50 патрон)\nАвтомат (250 патрон)\nДубинка\nАптечка\nБронежилет\nЗащитный щит\nЖезл", "Выбрать", "Отмена");
			    else ShowPlayerDialog(playerid, dialog_GUN_POLICE, DIALOG_STYLE_LIST, "{ee3366}Склад", "Убойный пистолет (50 патрон)\nАвтомат (250 патрон)\nДубинка\nАптечка\nБронежилет\nЗащитный щит", "Выбрать", "Отмена");
			}
		}
		case 9230: 
		{
		    if(!response) return 1;
		    if(response) 
			{
				switch(listitem) 
				{
				    case 0: 
					{
				        ShowPlayerDialogf(playerid, 9231, DIALOG_STYLE_MSGBOX, !"{ee3366}Покупка транспорта", "Купить", "Отмена", "\
						{FFFFFF}Вы хотите купить {ffff99}'%s'{FFFFFF} за {ffff99}'%d'{FFFFFF} донат-поинтов?\n\
						{FFFFFF}Стоимость: {ffff99}%d в руб\n\
						{FFFFFF}Скорость машины: {ffff99}%d км/час{FFFFFF}\n\n\
						{696969}Обратите внимание: отменить это действие будет невозможно!",
						VehicleNames[DealershipCars[PI[playerid][pChangerAutoSalon]][asModel]-400], DealershipCars[PI[playerid][pChangerAutoSalon]][asDonate], DealershipCars[PI[playerid][pChangerAutoSalon]][asDonate]*3000, DealershipCars[PI[playerid][pChangerAutoSalon]][asSpeed]);
				    }
				    case 1: 
					{
						if(PI[playerid][pHouse] == INVALID_HOUSE_ID && PI[playerid][pFloat] == INVALID_KV_ID) return SCM(playerid, COLOR_GREY, !"У Вас нет дома или квартиры");

						new Cache: result, query[140];

						mf(mysql, query, sizeof query, "SELECT * FROM ownable WHERE Owner='%e' AND Premium='0'", getName(playerid));
						result = mysql_query(mysql, query, true);

						if(cache_num_rows() >= 2)
						{
							ShowPlayerDialog(playerid, 0, DIALOG_STYLE_MSGBOX, !"{ee3366}Ошибка", "\
							{FFFFFF}У Вас заняты {FFFF99}2 из 2{FFFFFF} слотов для автомобилей.\n\n\
							{FFFFFF}Сейчас Вы можете преобрести только {FFFF99}Премиум{FFFFFF} автомобили за донат-поинты.", "Ок", "");
						}
						cache_delete(result);
						
						ShowPlayerDialogf(playerid, 9232, DIALOG_STYLE_MSGBOX, !"{ee3366}Покупка транспорта", "Купить", "Отмена", "\
						{FFFFFF}Вы хотите купить {FFFF99}'%s'{FFFFFF} за {FFFF99}'%d'{FFFFFF} руб?\n\
						{FFFFFF}Стоимость: {FFFF99}%d в донат-поинтах\n\
						{FFFFFF}Скорость машины: {FFFF99}%d км/час{FFFFFF}\n\n\
						{696969}Обратите внимание: отменить это действие будет невозможно!",
						VehicleNames[DealershipCars[PI[playerid][pChangerAutoSalon]][asModel]-400], DealershipCars[PI[playerid][pChangerAutoSalon]][asDonate]*3000, DealershipCars[PI[playerid][pChangerAutoSalon]][asDonate], DealershipCars[PI[playerid][pChangerAutoSalon]][asSpeed]);
					}
				}
			}
		}
		case 9231: 
		{
		    if(!response) return 1;
		    if(response) 
			{
				if(PI[playerid][pDonate] < DealershipCars[PI[playerid][pChangerAutoSalon]][asDonate]) 
							return ShowPlayerDialog(playerid, 0, DIALOG_STYLE_MSGBOX, !"{ee3366}Ошибка оплаты", "{FFFFFF}У Вас нет нужного количества донат-поинтов для покупки данного автомобиля!", "Закрыть", "");
				
				ShowPlayerDialog(playerid, 9235, DIALOG_STYLE_LIST, "{ee3366}Цвет транспорта", "\
																		{000000}||||||||||||||||\n\
																		{263739}||||||||||||||||\n\
																		{8494ab}||||||||||||||||\n\
																		{f5f5f5}||||||||||||||||\n\
																		{395a83}||||||||||||||||\n\
																		{0e316d}||||||||||||||||\n\
																		{993e4d}||||||||||||||||\n\
																		{473532}||||||||||||||||\n\
																		{d78e10}||||||||||||||||\n\
																		{193826}||||||||||||||||", "Выбрать", "");
				//PI[playerid][pDonate] -= DealershipCars[PI[playerid][pChangerAutoSalon]][asDonate];
				return 1;
		    }
		}
		case 9232: 
		{
		    if(!response) return 1;
		    if(response) 
			{

				if(PI[playerid][pMoney] < DealershipCars[PI[playerid][pChangerAutoSalon]][asDonate]*3000) 
					return ShowPlayerDialog(playerid, 0, DIALOG_STYLE_MSGBOX, !"{ee3366}Ошибка оплаты", "{FFFFFF}У Вас нет нужного количества денег для покупки данного автомобиля!", "Закрыть", "");
				
				ShowPlayerDialog(playerid, 9234, DIALOG_STYLE_LIST, "{ee3366}Цвет транспорта", "\
																{000000}||||||||||||||||\n\
																{263739}||||||||||||||||\n\
																{8494ab}||||||||||||||||\n\
																{f5f5f5}||||||||||||||||\n\
																{395a83}||||||||||||||||\n\
																{0e316d}||||||||||||||||\n\
																{993e4d}||||||||||||||||\n\
																{473532}||||||||||||||||\n\
																{d78e10}||||||||||||||||\n\
																{193826}||||||||||||||||", "Выбрать", "");
				//PI[playerid][pMoney] -= DealershipCars[PI[playerid][pChangerAutoSalon]][asCena];		
				return 1;										
		    }
		}
		case 9234:
		{
		    if(!response) 
			{ 
				return ShowPlayerDialog(playerid, 9234, DIALOG_STYLE_LIST, "{ee3366}Цвет транспорта", "{000000}||||||||||||||||\n{263739}||||||||||||||||\n{8494ab}||||||||||||||||\n{f5f5f5}||||||||||||||||\n{395a83}||||||||||||||||\n{0e316d}||||||||||||||||\n{993e4d}||||||||||||||||\n{473532}||||||||||||||||\n{d78e10}||||||||||||||||\n{193826}||||||||||||||||", "Выбрать", "");
			}
		    if(response)
			{
		    	switch(listitem) 
				{
					case 0: PI[playerid][pAutoSalonColor] = 0;
					case 1: PI[playerid][pAutoSalonColor] = 4;
					case 2: PI[playerid][pAutoSalonColor] = 32;
					case 3: PI[playerid][pAutoSalonColor] = 1;
					case 4: PI[playerid][pAutoSalonColor] = 87;
					case 5: PI[playerid][pAutoSalonColor] = 79;
					case 6: PI[playerid][pAutoSalonColor] = 161;
					case 7: PI[playerid][pAutoSalonColor] = 40;
					case 8: PI[playerid][pAutoSalonColor] = 6;
					case 9: PI[playerid][pAutoSalonColor] = 44;
				}
				HideAutoSalonMenu(playerid);
				DestroyVehicle(PI[playerid][pAutoSalonCar]);

				SetPlayerInterior(playerid, 0);
				SetPlayerVirtualWorld(playerid, 0);
				SetPlayerPosAC(playerid, 2323.3674,-1797.8130,22.4540);
				SetCameraBehindPlayer(playerid);

				if(PI[playerid][pMoney] < DealershipCars[PI[playerid][pChangerAutoSalon]][asDonate]*3000) 
					return ShowPlayerDialog(playerid, 0, DIALOG_STYLE_MSGBOX, !"{ee3366}Ошибка оплаты", "{FFFFFF}У Вас нет нужного количества денег для покупки данного автомобиля!", "Закрыть", "");

				new Sum = DealershipCars[PI[playerid][pChangerAutoSalon]][asDonate]*3000;
				new Profit = Sum*20/100;
				new B = GetPVarInt(playerid, "business");
				BizInfo[B][bMoney] += Profit;
				UpdateBusinessData(B);

				SCMf(playerid, COLOR_GREENNEW, "Вы успешно купили {fe9a7e}'%s'{00aa33} за {fe9a7e}%d руб",\
								VehicleNames[DealershipCars[PI[playerid][pChangerAutoSalon]][asModel]-400],
								DealershipCars[PI[playerid][pChangerAutoSalon]][asDonate]*3000);
				SCM(playerid, COLOR_GREENNEW, !"Повторно прочитать руководство по эксплуатации можно в меню трансорта {fe9a7e}(/car)");
				CarInformation(playerid);

				PI[playerid][pMoney] -= DealershipCars[PI[playerid][pChangerAutoSalon]][asDonate]*3000;		

				SetPlayerOwnable(playerid, DealershipCars[PI[playerid][pChangerAutoSalon]][asModel], DealershipCars[PI[playerid][pChangerAutoSalon]][asDonate]*3000, 50, PI[playerid][pAutoSalonColor], PI[playerid][pAutoSalonColor], 0);

				PI[playerid][pChangerAutoSalon] = INVALID_VEHICLE_ID;
				PI[playerid][pAutoSalonCar] = INVALID_VEHICLE_ID;
		    }
		}
		case 9235:
		{
		    if(!response) 
			{ 
				return ShowPlayerDialog(playerid, 9235, DIALOG_STYLE_LIST, "{ee3366}Цвет транспорта", "{000000}||||||||||||||||\n{263739}||||||||||||||||\n{8494ab}||||||||||||||||\n{f5f5f5}||||||||||||||||\n{395a83}||||||||||||||||\n{0e316d}||||||||||||||||\n{993e4d}||||||||||||||||\n{473532}||||||||||||||||\n{d78e10}||||||||||||||||\n{193826}||||||||||||||||", "Выбрать", "");
			}
		    if(response)
			{
		    	switch(listitem) 
				{
					case 0: PI[playerid][pAutoSalonColor] = 0;
					case 1: PI[playerid][pAutoSalonColor] = 4;
					case 2: PI[playerid][pAutoSalonColor] = 32;
					case 3: PI[playerid][pAutoSalonColor] = 1;
					case 4: PI[playerid][pAutoSalonColor] = 87;
					case 5: PI[playerid][pAutoSalonColor] = 79;
					case 6: PI[playerid][pAutoSalonColor] = 161;
					case 7: PI[playerid][pAutoSalonColor] = 40;
					case 8: PI[playerid][pAutoSalonColor] = 6;
					case 9: PI[playerid][pAutoSalonColor] = 44;
				}
				HideAutoSalonMenu(playerid);
				DestroyVehicle(PI[playerid][pAutoSalonCar]);

				SetPlayerInterior(playerid, 0);
				SetPlayerVirtualWorld(playerid, 0);
				SetPlayerPosAC(playerid, 2323.3674,-1797.8130,22.4540);
				SetCameraBehindPlayer(playerid);

				if(PI[playerid][pDonate] < DealershipCars[PI[playerid][pChangerAutoSalon]][asDonate]) 
					return ShowPlayerDialog(playerid, 0, DIALOG_STYLE_MSGBOX, !"{ee3366}Ошибка оплаты", "{FFFFFF}У Вас нет нужного количества денег для покупки данного автомобиля!", "Закрыть", "");

				new Sum = DealershipCars[PI[playerid][pChangerAutoSalon]][asDonate]*3000;
				new Profit = Sum*20/100;
				new B = GetPVarInt(playerid, "business");
				BizInfo[B][bMoney] += Profit;
				UpdateBusinessData(B);

				SCMf(playerid, COLOR_GREENNEW, "Вы успешно купили {fe9a7e}'%s'{00aa33} за {fe9a7e}%d донат-поинтов", 
												VehicleNames[DealershipCars[PI[playerid][pChangerAutoSalon]][asModel]-400],
												DealershipCars[PI[playerid][pChangerAutoSalon]][asDonate]);

				SCM(playerid, COLOR_GREENNEW, !"Повторно прочитать руководство по эксплуатации можно в меню трансорта {fe9a7e}(/car)");
				CarInformation(playerid);

				PI[playerid][pDonate] -= DealershipCars[PI[playerid][pChangerAutoSalon]][asDonate];	

				SetPlayerOwnable(playerid, DealershipCars[PI[playerid][pChangerAutoSalon]][asModel], DealershipCars[PI[playerid][pChangerAutoSalon]][asDonate]*3000, 50, PI[playerid][pAutoSalonColor], PI[playerid][pAutoSalonColor], 1);

				PI[playerid][pChangerAutoSalon] = INVALID_VEHICLE_ID;
				PI[playerid][pAutoSalonCar] = INVALID_VEHICLE_ID;
		    }
		}
		case 3298:
		{
			if(!response) return 1;
			if(response)
			{
				new Float:X,Float:Y,Float:Z;
				GetPlayerPos(targplayer[playerid], X, Y, Z);
				if(!PlayerToPoint(3.0, playerid, X, Y, Z)) return SCM(playerid, COLOR_GREY, !"Вы находетесь далеко друг от друга");

				switch(listitem)
				{
					case 0:
					{
						return SendRequestForPlayer(playerid, targplayer[playerid], 0);
					}
					case 1:
					{
						if(PI[targplayer[playerid]][pHealPack] >= 3) return SCM(playerid, COLOR_GREY, !"У игрока уже есть 3 набора аптечек");
						return SendRequestForPlayer(playerid, targplayer[playerid], 2);
					}
					case 2:
					{
						return SendRequestForPlayer(playerid, targplayer[playerid], 3);
					}
					case 3:
					{
						return SendRequestForPlayer(playerid, targplayer[playerid], 4);
					}
					case 4:
					{
						return SendRequestForPlayer(playerid, targplayer[playerid], 5);
					}
					case 5:
					{
						return SendRequestForPlayer(playerid, targplayer[playerid], 7);
					}
					case 6:
					{
						if(PI[targplayer[playerid]][pMask] >= 1) return SCM(playerid, COLOR_GREY, !"У игрока уже есть маска");
						return SendRequestForPlayer(playerid, targplayer[playerid], 8);
					}
				}
			}
		}
		case dialog_BUYGUN_1:
		{
			if(!response) return 1;
			if(response)
			{
			    if(strval(inputtext) <= 0) return SCM(playerid, COLOR_GREY,"Недопустимое значение");
			    if(strval(inputtext) > 500) return SCM(playerid, COLOR_GREY,"Нельзя купить больше 500 патронов за один раз");
                new b = GetPVarInt(playerid,"business");
				new patr = strval(inputtext);
				new kofi;
				new ggun = GetPVarInt(playerid, "makegun");
				switch(ggun)
			    {
			        case 24:kofi = 50;
			        case 22:kofi = 25;
			        case 25:kofi = 50;
			        case 29:kofi = 30;
			        case 30:kofi = 75;
			        case 34:kofi = 250;
			    }
			    if(patr*kofi > GetPlayerMoneyID(playerid)) return SCM(playerid, COLOR_GREY,"У Вас недостаточно денег на руках");
			    if(patr > BizInfo[b][bProduct] && BizInfo[b][bOwned] == 1) return SCM(playerid, COLOR_GREY,"На складе недостаточно боеприпасов");
                BizInfo[b][bProduct] -= patr;
                BizInfo[b][bMoney] += patr*kofi;
				GivePlayerMoneyLog(playerid, -patr*kofi);
				GiveWeapon(playerid, ggun, patr);
				UpdateBusinessData(b);
			}
		}
		case 9111: 
		{
			if(!response) return 1;
			if(response)
			{
				if(GetPlayerInterior(playerid) != 0) return SCM(playerid, COLOR_GREY, !"Вызов скорой помощи доступен только на улице");
				for(new i = 0; i < MAX_PLAYERS; i++) 
				{
				    if(!IsPlayerConnected(i)) continue;
				    if(PI[i][pMember] == 3) 
					{
						SCMf(i, 0x69b867FF, "%s[%d] вызвал полицию, расстояние: %.1f, Используйте /accept чтобы принять вызов",PI[playerid][pName],playerid, GetDistanceBetweenPlayers(playerid, i));
						SCMf(i, 0x69b867FF, "Сообщение игрока: {FFFF99}%s",inputtext);
				    }
				}
			    SCM(playerid, 0x00a86bFF, !"Вы успешно вызвали сотрудников полиции, оставайтесь на месте.");
				PI[playerid][data_911_1] = 1;
			}
		}
		case 9112: 
		{
			if(!response) return 1;
			if(response) 
			{
			    if(GetPlayerInterior(playerid) != 0) return SCM(playerid, COLOR_GREY, !"Вызов полиции доступен только на улице");
				for(new i = 0; i < MAX_PLAYERS; i++) 
				{
				    if(!IsPlayerConnected(i)) continue;
				    if(PI[i][pMember] == 4) 
					{
						SCMf(i,0x69b867FF, "%s[%d] вызвал скорую помощь, расстояние: %.1f, Используйте /accept чтобы принять вызов",PI[playerid][pName],playerid, GetDistanceBetweenPlayers(playerid, i));
						SCMf(i,0x69b867FF, "Сообщение игрока: {FFFF99}%s",inputtext);
				    }
				}
			    SCM(playerid, 0x00a86bFF, !"Вы успешно вызвали сотрудников скорой помощи, оставайтесь на месте.");
                PI[playerid][data_911_2] = 1;
			}
		}
		case dialog_ADD_HOUSE: 
		{
         	if(!response) return 1;
    		if(response) 
			{
                SetPVarInt(playerid,"addhouse",1);
				SCM(playerid, COLOR_YELLOW, !"Сядьте в машину и введите {3366cc}/tpc{FFFF00} для сохранения позиции автомобиля");
			}
		}
		case dialog_ADD_HOUSE_1:
  		{
  		    if(!response) return SetPVarInt(playerid, "addhouse",0);
  		    if(response)
  		    {
  		        switch(listitem)
  		        {
					case 0:
					{
					    SetPVarFloat(playerid,"aExitX",1113.1830);
                        SetPVarFloat(playerid,"aExitY",1526.1506);
                        SetPVarFloat(playerid,"aExitZ",905.8036);
                        SetPVarInt(playerid,"aInt",1);
					}
					case 1:
					{
					    SetPVarFloat(playerid,"aExitX",1113.1830);
                        SetPVarFloat(playerid,"aExitY",1526.1506);
                        SetPVarFloat(playerid,"aExitZ",905.8036);
                        SetPVarInt(playerid,"aInt",2);
					}
				}
				ShowPlayerDialog(playerid, dialog_ADD_HOUSE_2, DIALOG_STYLE_INPUT, "{ee3366}Цена дома", "От 10 000 рублей до 10 000 000 рублей", "Добавить", "Отмена");
			}
		}

		case dialog_ADD_HOUSE_2:
		{
		    if(!response) return SetPVarInt(playerid, "addhouse",0);
		    if(response)
		    {
		        if(strval(inputtext) < 10000 || strval(inputtext) > 10000000) return ShowPlayerDialog(playerid, dialog_ADD_HOUSE_3, DIALOG_STYLE_INPUT, "{ee3366}Цена дома", "От 10 000 рублей до 10 000 000 рублей", "Добавить", "Отмена");
                SetPVarInt(playerid,"aPrice",strval(inputtext));
                ShowPlayerDialog(playerid, dialog_ADD_HOUSE_3, DIALOG_STYLE_INPUT, "{ee3366}Класс", "Введите класс дома 0,1,2,3,4", "Добавить", "Отмена");
			}
		}
		case dialog_ADD_HOUSE_3:
		{
		    if(!response) return 1;
		    if(response)
		    {
			    SetPVarInt(playerid,"aClass",strval(inputtext));
			    AddHouse(playerid);
		    }
		}


		case dialog_ASH_TEST:
		{
		    if(!response) return 1;
			if(response)
			{
			    if(GetPlayerMoneyID(playerid) < 5000) return SCM(playerid, COLOR_GREY, !"У Вас недостаточно денег на руках");
				GivePlayerMoneyLog(playerid,-5000);
			    PI[playerid][data_ASH_CAR] = INVALID_VEHICLE_ID;
				PI[playerid][data_CHEK] = 0;
				PI[playerid][data_ASH_TEST] = 1;
				SCM(playerid,0xFFCC33FF, !"Вы начали тест. Отправляйтесь на парковку автошколы и возьмите траспортное средство");
			}
		}
        /*case dialog_BANK:
        {
            if(!response) return 1;
			if(response)
			{
			    switch(listitem)
			    {
			        case 0: ShowBankMoney(playerid);
			        case 1: ShowPlayerDialog(playerid, dialog_BANK_2, DIALOG_STYLE_INPUT, "{ee3366}Снятие наличных", "Комиссия составит {3377cc}4%\n{FFFFFF}Введите требуемую сумму", "Выполнить", "Назад");
			        case 2: ShowPlayerDialog(playerid, dialog_BANK_3, DIALOG_STYLE_INPUT, "{ee3366}Пополнение счёта", "Введите нужную сумму:", "Пополнить", "Назад");
			        case 3:
					{
						if(PI[playerid][pLevel] < 2) return SCM(playerid, COLOR_GREY,"Использовать банковскую систему можно только со 2 уровня");
						ShowPlayerDialog(playerid, dialog_BANK_9, DIALOG_STYLE_INPUT, "{ee3366}Перевод на другой счёт", "{FFFFFF}Укажите ID получателя и сумма перевода\nчерез запятую. Комиссия при переводе составит {3377cc}3%\n{FFFF99}Пример формы для перевода: 12, 500000", "Перевести", "Назад");
					}
			        case 4: ShowPlayerDialog(playerid, 9001, DIALOG_STYLE_INPUT, "{ee3366}Банк", "{FFFFFF}Введите сумму которую желаете положить на счет телефона", "Выполнить", "Назад");
			        case 5: 
					{
					    if(PI[playerid][pHouse] == INVALID_HOUSE_ID && PI[playerid][pFloat] == INVALID_KV_ID) return SCM(playerid, COLOR_GREY, !"У Вас нет дома или квартиры");
						if(PI[playerid][pHouse] != INVALID_HOUSE_ID) 
						{
							new h = PI[playerid][pHouse];
						 	ShowPlayerDialogf(playerid, 7950, DIALOG_STYLE_INPUT, !"{ee3366}Оплата жилья", !"Далее", !"Назад", "\
								{FFFFFF}Номер дома: %d\n\
								{FFFFFF}Статус оплаты: %d / 30 дней\n\
								{FFFF99}Квартплата - 1499 руб / день\n\n\
								{FFFFFF}Введите количество дней для оплаты", HOUSE_DATA[h][data_ID], HOUSE_DATA[h][data_DAY]);
				        }
				        else if(PI[playerid][pFloat] != INVALID_KV_ID) 
						{
							new kv = PI[playerid][data_PADIK],k = PI[playerid][pFloat];
						 	ShowPlayerDialogf(playerid, 7951, DIALOG_STYLE_INPUT, "{ee3366}Оплата жилья", "Далее", "Назад", "\
								{FFFFFF}Номер квартиры: %d\n\
								{FFFFFF}Статус оплаты: %d / 30 дн\n\
								{FFFF99}Квартплата - 1299 руб / день\n\n\
								{FFFFFF}Введите количество дней для оплаты", kvData[kv][kvID],kvData[kv][kvDays][k]);
				        }
					}
					case 6: 
					{
					    if(PI[playerid][pBusiness] == INVALID_BUSINESS_ID) return SCM(playerid, COLOR_GREY, !"У Вас нет бизнеса или АЗС");
						new b = PI[playerid][pBusiness];
						ShowPlayerDialogf(playerid, 7952, DIALOG_STYLE_INPUT, !"{ee3366}Оплата бизнеса", !"Далее", !"Назад", "\
							{FFFFFF}Номер бизнеса: %d\n\
							{FFFFFF}Статус оплаты: %d / 30 дней\n\
							{FFFF99}Налог - 3999 рублей\n\n\
							{FFFFFF}Введите количество дней для оплаты", BizInfo[b][data_ID], BizInfo[b][bDays]);
					}
				}
			}
        }*/
        case 9228: 
		{
		    if(!response) return 1;
		    if(response) 
			{
				if(PI[playerid][pLoadVehicleID] == INVALID_VEHICLE_ID) return SCM(playerid, COLOR_GREY, !"У Вас нет загруженно машины для продажи");
				if(CarInfo[PI[playerid][pLoadVehicleID]][cTemp] != -1) return SCM(playerid, COLOR_GREY, !"Вы не можете продать временный автомобиль");
				switch(listitem)
			    {
					case 0:
					{
						if(!PlayerToPoint(50.0, playerid, 1158.0021,2572.6350,1112.4800)) return SendClientMessage(playerid, COLOR_LIGHTGREY, !"Вы должны находится в Мэрии (/gps > Важные места)");
						ShowPlayerDialogf(playerid, 9227, DIALOG_STYLE_INPUT, !"{ee3366}Продажа транспорта", !"Продать", !"Закрыть",\
						"{FFFFFF}Вы действительно хотите продать своё транспортное средство государству?\n\n\
						Налог на продажу составит 35%% от государственной стоимости.\n\
						На Ваш банковский счёт будет переведено {3366cc}%d руб\n\
						{FFFFFF}Для подтверждения введите стоимость цифрой: {61bd74}%d\n\n\
						{ff6633}ОБРАТИТЕ ВНИМАНИЕ: Это действия нельзя будет отменить.\n\
						{FFFF99}Примичание: Вы должны находиться в Мэрии (/gps > Важные места)", CarInfo[PI[playerid][pLoadVehicleID]][cCost]/100*35, CarInfo[PI[playerid][pLoadVehicleID]][cCost]);
					}
					case 1:
					{
						if(!IsPlayerInRangeOfPoint(playerid, 75.0, 2475.3923, -706.9788, 12.3000)) 
							return SCM(playerid, COLOR_GREY, !"Чтобы продать свой транспорт другому игроку, Вам нужно быть на авторыноке.");

						ShowSellCar(playerid);
					}
				}
	        }
		}
		case 9221:
		{
			new from_player = PI[playerid][pRequestFrom];

			if(!response)
			{
				SCMf(from_player, COLOR_GREY, "%s отказался от Вашего предложения", getName(playerid), VehicleNames[CarInfo[PI[from_player][pLoadVehicleID]][cModel]-400]);
				SCMf(playerid, COLOR_GREY, "Вы отказались от предложения игрока %s", PI[from_player][pName]);

				ClearRequest(PI[playerid][pRequestFrom]);
				ClearRequest(playerid);
			}
			if(response) 
			{
				if(ProxDetectorS(10.0, playerid, from_player))
				{
					new value = PI[from_player][pRequestValue_1];
					new value_2 = PI[from_player][pRequestValue_2];

					if(CarInfo[PI[from_player][pLoadVehicleID]][cPremium] == 1)
					{
						SCMf(from_player, COLOR_YELLOW, "%s преобрел Ваш трансопорт '%s' за %d рублей (включая налог на премиум транспорт: %d)", 
							getName(playerid), VehicleNames[CarInfo[PI[from_player][pLoadVehicleID]][cModel]-400], value+value_2, value_2);
						SCMf(playerid, COLOR_YELLOW, "Поздравляем! Вы преобрели трансопорт '%s' за %d рублей у игрока %s", 
							VehicleNames[CarInfo[PI[from_player][pLoadVehicleID]][cModel]-400], value+value_2, getName(from_player));
					}
					else
					{
						SCMf(from_player, COLOR_YELLOW, "%s преобрел Ваш трансопорт '%s' за %d рублей", 
							getName(playerid), VehicleNames[CarInfo[PI[from_player][pLoadVehicleID]][cModel]-400], value);
						SCMf(playerid, COLOR_YELLOW, "Поздравляем! Вы преобрели трансопорт '%s' за %d рублей у игрока %s", 
							VehicleNames[CarInfo[PI[from_player][pLoadVehicleID]][cModel]-400], value, getName(from_player));
					}

					GivePlayerMoneyLog(playerid, -value);
					GivePlayerMoneyLog(from_player, value);

					UpdatePlayerDataInt(playerid, "Money", PI[playerid][pMoney]);
					UpdatePlayerDataInt(from_player, "Money", PI[from_player][pMoney]);
					//==========================================================
					new carid = PI[from_player][pLoadVehicleID];
					new Float: car_x, Float: car_y, Float: car_z;
					GetVehiclePos(carid, car_x, car_y, car_z);

					CarInfo[carid][cPos_X] = car_x;
					CarInfo[carid][cPos_Y] = car_y;
					CarInfo[carid][cPos_Z] = car_z + 0.8;
					GetVehicleZAngle(carid, CarInfo[carid][cPos_A]);
					
					CarInfo[carid][cNoPark] = 0;

					SaveOwnableCar(carid);
					//==========================================================

					mysql_queryf(mysql, "UPDATE `ownable` SET `Owner` = '%e' WHERE `Owner` = '%e' AND `ID` = '%d'", false,\
						getName(playerid), getName(from_player), CarInfo[PI[from_player][pLoadVehicleID]][cID]);

					strmid(CarInfo[PI[from_player][pLoadVehicleID]][cOwner], getName(playerid), 0, strlen(getName(playerid)), MAX_PLAYER_NAME);

					DestroyVehicle(PI[from_player][pLoadVehicleID]);
					ClearVehicleData(PI[from_player][pLoadVehicleID]);

					PI[from_player][pLoadVehicleID] = INVALID_VEHICLE_ID;
					LoadedOwnable--;

					ClearRequest(PI[playerid][pRequestFrom]);
					ClearRequest(playerid);
				}
				else 
				{
					SCM(playerid, COLOR_LIGHTGREY, !"Данный игрок слишком далеко от Вас");
					ClearRequest(PI[playerid][pRequestFrom]);
					ClearRequest(playerid);
				}	
			}
		}
		case 9227:
		{
			if(!PlayerToPoint(50.0, playerid, 1158.0021,2572.6350,1112.4800)) return SendClientMessage(playerid, COLOR_LIGHTGREY, !"Вы должны находится в Мэрии (/gps > Важные места)");
			return 1;
		}
		case 9226:
		{
			if(!response) return 1;	
			if(response) 
			{
				if(!IsPlayerInRangeOfPoint(playerid, 75.0, 2475.3923, -706.9788, 12.3000)) 
					return SCM(playerid, COLOR_GREY, !"Чтобы продать свой транспорт другому игроку, Вам нужно быть на авторыноке.");
				if(!strlen(inputtext)) 
					return ShowSellCar(playerid), SCM(playerid, COLOR_GREY, !"Введите ID игрока и стоимость через запятую.");

				new id, cost;
				if(sscanf(inputtext, "p<,>dd", id, cost)) return ShowSellCar(playerid), SCM(playerid, COLOR_GREY, !"Введите ID игрока и стоимость через запятую.");
				
				if(!IsPlayerConnected(id)) return SCM(playerid, COLOR_GREY, !"Игрок не в сети");
				if(!IsPlayerLogged{id}) return SCM(playerid, COLOR_GREY, !"Игрок не авторизован");

				if(cost > CarInfo[PI[playerid][pLoadVehicleID]][cCost]+CarInfo[PI[playerid][pLoadVehicleID]][cCost]/100*90)
					return ShowSellCar(playerid), SCMf(playerid, COLOR_GREY, "Вы указали слишком большую сумму для продажи, максимальная цена для продажи %d руб", (CarInfo[PI[playerid][pLoadVehicleID]][cCost]/100*90)+CarInfo[PI[playerid][pLoadVehicleID]][cCost]);

				if(cost < (CarInfo[PI[playerid][pLoadVehicleID]][cCost]/100*15))
					return ShowSellCar(playerid), SCMf(playerid, COLOR_GREY, "Вы указали маленькую сумму для продажи, минимальная цена для продажи %d руб", (CarInfo[PI[playerid][pLoadVehicleID]][cCost]/100*15));

				if(!IsPlayerInRangeOfPoint(playerid, 75.0, 2475.3923, -706.9788, 12.3000)) 
							return SCM(playerid, COLOR_GREY, !"Чтобы продать свой транспорт другому игроку, Вам нужно быть на авторыноке.");

				if(!ProxDetectorS(10.0, playerid, id)) 
					return SCM(playerid, COLOR_GREY, !"Данный игрок слишком далеко от Вас");

				if(PI[id][pRequest] == 1) 
					return SCM(playerid, COLOR_GREY, !"У игрока уже есть активное предложение");

				if(PI[id][pLoadVehicleID] != INVALID_VEHICLE_ID) 
					return SCM(playerid, COLOR_GREY, !"У игрока есть загруженный автомобиль");

				if(CarInfo[PI[playerid][pLoadVehicleID]][cPremium] == 1) 
				{
					if(cost+CarInfo[PI[playerid][pLoadVehicleID]][cCost]/100*20 > GetPlayerMoneyID(id)) return SCMf(playerid, COLOR_LIGHTGREY, "У игрока %s недостаточно денег на руках", getName(id));
					
					SendRequestForPlayer(playerid, id, 9, cost, CarInfo[PI[playerid][pLoadVehicleID]][cCost]/100*20);
				}
				else
				{
					SendRequestForPlayer(playerid, id, 9, cost, CarInfo[PI[playerid][pLoadVehicleID]][cCost]/100*20);
				}
				return 1;
			}
		}
        case 7950: 
		{
            if(!response) return 1;
			if(response) 
			{
				if(PI[playerid][pHouse] == INVALID_HOUSE_ID) return SCM(playerid,COLOR_GREY, !"У вас нет дома");
				if(strval(inputtext) <= 0) return SCM(playerid, COLOR_GREY, !"Недопустимое значение");
				new h_class;
				new h = PI[playerid][pHouse];
                h_class = strval(inputtext)*1499;
				if(h_class > GetPlayerMoneyID(playerid)) return SCM(playerid, COLOR_GREY, !"У Вас недостаточно денег на руках");
				if(HOUSE_DATA[h][data_DAY]+strval(inputtext) > 30) return SCM(playerid, COLOR_GREY, !"Нельзя оплатить дом на более 30 суток");
				GivePlayerMoneyLog(playerid,-h_class);
				HOUSE_DATA[h][data_DAY] += strval(inputtext);
				SCMf(playerid,0x138642FF, "{138642}Вы оплатили дом на {f1a88b}%d/30 дней{138642} за {f1a88b}%d руб",HOUSE_DATA[h][data_DAY], h_class);
			}
        }
        case 7952: 
		{
            if(!response) return 1;
			if(response) 
			{
				if(PI[playerid][pBusiness] == INVALID_BUSINESS_ID) return SCM(playerid, COLOR_GREY, !"У вас нет бизнеса");
				if(strval(inputtext) <= 0) return SCM(playerid, COLOR_GREY, !"Недопустимое значение");
				new h_class = strval(inputtext)*3999;
				new b = GetBusinessIndexByID(PI[playerid][pBusiness]);
				if(BizInfo[b][bDays]+strval(inputtext) > 30) return SCM(playerid, COLOR_GREY, !"Нельзя оплатить бизнес на более 30 суток");
				if(h_class > GetPlayerMoneyID(playerid)) return SCM(playerid, COLOR_GREY, !"У Вас недостаточно денег на руках");
				GivePlayerMoneyLog(playerid,-h_class);
				BizInfo[b][bDays] += strval(inputtext);
				SCMf(playerid,0x138642FF, "{138642}Вы оплатили бизнес на {f1a88b}%d/30дней{138642} за {f1a88b}%d руб",BizInfo[b][bDays], h_class);
			}
        }
        case 7951: {
            if(!response) return 1;
			if(response) {
				if(PI[playerid][pFloat] == INVALID_KV_ID) return SCM(playerid, COLOR_GREY, !"У вас нет квартиры");
				if(strval(inputtext) <= 0) return SCM(playerid, COLOR_GREY, !"Недопустимое значение");
				new h_class;
				new kv = PI[playerid][data_PADIK],k = PI[playerid][pFloat];
                h_class = strval(inputtext)*1299;
				if(h_class > GetPlayerMoneyID(playerid)) return SCM(playerid, COLOR_GREY, !"У Вас недостаточно денег на руках");
				if(kvData[kv][kvDays][k]+strval(inputtext) > 30) return SCM(playerid, COLOR_GREY, !"Нельзя оплатить квартиру на более 30 суток");
				GivePlayerMoneyLog(playerid,-h_class);
				kvData[kv][kvDays][k] += strval(inputtext);
				SCMf(playerid,0x138642FF, "{138642}Вы оплатили квартиру на {f1a88b}%d/30 дней{138642} за {f1a88b}%d руб", kvData[kv][kvDays][k], h_class);
			}
        }
		/*case 6002: {
            if(!response) return 1;
			if(response) {
				new textm[2][6];
				split(inputtext, textm, ',');
				new id = strval(textm[0]);
				new cash = strval(textm[1]);
				if(PI[playerid][pLevel] < 2) return SCM(playerid, COLOR_GREY,"Использовать банковскую систему можно только со 2 уровня");
				if(!IsPlayerConnected(id)) {
					SCM(playerid, COLOR_GREY, !"Счёт игрока не найден");
					return ShowPlayerDialog(playerid, dialog_BANK_9, DIALOG_STYLE_INPUT, "{ee3366}Мобильный банк", "{FFFFFF}Введите ID игрока на счёт которого Вы хотите перевести деньги\nи сумму которую желаете перевести. Отделите ID игрока и сумму для перевода запятой.\n\n{FFFF99}Пример: 12, 50000", "Перевести", "Назад");
				}
				if(cash > PI[playerid][pBank] || cash < 1) {
					SCM(playerid, COLOR_GREY, !"У Вас недостаточно средств");
					return ShowPlayerDialog(playerid, dialog_BANK_9, DIALOG_STYLE_INPUT, "{ee3366}Мобильный банк", "{FFFFFF}Введите ID игрока на счёт которого Вы хотите перевести деньги\nи сумму которую желаете перевести. Отделите ID игрока и сумму для перевода запятой.\n\n{FFFF99}Пример: 12, 50000", "Перевести", "Назад");
				}
				if(id == playerid) {
					SCM(playerid, COLOR_GREY, !"Вы не можете перевести деньги на свой счёт");
					return ShowPlayerDialog(playerid, dialog_BANK_9, DIALOG_STYLE_INPUT, "{ee3366}Мобильный банк", "{FFFFFF}Введите ID игрока на счёт которого Вы хотите перевести деньги\nи сумму которую желаете перевести. Отделите ID игрока и сумму для перевода запятой.\n\n{FFFF99}Пример: 12, 50000", "Перевести", "Назад");
				}
				if(cash > 500000) {
					SCM(playerid, COLOR_GREY, !"Вы не можете перевести более 500000 рублей на другой счёт");
					return ShowPlayerDialog(playerid, dialog_BANK_9, DIALOG_STYLE_INPUT, "{ee3366}Мобильный банк", "{FFFFFF}Введите ID игрока на счёт которого Вы хотите перевести деньги\nи сумму которую желаете перевести. Отделите ID игрока и сумму для перевода запятой.\n\n{FFFF99}Пример: 12, 50000", "Перевести", "Назад");
				}
    			if(GetPVarInt(playerid,"Counting_bank") > gettime()) return SCM(playerid, COLOR_GREY, !"Перевод в банке доступен раз в 10 минут");
				PI[playerid][pBank] -= cash;
				PI[id][pBank] += cash;
				PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
				SCMf(playerid, 0x62d44dFF, "[Мобильный Банк] Вы перевели {FFFF99}%d рублей {62d44d}на счёт %s[%d], баланс счёта: {FFFF99}%d рублей", cash, PI[id][pName], id, PI[playerid][pBank]);
				SCMf(id, 0x62d44dFF, "[Мобильный Банк] %s[%d] перевёл на Ваш счёт {FFFF99}%d рублей{62d44d}, баланс счёта: {FFFF99}%d рублей", PI[playerid][pName], playerid, cash, PI[id][pBank]);
				SetPVarInt(playerid,"Counting_bank",gettime() + 600);
				return 1;
			}
        }*/
		case 3898:
		{
			if(!response) return 1;
			if(response)
		    {
				switch(listitem)
		        {
		        	case 0:
			        {
			    	    new Float:health;
						GetPlayerHealth(playerid, health);
						if(health > 100) return SCM(playerid, COLOR_GREY, !"Вы не нуждаетесь в питании");
						cef_emit_event(playerid, "show-notify-right-text", CEFINT(4), CEFSTR("Вы поели"), CEFSTR("487f5f"), CEFSTR("+30 HP"));
						SetPlayerHealthAC(playerid, health+30);
		        	}
		        	case 1:
			        {
			    	    new Float:health;
						GetPlayerHealth(playerid, health);
						if(health > 100) return SCM(playerid, COLOR_GREY, !"Вы не нуждаетесь в питании");
						cef_emit_event(playerid, "show-notify-right-text", CEFINT(4), CEFSTR("Вы поели"), CEFSTR("487f5f"), CEFSTR("+30 HP"));
						SetPlayerHealthAC(playerid, health+30);
		        	}
		        	case 2:
			        {
			    	    new Float:health;
						GetPlayerHealth(playerid, health);
						if(health > 100) return SCM(playerid, COLOR_GREY, !"Вы не нуждаетесь в питании");
						cef_emit_event(playerid, "show-notify-right-text", CEFINT(4), CEFSTR("Вы поели"), CEFSTR("487f5f"), CEFSTR("+30 HP"));
						SetPlayerHealthAC(playerid, health+30);
		        	}
				}
		 	}
		}
		case 3456:
		{
		    if(!response) return 1;
			if(response)
   			{
				SendAdminsMessagef(COLOR_GREY, "[Warning] %s[%d] взял из общей казны 5000 рублей.", PI[playerid][pName], playerid);
                GivePlayerMoneyLog(playerid, 5000);

				SetPVarInt(playerid, "Counting_Treasury", gettime() + 300);
		    }
		}
		case 9189: 
		{
		    if(!response) return 1;
			if(response) 
			{
				if(MineOreStock < strval(inputtext)) return SCM(playerid, COLOR_GREY, !"На складе шахты недостаточно металла");

				if(PI[playerid][pVIP] > 0) 
				{
					if(strval(inputtext) > 80 || strval(inputtext) < 1) return SCM(playerid, COLOR_GREY, !"Вы можете купить от 1 до 80 кг металла");
					if(strval(inputtext)+PI[playerid][pMetall] > 80) return SCMf(playerid, COLOR_GREY, "Вы можете носить с собой не более 80 кг металла. У Вас: %d кг", PI[playerid][pMetall]);
				}
				else
				{
					if(strval(inputtext) > 40 || strval(inputtext) < 1) return SCM(playerid, COLOR_GREY, !"Вы можете купить от 1 до 40 кг металла");
					if(strval(inputtext)+PI[playerid][pMetall] > 40) return SCMf(playerid, COLOR_GREY, "Вы можете носить с собой не более 40 кг металла. У Вас: %d кг", PI[playerid][pMetall]);
				}
				if(GetPlayerMoneyID(playerid) < strval(inputtext)*30) return SCM(playerid, COLOR_GREY, !"У Вас не хватает денег");

				new money = strval(inputtext)*30;
				GivePlayerMoneyLog(playerid, -money);

				cef_text[0] = EOS, format(cef_text, 10, "-%d руб", money);
				SendPlayerRadarNotify(playerid, 9, "red", "Покупка металла", cef_text, 5);

				PI[playerid][pMetall] += strval(inputtext);
   			}
		}
		case 5413:
		{
		    if(!response) return 1;
		    if(response)
		    {
				if(GetPlayerMoneyID(playerid) < 750) return SCM(playerid, COLOR_GREY,"У Вас не хватает денег");
				SCM(playerid, 0x33dd66FF, "Вы оформили медицинскую справку за 750 руб");
				PI[playerid][pMedCard] = 1;
				GivePlayerMoneyLog(playerid, -750);
				if(PI[playerid][data_MEDNUM] == 0) PI[playerid][data_MEDNUM] = RandomEX(1111111, 6666666);
		    }
		}
		case 5414:
		{
		    if(!response) return 1;
			if(response)
   			{
				if(PI[playerid][pVIP] > 0) 
				{
					if(strval(inputtext) > 80 || strval(inputtext) < 1) return SCM(playerid, COLOR_GREY, !"Вы можете купить от 1 до 2000 единиц веществ");
					if(strval(inputtext)+PI[playerid][pDrugs] > 2000) return SCMf(playerid, COLOR_GREY, "Вы можете носить с собой не более 2000 единиц веществ. У Вас: %d кг", PI[playerid][pMetall]);
				}
				else
				{
					if(strval(inputtext) > 40 || strval(inputtext) < 1) return SCM(playerid, COLOR_GREY, !"Вы можете купить от 1 до 1000 единиц веществ");
					if(strval(inputtext)+PI[playerid][pDrugs] > 1000) return SCMf(playerid, COLOR_GREY, "Вы можете носить с собой не более 1000 единиц веществ. У Вас: %d кг", PI[playerid][pMetall]);
				}
				if(GetPlayerMoneyID(playerid) < strval(inputtext)*50) return SCM(playerid, COLOR_GREY, !"У Вас не хватает денег");

				new money = strval(inputtext)*50;
				GivePlayerMoneyLog(playerid, -money);

				cef_text[0] = EOS, format(cef_text, 10, "-%d руб", money);
				SendPlayerRadarNotify(playerid, 9, "red", "Покупка веществ", cef_text, 5);

				PI[playerid][pDrugs] += strval(inputtext);
   			}
		}
		case 7621:
		{
			if(army_wh[2] == 0) return SendClientMessage(playerid, COLOR_GREY, !"Склад организации 'Воинская часть' закрыт игровым мастером");
			switch(listitem)
   			{
   			    case 0: 
				{
   			        GiveWeapon(playerid, 6, 1);
					SendFractionMessagef(PI[playerid][pMember],0x99ccccFF, "[R] %s %s[%d] взял Лопату со склада (-1 кг металла, -1 шт патронов)",rang_army[PI[playerid][pRang]-1][frName],PI[playerid][pName],playerid);
                    army_wh[0] -=1;
                    army_wh[1] -=1;
   			    }
   			    case 1: 
				{
					SendFractionMessagef(PI[playerid][pMember],0x99ccccFF, "[R] %s %s[%d] взял Бронижелет со склада (-10 кг металла)",rang_army[PI[playerid][pRang]-1][frName],PI[playerid][pName],playerid);
					SetPlayerArmourAC(playerid, 100);
					army_wh[0] -=10;
   			    }
   			    case 2: 
				{
   			        GiveWeapon(playerid, 24, 35);
					SendFractionMessagef(PI[playerid][pMember],0x99ccccFF, "[R] %s %s[%d] взял ПЛ-15 со склада (-6 кг металла, -35 шт патронов)",rang_army[PI[playerid][pRang]-1][frName],PI[playerid][pName],playerid);
				    army_wh[0] -=6;
                    army_wh[1] -=35;
   			    }
   			    case 3:
				{
   			        GiveWeapon(playerid, 29, 90);
					SendFractionMessagef(PI[playerid][pMember],0x99ccccFF,"[R] %s %s[%d] взял AKC-74Y со склада (-8 кг металла, -90 шт патронов)",rang_army[PI[playerid][pRang]-1][frName],PI[playerid][pName],playerid);
					army_wh[0] -=8;
                    army_wh[1] -=90;
   			    }
   			    case 4:
				{
                    if(PI[playerid][pRang] < 2) return SCM(playerid, COLOR_GREY,"'АК-47' доступен с 2 ранга");
   			        GiveWeapon(playerid, 30, 90);
					SendFractionMessagef(PI[playerid][pMember],0x99ccccFF, "[R] %s %s[%d] взял AK-47 со склада (-9 кг металла, -90 шт патронов)",rang_army[PI[playerid][pRang]-1][frName],PI[playerid][pName],playerid);
					army_wh[0] -=9;
                    army_wh[1] -=90;
   			    }
   			    case 5: 
				{
   			        if(PI[playerid][pRang] < 3) return SCM(playerid, COLOR_GREY,"'Country Rifle' доступна с 3 ранга");
   			        GiveWeapon(playerid, 33, 10);
					SendFractionMessagef(PI[playerid][pMember],0x99ccccFF, "[R] %s %s[%d] взял Country Rifle со склада (-10 кг металла, -10 шт патронов)",rang_army[PI[playerid][pRang]-1][frName],PI[playerid][pName],playerid);
					army_wh[0] -=10;
                    army_wh[1] -=10;
   			    }
   			}
			global_str[0] = EOS, f(global_str, 100, "{f18c2b}Армейский склад\n\n{FFFFFF}Металл: %d кг.\n{fccf39}Патроны: %d шт.", army_wh[0], army_wh[1]);
			UpdateDynamic3DTextLabelText(army_sklad_text, -1, global_str);
			SaveWarehouse();
		}
		case 7622:
		{
			switch(listitem)
   			{
   			    case 0: 
				{
					ShowPlayerDialogf(playerid, 5981, DIALOG_STYLE_INPUT, !"{ee3366}Взять аптечки", !"Взять", !"Закрыть", "\
						{FFFFFF}Введите количество аптечек, которое Вы хотите взять:\n\
						{FFFF99}Подсказка: у Вас есть %d / 3 шт аптечек.\n\n\
						{3366cc}Вы можете взять не более 6 шт аптечек в час", PI[playerid][pHealPack]);
   			    }
   			    case 1: 
				{
					ShowPlayerDialog(playerid, 5980, DIALOG_STYLE_TABLIST_HEADERS, !"{ee3366}Оружейный склад", "\
					Оружие\tНужный ранг\tПатроны\n\
					{FFFFFF}Полицейская дубинка\t\t1+\t\t1\n\
					Полицейский жезл\t\t1+\t\t1\n\
					Бронежилет\t2+\t\t-\n\
					Балончик с краской\t\t2+\t\t500\n\
					ПЛ-15\t\t2+\t\t70\n\
					Тайзер\t\t7+\t\t70\n\
					АКС-74У\t\t3+\t\t180\n\
					АК-47\t\t5+\t\t180\n\
					Снайперская винтовка\t5+\t\t20", !"Взять", !"Закрыть");
   			    }
   			}
		}
		case 5981: 
		{
			if(PI[playerid][pHealPack] == 3) return SCM(playerid, COLOR_GREY, !"Вы не можете взять более 3-х аптечек");
			if(PI[playerid][pHealthPackKD] == 3) return SCM(playerid, COLOR_GREY, !"Вы можете взять более 3-х аптечек за час");
			if(strval(inputtext) > 3) return SCM(playerid, COLOR_GREY, !"Нельзя взять более 3-х аптечек");
			if(strval(inputtext)+PI[playerid][pHealthPackKD] > 3) return SCM(playerid, COLOR_GREY, !"Вы не можете взять такое количество аптечек");
			PI[playerid][pHealPack] += strval(inputtext);
			PI[playerid][pHealthPackKD] += strval(inputtext);
			UpdatePlayerDataInt(playerid, "HEALPACKSKLAD", PI[playerid][pHealthPackKD]);
			SendFractionMessagef(PI[playerid][pMember],0x99ccccFF, "[R] %s %s[%d] взял %d аптечек со склада",rang_police[PI[playerid][pRang]-1][frName],PI[playerid][pName],playerid, strval(inputtext));
		}
		case 5980: 
		{
			if(!response) return 1;
			if(response)
   			{
				switch(listitem) 
				{
					case 0: 
					{
						GiveWeapon(playerid, 3, 1);
						SendFractionMessagef(PI[playerid][pMember],0x99ccccFF, "[R] %s %s[%d] взял полицейскую дубинку со склада",rang_police[PI[playerid][pRang]-1][frName],PI[playerid][pName],playerid);
					}
					case 1: 
					{
						GiveWeapon(playerid, 12, 1);
						SendFractionMessagef(PI[playerid][pMember],0x99ccccFF, "[R] %s %s[%d] взял полицейский жезл со склада",rang_police[PI[playerid][pRang]-1][frName],PI[playerid][pName],playerid);
					}
					case 2: 
					{					
						if(PI[playerid][pRang] < 2) return SCM(playerid, COLOR_GREY, !"Бронежилет доступен со 2 ранга");
						SetPlayerArmourAC(playerid, 100);
						SendFractionMessagef(PI[playerid][pMember],0x99ccccFF, "[R] %s %s[%d] взял бронежелет со склада",rang_police[PI[playerid][pRang]-1][frName],PI[playerid][pName],playerid);
					}
					case 3: 
					{
						if(PI[playerid][pRang] < 2) return SCM(playerid, COLOR_GREY, !"Балончик с краской доступен со 2 ранга");
						GiveWeapon(playerid, 41, 500);
						SendFractionMessagef(PI[playerid][pMember],0x99ccccFF, "[R] %s %s[%d] взял балончик с краской со склада",rang_police[PI[playerid][pRang]-1][frName],PI[playerid][pName],playerid);
					}
					case 4: 
					{
						if(PI[playerid][pRang] < 2) return SCM(playerid, COLOR_GREY, !"ПЛ-15 доступен со 2 ранга");
						GiveWeapon(playerid, 24, 70);
						SendFractionMessagef(PI[playerid][pMember],0x99ccccFF, "[R] %s %s[%d] взял ПЛ-15 со склада",rang_police[PI[playerid][pRang]-1][frName],PI[playerid][pName],playerid);
					}
					case 5: 
					{
						if(PI[playerid][pRang] < 2) return SCM(playerid, COLOR_GREY, !"Тайзер доступен с 2 ранга");
						GiveWeapon(playerid, 23, 70);
						SendFractionMessagef(PI[playerid][pMember],0x99ccccFF, "[R] %s %s[%d] взял Тайзер",rang_police[PI[playerid][pRang]-1][frName],PI[playerid][pName],playerid);
					}
					case 6: 
					{
						if(PI[playerid][pRang] < 3) return SCM(playerid, COLOR_GREY,"АКС-74У доступен с 3 ранга");
						GiveWeapon(playerid, 29, 180);
						SendFractionMessagef(PI[playerid][pMember],0x99ccccFF, "[R] %s %s[%d] взял АКС-74У со склада",rang_police[PI[playerid][pRang]-1][frName],PI[playerid][pName],playerid);
					}
					case 7: 
					{
						if(PI[playerid][pRang] < 5) return SCM(playerid, COLOR_GREY,"АК-47 с 5 ранга");
						GiveWeapon(playerid, 30, 180);
						SendFractionMessagef(PI[playerid][pMember],0x99ccccFF, "[R] %s %s[%d] взял АК-47 со склада",rang_police[PI[playerid][pRang]-1][frName],PI[playerid][pName],playerid);
					}
					case 8: 
					{
						if(PI[playerid][pRang] < 5) return SCM(playerid, COLOR_GREY,"Снайперская винтовка доступна с 5 ранга");
						GiveWeapon(playerid, 34, 20);
						SendFractionMessagef(PI[playerid][pMember],0x99ccccFF, "[R] %s %s[%d] взял снайперскую винтовку со склада",rang_police[PI[playerid][pRang]-1][frName],PI[playerid][pName],playerid);
					}
				}
				ShowPoliceStorage(playerid);
			}
		}
		case 4980:
		{
			switch(listitem)
   			{

   			    case 0:
   			    {
                    if(PI[playerid][pRang] < 2) return SCM(playerid, COLOR_GREY,"Бронежилет доступен со 2 ранга");
   			        SetPlayerArmourAC(playerid, 100);
   			    }
   			    case 1:
   			    {
   			        GiveWeapon(playerid, 3, 1);
   			    }
   			    case 2:
   			    {
   			        GiveWeapon(playerid, 41, 300);
   			    }
   			    case 3:
   			    {
                    if(PI[playerid][pRang] < 2) return SCM(playerid, COLOR_GREY,"ПЛ-15 доступен со 2 ранга");
   			        GiveWeapon(playerid, 24, 65);
   			    }
   			    case 4:
   			    {
                    if(PI[playerid][pRang] < 3) return SCM(playerid, COLOR_GREY,"АКС-74У доступен с 3 ранга");
   			        GiveWeapon(playerid, 29, 90);
   			    }
   			    case 5:
   			    {
                    if(PI[playerid][pRang] < 4) return SCM(playerid, COLOR_GREY,"АК-47 доступен с 4 ранга");
   			        GiveWeapon(playerid, 30, 90);
   			    }
   			    case 6:
   			    {
                    if(PI[playerid][pRang] < 5) return SCM(playerid, COLOR_GREY,"Снайперская винтовка доступна с 5 ранга");
   			        GiveWeapon(playerid, 34, 20);
   			    }
   			}
		}
		case dialog_GIVEGUNPRAVO:
		{
			switch(listitem)
   			{
   			    case 0:
   			    {
                    if(PI[playerid][pRang] < 2) return SCM(playerid, COLOR_GREY,"ПЛ-15 доступен с 3 ранга");
   			        GiveWeapon(playerid, 24, 45);
   			    }
   			    case 1:
   			    {
   			        if(PI[playerid][pRang] < 2) return SCM(playerid, COLOR_GREY,"Тайзер доступен с 2 ранга");
   			        GiveWeapon(playerid, 23, 45);
   			    }
   			    case 2:
   			    {
   			        if(PI[playerid][pRang] < 2) return SCM(playerid, COLOR_GREY,"АКС-74У");
   			        GiveWeapon(playerid, 29, 90);
   			    }
   			}
		}
		case dialog_schoolinfo: {
		    if(!response) return 1;
			if(response) return 1;
		}
		case dialog_schoolclose: if(response || !response) return PI[playerid][pSchoolTestLvl] = 0;
		case dialog_schooltest: {
  			if(!response) return 1;
            if(response) return ShowPlayerDialog(playerid, dialog_schooltest1, DIALOG_STYLE_LIST, "{ee3366}Максимальная скорость в населенных пунктах", "1. 90 км час\n2. 60 км час\n3. 30 км час", "Выбрать", "");
		}
		case dialog_schooltest1: {
  			if(response || !response) {
				switch(listitem) {
		        	case 0: return ShowPlayerDialog(playerid, dialog_schooltest2, DIALOG_STYLE_LIST, "{ee3366}Когда разрешен обгон?", "1. Если обгоняемое ТС не мешает обзору и его скорость не больше 100 км час\n2. Если ТС не едем слишком медленно\n3. Если ТС не мешает проезду", "Выбрать", "");
	       			case 1: {
	   					PI[playerid][pSchoolTestLvl] += 1;
						return ShowPlayerDialog(playerid, dialog_schooltest2, DIALOG_STYLE_LIST, "{ee3366}Когда разрешен обгон?", "1. Если обгоняемое ТС не мешает обзору и его скорость не больше 100 км час\n2. Если ТС не едем слишком медленно\n3. Если ТС не мешает проезду", "Выбрать", "");
		       		}
		        	case 2: return ShowPlayerDialog(playerid, dialog_schooltest2, DIALOG_STYLE_LIST, "{ee3366}Когда разрешен обгон?", "1. Если обгоняемое ТС не мешает обзору и его скорость не больше 100 км час\n2. Если ТС не едем слишком медленно\n3. Если ТС не мешает проезду", "Выбрать", "");
				}
			}
		}
		case dialog_schooltest2: {
		    if(response || !response) {
	   			switch(listitem) {
	        		case 0: {
	        			PI[playerid][pSchoolTestLvl] += 1;
						return ShowPlayerDialog(playerid, dialog_schooltest3, DIALOG_STYLE_LIST, "{ee3366}Действия при остановке Вас инспектором", "1. Уеду забыв, что это было\n2. Спрошу его удостоверение и дам свои права\n3. Спрячусь и сделаю вид, что я не был за рулем", "Выбрать", "");
	        		}
	        		case 1: return ShowPlayerDialog(playerid, dialog_schooltest3, DIALOG_STYLE_LIST, "{ee3366}Действия при остановке Вас инспектором", "1. Уеду забыв, что это было\n2. Спрошу его удостоверение и дам свои права\n3. Спрячусь и сделаю вид, что я не был за рулем", "Выбрать", "");
	        		case 2: return ShowPlayerDialog(playerid, dialog_schooltest3, DIALOG_STYLE_LIST, "{ee3366}Действия при остановке Вас инспектором", "1. Уеду забыв, что это было\n2. Спрошу его удостоверение и дам свои права\n3. Спрячусь и сделаю вид, что я не был за рулем", "Выбрать", "");
				}
	    	}
		}
		case dialog_schooltest3: {
		    if(response || !response) {
	   			switch(listitem) {
	        		case 0: return ShowPlayerDialog(playerid, dialog_schooltest4, DIALOG_STYLE_LIST, "{ee3366}Разрешено ли водителю ехать будучи не трезвым", "1. Да\n2. Нет\n3.Нет правильного ответа", "Выбрать", "");
				    case 1: {
	    				PI[playerid][pSchoolTestLvl] += 1;
						return ShowPlayerDialog(playerid, dialog_schooltest4, DIALOG_STYLE_LIST, "{ee3366}Разрешено ли водителю ехать будучи не трезвым", "1. Да\n2. Нет\n3.Нет правильного ответа", "Выбрать", "");
	    			}
	   	 			case 2: return ShowPlayerDialog(playerid, dialog_schooltest4, DIALOG_STYLE_LIST, "{ee3366}Разрешено ли водителю ехать будучи не трезвым", "1. Да\n2. Нет\n3.Нет правильного ответа", "Выбрать", "");
				}
			}
		}
		case dialog_schooltest4: 
		{
			if(response || !response) 
			{
	   			switch(listitem) 
				{
	        		case 0: 
					{
						if(PI[playerid][pSchoolTestLvl] > 2) 
						{
							SendPlayerCenterNotify(playerid, 5, "Вы сдали на водительские права", 5);
							if(PI[playerid][pLicNumber] == 0) PI[playerid][pLicNumber] = RandomEX(1111111, 6666666);
							PI[playerid][pDriveLicense] = 1;
							return ShowPlayerDialogf(playerid, dialog_schoolclose, DIALOG_STYLE_MSGBOX, !"{ee3366}Автошкола", !"Закрыть", !"", "Вы успешно закончили проходить тест сдачи на водительские права, ваш результат: %d/4\nВы  успешно сдали на права,поздравляем.", PI[playerid][pSchoolTestLvl]);
						}
						if(PI[playerid][pSchoolTestLvl] < 2) 
						{
							SendPlayerCenterNotify(playerid, 2, "Вы не сдали на водительские права", 5);
							return ShowPlayerDialogf(playerid, dialog_schoolclose, DIALOG_STYLE_MSGBOX, !"{ee3366}Автошкола", !"Закрыть", !"", "Вы закончили проходить тест сдачи на водительские права, ваш результат: %d/4\nУвы, но вы не сдали на права.", PI[playerid][pSchoolTestLvl]);
						}
					}
					case 1: 
					{
						PI[playerid][pSchoolTestLvl] += 1;
						if(PI[playerid][pSchoolTestLvl] > 2) 
						{
							SendPlayerCenterNotify(playerid, 5, "Вы сдали на водительские права", 5);
							PI[playerid][pDriveLicense] = 1;
							if(PI[playerid][pLicNumber] == 0) PI[playerid][pLicNumber] = RandomEX(1111111, 6666666);
							return ShowPlayerDialogf(playerid, dialog_schoolclose, DIALOG_STYLE_MSGBOX, !"{ee3366}Автошкола", !"Закрыть", !"", "Вы успешно закончили проходить тест сдачи на водительские права, ваш результат: %d/4\nВы  успешно сдали на права,поздравляем.", PI[playerid][pSchoolTestLvl]);
						}
						if(PI[playerid][pSchoolTestLvl] < 2) 
						{
							SendPlayerCenterNotify(playerid, 2, "Вы не сдали на водительские права", 5);
							return ShowPlayerDialogf(playerid, dialog_schoolclose, DIALOG_STYLE_MSGBOX, !"{ee3366}Автошкола", !"Закрыть", !"", "Вы закончили проходить тест сдачи на водительские права, ваш результат: %d/4\nУвы, но вы не сдали  на права.", PI[playerid][pSchoolTestLvl]);
						}
					}
	      			case 2: 
					{
						if(PI[playerid][pSchoolTestLvl] > 2) 
						{
							SendPlayerCenterNotify(playerid, 5, "Вы сдали на водительские права", 5);
							if(PI[playerid][pLicNumber] == 0) PI[playerid][pLicNumber] = RandomEX(1111111, 6666666);
							PI[playerid][pDriveLicense] = 1;
							return ShowPlayerDialogf(playerid, dialog_schoolclose, DIALOG_STYLE_MSGBOX, !"{ee3366}Автошкола", !"Закрыть", !"", "Вы успешно закончили проходить тест сдачи на водительские права, ваш результат: %d/4\nВы  успешно сдали на права,поздравляем.", PI[playerid][pSchoolTestLvl]);
						}
						if(PI[playerid][pSchoolTestLvl] < 2) 
						{
							SendPlayerCenterNotify(playerid, 2, "Вы не сдали на водительские права", 5);
							return ShowPlayerDialogf(playerid, dialog_schoolclose, DIALOG_STYLE_MSGBOX, !"{ee3366}Автошкола", !"Закрыть", !"", "Вы закончили проходить тест сдачи на водительские права, ваш результат: %d/4\nУвы, но вы не сдали  на права.", PI[playerid][pSchoolTestLvl]);
						}
	      			}
				}
	    	}
		}
		case dialog_dalnoboy:
		{
		    if(!response) return 1;
		    if(response)
		    {
		        if(GetPVarInt(playerid,"Counting_Dalnoboy") > gettime()) return SCM(playerid, COLOR_GREY, !"Начинать работу дальнобойщика можно раз в 2 минуты");
		    	
				PI[playerid][pTempJob] = 1;
				PI[playerid][pStartJob] = 9;
		        SCM(playerid, COLOR_YELLOW, !"Отвезите продукты на предприятие. Оно отмечено на карте красной меткой");
				SCM(playerid, COLOR_YELLOW, !"Чтобы завершить работу, покиньте транспорт, после чего работа завершиться автоматически");
				SCM(playerid, COLOR_YELLOW, !"Так-же Вам была выдана рация на момент работы, используйте:{3377cc} /j");

				dalnoboy_car[playerid] = CreateVehicle(514,-643.8362,-2032.3152,41.3401,0,8,8,-1);
				dalnoboy_trayler[playerid] = CreateVehicle(435,-643.5872,-2013.6486,40.9900,0,1,1,-1);
			    CarInfo[dalnoboy_car[playerid]][cFuel] = 150;
			    CarInfo[dalnoboy_car[playerid]][cCreate] = 1;

      			switch(random(5))
      			{
      			    case 0: SetPlayerRaceCheckpoint(playerid, 1, -2351.3767,258.0399,23.6756, -2351.3767,258.0399,23.6756, 10);
      			    case 1: SetPlayerRaceCheckpoint(playerid, 1, 2978.3062,-720.5325,12.7500, 2978.3062,-720.5325,12.7500, 10);
      			    case 2: SetPlayerRaceCheckpoint(playerid, 1, 2325.0569,-264.0050,1.6073, 2325.0569,-264.0050,1.6073, 10);
      			    case 3: SetPlayerRaceCheckpoint(playerid, 1, 1976.2108,1652.2156,15.9200, 1976.2108,1652.2156,15.9200, 10);
      			    case 4: SetPlayerRaceCheckpoint(playerid, 1, -442.7106,-1575.0638,40.9470, -442.7106,-1575.0638,40.9470, 10);
      			}
				dalnaboy_check_pricep[playerid] = SetTimerEx("CheckDalnaboyPricep", 1000, true, "i", playerid);

			    PutPlayerInVehicleAC(playerid, dalnoboy_car[playerid], 0);
			    AttachTrailerToVehicle(dalnoboy_trayler[playerid], dalnoboy_car[playerid]);
			    DisableRemoteVehicleCollisions(playerid, 1);

			    SetPVarInt(playerid, "Counting_Dalnoboy", gettime() + 120);
		    }
		}
		case dialog_ENTER_HOUSE: 
		{
            if(!response) return 1;
            if(response) 
			{
                new h = GetPVarInt(playerid, "house");
                if(!PlayerToPoint(1.5, playerid, HOUSE_DATA[h][data_ENTERX], HOUSE_DATA[h][data_ENTERY], HOUSE_DATA[h][data_ENTERZ])) return 1;
                if(HOUSE_DATA[h][data_LOCK] == 0 || !strcmp(PI[playerid][pName],HOUSE_DATA[h][data_OWNER], true)) 
				{
	                SetPlayerPosAC(playerid,1113.0996,1528.0840,905.8000);
	                SetPlayerFacingAngle(playerid, 357.8026);
	                SetPlayerInterior(playerid, HOUSE_DATA[h][data_INT]+1);
	                SetPlayerVirtualWorld(playerid, HOUSE_DATA[h][data_ID]);
	                Freeze(playerid);
	            }
	            else SendPlayerCenterNotify(playerid, 2, "Этот дом закрыт", 5);
            }
        }
        case dialog_EXIT_HOUSE: 
		{
            if(!response) return 1;
            if(response) 
			{
                new h = GetPVarInt(playerid, "house");
                if(!PlayerToPoint(1.5, playerid, HOUSE_DATA[h][data_EXITX], HOUSE_DATA[h][data_EXITY], HOUSE_DATA[h][data_EXITZ])) return 1;
				SetPlayerPosAC(playerid,HOUSE_DATA[h][data_CARX],HOUSE_DATA[h][data_CARY],HOUSE_DATA[h][data_CARZ]);
 				SetPlayerFacingAngle(playerid,HOUSE_DATA[h][data_CARANGLE]);
 				SetCameraBehindPlayer(playerid);
	            SetPlayerInterior(playerid,0);
	            SetPlayerVirtualWorld(playerid,0);
            }
        }
		case dialog_SKLAD: 
		{
		    if(!response) return 1;
		    if(response) 
			{
		        switch(listitem) 
				{
		            case 0: 
					{
		                if(PI[playerid][pRang] < 5) return SCM(playerid, COLOR_GREY, !"Склад организации доступен с 5 ранга");
		                ShowPlayerDialog(playerid, dialog_SKLAD_1, DIALOG_STYLE_INPUT, "{ee3366}Взять металл", !"Введите количество единиц,\nкоторое Вы хотите взять со склада", "Взять", "Отмена");
		            }
		            case 1: 
					{
		                if(PI[playerid][pRang] < 5) return SCM(playerid, COLOR_GREY, !"Склад организации доступен с 5 ранга");
		                ShowPlayerDialog(playerid, dialog_SKLAD_3, DIALOG_STYLE_INPUT, !"{ee3366}Взять патроны", !"Введите количество единиц,\nкоторое Вы хотите взять со склада", "Взять", "Отмена");
		            }
		            case 2: 
					{
		                if(PI[playerid][pRang] < 5) return SCM(playerid, COLOR_GREY, !"Склад организации доступен с 5 ранга");
		                ShowPlayerDialog(playerid, dialog_SKLAD_5, DIALOG_STYLE_INPUT, !"{ee3366}Взять вещества", !"Введите количество единиц,\nкоторое Вы хотите взять со склада", "Взять", "Отмена");
		            }
		            case 3: ShowPlayerDialog(playerid, dialog_SKLAD_2, DIALOG_STYLE_INPUT, !"{ee3366}Положить металл", !"Введите количество единиц,\nкоторое Вы хотите положить на склада", "Положить", "Отмена");
		            case 4: ShowPlayerDialog(playerid, dialog_SKLAD_4, DIALOG_STYLE_INPUT, !"{ee3366}Положить патроны", !"Введите количество единиц,\nкоторое Вы хотите положить на склада", "Положить", "Отмена");
		            case 5: ShowPlayerDialog(playerid, dialog_SKLAD_6, DIALOG_STYLE_INPUT, !"{ee3366}Положить вещества", !"Введите количество единиц,\nкоторое Вы хотите положить на склада", "Положить", "Отмена");
		        }
		    }
		}
		case dialog_SKLAD_1:
		{
		    if(!response) return 1;
			if(response)
   			{
   			    if(PI[playerid][pRang] < 5) return SCM(playerid, COLOR_GREY,"Склад организации доступен с 5 ранга");
				if(PI[playerid][pMember] == 5 && skinhead_wh[3] != 0 || PI[playerid][pMember] == 6 && gopota_wh[3] != 0 || PI[playerid][pMember] == 7 && kavkaz_wh[3]) return SCM(playerid, COLOR_GREY,"Склад закрыт лидером или заместителем ОПГ");
				
				new gz;
				for(new i = 0; i < totalgz; i++) if(gz_info[i][gzopg] == PI[playerid][pMember]) gz++;

				switch(PI[playerid][pMember])
				{
					case 5:
					{
					    if(strval(inputtext) < 1) return SCM(playerid, COLOR_GREY,"Недопустимое значение");
						if(PI[playerid][pVIP] == 0) if(strval(inputtext)+PI[playerid][pMetall] > 40) return SCM(playerid, COLOR_GREY,"В инвентаре можно иметь максимум 40 кг металла");
						if(PI[playerid][pVIP] > 0) if(strval(inputtext)+PI[playerid][pMetall] > 80) return SCM(playerid, COLOR_GREY,"В инвентаре можно иметь максимум 80 кг металла");
						if(strval(inputtext) > 80) return SCM(playerid, COLOR_GREY,"Нельзя взять за 1 раз больше 80 металла");
						if(skinhead_wh[0] < strval(inputtext)) return SCM(playerid, COLOR_GREY,"На складе организации недостаточно металла");
						PI[playerid][pMetall] += strval(inputtext);
						skinhead_wh[0] -= strval(inputtext)+PI[playerid][pMetall];
						SendFractionMessagef(PI[playerid][pMember],0x67ab00FF, "[R] %s %s[%d] взял %d металла со склада",rang_skinhead[PI[playerid][pRang]-1][frName],PI[playerid][pName],playerid,strval(inputtext));
						global_str[0] = EOS, format(global_str, 225, "Склад\n{cc6666}Скинхеды\n{FFFFFF}Территорий: {ffcc33}%d шт\n{FFFFFF}Металл: {ffcc33}%d / 6000 шт.\n{FFFFFF}Патроны: {ffcc33}%d / 50000 шт.\n{FFFFFF}Вещества: {ffcc33}%d / 12000 шт.",gz,skinhead_wh[0],skinhead_wh[1],skinhead_wh[2]);
                        UpdateDynamic3DTextLabelText(skinhead_sklad_text, -1, global_str);
                        SaveWarehouse();
					}
					case 6:
					{
					    if(strval(inputtext) < 1) return SCM(playerid, COLOR_GREY,"Недопустимое значение");
						if(PI[playerid][pVIP] == 0) if(strval(inputtext)+PI[playerid][pMetall] > 40) return SCM(playerid, COLOR_GREY,"В инвентаре можно иметь максимум 40 кг металла");
						if(PI[playerid][pVIP] > 0) if(strval(inputtext)+PI[playerid][pMetall] > 80) return SCM(playerid, COLOR_GREY,"В инвентаре можно иметь максимум 80 кг металла");
						if(strval(inputtext) > 80) return SCM(playerid, COLOR_GREY,"Нельзя взять за 1 раз больше 80 металла");
						if(gopota_wh[0] < strval(inputtext)) return SCM(playerid, COLOR_GREY,"На складе организации недостаточно металла");
						PI[playerid][pMetall] += strval(inputtext);
						gopota_wh[0] -= strval(inputtext);
						SendFractionMessagef(PI[playerid][pMember],0x67ab00FF, "[R] %s %s[%d] взял %d металла со склада",rang_gopota[PI[playerid][pRang]-1][frName],PI[playerid][pName],playerid,strval(inputtext));
						global_str[0] = EOS, format(global_str, 225, "Склад\n{cc6666}Гопота\n{FFFFFF}Территорий: {ffcc33}%d шт\n{FFFFFF}Металл: {ffcc33}%d / 6000 шт.\n{FFFFFF}Патроны: {ffcc33}%d / 50000 шт.\n{FFFFFF}Вещества: {ffcc33}%d / 12000 шт.",gz,gopota_wh[0],gopota_wh[1],gopota_wh[2]);
					    UpdateDynamic3DTextLabelText(gopota_sklad_text, -1, global_str);
					    SaveWarehouse();
					}
					case 7:
					{
						if(strval(inputtext) < 1) return SCM(playerid, COLOR_GREY,"Недопустимое значение");
						if(PI[playerid][pVIP] == 0) if(strval(inputtext)+PI[playerid][pMetall] > 40) return SCM(playerid, COLOR_GREY,"В инвентаре можно иметь максимум 40 кг металла");
						if(PI[playerid][pVIP] > 0) if(strval(inputtext)+PI[playerid][pMetall] > 80) return SCM(playerid, COLOR_GREY,"В инвентаре можно иметь максимум 80 кг металла");
						if(strval(inputtext) > 80) return SCM(playerid, COLOR_GREY,"Нельзя взять за 1 раз больше 80 металла");
					    if(kavkaz_wh[0] < strval(inputtext)) return SCM(playerid, COLOR_GREY,"На складе организации недостаточно металла");
						PI[playerid][pMetall] += strval(inputtext);
						kavkaz_wh[0] -= strval(inputtext);
						SendFractionMessagef(PI[playerid][pMember],0x67ab00FF, "[R] %s %s[%d] взял %d металла со склада", rang_kavkaz[PI[playerid][pRang]-1][frName],PI[playerid][pName],playerid,strval(inputtext));
						global_str[0] = EOS, format(global_str, 225, "Склад\n{cc6666}Кавказцы\n{FFFFFF}Территорий: {ffcc33}%d шт\n{FFFFFF}Металл: {ffcc33}%d / 6000 шт.\n{FFFFFF}Патроны: {ffcc33}%d / 50000 шт.\n{FFFFFF}Вещества: {ffcc33}%d / 12000 шт.",gz,kavkaz_wh[0],kavkaz_wh[1],kavkaz_wh[2]);
						UpdateDynamic3DTextLabelText(kavkaz_sklad_text, -1, global_str);
						SaveWarehouse();
					}
				}
   			}
		}
		case dialog_SKLAD_2:
		{
		    if(!response) return 1;
			if(response)
   			{
				new gz;
				for(new i = 0; i < totalgz; i++) if(gz_info[i][gzopg] == PI[playerid][pMember]) gz++;
   			    switch(PI[playerid][pMember])
				{
					case 5:
					{
					    if(strval(inputtext)< 1) return SCM(playerid, COLOR_GREY,"Недопустимое значение");
					    if(PI[playerid][pMetall] < strval(inputtext)) return SCM(playerid, COLOR_GREY,"У Вас недостаточно металла");
						if(strval(inputtext)+skinhead_wh[0] > 6000) return SCM(playerid, COLOR_GREY,"На складе организации недостаточно места");
                        PI[playerid][pMetall] -= strval(inputtext);
                        PI[playerid][pProgressMetall] += strval(inputtext);
						skinhead_wh[0] += strval(inputtext);
						SendFractionMessagef(PI[playerid][pMember],0x67ab00FF, "[R] %s %s[%d] положил %d металла на склад",rang_skinhead[PI[playerid][pRang]-1][frName],PI[playerid][pName],playerid,strval(inputtext));
						global_str[0] = EOS, format(global_str, 225, "Склад\n{cc6666}Скинхеды\n{FFFFFF}Территорий: {ffcc33}%d шт\n{FFFFFF}Металл: {ffcc33}%d / 6000 шт.\n{FFFFFF}Патроны: {ffcc33}%d / 50000 шт.\n{FFFFFF}Вещества: {ffcc33}%d / 12000 шт.",gz,skinhead_wh[0],skinhead_wh[1],skinhead_wh[2]);
                        UpdateDynamic3DTextLabelText(skinhead_sklad_text, -1, global_str);
                        SaveWarehouse();
					}
					case 6:
					{
					    if(strval(inputtext) < 1) return SCM(playerid, COLOR_GREY,"Недопустимое значение");
					    if(PI[playerid][pMetall] < strval(inputtext)) return SCM(playerid, COLOR_GREY,"У Вас недостаточно металла");
						if(strval(inputtext)+gopota_wh[0] > 6000) return SCM(playerid, COLOR_GREY,"На складе организации недостаточно места");
                        PI[playerid][pMetall] -= strval(inputtext);
                        PI[playerid][pProgressMetall] += strval(inputtext);
						gopota_wh[0] += strval(inputtext);
						SendFractionMessagef(PI[playerid][pMember],0x67ab00FF, "[R] %s %s[%d] положил %d металла на склад",rang_gopota[PI[playerid][pRang]-1][frName],PI[playerid][pName],playerid,strval(inputtext));
						global_str[0] = EOS, format(global_str, 225, "Склад\n{cc6666}Гопота\n{FFFFFF}Территорий: {ffcc33}%d шт\n{FFFFFF}Металл: {ffcc33}%d / 6000 шт.\n{FFFFFF}Патроны: {ffcc33}%d / 50000 шт.\n{FFFFFF}Вещества: {ffcc33}%d / 12000 шт.",gz,gopota_wh[0],gopota_wh[1],gopota_wh[2]);
					    UpdateDynamic3DTextLabelText(gopota_sklad_text, -1, global_str);
					    SaveWarehouse();
					}
					case 7:
					{
					    if(strval(inputtext) < 1) return SCM(playerid, COLOR_GREY,"Недопустимое значение");
					    if(PI[playerid][pMetall] < strval(inputtext)) return SCM(playerid, COLOR_GREY,"У Вас недостаточно металла");
						if(strval(inputtext)+kavkaz_wh[0] > 6000) return SCM(playerid, COLOR_GREY,"На складе организации недостаточно места");
                        PI[playerid][pMetall] -= strval(inputtext);
                        PI[playerid][pProgressMetall] += strval(inputtext);
						kavkaz_wh[0] += strval(inputtext);
						SendFractionMessagef(PI[playerid][pMember],0x67ab00FF, "[R] %s %s[%d] положил %d металла на склад", rang_kavkaz[PI[playerid][pRang]-1][frName],PI[playerid][pName],playerid,strval(inputtext));
						global_str[0] = EOS, format(global_str, 225, "Склад\n{cc6666}Кавказцы\n{FFFFFF}Территорий: {ffcc33}%d шт\n{FFFFFF}Металл: {ffcc33}%d / 6000 шт.\n{FFFFFF}Патроны: {ffcc33}%d / 50000 шт.\n{FFFFFF}Вещества: {ffcc33}%d / 12000 шт.",gz,kavkaz_wh[0],kavkaz_wh[1],kavkaz_wh[2]);
						UpdateDynamic3DTextLabelText(kavkaz_sklad_text, -1, global_str);
						SaveWarehouse();
					}
				}
   			}
		}
		case dialog_SKLAD_3:
		{
		    if(!response) return 1;
			if(response)
   			{
   			    if(PI[playerid][pRang] < 5) return SCM(playerid, COLOR_GREY,"Склад организации доступен с 5 ранга");
   			    if(PI[playerid][pMember] == 5 && skinhead_wh[3] != 0 || PI[playerid][pMember] == 6 && gopota_wh[3] != 0 || PI[playerid][pMember] == 7 && kavkaz_wh[3]) return SCM(playerid, COLOR_GREY,"Склад закрыт лидером или заместителем ОПГ");
				
				new gz;
				for(new i = 0; i < totalgz; i++) if(gz_info[i][gzopg] == PI[playerid][pMember]) gz++;

				switch(PI[playerid][pMember])
				{
					case 5:
					{
						if(PI[playerid][pVIP] == 0) if(strval(inputtext)+PI[playerid][pAmmo] > 400) return SCM(playerid, COLOR_GREY,"В инвентаре можно иметь максимум 400 патронов");
						if(PI[playerid][pVIP] > 0) if(strval(inputtext)+PI[playerid][pAmmo] > 800) return SCM(playerid, COLOR_GREY,"В инвентаре можно иметь максимум 800 патронов");
						if(strval(inputtext) > 500) return SCM(playerid, COLOR_GREY,"Нельзя взять за 1 раз больше 500 патронов");
					    if(strval(inputtext) < 1) return SCM(playerid, COLOR_GREY,"Недопустимое значение");
					    if(skinhead_wh[1] < strval(inputtext)) return SCM(playerid, COLOR_GREY,"На складе недостаточно патронов");
						PI[playerid][pAmmo] += strval(inputtext);
						skinhead_wh[1] -= strval(inputtext);
						SendFractionMessagef(PI[playerid][pMember],0x67ab00FF, "[R] %s %s[%d] взял %d патронов со склада",rang_skinhead[PI[playerid][pRang]-1][frName],PI[playerid][pName],playerid,strval(inputtext));
						global_str[0] = EOS, format(global_str, 225, "Склад\n{cc6666}Скинхеды\n{FFFFFF}Территорий: {ffcc33}%d шт\n{FFFFFF}Металл: {ffcc33}%d / 6000 шт.\n{FFFFFF}Патроны: {ffcc33}%d / 50000 шт.\n{FFFFFF}Вещества: {ffcc33}%d / 12000 шт.",gz,skinhead_wh[0],skinhead_wh[1],skinhead_wh[2]);
                        UpdateDynamic3DTextLabelText(skinhead_sklad_text, -1, global_str);
                        SaveWarehouse();

					}
					case 6:
					{
						if(PI[playerid][pVIP] == 0) if(strval(inputtext)+PI[playerid][pAmmo] > 400) return SCM(playerid, COLOR_GREY,"В инвентаре можно иметь максимум 400 патронов");
						if(PI[playerid][pVIP] > 0) if(strval(inputtext)+PI[playerid][pAmmo] > 800) return SCM(playerid, COLOR_GREY,"В инвентаре можно иметь максимум 800 патронов");
						if(strval(inputtext) > 500) return SCM(playerid, COLOR_GREY,"Нельзя взять за 1 раз больше 500 патронов");
					    if(strval(inputtext) < 1) return SCM(playerid, COLOR_GREY,"Недопустимое значение");
					    if(gopota_wh[1] < strval(inputtext)) return SCM(playerid, COLOR_GREY,"На складе недостаточно патронов");
						PI[playerid][pAmmo] += strval(inputtext);
						gopota_wh[1] -= strval(inputtext);
						SendFractionMessagef(PI[playerid][pMember],0x67ab00FF, "[R] %s %s[%d] взял %d патронов со склада",rang_gopota[PI[playerid][pRang]-1][frName],PI[playerid][pName],playerid,strval(inputtext));
						global_str[0] = EOS, format(global_str, 225, "Склад\n{cc6666}Гопота\n{FFFFFF}Территорий: {ffcc33}%d шт\n{FFFFFF}Металл: {ffcc33}%d / 6000 шт.\n{FFFFFF}Патроны: {ffcc33}%d / 50000 шт.\n{FFFFFF}Вещества: {ffcc33}%d / 12000 шт.",gz,gopota_wh[0],gopota_wh[1],gopota_wh[2]);
					    UpdateDynamic3DTextLabelText(gopota_sklad_text, -1, global_str);
					    SaveWarehouse();
					}
					case 7:
					{
						if(PI[playerid][pVIP] == 0) if(strval(inputtext)+PI[playerid][pAmmo] > 400) return SCM(playerid, COLOR_GREY,"В инвентаре можно иметь максимум 400 патронов");
						if(PI[playerid][pVIP] > 0) if(strval(inputtext)+PI[playerid][pAmmo] > 800) return SCM(playerid, COLOR_GREY,"В инвентаре можно иметь максимум 800 патронов");
						if(strval(inputtext) > 500) return SCM(playerid, COLOR_GREY,"Нельзя взять за 1 раз больше 500 патронов");
					    if(strval(inputtext) < 1) return SCM(playerid, COLOR_GREY,"Недопустимое значение");
					    if(kavkaz_wh[1] < strval(inputtext)) return SCM(playerid, COLOR_GREY,"На складе недостаточно патронов");
						PI[playerid][pAmmo] += strval(inputtext);
						kavkaz_wh[1] -= strval(inputtext);
						SendFractionMessagef(PI[playerid][pMember],0x67ab00FF, "[R] %s %s[%d] взял %d патронов со склада", rang_kavkaz[PI[playerid][pRang]-1][frName],PI[playerid][pName],playerid,strval(inputtext));
						global_str[0] = EOS, format(global_str, 225, "Склад\n{cc6666}Кавказцы\n{FFFFFF}Территорий: {ffcc33}%d шт\n{FFFFFF}Металл: {ffcc33}%d / 6000 шт.\n{FFFFFF}Патроны: {ffcc33}%d / 50000 шт.\n{FFFFFF}Вещества: {ffcc33}%d / 12000 шт.",gz,kavkaz_wh[0],kavkaz_wh[1],kavkaz_wh[2]);
						UpdateDynamic3DTextLabelText(kavkaz_sklad_text, -1, global_str);
						SaveWarehouse();
					}
				}
   			}
		}
		case dialog_SKLAD_4:
		{
		    if(!response) return 1;
			if(response)
   			{
				new gz;
				for(new i = 0; i < totalgz; i++) if(gz_info[i][gzopg] == PI[playerid][pMember]) gz++;
   			    switch(PI[playerid][pMember])
				{
					case 5:
					{
					    if(strval(inputtext) < 1) return SCM(playerid, COLOR_GREY,"Недопустимое значение");
					    if(PI[playerid][pAmmo] < strval(inputtext)) return SCM(playerid, COLOR_GREY,"У Вас недостаточно патронов");
						if(strval(inputtext)+skinhead_wh[1] > 50000) return SCM(playerid, COLOR_GREY,"На складе организации недостаточно места");
                        PI[playerid][pAmmo] -= strval(inputtext);
                        PI[playerid][pProgressAmmo]  += strval(inputtext);
						skinhead_wh[1] += strval(inputtext);
						SendFractionMessagef(PI[playerid][pMember],0x67ab00FF, "[R] %s %s[%d] положил %d патронов на склад",rang_skinhead[PI[playerid][pRang]-1][frName],PI[playerid][pName],playerid,strval(inputtext));
						global_str[0] = EOS, format(global_str, 225, "Склад\n{cc6666}Скинхеды\n{FFFFFF}Территорий: {ffcc33}%d шт\n{FFFFFF}Металл: {ffcc33}%d / 6000 шт.\n{FFFFFF}Патроны: {ffcc33}%d / 50000 шт.\n{FFFFFF}Вещества: {ffcc33}%d / 12000 шт.",gz,skinhead_wh[0],skinhead_wh[1],skinhead_wh[2]);
                        UpdateDynamic3DTextLabelText(skinhead_sklad_text, -1, global_str);
                        SaveWarehouse();
					}
					case 6:
					{
					    if(strval(inputtext) < 1) return SCM(playerid, COLOR_GREY,"Недопустимое значение");
					    if(PI[playerid][pAmmo] < strval(inputtext)) return SCM(playerid, COLOR_GREY,"У Вас недостаточно патронов");
						if(strval(inputtext)+gopota_wh[1] > 50000) return SCM(playerid, COLOR_GREY,"На складе организации недостаточно места");
                        PI[playerid][pAmmo] -= strval(inputtext);
                        PI[playerid][pProgressAmmo]  += strval(inputtext);
						gopota_wh[1] += strval(inputtext);
						SendFractionMessagef(PI[playerid][pMember],0x67ab00FF, "[R] %s %s[%d] положил %d патронов на склад",rang_gopota[PI[playerid][pRang]-1][frName],PI[playerid][pName],playerid,strval(inputtext));
						global_str[0] = EOS, f(global_str, 200, "Склад\n{cc6666}Гопота\n{FFFFFF}Территорий: {ffcc33}%d шт\n{FFFFFF}Металл: {ffcc33}%d / 6000 шт.\n{FFFFFF}Патроны: {ffcc33}%d / 50000 шт.\n{FFFFFF}Вещества: {ffcc33}%d / 12000 шт.",gz,gopota_wh[0],gopota_wh[1],gopota_wh[2]);
					    UpdateDynamic3DTextLabelText(gopota_sklad_text, -1, global_str);
					    SaveWarehouse();
					}
					case 7:
					{
					    if(strval(inputtext) < 1) return SCM(playerid, COLOR_GREY,"Недопустимое значение");
					    if(PI[playerid][pAmmo] < strval(inputtext)) return SCM(playerid, COLOR_GREY,"У Вас недостаточно патронов");
						if(strval(inputtext)+kavkaz_wh[1] > 50000) return SCM(playerid, COLOR_GREY,"На складе организации недостаточно места");
                        PI[playerid][pAmmo] -= strval(inputtext);
                        PI[playerid][pProgressAmmo]  += strval(inputtext);
						kavkaz_wh[1] += strval(inputtext);
						SendFractionMessagef(PI[playerid][pMember],0x67ab00FF, "[R] %s %s[%d] положил %d патронов на склад", rang_kavkaz[PI[playerid][pRang]-1][frName],PI[playerid][pName],playerid,strval(inputtext));
						global_str[0] = EOS, f(global_str, 200, "Склад\n{cc6666}Кавказцы\n{FFFFFF}Территорий: {ffcc33}%d шт\n{FFFFFF}Металл: {ffcc33}%d / 6000 шт.\n{FFFFFF}Патроны: {ffcc33}%d / 50000 шт.\n{FFFFFF}Вещества: {ffcc33}%d / 12000 шт.",gz,kavkaz_wh[0],kavkaz_wh[1],kavkaz_wh[2]);
						UpdateDynamic3DTextLabelText(kavkaz_sklad_text, -1, global_str);
						SaveWarehouse();
					}
				}
   			}
		}
		case dialog_SKLAD_5:
		{
		    if(!response) return 1;
			if(response)
   			{
   			    if(PI[playerid][pRang] < 5) return SCM(playerid, COLOR_GREY,"Склад организации доступен с 5 ранга");
   			    if(PI[playerid][pMember] == 5 && skinhead_wh[3] != 0 || PI[playerid][pMember] == 6 && gopota_wh[3] != 0 || PI[playerid][pMember] == 7 && kavkaz_wh[3]) return SCM(playerid, COLOR_GREY,"Склад закрыт лидером или заместителем ОПГ");
				
				new gz;
				for(new i = 0; i < totalgz; i++) if(gz_info[i][gzopg] == PI[playerid][pMember]) gz++;
				
				switch(PI[playerid][pMember])
				{
					case 5:
					{
					    if(strval(inputtext) < 1) return SCM(playerid, COLOR_GREY,"Недопустимое значение");
					    if(skinhead_wh[2] < strval(inputtext)) return SCM(playerid, COLOR_GREY,"На складе организации недостаточно наркотиков");
						if(PI[playerid][pVIP] < 1) if(strval(inputtext)+PI[playerid][pDrugs] > 1000) return SCM(playerid, COLOR_GREY,"В инвентаре можно иметь максимум 1000 наркотиков");
						if(PI[playerid][pVIP] > 0) if(strval(inputtext)+PI[playerid][pDrugs]  > 2000) return SCM(playerid, COLOR_GREY,"В инвентаре можно иметь максимум 2000 наркотиков");
						PI[playerid][pDrugs] += strval(inputtext);
						skinhead_wh[2] -= strval(inputtext);
						SendFractionMessagef(PI[playerid][pMember],0x67ab00FF, "[R] %s %s[%d] взял %d наркотиков со склада",rang_skinhead[PI[playerid][pRang]-1][frName],PI[playerid][pName],playerid,strval(inputtext));
						global_str[0] = EOS, format(global_str, 225, "Склад\n{cc6666}Скинхеды\n{FFFFFF}Территорий: {ffcc33}%d шт\n{FFFFFF}Металл: {ffcc33}%d / 6000 шт.\n{FFFFFF}Патроны: {ffcc33}%d / 50000 шт.\n{FFFFFF}Вещества: {ffcc33}%d / 12000 шт.",gz,skinhead_wh[0],skinhead_wh[1],skinhead_wh[2]);
                        UpdateDynamic3DTextLabelText(skinhead_sklad_text, -1, global_str);
                        SaveWarehouse();

					}
					case 6:
					{
					    if(strval(inputtext) < 1) return SCM(playerid, COLOR_GREY,"Недопустимое значение");
					    if(gopota_wh[2] < strval(inputtext)) return SCM(playerid, COLOR_GREY,"На складе организации недостаточно наркотиков");
						if(PI[playerid][pVIP] < 1) if(strval(inputtext)+PI[playerid][pDrugs] > 1000) return SCM(playerid, COLOR_GREY,"В инвентаре можно иметь максимум 1000 наркотиков");
						if(PI[playerid][pVIP] >= 0) if(strval(inputtext)+PI[playerid][pDrugs] > 2000) return SCM(playerid, COLOR_GREY,"В инвентаре можно иметь максимум 2000 наркотиков");
						PI[playerid][pDrugs] += strval(inputtext);
						gopota_wh[2] -= strval(inputtext);
						SendFractionMessagef(PI[playerid][pMember],0x67ab00FF, "[R] %s %s[%d] взял %d наркотиков со склада",rang_gopota[PI[playerid][pRang]-1][frName],PI[playerid][pName],playerid,strval(inputtext));
						global_str[0] = EOS, format(global_str, 225, "Склад\n{cc6666}Гопота\n{FFFFFF}Территорий: {ffcc33}%d шт\n{FFFFFF}Металл: {ffcc33}%d / 6000 шт.\n{FFFFFF}Патроны: {ffcc33}%d / 50000 шт.\n{FFFFFF}Вещества: {ffcc33}%d / 12000 шт.",gz,gopota_wh[0],gopota_wh[1],gopota_wh[2]);
					    UpdateDynamic3DTextLabelText(gopota_sklad_text, -1, global_str);
					    SaveWarehouse();
					}
					case 7:
					{
					    if(strval(inputtext) < 1) return SCM(playerid, COLOR_GREY,"Недопустимое значение");
					    if(kavkaz_wh[2] < strval(inputtext)) return SCM(playerid, COLOR_GREY,"На складе организации недостаточно наркотиков");
						if(PI[playerid][pVIP] < 1) if(strval(inputtext)+PI[playerid][pDrugs] > 1000) return SCM(playerid, COLOR_GREY,"В инвентаре можно иметь максимум 1000 наркотиков");
						if(PI[playerid][pVIP] > 0) if(strval(inputtext)+PI[playerid][pDrugs] > 2000) return SCM(playerid, COLOR_GREY,"В инвентаре можно иметь максимум 2000 наркотиков");
						PI[playerid][pDrugs] += strval(inputtext);
						kavkaz_wh[2] -= strval(inputtext);
						SendFractionMessagef(PI[playerid][pMember],0x67ab00FF, "[R] %s %s[%d] взял %d наркотиков со склада", rang_kavkaz[PI[playerid][pRang]-1][frName],PI[playerid][pName],playerid,strval(inputtext));
						global_str[0] = EOS, format(global_str, 225, "Склад\n{cc6666}Кавказцы\n{FFFFFF}Территорий: {ffcc33}%d шт\n{FFFFFF}Металл: {ffcc33}%d / 6000 шт.\n{FFFFFF}Патроны: {ffcc33}%d / 50000 шт.\n{FFFFFF}Вещества: {ffcc33}%d / 12000 шт.",gz,kavkaz_wh[0],kavkaz_wh[1],kavkaz_wh[2]);
						UpdateDynamic3DTextLabelText(kavkaz_sklad_text, -1, global_str);
						SaveWarehouse();
					}
				}
   			}
		}
		case dialog_SKLAD_6:
		{
		    if(!response) return 1;
			if(response)
   			{
				new gz;
				for(new i = 0; i < totalgz; i++) if(gz_info[i][gzopg] == PI[playerid][pMember]) gz++;

			    switch(PI[playerid][pMember])
				{
					case 5:
					{
					    if(strval(inputtext) < 1) return SCM(playerid, COLOR_GREY,"Недопустимое значение");
					    if(PI[playerid][pDrugs] < strval(inputtext)) return SCM(playerid, COLOR_GREY,"У Вас недостаточно наркотиков");
						if(strval(inputtext)+skinhead_wh[2] > 12000) return SCM(playerid, COLOR_GREY,"На складе организации недостаточно места");
                        PI[playerid][pDrugs] -= strval(inputtext);
                        PI[playerid][pProgressDrugs] += strval(inputtext);
						skinhead_wh[2] += strval(inputtext);
						SendFractionMessagef(PI[playerid][pMember],0x67ab00FF, "[R] %s %s[%d] положил %d наркотиков на склад",rang_skinhead[PI[playerid][pRang]-1][frName],PI[playerid][pName],playerid,strval(inputtext));
						global_str[0] = EOS, format(global_str, 225, "Склад\n{cc6666}Скинхеды\n{FFFFFF}Территорий: {ffcc33}%d шт\n{FFFFFF}Металл: {ffcc33}%d / 6000 шт.\n{FFFFFF}Патроны: {ffcc33}%d / 30000 шт.\n{FFFFFF}Вещества: {ffcc33}%d / 12000 шт.",gz+1,skinhead_wh[0],skinhead_wh[1],skinhead_wh[2]);
                        UpdateDynamic3DTextLabelText(skinhead_sklad_text, -1, global_str);
                        SaveWarehouse();
					}
					case 6:
					{
					    if(strval(inputtext) < 1) return SCM(playerid, COLOR_GREY,"Недопустимое значение");
					    if(PI[playerid][pDrugs] < strval(inputtext)) return SCM(playerid, COLOR_GREY,"У Вас недостаточно наркотиков");
						if(strval(inputtext)+gopota_wh[2] > 12000) return SCM(playerid, COLOR_GREY,"На складе организации недостаточно места");
                        PI[playerid][pDrugs] -= strval(inputtext);
                        PI[playerid][pProgressDrugs] += strval(inputtext);
						gopota_wh[2] += strval(inputtext);
						SendFractionMessagef(PI[playerid][pMember],0x67ab00FF, "[R] %s %s[%d] положил %d наркотиков на склад",rang_gopota[PI[playerid][pRang]-1][frName],PI[playerid][pName],playerid,strval(inputtext));
						global_str[0] = EOS, format(global_str, 225, "Склад\n{cc6666}Гопота\n{FFFFFF}Территорий: {ffcc33}%d шт\n{FFFFFF}Металл: {ffcc33}%d / 6000 шт.\n{FFFFFF}Патроны: {ffcc33}%d / 30000 шт.\n{FFFFFF}Вещества: {ffcc33}%d / 12000 шт.",gz+1,gopota_wh[0],gopota_wh[1],gopota_wh[2]);
					    UpdateDynamic3DTextLabelText(gopota_sklad_text, -1, global_str);
					    SaveWarehouse();
					}
					case 7:
					{
					    if(strval(inputtext) < 1) return SCM(playerid, COLOR_GREY,"Недопустимое значение");
					    if(PI[playerid][pDrugs] < strval(inputtext)) return SCM(playerid, COLOR_GREY,"У Вас недостаточно наркотиков");
						if(strval(inputtext)+kavkaz_wh[2] > 12000) return SCM(playerid, COLOR_GREY,"На складе организации недостаточно места");
                        PI[playerid][pDrugs] -= strval(inputtext);
                        PI[playerid][pProgressDrugs] += strval(inputtext);
						kavkaz_wh[2] += strval(inputtext);
						SendFractionMessagef(PI[playerid][pMember],0x67ab00FF, "[R] %s %s[%d] положил %d наркотиков на склад", rang_kavkaz[PI[playerid][pRang]-1][frName],PI[playerid][pName],playerid,strval(inputtext));
						global_str[0] = EOS, format(global_str, 225, "Склад\n{cc6666}Кавказцы\n{FFFFFF}Территорий: {ffcc33}%d шт\n{FFFFFF}Металл: {ffcc33}%d / 6000 шт.\n{FFFFFF}Патроны: {ffcc33}%d / 30000 шт.\n{FFFFFF}Вещества: {ffcc33}%d / 12000 шт.",gz+1,kavkaz_wh[0],kavkaz_wh[1],kavkaz_wh[2]);
						UpdateDynamic3DTextLabelText(kavkaz_sklad_text, -1, global_str);
						SaveWarehouse();
					}
				}
   			}
		}
		case 6751:
		{
			if(!response) return 1;
			if(response)
			{
	  			if(IsPlayerInAnyVehicle(playerid) && GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
				{
				    new b = GetPVarInt(playerid,"business"), cena = BizInfo[b][data_CENA]*strval(inputtext), car = GetPlayerVehicleID(playerid);

		   			if(strval(inputtext) <= 0) 
						return SCM(playerid, COLOR_GREY, !"Введите от 1 до 50 литров.");
					if(strval(inputtext)+CarInfo[car][cFuel] > 50) 
						return SCM(playerid, COLOR_GREY, !"В топливном баке можно перевозить не более 50 литров бензина");
                    if(strval(inputtext) > BizInfo[b][bProduct]  && BizInfo[b][bOwned] == 1) 
						return SCM(playerid, COLOR_GREY, !"У данной АЗС недостаточно бензина");
					if(GetPlayerMoneyID(playerid) < cena) 
						return SCM(playerid, COLOR_GREY, !"У Вас недостаточно денег на руках");
                    
					
					BizInfo[b][bProduct] -= strval(inputtext);
					BizInfo[b][bMoney] += cena;
					CarInfo[car][cFuel] += strval(inputtext);

					GivePlayerMoneyLog(playerid,-cena);
					UpdateBusinessData(b);
				}
			}
		}
		case 6752:
		{
			if(!response) return 1;
			if(response)
			{
	  			new b = GetPVarInt(playerid,"business"), cena = BizInfo[b][data_CENA]*20;
				if(PI[playerid][pCanisters] == 1) 
					return SCM(playerid, COLOR_GREY, !"У вас уже есть канистра. Чтобы заправить автомобиль, просто воспользуйтесь командой /fuel.");
				if(10 > BizInfo[b][bProduct] && BizInfo[b][bOwned] == 1) 
					return SCM(playerid, COLOR_GREY, !"Увы, на складе недостаточно топлива.");
				if(GetPlayerMoneyID(playerid) < cena) 
					return SCM(playerid, COLOR_GREY, !"У Вас недостаточно денег на руках");

				BizInfo[b][bProduct] -= 10;
				BizInfo[b][bMoney] += cena;
				GivePlayerMoneyLog(playerid,-cena);
				UpdateBusinessData(b);
				PI[playerid][pCanisters] = 1;
				SCM(playerid, COLOR_GREEN, "[Информация]: {FFFFFF}Поздравляю! Теперь у вас есть канистра с бензином. Для заправки автомобиля используйте команду /fuel.");
			}
		}
		case 6753: 
		{
		    if(!response) return 1;
			if(response) 
			{
				new b = GetPVarInt(playerid,"business"), cena = BizInfo[b][data_CENA]*30;

				if(PI[playerid][pFixPack] >= 3) 
					return SCM(playerid, COLOR_GREY, !"У Вас уже есть ремонтный комплект, используйте /fix для починки");
				if(GetPlayerMoneyID(playerid) < cena) 
					return SCM(playerid, COLOR_GREY, !"У Вас недостаточно денег на руках");

				BizInfo[b][bMoney] += cena;
				GivePlayerMoneyLog(playerid,-cena);
				UpdateBusinessData(b);
				PI[playerid][pFixPack] = 1;
				SCM(playerid, COLOR_GREEN, "Вы приобрели ремонтный комплект. Для его использования введите команду: /fix.");
			}
		}
		case 7242: 
		{
			if (!response) return 1;

			new OrgID = PI[GetPVarInt(playerid, "FromID")][pMember];
			new SenderID = GetPVarInt(playerid, "FromID");
			DeletePVar(playerid, "FromID");

			PI[playerid][pMember] = OrgID;
			PI[playerid][pRang] = 1;
			PI[playerid][pOrgSkin] = PI[playerid][pSkin];
			SetPlayerColorEx(playerid);
			PI[playerid][data_JOB] = 0;

			new skinId;
			switch (PI[playerid][pSex])
			{
				case 1:
					switch (PI[playerid][pMember])
					{
						case 1: skinId = 57;
						case 2: skinId = 179;
						case 3: skinId = 280;
						case 4: skinId = 71;
						case 5: skinId = 8;
						case 6: skinId = 115;
						case 7: skinId = 123;
						case 8: skinId = 15;
					}
				case 2: 
					switch (PI[playerid][pMember])
					{
						case 1: skinId = 216;
						case 2: skinId = 191;
						case 3: skinId = 141;
						case 4: skinId = 194;
						case 5: skinId = 13;
						case 6: skinId = 13;
						case 7: skinId = 13;
						case 8: skinId = 12;
					}
			}

			PI[playerid][pOrgSkin] = skinId;
			SetPlayerSkinAC(playerid, skinId);
			SetPlayerTeam(playerid, PI[playerid][pMember]);

			if (PI[playerid][pMember] >= 5 && PI[playerid][pMember] <= 7) 
			{
				for (new g = 0; g <= totalgz; g++) 
				{
					GangZoneShowForPlayer(playerid, g, GetGZFrac(g));
				}
			}

			SCMf(playerid, -1, "Поздравляем! Вы вступили в организацию {ffb614}'%s'", Fraction_Name[PI[playerid][pMember]]);
			SCM(playerid, -1, !"Используйте {ffb614}/setspawn{FFFFFF} для изменения спавна и {ffb614}/menu > Список команд для помощи");
			SCMf(SenderID, 0x36e96cFF, "%s[%d] вступил в организацию по Вашему предложению. Игрок включён в стандартную группу", PI[playerid][pName], playerid);

			mysql_string[0] = EOS, f(mysql_string, 75, "SELECT * FROM `group` WHERE `fraction` = '%d' AND `default` = 1", PI[playerid][pMember]);
			mysql_tquery(mysql, mysql_string, "SetPlayerStandartGroup", "i", playerid);

			SavePlayerData(playerid);
			CheckGangWar(playerid);

			return 1;
		}
		case 4500:
        {
            if(!response) return 1;
			if(response)
			{
			    switch(listitem)
			    {
			        case 0: ShowPlayerDialog(playerid, 0, DIALOG_STYLE_MSGBOX, !"{ee3366}Информация", "{FFFFFF}Что бы отключить навигатор зайдите в раздел Карта (ESC) и нажмите ПКМ", "Закрыть", "Назад");
					case 1: ShowPlayerDialog(playerid, 4506, DIALOG_STYLE_TABLIST_HEADERS, "{ee3366}Важные места", "Место\tРасполажение\n\
																							1. Автовокзал №1\t\tпгт. Батырево\n\
																							2. Центарльный Банк\t\tпгт. Батырево\n\
																							3. Автосалон (импортный)\t\tпгт. Южный\n\
																							4. Автошкола\t\tпгт. Батырево\n\
																							5. Мэрия\t\tпгт. Батырево\n\
																							6. Металлобаза\tпгт. Батырево\n\
																							7. Военкомат\t\tпгт. Батырево\n\
																							8. Авторынок\t\tНижегородская область", "Отметить", "Назад");
					case 2: ShowPlayerDialog(playerid, 4505, DIALOG_STYLE_TABLIST_HEADERS, "{ee3366}Временные работы", "\
																							Место\tРасполажение\n\
																							1. Ферма {e1e187}[1+ уровень]\t\t{FFFFFF}Ашан (не работает)\n\
																							2. Шахта {e1e187}[1+ уровень]\t\t{FFFFFF}г. Лыткарино", "Отметить", "Назад");
					case 3: ShowPlayerDialog(playerid, 4504, DIALOG_STYLE_TABLIST_HEADERS, "{ee3366}Основные работы", "\
																							Место\tРасполажение\n\
																							1. Дальнобойщик {e1e187}[3+ уровень]\t\t{FFFFFF}г. Южный\n\
																							2. Таксист {e1e187}[1+ уровень]\t\t{FFFFFF}г. Батырвео","Отметить", "Назад");
					case 4:ShowPlayerDialog(playerid, 4503, DIALOG_STYLE_TABLIST_HEADERS, "{ee3366}Государственные организации", "\
																							Место\tРасполажение\n\
																							1. Правительство\t\t пгт. Батырево\n\
																							2. Войсковая часть\t\t пгт. Батырево\n\
																							3. Полиция\t\t\t пгт. Южный\n\
																							4. БЦРБ (больница)\t\t пгт. Батырево", "Отметить", "Назад");
					case 5:ShowPlayerDialog(playerid, 4502, DIALOG_STYLE_TABLIST_HEADERS, "{ee3366}Нелегальные организации", "\
																							Место\tРасполажение\n\
																							1. Скинхеды\t\t\t пгт. Батырево\n\
																							2. Гопота\t\t\t г. Южный\n\
																							3. Кавказцы\t\t\t пгт. Бусаево\n\
																							{FFFF99}4. Склад вещест\t\t пгт. Батырево", "Отметить", "Назад");
					case 6: ShowPlayerDialog(playerid, 4501, DIALOG_STYLE_LIST, "{ee3366}Развлечения", "\
																							1. Аренда лодок\n\
																							2. Казино", "Отметить", "Назад");
					case 7: return 1;
					case 8: 
					{
	                    new Float:pX, Float:pY, Float:pZ;
						new Float:Item, Float:minS;
						new Posi;
						GetPlayerPos(playerid, pX, pY, pZ);
						for(new i = 0; i < sizeof(TotalBusiness); i++) 
						{
							minS = PointToPoint(pX, pY, pZ, BizInfo[i][data_ENTERX], BizInfo[i][data_ENTERY], BizInfo[i][data_ENTERZ]);
						}
						Posi = 56;
						for(new i = 0; i < sizeof(TotalBusiness); i++)
						{
							Item = PointToPoint(pX, pY, pZ, BizInfo[i][data_ENTERX], BizInfo[i][data_ENTERY], BizInfo[i][data_ENTERZ]);
							if(Item < minS)
							{
							    minS = Item;
							    Posi = i;
							}
						}
						SCM(playerid, COLOR_GREEN, !"Местоположение ближайшей АЗС успешно отмечено в вашем GPS.");
				        DisablePlayerCheckpoint(playerid);
				        SetPlayerCheckpoint(playerid, BizInfo[Posi][data_ENTERX], BizInfo[Posi][data_ENTERY], BizInfo[Posi][data_ENTERZ],5.0);
						return 1;
					}
					case 9: 
					{
	                    new Float:pX, Float:pY, Float:pZ;
						new Float:Item, Float:minS;
						new Posi;
						GetPlayerPos(playerid, pX, pY, pZ);
						for(new i = 0; i < sizeof(Bankomats); i++) minS = PointToPoint(pX, pY, pZ, Bankomats[i][0], Bankomats[i][1], Bankomats[i][2]);
						Posi = 56;
						for(new i = 0; i < sizeof(Bankomats); i++)
						{
							Item = PointToPoint(pX, pY, pZ, Bankomats[i][0], Bankomats[i][1], Bankomats[i][2]);
							if(Item < minS)
							{
							    minS = Item;
							    Posi = i;
							}
						}
						SCM(playerid, COLOR_GREEN, !"Местоположение ближайшего банкомата успешно отмечено в вашем GPS.");
				        DisablePlayerCheckpoint(playerid);
				        SetPlayerCheckpoint(playerid, Bankomats[Posi][0], Bankomats[Posi][1], Bankomats[Posi][2],5.0);
						return 1;
					}
					case 10: 
					{
						DisablePlayerCheckpoint(playerid);
						DeletePVar(playerid, "gps_pos_x");
						DeletePVar(playerid, "gps_pos_y");
						DeletePVar(playerid, "gps_pos_z");
						return 1;
					}
				}
			}
		}
		case 4501:
		{
		    if(!response) return ShowGPS(playerid);
		    if(response)
		    {
				DisablePlayerCheckpoint(playerid);
		        switch(listitem)
		        {
		            case 0:
		            {
		                SetPVarFloat(playerid, "gps_pos_x", 2808.5137);
						SetPVarFloat(playerid, "gps_pos_y", -2148.5676);
						SetPVarFloat(playerid, "gps_pos_z", 19.0471);
				        SetPlayerCheckpoint(playerid,2808.5137,-2148.5676,19.0471,5.0);
		            }
		            case 1:
		            {
		            	SetPVarFloat(playerid, "gps_pos_x", 1887.9885);
						SetPVarFloat(playerid, "gps_pos_y", 1895.7618);
						SetPVarFloat(playerid, "gps_pos_z", 13.2227);
				        SetPlayerCheckpoint(playerid,2313.8247,-1924.8029,22.4338,5.0);
		            }
				}
				SendPlayerRadarNotify(playerid, 3, "green", "Пункт назначения отмечен у Вас на мини-карте", "", 5);
			}
		}
		case 4503:
		{
		    if(!response) return ShowGPS(playerid);
		    {
				DisablePlayerCheckpoint(playerid);
		        switch(listitem)
		        {
		            case 0:
		            {
		                SetPVarFloat(playerid, "gps_pos_x", 1825.0465);
						SetPVarFloat(playerid, "gps_pos_y", 2096.2244);
						SetPVarFloat(playerid, "gps_pos_z", 15.8515);
				        SetPlayerCheckpoint(playerid,1825.0465,2096.2244,15.8515,5.0);
		            }
		            case 1:
		            {
		                SetPVarFloat(playerid, "gps_pos_x", 1896.4519);
						SetPVarFloat(playerid, "gps_pos_y", 1721.5980);
						SetPVarFloat(playerid, "gps_pos_z", 15.8050);
				        SetPlayerCheckpoint(playerid,1896.4519,1721.5980,15.8050,5.0);
		            }
		            case 2:
					{
					    SetPVarFloat(playerid, "gps_pos_x", 2403.7036);
						SetPVarFloat(playerid, "gps_pos_y", -1852.4626);
						SetPVarFloat(playerid, "gps_pos_z", 21.9308);
				        SetPlayerCheckpoint(playerid,2403.7036,-1852.4626,21.9308,5.0);
					}
		            case 3:
		            {
		                SetPVarFloat(playerid, "gps_pos_x", 2100.3179);
						SetPVarFloat(playerid, "gps_pos_y", 1819.1858);
						SetPVarFloat(playerid, "gps_pos_z", 12.2200);
				        SetPlayerCheckpoint(playerid,2100.3179,1819.1858,12.2200,5.0);
		            }
		        }
				SendPlayerRadarNotify(playerid, 3, "green", "Пункт назначения отмечен у Вас на мини-карте", "", 5);
		    }
		}
		case 4502:
		{
		    if(!response) return ShowGPS(playerid);
		    {
				DisablePlayerCheckpoint(playerid);
		        switch(listitem)
		        {
		            case 0:
		            {
		                SetPVarFloat(playerid, "gps_pos_x", 1425.3506);
						SetPVarFloat(playerid, "gps_pos_y", 2371.1912);
						SetPVarFloat(playerid, "gps_pos_z", 13.6925);
				        SetPlayerCheckpoint(playerid,1425.3506,2371.1912,13.6925,5.0);
		            }
		            case 1:
		            {
		                SetPVarFloat(playerid, "gps_pos_x", 2216.6448);
						SetPVarFloat(playerid, "gps_pos_y", -2572.8618);
						SetPVarFloat(playerid, "gps_pos_z", 21.9633);
				        SetPlayerCheckpoint(playerid,2216.6448,-2572.8618,21.9633,5.0);
		            }
		            case 2:
		            {
		                SetPVarFloat(playerid, "gps_pos_x", -543.7330);
						SetPVarFloat(playerid, "gps_pos_y", -1386.7384);
						SetPVarFloat(playerid, "gps_pos_z", 41.2275);
				        SetPlayerCheckpoint(playerid,-543.7330,-1386.7384,41.2275,5.0);
		            }
		            case 3:
		            {
		                SetPVarFloat(playerid, "gps_pos_x", 1894.9059);
						SetPVarFloat(playerid, "gps_pos_y", 1186.5181);
						SetPVarFloat(playerid, "gps_pos_z", 30.3239);
				        SetPlayerCheckpoint(playerid,1894.9059,1186.5181,30.3239,5.0);
		            }
		        }
				SendPlayerRadarNotify(playerid, 3, "green", "Пункт назначения отмечен у Вас на мини-карте", "", 5);
		    }
		}
		case 4506:
		{
		    if(!response) return ShowGPS(playerid);
			if(response)
			{
				DisablePlayerCheckpoint(playerid);
			    switch(listitem)
			    {
			        case 0:
			        {
			            SetPVarFloat(playerid, "gps_pos_x", 1811.0527);
						SetPVarFloat(playerid, "gps_pos_y", 2510.2866);
						SetPVarFloat(playerid, "gps_pos_z", 15.6717);
				        SetPlayerCheckpoint(playerid,1811.0527,2510.2866,15.6717,5.0);
			        }
					case 1:
					{
			            SetPVarFloat(playerid, "gps_pos_x", 1821.0479);
						SetPVarFloat(playerid, "gps_pos_y", 2028.2125);
						SetPVarFloat(playerid, "gps_pos_z", 15.8697);
				        SetPlayerCheckpoint(playerid,1821.0479,2028.2125,15.8697,5.0);
					}
					case 2:
					{
					    SetPVarFloat(playerid, "gps_pos_x", 2325.5154);
						SetPVarFloat(playerid, "gps_pos_y", -1803.9813);
						SetPVarFloat(playerid, "gps_pos_z", 22.4540);
				        SetPlayerCheckpoint(playerid, 2325.5154,-1803.9813,22.4540,5.0);
					}
					case 3:
					{
						SetPVarFloat(playerid, "gps_pos_x", 1854.3938);
						SetPVarFloat(playerid, "gps_pos_y", 1453.0250);
						SetPVarFloat(playerid, "gps_pos_z", 10.0355);
				        SetPlayerCheckpoint(playerid,1854.3938,1453.0250,10.0355,5.0);
					}
					case 4:
					{
						SetPVarFloat(playerid, "gps_pos_x", 1824.3256);
						SetPVarFloat(playerid, "gps_pos_y", 2095.8198);
						SetPVarFloat(playerid, "gps_pos_z", 15.8522);
				        SetPlayerCheckpoint(playerid,1824.3256,2095.8198,15.8522,5.0);
					}
					case 5:
					{
						SetPVarFloat(playerid, "gps_pos_x", 2776.2747);
						SetPVarFloat(playerid, "gps_pos_y", 2699.4124);
						SetPVarFloat(playerid, "gps_pos_z", 16.7200);
				        SetPlayerCheckpoint(playerid,2776.2747,2699.4124,16.7200,5.0);
					}
					case 6:
					{
						SetPVarFloat(playerid, "gps_pos_x", 1913.6172);
						SetPVarFloat(playerid, "gps_pos_y", 2300.4441);
						SetPVarFloat(playerid, "gps_pos_z", 15.5697);
				        SetPlayerCheckpoint(playerid,1913.6172,2300.4441,15.5697,5.0);
					}
					case 7:
					{
						SetPVarFloat(playerid, "gps_pos_x", 2452.4082);
						SetPVarFloat(playerid, "gps_pos_y", -756.4071);
						SetPVarFloat(playerid, "gps_pos_z", 12.0969);
				        SetPlayerCheckpoint(playerid, 2452.4082,-756.4071,12.0969,5.0);
					}
				}
				SendPlayerRadarNotify(playerid, 3, "green", "Пункт назначения отмечен у Вас на мини-карте", "", 5);
			}
		}
		case 4504:
		{
		    if(!response) return ShowGPS(playerid);
			if(response)
			{
				DisablePlayerCheckpoint(playerid);
			    switch(listitem)
			    {
			        case 0:
			        {
			            SetPVarFloat(playerid, "gps_pos_x", 1966.2675);
						SetPVarFloat(playerid, "gps_pos_y", -2603.7898);
						SetPVarFloat(playerid, "gps_pos_z", 10.8149);
				        SetPlayerCheckpoint(playerid,1966.2675,-2603.7898,10.8149,5.0);
			        }
			        case 1:
			        {
			            SetPVarFloat(playerid, "gps_pos_x", 1783.8827);
						SetPVarFloat(playerid, "gps_pos_y", 2296.9661);
						SetPVarFloat(playerid, "gps_pos_z", 15.7667);
				        SetPlayerCheckpoint(playerid,1783.8827,2296.9661,15.7667,5.0);
			        }
			        
				}
			}
		}
		case 4505:
		{
		    if(!response) return ShowGPS(playerid);
			if(response)
			{
				DisablePlayerCheckpoint(playerid);
			    switch(listitem)
			    {
			        case 0:
			        {
			            SetPVarFloat(playerid, "gps_pos_x", 2129.8027);
						SetPVarFloat(playerid, "gps_pos_y", 1791.4589);
						SetPVarFloat(playerid, "gps_pos_z", 12.0000);
				        SetPlayerCheckpoint(playerid, 2027.6515, 1396.8190, 26.1489,5.0);
			        }
			        case 1:
			        {
			            SetPVarFloat(playerid, "gps_pos_x", 2776.2747);
						SetPVarFloat(playerid, "gps_pos_y", 2699.4124);
						SetPVarFloat(playerid, "gps_pos_z", 16.7200);
				        SetPlayerCheckpoint(playerid,2776.2747,2699.4124,16.7200,5.0);
			        }
				}
				SendPlayerRadarNotify(playerid, 3, "green", "Пункт назначения отмечен у Вас на мини-карте", "", 5);
			}
		}
		case dialog_EAT_MENU: 
		{
		    new b = GetPVarInt(playerid,"business");
		    if(!response) return 1;
			if(response) {
			    switch(listitem) 
				{
			        case 0: 
					{
			            new cena = 100;
	                    if(BizInfo[b][bProduct] <= 0  && BizInfo[b][bOwned] == 1) return SCM(playerid, COLOR_GREY,"В бизнесе недостаточно продуктов");
						if(GetPlayerMoneyID(playerid) < cena) return SCM(playerid, COLOR_GREY,"У Вас недостаточно денег на руках");
						GivePlayerMoneyLog(playerid,-cena);
						BizInfo[b][bMoney] += cena;
						BizInfo[b][bProduct] -= 1;
                        UpdateBusinessData(b);
						global_str[0] = EOS, f(global_str, 39, "%s выпил спранк",PI[playerid][pName]);
						PlayerPlaySound(playerid, 32200, 0.0, 0.0, 0.0);
					    ProxDetector(10.0, playerid, global_str, 0xFF99CCFF, 0xFF99CCFF, 0xFF99CCFF, 0xFF99CCFF, 0xFF99CCFF);
	                    SetPlayerChatBubble(playerid, "выпил спранк", 0xFF99CCFF, 20.0, 4000);
					}
		         	case 1: {
			            new cena = 150;
	                    if(BizInfo[b][bProduct] <= 0  && BizInfo[b][bOwned] == 1) return SCM(playerid, COLOR_GREY,"В бизнесе недостаточно продуктов");
						if(GetPlayerMoneyID(playerid) < cena) return SCM(playerid, COLOR_GREY,"У Вас недостаточно денег на руках");
						GivePlayerMoneyLog(playerid,-cena);
						BizInfo[b][bMoney] += cena;
						BizInfo[b][bProduct] -= 1;
                        UpdateBusinessData(b);
						global_str[0] = EOS, f(global_str, 39, "%s выпил кофе",PI[playerid][pName]);
						PlayerPlaySound(playerid, 32200, 0.0, 0.0, 0.0);
					    ProxDetector(10.0, playerid, global_str, 0xFF99CCFF, 0xFF99CCFF, 0xFF99CCFF, 0xFF99CCFF, 0xFF99CCFF);
	                    SetPlayerChatBubble(playerid, "выпил кофе", 0xFF99CCFF, 20.0, 4000);

			        }
			       	case 2: 
					{
			            new cena = 250;
	                    if(BizInfo[b][bProduct] <= 0  && BizInfo[b][bOwned] == 1) return SCM(playerid, COLOR_GREY,"В бизнесе недостаточно продуктов");
						if(GetPlayerMoneyID(playerid) < cena) return SCM(playerid, COLOR_GREY,"У Вас недостаточно денег на руках");
						GivePlayerMoneyLog(playerid,-cena);
						BizInfo[b][bMoney] += cena;
						BizInfo[b][bProduct] -= 1;
						new Float:hp;
						GetPlayerHealth(playerid, hp);
						SetPlayerHealthAC(playerid, hp+30);
						if(PI[playerid][pSatiety] <= 70) PI[playerid][pSatiety] += 30;
						else PI[playerid][pSatiety] = 100;
                        UpdateBusinessData(b);
						global_str[0] = EOS, f(global_str, 39, "%s съела бургер",PI[playerid][pName]);
						PlayerPlaySound(playerid, 32200, 0.0, 0.0, 0.0);
					    ProxDetector(10.0, playerid, global_str, 0xFF99CCFF, 0xFF99CCFF, 0xFF99CCFF, 0xFF99CCFF, 0xFF99CCFF);
	                    SetPlayerChatBubble(playerid, "съела бургер", 0xFF99CCFF, 20.0, 4000);
			        }
			    }
			    ShowEatMenu(playerid);
			}
		}
		case 101: 
		{
		    if(!response) return 1;
		    if(response) 
			{
				if(!IsPlayerLogged{playerid}) return 1;
			    switch(listitem) 
				{
			        case 0: ShowStats(playerid);
			        case 1: callcmd::help(playerid);
					case 2: ShowHotKeys(playerid);
					case 3: ReportDialog(playerid);
					case 4: ShowSettings(playerid);
					case 5: ShowDialogRule(playerid);
                    case 6: ShowDialogResurs(playerid);
			        case 7: ChangeNameMenu(playerid);
                    case 8: 
					{
						mf(mysql, mysql_string, 86, "SELECT * FROM `fractions_blacklist` WHERE bl_name = '%e'",PI[playerid][pName]);
						mysql_tquery(mysql, mysql_string, "CheckBlackListPlayer", "d", playerid);
					}
					case 9: 
					{
						mf(mysql, mysql_string, 66, "SELECT * FROM `accounts` WHERE `Name` = '%e'",PI[playerid][pName]);
						mysql_function_query(mysql, mysql_string, true, "LoadDonate", "i", playerid);
					}
			    }
			}
		}
		case dialog_HOUSE:
  		{
			if(!response) return 1;
			if(response)
			{
			    switch(listitem)
			    {
			        case 0:
			        {
			            new h = PI[playerid][pHouse];
                        ShowPlayerDialogf(playerid, 0, DIALOG_STYLE_MSGBOX, !"{ee3366}Информация о доме", !"Закрыть", !"", "\
							{FFFFFF}Номер дома: {FFFF99}%d\n\
							{FFFFFF}Гос. цена: {FFFF99}%d\n\n\
							{CCCC33}Оплачен на %d дня/дней", h+1,HOUSE_DATA[h][data_PRICE], HOUSE_DATA[h][data_DAY]);
			        }
			        case 1:
			        {
			            new h = PI[playerid][pHouse];
	 				    if(PlayerToPoint(3.0, playerid, HOUSE_DATA[h][data_EXITX], HOUSE_DATA[h][data_EXITY], HOUSE_DATA[h][data_EXITZ]) || PlayerToPoint(3.0, playerid, HOUSE_DATA[h][data_ENTERX], HOUSE_DATA[h][data_ENTERY], HOUSE_DATA[h][data_ENTERZ]))
						switch(HOUSE_DATA[h][data_LOCK])
   						{
	        				case 0: HOUSE_DATA[h][data_LOCK] = 1, cef_emit_event(playerid, "show-notify", CEFINT(2), CEFSTR("Вы закрыли свой дом"), CEFSTR("c13537"));
       						case 1: HOUSE_DATA[h][data_LOCK] = 0, cef_emit_event(playerid, "show-notify", CEFINT(3), CEFSTR("Вы открыли свой дом"), CEFSTR("487f5f"));
				        }
				        else SCM(playerid, COLOR_GREY, !"Необходимо находиться возле выхода/входа");
			        }
			        case 2:
			        {
						new h = PI[playerid][pHouse];
			            ShowPlayerDialogf(playerid, dialog_SELL_HOUSE, DIALOG_STYLE_MSGBOX, !"{ee3366}Продажа дома", !"Продать", !"Отмена", "{FFFFFF}Вы желаете продать свой дом за {FFFF99}%d рублей{FFFFFF}?", HOUSE_DATA[h][data_PRICE]/2);
			        }
			    }
			}
  		}
  		case dialog_SELL_HOUSE:
		{
			if(!response) return 1;
			if(response)
   			{
		    	new h = PI[playerid][pHouse];
		      	HOUSE_DATA[h][data_OWNED] = 0;
		      	HOUSE_DATA[h][data_DAY] = 0;
		      	PI[playerid][pHouse] = INVALID_HOUSE_ID;
			 	strmid(HOUSE_DATA[h][data_OWNER], "None", 0, strlen(HOUSE_DATA[h][data_OWNER]), 24);
				GivePlayerMoneyLog(playerid,HOUSE_DATA[h][data_PRICE]/2);
			 	SCMf(playerid, 0xFFCC00AA, "Вы продали дом государству за %d рублей", HOUSE_DATA[h][data_PRICE]/2);
				UpdateHouseData(h);
				SaveHouseData(h);
			  	SavePlayerData(playerid);
   			}
		}
		case dialog_DONATE_VIP: 
		{
			if(!response) return 1;
			if(response) 
			{
			    if(PI[playerid][pVIP] == 1) return SCM(playerid, COLOR_GREY, !"У Вас уже есть вип статус");
			    if(PI[playerid][pDonate] < 200) return SCM(playerid, COLOR_GREY, !"У Вас недостаточно донат-поинтов на счету");
                PI[playerid][pVIP] = 30;
                PI[playerid][pDonate] -= 200;
				UpdatePlayerDataInt(playerid, "Donate", PI[playerid][pDonate]);
				UpdatePlayerDataInt(playerid, "vip", PI[playerid][pVIP]);
                SCM(playerid, COLOR_YELLOW, !"Поздравляем Вас с покупкой вип-статуса");
				SCM(playerid, 0x33ccffFF, !"Успешная покупка, списано 200 донат-поинтов.");
			}
		}
		case dialog_DONATE: 
		{
		    if(!response) return 1;
		    if(response) 
			{
		        switch(listitem) 
				{
		            case 0: 
					{
						ShowPlayerDialogf(playerid, dialog_DONATE, DIALOG_STYLE_MSGBOX, !"{ee3366}Информация", "Закрыть", "Назад", "{FFFFFF}Текущий баланс {ee3366}%d донат-поинтов", PI[playerid][pDonate]);
					}
					case 1: ShowPlayerDialog(playerid, 0, DIALOG_STYLE_MSGBOX, !"{ee3366}История", "{FFFFFF}История операций пуста", "Назад", "");
					case 2: 
					{
					 	ShowPlayerDialogf(playerid, dialog_CONVERT, DIALOG_STYLE_INPUT, "{ee3366}Конвертация донат-поинтов (ввод суммы)", "Далее", "Закрыть", "{FFFFFF}Баланс донат-поинтов: {3366cc}%d\n{FFFFFF}Ставка перевода: 1 дп. = 2000 руб\n\nВведите количество донат-поинтов, которое Вы\nхотите конвертировать в игровые рубли:", PI[playerid][pDonate]);
					}
					case 3: ShowPlayerDialog(playerid, 9884, DIALOG_STYLE_MSGBOX, !"{ee3366}Покупка всех навыков стрельбы", "{FFFFFF}После покупки у Вас появятся все навыки стрельбы с оружия.\nЦена - {FFFF99}30 донат-поинтов", "Купить", "Закрыть");
					case 4: ShowPlayerDialog(playerid, 9883, DIALOG_STYLE_MSGBOX, !"{ee3366}Снятие всех предупреждений", "{FFFFFF}После покупки у Вас пропадут все предупреждения\nЦена - {FFFF99}25 донат-поинтов", "Купить", "Закрыть");
		            case 5: ShowPlayerDialog(playerid, 9882, DIALOG_STYLE_INPUT, "{ee3366}Изменение никнейма", "{FFFFFF}Вы собераетесь изменить игровой никнейм своего персонажа\n\n{FFFF99}Обратите внимание, что если Вы измените никнейм во время\nпроверки на Вас жалобы, Вы будете заблокированы на 7 дней.", "Изменить", "Назад");
                    case 6: callcmd::plus(playerid);
                    case 7: 
					{
                        if(PI[playerid][pDonate] < 129) return ShowPlayerDialog(playerid, 0, DIALOG_STYLE_MSGBOX, !"{ee3366}Ошибка", "{FFFFFF}Для покупки военного билета нужно 129 донат-поинтов.", "Закрыть", "");
                        PI[playerid][pMilitaryID] = 1;
                        UpdatePlayerDataInt(playerid, "military", PI[playerid][pMilitaryID]);
			            mysql_tqueryf(mysql, "UPDATE `accounts` SET `donate` = '%d' WHERE `Name` = '%e'",PI[playerid][pDonate],PI[playerid][pName]);
						SCM(playerid, 0x33ccffFF, !"Успешная покупка, списано 129 донат-поинтов.");
                    }
                    case 8: 
					{
                        if(PI[playerid][pDonate] < 129) return ShowPlayerDialog(playerid, 0, DIALOG_STYLE_MSGBOX, !"{ee3366}Ошибка", "{FFFFFF}Для покупки 10 единиц законопослушности нужно 19 донат-поинтов.", "Закрыть", "");
                        PI[playerid][pRespect] +=10;
						UpdatePlayerDataInt(playerid, "Respect", PI[playerid][pRespect]);
			            mysql_tqueryf(mysql, "UPDATE `accounts` SET `donate` = '%d' WHERE `Name` = '%e'",PI[playerid][pDonate],PI[playerid][pName]);
						SCM(playerid, 0x33ccffFF, !"Успешная покупка, списано 19 донат-поинтов.");
                    }
		            case 9: ShowPlayerDialog(playerid, 9881, DIALOG_STYLE_INPUT, "{ee3366}Покупка 4х значного номера", "Введите желаем номер в окне ниже.", "Купить", "Отмена");
					case 10:
					{
						new settings[700];
						format(settings, sizeof settings, "\
						{FFFFFF}1. Рога\t\t\t\t{FFFF99}%s (цена: 35 дп)\n\
						{FFFFFF}2. Костюм гробовщик\t{FFFF99}%s (цена: 35 дп)\n\
						{FFFFFF}3. Голова Микки-Мауса\t{FFFF99}%s (цена: 35 дп)\n\
						{FFFFFF}4. Голова Дед-Пула\t\t\t{FFFF99}%s (цена: 25 дп)\n\
						{FFFFFF}5. Огнемёт\t\t\t{FFFF99}%s (цена: 25 дп)\n\
						{FFFFFF}6. Красный чемодан\t\t{FFFF99}%s (цена: 10 дп)\n\
						{FFFFFF}7. Ёлка на плечо\t\t{FFFF99}%s (цена: 25 дп)\n\
						{FFFFFF}8. Ангельское кольцо \t\t{FFFF99}%s (цена: 40 дп)\n\
						{FFFFFF}9. Дигл на спину\t\t{FFFF99}%s (цена: 25 дп)\n\
						{FFFFFF}10. Шляпа фермера\t\t{FFFF99}%s (цена: 15 дп)",
						(PI[playerid][pAccessory_1]) ? ("(куплен)") : ("(не куплен)"),
						(PI[playerid][pAccessory_2]) ? ("(куплен)") : ("(не куплен)"),
						(PI[playerid][pAccessory_3]) ? ("(куплен)") : ("(не куплен)"),
						(PI[playerid][pAccessory_4]) ? ("(куплен)") : ("(не куплен)"),
						(PI[playerid][pAccessory_5]) ? ("(куплен)") : ("(не куплен)"),
						(PI[playerid][pAccessory_6]) ? ("(куплен)") : ("(не куплен)"),
						(PI[playerid][pAccessory_7]) ? ("(куплен)") : ("(не куплен)"),
						(PI[playerid][pAccessory_8]) ? ("(куплен)") : ("(не куплен)"),
						(PI[playerid][pAccessory_9]) ? ("(куплен)") : ("(не куплен)"),
						(PI[playerid][pAccessory_10]) ? ("(куплен)") : ("(не куплен)"));
						ShowPlayerDialog(playerid,9879, DIALOG_STYLE_LIST, "{ee3366}Покупка акессуаров",settings, "Купить", "Отмена");
					}
					case 11: 
					{
						new settings[700];
						format(settings, sizeof settings, "\
						{FFFFFF}1. Игровой мастер 1-вого уровня\t\t{FFFF99}(цена: %d дп)\n\
						{FFFFFF}2. Игровой мастер 2-вого уровня\t\t{FFFF99}(цена: %d дп)\n\
						{FFFFFF}3. Игровой мастер 3-вого уровня\t\t{FFFF99}(цена: %d дп)\n\
						{FFFFFF}4. Игровой мастер 4-вого уровня\t\t{FFFF99}(цена: %d дп)\n\
						{FFFFFF}5. Игровой мастер 5-вого уровня\t\t{FFFF99}(цена: %d дп)\n\
						{FFFFFF}6. Игровой мастер 6-вого уровня\t\t{FFFF99}(цена: %d дп)\n\
						{FFFFFF}7. Игровой мастер 7-вого уровня\t\t{FFFF99}(цена: %d дп)",
						150*XDON,300*XDON,450*XDON,600*XDON,750*XDON,900*XDON,1050*XDON);
						ShowPlayerDialog(playerid,9880, DIALOG_STYLE_LIST, "{ee3366}Покупка прав игрового мастера",settings, "Купить", "Отмена");
					}
				}
			}
		}
		case 9879: 
		{
			if(!response) return 1;
			if(response) 
			{
				switch(listitem) 
				{
		            case 0: 
					{
						if(PI[playerid][pDonate] < 30) return ShowPlayerDialog(playerid, 0, DIALOG_STYLE_MSGBOX, !"{ff5511}Ошибка", !"{FFFFFF}Для покупки данного предмета нужно 30 донат-поинтов", "Закрыть", "");
						PI[playerid][pDonate] -= 30;
						PI[playerid][pAccessory_1] = 1;
						UpdatePlayerDataInt(playerid, "Donate", PI[playerid][pDonate]);
						UpdatePlayerDataInt(playerid, "Accessory_1", PI[playerid][pAccessory_1]);
						SCM(playerid, 0x33ccffFF, !"Успешная покупка, списано 30 донат-поинтов.");
						SCM(playerid, COLOR_HINT, !"[Подсказка] {FFFFFF}Чтобы использовать, /mm > Настройки персонажа > Управление аксессуарами");
						return 1;
		            }
		            case 1: 
					{
						if(PI[playerid][pDonate] < 35) return ShowPlayerDialog(playerid, 0, DIALOG_STYLE_MSGBOX, !"{ff5511}Ошибка", !"{FFFFFF}Для покупки данного предмета нужно 35 донат-поинтов", "Закрыть", "");
						PI[playerid][pDonate] -= 35;
						PI[playerid][pAccessory_1] = 1;
						UpdatePlayerDataInt(playerid, "Donate", PI[playerid][pDonate]);
						UpdatePlayerDataInt(playerid, "Accessory_4", PI[playerid][pAccessory_1]);
						SCM(playerid, 0x33ccffFF, !"Успешная покупка, списано 35 донат-поинтов.");
						SCM(playerid, COLOR_HINT, !"[Подсказка] {FFFFFF}Чтобы использовать, /mm > Настройки персонажа > Управление аксессуарами");
						return 1;
		            }
		            case 2: 
					{
						if(PI[playerid][pDonate] < 30) return ShowPlayerDialog(playerid, 0, DIALOG_STYLE_MSGBOX, !"{ff5511}Ошибка", !"{FFFFFF}Для покупки данного предмета нужно 30 донат-поинтов", "Закрыть", "");
						PI[playerid][pDonate] -= 30;
						PI[playerid][pAccessory_3] = 1;
						UpdatePlayerDataInt(playerid, "Donate", PI[playerid][pDonate]);
						UpdatePlayerDataInt(playerid, "Accessory_3", PI[playerid][pAccessory_3]);
						SCM(playerid, 0x33ccffFF, !"Успешная покупка, списано 30 донат-поинтов.");
						SCM(playerid, COLOR_HINT, !"[Подсказка] {FFFFFF}Чтобы использовать, /mm > Настройки персонажа > Управление аксессуарами");
						return 1;
					}
					case 3: 
					{
						if(PI[playerid][pDonate] < 30) return ShowPlayerDialog(playerid, 0, DIALOG_STYLE_MSGBOX, !"{ff5511}Ошибка", !"{FFFFFF}Для покупки данного предмета нужно 30 донат-поинтов", "Закрыть", "");
						PI[playerid][pDonate] -= 30;
						PI[playerid][pAccessory_4] = 1;
						UpdatePlayerDataInt(playerid, "Donate", PI[playerid][pDonate]);
						UpdatePlayerDataInt(playerid, "Accessory_2", PI[playerid][pAccessory_4]);
						SCM(playerid, 0x33ccffFF, !"Успешная покупка, списано 30 донат-поинтов.");
						SCM(playerid, COLOR_HINT, !"[Подсказка] {FFFFFF}Чтобы использовать, /mm > Настройки персонажа > Управление аксессуарами");
						return 1;
					}
					case 4: 
					{
						if(PI[playerid][pDonate] < 30) return ShowPlayerDialog(playerid, 0, DIALOG_STYLE_MSGBOX, !"{ff5511}Ошибка", !"{FFFFFF}Для покупки данного предмета нужно 30 донат-поинтов", "Закрыть", "");
						PI[playerid][pDonate] -= 30;
						PI[playerid][pAccessory_5] = 1;
						UpdatePlayerDataInt(playerid, "Donate", PI[playerid][pDonate]);
						UpdatePlayerDataInt(playerid, "Accessory_5", PI[playerid][pAccessory_5]);
						SCM(playerid, 0x33ccffFF, !"Успешная покупка, списано 30 донат-поинтов.");
						SCM(playerid, COLOR_HINT, !"[Подсказка] {FFFFFF}Чтобы использовать, /mm > Настройки персонажа > Управление аксессуарами");
						return 1;
					}
					case 5: 
					{
						if(PI[playerid][pDonate] < 30) return ShowPlayerDialog(playerid, 0, DIALOG_STYLE_MSGBOX, !"{ff5511}Ошибка", !"{FFFFFF}Для покупки данного предмета нужно 30 донат-поинтов", "Закрыть", "");
						PI[playerid][pDonate] -= 30;
						PI[playerid][pAccessory_6] = 1;
						UpdatePlayerDataInt(playerid, "Donate", PI[playerid][pDonate]);
						UpdatePlayerDataInt(playerid, "Accessory_6", PI[playerid][pAccessory_6]);
						SCM(playerid, 0x33ccffFF, !"Успешная покупка, списано 30 донат-поинтов.");
						SCM(playerid, COLOR_HINT, !"[Подсказка] {FFFFFF}Чтобы использовать, /mm > Настройки персонажа > Управление аксессуарами");
						return 1;
					}
					case 6: 
					{
						if(PI[playerid][pDonate] < 30) return ShowPlayerDialog(playerid, 0, DIALOG_STYLE_MSGBOX, !"{ff5511}Ошибка", !"{FFFFFF}Для покупки данного предмета нужно 30 донат-поинтов", "Закрыть", "");
						PI[playerid][pDonate] -= 30;
						PI[playerid][pAccessory_7] = 1;
						UpdatePlayerDataInt(playerid, "Donate", PI[playerid][pDonate]);
						UpdatePlayerDataInt(playerid, "Accessory_7", PI[playerid][pAccessory_7]);
						SCM(playerid, 0x33ccffFF, !"Успешная покупка, списано 30 донат-поинтов.");
						SCM(playerid, COLOR_HINT, !"[Подсказка] {FFFFFF}Чтобы использовать, /mm > Настройки персонажа > Управление аксессуарами");
						return 1;
					}
					case 7: 
					{
						if(PI[playerid][pDonate] < 30) return ShowPlayerDialog(playerid, 0, DIALOG_STYLE_MSGBOX, !"{ff5511}Ошибка", !"{FFFFFF}Для покупки данного предмета нужно 30 донат-поинтов", "Закрыть", "");
						PI[playerid][pDonate] -= 30;
						PI[playerid][pAccessory_8] = 1;
						UpdatePlayerDataInt(playerid, "Donate", PI[playerid][pDonate]);
						UpdatePlayerDataInt(playerid, "Accessory_8", PI[playerid][pAccessory_8]);
						SCM(playerid, 0x33ccffFF, !"Успешная покупка, списано 30 донат-поинтов.");
						SCM(playerid, COLOR_HINT, !"[Подсказка] {FFFFFF}Чтобы использовать, /mm > Настройки персонажа > Управление аксессуарами");
						return 1;
					}
					case 8: 
					{
						if(PI[playerid][pDonate] < 30) return ShowPlayerDialog(playerid, 0, DIALOG_STYLE_MSGBOX, !"{ff5511}Ошибка", !"{FFFFFF}Для покупки данного предмета нужно 30 донат-поинтов", "Закрыть", "");
						PI[playerid][pDonate] -= 30;
						PI[playerid][pAccessory_9] = 1;
						UpdatePlayerDataInt(playerid, "Donate", PI[playerid][pDonate]);
						UpdatePlayerDataInt(playerid, "Accessory_9", PI[playerid][pAccessory_9]);
						SCM(playerid, 0x33ccffFF, !"Успешная покупка, списано 30 донат-поинтов.");
						SCM(playerid, COLOR_HINT, !"[Подсказка] {FFFFFF}Чтобы использовать, /mm > Настройки персонажа > Управление аксессуарами");
						return 1;
					}
					case 9: 
					{
						if(PI[playerid][pDonate] < 30) return ShowPlayerDialog(playerid, 0, DIALOG_STYLE_MSGBOX, !"{ff5511}Ошибка", !"{FFFFFF}Для покупки данного предмета нужно 30 донат-поинтов", "Закрыть", "");
						PI[playerid][pDonate] -= 30;
						PI[playerid][pAccessory_10] = 1;
						UpdatePlayerDataInt(playerid, "Donate", PI[playerid][pDonate]);
						UpdatePlayerDataInt(playerid, "Accessory_10", PI[playerid][pAccessory_10]);
						SCM(playerid, 0x33ccffFF, !"Успешная покупка, списано 30 донат-поинтов.");
						SCM(playerid, COLOR_HINT, !"[Подсказка] {FFFFFF}Чтобы использовать, /mm > Настройки персонажа > Управление аксессуарами");
						return 1;
					}
				}
			}
		}
		case dialog_TAKE: 
		{
			if(!response) return 1;
			if(response) 
			{
				switch(listitem)
				{
		            case 0: 
					{
						if(PI[playerid][pTakeAcs] != 0) return ShowPlayerDialog(playerid, 0, DIALOG_STYLE_MSGBOX, !"{ff5511}Ошибка", !"{FFFFFF}Вы уже получили приз!", "Закрыть", "");
						PI[playerid][pTakeAcs] = 1;
						PI[playerid][pAccessory_1] = 1;
						UpdatePlayerDataInt(playerid, "Donate", PI[playerid][pTakeAcs]);
						UpdatePlayerDataInt(playerid, "Accessory_1", PI[playerid][pAccessory_1]);
						SCM(playerid, COLOR_HINT, !"[Подсказка] {FFFFFF}Чтобы использовать, /mm > Настройки персонажа > Управление аксессуарами");
						return 1;
		            }
		            case 1: 
					{
						if(PI[playerid][pTakeAcs] != 0) return ShowPlayerDialog(playerid, 0, DIALOG_STYLE_MSGBOX, !"{ff5511}Ошибка", !"{FFFFFF}Вы уже получили приз!", "Закрыть", "");
						PI[playerid][pTakeAcs] = 1;
						PI[playerid][pAccessory_2] = 1;
						UpdatePlayerDataInt(playerid, "Donate", PI[playerid][pTakeAcs]);
						UpdatePlayerDataInt(playerid, "Accessory_2", PI[playerid][pAccessory_2]);
						SCM(playerid, COLOR_HINT, !"[Подсказка] {FFFFFF}Чтобы использовать, /mm > Настройки персонажа > Управление аксессуарами");
						return 1;
		            }
		            case 2: 
					{
						if(PI[playerid][pTakeAcs] != 0) return ShowPlayerDialog(playerid, 0, DIALOG_STYLE_MSGBOX, !"{ff5511}Ошибка", !"{FFFFFF}Вы уже получили приз!", "Закрыть", "");
						PI[playerid][pTakeAcs] = 1;
						PI[playerid][pAccessory_3] = 1;
						UpdatePlayerDataInt(playerid, "Donate", PI[playerid][pTakeAcs]);
						UpdatePlayerDataInt(playerid, "Accessory_3", PI[playerid][pAccessory_3]);
						SCM(playerid, COLOR_HINT, !"[Подсказка] {FFFFFF}Чтобы использовать, /mm > Настройки персонажа > Управление аксессуарами");
						return 1;
					}
					case 3: 
					{
						if(PI[playerid][pTakeAcs] != 0) return ShowPlayerDialog(playerid, 0, DIALOG_STYLE_MSGBOX, !"{ff5511}Ошибка", !"{FFFFFF}Вы уже получили приз!", "Закрыть", "");
						PI[playerid][pTakeAcs] = 1;
						PI[playerid][pAccessory_4] = 1;
						UpdatePlayerDataInt(playerid, "Donate", PI[playerid][pTakeAcs]);
						UpdatePlayerDataInt(playerid, "Accessory_4", PI[playerid][pAccessory_4]);
						SCM(playerid, COLOR_HINT, !"[Подсказка] {FFFFFF}Чтобы использовать, /mm > Настройки персонажа > Управление аксессуарами");
						return 1;
					}
					case 4: 
					{
						if(PI[playerid][pTakeAcs] != 0) return ShowPlayerDialog(playerid, 0, DIALOG_STYLE_MSGBOX, !"{ff5511}Ошибка", !"{FFFFFF}Вы уже получили приз!", "Закрыть", "");
						PI[playerid][pTakeAcs] = 1;
						PI[playerid][pAccessory_5] = 1;
						UpdatePlayerDataInt(playerid, "Donate", PI[playerid][pTakeAcs]);
						UpdatePlayerDataInt(playerid, "Accessory_5", PI[playerid][pAccessory_5]);
						SCM(playerid, COLOR_HINT, !"[Подсказка] {FFFFFF}Чтобы использовать, /mm > Настройки персонажа > Управление аксессуарами");
						return 1;
					}
					case 5: 
					{
						if(PI[playerid][pTakeAcs] != 0) return ShowPlayerDialog(playerid, 0, DIALOG_STYLE_MSGBOX, !"{ff5511}Ошибка", !"{FFFFFF}Вы уже получили приз!", "Закрыть", "");
						PI[playerid][pTakeAcs] = 1;
						PI[playerid][pAccessory_6] = 1;
						UpdatePlayerDataInt(playerid, "Donate", PI[playerid][pTakeAcs]);
						UpdatePlayerDataInt(playerid, "Accessory_6", PI[playerid][pAccessory_6]);
						SCM(playerid, COLOR_HINT, !"[Подсказка] {FFFFFF}Чтобы использовать, /mm > Настройки персонажа > Управление аксессуарами");
						return 1;
					}
					case 6: 
					{
						if(PI[playerid][pTakeAcs] != 0) return ShowPlayerDialog(playerid, 0, DIALOG_STYLE_MSGBOX, !"{ff5511}Ошибка", !"{FFFFFF}Вы уже получили приз!", "Закрыть", "");
						PI[playerid][pTakeAcs] = 1;
						PI[playerid][pAccessory_7] = 1;
						UpdatePlayerDataInt(playerid, "Donate", PI[playerid][pTakeAcs]);
						UpdatePlayerDataInt(playerid, "Accessory_7", PI[playerid][pAccessory_7]);
						SCM(playerid, COLOR_HINT, !"[Подсказка] {FFFFFF}Чтобы использовать, /mm > Настройки персонажа > Управление аксессуарами");
						return 1;
					}
					case 7: 
					{
						if(PI[playerid][pTakeAcs] != 0) return ShowPlayerDialog(playerid, 0, DIALOG_STYLE_MSGBOX, !"{ff5511}Ошибка", !"{FFFFFF}Вы уже получили приз!", "Закрыть", "");
						PI[playerid][pTakeAcs] = 1;
						PI[playerid][pAccessory_8] = 1;
						UpdatePlayerDataInt(playerid, "Donate", PI[playerid][pTakeAcs]);
						UpdatePlayerDataInt(playerid, "Accessory_8", PI[playerid][pAccessory_8]);
						SCM(playerid, COLOR_HINT, !"[Подсказка] {FFFFFF}Чтобы использовать, /mm > Настройки персонажа > Управление аксессуарами");
						return 1;
					}
					case 8: 
					{
						if(PI[playerid][pTakeAcs] != 0) return ShowPlayerDialog(playerid, 0, DIALOG_STYLE_MSGBOX, !"{ff5511}Ошибка", !"{FFFFFF}Вы уже получили приз!", "Закрыть", "");
						PI[playerid][pTakeAcs] = 1;
						PI[playerid][pAccessory_9] = 1;
						UpdatePlayerDataInt(playerid, "Donate", PI[playerid][pTakeAcs]);
						UpdatePlayerDataInt(playerid, "Accessory_9", PI[playerid][pAccessory_9]);
						SCM(playerid, COLOR_HINT, !"[Подсказка] {FFFFFF}Чтобы использовать, /mm > Настройки персонажа > Управление аксессуарами");
						return 1;
					}
					case 9: 
					{
						if(PI[playerid][pTakeAcs] != 0) return ShowPlayerDialog(playerid, 0, DIALOG_STYLE_MSGBOX, !"{ff5511}Ошибка", !"{FFFFFF}Вы уже получили приз!", "Закрыть", "");
						PI[playerid][pTakeAcs] = 1;
						PI[playerid][pAccessory_10] = 1;
						UpdatePlayerDataInt(playerid, "Donate", PI[playerid][pTakeAcs]);
						UpdatePlayerDataInt(playerid, "Accessory_10", PI[playerid][pAccessory_10]);
						SCM(playerid, COLOR_HINT, !"[Подсказка] {FFFFFF}Чтобы использовать, /mm > Настройки персонажа > Управление аксессуарами");
						return 1;
					}
				}
			}
		}
        case dialog_TP:
        {
            if(!response) return 1;
            if(response)
            {
                switch(listitem)
                {
                    case 0: SetPlayerPosAC(playerid, 2381.2559,-1901.3752,21.9330);
                    case 1: SetPlayerPosAC(playerid, 1916.8721,2246.8320,15.7139);
					case 2: SetPlayerPosAC(playerid, 2387.4668,-615.2571,12.3700);
					case 3: SetPlayerPosAC(playerid, -582.7040,-139.3514,1.2200);
					case 4: SetPlayerPosAC(playerid, 998.2722,-384.9974,4.0025);
					case 5: SetPlayerPosAC(playerid, 215.1709,-918.4337,40.6382);
					case 6: SetPlayerPosAC(playerid, 1758.3649,2255.2327,15.8572);
					case 7: SetPlayerPosAC(playerid, 1184.8860,2498.1978,12.4800);
					case 8: SetPlayerPosAC(playerid, 2376.0488,-996.1595,2.0300);
					case 9: SetPlayerPosAC(playerid, 2309.8789,-1131.2976,2.5600);
					case 10: SetPlayerPosAC(playerid, 2484.7485,-746.3240,12.0969);
					case 11: SetPlayerPosAC(playerid, 616.4615,797.7547,12.0298);
					case 12: SetPlayerPosAC(playerid, 443.5924,360.1169,12.1800);
					case 13: SetPlayerPosAC(playerid, 2325.5154,-1803.9813,22.4540);
					case 14: SetPlayerPosAC(playerid, 1223.7863,-370.6064,4.0765);
					case 15: SetPlayerPosAC(playerid, 24.3647,288.6667,12.0567);
					case 16: SetPlayerPosAC(playerid, 207.5432,1478.4958,12.0346);
					case 17: SetPlayerPosAC(playerid, -284.2634,582.7474,12.1289);
					case 18: SetPlayerPosAC(playerid, 2160.5093,-1766.6997,18.9069);
					case 19: SetPlayerPosAC(playerid, 464.8619,-1241.0986,40.6765);
					case 20: SetPlayerPosAC(playerid, 1767.4198,1334.9589,9.7556);
					case 21: SetPlayerPosAC(playerid, -398.1591,925.6467,12.1500);
					case 22: SetPlayerPosAC(playerid, -1503.4741,1608.9265,36.5690);
                }
                SetPlayerInterior(playerid, 0);
                SetPlayerVirtualWorld(playerid, 0);
            }
        }
		case dialog_CHANGE_NAME: {
			if(!response) return ShowMainMenu(playerid);
			if(response) {
				switch(listitem) {
					case 0: RandomName(playerid);
					case 1: ShowPlayerDialog(playerid, 9882, DIALOG_STYLE_INPUT, "{ee3366}Изменение никнейма", "Вы собераетесь изменить игровой никнейм своего персонажа\n\n{FFFF99}Обратите внимание, что если Вы измените никнейм во время\nпроверки на Вас жалобы, Вы будете заблокированы на 7 дней.", "Изменить", "Назад");
				}
			}
		}
		case dialog_SETNAME:
		{
			if(!response) return ChangeNameMenu(playerid);
			if(response) 
			{
				new name[24];
				GetPVarString(playerid,"randomame", name, sizeof(name));
				FixSVarString(name);
				strmid(CHANGE_NAME[playerid], name, 0, strlen(name), MAX_PLAYER_NAME);
				SetPVarInt(playerid, "change_name_status", 1);

				mysql_string[0] = EOS, mf(mysql, mysql_string, 66, "SELECT * FROM `accounts` WHERE `Name` = '%e'", CHANGE_NAME[playerid]);
				mysql_function_query(mysql, mysql_string, true, "CheckName", "ds", playerid, CHANGE_NAME[playerid]);
			}
		}
		case dialog_MAKEGUN:
		{
		    if(!response) return 1;
			if(response)
			{
			    switch(listitem)
			    {
			        case 0:
			        {
			            if(PI[playerid][pMetall] < 1) return SCM(playerid, COLOR_GREY, !"У Вас недостаточно металла");
			            SetPVarInt(playerid, "makegun",5);
			            ShowPlayerDialog(playerid, dialog_MAKEGUN_1, DIALOG_STYLE_INPUT, !"{ee3366}Бейсбольная бита", !"{FFFFFF}Введите желаемое количество", !"Создать", !"Отмена");
			        }
			        case 1:
			        {
			            if(PI[playerid][pMetall] < 5) return SCM(playerid, COLOR_GREY, !"У Вас недостаточно металла");
			            SetPVarInt(playerid, "makegun",22);
			            ShowPlayerDialog(playerid, dialog_MAKEGUN_1, DIALOG_STYLE_INPUT, !"{ee3366}Тайзер", !"{FFFFFF}Введите желаемое количество патронов", !"Создать", !"Отмена");
			        }
			        case 2:
			        {
			            if(PI[playerid][pMetall] < 3) return SCM(playerid, COLOR_GREY, !"У Вас недостаточно металла");
			            SetPVarInt(playerid, "makegun",23);
			            ShowPlayerDialog(playerid, dialog_MAKEGUN_1, DIALOG_STYLE_INPUT, !"{ee3366}Тайзер", !"{FFFFFF}Введите желаемое количество патронов", !"Создать", !"Отмена");
			        }
			        case 3:
			        {
			            if(PI[playerid][pMetall] < 6) return SCM(playerid, COLOR_GREY, !"У Вас недостаточно металла");
			            SetPVarInt(playerid, "makegun",24);
			            ShowPlayerDialog(playerid, dialog_MAKEGUN_1, DIALOG_STYLE_INPUT, !"{ee3366}ПЛ-15", !"{FFFFFF}Введите желаемое количество патронов", !"Создать", !"Отмена");
			        }
			        case 4:
			        {
			            if(PI[playerid][pMetall] < 8) return SCM(playerid, COLOR_GREY, !"У Вас недостаточно металла");
			            SetPVarInt(playerid, "makegun",25);
			            ShowPlayerDialog(playerid, dialog_MAKEGUN_1, DIALOG_STYLE_INPUT, !"{ee3366}Дробовик", !"{FFFFFF}Введите желаемое количество патронов", !"Создать", !"Отмена");
			        }
			        case 5:
			        {
			            if(PI[playerid][pMetall] < 7) return SCM(playerid, COLOR_GREY, !"У Вас недостаточно металла");
			            SetPVarInt(playerid, "makegun",26);
			            ShowPlayerDialog(playerid, dialog_MAKEGUN_1, DIALOG_STYLE_INPUT, !"{ee3366}Обрез", !"{FFFFFF}Введите желаемое количество патронов", !"Создать", !"Отмена");
			        }
			        case 6:
			        {
			            if(PI[playerid][pMetall] < 9) return SCM(playerid, COLOR_GREY, !"У Вас недостаточно металла");
			            SetPVarInt(playerid, "makegun",27);
			            ShowPlayerDialog(playerid, dialog_MAKEGUN_1, DIALOG_STYLE_INPUT, !"{ee3366}Автоматический дробовик", !"{FFFFFF}Введите желаемое количество патронов", !"Создать", !"Отмена");
			        }
			        case 7:
			        {
			            if(PI[playerid][pMetall] < 7) return SCM(playerid, COLOR_GREY, !"У Вас недостаточно металла");
			            SetPVarInt(playerid, "makegun",28);
			            ShowPlayerDialog(playerid, dialog_MAKEGUN_1, DIALOG_STYLE_INPUT, !"{ee3366}MP40", !"{FFFFFF}Введите желаемое количество патронов", !"Создать", !"Отмена");
			        }
			        case 8:
			        {
			            if(PI[playerid][pMetall] < 8) return SCM(playerid, COLOR_GREY, !"У Вас недостаточно металла");
			            SetPVarInt(playerid, "makegun",29);
			            ShowPlayerDialog(playerid, dialog_MAKEGUN_1, DIALOG_STYLE_INPUT, !"{ee3366}AKC-74Y", !"{FFFFFF}Введите желаемое количество патронов", !"Создать", !"Отмена");
			        }
			        case 9:
			        {
			            if(PI[playerid][pMetall] < 9) return SCM(playerid, COLOR_GREY, !"У Вас недостаточно металла");
			            SetPVarInt(playerid, "makegun",30);
			            ShowPlayerDialog(playerid, dialog_MAKEGUN_1, DIALOG_STYLE_INPUT, !"{ee3366}AK-47", !"{FFFFFF}Введите желаемое количество патронов", !"Создать", !"Отмена");
			        }
			        case 10:
			        {
			            if(PI[playerid][pMetall] < 9) return SCM(playerid, COLOR_GREY, !"У Вас недостаточно металла");
			            SetPVarInt(playerid, "makegun",31);
			            ShowPlayerDialog(playerid, dialog_MAKEGUN_1, DIALOG_STYLE_INPUT, !"{ee3366}AK-104", !"{FFFFFF}Введите желаемое количество патронов", !"Создать", !"Отмена");
			        }
			        case 11:
			        {
			            if(PI[playerid][pMetall] < 7) return SCM(playerid, COLOR_GREY, !"У Вас недостаточно металла");
			            SetPVarInt(playerid, "makegun",32);
			            ShowPlayerDialog(playerid, dialog_MAKEGUN_1, DIALOG_STYLE_INPUT, !"{ee3366}Tec-9", !"{FFFFFF}Введите желаемое количество патронов", !"Создать", !"Отмена");
			        }
			        case 12:
			        {
			            if(PI[playerid][pMetall] < 10) return SCM(playerid, COLOR_GREY, !"У Вас недостаточно металла");
			            SetPVarInt(playerid, "makegun",33);
			            ShowPlayerDialog(playerid, dialog_MAKEGUN_1, DIALOG_STYLE_INPUT, !"{ee3366}Country Rifle", !"{FFFFFF}Введите желаемое количество патронов", !"Создать", !"Отмена");
			        }
			    }
			}
		}
		case dialog_MAKEGUN_1: {
		    if(!response) return 1;
		    if(response) {
				if(strval(inputtext) > PI[playerid][pAmmo]) return SCM(playerid, COLOR_GREY,"У Вас недостаточно патронов");
				if(strval(inputtext) < 1) return SCM(playerid, COLOR_GREY,"Недопустимое значение");
				new gun = GetPlayerWeapon(playerid);
				if(gun == GetPVarInt(playerid,"makegun")) {
					GiveWeapon(playerid, GetPVarInt(playerid,"makegun"), strval(inputtext));
					PI[playerid][pAmmo] -= strval(inputtext);
					new string[55];
				    format(string, sizeof(string), "%s добавил %d пт к %s",PI[playerid][pName], strval(inputtext), weapon_names[GetPVarInt(playerid,"makegun")]);
					ProxDetector(30.0, playerid, string, 0xFF99CCFF, 0xFF99CCFF, 0xFF99CCFF, 0xFF99CCFF, 0xFF99CCFF);
					SetPlayerChatBubble(playerid, string, 0xFF99CCFF, 20.0, 4000);
				}
				else {
					GiveWeapon(playerid, GetPVarInt(playerid,"makegun"), strval(inputtext));
					PI[playerid][pAmmo] -= strval(inputtext);
					new string[120];
				    format(string, sizeof(string), "%s собрал %s и добавил к нему %d пт",PI[playerid][pName], weapon_names[GetPVarInt(playerid,"makegun")], strval(inputtext));
					ProxDetector(30.0, playerid, string, 0xFF99CCFF, 0xFF99CCFF, 0xFF99CCFF, 0xFF99CCFF, 0xFF99CCFF);
					SetPlayerChatBubble(playerid, string, 0xFF99CCFF, 20.0, 4000);
					SavePlayerData(playerid);
					switch(GetPVarInt(playerid,"makegun")) {
						case 5: PI[playerid][pMetall] -= 1;
						case 22: PI[playerid][pMetall] -= 5;
						case 23: PI[playerid][pMetall] -= 3;
						case 24: PI[playerid][pMetall] -= 6;
					    case 25: PI[playerid][pMetall] -= 8;
					    case 26: PI[playerid][pMetall] -= 7;
					    case 27: PI[playerid][pMetall] -= 9;
					    case 28: PI[playerid][pMetall] -= 7;
					    case 29: PI[playerid][pMetall] -= 8;
				     	case 30: PI[playerid][pMetall] -= 9;
				   		case 31: PI[playerid][pMetall] -= 9;
					    case 32: PI[playerid][pMetall] -= 7;
					    case 33: PI[playerid][pMetall] -= 10;
					}

				}
			}
		}
		case 3953: 
		{
            if(!response) return ShowSettings(playerid);
			if(response) 
			{
			    switch(listitem) 
				{
			        case 0: 
					{
			            SetPlayerFightingStyle(playerid, FIGHT_STYLE_NORMAL);
			            SCM(playerid,COLOR_GREENNEW, !"Вы изменили стиль боя на 'Улучшеный'");
						
			        }
			        case 1: 
					{
			            SetPlayerFightingStyle(playerid, FIGHT_STYLE_BOXING);
			            SCM(playerid,COLOR_GREENNEW, !"Вы изменили стиль боя на 'Бокс'");
						
			        }
			        case 2: 
					{
			            SetPlayerFightingStyle(playerid, FIGHT_STYLE_KNEEHEAD);
			            SCM(playerid,COLOR_GREENNEW, !"Вы изменили стиль боя на 'Кик-боксинг'");
						
			        }
			        case 3: 
					{
			            SetPlayerFightingStyle(playerid, FIGHT_STYLE_KUNGFU);
			            SCM(playerid,COLOR_GREENNEW, !"Вы изменили стиль боя на 'Кунг-фу'");
			        }
			    }
			}
        }
        case 3952:
        {
            if(!response) return ShowSettings(playerid);
			if(response)
			{
                switch(listitem)
				{
		            case 0: SetPlayerWalkingStyle (playerid, WALK_NORMAL);
	             	case 1: SetPlayerWalkingStyle (playerid, WALK_PED);
		            case 2: SetPlayerWalkingStyle (playerid, WALK_GANGSTA);
		            case 3: SetPlayerWalkingStyle (playerid, WALK_GANGSTA2);
		            case 4: SetPlayerWalkingStyle (playerid, WALK_OLD);
		            case 5: SetPlayerWalkingStyle (playerid, WALK_FAT_OLD);
		            case 6: SetPlayerWalkingStyle (playerid, WALK_FAT);
		            case 7: SetPlayerWalkingStyle (playerid, WALK_LADY);
   		            case 8: SetPlayerWalkingStyle (playerid, WALK_LADY2);
		            case 9: SetPlayerWalkingStyle (playerid, WALK_WHORE);
		            case 10: SetPlayerWalkingStyle (playerid, WALK_WHORE2);
		            case 11: SetPlayerWalkingStyle (playerid, WALK_DRUNK);
		            case 12: SetPlayerWalkingStyle (playerid, WALK_BLIND);
		            case 13: SetPlayerWalkingStyle (playerid, WALK_DEFAULT);
	            }
	            SCM(playerid, COLOR_GREENNEW, "Вы изменили свой стиль походки. Использование: W + ALT");
			}
        }
		case 3950:
        {
            if(!response) return ShowMainMenu(playerid);
			if(response)
			{
			    switch(listitem)
			    {
			        case 0: 
					{
						ShowPlayerDialog(playerid, dialog_SETTING_1, DIALOG_STYLE_INPUT,\
						!"{ee3366}Изменение пароля", 
						!"Введите в поле ниже свой нынешний пароль\n\
						{FFFF99}Пример: 123qwe", !"Далее", !"Назад");
					}
			        case 1: 
					{
						ShowPlayerDialog(playerid, 3953, DIALOG_STYLE_LIST,\
						!"{ee3366}Стили боя", 
						!"1. Улучшеный\n\
						2. Бокс\n\
						3. Кик-боксинг\n\
						4. Кунг-фу", !"Выбрать", !"Назад");
					}
					case 2: 
					{
						ShowPlayerDialog(playerid, 3952, DIALOG_STYLE_LIST,\
						!"{ee3366}Стили походки",\
						!"1. Обычная\n\
						2. Гражданская\n\
						3. Бандитская (1)\n\
						4.Бандитская (2)\n\
						5. Пожилого мужчины\n\
						6. Пожилой женщины\n\
						7. Женская (1)\n\
						8. Женская (2)\n\
						9. Женская (3)\n\
						10. Проститутки (1)\n\
						11. Проститутки (2)\n\
						12. Пьяного\n\
						13. Слабовидящего\n\
						14. Стандартная", !"Выбрать", !"Назад");
					}
					case 3:
					{
						if(PI[playerid][pCinematicMode] == 1)
						{
							PI[playerid][pCinematicMode] = 0;
							cef_emit_event(playerid, "cef:hud:active", CEFINT(1));
						}
						else
						{
							PI[playerid][pCinematicMode] = 1;
							cef_emit_event(playerid, "cef:hud:active", CEFINT(0));
						}
					}
					case 4: 
					{
						ShowPlayerDialogf(playerid, 3951, DIALOG_STYLE_LIST, "{ee3366}Управление аксессуарами", "Выбрать", "Назад", "\
						{FFFFFF}1. Рога\t\t\t\t{FFFF99}%s\n\
						{FFFFFF}2. Голова Дед-Пула\t\t{FFFF99}%s\n\
						{FFFFFF}3. Голова Микки-Мауса\t{FFFF99}%s\n\
						{FFFFFF}4. Костюм гробовщик\t\t\t{FFFF99}%s\n\
						{FFFFFF}5. Огнемёт\t\t\t{FFFF99}%s\n\
						{FFFFFF}6. Красный чемодан\t\t{FFFF99}%s\n\
						{FFFFFF}7. Ёлка на плечо\t\t{FFFF99}%s\n\
						{FFFFFF}8. Ангельское кольцо\t\t{FFFF99}%s\n\
						{FFFFFF}9. Дигл на спину\t\t{FFFF99}%s\n\
						{FFFFFF}10. Шляпа фермера\t\t{FFFF99}%s\n\
						{FFFF99}Очистить акессуары\t\t{FFFF99}...", 
						(PI[playerid][pAccessory_1]) ? ("(куплен)") : ("(не куплен)"),
						(PI[playerid][pAccessory_2]) ? ("(куплен)") : ("(не куплен)"),
						(PI[playerid][pAccessory_3]) ? ("(куплен)") : ("(не куплен)"),
						(PI[playerid][pAccessory_4]) ? ("(куплен)") : ("(не куплен)"),
						(PI[playerid][pAccessory_5]) ? ("(куплен)") : ("(не куплен)"),
						(PI[playerid][pAccessory_6]) ? ("(куплен)") : ("(не куплен)"),
						(PI[playerid][pAccessory_7]) ? ("(куплен)") : ("(не куплен)"),
						(PI[playerid][pAccessory_8]) ? ("(куплен)") : ("(не куплен)"),
						(PI[playerid][pAccessory_9]) ? ("(куплен)") : ("(не куплен)"),
						(PI[playerid][pAccessory_10]) ? ("(куплен)") : ("(не куплен)"));
					}
				}
			}
        }
		case 3951: 
		{
			if(!response) return 1;
			if(response) 
			{
				if(PI[playerid][pTempJob] == 2) return SendClientMessage(playerid, COLOR_LIGHTGREY, !"Во время данной работы Вы не можете установить себе аксессуары");
				switch(listitem) 
				{
		            case 0: 
					{
						if(PI[playerid][pAccessory_1] != 1) return ShowPlayerDialog(playerid, 0, DIALOG_STYLE_MSGBOX, !"{ff5511}Ошибка", !"{FFFFFF}У Вас нет данного аксессуара, купите его в /donate", "Закрыть", "");
						PI[playerid][pUseAccessory] = 1;
						for(new i; i < 10; i++) RemovePlayerAttachedObject(playerid, i);
						SetAccessory(playerid);
						UpdatePlayerDataInt(playerid, "UseAccessory", PI[playerid][pUseAccessory]);
						SCM(playerid, 0x33ccffFF, !"Вы успешно одели данный акессуар.");
						return 1;
		            }
		            case 1: 
					{
						if(PI[playerid][pAccessory_2] != 1) return ShowPlayerDialog(playerid, 0, DIALOG_STYLE_MSGBOX, !"{ff5511}Ошибка", !"{FFFFFF}У Вас нет данного аксессуара, купите его в /donate", "Закрыть", "");
						PI[playerid][pUseAccessory] = 2;
						for(new i; i < 10; i++) RemovePlayerAttachedObject(playerid, i);
						SetAccessory(playerid);
						UpdatePlayerDataInt(playerid, "UseAccessory", PI[playerid][pUseAccessory]);
						SCM(playerid, 0x33ccffFF, !"Вы успешно одели данный акессуар.");
						return 1;
		            }
		            case 2: 
					{
						if(PI[playerid][pAccessory_3] != 1) return ShowPlayerDialog(playerid, 0, DIALOG_STYLE_MSGBOX, !"{ff5511}Ошибка", !"{FFFFFF}У Вас нет данного аксессуара, купите его в /donate", "Закрыть", "");
						PI[playerid][pUseAccessory] = 3;
						for(new i; i < 10; i++) RemovePlayerAttachedObject(playerid, i);
						SetAccessory(playerid);
						UpdatePlayerDataInt(playerid, "UseAccessory", PI[playerid][pUseAccessory]);
						SCM(playerid, 0x33ccffFF, !"Вы успешно одели данный акессуар.");
						return 1;
					}
					case 3: 
					{
						if(PI[playerid][pAccessory_4] != 1) return ShowPlayerDialog(playerid, 0, DIALOG_STYLE_MSGBOX, !"{ff5511}Ошибка", !"{FFFFFF}У Вас нет данного аксессуара, купите его в /donate", "Закрыть", "");
						PI[playerid][pUseAccessory] = 4;
						for(new i; i < 10; i++) RemovePlayerAttachedObject(playerid, i);
						SetAccessory(playerid);
						UpdatePlayerDataInt(playerid, "UseAccessory", PI[playerid][pUseAccessory]);
						SCM(playerid, 0x33ccffFF, !"Вы успешно одели данный акессуар.");
						return 1;
					}
					case 4: {
						if(PI[playerid][pAccessory_5] != 1) return ShowPlayerDialog(playerid, 0, DIALOG_STYLE_MSGBOX, !"{ff5511}Ошибка", !"{FFFFFF}У Вас нет данного аксессуара, купите его в /donate", "Закрыть", "");
						PI[playerid][pUseAccessory] = 5;
						for(new i; i < 10; i++) RemovePlayerAttachedObject(playerid, i);
						SetAccessory(playerid);
						UpdatePlayerDataInt(playerid, "UseAccessory", PI[playerid][pUseAccessory]);
						SCM(playerid, 0x33ccffFF, !"Вы успешно одели данный акессуар.");
						return 1;
					}
					case 5: {
						if(PI[playerid][pAccessory_6] != 1) return ShowPlayerDialog(playerid, 0, DIALOG_STYLE_MSGBOX, !"{ff5511}Ошибка", !"{FFFFFF}У Вас нет данного аксессуара, купите его в /donate", "Закрыть", "");
						PI[playerid][pUseAccessory] = 6;
						for(new i; i < 10; i++) RemovePlayerAttachedObject(playerid, i);
						SetAccessory(playerid);
						UpdatePlayerDataInt(playerid, "UseAccessory", PI[playerid][pUseAccessory]);
						SCM(playerid, 0x33ccffFF, !"Вы успешно одели данный акессуар.");
						return 1;
					}
					case 6: {
						if(PI[playerid][pAccessory_7] != 1) return ShowPlayerDialog(playerid, 0, DIALOG_STYLE_MSGBOX, !"{ff5511}Ошибка", !"{FFFFFF}У Вас нет данного аксессуара, купите его в /donate", "Закрыть", "");
						PI[playerid][pUseAccessory] = 7;
						for(new i; i < 10; i++) RemovePlayerAttachedObject(playerid, i);
						SetAccessory(playerid);
						UpdatePlayerDataInt(playerid, "UseAccessory", PI[playerid][pUseAccessory]);
						SCM(playerid, 0x33ccffFF, !"Вы успешно одели данный акессуар.");
						return 1;
					}
					case 7: {
						if(PI[playerid][pAccessory_8] != 1) return ShowPlayerDialog(playerid, 0, DIALOG_STYLE_MSGBOX, !"{ff5511}Ошибка", !"{FFFFFF}У Вас нет данного аксессуара, купите его в /donate", "Закрыть", "");
						PI[playerid][pUseAccessory] = 8;
						for(new i; i < 10; i++) RemovePlayerAttachedObject(playerid, i);
						SetAccessory(playerid);
						UpdatePlayerDataInt(playerid, "UseAccessory", PI[playerid][pUseAccessory]);
						SCM(playerid, 0x33ccffFF, !"Вы успешно одели данный акессуар.");
						return 1;
					}
					case 8: {
						if(PI[playerid][pAccessory_9] != 1) return ShowPlayerDialog(playerid, 0, DIALOG_STYLE_MSGBOX, !"{ff5511}Ошибка", !"{FFFFFF}У Вас нет данного аксессуара, купите его в /donate", "Закрыть", "");
						PI[playerid][pUseAccessory] = 9;
						for(new i; i < 10; i++) RemovePlayerAttachedObject(playerid, i);
						SetAccessory(playerid);
						UpdatePlayerDataInt(playerid, "UseAccessory", PI[playerid][pUseAccessory]);
						SCM(playerid, 0x33ccffFF, !"Вы успешно одели данный акессуар.");
						return 1;
					}
					case 9: {
						if(PI[playerid][pAccessory_10] != 1) return ShowPlayerDialog(playerid, 0, DIALOG_STYLE_MSGBOX, !"{ff5511}Ошибка", !"{FFFFFF}У Вас нет данного аксессуара, купите его в /donate", "Закрыть", "");
						PI[playerid][pUseAccessory] = 10;
						for(new i; i < 10; i++) RemovePlayerAttachedObject(playerid, i);
						SetAccessory(playerid);
						UpdatePlayerDataInt(playerid, "UseAccessory", PI[playerid][pUseAccessory]);
						SCM(playerid, 0x33ccffFF, !"Вы успешно одели данный акессуар.");
						return 1;
					}
					case 10: {
						if(PI[playerid][pUseAccessory] == 0) return ShowPlayerDialog(playerid, 0, DIALOG_STYLE_MSGBOX, !"{ff5511}Ошибка", !"{FFFFFF}У Вас нет использованных аксессуаров", "Закрыть", "");
						PI[playerid][pUseAccessory] = 0;
						for(new i; i < 10; i++) RemovePlayerAttachedObject(playerid, i);
						UpdatePlayerDataInt(playerid, "UseAccessory", PI[playerid][pUseAccessory]);
						SCM(playerid, 0x33ccffFF, !"Вы успешно очистили все акессуары.");
						return 1;
					}
				}
			}
		}
		case dialog_SETTING_2:
		{
		    if(!response) return ShowSettings(playerid);
            if(response)
			{
			    if(strlen(inputtextsave) == 0) return ShowPlayerDialog(playerid, dialog_SETTING_2, DIALOG_STYLE_INPUT, !"{ee3366}Изменение пароля","{FFFFFF}Введите в поле ниже новый пароль от аккаунта\n{FFFF99}Пример: 12345qwe", "Далее", "Назад");
				if(strlen(inputtextsave) < 6 || strlen(inputtextsave) > 30) return SCM(playerid, COLOR_GREY, !"Длина пароля должна быть от 6 до 30 символов"),ShowPlayerDialog(playerid, dialog_SETTING_2, DIALOG_STYLE_INPUT, !"{ee3366}Изменение пароля","Введите в поле ниже новый пароль от аккаунта\n{FFFF99}Пример: 12345qwe", "Далее", "Назад");
        		for(new i = strlen(inputtextsave); i != 0; --i)
				switch(inputtextsave[i]) {
					case 'А'..'Я', 'а'..'я', ',', '`', '=': return SCM(playerid, COLOR_HINT, "[Подсказка]: {FFFFFF}Разрешено использовать {6699ff}только{FFFFFF} латинские буквы и цифры"),ShowPlayerDialog(playerid, dialog_SETTING_2, DIALOG_STYLE_INPUT, !"{ee3366}Изменение пароля","Введите в поле ниже новый пароль от аккаунта\n{FFFF99}Пример: 12345qwe", "Далее", "Назад");
				}
				strmid(PI[playerid][pPassword], inputtextsave, 0, strlen(inputtextsave), 30);
				mf(mysql, mysql_string, 130, "UPDATE `accounts` SET `Password` = md5('%e') WHERE `Name` = '%e'",PI[playerid][pPassword],PI[playerid][pName]);
    			mysql_function_query(mysql, mysql_string, false, "", "");
				SCMf(playerid, COLOR_HINT, "[Внимание]: {FFFFFF}Ваш новый пароль: %s. Обязательно сделайте скриншот {6699ff}'F8'", inputtextsave);

            }
		}
		case dialog_SETTING_1:
        {
            if(!response) return ShowSettings(playerid);
			if(response)
			{
			    if(strlen(inputtextsave) == 0) return ShowPlayerDialog(playerid, dialog_SETTING_1, DIALOG_STYLE_INPUT, !"{ee3366}Изменение пароля", "{FFFFFF}Введите в поле ниже свой нынешний пароль\n{FFFF99}Пример: 123qwe", "Далее", "Назад");
				if(strlen(inputtextsave) < 6 || strlen(inputtextsave) > 30) return SCM(playerid, COLOR_GREY, !"Длина пароля должна быть от 6 до 30 символов"),ShowPlayerDialog(playerid, dialog_SETTING_1, DIALOG_STYLE_INPUT, !"{ee3366}Изменение пароля","Введите в поле ниже свой нынешний пароль\n{FFFF99}Пример: 123qwe", "Далее", "Назад");
        		for(new i = strlen(inputtextsave); i != 0; --i)
				switch(inputtextsave[i])
				{
					case 'А'..'Я', 'а'..'я': return SCM(playerid, COLOR_HINT, "[Подсказка]: {FFFFFF}Разрешено использовать {FFFF33}только{FFFFFF} латинские буквы и цифры"),ShowPlayerDialog(playerid, dialog_SETTING_1, DIALOG_STYLE_INPUT, !"{ee3366}Изменение пароля","Введите в поле ниже свой нынешний пароль\n{FFFF99}Пример: 123qwe", "Далее", "Назад");
				}
    			strmid(PI[playerid][pPassword], inputtextsave, 0, strlen(inputtextsave), 30);
				mf(mysql, mysql_string, 130, "SELECT * FROM `accounts` WHERE `Name` = '%e' AND `Password` = md5('%e')",PI[playerid][pName],PI[playerid][pPassword]);
				mysql_function_query(mysql, mysql_string, true, "ChangePassword", "d", playerid);
			}
		}
		case 1250:
  		{
  		    if(!response) return ShowMainMenu(playerid);
   			if(response)
   			{
   			    if(PI[playerid][pMute] != 0) return SCM(playerid, COLOR_GREY,"У Вас мут");
  				if(strlen(inputtext) < 1 || strlen(inputtext) > 100) return SCM(playerid, COLOR_GREY,"Не менее 1 и не более 100 символов"),ReportDialog(playerid);
   				SendAdminsMessagef(0xFFFF99FF, "Вопрос от %s[%d]:{FFFFFF} %s",PI[playerid][pName],playerid,inputtext);
				SCMf(playerid,0xFFFF99FF, "Вопрос от %s[%d]:{FFFFFF} %s",PI[playerid][pName],playerid,inputtext);
			}
    	}
		case 1251:
  		{
  		    if(!response) return ShowMainMenu(playerid);
   			if(response)
   			{
  				if(strlen(inputtext) < 1 || strlen(inputtext) > 100) return SCM(playerid, COLOR_GREY,"Не менее 1 и не более 100 символов"),ReportDialog(playerid);
	   			SendAdminsMessagef(0xFF8877FF, "Жалоба от %s[%d]:{FFFFFF} %s",PI[playerid][pName],playerid,inputtext);
				SCMf(playerid,0xFF8877FF, "Жалоба от %s[%d]:{FFFFFF} %s",PI[playerid][pName],playerid,inputtext);
				SCM(playerid, 0xFF8877FF, "Вы можете заблокировать голосовой чат игрока {FFFF99}O{FF8877}");
			}
    	}
		case dialog_REPORT: {
            if(!response) return ShowMainMenu(playerid);
			if(response) {
			    switch(listitem) {
			        case 0: {
						ShowPlayerDialog(playerid, 1250, DIALOG_STYLE_INPUT, "{ee3366}Вопрос или жалоба", "\
						{FFFFFF}Введите сообщение для игровых мастеров. Пишите кратко и по делу.\n\
						Перед тем, как задать вопрос, проверьте, нет ли ответа в меню помощи - {ee3366}/help\n\
						{696969}Обратите внимание: за оффтоп Вы можете получить блокировку чата", "Далее", "Отмена");
			        }
			        case 1: {
						ShowPlayerDialog(playerid, 1251, DIALOG_STYLE_INPUT, "{ee3366}Вопрос или жалоба", "\
						{FFFFFF}Введите сообщение для игровых мастеров. Пишите кратко и по делу.\n\
						Перед тем, как задать вопрос, проверьте, нет ли ответа в меню помощи - {ee3366}/help\n\
						{696969}Обратите внимание: за оффтоп Вы можете получить блокировку чата", "Далее", "Отмена");
			        }
			    }
			}
        }
		case 7610: {
			if(!response) return 1;
			if(response) {
				PI[playerid][pTempStopWar] = StopWar_cfg[listitem][frac_id];
				ShowPlayerDialog(playerid,7611, DIALOG_STYLE_LIST, "{ee3366}Заморозка территорий", "1. 60 минут\n2. 120 минут\n3. 3 часа\n4. 4 часа\n5. 5 часов\n6. 6 часов\n7. 7 часов\n8. 8 часов\n9. 9 часов\n10. 10 часов\n11. 24 часа\n12. 48 часов\n{FFFF99}Снять заморозку", "Выбор", "Закрыть");
			}
		}
		case 7611: {
			if(!response) return 1;
			if(response) {
				new status = 0;
				switch(listitem) {
					case 0: {
						status = 2;
						if(PI[playerid][pTempStopWar] == 5) m_skinhead = 60;
						if(PI[playerid][pTempStopWar] == 6) m_gopota = 60;
						if(PI[playerid][pTempStopWar] == 7) m_kavkaz = 60;
						SCMf(playerid, COLOR_GREENNEW, "Вы выдали заморозку стрел для организации {FFFF00}('%s') {00aa33}на 1 час", Fraction_Name[PI[playerid][pTempStopWar]]);
					}
					case 1: {
						status = 2;
						if(PI[playerid][pTempStopWar] == 5) m_skinhead = 120;
						if(PI[playerid][pTempStopWar] == 6) m_gopota = 120;
						if(PI[playerid][pTempStopWar] == 7) m_kavkaz = 120;
						SCMf(playerid, COLOR_GREENNEW, "Вы выдали заморозку стрел для организации {FFFF00}('%s') {00aa33}на 2 часа", Fraction_Name[PI[playerid][pTempStopWar]]);
					}
					case 2: {
						status = 2;
						if(PI[playerid][pTempStopWar] == 5) m_skinhead = 180;
						if(PI[playerid][pTempStopWar] == 6) m_gopota = 180;
						if(PI[playerid][pTempStopWar] == 7) m_kavkaz = 180;
						SCMf(playerid, COLOR_GREENNEW, "Вы выдали заморозку стрел для организации {FFFF00}('%s') {00aa33}на 3 часа", Fraction_Name[PI[playerid][pTempStopWar]]);
					}
					case 3: {
						status = 2;
						if(PI[playerid][pTempStopWar] == 5) m_skinhead = 240;
						if(PI[playerid][pTempStopWar] == 6) m_gopota = 240;
						if(PI[playerid][pTempStopWar] == 7) m_kavkaz = 240;
						SCMf(playerid, COLOR_GREENNEW, "Вы выдали заморозку стрел для организации {FFFF00}('%s') {00aa33}на 4 часа", Fraction_Name[PI[playerid][pTempStopWar]]);
					}
					case 4: {
						status = 2;
						if(PI[playerid][pTempStopWar] == 5) m_skinhead = 300;
						if(PI[playerid][pTempStopWar] == 6) m_gopota = 300;
						if(PI[playerid][pTempStopWar] == 7) m_kavkaz = 300;
						SCMf(playerid, COLOR_GREENNEW, "Вы выдали заморозку стрел для организации {FFFF00}('%s') {00aa33}на 5 часов", Fraction_Name[PI[playerid][pTempStopWar]]);
					}
					case 5: {
						status = 2;
						if(PI[playerid][pTempStopWar] == 5) m_skinhead = 360;
						if(PI[playerid][pTempStopWar] == 6) m_gopota = 360;
						if(PI[playerid][pTempStopWar] == 7) m_kavkaz = 360;
						SCMf(playerid, COLOR_GREENNEW, "Вы выдали заморозку стрел для организации {FFFF00}('%s') {00aa33}на 6 часов", Fraction_Name[PI[playerid][pTempStopWar]]);
					}
					case 6: {
						status = 2;
						if(PI[playerid][pTempStopWar] == 5) m_skinhead = 420;
						if(PI[playerid][pTempStopWar] == 6) m_gopota = 420;
						if(PI[playerid][pTempStopWar] == 7) m_kavkaz = 420;
						SCMf(playerid, COLOR_GREENNEW, "Вы выдали заморозку стрел для организации {FFFF00}('%s') {00aa33}на 7 часов", Fraction_Name[PI[playerid][pTempStopWar]]);
					}
					case 7: {
						status = 2;
						if(PI[playerid][pTempStopWar] == 5) m_skinhead = 480;
						if(PI[playerid][pTempStopWar] == 6) m_gopota = 480;
						if(PI[playerid][pTempStopWar] == 7) m_kavkaz = 480;
						SCMf(playerid, COLOR_GREENNEW, "Вы выдали заморозку стрел для организации {FFFF00}('%s') {00aa33}на 8 часов", Fraction_Name[PI[playerid][pTempStopWar]]);
					}
					case 8: {
						status = 2;
						if(PI[playerid][pTempStopWar] == 5) m_skinhead = 540;
						if(PI[playerid][pTempStopWar] == 6) m_gopota = 540;
						if(PI[playerid][pTempStopWar] == 7) m_kavkaz = 540;
						SCMf(playerid, COLOR_GREENNEW, "Вы выдали заморозку стрел для организации {FFFF00}('%s') {00aa33}на 9 часов", Fraction_Name[PI[playerid][pTempStopWar]]);
					}
					case 9: {
						status = 2;
						if(PI[playerid][pTempStopWar] == 5) m_skinhead = 600;
						if(PI[playerid][pTempStopWar] == 6) m_gopota = 600;
						if(PI[playerid][pTempStopWar] == 7) m_kavkaz = 600;
						SCMf(playerid, COLOR_GREENNEW, "Вы выдали заморозку стрел для организации {FFFF00}('%s') {00aa33}на 10 часов", Fraction_Name[PI[playerid][pTempStopWar]]);
					}
					case 10: {
						status = 2;
						if(PI[playerid][pTempStopWar] == 5) m_skinhead = 1445;
						if(PI[playerid][pTempStopWar] == 6) m_gopota = 1445;
						if(PI[playerid][pTempStopWar] == 7) m_kavkaz = 1445;
						SCMf(playerid, COLOR_GREENNEW, "Вы выдали заморозку стрел для организации {FFFF00}('%s') {00aa33}на 24 часа", Fraction_Name[PI[playerid][pTempStopWar]]);
					}
					case 11: {
						status = 2;
						if(PI[playerid][pTempStopWar] == 5) m_skinhead = 2890;
						if(PI[playerid][pTempStopWar] == 6) m_gopota = 2890;
						if(PI[playerid][pTempStopWar] == 7) m_kavkaz = 2890;
						SCMf(playerid, COLOR_GREENNEW, "Вы выдали заморозку стрел для организации {FFFF00}('%s') {00aa33}на 48 часов", Fraction_Name[PI[playerid][pTempStopWar]]);
					}
					case 12: {
						if(PI[playerid][pTempStopWar] == 5) if(m_skinhead == 0) return SCM(playerid, COLOR_GREY,"У данной организации нет мороза!");
						if(PI[playerid][pTempStopWar] == 6) if(m_gopota == 0) return SCM(playerid, COLOR_GREY,"У данной организации нет мороза!");
						if(PI[playerid][pTempStopWar] == 7) if(m_kavkaz == 0) return SCM(playerid, COLOR_GREY,"У данной организации нет мороза!");
						if(PI[playerid][pTempStopWar] == 5) m_skinhead = 0;
						if(PI[playerid][pTempStopWar] == 6) m_gopota = 0;
						if(PI[playerid][pTempStopWar] == 7) m_kavkaz = 0;
						SCMf(playerid, COLOR_GREENNEW, "Вы сняли заморозку стрел для организации {FFFF00}('%s')", Fraction_Name[PI[playerid][pTempStopWar]]);
						status = 1;
					}
				}
				if(status == 1) 
				{
					PI[playerid][pTempStopWar] = -1;
					SaveWarehouse();
				}
				else if(status == 2)
				{
					PI[playerid][pTempStopWar] = -1;
					SaveWarehouse();
				}
			}
		}
		case 1932:
		{
			if(!response) return 1;
			if(response) 
			{
				switch(listitem)
				{
					case 0: 
					{
						SetPlayerVirtualWorld(playerid, 1);
						SetPlayerInterior(playerid, 1);

						SetPlayerPos(playerid, 2129.0225,1536.2969,-47.2944);
						SetPlayerFacingAngle(playerid, 271.4833);
						SetCameraBehindPlayer(playerid);
						Freeze(playerid);
						return true;
					}
					case 1:
					{
						SetPlayerVirtualWorld(playerid, 1);
						SetPlayerInterior(playerid, 1);

						SetPlayerPos(playerid, 2114.1545,1494.5404,-47.5444);
						SetPlayerFacingAngle(playerid, 269.2256);
						SetCameraBehindPlayer(playerid);
						Freeze(playerid);
						return true;
					}
					case 2:
					{
						SetPlayerVirtualWorld(playerid, 1);
						SetPlayerInterior(playerid, 1);

						SetPlayerPos(playerid, 2067.2344,1502.3389,-47.5044);
						SetPlayerFacingAngle(playerid, 270.2444);
						SetCameraBehindPlayer(playerid);
						Freeze(playerid);
						return true;
					}
				}
			}
		}
		case 5898: 
		{
			if(!response) return 1;
			if(response) 
			{
				switch(listitem)
				{
					case 0: 
					{
						GetPlayerPos(playerid, gomp_pos[0],gomp_pos[1],gomp_pos[2]);
						MPStatus = true;
						SendAdminsMessagef(COLOR_ADMINCHAT, "[%s #%d] %s[%d] изменил точку телепорта на мероприятие", AdminName[PI[playerid][pAdmin]], PI[playerid][pAdminNumber], PI[playerid][pName], playerid);
						callcmd::editmp(playerid);
					}
					case 1: ShowPlayerDialog(playerid, 5899, DIALOG_STYLE_INPUT, "{ee3366}Выдача одежды", "{FFFFFF}Напишите: [тип: 1, 2, 3] [ID-скина]\n{FFFF99}Пример: 3,23", "Выдать", "Закрыть");
					case 2: ShowPlayerDialog(playerid, 5900, DIALOG_STYLE_INPUT, "{ee3366}Выдача оружия", "{FFFFFF}Напишите: [тип: 1, 2, 3] [ID-оружия] [ПТ]\n{FFFF99}Пример: 3,24,500", "Выдать", "Закрыть");
					case 3: 
					{
						SendAdminsMessagef(COLOR_ADMINCHAT, "[%s #%d] %s[%d] выдал бронежилет всем участникам мероприятия", AdminName[PI[playerid][pAdmin]], PI[playerid][pAdminNumber], PI[playerid][pName], playerid);
						new Float:x, Float:y, Float:z;
						GetPlayerPos(playerid, x,y,z);
						for(new i = 0; i < MAX_PLAYERS; i++) 
						{
							if(!IsPlayerConnected(i)) continue;
							if(PlayerToPoint(100.0, i, x,y,z)) 
							{
								SetPlayerArmourAC(i, 100);
								SCM(i, -1, !"Игровой мастер выдал Вам бронижелет");
							}
						}
						callcmd::editmp(playerid);
					}
					case 4: 
					{
						SendAdminsMessagef(COLOR_ADMINCHAT, "[%s #%d] %s[%d] выдал здоровье всем участникам мероприятия", AdminName[PI[playerid][pAdmin]], PI[playerid][pAdminNumber], PI[playerid][pName], playerid);
						new Float:x, Float:y, Float:z;
						GetPlayerPos(playerid, x,y,z);
						for(new i = 0; i < MAX_PLAYERS; i++) 
						{
							if(!IsPlayerConnected(i)) continue;
							if(PlayerToPoint(100.0, i, x,y,z)) 
							{
								SetPlayerHealthAC(i, 176);
								SCMf(i, -1,"Игровой мастер изменил уровень Вашего здоровья", PI[playerid][pAdminNumber]);
								PI[i][pHospital] = 0;
							}
						}
						callcmd::editmp(playerid);
					}
					case 5: 
					{
						if(MPTeamKill == true) 
						{
							MPTeamKill = false;
							SendAdminsMessagef(COLOR_ADMINCHAT, "[%s #%d] %s[%d] выключил убийствой тиммейтов на мероприятии", AdminName[PI[playerid][pAdmin]], PI[playerid][pAdminNumber], PI[playerid][pName], playerid);
						}
						else 
						{
							MPTeamKill = true;
							SendAdminsMessagef(COLOR_ADMINCHAT, "[%s #%d] %s[%d] включил убийствой тиммейтов на мероприятии", AdminName[PI[playerid][pAdmin]], PI[playerid][pAdminNumber], PI[playerid][pName], playerid);
						}
						callcmd::editmp(playerid);
					}
					case 6: 
					{
						MPStatus = false;
						SendAdminsMessagef(COLOR_ADMINCHAT, "[%s #%d] %s[%d] остановил точку телепорта на мероприятии", AdminName[PI[playerid][pAdmin]], PI[playerid][pAdminNumber], PI[playerid][pName], playerid);
						for(new i = 0; i < MAX_PLAYERS; i++) 
						{
							SCM(i, 0xff2457FF, "Игровой мастер завершил мероприятие");
							if(PI[i][pOnMP] == 1) 
							{
								PI[i][pOnMP] = 0;
								SetPlayerPos(playerid, PI[i][pOnMPX], PI[i][pOnMPY], PI[i][pOnMPZ]+2);
								SetPlayerInterior(i, 0);
								SetPlayerVirtualWorld(i, 0);
							}
						}
						callcmd::editmp(playerid);
					}
					case 7: 
					{
						MPStatus = false;
						SendAdminsMessagef(COLOR_ADMINCHAT, "[%s #%d] %s[%d] остановил точку телепорта на мероприятие без респавна", AdminName[PI[playerid][pAdmin]], PI[playerid][pAdminNumber], PI[playerid][pName], playerid);
						callcmd::editmp(playerid);
					}
				}
			}
		}
		case 5899: 
		{
			if(!response) return 1;
			if(response) 
			{
				new type,id,str[35];
				sscanf(inputtext, "p<,>dd", type, id);
				if(type == 0) return ShowPlayerDialog(playerid, 5899, DIALOG_STYLE_INPUT, "{ee3366}Выдача одежды", "{FFFFFF}Напишите: [тип: 1, 2, 3] [ID-скина]\n{FFFF99}Пример: 3,23", "Выдать", "Закрыть");
				if(id == 0) return ShowPlayerDialog(playerid, 5899, DIALOG_STYLE_INPUT, "{ee3366}Выдача одежды", "{FFFFFF}Напишите: [тип: 1, 2, 3] [ID-скина]\n{FFFF99}Пример: 3,23", "Выдать", "Закрыть");
                format(str,sizeof str,"%d %d", type, id);
				callcmd::mpskin(playerid, str);
				callcmd::editmp(playerid);
			}
		}
		case 5900: 
		{
			if(!response) return 1;
			if(response) 
			{
				new type, id, pt, str[35];
				sscanf(inputtext, "p<,>ddd", type, id, pt);
				if(type == 0) return  ShowPlayerDialog(playerid, 5900, DIALOG_STYLE_INPUT, "{ee3366}Выдача оружия", "{FFFFFF}Напишите: [тип: 1, 2, 3] [ID-оружия] [ПТ]\n{FFFF99}nПример: 3,24,500", "Выдать", "Закрыть");
				if(pt == 0) return ShowPlayerDialog(playerid, 5900, DIALOG_STYLE_INPUT, "{ee3366}Выдача оружия", "{FFFFFF}Напишите: [тип: 1, 2, 3] [ID-оружия] [ПТ]\n{FFFF99}Пример: 3,24,500", "Выдать", "Закрыть");
				if(id == 0) return ShowPlayerDialog(playerid, 5900, DIALOG_STYLE_INPUT, "{ee3366}Выдача оружия", "{FFFFFF}Напишите: [тип: 1, 2, 3] [ID-оружия] [ПТ]\n{FFFF99}Пример: 3,24,500", "Выдать", "Закрыть");
                format(str,sizeof str,"%d %d %d", type, id, pt);
				callcmd::mpgun(playerid, str);
				callcmd::editmp(playerid);
			}
		}
		case 1231: 
		{
			if(!response) return 1;
			if(response) 
			{
				new Float:x, Float:y, Float:z;
				GetPlayerPos(playerid, x, y, z);
				PI[playerid][pOnMPX] = x;
				PI[playerid][pOnMPY] = y;
				PI[playerid][pOnMPZ] = z;
				PI[playerid][pOnMP] = 1;
				SetPlayerPosAC(playerid, gomp_pos[0],gomp_pos[1],gomp_pos[2]);
				SetPlayerInterior(playerid, 0);
				SetPlayerVirtualWorld(playerid, 0);

				SetPlayerSkillLevel(playerid, WEAPONSKILL_PISTOL, 100*10);
				SetPlayerSkillLevel(playerid, WEAPONSKILL_PISTOL_SILENCED, 100*10);
				SetPlayerSkillLevel(playerid, WEAPONSKILL_DESERT_EAGLE, 100*10);
				SetPlayerSkillLevel(playerid, WEAPONSKILL_SHOTGUN, 100*10);
				SetPlayerSkillLevel(playerid, WEAPONSKILL_MP5, 100*10);
				SetPlayerSkillLevel(playerid, WEAPONSKILL_AK47, 100*10);
				SetPlayerSkillLevel(playerid, WEAPONSKILL_SNIPERRIFLE, 100*10);
			}
		}
		case 1232: 
		{
			if(!response) return 1;
			if(response) 
			{
				PI[playerid][pOnMP] = 0;
				SetPlayerPos(playerid, PI[playerid][pOnMPX], PI[playerid][pOnMPY], PI[playerid][pOnMPZ]+2);
				SetPlayerInterior(playerid,0);
				SetPlayerVirtualWorld(playerid,0);
			    DeletePVar(playerid, "ac_fly");

				SetPlayerSkills(playerid);
			}
		}
 		case dialog_ADMCOMMAND:
		{
		    if(!response) return 1;
			if(response)
   			{
				switch(listitem)
				{
				   	case 0: 
					{
						ShowPlayerDialog(playerid, dialog_ABACK, DIALOG_STYLE_MSGBOX, !"{ee3366}Команды игрового мастера",
						!"admins - список администраторов в сети\n\
						az - телепортация в админ-зону\n\
						moders - список модераторов в сети\n\
						spawn - заспавнить игрока\n\
						vw - перейти в другой виртуальный мир\n\
						tpcor - телепортироваться на координаты\n\
						skin - выдать скин игроку\n\
						goto - телепортироваться к игроку\n\
						a - чат админов и модераторов\n\
						tp (F2) - меню телепортации\n\
						sethp - установить уровень здоровья\n\
						flip - починить транспорт\n\
						sp - следить за игроком\n\
						spawncars - заспавнить транспорт по его ID\n\
						freeze - заморозить/разморозить игрока\n\
						ans - ответить игроку", "Назад", "Выход");
					}
					case 1: 
					{
						ShowPlayerDialog(playerid, dialog_ABACK, DIALOG_STYLE_MSGBOX, !"{ee3366}Команды игрового мастера",
						!"gethere - телепортировать игрока к себе\n\
						veh - создать транспортное средство\n\
						dveh - удалить созданную машину\n\
						unmute - снять блокировку текстового чата\n\
						setarm - выдать бронежилет\n\
						vmute - выдать блокировку голосового чата\n\
						unvmute - снять блокировку голосового чата\n\
						mute - выдать блокировку текстового чата\n\
						kick - кикнуть игрока\n\
						slap - подкинуть игрока\n\
						unjail - выпустить игрока из деморгана\n\
						unprison - выпустить игрока из КПЗ\n\
						cc - очистить чат\n\
						prison - быстрые наказания\n\
						jail - посадить игрока в деморган", "Назад", "Выход");
					}
					case 2: 
					{
						ShowPlayerDialog(playerid, dialog_ABACK, DIALOG_STYLE_MSGBOX, !"{ee3366}Команды игрового мастера",
						!"spawncar - заспавнить транспортное средство\n\
						setfuel - установить уровень топлива транспортному средству\n\
						gun - выдать оружие игроку\n\
						bangun - выдать блокировку на использование оружия\n\
						unbangun - снять блокировку на использование оружия\n\
						aclear - обнулить розыск игроку\n\
						resgun - забрать оружие у игрока\n\
						setmember - выдать ранг в организации игроку\n\
						agivelic - выдать водительские права игроку\n\
						ahp - выдать здоровье игрокам в радиусе\n\
						punishment - посмотреть историю наказаний игрока\n\
						atw - забрать оружие у игроков в радиусе\n\
						getcar - телепортировать машину к себе\n\
						check - посмотреть статистику игрока", "Назад", "Выход");
					}
					case 3: 
					{
						ShowPlayerDialog(playerid, dialog_ABACK, DIALOG_STYLE_MSGBOX, !"{ee3366}Команды игрового мастера",
						!"unwarn - снять предупреждение игроку\n\
						giveskill - выдать навыки стрельбы игроку\n\
						mphp - выдать здоровье игрокам на мероприятии\n\
						mparm - выдать броню игрокам на мероприятии\n\
						mpskin - выдать одежду игрокам на мероприятии\n\
						mpgun - выдать оружие игрокам на мероприятии\n\
						editmp - настройи мероприятия\n\
						setmp - установить место телепорта на мероприятие\n\
						givegod - выдать режим бога игроку\n\
						offmute - выдать блокировку текстового чата оффлайн\n\
						offjail - посадить в деморган оффлайн\n\
						offvmute - выдать блокировку голосового чата оффлайн\n\
						offunvmute - снять блокировку голосового чата оффлайн\n\
						offunjail - выпустить из деморгана оффлайн\n\
						offunmute - снять блокировку текстового чата оффлайн\n\
						offwarn - выдать предупреждение оффлайн\n\
						offunwarn - снять предупреждение оффлайн\n\
						warn - выдать предупреждение игроку", "Назад", "Выход");
					}
					case 4: 
					{
						ShowPlayerDialog(playerid, dialog_ABACK, DIALOG_STYLE_MSGBOX, 
						!"{ee3366}Команды игрового мастера",\
						!"ban - выдать блокировку игроку\n\
						setgz - перекрасить территорию\n\
						msg - написать сообщение на весь сервер\n\
						astorage - настройки склада ВЧ\n\
						setleader - назначить на пост лидера\n\
						auninvite - уволить из организации\n\
						luninvite - снять с поста лидера\n\
						givevb - выдать военный билет\n\
						unban - снять блокировку аккаунта\n\
						offleader - снять лидера оффлайн\n\
						stopwar - заморозить капты\n\
						offban - заблокировать игрока оффлайн\n\
						givecard - выдать медицинскую карту игроку\n\
						change - подтвердить смену никнейма игрока\n\
						checkoff - посмотреть статистику игрока оффлайн", "Назад", "Выход");
					}
					case 5: 
					{
						ShowPlayerDialog(playerid, dialog_ABACK, DIALOG_STYLE_MSGBOX, !"{ee3366}Команды игрового мастера",
						!"banip - выдать блокировку по IP\n\
						unbanip - разблокировать IP адрес\n\n\
						На данном уровне игрового мастера нет новых команд, но добавлена защита от оффлайн наказаний.", "Назад", "Выход");
					}
					case 6: 
					{
						ShowPlayerDialog(playerid, dialog_ABACK, DIALOG_STYLE_MSGBOX, !"{ee3366}Команды игрового мастера",
						!"setsex - изменить пол игроку\n\
						rasform - расформировать территории ОПГ\n\
						stopcapture - остановить захват территории", "Назад", "Выход");
					}
					case 7: 
					{
						ShowPlayerDialog(playerid, dialog_ABACK, DIALOG_STYLE_MSGBOX, !"{ee3366}Команды игрового мастера",
						!"saveplayers - сохранить всех игроков на сервере\n\
						addhouse - создать новый дом\n\
						giveownable - выдать игроку машину на 14 дней\n\
						offgm - снять с должности игрового мастера оффлайн\n\
						givemoney - выдать деньги игроку\n\
						makegm - выдать уровень игрового мастера\n\
						setstat - изменить статистику игроку\n\
						givemoneyall - выдать деньги всем игрокам на сервере\n\
						givevipall - выдать вип всем игрокам на сервере\n\
						givedonate - выдать донат игроку\n\
						apanel - админ панель", "Назад", "Выход");
					}
				}
			}
		}
		case dialog_SETGZ: 
		{
		    if(!response) return 1;
		    if(response) 
			{
				new gz = GetPlayerGangZone(playerid), LastOpg = gz_info[gz][gzopg];

				switch(listitem) 
				{
				    case 0: 
					{
					    gz_info[gz][gzopg] = 5;
         				SaveGZ(5, gz);

						SendAdminsMessagef(COLOR_ADMINCHAT, "[%s #%d] %s[%d] перекрасил территорию №%d (%s) в территорию (Скинхеды)",\
							AdminName[PI[playerid][pAdmin]], PI[playerid][pAdminNumber], getName(playerid), playerid, gz, Fraction_Name[LastOpg]);
						SCM(playerid, COLOR_LIGHTGREY, !"Вы присвоили территорию ОПГ 'Скинхеды'");
					}
					case 1: 
					{
					    gz_info[gz][gzopg] = 6;
					    SaveGZ(6, gz);

						SendAdminsMessagef(COLOR_ADMINCHAT, "[%s #%d] %s[%d] перекрасил территорию №%d (%s) в территорию (Гопота)",\
							AdminName[PI[playerid][pAdmin]], PI[playerid][pAdminNumber], getName(playerid), playerid, gz, Fraction_Name[LastOpg]);
						SCM(playerid, COLOR_LIGHTGREY, !"Вы присвоили территорию ОПГ 'Гопота'");
					}
					case 2: 
					{
					    gz_info[gz][gzopg] = 7;
					    SaveGZ(7, gz);

						SendAdminsMessagef(COLOR_ADMINCHAT, "[%s #%d] %s[%d] перекрасил территорию №%d (%s) в территорию (Кавказцы)",\
							AdminName[PI[playerid][pAdmin]], PI[playerid][pAdminNumber], getName(playerid), playerid, gz, Fraction_Name[LastOpg]);
						SCM(playerid, COLOR_LIGHTGREY, !"Вы присвоили территорию ОПГ 'Кавказцы'");
					}
				}
				foreach(new i:Player) 
				{
					if(PI[i][pMember] == 5 || PI[i][pMember] == 6 || PI[i][pMember] == 7) 
					{
						GangZoneHideForPlayer(i, gz);
						GangZoneShowForPlayer(i, gz, GetGZFrac(gz));
					}
				}
		    }
		}
		case dialog_SETSKINDEV: 
		{
			if(!response) return 1;
			if(response) 
			{
			    new p = GetPVarInt(playerid,"gPLAYER");
				switch(PI[p][pMember]) {
				    case 1: {
				        switch(listitem) {
						    case 0:PI[p][pOrgSkin] = 216;
						}
				    }
				    case 2: {
					    switch(listitem) {
						    case 0:PI[p][pOrgSkin] = 191;
						}
					}
					case 3: {
					    switch(listitem) {
						    case 0:PI[p][pOrgSkin] = 141;
						}
					}
					case 4: {
					    switch(listitem) {
						    case 0:PI[p][pOrgSkin] = 194;
						}
					}
					case 5: {
					    switch(listitem) {
						    case 0:PI[p][pOrgSkin] = 13;
						}
					}
					case 6: {
					    switch(listitem) {
						    case 0:PI[p][pOrgSkin] = 13;
						}
					}
					case 7: {
					    switch(listitem) {
						    case 0:PI[p][pOrgSkin] = 13;
						}
					}
					case 8: {
					    switch(listitem) {
						    case 0:PI[p][pOrgSkin] = 12;
						}
					}
				}
				SetPlayerSkinAC(p, PI[p][pOrgSkin]);
				SCMf(playerid,0x6699ccFF, "Вы изменили внешний вид игроку %s", PI[p][pName]);
				SCMf(p, 0x6699ccFF, "%s %s[%d] изменил Вашу внешность в орагнизацию", NameRang(playerid),PI[playerid][pName],playerid);

			}
		}
		case dialog_SETSKIN:
		{
			if(!response) return 1;
			if(response)
			{
			    new p = GetPVarInt(playerid,"gPLAYER");
				switch(PI[p][pMember])
				{
				    case 1:
				    {
				        switch(listitem)
						{
						    case 0:PI[p][pOrgSkin] = 156;
						    case 1:PI[p][pOrgSkin] = 154;
						    case 2:PI[p][pOrgSkin] = 208;
						    case 3:PI[p][pOrgSkin] = 187;
						    case 4:PI[p][pOrgSkin] = 147;
						}
				    }
				    case 2:
					{
					    switch(listitem)
						{
						    case 0:PI[p][pOrgSkin] = 179;
						    case 1:PI[p][pOrgSkin] = 262;
						    case 2:PI[p][pOrgSkin] = 253;
						    case 3:PI[p][pOrgSkin] = 287;
						    case 4:PI[p][pOrgSkin] = 167;
						    case 5:PI[p][pOrgSkin] = 277;
						    case 6:PI[p][pOrgSkin] = 278;
						    case 7:PI[p][pOrgSkin] = 279;
						    case 8:PI[p][pOrgSkin] = 188;
						    case 9:PI[p][pOrgSkin] = 222;
						    case 10:PI[p][pOrgSkin] = 255;
						    case 11:PI[p][pOrgSkin] = 84;
						}
					}
					case 3:
					{
					    switch(listitem)
						{
						    case 0: PI[p][pOrgSkin] = 280;
						    case 1: PI[p][pOrgSkin] = 281;
						    case 2: PI[p][pOrgSkin] = 282;
						    case 3: PI[p][pOrgSkin] = 285;
						    case 4: PI[p][pOrgSkin] = 286;
						    case 5: PI[p][pOrgSkin] = 288;
						    case 6: PI[p][pOrgSkin] = 220;
						    case 7: PI[p][pOrgSkin] = 284;
						}
					}
					case 4:
					{
					    switch(listitem)
						{
						    case 0:PI[p][pOrgSkin] = 276;
						    case 1:PI[p][pOrgSkin] = 71;
						    case 2:PI[p][pOrgSkin] = 275;
						    case 3:PI[p][pOrgSkin] = 70;
						}
					}
					case 5:
					{
					    switch(listitem)
						{
						    case 0:PI[p][pOrgSkin] = 8;
						    case 1:PI[p][pOrgSkin] = 17;
						    case 2:PI[p][pOrgSkin] = 28;
						    case 3:PI[p][pOrgSkin] = 126;
						    case 4: if(PI[p][pRang] != 10) return SCM(playerid, COLOR_GREY,"Данный вид одежды доступен только лидеру организации"); else PI[p][pOrgSkin] = 117;
						}
					}
					case 6:
					{
					    switch(listitem)
						{
						    case 0:PI[p][pOrgSkin] = 115;
						    case 1:PI[p][pOrgSkin] = 116;
						    case 2:PI[p][pOrgSkin] = 114;
						    case 3:PI[p][pOrgSkin] = 111;
						    case 4: if(PI[p][pRang] != 10) return SCM(playerid, COLOR_GREY,"Данный вид одежды доступен только лидеру организации"); else PI[p][pOrgSkin] = 236;
						}
					}
					case 7:
					{
					    switch(listitem)
						{
						    case 0:PI[p][pOrgSkin] = 123;
						    case 1:PI[p][pOrgSkin] = 122;
						    case 2:PI[p][pOrgSkin] = 109;
						    case 3:PI[p][pOrgSkin] = 108;
						    case 4: if(PI[p][pRang] != 10) return SCM(playerid, COLOR_GREY,"Данный вид одежды доступен только лидеру организации"); else PI[p][pOrgSkin] = 118;
						}
					}
					case 8:
					{
					    switch(listitem)
						{
						    case 0:PI[p][pOrgSkin] = 15;
						    case 1:PI[p][pOrgSkin] = 17;
						    case 2: if(PI[p][pRang] != 10) return SCM(playerid, COLOR_GREY,"Данный вид одежды доступен только лидеру организации"); else PI[p][pOrgSkin] = 23;
						}
					}
				}
				SetPlayerSkinAC(p,PI[p][pOrgSkin]);
				SCMf(playerid,0x6699ccFF, "Вы изменили внешний вид игроку %s",PI[p][pName]);
				SCMf(p,0x6699ccFF, "%s %s[%d] изменил Вашу внешность в орагнизацию", NameRang(p), PI[playerid][pName], playerid);

			}
		}
		case 7213: 
		{
		    if(!response) return 1;
			if(response) 
			{
				switch(listitem) 
				{
      				case 0: 
					{
						if(PI[playerid][pAdminStatus] == 0) 
						{
							SendAdminsMessagef(COLOR_ADMINCHAT, "[%s #%d] %s[%d] включил скрытие никнейма", AdminName[PI[playerid][pAdmin]], PI[playerid][pAdminNumber], getName(playerid), playerid);
			        	    PI[playerid][pAdminStatus] = 1;
							SetPlayerHealthAC(playerid, 200.0);
							UpdatePlayerDataInt(playerid, "AdminStatus", PI[playerid][pAdminStatus]);
							for(new i = 0; i < MAX_PLAYERS; i++) ShowPlayerNameTagForPlayer(i, playerid, false);
						}
						else 
						{
							SendAdminsMessagef(COLOR_ADMINCHAT, "[%s #%d] %s[%d] выключил скрытие никнейма", AdminName[PI[playerid][pAdmin]], PI[playerid][pAdminNumber], getName(playerid), playerid);
			        	    PI[playerid][pAdminStatus] = 0;
							SetPlayerHealthAC(playerid, 176.0);
			        	    UpdatePlayerDataInt(playerid, "AdminStatus", PI[playerid][pAdminStatus]);
							for(new i = 0; i < MAX_PLAYERS; i++) ShowPlayerNameTagForPlayer(i, playerid, true);
						}
      				}
      				case 1: ShowPlayerDialog(playerid, 9827, DIALOG_STYLE_INPUT, !"{ee3366}Смена никнейма", !"Введите никнейм для смены в поле ниже", !"Изменить", !"Отмена");
      				case 2: 
					{
      				  	if(!IsPlayerLogged{playerid}) return 1;
		                new rand = random(sizeof(nname));
		                SetPlayerName(playerid, nname[rand]);
		                SendAdminsMessagef(COLOR_ADMINCHAT, "[%s #%d] %s[%d] установил временный никнейм (%s)", AdminName[PI[playerid][pAdmin]], PI[playerid][pAdminNumber], PI[playerid][pName], playerid, nname[rand]);
      				}
      				case 3: SetPlayerSkinAC(playerid, 60);
					case 4: 
					{
    					if(CheckAccess(playerid)) return 0;
						SetPlayerSpecialAction(playerid, SPECIAL_ACTION_USEJETPACK);
						return 1;
					}
      				case 5: 
					{
						if(PI[playerid][pAdminChat] == 1) 
						{
			        	    PI[playerid][pAdminChat] = 0;
							SCM(playerid, COLOR_HINT, !"[AdminSettings]: {FFFFFF}Вы включили админ-чат для себя");
						}
						else
						{
			        	    PI[playerid][pAdminChat] = 1;
							SCM(playerid, COLOR_HINT, !"[AdminSettings]: {FFFFFF}Вы отключили админ-чат для себя");
						}
      				}
					case 6:
					{
						if(PI[playerid][pAdminWatherDriver] == 1) 
						{
			        	    PI[playerid][pAdminWatherDriver] = 0;
							//TogglePlayerDriveOnWater(playerid, false);
							SCM(playerid, COLOR_HINT, !"[AdminSettings]: {FFFFFF}Вы отключили езду по воде");
						}
						else
						{
			        	    PI[playerid][pAdminWatherDriver] = 1;
							//TogglePlayerDriveOnWater(playerid, true);
							SCM(playerid, COLOR_HINT, !"[AdminSettings]: {FFFFFF}Вы включили езду по воде");
						}
					}
					case 7:
					{
						if(PI[playerid][pAdminNoReload] == 1) 
						{
			        	    PI[playerid][pAdminNoReload] = 0;
							//SetPlayerNoReload(playerid, false);
							SCM(playerid, COLOR_HINT, !"[AdminSettings]: {FFFFFF}Вы отключили стрельбу без перезарядки");
						}
						else
						{
			        	    PI[playerid][pAdminNoReload] = 1;
							//SetPlayerNoReload(playerid, true);
							SCM(playerid, COLOR_HINT, !"[AdminSettings]: {FFFFFF}Вы включили стрельбу без перезарядки");
						}
					}
				}
			}
		}
		case 7600: {
		    if(!response) return 1;
		    if(response) {
			    switch(listitem) {
      				case 0: {
      					if(PI[playerid][pMember] == 4) return SCM(playerid, COLOR_YELLOW,"Нельзя перевестись в свою же организацию. Приятной игры на {921dd1}"NAMESERVER"");
						ShowPlayerDialog(playerid, 7601, DIALOG_STYLE_MSGBOX, !"{ee3366}Перевод в организацию - 'БЦРБ'", "Перевод нельзя будет отменить.", "Продолжить", "Отмена");
      				}
      				case 1: {
      					if(PI[playerid][pMember] == 3) return SCM(playerid, COLOR_YELLOW,"Нельзя перевестись в свою же организацию. Приятной игры на {921dd1}"NAMESERVER"");
      					ShowPlayerDialog(playerid, 7602, DIALOG_STYLE_MSGBOX, !"{ee3366}Перевод в организацию - 'Полиция'", "Перевод нельзя будет отменить.", "Продолжить", "Отмена");
      				}
      				case 2: {
      				    if(PI[playerid][pMember] == 1) return SCM(playerid, COLOR_YELLOW,"Нельзя перевестись в свою же организацию. Приятной игры на {921dd1}"NAMESERVER"");
      					ShowPlayerDialog(playerid, 7603, DIALOG_STYLE_MSGBOX, !"{ee3366}Перевод в организацию - 'Правительство'", "Перевод нельзя будет отменить.", "Продолжить", "Отмена");
      				}
      				case 3: {
						if(PI[playerid][pMember] == 2) return SCM(playerid, COLOR_YELLOW,"Нельзя перевестись в свою же организацию. Приятной игры на {921dd1}"NAMESERVER"");
      					ShowPlayerDialog(playerid, 7604, DIALOG_STYLE_MSGBOX, !"{ee3366}Перевод в организацию - 'Воинская Часть'", "Перевод нельзя будет отменить.", "Продолжить", "Отмена");
      				}
			    }
			}
		}
		case 7604: {
		    if(!response) return 1;
			if(response) {
				PI[playerid][data_TRANSFER] = 1;
				PI[playerid][data_TRANSFER_FRAC] = 2;
				PI[playerid][data_TRANSFER_RANG] = PI[playerid][pMember]-2;
				SCM(playerid, COLOR_YELLOW,"Вы подали заявку на перевод в организацию 'Воинская Часть', ожидайте одобрение от Лидера.");
			}
		}
		case 7603:
		{
		    if(!response) return 1;
			if(response)
			{
				PI[playerid][data_TRANSFER] = 1;
				PI[playerid][data_TRANSFER_FRAC] = 1;
				PI[playerid][data_TRANSFER_RANG] = PI[playerid][pMember]-2;
				SCM(playerid, COLOR_YELLOW,"Вы подали заявку на перевод в организацию 'Правительство', ожидайте одобрение от Лидера.");
			}
		}
		case 7602:
		{
		    if(!response) return 1;
			if(response)
			{
				PI[playerid][data_TRANSFER] = 1;
				PI[playerid][data_TRANSFER_FRAC] = 3;
				PI[playerid][data_TRANSFER_RANG] = PI[playerid][pMember]-2;
				SCM(playerid, COLOR_YELLOW,"Вы подали заявку на перевод в организацию 'Полиция', ожидайте одобрение от Лидера.");
			}
		}
		case 7601:
		{
		    if(!response) return 1;
			if(response)
			{
				PI[playerid][data_TRANSFER] = 1;
				PI[playerid][data_TRANSFER_FRAC] = 4;
				PI[playerid][data_TRANSFER_RANG] = PI[playerid][pMember]-2;
				SCM(playerid, COLOR_YELLOW,"Вы подали заявку на перевод в организацию 'БЦРБ', ожидайте одобрение от Лидера.");
			}
		}
		case 7890:
		{
			if(!response) return 1;
			if(response)
			{
				new pTempID = strval(inputtext);
				PI[pTempID][pRang] = PI[pTempID][data_TRANSFER_RANG];
				PI[pTempID][pMember] = PI[pTempID][data_TRANSFER_FRAC];
				PI[pTempID][data_TRANSFER] = 0;
				PI[pTempID][data_TRANSFER_FRAC] = 0;
				PI[pTempID][data_TRANSFER_RANG] = 0;
				ClearGroup(pTempID);
				SCMf(playerid, -1, "{FFFF00}Вы одобрили перевод для игрока - %s", PI[pTempID][pName] );
				SCM(pTempID, COLOR_YELLOW,"Вам одобрили перевод в организацию. Сейчас Вам установят одежду.");
				callcmd::setskin(playerid,inputtext);
			}
		}
		case dialog_ANIM:
  		{
			if(!response) return true;
			if(response)
			{
			    SetPVarInt(playerid, "AnimOn", 1);
			    cef_emit_event(playerid, "show-button", CEFSTR("LSHIFT"), CEFSTR("ОТКЛЮЧИТЬ АНИМАЦИЮ"));
			    ClearAnimations(playerid);
				switch(listitem)
				{
					case 0: SetPlayerSpecialAction (playerid, SPECIAL_ACTION_HANDSUP);
					case 1: ApplyAnimation(playerid,"SMOKING","M_smklean_loop",4.1, 1, 0, 0, 0, 0 ,1);
					case 2: ApplyAnimation(playerid,"BD_FIRE","wash_up",4.0,1,0,0,0,0,1);//мыть руки
					case 3: ApplyAnimation(playerid,"BEACH","ParkSit_M_loop",4.1,1,0,0,0,0,1);//сесть на землю
					case 4: ApplyAnimation(playerid,"BEACH","SitnWait_loop_W",4.1,1,0,0,0,0,1);//сесть на землю
					case 5: ApplyAnimation(playerid,"BEACH","Lay_Bac_Loop",4.1,1,0,0,0,0,1); //лежать
					case 6: ApplyAnimation(playerid,"RAPPING","RAP_A_Loop",4.1,1,0,0,0,0,1); //читать рэп
					case 7: ApplyAnimation( playerid, "BEACH", "ParkSit_W_Loop", 4.1, 1, 0, 0, 0, 0 ,1);
					case 8: ApplyAnimation( playerid, "BOMBER", "BOM_Plant", 4.1, 0, 0, 0, 0, 0 ,1);// Установить бомбу
					case 9: ApplyAnimation( playerid, "BSKTBALL", "BBALL_def_loop", 4.1, 1, 0, 0, 0, 0 ,1); // Поза вратаря
					case 10: ApplyAnimation( playerid, "COP_AMBIENT", "Coplook_loop", 4.1, 1, 0, 0, 0, 0 ,1); // Сложить руки
					case 11: ApplyAnimation( playerid, "GRAVEYARD", "mrnF_loop", 4.1, 1, 0, 0, 0, 0 ,1); // Плакать
					case 12: ApplyAnimation( playerid, "RYDER", "RYD_Die_PT1", 4.1, 1, 0, 0, 0, 0 ,1);
					case 13: ApplyAnimation(playerid,"MISC","Hiker_Pose",4.1,1,0,0,0,0,1); // Голосовать
					case 14: ApplyAnimation(playerid,"ON_LOOKERS","POINTUP_IN", 4.1, 0, 0, 0, 0, 0 ,1);
					case 15: ApplyAnimation(playerid,"RIOT","RIOT_ANGRY", 4.1, 0, 0, 0, 0, 0 ,1);
					case 16: ApplyAnimation(playerid,"MISC","PLYRLEAN_LOOP", 4.1, 1, 0, 0, 0, 0 ,1);
					case 17: ApplyAnimation(playerid,"ON_LOOKERS","lkup_loop", 4.1, 1, 0, 0, 0, 0 ,1);// Смотреть на небо
					case 18: ApplyAnimation(playerid,"ON_LOOKERS","wave_loop", 4.1, 1, 0, 0, 0, 0 ,1);//
					case 19: ApplyAnimation(playerid,"ON_LOOKERS","shout_02", 4.1, 1, 0, 0, 0, 0 ,1);// Болельщик
					case 20: ApplyAnimation(playerid,"PARK","Tai_Chi_Loop", 4.1, 1, 0, 0, 0, 0 ,1);// медитация
					case 21: ApplyAnimation(playerid,"MISC","plyr_shkhead",4.0,0,0,0,0,0,1); // facepalm
					case 22: ApplyAnimation(playerid,"ped","cower",4.1,1,0,0,0,0,1); //лежать
					case 23: SetPlayerSpecialAction(playerid, 68); // ссать
				}
				SetPVarInt(playerid,"UseAnim",1);

			}
		}
        case 7210:
		{
		    if(!response) return 1;
		    if(response) {
			    switch(listitem) 
				{
			        case 0: 
					{
					    new status[64];
						switch(PI[playerid][pPhoneStatus]) 
						{
							case 0: format(status,sizeof(status),"{ee2121}Телефон выключен");
							case 1: format(status,sizeof(status),"{31d562}Телефон включен");
						}
					 	ShowPlayerDialogf(playerid, 0, DIALOG_STYLE_MSGBOX, !"{ee3366}Информация о телефоне", !"Закрыть", !"", "\
						{FFFFFF}Название: \t\t{3274c6}bPhone XX\n\
						{FFFFFF}Номер телефона: \t{FFFF99}%d\n\
						{FFFFFF}Поддержка звонков: \tДа\n\
						{FFFFFF}Мобильный банк: \tДа\n\
						{FFFFFF}Баланс: \t\t%d\n\
						{FFFFFF}Статус: \t\t\t%s", PI[playerid][pNumber], PI[playerid][pNumberMoney], status);
					}
					case 1:
					{
						if(PI[playerid][pPhoneStatus] == 1) 
						{
							PI[playerid][pPhoneStatus] = 0;
							callcmd::phone(playerid);
						}
						else 
						{
                        	PI[playerid][pPhoneStatus] = 1;
                        	callcmd::phone(playerid);
						}
					}
			    }
			}
		}
        case 7220: 
		{
		    if(!response) return 1;
		    if(response) 
			{
			    switch(listitem) 
				{
			        case 0: 
					{
					    new status[27];
						switch(PI[playerid][pPhoneStatus]) 
						{
							case 0: format(status,sizeof(status),"{ee2121}Телефон выключен");
							case 1: format(status,sizeof(status),"{31d562}Телефон включен");
						}
					 	ShowPlayerDialogf(playerid, 0, DIALOG_STYLE_MSGBOX, !"{ee3366}Информация о телефоне", !"Закрыть", !"", "\
						{FFFFFF}Название: \t\t{3274c6}bPhone XX\n\
						{FFFFFF}Номер телефона: \t{FFFF99}%d\n\
						{FFFFFF}Поддержка звонков: \tДа\n\
						{FFFFFF}Мобильный банк: \tДа\n\
						{FFFFFF}Баланс: \t\t%d\n\
						{FFFFFF}Статус: \t\t\t%s", PI[playerid][pNumber], PI[playerid][pNumberMoney], status);
					}
					case 1:
					{
						ShowPlayerDialog(playerid, 7221, DIALOG_STYLE_INPUT, !"{ee3366}Сделать вызов", !"\
						{FFFFFF}Список государственных слубж и сервисов:\n\n\
						{FFFFFF}Полиция:{3070c1}\t\t\t102\n\
						{FFFFFF}Скорая помощь:{3070c1}\t\t103\n\
						{FFFFFF}Введите номер телефона в окошко ниже:", !"Вызов", !"Отмена");
      				}
      				case 2: 
					{
						ShowPlayerDialog(playerid, 7222, DIALOG_STYLE_INPUT, !"{ee3366}Отправить сообщение", !"\
						{FFFFFF}Введите номер телефона и текст через запятую", !"Отправить", !"Отмена");
      				}
      				case 3: 
					{
						ShowPlayerDialog(playerid, 6001, DIALOG_STYLE_LIST, !"{ee3366}Мобильный банк", !"\
						1. Узнать баланс счёта\n\
						2. Перевести деньги на другой счёт\n\
						3. Оплата штрафов\n\
						4. Оплата имущества\n\
						5. Медицинские услуги", !"Далее", !"Назад");
      				}
      				case 4: 
					{
						mysql_string[0] = EOS, mf(mysql, mysql_string, 72, "SELECT * FROM `phonebook` WHERE name_add = '%e'",PI[playerid][pName]);
	                    mysql_tquery(mysql, mysql_string, "PhoneBook", "i", playerid);
					}
				  	case 5: SCM(playerid, COLOR_YELLOW, !"Данная функция ещё не была добавлена");
					case 6:
					{
						if(PI[playerid][pPhoneStatus] == 1) 
						{
							PI[playerid][pPhoneStatus] = 0;
							callcmd::phone(playerid);
						}
						else 
						{
                        	PI[playerid][pPhoneStatus] = 1;
                        	callcmd::phone(playerid);
						}
					}
			    }
			}
		}
		case 3210: 
		{
		    if(!response) return 1;
			if(response) 
			{
			    switch(listitem) 
				{
			        case 0: 
					{
						new id = GetPVarInt(playerid, "idg");

						if(PI[id][pGroupID] <= 0) return SCM(playerid, COLOR_GREY, !"Данный игрок не состоит не в одной из групп");

						PI[id][pGroupID] = -1;
						UpdatePlayerDataInt(id, "GroupID", PI[id][pGroupID]);

						SendFractionMessagef(PI[playerid][pMember], 0x69b867FF, "[R] %s %s[%d] удалил %s %s[%d] с группы ('%s')", NameRang(playerid), PI[playerid][pName], playerid, NameRang(id), PI[id][pName], id, PI[id][pGroupName]);
						
						DeletePVar(playerid, "idg");
				    }
				    default: 
					{
				        new _text[24];
		                sscanf(inputtext, "s", _text);

						mysql_string[0] = EOS, mf(mysql, mysql_string, 100, "SELECT * FROM `group` WHERE `fraction` = '%d' AND `group_name` = '%e'", PI[playerid][pMember], _text);
						mysql_function_query(mysql, mysql_string, true, "SetGroupPlayer", "i", playerid);
				    }
			    }

			}
		}
		case 3410: 
		{
		    if(!response) return 1;
			if(response) 
			{
			    SetPVarString(playerid, "namegr", inputtext);
				switch(PI[playerid][pMember]) 
				{
					case 1: ShowPlayerDialog(playerid, 3411, DIALOG_STYLE_LIST, "{ee3366}Выберете форму одежды", "{FFFF99}1. Сбросить мужской скин{FFFFFF}\n2. ID 156\n3. ID 154\n4. ID 208\n5. ID 155\n6. ID 147\n7. ID 187", "Выбрать", "Отмена");
					case 2: ShowPlayerDialog(playerid, 3411, DIALOG_STYLE_LIST, "{ee3366}Выберете форму одежды", "{FFFF99}1. Сбросить мужской скин{FFFFFF}\n2. ID 179\n3. ID 262\n4. ID 253\n5. ID 283\n6. ID 167\n7. ID 277\n8. ID 278\n9. ID 188\n10. ID 222\n11. ID 255\n12 ID 84\n13 ID 283", "Выбрать", "Отмена");
					case 3: 
					{
						ShowPlayerDialog(playerid, 3411, DIALOG_STYLE_LIST, !"{ee3366}Выберете форму одежды", 
						!"{FFFF99}1. Сбросить мужской скин{FFFFFF}\n\
						2. ID 280\n\
						3. ID 281\n\
						4. ID 282\n\
						5. ID 285\n\
						6. ID 286\n\
						7. ID 288\n\
						8 ID 220\n\
						9. ID 284", "Выбрать", "Отмена");
					}
					case 4: ShowPlayerDialog(playerid, 3411, DIALOG_STYLE_LIST, "{ee3366}Выберете форму одежды", "{FFFF99}1. Сбросить мужской скин{FFFFFF}\n2. ID 276\n3. ID 71\n4. ID 275\n5. ID 70", "Выбрать", "Отмена");
					case 5: ShowPlayerDialog(playerid, 3411, DIALOG_STYLE_LIST, "{ee3366}Выберете форму одежды", "{FFFF99}1. Сбросить мужской скин{FFFFFF}\n2. [1-4 ранг]\n3. [5-7 ранг]\n4. [Стрелковый состав 1-7 ранг]\n5. [8-9 ранг]\n6. [10 ранг]", "Выбрать", "Отмена");
					case 6: ShowPlayerDialog(playerid, 3411, DIALOG_STYLE_LIST, "{ee3366}Выберете форму одежды", "{FFFF99}1. Сбросить мужской скин{FFFFFF}\n2. [1-4 ранг]\n3. [5-7 ранг]\n4. [Стрелковый состав 1-7 ранг]\n5. [8-9 ранг]\n6. [10 ранг]", "Выбрать", "Отмена");
					case 7: ShowPlayerDialog(playerid, 3411, DIALOG_STYLE_LIST, "{ee3366}Выберете форму одежды", "{FFFF99}1. Сбросить мужской скин{FFFFFF}\n2. [1-4 ранг]\n3. [5-7 ранг]\n4. [Стрелковый состав 1-7 ранг]\n5. [8-9 ранг]\n6. [10 ранг]", "Выбрать", "Отмена");
					case 8: ShowPlayerDialog(playerid, 3411, DIALOG_STYLE_LIST, "{ee3366}Выберете форму одежды", "{FFFF99}1. Сбросить мужской скин{FFFFFF}\n2. ID 15\n3. ID 17\n4. ID 23", "Выбрать", "Отмена");
				}
			}
		}
		case 3411: 
		{
		    if(!response) return 1;
			if(response) 
			{
				switch(PI[playerid][pMember])
				{
				    case 1:
				    {
				        switch(listitem)
						{
						    case 0:SetPVarInt(playerid, "sking", 0);
						    case 1:SetPVarInt(playerid, "sking", 156);
						    case 2:SetPVarInt(playerid, "sking", 154);
						    case 3:SetPVarInt(playerid, "sking", 208);
						    case 4:SetPVarInt(playerid, "sking", 187);
						    case 5:SetPVarInt(playerid, "sking", 147);
						}
				    }
				    case 2:
					{
					    switch(listitem)
						{
						    case 0:SetPVarInt(playerid, "sking", 0);
						    case 1:SetPVarInt(playerid, "sking", 179);
						    case 2:SetPVarInt(playerid, "sking", 262);
						    case 3:SetPVarInt(playerid, "sking", 253);
						    case 4:SetPVarInt(playerid, "sking", 287);
						    case 5:SetPVarInt(playerid, "sking", 167);
						    case 6:SetPVarInt(playerid, "sking", 277);
						    case 7:SetPVarInt(playerid, "sking", 278);
						    case 8:SetPVarInt(playerid, "sking", 279);
						    case 9:SetPVarInt(playerid, "sking", 188);
						    case 10:SetPVarInt(playerid, "sking", 222);
						    case 11:SetPVarInt(playerid, "sking", 255);
                            case 12:SetPVarInt(playerid, "sking", 84);
                            case 13:SetPVarInt(playerid, "sking", 283);

						}
					}
					case 3:
					{
					    switch(listitem)
						{
							case 0: SetPVarInt(playerid, "sking", 0);
						    case 1: SetPVarInt(playerid, "sking", 280);
						    case 2: SetPVarInt(playerid, "sking", 281);
						    case 3: SetPVarInt(playerid, "sking", 282);
						    case 4: SetPVarInt(playerid, "sking", 285);
						    case 5: SetPVarInt(playerid, "sking", 286);
						    case 6: SetPVarInt(playerid, "sking", 288);
						    case 7: SetPVarInt(playerid, "sking", 220);
						    case 8: SetPVarInt(playerid, "sking", 284);
						}
					}
					case 4:
					{
					    switch(listitem)
						{
						    case 0:SetPVarInt(playerid, "sking", 0);
						    case 1:SetPVarInt(playerid, "sking", 276);
						    case 2:SetPVarInt(playerid, "sking", 71);
						    case 3:SetPVarInt(playerid, "sking", 275);
						    case 4:SetPVarInt(playerid, "sking", 70);
						}
					}
					case 5:
					{
					    switch(listitem)
						{
						    case 0:SetPVarInt(playerid, "sking", 0);
						    case 1:SetPVarInt(playerid, "sking", 8);
						    case 2:SetPVarInt(playerid, "sking", 17);
						    case 3:SetPVarInt(playerid, "sking", 28);
						    case 4:SetPVarInt(playerid, "sking", 126);
						    case 5:SetPVarInt(playerid, "sking", 117);
						}
					}
					case 6:
					{
					    switch(listitem)
						{
						    case 0:SetPVarInt(playerid, "sking", 0);
						    case 1:SetPVarInt(playerid, "sking", 115);
						    case 2:SetPVarInt(playerid, "sking", 116);
						    case 3:SetPVarInt(playerid, "sking", 114);
						    case 4:SetPVarInt(playerid, "sking", 111);
						    case 5:SetPVarInt(playerid, "sking", 236);
						}
					}
					case 7:
					{
					    switch(listitem)
						{
						    case 0:SetPVarInt(playerid, "sking", 0);
						    case 1:SetPVarInt(playerid, "sking", 123);
						    case 2:SetPVarInt(playerid, "sking", 122);
						    case 3:SetPVarInt(playerid, "sking", 109);
						    case 4:SetPVarInt(playerid, "sking", 108);
						    case 5:SetPVarInt(playerid, "sking", 118);
						}
					}
					case 8:
					{
					    switch(listitem)
						{
						    case 0:SetPVarInt(playerid, "sking", 0);
						    case 1:SetPVarInt(playerid, "sking", 15);
						    case 2:SetPVarInt(playerid, "sking", 18);
						    case 3:SetPVarInt(playerid, "sking", 23);
						}
					}
				}
				switch(PI[playerid][pMember]) 
				{
					case 1: ShowPlayerDialog(playerid, 3412, DIALOG_STYLE_LIST, "{ee3366}Выберете форму одежды", "{FFFF99}1. Сбросить мужской скин\n2. ID 216", "Выбрать", "Отмена");
					case 2: ShowPlayerDialog(playerid, 3412, DIALOG_STYLE_LIST, "{ee3366}Выберете форму одежды", "{FFFF99}1. Сбросить мужской скин\n2. ID 191", "Выбрать", "Отмена");
					case 3: ShowPlayerDialog(playerid, 3412, DIALOG_STYLE_LIST, "{ee3366}Выберете форму одежды", "{FFFF99}1. Сбросить мужской скин\n2. ID 141", "Выбрать", "Отмена");
					case 4: ShowPlayerDialog(playerid, 3412, DIALOG_STYLE_LIST, "{ee3366}Выберете форму одежды", "{FFFF99}1. Сбросить мужской скин\n2. ID 194", "Выбрать", "Отмена");
					case 5: ShowPlayerDialog(playerid, 3412, DIALOG_STYLE_LIST, "{ee3366}Выберете форму одежды", "{FFFF99}1. Сбросить мужской скин\n2. ID 13", "Выбрать", "Отмена");
					case 6: ShowPlayerDialog(playerid, 3412, DIALOG_STYLE_LIST, "{ee3366}Выберете форму одежды", "{FFFF99}1. Сбросить мужской скин\n2. ID 13", "Выбрать", "Отмена");
					case 7: ShowPlayerDialog(playerid, 3412, DIALOG_STYLE_LIST, "{ee3366}Выберете форму одежды", "{FFFF99}1. Сбросить мужской скин\n2. ID 13", "Выбрать", "Отмена");
					case 8: ShowPlayerDialog(playerid, 3412, DIALOG_STYLE_LIST, "{ee3366}Выберете форму одежды", "{FFFF99}1. Сбросить мужской скин\n2. ID 12", "Выбрать", "Отмена");
				}
			}
		}
		case 3412: 
		{
		    if(!response) return 1;
			if(response) 
			{
				switch(PI[playerid][pMember]) 
				{
				    case 1: 
					{
				        switch(listitem) 
						{
				        	case 0:SetPVarInt(playerid, "skinm", 0);
						    case 1:SetPVarInt(playerid, "skinm", 216);
						}
				    }
				    case 2: 
					{
					    switch(listitem) 
						{
					    	case 0:SetPVarInt(playerid, "skinm", 0);
						    case 1:SetPVarInt(playerid, "skinm", 191);
						}
					}
					case 3: 
					{
					    switch(listitem) 
						{
					    	case 0:SetPVarInt(playerid, "skinm", 0);
						    case 1:SetPVarInt(playerid, "skinm", 141);
						}
					}
					case 4: 
					{
					    switch(listitem) 
						{
					    	case 0:SetPVarInt(playerid, "skinm", 0);
						    case 1:SetPVarInt(playerid, "skinm", 194);
						}
					}
					case 5: 
					{
					    switch(listitem) 
						{
					    	case 0:SetPVarInt(playerid, "skinm", 0);
						    case 1:SetPVarInt(playerid, "skinm", 13);
						}
					}
					case 6: 
					{
					    switch(listitem) 
						{
					    	case 0:SetPVarInt(playerid, "skinm", 0);
						    case 1:SetPVarInt(playerid, "skinm", 13);
						}
					}
					case 7: 
					{
					    switch(listitem) 
						{
					    	case 0:SetPVarInt(playerid, "skinm", 0);
						    case 1:SetPVarInt(playerid, "skinm", 13);
						}
					}
					case 8: 
					{
					    switch(listitem)
						{
					    	case 0:SetPVarInt(playerid, "skinm", 0);
						    case 1:SetPVarInt(playerid, "skinm", 12);
						}
					}
				}
				new textg[24];
				GetPVarString(playerid, "namegr", textg, sizeof(textg));
				FixSVarString(textg);
				mysql_tqueryf(mysql, "INSERT INTO `group`(`fraction`,`group_name`,`skin_m`,`skin_g`) VALUES ('%d','%s','%d','%d')", PI[playerid][pMember],textg,GetPVarInt(playerid, "sking"),GetPVarInt(playerid, "skinm"));
				SCMf(playerid, COLOR_GREENNEW, "Вы успешно создали группу {FFFF00}('%s')",textg);
				DeletePVar(playerid, "skinm");
				DeletePVar(playerid, "sking");
			}
		}
		case 3211: 
		{
		    if(!response) return 1;
			if(response) 
			{
			    switch(listitem) 
				{
			        case 0: ShowPlayerDialog(playerid, 3410, DIALOG_STYLE_INPUT, !"{ee3366}Создание группы", !"{FFFFFF}Название группы", !"Далее", !"Закрыть");
			        default: 
					{
						new _text[24];
		                sscanf(inputtext, "s", _text);
		                SetPVarString(playerid, "gtext", _text);
		                EditGroups(playerid);
					}
				}
			}
		}
		case 3212: 
		{
		    if(!response) return 1;
			if(response) 
			{
				new grouptext[24];
				GetPVarString(playerid, "gtext", grouptext, sizeof(grouptext));
				FixSVarString(grouptext);

                switch(listitem) 
				{
				    case 0: 
					{
						mysql_string[0] = EOS, mf(mysql, mysql_string, 150, "SELECT * FROM `group` WHERE `fraction` = '%d' AND `group_name` = '%e'", PI[playerid][pMember], grouptext);
	                    mysql_tquery(mysql, mysql_string, "InfoGroup", "i", playerid);
					}
					case 1: 
					{
					    mysql_string[0] = EOS, mf(mysql, mysql_string, 150, "SELECT * FROM `group` WHERE `fraction` = '%d' AND `group_name` = '%e'", PI[playerid][pMember], grouptext);
	                    mysql_tquery(mysql, mysql_string, "IDGroup", "i", playerid);
					}
					case 2: 
					{
						mysql_string[0] = EOS, mf(mysql, mysql_string, 150, "SELECT * FROM `group` WHERE `fraction` = '%d' AND `group_name` = '%e' AND `default` = '1'", PI[playerid][pMember], grouptext);
	                    mysql_tquery(mysql, mysql_string, "CheckStandart", "i", playerid);
					}
					case 3: 
					{
					    switch(PI[playerid][pMember]) 
						{
							case 1: ShowPlayerDialog(playerid, 3450, DIALOG_STYLE_LIST, !"{ee3366}Выберете форму одежды", !"{FFFF99}1. Сбросить мужской скин\n{FFFFFF}2. ID 156\n3. ID 154\n4. ID 208\n5. ID 155\n6. ID 147\n7. ID 187", "Выбрать", "Отмена");
							case 2: ShowPlayerDialog(playerid, 3450, DIALOG_STYLE_LIST, !"{ee3366}Выберете форму одежды", !"{FFFF99}1. Сбросить мужской скин\n{FFFFFF}2. ID 179\n3. ID 262\n4. ID 253\n5. ID 283\n6. ID 167\n7. ID 277\n8. ID 278\n9. ID 188\n10. ID 222\n11. ID 255\n12 ID 84", "Выбрать", "Отмена");
							case 3: 
							{
								ShowPlayerDialog(playerid, 3450, DIALOG_STYLE_LIST, !"{ee3366}Выберете форму одежды", 
								!"{FFFF99}1. Сбросить мужской скин\n\
								{FFFFFF}2. ID 280\n\
								3. ID 281\n\
								4. ID 282\n\
								5. ID 285\n\
								6. ID 286\n\
								7. ID 288\n\
								8. ID 220\n\
								9. ID 284", "Выбрать", "Отмена");
							}
							case 4: ShowPlayerDialog(playerid, 3450, DIALOG_STYLE_LIST, !"{ee3366}Выберете форму одежды", !"{FFFF99}1. Сбросить мужской скин{FFFFFF}\n2. ID 280\n3. ID 281\n4. ID 282\n5. ID 285\n6. ID 286\n7. ID 288\n8 ID 220\n9. ID 224\n10. ID 284\n11. ID 289", "Выбрать", "Отмена");
							case 5: ShowPlayerDialog(playerid, 3450, DIALOG_STYLE_LIST, !"{ee3366}Выберете форму одежды", !"{FFFF99}1. Сбросить мужской скин\n{FFFFFF}2. [1-4 ранг]\n3. [5-7 ранг]\n4. [Стрелковый состав 1-7 ранг]\n5. [8-9 ранг]\n6. [10 ранг]", "Выбрать", "Отмена");
							case 6: ShowPlayerDialog(playerid, 3450, DIALOG_STYLE_LIST, !"{ee3366}Выберете форму одежды", !"{FFFF99}1. Сбросить мужской скин\n{FFFFFF}2. [1-4 ранг]\n3. [5-7 ранг]\n4. [Стрелковый состав 1-7 ранг]\n5. [8-9 ранг]\n6. [10 ранг]", "Выбрать", "Отмена");
							case 7: ShowPlayerDialog(playerid, 3450, DIALOG_STYLE_LIST, !"{ee3366}Выберете форму одежды", !"{FFFF99}1. Сбросить мужской скин\n{FFFFFF}2. [1-4 ранг]\n3. [5-7 ранг]\n4. [Стрелковый состав 1-7 ранг]\n5. [8-9 ранг]\n6. [10 ранг]", "Выбрать", "Отмена");
							case 8: ShowPlayerDialog(playerid, 3450, DIALOG_STYLE_LIST, !"{ee3366}Выберете форму одежды", !"{FFFF99}1. Сбросить мужской скин\n{FFFFFF}2. ID 15\n3. ID 17\n4. ID 23", "Выбрать", "Отмена");
						}
					}
					case 4: 
					{
						switch(PI[playerid][pMember]) 
						{
							case 1: ShowPlayerDialog(playerid, 3451, DIALOG_STYLE_LIST, !"{ee3366}Выберете форму одежды", !"{FFFF99}1. Сбросить мужской скин\n{FFFFFF}2. ID 216", !"Выбрать", !"Отмена");
							case 2: ShowPlayerDialog(playerid, 3451, DIALOG_STYLE_LIST, !"{ee3366}Выберете форму одежды", !"{FFFF99}1. Сбросить мужской скин\n{FFFFFF}2. ID 191", !"Выбрать", !"Отмена");
							case 3: ShowPlayerDialog(playerid, 3451, DIALOG_STYLE_LIST, !"{ee3366}Выберете форму одежды", !"{FFFF99}1. Сбросить мужской скин\n{FFFFFF}2. ID 141", !"Выбрать", !"Отмена");
							case 4: ShowPlayerDialog(playerid, 3451, DIALOG_STYLE_LIST, !"{ee3366}Выберете форму одежды", !"{FFFF99}1. Сбросить мужской скин\n{FFFFFF}2. ID 194", !"Выбрать", !"Отмена");
							case 5: ShowPlayerDialog(playerid, 3451, DIALOG_STYLE_LIST, !"{ee3366}Выберете форму одежды", !"{FFFF99}1. Сбросить мужской скин\n{FFFFFF}2. ID 13", !"Выбрать", !"Отмена");
							case 6: ShowPlayerDialog(playerid, 3451, DIALOG_STYLE_LIST, !"{ee3366}Выберете форму одежды", !"{FFFF99}1. Сбросить мужской скин\n{FFFFFF}2. ID 13", !"Выбрать", !"Отмена");
							case 7: ShowPlayerDialog(playerid, 3451, DIALOG_STYLE_LIST, !"{ee3366}Выберете форму одежды", !"{FFFF99}1. Сбросить мужской скин\n{FFFFFF}2. ID 13", !"Выбрать", !"Отмена");
							case 8: ShowPlayerDialog(playerid, 3451, DIALOG_STYLE_LIST, !"{ee3366}Выберете форму одежды", !"{FFFF99}1. Сбросить мужской скин\n{FFFFFF}2. ID 12", !"Выбрать", !"Отмена");
						}
					}
					case 5: ShowPlayerDialog(playerid, 3452, DIALOG_STYLE_INPUT, !"{ee3366}Изменить название группы", !"{FFFFFF}Новое название группы", !"Далее", !"Закрыть");
					case 6: 
					{
						mysql_string[0] = EOS, mf(mysql, mysql_string, 130, "SELECT * FROM `group` WHERE `fraction` = '%d' AND `group_name` = '%e'", PI[playerid][pMember], grouptext);
						mysql_function_query(mysql, mysql_string, true, "CheckDelete", "i", playerid);
					}
					default: return 1;
				}
			}
		}
		case 3452: 
		{
		    if(!response) return 1;
			if(response) 
			{
			    new grouptext[24];
				GetPVarString(playerid,"gtext", grouptext, sizeof(grouptext));
				FixSVarString(grouptext);
				mysql_tqueryf(mysql, "UPDATE `group` SET `group_name` = '%e' WHERE `group_name` = '%e' AND `fraction` = '%d'",inputtext, grouptext,PI[playerid][pMember]);
				SCMf(playerid, COLOR_GREENNEW, "Вы успешно изменили название группы {FFFF00}('%s'){00aa33} на {FFFF00}('%s')",grouptext,inputtext);
				DeletePVar(playerid, "gtext");
			}
		}
		case 3451: 
		{
		    if(!response) return 1;
			if(response) 
			{
				switch(PI[playerid][pMember]) 
				{
				    case 1: 
					{
				        switch(listitem) 
						{
				        	case 0:SetPVarInt(playerid, "skinm", 0);
						    case 1:SetPVarInt(playerid, "skinm", 216);
						}
				    }
				    case 2: 
					{
					    switch(listitem) 
						{
					    	case 0:SetPVarInt(playerid, "skinm", 0);
						    case 1:SetPVarInt(playerid, "skinm", 191);
						}
					}
					case 3: 
					{
					    switch(listitem) 
						{
					    	case 0:SetPVarInt(playerid, "skinm", 0);
						    case 1:SetPVarInt(playerid, "skinm", 141);
						}
					}
					case 4: 
					{
					    switch(listitem) 
						{
					    	case 0:SetPVarInt(playerid, "skinm", 0);
						    case 1:SetPVarInt(playerid, "skinm", 194);
						}
					}
					case 5: 
					{
					    switch(listitem) 
						{
					    	case 0:SetPVarInt(playerid, "skinm", 0);
						    case 1:SetPVarInt(playerid, "skinm", 13);
						}
					}
					case 6: 
					{
					    switch(listitem) 
						{
					    	case 0:SetPVarInt(playerid, "skinm", 0);
						    case 1:SetPVarInt(playerid, "skinm", 13);
						}
					}
					case 7: 
					{
					    switch(listitem) 
						{
					    	case 0:SetPVarInt(playerid, "skinm", 0);
						    case 1:SetPVarInt(playerid, "skinm", 13);
						}
					}
					case 8: 
					{
					    switch(listitem) 
						{
					    	case 0:SetPVarInt(playerid, "skinm", 0);
						    case 1:SetPVarInt(playerid, "skinm", 12);
						}
					}
				}
				new grouptext[24];
				GetPVarString(playerid,"gtext", grouptext, sizeof(grouptext));
				FixSVarString(grouptext);

				mysql_string[0] = EOS, mf(mysql, mysql_string, 130, "SELECT * FROM `group` WHERE `fraction` = '%d' AND `group_name` = '%e'", PI[playerid][pMember], grouptext);
				mysql_function_query(mysql, mysql_string, true, "ChangeSkinG", "i", playerid);

				DeletePVar(playerid, "gtext");
			}
		}
		case 3450: 
		{
		    if(!response) return 1;
			if(response) 
			{
				switch(PI[playerid][pMember])
				{
				    case 1:
				    {
				        switch(listitem)
						{
						    case 0: SetPVarInt(playerid, "Temp_GroupSkin", 0);
						    case 1: SetPVarInt(playerid, "Temp_GroupSkin", 156);
						    case 2: SetPVarInt(playerid, "Temp_GroupSkin", 154);
						    case 3: SetPVarInt(playerid, "Temp_GroupSkin", 208);
						    case 4: SetPVarInt(playerid, "Temp_GroupSkin", 187);
						    case 5: SetPVarInt(playerid, "Temp_GroupSkin", 147);
						}
				    }
				    case 2:
					{
					    switch(listitem)
						{
						    case 0:SetPVarInt(playerid, "Temp_GroupSkin", 0);
						    case 1:SetPVarInt(playerid, "Temp_GroupSkin", 179);
						    case 2:SetPVarInt(playerid, "Temp_GroupSkin", 262);
						    case 3:SetPVarInt(playerid, "Temp_GroupSkin", 253);
						    case 4:SetPVarInt(playerid, "Temp_GroupSkin", 287);
						    case 5:SetPVarInt(playerid, "Temp_GroupSkin", 167);
						    case 6:SetPVarInt(playerid, "Temp_GroupSkin", 277);
						    case 7:SetPVarInt(playerid, "Temp_GroupSkin", 278);
						    case 8:SetPVarInt(playerid, "Temp_GroupSkin", 279);
						    case 9:SetPVarInt(playerid, "Temp_GroupSkin", 188);
						    case 10:SetPVarInt(playerid, "Temp_GroupSkin", 222);
						    case 11:SetPVarInt(playerid, "Temp_GroupSkin", 255);
						    case 12:SetPVarInt(playerid, "Temp_GroupSkin", 84);
						}
					}
					case 3:
					{
					    switch(listitem)
						{
							case 0:SetPVarInt(playerid, "Temp_GroupSkin", 0);
						    case 1:SetPVarInt(playerid, "Temp_GroupSkin", 280);
						    case 2:SetPVarInt(playerid, "Temp_GroupSkin", 281);
						    case 3:SetPVarInt(playerid, "Temp_GroupSkin", 282);
						    case 4:SetPVarInt(playerid, "Temp_GroupSkin", 285);
						    case 5:SetPVarInt(playerid, "Temp_GroupSkin", 286);
						    case 6:SetPVarInt(playerid, "Temp_GroupSkin", 288);
							case 7:SetPVarInt(playerid, "Temp_GroupSkin", 220);
							case 8:SetPVarInt(playerid, "Temp_GroupSkin", 284);
						}
					}
					case 4:
					{
					    switch(listitem)
						{
						    case 0:SetPVarInt(playerid, "Temp_GroupSkin", 0);
						    case 1:SetPVarInt(playerid, "Temp_GroupSkin", 276);
						    case 2:SetPVarInt(playerid, "Temp_GroupSkin", 71);
						    case 3:SetPVarInt(playerid, "Temp_GroupSkin", 275);
						    case 4:SetPVarInt(playerid, "Temp_GroupSkin", 70);
						}
					}
					case 5:
					{
					    switch(listitem)
						{
						    case 0:SetPVarInt(playerid, "Temp_GroupSkin", 0);
						    case 1:SetPVarInt(playerid, "Temp_GroupSkin", 8);
						    case 2:SetPVarInt(playerid, "Temp_GroupSkin", 17);
						    case 3:SetPVarInt(playerid, "Temp_GroupSkin", 28);
						    case 4:SetPVarInt(playerid, "Temp_GroupSkin", 126);
						    case 5:SetPVarInt(playerid, "Temp_GroupSkin", 117);
						}
					}
					case 6:
					{
					    switch(listitem)
						{
						    case 0:SetPVarInt(playerid, "Temp_GroupSkin", 0);
						    case 1:SetPVarInt(playerid, "Temp_GroupSkin", 115);
						    case 2:SetPVarInt(playerid, "Temp_GroupSkin", 116);
						    case 3:SetPVarInt(playerid, "Temp_GroupSkin", 114);
						    case 4:SetPVarInt(playerid, "Temp_GroupSkin", 111);
						    case 5:SetPVarInt(playerid, "Temp_GroupSkin", 236);
						}
					}
					case 7:
					{
					    switch(listitem)
						{
						    case 0:SetPVarInt(playerid, "Temp_GroupSkin", 0);
						    case 1:SetPVarInt(playerid, "Temp_GroupSkin", 123);
						    case 2:SetPVarInt(playerid, "Temp_GroupSkin", 122);
						    case 3:SetPVarInt(playerid, "Temp_GroupSkin", 109);
						    case 4:SetPVarInt(playerid, "Temp_GroupSkin", 108);
						    case 5:SetPVarInt(playerid, "Temp_GroupSkin", 118);
						}
					}
					case 8:
					{
					    switch(listitem)
						{
						    case 0:SetPVarInt(playerid, "Temp_GroupSkin", 0);
						    case 1:SetPVarInt(playerid, "Temp_GroupSkin", 15);
						    case 2:SetPVarInt(playerid, "Temp_GroupSkin", 18);
						    case 3:SetPVarInt(playerid, "Temp_GroupSkin", 23);
						}
					}
				}
				new grouptext[24];
				GetPVarString(playerid,"gtext", grouptext, sizeof(grouptext));
				FixSVarString(grouptext);

				mysql_string[0] = EOS, mf(mysql, mysql_string, 130, "SELECT * FROM `group` WHERE `fraction` = '%d' AND `group_name` = '%e'", PI[playerid][pMember], grouptext);
				mysql_function_query(mysql, mysql_string, true, "ChangeSkinM", "i", playerid);

				DeletePVar(playerid, "gtext");
			}
		}
		case 7229: 
		{
			if(!response) return callcmd::phone(playerid);
			if(response) 
			{
                switch(listitem) 
				{
				    case 0: 
					{
						ShowPlayerDialog(playerid, 7321, DIALOG_STYLE_INPUT, !"{ee3366}Добавить контакт", !"\
						{FFFFFF}Введите имя контакта (без пробела) и номер телефона через запятую.\n\
						{FFFF99}Например: Ivan_Ivanov, 1234567", !"Добавить", !"Отмена");
					}
                    default: 
					{
                        new _text[24];
                		sscanf(inputtext, "s{d}", _text);
                        ShowPlayerDialog(playerid, 7300, DIALOG_STYLE_LIST, !"{ee3366}Меню контакта", !"\
						{FFFFFF}1. Информация о контакте\n\
						2. Позвонить\n\
						3. Отправить SMS\n\
						4. Изменить имя\n\
						5. Изменить номер\n\
						{FFFF99}6. Удалить контакт", !"Далее", !"Назад");
						SetPVarString(playerid, "pb_namecont", _text);
					}
				}
			}
		}
		case 7300: 
		{
			if(!response) return callcmd::phone(playerid);
			if(response) 
			{
                switch(listitem) 
				{
				    case 0: 
					{
				    	new text[24];
						GetPVarString(playerid,"pb_namecont", text, sizeof(text));
						FixSVarString(text);

				    	mysql_string[0] = EOS, mf(mysql, mysql_string, 120, "SELECT * FROM `phonebook` WHERE `name_add` = '%e' AND `name` = '%e'",PI[playerid][pName], text);
						mysql_function_query(mysql, mysql_string, true, "InfoPhoneBook", "i", playerid);
				    }
				    case 1: 
					{
				    	new text[24];
						GetPVarString(playerid,"pb_namecont", text, sizeof(text));
						FixSVarString(text);

				    	mysql_string[0] = EOS, mf(mysql, mysql_string, 120, "SELECT * FROM `phonebook` WHERE `name_add` = '%e' AND `name` = '%e'", PI[playerid][pName], text);
						mysql_function_query(mysql, mysql_string, true, "CallPhoneBook", "i", playerid);
				    }
				    case 2: ShowPlayerDialog(playerid, 7322, DIALOG_STYLE_INPUT, "{ee3366}Отправить SMS", "Введите текст сообщения:", "Отправить", "Назад");
				    case 3: ShowPlayerDialog(playerid, 7323, DIALOG_STYLE_INPUT, "{ee3366}Изменить имя", "Введите новое имя контакта (без пробела):", "Изменить", "Назад");
				    case 4: ShowPlayerDialog(playerid, 7324, DIALOG_STYLE_INPUT, "{ee3366}Изменить номер", "Введите новый номер телефона для контакта:", "Изменить", "Назад");
				    case 5: 
					{
				    	new text[24];
						GetPVarString(playerid,"pb_namecont", text, sizeof(text));
						FixSVarString(text);

					 	ShowPlayerDialogf(playerid, 7325, DIALOG_STYLE_MSGBOX, !"{ee3366}Удалить контакт", "Да", "Нет", "Вы уверены что хотите удалить контакт {3377cc}'%s'{FFFFFF}?\n{696969}Обратите внимание: отменить это действие будет невозможно!", text);
                    }
					default: return 1;
				}
			}
		}
		case 7325:
		{
		    if(!response) return callcmd::phone(playerid);
			new text[24];
			GetPVarString(playerid,"pb_namecont", text, sizeof(text));
			FixSVarString(text);

			mysql_string[0] = EOS, mf(mysql, mysql_string, 115, "SELECT * FROM `phonebook` WHERE `name_add` = '%e' AND `name` = '%e'",PI[playerid][pName], text);
			mysql_function_query(mysql, mysql_string, true, "DeletePhoneBook", "i", playerid);
		}
		case 7324:
		{
		    if(!response) return callcmd::phone(playerid);
		    SetPVarInt(playerid, "number_pb", strval(inputtext));
			new text[24];
			GetPVarString(playerid,"pb_namecont", text, sizeof(text));
			FixSVarString(text);

			mysql_string[0] = EOS, mf(mysql, mysql_string, 115, "SELECT * FROM `phonebook` WHERE `name_add` = '%e' AND `name` = '%e'",PI[playerid][pName], text);
			mysql_function_query(mysql, mysql_string, true, "ChangeNumberPhoneBook", "i", playerid);
		}
		case 7323:
		{
		    if(!response) return callcmd::phone(playerid);
			SetPVarString(playerid, "c_name", inputtext);
			new text[24];
			GetPVarString(playerid,"pb_namecont", text, sizeof(text));

			mysql_string[0] = EOS, mf(mysql, mysql_string, 115, "SELECT * FROM `phonebook` WHERE `name_add` = '%e' AND `name` = '%e'",PI[playerid][pName], text);
			mysql_function_query(mysql, mysql_string, true, "ChangeNamePhoneBook", "i", playerid);
		}
		case 7322:
		{
		    if(!response) return callcmd::phone(playerid);
			SetPVarString(playerid, "sms_pb", inputtext);
			new text[24];
			GetPVarString(playerid,"pb_namecont", text, sizeof(text));
			FixSVarString(text);
			
			mysql_string[0] = EOS, mf(mysql, mysql_string, 115, "SELECT * FROM `phonebook` WHERE `name_add` = '%e' AND `name` = '%e'",PI[playerid][pName], text);
			mysql_function_query(mysql, mysql_string, true, "SmsPhoneBook", "i", playerid);
		}
		case 7321:
		{
		    if(!response) return callcmd::phone(playerid);
			new number,name[24];
			if(sscanf(inputtext, "p<,>s[23]d", name, number)) return 1;

			mysql_string[0] = EOS, mf(mysql, mysql_string, 115, "SELECT * FROM `phonebook` WHERE name = '%e' AND name_add = '%e'", name, PI[playerid][pName]);
			mysql_function_query(mysql, mysql_string, true, "PhoneBookAddCheck", "d", playerid);

		    SetPVarString(playerid, "name_pb", name);
		    SetPVarInt(playerid, "number_pb", number);
		}
		case 7221:
		{
            if(strval(inputtext) == 777) return SCM(playerid, COLOR_GREY,"Разработка");
            if(strval(inputtext) == 999) return SCM(playerid, COLOR_GREY,"Разработка");
		    if(strval(inputtext) == 102) 
			{
		        if(PI[playerid][data_911_1] > 0) return SCM(playerid, COLOR_GREY,"Вы уже вызывали сотрудников Полиция");
				return ShowPlayerDialog(playerid, 9111, DIALOG_STYLE_INPUT, "{ee3366}Вызов полиции", "Вы позвонили на гарячую линию вызова полции.\nПожалуйста, оставайтесь на месте и опишите Ваше местоположение:", "Вызов", "Отмена");
		    }
		    if(strval(inputtext) == 103) 
			{
		        if(PI[playerid][data_911_2] > 0) return SCM(playerid, COLOR_GREY,"Вы уже вызывали сотрудников БЦРБ");
				return ShowPlayerDialog(playerid, 9112, DIALOG_STYLE_INPUT, "{ee3366}Вызов скорой помощи", "Вы позвонили на гарячую линию вызова скорой помощи.\nПожалуйста, оставайтесь на месте и опишите Ваше местоположение:", "Вызов", "Отмена");
		    }
			{
				new number[24];
				if(sscanf(inputtext, "p<,>d[23]", number)) return callcmd::phone(playerid);
				new str[144];
				format(str, sizeof(str), "%d", number);
				callcmd::call(playerid,str);
			}
		}
		case 7222: {
			new name, text[64] ;
			if(sscanf(inputtext, "p<,>d[23]s[63]", name, text)) return callcmd::phone(playerid);
			new str[70];
			format(str, sizeof(str), "%d %s", name, text );
			callcmd::sms(playerid,str);
		}
		case 6001: {
            if(!response) return 1;
			if(response) {
			    switch(listitem) {
			        case 0: ShowBankMoney(playerid);
			        case 1: {
						ShowPlayerDialog(playerid, 6002, DIALOG_STYLE_INPUT, "{ee3366}Перевод на другой счёт", "\
						{FFFFFF}Укажите ID получателя и сумма перевода\n\
						через запятую. Комиссия при переводе составит {3377cc}3%\n\
						{FFFF99}Пример формы для перевода: 12, 500000", "Перевести", "Назад");
					}
					case 2: return 1;
					case 3: ShowPlayerDialog(playerid, 7997, DIALOG_STYLE_LIST, "{ee3366}Оплата аредны", "1. Оплатить дом / квартиру\n2. Оплатить бизнес / АЗС", "Выбрать", "Отмена");
					case 4: return 1;
				}
			}
        }
		case 5213: 
		{
            if(!response) return 1;
			new id = GetPVarInt(playerid, "PrisonID");
			if(!IsPlayerConnected(id)) return  SCM(playerid, COLOR_GREY, !"Игрок не в сети");
			if(!IsPlayerLogged{id}) return  SCM(playerid, COLOR_GREY, !"Игрок не авторизован");
            switch(listitem) 
			{
                case 0: 
				{
					PI[id][pHospital] = 0;
					PI[id][pDemorgan] = 1;
					PI[id][pDemorganTime] = 60*15;
					SCMf(playerid, COLOR_TOMATO, "Вы посадили в тюрьму игрока %s на 15 минут. Причина: DM (п. 1.1)", PI[id][pName]);
					SCM(id, COLOR_TOMATO, "Игровой мастер посадил Вас в тюрьму на 15 минут. Причина: DM (п. 1.1)");
					SCMf(id, COLOR_LIGHTGREY, "Номер наказания: %d (для обжалования на {ff6633}"FORUM")");
					SendAdminsMessagef(COLOR_ADMINCHAT, "[%s #%d] %s[%d] посадил игрока %s в тюрьму на 15 минут. Причина: DM (п. 1.1)", AdminName[PI[playerid][pAdmin]], PI[playerid][pAdminNumber], PI[playerid][pName],playerid,PI[id][pName]);
					SavePlayerData(id);
					PlayerSpawn(id);

					if(PI[id][pOnCapture] == 1)
					{
						AutoKickCapture(id);
						CheckCount(id);
					}
                }
                case 1: 
				{
					PI[id][pHospital] = 0;
					PI[id][pDemorgan] = 1;
					PI[id][pDemorganTime] = 5*60;
					SCMf(playerid, COLOR_TOMATO, "Вы посадили в тюрьму игрока %s на 5 минут. Причина: NonRP Drive (п. 1.19)", PI[id][pName]);
					SCMf(id, COLOR_TOMATO, "Игровой мастер посадил Вас в тюрьму на 5 минут. Причина: NonRP Drive (п. 1.19)");
					SendAdminsMessagef(COLOR_ADMINCHAT, "[%s #%d] %s[%d] посадил игрока %s в тюрьму на 5 минут. Причина: NonRP Drive (п. 1.19)", AdminName[PI[playerid][pAdmin]], PI[playerid][pAdminNumber], PI[playerid][pName],playerid,PI[id][pName]);
					SavePlayerData(id);
					PlayerSpawn(id);

					if(PI[id][pOnCapture] == 1)
					{
						AutoKickCapture(id);
						CheckCount(id);
					}
                }
                case 2: 
				{
					PI[id][pHospital] = 0;
					PI[id][pDemorgan] = 1;
					PI[id][pDemorganTime] = 60*10;
					SCMf(playerid, COLOR_TOMATO, "Вы посадили в тюрьму игрока %s на 10 минут. Причина: DriveBy (п 1.4)", PI[id][pName]);
					SCMf(id, COLOR_TOMATO, "Игровой мастер посадил Вас в тюрьму на 10 минут. Причина: DriveBy (п 1.4)");
					SendAdminsMessagef(COLOR_ADMINCHAT, "[%s #%d] %s[%d] посадил игрока %s в тюрьму на 10 минут. Причина: DriveBy (п 1.4)", AdminName[PI[playerid][pAdmin]], PI[playerid][pAdminNumber], PI[playerid][pName],playerid,PI[id][pName]);
					SavePlayerData(id);
					PlayerSpawn(id);

					if(PI[id][pOnCapture] == 1)
					{
						AutoKickCapture(id);
						CheckCount(id);
					}
                }
                case 3: 
				{
					PI[id][pHospital] = 0;
					PI[id][pDemorgan] = 1;
					PI[id][pDemorganTime] = 60*20;
					SCMf(playerid, COLOR_TOMATO, "Вы посадили в тюрьму игрока %s на 20 минут. Причина: Багоюз (п 1.7)", PI[id][pName]);
					SCMf(id, COLOR_TOMATO, "Игровой мастер посадил Вас в тюрьму на 20 минут. Причина: Багоюз (п 1.7)");
					SendAdminsMessagef(COLOR_ADMINCHAT, "[%s #%d] %s[%d] посадил игрока %s в тюрьму на 20 минут. Причина: Багоюз (п 1.7)", AdminName[PI[playerid][pAdmin]], PI[playerid][pAdminNumber], PI[playerid][pName],playerid,PI[id][pName]);
					SavePlayerData(id);
					PlayerSpawn(id);

					if(PI[id][pOnCapture] == 1)
					{
						AutoKickCapture(id);
						CheckCount(id);
					}
                }
                case 4: 
				{
					PI[id][pHospital] = 0;
					PI[id][pDemorgan] = 1;
					PI[id][pDemorganTime] = 60*15;
					SCMf(playerid, COLOR_TOMATO, "Вы посадили в тюрьму игрока %s на 15 минут. Причина: Помеха работе (п 1.9)", PI[id][pName]);
					SCMf(id, COLOR_TOMATO, "Игровой мастер посадил Вас в тюрьму на 15 минут. Причина: Помеха работе (п 1.9)");
					SendAdminsMessagef(COLOR_ADMINCHAT, "[%s #%d] %s[%d] посадил игрока %s в тюрьму на 15 минут. Причина: Помеха работе (п 1.9)", AdminName[PI[playerid][pAdmin]], PI[playerid][pAdminNumber], PI[playerid][pName],playerid,PI[id][pName]);
					SavePlayerData(id);
					PlayerSpawn(id);

					if(PI[id][pOnCapture] == 1)
					{
						AutoKickCapture(id);
						CheckCount(id);
					}
                }
                case 5: 
				{
					PI[id][pHospital] = 0;
					PI[id][pDemorgan] = 1;
					PI[id][pDemorganTime] = 15*60;
					SCMf(playerid, COLOR_TOMATO, "Вы посадили в тюрьму игрока %s на 15 минут. Причина: Помеха РП процессу (п 1.22)", PI[id][pName]);
					SCMf(id, COLOR_TOMATO, "Игровой мастер посадил Вас в тюрьму на 15 минут. Причина: Помеха РП процессу (п 1.22)");
					SendAdminsMessagef(COLOR_ADMINCHAT, "[%s #%d] %s[%d] посадил игрока %s в тюрьму на 15 минут. Причина: Помеха РП процессу (п 1.22)", AdminName[PI[playerid][pAdmin]], PI[playerid][pAdminNumber], PI[playerid][pName],playerid,PI[id][pName]);
					SavePlayerData(id);
					PlayerSpawn(id);

					if(PI[id][pOnCapture] == 1)
					{
						AutoKickCapture(id);
						CheckCount(id);
					}
                }
                case 6: 
				{
					if(PI[playerid][pAdmin] < 2) return SCM(playerid, COLOR_GREY, !"Для выдачи этого наказания у Вас должен быть более высокий уровень игрового мастера.");
					PI[id][pVmute] = 1;
					PI[id][pVmuteTime] = 10*60;

					SendPlayerHudNotify(id, 20, "mute", "Блокировка голосового чата", PI[id][pVmuteTime]);

					SCMf(playerid, COLOR_TOMATO, "Вы заблокировали голосовой чат игрока %s на 10 минут. Причина: Музыка (п 2.9)", PI[id][pName]);
					SCMf(id, COLOR_TOMATO, "Игровой мастер заблокировал Вам голосовой чат на 10 минут. Причина: Музыка (п 2.9)");
					SendAdminsMessagef(COLOR_ADMINCHAT, "[%s #%d] %s[%d] заблокировал голосовой чат игроку %s на 10 минут. Причина: Музыка (п 2.9)", AdminName[PI[playerid][pAdmin]], PI[playerid][pAdminNumber], PI[playerid][pName],playerid,PI[id][pName]);
					SvMutePlayerEnable(id);
                }
                case 7: 
				{
					PI[id][pHospital] = 0;
					PI[id][pDemorgan] = 1;
					PI[id][pDemorganTime] = 5*60;
					SCMf(playerid, COLOR_TOMATO, "Вы посадили в тюрьму игрока %s на 5 минут. Причина: TeamKill (п 1.7)", PI[id][pName]);
					SCMf(id, COLOR_TOMATO, "Игровой мастер посадил Вас в тюрьму на 5 минут. Причина: TeamKill (п 1.7)");
					SendAdminsMessagef(COLOR_ADMINCHAT, "[%s #%d] %s[%d] посадил игрока %s в тюрьму на 5 минут. Причина: TeamKill (п 1.7)", AdminName[PI[playerid][pAdmin]], PI[playerid][pAdminNumber], PI[playerid][pName],playerid,PI[id][pName]);
					SavePlayerData(id);
					PlayerSpawn(id);

					if(PI[id][pOnCapture] == 1)
					{
						AutoKickCapture(id);
						CheckCount(id);
					}
                }
                case 8: 
				{
					if(PI[playerid][pAdmin] < 3) return SCM(playerid, COLOR_GREY, !"Для выдачи этого наказания у Вас должен быть более высокий уровень  игрового мастера.");
					PI[id][pMember] = 0;
					PI[id][pLeader] = 0;
					PI[id][pRang] = 0;
					PI[id][pAdmin] = 0;
				    mysql_string[0] = EOS, mf(mysql, mysql_string, 185, "INSERT INTO `banlist` ( `name`,`admin`, `day`, `text`, `ip`) VALUES ( '%e', '%e', '1', 'Оскорбление игры (п 1.37)', '%e')",PI[id][pName],PI[playerid][pName],PI[id][pLoginIP]);
				    mysql_function_query(mysql, mysql_string, false, "", "");
					SCMf(playerid, COLOR_TOMATO, "Вы заблокировали игрока %s на 1 дн. Причина: Оскорбление игры (п 1.37)", PI[id][pName]);
					SCM(id, COLOR_TOMATO, "Ваш персонаж заблокирован на 1 дн. Причина: Оскорбление игры (п 1.37)");
					SendAdminsMessagef(COLOR_ADMINCHAT, "[%s #%d] %s[%d] заблокировал игрока %s на 1 дн.  Причина: Оскорбление игры (п 1.37)", AdminName[PI[playerid][pAdmin]], PI[playerid][pAdminNumber],PI[playerid][pName],playerid,PI[id][pName]);
					Kick(id);
                }
                case 9: 
				{
					if(PI[playerid][pAdmin] < 2) return SCM(playerid, COLOR_GREY, !"Для выдачи этого наказания у Вас должен быть более высокий уровень  игрового мастера.");
                	PI[id][pMute] = 1;
					PI[id][pMuteTime] = 120*60;
					SCMf(playerid, COLOR_TOMATO, "Вы заблокировали чат игрока %s на 120 минут. Причина: Оскорбление ИМ (п 1.25)", PI[id][pName]);
					SCMf(id, COLOR_TOMATO, "Игровой мастер заблокировал Вам чат на 120 минут. Причина: Оскорбление ИМ (п 1.25)");
					SendAdminsMessagef(COLOR_ADMINCHAT, "[%s #%d] %s[%d] заблокировал чат игроку %s на 120 минут. Причина: Оскорбление ИМ (п 1.25)", AdminName[PI[playerid][pAdmin]], PI[playerid][pAdminNumber], PI[playerid][pName],playerid,PI[id][pName]);
                }
                case 10: 
				{
					if(PI[playerid][pAdmin] < 3) return SCM(playerid, COLOR_GREY, !"Для выдачи этого наказания у Вас должен быть более высокий уровень игрового мастера.");
					PI[id][pMember] = 0;
					PI[id][pLeader] = 0;
					PI[id][pRang] = 0;
					PI[id][pAdmin] = 0;
				 	mysql_string[0] = EOS, mf(mysql, mysql_string, 175, "INSERT INTO `banlist` ( `name`,`admin`, `day`, `text`, `ip`) VALUES ( '%e', '%e', '1', 'Реклама (п 2.6)', '%e')",PI[id][pName],PI[playerid][pName],PI[id][pLoginIP]);
				    mysql_function_query(mysql, mysql_string, false, "", "");
					SCMf(playerid, COLOR_TOMATO, "Вы заблокировали игрока %s на 1 дн. Причина: Реклама (п 2.6)", PI[id][pName]);
					SCM(id, COLOR_TOMATO, "Ваш персонаж заблокирован на 1 дн. Причина: Реклама (п 2.6)");
					SendAdminsMessagef(COLOR_ADMINCHAT, "[%s #%d] %s[%d] заблокировал игрока %s на 1 дн.  Причина: Реклама (п 2.6)", AdminName[PI[playerid][pAdmin]], PI[playerid][pAdminNumber], PI[playerid][pName],playerid,PI[id][pName]);
					Kick(id);
                }
                case 11: 
				{
					if(PI[playerid][pAdmin] < 2) return SCM(playerid, COLOR_GREY, !"Для выдачи этого наказания у Вас должен быть более высокий уровень игрового мастера.");
                	PI[id][pMute] = 1;
					PI[id][pMuteTime] = 15*60;
					SCMf(playerid, COLOR_TOMATO, "Вы заблокировали чат игрока %s на 15 минут. Причина: Флуд (п 2.5)", PI[id][pName]);
					SCMf(id, COLOR_TOMATO, "Игровой мастер заблокировал Вам чат на 15 минут. Причина: Флуд (п 2.5)");
					SendAdminsMessagef(COLOR_ADMINCHAT, "[%s #%d] %s[%d] заблокировал чат игроку %s на 15 минут. Причина: Флуд (п 2.5)", AdminName[PI[playerid][pAdmin]], PI[playerid][pAdminNumber], PI[playerid][pName],playerid,PI[id][pName]);
                }
                case 12: 
				{
					if(PI[playerid][pAdmin] < 2) return SCM(playerid, COLOR_GREY, !"Для выдачи этого наказания у Вас должен быть более высокий уровень игрового мастера.");
                	PI[id][pMute] = 1;
					PI[id][pMuteTime] = 15*60;
					SCMf(playerid, COLOR_TOMATO, "Вы заблокировали чат игрока %s на 15 минут. Причина: Оффтоп (п 2.5)", PI[id][pName]);
					SCMf(id, COLOR_TOMATO, "Игровой мастер заблокировал Вам чат на 15 минут. Причина: Оффтоп (п 2.5)");
					SendAdminsMessagef(COLOR_ADMINCHAT, "[%s #%d] %s[%d] заблокировал чат игроку %s на 15 минут. Причина: Оффтоп (п 2.5)", AdminName[PI[playerid][pAdmin]], PI[playerid][pAdminNumber], PI[playerid][pName],playerid,PI[id][pName]);
                }
                case 13: 
				{
					PI[id][pHospital] = 0;
					PI[id][pDemorgan] = 1;
					PI[id][pDemorganTime] = 25*60;
					SCMf(playerid, COLOR_TOMATO, "Вы посадили в тюрьму игрока %s на 25 минут. Причина: AFK в бою (п 1.5)", PI[id][pName]);
					SCMf(id, COLOR_TOMATO, "Игровой мастер посадил Вас в тюрьму на 25 минут. Причина: AFK в бою (п 1.5)");
					SendAdminsMessagef(COLOR_ADMINCHAT, "[%s #%d] %s[%d] посадил игрока %s в тюрьму на 25 минут. Причина: AFK в бою (п 1.5)", AdminName[PI[playerid][pAdmin]], PI[playerid][pAdminNumber], PI[playerid][pName],playerid,PI[id][pName]);
					SavePlayerData(id);
					PlayerSpawn(id);

					if(PI[id][pOnCapture] == 1)
					{
						AutoKickCapture(id);
						CheckCount(id);
					}
                }
                case 14: 
				{
					if(PI[playerid][pAdmin] < 2) return SCM(playerid, COLOR_GREY, !"Для выдачи этого наказания у Вас должен быть более высокий уровень игрового мастера.");
                	PI[id][pMute] = 1;
					PI[id][pMuteTime] = 10;
					SCMf(playerid, COLOR_TOMATO, "Вы заблокировали чат игрока %s на 10 минут. Причина: MG (п 2.7)", PI[id][pName]);
					SCMf(id, COLOR_TOMATO, "Игровой мастер заблокировал Вам чат на 10 минут. Причина: MG (п 2.7)");
					SendAdminsMessagef(COLOR_ADMINCHAT, "[%s #%d] %s[%d] заблокировал чат игроку %s на 10 минут. Причина: MG (п 2.7)", AdminName[PI[playerid][pAdmin]], PI[playerid][pAdminNumber], PI[playerid][pName],playerid,PI[id][pName]);
                }
                case 15: 
				{
					if(PI[playerid][pAdmin] < 2) return SCM(playerid, COLOR_GREY, !"Для выдачи этого наказания у Вас должен быть более высокий уровень игрового мастера.");
                	PI[id][pMute] = 1;
					PI[id][pMuteTime] = 10;
					SCMf(playerid, COLOR_TOMATO, "Вы заблокировали чат игрока %s на 10 минут. Причина: MG (п 2.10)", PI[id][pName]);
					SCMf(id, COLOR_TOMATO, "Игровой мастер заблокировал Вам чат на 10 минут. Причина: MG (п 2.10)");
					SendAdminsMessagef(COLOR_ADMINCHAT, "[%s #%d] %s[%d] заблокировал чат игроку %s на 10 минут. Причина: MG (п 2.10)", AdminName[PI[playerid][pAdmin]], PI[playerid][pAdminNumber], PI[playerid][pName],playerid,PI[id][pName]);
                }
				case 16: 
				{
					PI[id][pHospital] = 0;
					PI[id][pDemorgan] = 1;
					PI[id][pDemorganTime] = 60*60;
					SCMf(playerid, COLOR_TOMATO, "Вы посадили в тюрьму игрока %s на 60 минут. Причина: Читы / Скрипты (п 1.6)", PI[id][pName]);
					SCMf(id, COLOR_TOMATO, "Игровой мастер посадил Вас в тюрьму на 60 минут. Причина: Читы / Скрипты (п 1.6)");
					SendAdminsMessagef(COLOR_ADMINCHAT, "[%s #%d] %s[%d] посадил игрока %s в тюрьму на 60 минут. Причина: Читы / Скрипты (п 1.6)", AdminName[PI[playerid][pAdmin]], PI[playerid][pAdminNumber], PI[playerid][pName],playerid,PI[id][pName]);
					SavePlayerData(id);
					PlayerSpawn(id);

					if(PI[id][pOnCapture] == 1)
					{
						AutoKickCapture(id);
						CheckCount(id);
					}
                }
                case 17: 
				{
					PI[id][pHospital] = 0;
					PI[id][pDemorgan] = 1;
					PI[id][pDemorganTime] = 15*60;
					SCMf(playerid, COLOR_TOMATO, "Вы посадили в тюрьму игрока %s на 15 минут. Причина: PowerGaming (п 1.12)", PI[id][pName]);
					SCMf(id, COLOR_TOMATO, "Игровой мастер посадил Вас в тюрьму на 15 минут. Причина: PowerGaming (п 1.12)");
					SendAdminsMessagef(COLOR_ADMINCHAT, "[%s #%d] %s[%d] посадил игрока %s в тюрьму на 15 минут. Причина: PowerGaming (п 1.12)", AdminName[PI[playerid][pAdmin]], PI[playerid][pAdminNumber], PI[playerid][pName],playerid,PI[id][pName]);
					SavePlayerData(id);
					PlayerSpawn(id);

					if(PI[id][pOnCapture] == 1)
					{
						AutoKickCapture(id);
						CheckCount(id);
					}
                }
                case 18: 
				{
					PI[id][pHospital] = 0;
					PI[id][pDemorgan] = 1;
					PI[id][pDemorganTime] = 5*60;
					SCMf(playerid, COLOR_TOMATO, "Вы посадили в тюрьму игрока %s на 5 минут. Причина: NonRP /me (п 1.25)", PI[id][pName]);
					SCMf(id, COLOR_TOMATO, "Игровой мастер посадил Вас в тюрьму на 5 минут. Причина: NonRP /me (п 1.25)");
					SendAdminsMessagef(COLOR_ADMINCHAT, "[%s #%d] %s[%d] посадил игрока %s в тюрьму на 5 минут. Причина: NonRP /me (п 1.25)", AdminName[PI[playerid][pAdmin]], PI[playerid][pAdminNumber], PI[playerid][pName],playerid,PI[id][pName]);
					SavePlayerData(id);
					PlayerSpawn(id);

					if(PI[id][pOnCapture] == 1)
					{
						AutoKickCapture(id);
						CheckCount(id);
					}
                }
                case 19: 
				{
					if(PI[playerid][pAdmin] < 2) return SCM(playerid, COLOR_GREY, !"Для выдачи этого наказания у Вас должен быть более высокий уровень игрового мастера.");
					SCMf(playerid, COLOR_TOMATO, "Вы кикнули игрока %s. Причина: NonRP /sleep (п 1.39)", PI[id][pName]);
					SCMf(id, COLOR_TOMATO, "Игровой мастер кикнул Вас. Причина: NonRP /sleep (п 1.39)");
					SendAdminsMessagef(COLOR_ADMINCHAT, "[%s #%d] %s[%d] кикнул игрока %s. Причина: NonRP /sleep (п 1.39)", AdminName[PI[playerid][pAdmin]], PI[playerid][pAdminNumber], PI[playerid][pName],playerid,PI[id][pName]);
					SCM(id,COLOR_GREY, "Вы были отключены от сервера, для выхода из игры используйте /(q)uit");
					Kick(id);
                }
                case 20: 
				{
					if(PI[playerid][pAdmin] < 2) return SCM(playerid, COLOR_GREY, !"Для выдачи этого наказания у Вас должен быть более высокий уровень игрового мастера.");
					PI[id][pVmute] = 1;
					PI[id][pVmuteTime] = 15*60;

					SendPlayerHudNotify(id, 20, "mute", "Блокировка голосового чата", PI[id][pVmuteTime]);

					SCMf(playerid, COLOR_TOMATO, "Вы заблокировали голосовой чат игрока %s на 15 минут. Причина: Неадекватное поведение (п 2.12)", PI[id][pName]);
					SCMf(id, COLOR_TOMATO, "Игровой мастер заблокировал Вам голосовой чат на 15 минут. Причина: Неадекватное поведение (п 2.12)");
					SendAdminsMessagef(COLOR_ADMINCHAT, "[%s #%d] %s[%d] заблокировал голосовой чат игроку %s на 15 минут. Причина: Неадекватное поведение (п 2.12)", AdminName[PI[playerid][pAdmin]], PI[playerid][pAdminNumber], PI[playerid][pName],playerid,PI[id][pName]);
					SvMutePlayerEnable(id);
                }
            }
            DeletePVar(playerid, "PrisonID");
        }
        case 7997: 
		{
            if(!response) return 1;
			if(response) 
			{
			    switch(listitem) 
				{
			        case 0: 
					{
					    if(PI[playerid][pHouse] == INVALID_HOUSE_ID && PI[playerid][pFloat] == INVALID_KV_ID) return SCM(playerid, COLOR_GREY, !"У Вас нет дома или квартиры");
						if(PI[playerid][pHouse] != INVALID_HOUSE_ID) 
						{
							new h = PI[playerid][pHouse];
						 	ShowPlayerDialogf(playerid, 7950, DIALOG_STYLE_INPUT, "{ee3366}Оплата жилья", "Выполнить", "Назад","\
							Номер дома: %d\n\
							{FFFFFF}Статус оплаты: %d / 30 дней\n\
							{FFFF99}Квартплата - 1499 руб / день\n\n\
							{FFFFFF}Введите количество дней для оплаты", HOUSE_DATA[h][data_ID], HOUSE_DATA[h][data_DAY]);
				        }
				        else if(PI[playerid][pFloat] != INVALID_KV_ID) 
						{
							new kv = PI[playerid][data_PADIK],k = PI[playerid][pFloat];
						 	ShowPlayerDialogf(playerid, 7951, DIALOG_STYLE_INPUT, "{ee3366}Оплата жилья", "Выполнить", "Назад", "\
							Номер квартиры: %d\n\
							{FFFFFF}Статус оплаты: %d / 30 дн\n\
							{FFFF99}Квартплата - 1299 руб / день\n\n\
							{FFFFFF}Введите количество дней для оплаты",kvData[kv][kvID],kvData[kv][kvDays][k]);
				        }
					}
					case 1:
					{
					    if(PI[playerid][pBusiness] == INVALID_BUSINESS_ID) return SCM(playerid, COLOR_GREY,"У Вас нет бизнеса или АЗС");
						new b = GetBusinessIndexByID(PI[playerid][pBusiness]);
						ShowPlayerDialogf(playerid, 7952, DIALOG_STYLE_INPUT, "{ee3366}Оплата бизнеса", "Выполнить", "Назад", "\
						Номер бизнеса: %d\n\
						{FFFFFF}Статус оплаты: %d / 30 дней\n\
						{FFFF99}Налог - 3999 рублей\n\n\
						{FFFFFF}Введите количество дней для оплаты", BizInfo[b][bID], BizInfo[b][bDays]);
					}
				}
			}
        }
		case 7900: {
		    if(!response) return 1;
		    if(response) {
		        for(new h = 0; h < TotalHouses; h++) {
		        	if(PlayerToPoint(3.0, playerid, HOUSE_DATA[h][data_ENTERX], HOUSE_DATA[h][data_ENTERY], HOUSE_DATA[h][data_ENTERZ])) {
			            if(PI[playerid][pFloat] != INVALID_KV_ID || PI[playerid][pHouse] != INVALID_HOUSE_ID) return SCM(playerid, COLOR_GREY,"У Вас уже есть недвижимость");
			            if(HOUSE_DATA[h][data_OWNED] == 1) return SCM(playerid, COLOR_GREY,"Данный дом уже куплен");
						if(GetPlayerMoneyID(playerid) < HOUSE_DATA[h][data_PRICE]) return SCM(playerid, COLOR_GREY,"У Вас недостаточно денег на руках");
						PI[playerid][pHouse] = h;
			            HOUSE_DATA[h][data_OWNED] = 1;
			            HOUSE_DATA[h][data_DAY] = 3;
			            strmid(HOUSE_DATA[h][data_OWNER], PI[playerid][pName], 0, strlen(PI[playerid][pName]), MAX_PLAYER_NAME);
			            GivePlayerMoneyLog(playerid,-HOUSE_DATA[h][data_PRICE]);
			            SCM(playerid,0xFFCC33FF, "Поздравляем Вас с покупкой дома! Он был оплачен на 3 дня");
			            SCM(playerid,0xFFCC33FF, "Для управления домом используйте: /home");
			            SCM(playerid, 0x9F81F7FF, "Используйте: /setspawn, чтобы изменить место появления");
			            UpdateHouseData(h);
			            SaveHouseData(h);
			           	return 1;
			        }
		    	}
			}
		}
		case 8791:
		{
			if (!response) return 1;

			new fromPlayerId = GetPVarInt(playerid, "from_player");
			new gun = GetPlayerWeapon(fromPlayerId);
			new gunslot = getWeaponIdSlot(gun);
			new value1 = GetPVarInt(playerid, "value_1");
			new gunAmmo = PI[fromPlayerId][data_AMMO][gunslot];
			new gunPrice = GetPVarInt(fromPlayerId, "cena");
			new pricePerPt = GetPVarInt(fromPlayerId, "pt");
			
			if (gunAmmo == 0 || gunslot == 0) 
			{
				return SCM(fromPlayerId, COLOR_GREY, "Чтобы продать оружие, нужно взять его в руки");
			}
			if (gunAmmo < value1) 
			{
				return SCM(fromPlayerId, COLOR_GREY, "У Вас нет такого количества патронов");
			}
			
			PI[fromPlayerId][data_AMMO][gunslot] -= value1;
			SetWeapon(fromPlayerId, gun, PI[fromPlayerId][data_AMMO][gunslot]);
			GiveWeapon(playerid, gun, value1);
			
			new gunCost = gunPrice / pricePerPt;

			SCMf(fromPlayerId, 0xFF99CCFF, "%s купил у Вас %s (%d пт) за %d руб (%d за 1 пт)", PI[playerid][pName], weapon_names[gun], value1, gunPrice, gunCost);
			GivePlayerMoneyLog(playerid, -gunPrice);
			GivePlayerMoneyLog(fromPlayerId, gunPrice);

			SCMf(playerid, 0xFF99CCFF, "Вы купили у %s %s (%d пт) за %d руб (%d за 1 пт)", PI[fromPlayerId][pName], weapon_names[gun], value1, gunPrice, gunCost);

			PI[fromPlayerId][pProgressSellGun] += 1;

			return 1;
		}
		case 8790: 
		{
			if(!response) return 1;
			if(response) 
			{
				new from_player = PI[playerid][pRequestFrom];
				new value = PI[from_player][pRequestValue_1];

				new gun = GetPlayerWeapon(from_player);
				new gunslot = getWeaponIdSlot(gun);

				if(PI[from_player][data_GUN][gunslot] == 0 || gunslot == 0) return SCM(from_player, COLOR_GREY, "Чтобы передать оружие, нужно взять его в руки");
				if(PI[from_player][data_AMMO][gunslot] < value) return SCM(from_player, COLOR_GREY, "У Вас нет такого количества патронов");
				new ammonew = PI[from_player][data_AMMO][gunslot] - value;
				SetWeapon(from_player, gun, ammonew);
				GiveWeapon(playerid, gun, value);
				new string[60];
				format(string, sizeof(string), "%s передал(а) оружие %s",PI[from_player][pName],PI[playerid][pName]);
				ProxDetector(30.0, from_player, string, 0xFF99CCFF, 0xFF99CCFF, 0xFF99CCFF, 0xFF99CCFF, 0xFF99CCFF);
				SetPlayerChatBubble(from_player, "передал(а) оружие", 0xFF99CCFF, 20.0, 4000);
				SCMf(from_player, 0xFF99CCFF, "%s взял у Вас %s (%d пт)",PI[playerid][pName], weapon_names[gun], value);

				ClearRequest(PI[playerid][pRequestFrom]);
				ClearRequest(playerid);
			}
		}
		case 7515: 
		{
			if(!response) return 1;
			if(response) 
			{
			    switch(listitem) 
				{
   					case 0: ShowPlayerDialog(playerid, 9315, DIALOG_STYLE_LIST, !"Государственная волна", !"Запланировать за 30 минут", "Выбрать", "Назад");
      				case 1: ShowPlayerDialog(playerid, 9316, DIALOG_STYLE_LIST, !"Государственная волна", !"Запланировать за 15 минут", "Выбрать", "Назад");
      				case 2: ShowPlayerDialog(playerid, 9323, DIALOG_STYLE_LIST, !"Государственная волна", !"Запланировать за 5 минут", "Выбрать", "Назад");
      				case 3: ShowPlayerDialog(playerid, 9312, DIALOG_STYLE_LIST, !"Государственная волна", !"Начать собеседование", "Выбрать", "Назад");
      				case 4: ShowPlayerDialog(playerid, 9313, DIALOG_STYLE_LIST, !"Государственная волна", !"Продолжить собеседование", "Выбрать", "Назад");
      				case 5: ShowPlayerDialog(playerid, 9314, DIALOG_STYLE_LIST, !"Государственная волна", !"Закончить собеседование", "Выбрать", "Назад");
      				case 6: ShowPlayerDialog(playerid, 9328, DIALOG_STYLE_LIST, !"Государственная волна", !"Отменить собеседование", "Выбрать", "Назад");

				}
			}
		}
		case 7788: 
		{
			if(!response) return 1;
			if(response) 
			{
			    switch(listitem) 
				{
   					case 0: ShowPlayerDialog(playerid, 9315, DIALOG_STYLE_LIST, "Государственная волна", "Запланировать за 30 минут", "Выбрать", "Назад");
      				case 1: ShowPlayerDialog(playerid, 9316, DIALOG_STYLE_LIST, "Государственная волна", "Запланировать за 15 минут", "Выбрать", "Назад");
      				case 2: ShowPlayerDialog(playerid, 9323, DIALOG_STYLE_LIST, "Государственная волна", "Запланировать за 5 минут", "Выбрать", "Назад");
      				case 3: ShowPlayerDialog(playerid, 9312, DIALOG_STYLE_LIST, "Государственная волна", "Начать собеседование", "Выбрать", "Назад");
      				case 4: ShowPlayerDialog(playerid, 9313, DIALOG_STYLE_LIST, "Государственная волна", "Продолжить призыв", "Выбрать", "Назад");
      				case 5: ShowPlayerDialog(playerid, 9314, DIALOG_STYLE_LIST, "Государственная волна", "Закончить призыв", "Выбрать", "Назад");
      				case 6: ShowPlayerDialog(playerid, 9328, DIALOG_STYLE_LIST, "Государственная волна", "Отменить призыв", "Выбрать", "Назад");

				}
			}
		}
		case 9312:
		{
		    if(!response) return callcmd::gov(playerid);
			if(response)
			{
				switch(listitem) 
				{
					case 0:
					{
						if(PI[playerid][pMember] != 0)
						{
							SendClientMessageToAllf(COLOR_BLACKBLUE, "В организации «%s» началось собеседование", Fraction_Name[PI[playerid][pMember]]);
							SendClientMessageToAllf(COLOR_BLACKBLUE, "Все подробности Вы найдёте на информационном пикапе в здание *%s*", Fraction_Name[PI[playerid][pMember]]);
						}
						return SCM(playerid, COLOR_LIGHTORANGE, !"[!!!] {ffff99}Вы успешно начали собеседование/призыв");
					}
				}
			}
  		}
		case 9313:
		{
		    if(!response) return callcmd::gov(playerid);
			if(response) 
			{
				switch(listitem) 
				{
					case 0:
					{
						if(PI[playerid][pMember] != 0)
						{
							SendClientMessageToAllf(COLOR_BLACKBLUE, "В организации «%s» продолжается собеседование", Fraction_Name[PI[playerid][pMember]]);
							SendClientMessageToAllf(COLOR_BLACKBLUE, "Все подробности Вы найдёте на информационном пикапе в здание «%s»", Fraction_Name[PI[playerid][pMember]]);
						}
						return SCM(playerid, COLOR_LIGHTORANGE, !"[!!!] {ffff99}Вы успешно продолжили собеседование/призыв");
					}
				}
			}
  		}
		case 9314:
		{
		    if(!response) return callcmd::gov(playerid);
			if(response) 
			{
				switch(listitem) 
				{
					case 0:
					{
						if(PI[playerid][pMember] != 0)
						{
							SendClientMessageToAllf(COLOR_BLACKBLUE, "В организации «%s» закончилось собеседование", Fraction_Name[PI[playerid][pMember]]);
							SendClientMessageToAllf(COLOR_BLACKBLUE, "Все подробности Вы найдёте на информационном пикапе в здание «%s»", Fraction_Name[PI[playerid][pMember]]);
						}
						return SCM(playerid, COLOR_LIGHTORANGE, !"[!!!] {ffff99}Вы успешно закончили собеседование/призыв");
					}
				}
			}
  		}
		case 9315:
		{
		    if(!response) return callcmd::gov(playerid);
			if(response) 
			{
				switch(listitem) 
				{
					case 0:
					{
						if(PI[playerid][pMember] != 0)
						{
							SendClientMessageToAllf(COLOR_BLACKBLUE, "Через 30 минут начнётся собеседование в организацию «%s»", Fraction_Name[PI[playerid][pMember]]);
							SendClientMessageToAllf(COLOR_BLACKBLUE, "Все подробности Вы найдёте на информационном пикапе в здание «%s»", Fraction_Name[PI[playerid][pMember]]);
						}
						return SCM(playerid, COLOR_LIGHTORANGE, !"[!!!] {ffff99}Вы успешно оповестили граждан о своём собеседование/призыве");
					}
				}
			}
  		}
		case 9316:
		{
		    if(!response) return callcmd::gov(playerid);
			if(response) 
			{
				switch(listitem) 
				{
					case 0:
					{
						if(PI[playerid][pMember] != 0)
						{
							SendClientMessageToAllf(COLOR_BLACKBLUE, "Через 15 минут начнётся собеседование в организацию «%s»", Fraction_Name[PI[playerid][pMember]]);
							SendClientMessageToAllf(COLOR_BLACKBLUE, "Все подробности Вы найдёте на информационном пикапе в здание «%s»", Fraction_Name[PI[playerid][pMember]]);
						}
						return SCM(playerid, COLOR_LIGHTORANGE, !"[!!!] {ffff99}Вы успешно оповестили граждан о своём собеседование/призыве");
					}
				}
			}
  		}
		case 9323:
		{
		    if(!response) return open_gov(playerid);
			if(response) 
			{
				switch(listitem)
				{
					case 0:
					{
						if(PI[playerid][pMember] != 0)
						{
							SendClientMessageToAllf(COLOR_BLACKBLUE,"Через 5 минут начнётся собеседование в организацию «%s»", Fraction_Name[PI[playerid][pMember]]);
							SendClientMessageToAllf(COLOR_BLACKBLUE,"Все подробности Вы найдёте на информационном пикапе в здание «%s»", Fraction_Name[PI[playerid][pMember]]);
						}
						return SCM(playerid, COLOR_LIGHTORANGE, !"[!!!] {ffff99}Вы успешно оповестили граждан о своём собеседование/призыве");
					}
				}
			}
  		}
		case 9328:
		{
		    if(!response) return open_gov(playerid);
			if(response) 
			{
				switch(listitem) 
				{
					case 0:
					{
						if(PI[playerid][pMember] != 0)
						{
							SendClientMessageToAllf(COLOR_BLACKBLUE,"Собеседование в организацию «%s» отменено.", Fraction_Name[PI[playerid][pMember]]);
						}
						return SCM(playerid, COLOR_LIGHTORANGE, !"[!!!] {ffff99}Вы отменили собеседование/призыв");
					}
				}
			}
  		}
		case 7500: 
		{
		    if(!response) return 1;
		    if(response) 
			{
			    switch(listitem) 
				{
      				case 0: 
					{
					    if(PI[playerid][pRang] < 10) return SCM(playerid, COLOR_GREY, !"Данная команда доступна лидерам организаций");
						if(!IsPlayerLogged{playerid}) return 1;

						mysql_string[0] = EOS, mf(mysql, mysql_string, 50, "SELECT * FROM `group` WHERE `fraction` = '%d'", PI[playerid][pMember]);
						mysql_function_query(mysql, mysql_string, true, "EditGroup", "d", playerid);
      				}
      				case 1: 
					{
						if(PI[playerid][pMember] == 5 || PI[playerid][pMember] == 6 || PI[playerid][pMember] == 7) return SCM(playerid, COLOR_YELLOW, "Переводы доступны только в Государственых Организациях");
      					callcmd::transfers(playerid);
      				}
      				case 2: callcmd::allmembers(playerid);
      				case 3: callcmd::bl(playerid);
      				case 4: ShowPlayerDialog(playerid, 8975, DIALOG_STYLE_LIST, "{ee3366}Автопарк организации", "{FFFFFF}1. Заспавнить транспорт организации", "Выбрать", "Назад");
      				case 5: ShowPlayerDialog(playerid, 7512, DIALOG_STYLE_INPUT, "{ee3366}Принять в организацию", "{FFFFFF}Введите ID игрока:", "Принять", "Отмена");
      				case 6: ShowPlayerDialog(playerid, 7502, DIALOG_STYLE_INPUT, "{ee3366}Уволить из организации", "{FFFFFF}Введите ID игрока и причину через запятую в поле ниже\nПример: 5,НВЗ", "Уволить", "Отмена");
      				case 7: ShowPlayerDialog(playerid, 7504, DIALOG_STYLE_INPUT, "{ee3366}Уволить из организации оффлайн", "{FFFFFF}Введите имя игрока в поле ниже\n{d7d394}Например: Ivan_Zolo", "Уволить", "Отмена");
      				case 8: ShowPlayerDialog(playerid, 7505, DIALOG_STYLE_INPUT, "{ee3366}Выдать выговор", "{FFFFFF}Введите ID игрока и причину через запятую в поле ниже\n{d7d394}Например: 32, Н.В.З.", "Выдать", "Отмена");
      				case 9: ShowPlayerDialog(playerid, 7506, DIALOG_STYLE_INPUT, "{ee3366}Выдать выговор в оффлайн", "{FFFFFF}Введите имя игрока в поле ниже\n{d7d394}Например: Ivan_Zolo", "Выдать", "Отмена");
      				case 10: ShowPlayerDialog(playerid, 7507, DIALOG_STYLE_INPUT, "{ee3366}Снять выговор", "{FFFFFF}Введите ID игрока и причину через запятую в поле ниже\nПример: 5,Ошибка", "Снять", "Отмена");
      				case 11: ShowPlayerDialog(playerid, 7508, DIALOG_STYLE_INPUT, "{ee3366}Снять выговор в оффлайн", "{FFFFFF}Введите имя игрока в поле ниже\nПример: Ivan_Bober", "Снять", "Отмена");
      				case 12: ShowPlayerDialog(playerid, 7509, DIALOG_STYLE_INPUT, "{ee3366}Изменить ранг", "{FFFFFF}Введите ID игрока и '+' или '-' (без кавычек) через запятую\nПример: 78, +", "Изменить", "Отмена");
      				case 13: ShowPlayerDialog(playerid, 7510, DIALOG_STYLE_INPUT, "{ee3366}Изменить внешность", "{FFFFFF}Введите ID игрока:", "Изменить", "Отмена");
      				case 14: ShowPlayerDialog(playerid, 7511, DIALOG_STYLE_INPUT, "{ee3366}Изменить группу", "{FFFFFF}Введите ID игрока:", "Изменить", "Отмена");
				    case 15: ShowPlayerDialog(playerid, 7503, DIALOG_STYLE_MSGBOX, !"{ee3366}Расформировать организацию", "{FFFFFF}Вы подтверждаете расормирование организации?\nДействие нельзя будет отменить.", "Продолжить", "Отмена");
				    case 16: callcmd::gov(playerid);
			    }
			}
      	}
		case 7501:
		{
		    if(!response) return 1;
		    if(response)
			{
			    switch(listitem) 
				{
      				case 0: 
					{
					    if(PI[playerid][pRang] < 10) return SCM(playerid, COLOR_GREY, !"Данная команда доступна лидерам организаций");
						if(!IsPlayerLogged{playerid}) return 1;

						mysql_string[0] = EOS, mf(mysql, mysql_string, 50, "SELECT * FROM `group` WHERE `fraction` = '%d'", PI[playerid][pMember]);
						mysql_function_query(mysql, mysql_string, true, "EditGroup", "d", playerid);
      				}
      				case 1: callcmd::allmembers(playerid);
      				case 2: callcmd::bl(playerid);
      				case 3: ShowPlayerDialog(playerid, 8975, DIALOG_STYLE_LIST, "{ee3366}Автопарк организации", "1. Заспавнить весь транспорт организации", "Выбрать", "Назад");
      				case 4: ShowPlayerDialog(playerid, 7512, DIALOG_STYLE_INPUT, "{ee3366}Принять в организацию", "{FFFFFF}Введите ID игрока:", "Принять", "Отмена");
      				case 5: ShowPlayerDialog(playerid, 7502, DIALOG_STYLE_INPUT, "{ee3366}Уволить из организации", "{FFFFFF}Введите ID игрока и причину через запятую в поле ниже\nПример: 5,НВЗ", "Уволить", "Отмена");
      				case 6: ShowPlayerDialog(playerid, 7504, DIALOG_STYLE_INPUT, "{ee3366}Уволить из организации оффлайн", "{FFFFFF}Введите имя игрока в поле ниже\n{d7d394}Например: Ivan_Zolo", "Уволить", "Отмена");
      				case 7: ShowPlayerDialog(playerid, 7505, DIALOG_STYLE_INPUT, "{ee3366}Выдать выговор", "{FFFFFF}Введите ID игрока и причину через запятую в поле ниже\n{d7d394}Например: 32, Н.В.З.", "Выдать", "Отмена");
      				case 8: ShowPlayerDialog(playerid, 7506, DIALOG_STYLE_INPUT, "{ee3366}Выдать выговор в оффлайн", "{FFFFFF}Введите имя игрока в поле ниже\n{d7d394}Например: Ivan_Zolo", "Выдать", "Отмена");
      				case 9: ShowPlayerDialog(playerid, 7507, DIALOG_STYLE_INPUT, "{ee3366}Снять выговор", "{FFFFFF}Введите ID игрока и причину через запятую в поле ниже\nПример: 5,Ошибка", "Снять", "Отмена");
      				case 10: ShowPlayerDialog(playerid, 7508, DIALOG_STYLE_INPUT, "{ee3366}Снять выговор в оффлайн", "{FFFFFF}Введите имя игрока в поле ниже\nПример: Ivan_Bober", "Снять", "Отмена");
      				case 11: ShowPlayerDialog(playerid, 7510, DIALOG_STYLE_INPUT, "{ee3366}Изменить внешность", "{FFFFFF}Введите ID игрока:", "Изменить", "Отмена");
      				case 12: ShowPlayerDialog(playerid, 7511, DIALOG_STYLE_INPUT, "{ee3366}Изменить группу", "{FFFFFF}Введите ID игрока:", "Изменить", "Отмена");
			  		case 13: ShowPlayerDialog(playerid, 7503, DIALOG_STYLE_MSGBOX, !"{ee3366}Расформировать организацию", "{FFFFFF}Вы подтверждаете расормирование организации?\nДействие нельзя будет отменить.", "Продолжить", "Отмена");
			    }
			}
      	}
		case 8975:
		{
		    if(!response) return callcmd::lmenu(playerid);
		    if(GetPVarInt(playerid,"SpawnCar") > gettime()) return SCM(playerid, COLOR_GREY, !"Респавнить транспорт организации можно раз в 15 секунд ");
   	        switch(listitem) {
   	            case 0:
				{
		   			if(response) if(PI[playerid][pMember] == 5)
					{
				 		DestroyVehicle(skinhead_car[1]);
				 		skinhead_car[1] = CreateVehicle(404, -120.1114,628.1298,-50.3746,0.0683, 1, 1, -1);
					   	SetVehicleVirtualWorld(skinhead_car[1], GARAGE_INT_SKINHEAD);
					    LinkVehicleToInterior(skinhead_car[1], 1);
		  		 		DestroyVehicle(skinhead_car[2]);
				 		skinhead_car[2] = CreateVehicle(492, -128.7444,628.2188,-50.3748,359.2198, 1, 1, -1);
					   	SetVehicleVirtualWorld(skinhead_car[2], GARAGE_INT_SKINHEAD);
					    LinkVehicleToInterior(skinhead_car[2], 1);
		  		 		DestroyVehicle(skinhead_car[3]);
				 		skinhead_car[3] = CreateVehicle(504, -136.2352,628.0240,-50.3748,0.9594, 1, 1, -1);
					   	SetVehicleVirtualWorld(skinhead_car[3], GARAGE_INT_SKINHEAD);
					    LinkVehicleToInterior(skinhead_car[3], 1);
		  		 		DestroyVehicle(skinhead_car[4]);
				 		skinhead_car[4] = CreateVehicle(418, -148.8755,628.7747,-50.3747,0.1094, 1, 1, -1);
					   	SetVehicleVirtualWorld(skinhead_car[4], GARAGE_INT_SKINHEAD);
					    LinkVehicleToInterior(skinhead_car[4], 1);
		  		 		DestroyVehicle(skinhead_car[5]);
				 		skinhead_car[5] = CreateVehicle(422, -120.1441,653.5405,-50.3746,179.6092, 1, 1, -1);
					   	SetVehicleVirtualWorld(skinhead_car[5], GARAGE_INT_SKINHEAD);
					    LinkVehicleToInterior(skinhead_car[5], 1);
		  		 		DestroyVehicle(skinhead_car[6]);
				 		skinhead_car[6] = CreateVehicle(475, -128.5931,653.5984,-50.3746,179.5707, 1, 1, -1);
					   	SetVehicleVirtualWorld(skinhead_car[6], GARAGE_INT_SKINHEAD);
					    LinkVehicleToInterior(skinhead_car[6], 1);
		  		 		DestroyVehicle(skinhead_car[7]);
				 		skinhead_car[7] = CreateVehicle(400, -136.2937,653.7285,-50.3743,180.1815, 1, 1, -1);
					   	SetVehicleVirtualWorld(skinhead_car[7], GARAGE_INT_SKINHEAD);
					    LinkVehicleToInterior(skinhead_car[7], 1);
					    SetPVarInt(playerid,"SpawnCar",gettime() + 25);
					}
		   			if(response) if(PI[playerid][pMember] == 1)
					{
				 		DestroyVehicle(gov_car[1]);
				 		gov_car[1] = CreateVehicle(551, -152.6144,628.7219,-50.1706,356.2022, 0, 0, -1);
					   	SetVehicleVirtualWorld(gov_car[1], GARAGE_INT_MERIYA);
					    LinkVehicleToInterior(gov_car[1], 1);
		  		 		DestroyVehicle(gov_car[2]);
				 		gov_car[2] = CreateVehicle(494, -148.8862,628.6601,-50.1706,357.1905, 1, 1, -1);
					   	SetVehicleVirtualWorld(gov_car[2], GARAGE_INT_MERIYA);
					    LinkVehicleToInterior(gov_car[2], 1);
		  		 		DestroyVehicle(gov_car[3]);
				 		gov_car[3] = CreateVehicle(494, -140.8531,629.0610,-50.1706,355.4791, 1, 1, -1);
					   	SetVehicleVirtualWorld(gov_car[3], GARAGE_INT_MERIYA);
					    LinkVehicleToInterior(gov_car[3], 1);
		  		 		DestroyVehicle(gov_car[4]);
				 		gov_car[4] = CreateVehicle(418, -136.9894,629.2422,-50.1706,358.5539, 1, 1, -1);
					   	SetVehicleVirtualWorld(gov_car[4], GARAGE_INT_MERIYA);
					    LinkVehicleToInterior(gov_car[4], 1);
		  		 		DestroyVehicle(gov_car[5]);
				 		gov_car[5] = CreateVehicle(418, -129.2403,628.5641,-50.1706,359.4196, 1, 1, -1);
					   	SetVehicleVirtualWorld(gov_car[5], GARAGE_INT_MERIYA);
					    LinkVehicleToInterior(gov_car[5], 1);
		  		 		DestroyVehicle(gov_car[6]);
				 		gov_car[6] = CreateVehicle(479, -128.5097,653.4676,-50.1706,181.3475, 1, 1, -1);
					   	SetVehicleVirtualWorld(gov_car[6], GARAGE_INT_MERIYA);
					    LinkVehicleToInterior(gov_car[6], 1);
		  		 		DestroyVehicle(gov_car[7]);
				 		gov_car[7] = CreateVehicle(480, -135.6245,653.2039,-50.1706,176.8134, 1, 1, -1);
					   	SetVehicleVirtualWorld(gov_car[7], GARAGE_INT_MERIYA);
					    LinkVehicleToInterior(gov_car[7], 1);
					    SetPVarInt(playerid,"SpawnCar",gettime() + 15);
					}
		   			if(response) if(PI[playerid][pMember] == 3)
					{
		                DestroyVehicle(police_car[1]);
		                police_car[1] = CreateVehicle(599, -152.6144,628.7219,-50.1706,356.2022, 1, 1, -1);
		                SetVehicleVirtualWorld(police_car[1], GARAGE_INT_MVD);
		                LinkVehicleToInterior(police_car[1], 1);
		                DestroyVehicle(police_car[2]);
		                police_car[2] = CreateVehicle(596, -148.8862,628.6601,-50.1706,357.1905, 1, 1, -1);
		                SetVehicleVirtualWorld(police_car[2], GARAGE_INT_MVD);
		                LinkVehicleToInterior(police_car[2], 1);
		                DestroyVehicle(police_car[3]);
		                police_car[3] = CreateVehicle(597, -140.8531,629.0610,-50.1706,355.4791, 1, 1, -1);
		                SetVehicleVirtualWorld(police_car[3], GARAGE_INT_MVD);
		                LinkVehicleToInterior(police_car[3], 1);
		                DestroyVehicle(police_car[4]);
		                police_car[4] = CreateVehicle(597, -136.9894,629.2422,-50.1706,358.5539, 1, 1, -1);
		                SetVehicleVirtualWorld(police_car[4], GARAGE_INT_MVD);
		                LinkVehicleToInterior(police_car[4], 1);
		                DestroyVehicle(police_car[5]);
		                police_car[5] = CreateVehicle(598, -129.2403,628.5641,-50.1706,359.4196, 1, 1, -1);
		                SetVehicleVirtualWorld(police_car[5], GARAGE_INT_MVD);
		                LinkVehicleToInterior(police_car[5], 1);
		                DestroyVehicle(police_car[6]);
		                police_car[6] = CreateVehicle(598, -128.5097,653.4676,-50.1706,181.3475, 1, 1, -1);
		                SetVehicleVirtualWorld(police_car[6], GARAGE_INT_MVD);
		                LinkVehicleToInterior(police_car[6], 1);
		                DestroyVehicle(police_car[7]);
		                police_car[7] = CreateVehicle(598, -135.6245,653.2039,-50.1706,176.8134, 1, 1, -1);
		                SetVehicleVirtualWorld(police_car[7], GARAGE_INT_MVD);
		                LinkVehicleToInterior(police_car[7], 1);
		                SetPVarInt(playerid,"SpawnCar",gettime() + 15);
					}
					if(response) if(PI[playerid][pMember] == 4)
					{
					    DestroyVehicle(hospital_car[1]);
					    hospital_car[1] = CreateVehicle(416, -152.6144,628.7219,-50.1706,356.2022, 1, 1, -1);
		       			SetVehicleVirtualWorld(hospital_car[1], GARAGE_INT_CRB);
		                LinkVehicleToInterior(hospital_car[1], 1);
		                DestroyVehicle(hospital_car[2]);
					    hospital_car[2] = CreateVehicle(416, -148.8862,628.6601,-50.1706,357.1905, 1, 1, -1);
		       			SetVehicleVirtualWorld(hospital_car[2], GARAGE_INT_CRB);
		                LinkVehicleToInterior(hospital_car[2], 1);
		                DestroyVehicle(hospital_car[3]);
					    hospital_car[3] = CreateVehicle(416, -140.8531,629.0610,-50.1706,355.4791, 1, 1, -1);
		       			SetVehicleVirtualWorld(hospital_car[3], GARAGE_INT_CRB);
		                LinkVehicleToInterior(hospital_car[3], 1);
		                DestroyVehicle(hospital_car[4]);
					    hospital_car[4] = CreateVehicle(416, -136.9894,629.2422,-50.1706,358.5539, 1, 1, -1);
		       			SetVehicleVirtualWorld(hospital_car[4], GARAGE_INT_CRB);
		                LinkVehicleToInterior(hospital_car[4], 1);
		                DestroyVehicle(hospital_car[5]);
					    hospital_car[5] = CreateVehicle(416, -129.2403,628.5641,-50.1706,359.4196, 1, 1, -1);
		       			SetVehicleVirtualWorld(hospital_car[5], GARAGE_INT_CRB);
		                LinkVehicleToInterior(hospital_car[5], 1);
		                DestroyVehicle(hospital_car[6]);
					    hospital_car[6] = CreateVehicle(551, -128.5097,653.4676,-50.1706,181.3475, 1, 1, -1);
		       			SetVehicleVirtualWorld(hospital_car[6], GARAGE_INT_CRB);
		                LinkVehicleToInterior(hospital_car[6], 1);
		                DestroyVehicle(hospital_car[7]);
					    hospital_car[7] = CreateVehicle(551, -135.6245,653.2039,-50.1706,176.8134, 1, 1, -1);
		       			SetVehicleVirtualWorld(hospital_car[7], GARAGE_INT_CRB);
		                LinkVehicleToInterior(hospital_car[7], 1);
		                SetPVarInt(playerid,"SpawnCar",gettime() + 15);
					}
					if(response) if(PI[playerid][pMember] == 6)
					{
						DestroyVehicle(gopota_car[1]);
						gopota_car[1] = CreateVehicle(404, -120.1114,628.1298,-50.3746,0.0683, 24, 24, -1);
						SetVehicleVirtualWorld(gopota_car[1], GARAGE_INT_GOPOTA);
						LinkVehicleToInterior(gopota_car[1], 1);
						DestroyVehicle(gopota_car[2]);
						gopota_car[2] = CreateVehicle(492, -128.7444,628.2188,-50.3748,359.2198, 24, 24, -1);
						SetVehicleVirtualWorld(gopota_car[2], GARAGE_INT_GOPOTA);
						LinkVehicleToInterior(gopota_car[2], 1);
						DestroyVehicle(gopota_car[3]);
						gopota_car[3] = CreateVehicle(504, -136.2352,628.0240,-50.3748,0.9594, 24, 24, -1);
						SetVehicleVirtualWorld(gopota_car[3], GARAGE_INT_GOPOTA);
						LinkVehicleToInterior(gopota_car[3], 1);
						DestroyVehicle(gopota_car[4]);
						gopota_car[4] = CreateVehicle(418, -148.8755,628.7747,-50.3747,0.1094, 24, 24, -1);
						SetVehicleVirtualWorld(gopota_car[4], GARAGE_INT_GOPOTA);
						LinkVehicleToInterior(gopota_car[4], 1);
						DestroyVehicle(gopota_car[5]);
						gopota_car[5] = CreateVehicle(422, -120.1441,653.5405,-50.3746,179.6092, 24, 24, -1);
						SetVehicleVirtualWorld(gopota_car[5], GARAGE_INT_GOPOTA);
						LinkVehicleToInterior(gopota_car[5], 1);
						DestroyVehicle(gopota_car[6]);
						gopota_car[6] = CreateVehicle(475, -128.5931,653.5984,-50.3746,179.5707, 24, 24, -1);
						SetVehicleVirtualWorld(gopota_car[6], GARAGE_INT_GOPOTA);
						LinkVehicleToInterior(gopota_car[6], 1);
						DestroyVehicle(gopota_car[7]);
						gopota_car[7] = CreateVehicle(400, -136.2937,653.7285,-50.3743,180.1815, 24, 24, -1);
						SetVehicleVirtualWorld(gopota_car[7], GARAGE_INT_GOPOTA);
						LinkVehicleToInterior(gopota_car[7], 1);
						SetPVarInt(playerid,"SpawnCar",gettime() + 15);
					}
					if(response) if(PI[playerid][pMember] == 7)
					{
		                DestroyVehicle(kavkaz_car[1]);
		                kavkaz_car[1] = CreateVehicle(404, -120.1114,628.1298,-50.3746,0.0683, 0, 0, -1);
		                SetVehicleVirtualWorld(kavkaz_car[1], GARAGE_INT_OFFCLUB);
		                LinkVehicleToInterior(kavkaz_car[1], 1);
		                DestroyVehicle(kavkaz_car[2]);
		                kavkaz_car[2] = CreateVehicle(492, -128.7444,628.2188,-50.3748,359.2198, 0, 0, -1);
		                SetVehicleVirtualWorld(kavkaz_car[2], GARAGE_INT_OFFCLUB);
		                LinkVehicleToInterior(kavkaz_car[2], 1);
		                DestroyVehicle(kavkaz_car[3]);
		                kavkaz_car[3] = CreateVehicle(504, -136.2352,628.0240,-50.3748,0.9594, 0, 0, -1);
		                SetVehicleVirtualWorld(kavkaz_car[3], GARAGE_INT_OFFCLUB);
		                LinkVehicleToInterior(kavkaz_car[3], 1);
		                DestroyVehicle(kavkaz_car[4]);
		                kavkaz_car[4] = CreateVehicle(418, -148.8755,628.7747,-50.3747,0.1094, 0, 0, -1);
		                SetVehicleVirtualWorld(kavkaz_car[4], GARAGE_INT_OFFCLUB);
		                LinkVehicleToInterior(kavkaz_car[4], 1);
		                DestroyVehicle(kavkaz_car[5]);
		                kavkaz_car[5] = CreateVehicle(422, -120.1441,653.5405,-50.3746,179.6092, 0, 0, -1);
		                SetVehicleVirtualWorld(kavkaz_car[5], GARAGE_INT_OFFCLUB);
		                LinkVehicleToInterior(kavkaz_car[5], 1);
		                DestroyVehicle(kavkaz_car[6]);
		                kavkaz_car[6] = CreateVehicle(475, -128.5931,653.5984,-50.3746,179.5707, 0, 0, -1);
		                SetVehicleVirtualWorld(kavkaz_car[6], GARAGE_INT_OFFCLUB);
		                LinkVehicleToInterior(kavkaz_car[6], 1);
		                DestroyVehicle(kavkaz_car[7]);
		                kavkaz_car[7] = CreateVehicle(400, -136.2937,653.7285,-50.3743,180.1815, 0, 0, -1);
		                SetVehicleVirtualWorld(kavkaz_car[7], GARAGE_INT_OFFCLUB);
		                LinkVehicleToInterior(kavkaz_car[7], 1);
		                SetPVarInt(playerid,"SpawnCar",gettime() + 15);
					}
					if(response) if(PI[playerid][pMember] == 2)
					{
					    DestroyVehicle(army_car[0]);
		                army_car[0] = CreateVehicle(433, 1820.8024,1669.9033,15.9475,358.8507, 1, 1, -1);
		                SetVehicleVirtualWorld(army_car[0], GARAGE_INT_VCH);
		                LinkVehicleToInterior(army_car[0], 1);
		                DestroyVehicle(army_car[1]);
		                army_car[1] = CreateVehicle(599, -152.6144,628.7219,-50.1706,356.2022, 1, 1, -1);
		                SetVehicleVirtualWorld(army_car[1], GARAGE_INT_VCH);
		                LinkVehicleToInterior(army_car[1], 1);
		                DestroyVehicle(army_car[2]);
		                army_car[2] = CreateVehicle(597, -148.8862,628.6601,-50.1706,357.1905, 1, 1, -1);
		                SetVehicleVirtualWorld(army_car[2], GARAGE_INT_VCH);
		                LinkVehicleToInterior(army_car[2], 1);
		                DestroyVehicle(army_car[3]);
		                army_car[3] = CreateVehicle(597, -140.8531,629.0610,-50.1706,355.4791, 1, 1, -1);
		                SetVehicleVirtualWorld(army_car[3], GARAGE_INT_VCH);
		                LinkVehicleToInterior(army_car[3], 1);
		                DestroyVehicle(army_car[4]);
		                army_car[4] = CreateVehicle(598, -136.9894,629.2422,-50.1706,358.5539, 1, 1, -1);
		                SetVehicleVirtualWorld(army_car[4], GARAGE_INT_VCH);
		                LinkVehicleToInterior(army_car[4], 1);
		                DestroyVehicle(army_car[5]);
		                army_car[5] = CreateVehicle(598, -129.2403,628.5641,-50.1706,359.4196, 1, 1, -1);
		                SetVehicleVirtualWorld(army_car[5], GARAGE_INT_VCH);
		                LinkVehicleToInterior(army_car[5], 1);
		                DestroyVehicle(army_car[6]);
		                army_car[6] = CreateVehicle(598, -128.5097,653.4676,-50.1706,181.3475, 1, 1, -1);
		                SetVehicleVirtualWorld(army_car[6], GARAGE_INT_VCH);
		                LinkVehicleToInterior(army_car[6], 1);
		                DestroyVehicle(army_car[7]);
		                army_car[7] = CreateVehicle(598, -135.6245,653.2039,-50.1706,176.8134, 1, 1, -1);
		                SetVehicleVirtualWorld(army_car[7], GARAGE_INT_VCH);
		                LinkVehicleToInterior(army_car[7], 1);
		                DestroyVehicle(army_car[8]);
		                army_car[8] = CreateVehicle(601, 1816.5143,1669.4126,15.0190,0.9330, 1, 1, -1);
		                SetVehicleVirtualWorld(army_car[8], GARAGE_INT_VCH);
		                LinkVehicleToInterior(army_car[8], 1);
		                SetPVarInt(playerid,"SpawnCar",gettime() + 15);
					}
					return SCM(playerid, COLOR_GREY, !"Вы успешно зареспавнили весь транспорт организации");
				}
			}
		}
		case 7512:
		{
		    if(!response) return 1;
			if(response) {
				if(strval(inputtext) == playerid) return SCM(playerid, COLOR_GREY, !"Нельзя использовать на самом себе");
				SetPVarInt(playerid, "Invite", strval(inputtext));

				mysql_string[0] = EOS, mf(mysql, mysql_string, 108, "SELECT * FROM `fractions_blacklist` WHERE bl_name = '%e' AND bl_fraction = '%d'", PI[strval(inputtext)][pName], PI[playerid][pMember]);
				mysql_function_query(mysql, mysql_string, true, "CheckBlackListInvite", "d", playerid);
			}
		}
		case 7511: 
		{
		    if(!response) return 1;
			if(response) callcmd::setgroup(playerid,inputtext);
		}
		case 7510: 
		{
		    if(!response) return 1;
			if(response) callcmd::setskin(playerid,inputtext);
		}
		case 7509: 
		{
		    if(!response) return 1;
			if(response) {
				new id, reason[25] ;
				if(sscanf(inputtext, "p<,>ds[26]", id, reason)) return callcmd::lmenu(playerid);
				new str[144];
				format(str, sizeof(str), "%d %s", id, reason);
				callcmd::setrang(playerid,str);
			}
		}
		case 7508: 
		{
		    if(!response) return 1;
			if(response) callcmd::offuntwarn(playerid,inputtext);
		}
		case 7507:
		{
		    if(!response) return 1;
			if(response)
			{
				new id, reason[25] ;
				if(sscanf(inputtext, "p<,>ds[26]", id, reason)) return callcmd::lmenu(playerid);
				new str[144];
				format(str, sizeof(str), "%d %s", id, reason);
				callcmd::untwarn(playerid,str);
				return 1;
			}
		}
		case 7506:
		{
		    if(!response) return 1;
			if(response) callcmd::offtwarn(playerid,inputtext);
		}
		case 7504:
		{
		    if(!response) return 1;
			if(response) callcmd::uninviteoff(playerid,inputtext);
		}
		case 7502:
		{
		    if(!response) return 1;
			if(response)
			{
				new
					id,
					reason[25]
				;
				if(sscanf(inputtext, "p<,>ds[26]", id, reason)) {
					return callcmd::lmenu(playerid);
				}
				new str[144];
				format(str, sizeof(str),
					"%d %s",
					id,
					reason
				);
				callcmd::uninvite(playerid,str);
				return 1;
			}
		}
		case 7505: 
		{
		    if(!response) return 1;
			if(response) 
			{
				new id, reason[25];
				if(sscanf(inputtext, "p<,>ds[26]", id, reason)) return callcmd::lmenu(playerid);
				new str[144];
				format(str, sizeof(str), "%d %s", id, reason);
				callcmd::twarn(playerid,str);
				return 1;
			}
		}
		case 7503: {
		    if(!response) return 1;
			if(response) if(PI[playerid][pAdmin] < 4) return 1;
		}
		case 7214:
		{
		    if(!response) return 1;
			if(response)
			{
				SendFractionMessagef(PI[playerid][pMember], COLOR_TOMATO, "[R] %s %s покинул организацию по собственному желанию", NameRang(playerid), PI[playerid][pName]);
				SCMf(playerid, COLOR_TOMATO, "Вы покинули организацию '%s' по собственному желанию", Fraction_Name[PI[playerid][pMember]]);
				
				cef_emit_event(playerid, "cef:capture:visible", CEFINT(false));
				for(new g; g <= totalgz; g++) GangZoneHideForPlayer(playerid, g);
				GangZoneStopFlashForPlayer(playerid, WarZone);
				ClearGroup(playerid);

				new year, month, day ;
				getdate(year, month, day);

				mysql_string[0] = EOS, mf(mysql, mysql_string, 265, "INSERT INTO `wbook`(`w_player`,`w_fraction`,`w_name`,`w_reason`,`w_rank`,`w_day`,`w_mes`,`w_year`) VALUES ('%d','%d','%s','Собственное желание','%d','%d','%d','%d')", PI[playerid][pID], PI[playerid][pMember], PI[playerid][pName], PI[playerid][pRang], day, month, year);
				mysql_function_query(mysql, mysql_string, false, "", "");

				PI[playerid][pMember] = 0;
				PI[playerid][pRang] = 0;
				PI[playerid][pLeader] = 0;
				PI[playerid][pProgressMetall] = 0;
	            PI[playerid][pProgressDrugs] = 0;
	            PI[playerid][pProgressAmmo] = 0;
	            PI[playerid][pProgressCarGrabber] = 0;
	            PI[playerid][pProgressSellGun] = 0;
	            PI[playerid][pProgressCapture] = 0;
	            PI[playerid][pCaptureManager] = 0;
				SetPlayerSkinAC(playerid,PI[playerid][pSkin]);
				SetPlayerColorEx(playerid);
				if(PI[playerid][pMember] == 2 && PI[playerid][pRang] <= 3 && PI[playerid][pMilitaryID] == 0) 
				{
					SCM(playerid, COLOR_HINT, "[Подсказка]: {FFFFFF}Вы отслужили в армии и получили военный билет");
					PI[playerid][pMilitaryID] = 1;
				}
				if(IsPlayerInAnyVehicle(playerid) && GetPlayerState(playerid) == PLAYER_STATE_DRIVER) 
				{
					new Float:x, Float:y, Float:z;
					GetPlayerPos(playerid,x,y,z);
					SetPlayerPosAC(playerid,x,y,z+2);
				}
			}
		}
		case dialog_ABACK: {
		    if(!response) return 1;
		    if(response) callcmd::ahelp(playerid);
		}
		case dialog_DISCONNECT: {
		    if(!response) return Kick(playerid);
		    if(response) return Kick(playerid);
		}
		case 3513: 
		{
		    if(!response) return 1;
		    if(response) 
			{
		        switch(listitem) 
				{
		            case 0: 
					{
					    if(PI[playerid][pMember] == 0) return SCM(playerid, COLOR_GREY, !"Вы не состоите во организации");
                        PI[playerid][data_SPAWN] = 1;
					    SCM(playerid, COLOR_YELLOW, !"Место спавна изменено");
					}
		            case 1: 
					{
					    PI[playerid][data_SPAWN] = 0;
					    SCM(playerid, COLOR_YELLOW, !"Место спавна изменено");
					}
		            case 2: 
					{
					    if(PI[playerid][pHouse] == INVALID_HOUSE_ID && PI[playerid][pFloat] == INVALID_KV_ID) return SCM(playerid, COLOR_GREY, !"У Вас нет дома или квартиры");
                        PI[playerid][data_SPAWN] = 2;
					    SCM(playerid, COLOR_YELLOW, !"Место спавна изменено");
					}
		        }
		    }
		}
	}
	return 1;
}
public OnPlayerClickPlayer(playerid, clickedplayerid, source) return 1;
public OnPlayerSpawn(playerid)
{

	if(!IsPlayerLogged{playerid} && GetPVarInt(playerid, "ChoosingSkin") == 1) 
	{
		ChoosingSkin(playerid);
	}
	else if(!IsPlayerLogged{playerid}) return Kick(playerid);

	new hour, minute;
	gettime(hour, minute, _);
	SetPlayerTime(playerid, hour, minute);
	StopAudioStreamForPlayer(playerid);
    Streamer_VisibleItems(STREAMER_TYPE_OBJECT, 1000);

	SetPlayerSkills(playerid);
    SetPlayerHealthAC(playerid, PI[playerid][pHealthPoints]);

	SetPlayerWantedLevel(playerid, PI[playerid][pWanted]);

	TogglePlayerControllable(playerid, true);

	PI[playerid][pStartJob] = 0;
    PI[playerid][data_PUTPATR] = 0;
    PI[playerid][data_PUTMET] = 0;
	shield[playerid] = false;
    DisablePlayerCheckpoint(playerid);
    DisablePlayerRaceCheckpoint(playerid);
	PlayerHideTextDraws(playerid);
	if(PI[playerid][pDeathOnCapture] == 0)
	{
		for(new i = 0; i < 13; i++) 
		{
			if(PI[playerid][data_GUN][i] != 0 && PI[playerid][data_AMMO][i] != 0) return GivePlayerWeapon(playerid, PI[playerid][data_GUN][i], PI[playerid][data_AMMO][i]);
		}
	}
	SettingSpawn(playerid);
	SetAccessory(playerid);
	return true;
}
alias:donate("donat", "adon", "don");
cmd:donate(playerid) 
{
	mysql_string[0] = EOS, mf(mysql, mysql_string, 68, "SELECT * FROM `accounts` WHERE `Name` = '%e'",PI[playerid][pName]);
    mysql_function_query(mysql, mysql_string, true, "LoadDonate", "i", playerid);
}
callback: LoadDonate(playerid) 
{
    new rows, fields, temp[20];
    cache_get_data(rows, fields);
    if(rows) 
	{
        cache_get_field_content(0, "Donate", temp), PI[playerid][pDonate] = strval (temp);
		ShowPlayerDialog(playerid, dialog_DONATE, DIALOG_STYLE_LIST, "{ee3366}Дополнительные услуги", "\
		{FFFF99}Информация\n\
		{FFFF99}Последние 10 операций\n\
		Конвертирование донат-поинтов в рубли \t{66ccff}(от 1 дп.)\n\
		Покупка всех навыков стрельбы \t\t{66ccff}(100 дп)\n\
		Снятие предупреждений \t\t\t{66ccff}(60 дп)\n\
		Изменение имени \t\t\t\t{66ccff}(100 дп)\n\
		Подписка {FFA500}"NAMEVIP"\t\t\t{66ccff}(200 дп/мес.)\n\
		Покупка военного билета\t\t\t{66ccff}(129 дп)\n\
		Покупка законопослушности (+10)\t\t{66ccff}(19 дп)\n\
		Покупка 4-x значного номера телефона\t{66ccff}(150 дп)\n\
		Покупка аксессуара\t\t\t\t{66ccff}(от 10 дп)", "Далее", "Закрыть");
    }
    return 1;
}
callback: LoadHouses() 
{
    new rows, fields, temp[256], time = GetTickCount();
    cache_get_data(rows, fields);
	LoadedHouse = cache_get_row_count(mysql);
    if(rows) 
	{
    	for(new h = 0; h < rows; h++) 
		{
	        cache_get_field_content(h, "id", temp), HOUSE_DATA[h][data_ID] = strval (temp);
	        cache_get_field_content(h, "owner", HOUSE_DATA[h][data_OWNER], mysql, MAX_PLAYER_NAME);
	        cache_get_field_content(h, "enterx", temp), HOUSE_DATA[h][data_ENTERX] = floatstr (temp);
	        cache_get_field_content(h, "entery", temp), HOUSE_DATA[h][data_ENTERY] = floatstr (temp);
	        cache_get_field_content(h, "enterz", temp), HOUSE_DATA[h][data_ENTERZ] = floatstr (temp);
	        cache_get_field_content(h, "exitx", temp), HOUSE_DATA[h][data_EXITX] = floatstr (temp);
	        cache_get_field_content(h, "exity", temp), HOUSE_DATA[h][data_EXITY] = floatstr (temp);
	        cache_get_field_content(h, "exitz", temp), HOUSE_DATA[h][data_EXITZ] = floatstr (temp);
	        cache_get_field_content(h, "carx", temp), HOUSE_DATA[h][data_CARX] = floatstr (temp);
	        cache_get_field_content(h, "cary", temp), HOUSE_DATA[h][data_CARY] = floatstr (temp);
	        cache_get_field_content(h, "carz", temp), HOUSE_DATA[h][data_CARZ] = floatstr (temp);
	        cache_get_field_content(h, "cara", temp), HOUSE_DATA[h][data_CARANGLE] = floatstr (temp);
	        cache_get_field_content(h, "class", temp), HOUSE_DATA[h][data_CLASS] = strval (temp);
	        cache_get_field_content(h, "owned", temp), HOUSE_DATA[h][data_OWNED] = strval (temp);
	        cache_get_field_content(h, "price", temp), HOUSE_DATA[h][data_PRICE] = strval (temp);
	        cache_get_field_content(h, "day", temp), HOUSE_DATA[h][data_DAY] = strval (temp);
	        cache_get_field_content(h, "lock", temp), HOUSE_DATA[h][data_LOCK] = strval (temp);
         	TotalHouses++;
         	if(HOUSE_DATA[h][data_OWNED] == 0) {
         	    HOUSE_DATA[h][data_PICKUPENTER] = CreateDynamicPickup(1273, 23, HOUSE_DATA[h][data_ENTERX], HOUSE_DATA[h][data_ENTERY], HOUSE_DATA[h][data_ENTERZ],-1);
				HOUSE_DATA[h][data_MAPICON] = CreateDynamicMapIcon(HOUSE_DATA[h][data_ENTERX], HOUSE_DATA[h][data_ENTERY], HOUSE_DATA[h][data_ENTERZ], 31, -1, 0, -1, -1, 100.0);
         	}
         	else {
    	     	HOUSE_DATA[h][data_PICKUPENTER] = CreateDynamicPickup(1272, 23, HOUSE_DATA[h][data_ENTERX], HOUSE_DATA[h][data_ENTERY], HOUSE_DATA[h][data_ENTERZ],0);
                HOUSE_DATA[h][data_MAPICON] = CreateDynamicMapIcon(HOUSE_DATA[h][data_ENTERX], HOUSE_DATA[h][data_ENTERY], HOUSE_DATA[h][data_ENTERZ], 32, -1, 0, -1, -1, 100.0);
        	}
        }
        printf("[INFO]  Load houses. Load: %d h. Time: %d ms.",TotalHouses, GetTickCount()-time);
	}
    return 1;
}
callback: LoadGZ() 
{
    new rows, fields, temp[602];
    cache_get_data(rows, fields);
    if(!rows) return print("[MYSQL] Территории не найдены");
    if(rows) 
	{
        for(new g = 0; g < rows; g++) 
		{
            cache_get_field_content(g, "gzid", temp), gz_info[g][gzid] = strval (temp);
            cache_get_field_content(g, "gzminx", temp), gz_info[g][gzminx] = floatstr (temp);
            cache_get_field_content(g, "gzminy", temp), gz_info[g][gzminy] = floatstr (temp);
            cache_get_field_content(g, "gzmaxx", temp), gz_info[g][gzmaxx] = floatstr (temp);
            cache_get_field_content(g, "gzmaxy", temp), gz_info[g][gzmaxy] = floatstr (temp);
            cache_get_field_content(g, "gzopg", temp), gz_info[g][gzopg] = strval (temp);
			cache_get_field_content(g, "standart_team", temp), gz_info[g][standart_opg] = strval (temp);
            if(gz_info[g][gzid] != 101) GangZoneCreate(gz_info[g][gzminx], gz_info[g][gzminy], gz_info[g][gzmaxx], gz_info[g][gzmaxy]);
	        totalgz++;
        }
    }
    printf("%d территорий загружено", totalgz);
    return 1;
}
callback: LoadWarehouse()
{
	new rows, fields, temp[10],time = GetTickCount();
    cache_get_data(rows, fields);
    if(rows) 
	{
		cache_get_field_content(0, "rostov_metal", temp), skinhead_wh[0] = strval (temp);
		cache_get_field_content(0, "rostov_patr", temp), skinhead_wh[1] = strval (temp);
		cache_get_field_content(0, "rostov_narko", temp), skinhead_wh[2] = strval (temp);
		cache_get_field_content(0, "rostov_storage", temp), skinhead_wh[3] = strval (temp);
		cache_get_field_content(0, "gopota_metal", temp), gopota_wh[0] = strval (temp);
		cache_get_field_content(0, "gopota_patr", temp), gopota_wh[1] = strval (temp);
		cache_get_field_content(0, "gopota_narko", temp), gopota_wh[2] = strval (temp);
		cache_get_field_content(0, "gopota_storage", temp), gopota_wh[3] = strval (temp);
		cache_get_field_content(0, "kavkaz_metal", temp), kavkaz_wh[0] = strval (temp);
		cache_get_field_content(0, "kavkaz_patr", temp), kavkaz_wh[1] = strval (temp);
		cache_get_field_content(0, "kavkaz_narko", temp), kavkaz_wh[2] = strval (temp);
		cache_get_field_content(0, "kavkaz_storage", temp), kavkaz_wh[3] = strval (temp);
		cache_get_field_content(0, "smi_money", temp), smi_money = strval (temp);
		cache_get_field_content(0, "army_metal", temp), army_wh[0] = strval (temp);
		cache_get_field_content(0, "army_patr", temp), army_wh[1] = strval (temp);
		cache_get_field_content(0, "moroz_kavkaz", temp), m_kavkaz = strval (temp);
		cache_get_field_content(0, "moroz_gopota", temp), m_gopota = strval (temp);
		cache_get_field_content(0, "moroz_skinhead", temp), m_skinhead = strval (temp);
		//вч склад
		cache_get_field_content(0, "armystorage", temp), army_wh[2] = strval (temp);
		//склад шахты
		cache_get_field_content(0, "metall", temp), MineOreStock = strval (temp);
        cache_get_field_content(0, "coal", temp), MineCoalStock = strval (temp);
		//
		global_str[0] = EOS, f(global_str, 180, "{ff9933}Шахта\n\n\
                                        {FFFFFF}Металла на складе: {ffcc33}%d кг\n\
                                        {FFFFFF}Угля на складе: {cc6666}%d кг", MineOreStock, MineCoalStock);
        MineInfo = CreateDynamic3DTextLabel(global_str, -1, 2055.4192, 1649.4381, -45.3953, 10.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1, 1);
		//
		kavkaz_sklad = CreateDynamicPickup(1279, 23, -2131.1814,2390.8223,1501.8101, 1);
		gopota_sklad = CreateDynamicPickup(1279, 23, -2131.1814,2390.8223,1501.8101, 2);
		skinhead_sklad = CreateDynamicPickup(1279, 23, -2131.1814,2390.8223,1501.8101, 3);

		new gz1,gz2,gz3;
		for(new i = 0; i < totalgz; i++) 
		{
			if(gz_info[i][gzopg] == 5) gz1++;
			if(gz_info[i][gzopg] == 6) gz2++;
			if(gz_info[i][gzopg] == 7) gz3++;
		}
		switch(skinhead_wh[3]) 
		{
		    case 0: 
			{
				global_str[0] = EOS, f(global_str, 215, "Склад {ff6633}(закрыт)\n{cc6666}Скинхеды\n\
				{FFFFFF}Территорий: {e6d455}%d шт\n{FFFFFF}Металл: {e6d455}%d / 6000 шт.\n\
				{FFFFFF}Патроны: {e6d455}%d / 50000 шт.\n\
				{FFFFFF}Вещества: {e6d455}%d / 12000 шт.",gz1, skinhead_wh[0], skinhead_wh[1], skinhead_wh[2]);
  				skinhead_sklad_text = CreateDynamic3DTextLabel(global_str, -1, -2131.1814,2390.8223,1501.8101, 10.0,INVALID_PLAYER_ID,INVALID_VEHICLE_ID,3,3);
		    }
		    case 1: 
			{
				global_str[0] = EOS, f(global_str, 215, "Склад\n{cc6666}Скинхеды\n\
				{FFFFFF}Территорий: {e6d455}%d шт\n{FFFFFF}Металл: {e6d455}%d / 6000 шт.\n\
				{FFFFFF}Патроны: {e6d455}%d / 50000 шт.\n\
				{FFFFFF}Вещества: {e6d455}%d / 12000 шт.", gz1, skinhead_wh[0], skinhead_wh[1], skinhead_wh[2]);
				skinhead_sklad_text = CreateDynamic3DTextLabel(global_str, -1, -2131.1814,2390.8223,1501.8101, 10.0,INVALID_PLAYER_ID,INVALID_VEHICLE_ID,3,3);
		    }
		}
		switch(gopota_wh[3]) 
		{
		    case 0: 
			{
				global_str[0] = EOS, f(global_str, 215, "Склад {ff6633}(закрыт)\n{cc6666}Гопота\n\
				{FFFFFF}Территорий: {e6d455}%d шт\n{FFFFFF}Металл: {e6d455}%d / 6000 шт.\n\
				{FFFFFF}Патроны: {e6d455}%d / 50000 шт.\n\
				{FFFFFF}Вещества: {e6d455}%d / 12000 шт.", gz2, gopota_wh[0], gopota_wh[1], gopota_wh[2]);
				gopota_sklad_text = CreateDynamic3DTextLabel(global_str, -1, -2131.1814,2390.8223,1501.8101, 10.0,INVALID_PLAYER_ID,INVALID_VEHICLE_ID,2,2);
		    }
		    case 1: 
			{
				global_str[0] = EOS, f(global_str, 215, "Склад\n{cc6666}Гопота\n\
				{FFFFFF}Территорий: {e6d455}%d шт\n{FFFFFF}Металл: {e6d455}%d / 6000 шт.\n\
				{FFFFFF}Патроны: {e6d455}%d / 50000 шт.\n\
				{FFFFFF}Вещества: {e6d455}%d / 12000 шт.", gz2, gopota_wh[0], gopota_wh[1], gopota_wh[2]);
				gopota_sklad_text = CreateDynamic3DTextLabel(global_str, -1, -2131.1814,2390.8223,1501.8101, 10.0,INVALID_PLAYER_ID,INVALID_VEHICLE_ID,2,2);
		    }
		}
		switch(kavkaz_wh[3]) 
		{
		    case 0: 
			{
				global_str[0] = EOS, f(global_str, 215, "Склад {ff6633}(закрыт)\n{cc6666}Кавказцы\n\
				{FFFFFF}Территорий: {e6d455}%d шт\n{FFFFFF}Металл: {ffcc33}%d / 6000 шт.\n\
				{FFFFFF}Патроны: {ffcc33}%d / 50000 шт.\n\
				{FFFFFF}Вещества: {ffcc33}%d / 12000 шт.", gz3, kavkaz_wh[0], kavkaz_wh[1], kavkaz_wh[2]);
				kavkaz_sklad_text = CreateDynamic3DTextLabel(global_str, -1, -2131.1814,2390.8223,1501.8101, 10.0,INVALID_PLAYER_ID,INVALID_VEHICLE_ID,1,1);
		    }
		    case 1: 
			{
				global_str[0] = EOS, f(global_str, 215, "Склад\n{cc6666}Кавказцы\n\
				{FFFFFF}Территорий: {e6d455}%d шт\n{FFFFFF}Металл: {ffcc33}%d / 6000 шт.\n\
				{FFFFFF}Патроны: {ffcc33}%d / 50000 шт.\n\
				{FFFFFF}Вещества: {ffcc33}%d / 12000 шт.", gz3, kavkaz_wh[0], kavkaz_wh[1], kavkaz_wh[2]);
				kavkaz_sklad_text = CreateDynamic3DTextLabel(global_str, -1, -2131.1814,2390.8223,1501.8101, 10.0,INVALID_PLAYER_ID,INVALID_VEHICLE_ID,1,1);
		    }
		}
		global_str[0] = EOS, f(global_str, 100, "{f18c2b}Армейский склад\n{FFFFFF}Металл: %d кг.\n{fccf39}Патроны: %d шт.",army_wh[0], army_wh[1]);
		Update3DTextLabelText(army_sklad_text, -1, global_str);
		printf("[INFO]  Load warehouse. Time: %d ms.",GetTickCount()-time);
	}
	return 1;
}
callback: LoadPlayerData(playerid) 
{
	new rows, fields, temp[10], LoginIP[32];
    cache_get_data(rows, fields);
    if(rows) 
	{	
		cache_get_field_content(0, "id", temp), PI[playerid][pID] = strval (temp);
		cache_get_field_content(0, "uid", temp), PI[playerid][data_UID] = strval (temp);
		cache_get_field_content(0, "sex", temp), PI[playerid][pSex] = strval (temp);
		cache_get_field_content(0, "skin", temp), PI[playerid][pSkin] = strval (temp);
		cache_get_field_content(0, "skinm", temp), PI[playerid][pOrgSkin] = strval (temp);
		cache_get_field_content(0, "Money", temp), PI[playerid][pMoney] = strval (temp);
		cache_get_field_content(0, "VKNotif", temp), PI[playerid][pVKNotif] = strval (temp);
		cache_get_field_content(0, "AdminNumber", temp), PI[playerid][pAdminNumber] = strval (temp);
		cache_get_field_content(0, "Level", temp), PI[playerid][pLevel] = strval (temp);
		cache_get_field_content(0, "bangun", temp), PI[playerid][pWeaponLock] = strval (temp);
		cache_get_field_content(0, "GroupID", temp), PI[playerid][pGroupID] = strval (temp);
		cache_get_field_content(0, "exp", temp), PI[playerid][pExp] = strval (temp);
		cache_get_field_content(0, "member", temp), PI[playerid][pMember] = strval (temp);
		cache_get_field_content(0, "Leader", temp), PI[playerid][pLeader] = strval (temp);
		cache_get_field_content(0, "rank", temp), PI[playerid][pRang] = strval (temp);
		cache_get_field_content(0, "Admin", temp), PI[playerid][pAdmin] = strval (temp);
		cache_get_field_content(0, "RegIP", PI[playerid][pRegIP], mysql, 32);
		cache_get_field_content(0, "LoginIP", LoginIP, mysql, 32);
  		cache_get_field_content(0, "Email", PI[playerid][pEmail], mysql, 50);
		cache_get_field_content(0, "mute", temp), PI[playerid][pMute] = strval (temp);
		cache_get_field_content(0, "mutetime", temp), PI[playerid][pMuteTime] = strval (temp);
		cache_get_field_content(0, "vmute", temp), PI[playerid][pVmute] = strval (temp);
		cache_get_field_content(0, "vmutetime", temp), PI[playerid][pVmuteTime] = strval (temp);
		cache_get_field_content(0, "warn", temp), PI[playerid][pWarn] = strval (temp);
		cache_get_field_content(0, "warntime", temp), PI[playerid][pWarnTime] = strval (temp);
		cache_get_field_content(0, "salary", temp), PI[playerid][pPayDayMoney] = strval (temp);
		cache_get_field_content(0, "bank", temp), PI[playerid][pBank] = strval (temp);
		cache_get_field_content(0, "licb", temp), PI[playerid][pDriveLicense] = strval (temp);
		cache_get_field_content(0, "licg", temp), PI[playerid][pGunLicense] = strval (temp);
		cache_get_field_content(0, "licnum", temp), PI[playerid][pLicNumber] = strval (temp);
		cache_get_field_content(0, "business", temp), PI[playerid][pBusiness] = strval (temp);
		cache_get_field_content(0, "house", temp), PI[playerid][pHouse] = strval (temp);
		cache_get_field_content(0, "vip", temp), PI[playerid][pVIP] = strval (temp);
		cache_get_field_content(0, "time", temp), PI[playerid][data_TIME] = strval (temp);
		cache_get_field_content(0, "AdminStatus", temp), PI[playerid][pAdminStatus] = strval (temp);
		cache_get_field_content(0, "CaptureKills", temp), PI[playerid][pCaptureKills] = strval (temp);
		cache_get_field_content(0, "CaptureValue", temp), PI[playerid][pCaptureValue] = strval (temp);
		cache_get_field_content(0, "AdminReports", temp), PI[playerid][pAdminReports] = strval (temp);
		cache_get_field_content(0, "AdminEvents", temp), PI[playerid][pAdminEvents] = strval (temp);
		cache_get_field_content(0, "AdminWarn", temp), PI[playerid][pAdminWarn] = strval (temp);
		cache_get_field_content(0, "ModerWarn", temp), PI[playerid][pModerWarn] = strval (temp);
		cache_get_field_content(0, "RankUPTime", temp), PI[playerid][pRankUPTime] = strval (temp);
		cache_get_field_content(0, "patr", temp), PI[playerid][pAmmo] = strval (temp);
		cache_get_field_content(0, "drugs", temp), PI[playerid][pDrugs] = strval (temp);
		cache_get_field_content(0, "usedrugs", temp), PI[playerid][pUserDrugs] = strval (temp);
		cache_get_field_content(0, "met", temp), PI[playerid][pMetall] = strval (temp);
		cache_get_field_content(0, "wanted", temp), PI[playerid][pWanted] = strval (temp);
		cache_get_field_content(0, "Respect", temp), PI[playerid][pRespect] = strval (temp);
		cache_get_field_content(0, "number", temp), PI[playerid][pNumber] = strval (temp);
		cache_get_field_content(0, "number_m", temp), PI[playerid][pNumberMoney] = strval (temp);
		cache_get_field_content(0, "pstatus", temp), PI[playerid][pPhoneStatus] = strval (temp);
		cache_get_field_content(0, "jail", temp), PI[playerid][pJail] = strval (temp);
		cache_get_field_content(0, "jailtime", temp), PI[playerid][pJailTime] = strval (temp);
		cache_get_field_content(0, "demorgan", temp), PI[playerid][pDemorgan] = strval (temp);
		cache_get_field_content(0, "demorgan_time", temp), PI[playerid][pDemorganTime] = strval (temp);
		cache_get_field_content(0, "Donate", temp), PI[playerid][pDonate] = strval (temp);
		cache_get_field_content(0, "Moder", temp), PI[playerid][pModer] = strval (temp);
		cache_get_field_content(0, "Accessory_1", temp), PI[playerid][pAccessory_1] = strval (temp);
		cache_get_field_content(0, "Accessory_2", temp), PI[playerid][pAccessory_2] = strval (temp);
		cache_get_field_content(0, "Accessory_3", temp), PI[playerid][pAccessory_3] = strval (temp);
		cache_get_field_content(0, "Accessory_4", temp), PI[playerid][pAccessory_4] = strval (temp);
		cache_get_field_content(0, "Accessory_5", temp), PI[playerid][pAccessory_5] = strval (temp);
		cache_get_field_content(0, "Accessory_6", temp), PI[playerid][pAccessory_6] = strval (temp);
		cache_get_field_content(0, "Accessory_7", temp), PI[playerid][pAccessory_7] = strval (temp);
		cache_get_field_content(0, "Accessory_8", temp), PI[playerid][pAccessory_8] = strval (temp);
		cache_get_field_content(0, "Accessory_9", temp), PI[playerid][pAccessory_9] = strval (temp);
		cache_get_field_content(0, "Accessory_10", temp), PI[playerid][pAccessory_10] = strval (temp);
		cache_get_field_content(0, "TakeAcs", temp), PI[playerid][pTakeAcs] = strval (temp);
		cache_get_field_content(0, "UseAccessory", temp), PI[playerid][pUseAccessory] = strval (temp);
		cache_get_field_content(0, "phone", temp), PI[playerid][pPhone] = strval (temp);
		cache_get_field_content(0, "phonebook", temp), PI[playerid][pPhoneBook] = strval (temp);
		cache_get_field_content(0, "Satiety", temp), PI[playerid][pSatiety] = strval (temp);
		cache_get_field_content(0, "HealthPoints", temp), PI[playerid][pHealthPoints] = strval (temp);
		cache_get_field_content(0, "LeavePosX", temp), PI[playerid][pLeavePosX] = strval (temp);
		cache_get_field_content(0, "LeavePosY", temp), PI[playerid][pLeavePosY] = strval (temp);
		cache_get_field_content(0, "LeavePosZ", temp), PI[playerid][pLeavePosZ] = strval (temp);
		cache_get_field_content(0, "arm", temp), PI[playerid][pArmour] = strval (temp);
		cache_get_field_content(0, "med", temp), PI[playerid][data_MED] = strval (temp);
		cache_get_field_content(0, "mednum", temp), PI[playerid][data_MEDNUM] = strval (temp);
		cache_get_field_content(0, "spawn", temp), PI[playerid][data_SPAWN] = strval (temp);
		cache_get_field_content(0, "hospital", temp), PI[playerid][pHospital] = strval (temp);
		cache_get_field_content(0, "pistol_skill", temp), PI[playerid][pSkillPistol] = strval (temp);
		cache_get_field_content(0, "sdpistol_skill", temp), PI[playerid][pSkillSDPistol] = strval (temp);
		cache_get_field_content(0, "deagle_skill", temp), PI[playerid][pSkillDeagle] = strval (temp);
		cache_get_field_content(0, "shotgun_skill", temp), PI[playerid][pSkillShotgun] = strval (temp);
		cache_get_field_content(0, "mp5_skill", temp), PI[playerid][pSkillMP5] = strval (temp);
		cache_get_field_content(0, "ak47_skill", temp), PI[playerid][pSkillAK47] = strval (temp);
		cache_get_field_content(0, "rifle_skill", temp), PI[playerid][pSkillRifle] = strval (temp);
	    cache_get_field_content(0, "job", temp), PI[playerid][data_JOB] = strval (temp);
	    cache_get_field_content(0, "house", temp), PI[playerid][pHouse] = strval (temp);
	    cache_get_field_content(0, "business", temp), PI[playerid][pBusiness] = strval (temp);
	    cache_get_field_content(0, "kv", temp), PI[playerid][pFloat] = strval (temp);
	    cache_get_field_content(0, "padik", temp), PI[playerid][data_PADIK] = strval (temp);
	    cache_get_field_content(0, "gun0", temp), PI[playerid][data_GUN][0] = strval (temp);
		cache_get_field_content(0, "gun1", temp), PI[playerid][data_GUN][1] = strval (temp);
		cache_get_field_content(0, "gun2", temp), PI[playerid][data_GUN][2] = strval (temp);
		cache_get_field_content(0, "gun3", temp), PI[playerid][data_GUN][3] = strval (temp);
		cache_get_field_content(0, "gun4", temp), PI[playerid][data_GUN][4] = strval (temp);
		cache_get_field_content(0, "gun5", temp), PI[playerid][data_GUN][5] = strval (temp);
		cache_get_field_content(0, "gun6", temp), PI[playerid][data_GUN][6] = strval (temp);
		cache_get_field_content(0, "gun7", temp), PI[playerid][data_GUN][7] = strval (temp);
		cache_get_field_content(0, "gun8", temp), PI[playerid][data_GUN][8] = strval (temp);
		cache_get_field_content(0, "gun9", temp), PI[playerid][data_GUN][9] = strval (temp);
		cache_get_field_content(0, "gun10", temp), PI[playerid][data_GUN][10] = strval (temp);
		cache_get_field_content(0, "gun11", temp), PI[playerid][data_GUN][11] = strval (temp);
		cache_get_field_content(0, "gun12", temp), PI[playerid][data_GUN][12] = strval (temp);
		cache_get_field_content(0, "ammo0", temp), PI[playerid][data_AMMO][0] = strval (temp);
		cache_get_field_content(0, "ammo1", temp), PI[playerid][data_AMMO][1] = strval (temp);
		cache_get_field_content(0, "ammo2", temp), PI[playerid][data_AMMO][2] = strval (temp);
		cache_get_field_content(0, "ammo3", temp), PI[playerid][data_AMMO][3] = strval (temp);
		cache_get_field_content(0, "ammo4", temp), PI[playerid][data_AMMO][4] = strval (temp);
		cache_get_field_content(0, "ammo5", temp), PI[playerid][data_AMMO][5] = strval (temp);
		cache_get_field_content(0, "ammo6", temp), PI[playerid][data_AMMO][6] = strval (temp);
		cache_get_field_content(0, "ammo7", temp), PI[playerid][data_AMMO][7] = strval (temp);
		cache_get_field_content(0, "ammo8", temp), PI[playerid][data_AMMO][8] = strval (temp);
		cache_get_field_content(0, "ammo9", temp), PI[playerid][data_AMMO][9] = strval (temp);
		cache_get_field_content(0, "ammo10", temp), PI[playerid][data_AMMO][10] = strval (temp);
		cache_get_field_content(0, "ammo11", temp), PI[playerid][data_AMMO][11] = strval (temp);
		cache_get_field_content(0, "ammo12", temp), PI[playerid][data_AMMO][12] = strval (temp);
		cache_get_field_content(0, "healthchest", temp), PI[playerid][pHealPack] = strval (temp);
		cache_get_field_content(0, "HEALPACKSKLAD", temp), PI[playerid][pHealthPackKD] = strval (temp);
		cache_get_field_content(0, "Сanister", temp), PI[playerid][pCanisters] = strval (temp);
		cache_get_field_content(0, "mask", temp), PI[playerid][pMask] = strval (temp);
		cache_get_field_content(0, "VkontakteID", temp), PI[playerid][pVkontakteID] = strval (temp);
		cache_get_field_content(0, "twarn", temp), PI[playerid][pTwarn] = strval (temp);
		cache_get_field_content(0, "fixnabor", temp), PI[playerid][pFixPack] = strval (temp);
        cache_get_field_content(0, "military", temp), PI[playerid][pMilitaryID] = strval (temp);
        cache_get_field_content(0, "medcard", temp), PI[playerid][pMedCard] = strval (temp);
	    cache_get_field_content(0, "ProgressAmmo", temp), PI[playerid][pProgressAmmo] = strval (temp);
	    cache_get_field_content(0, "ProgressMetall", temp), PI[playerid][pProgressMetall] = strval (temp);
		cache_get_field_content(0, "PromoCodeUse", temp), PI[playerid][pPromoCodeUse] = strval (temp);
	    cache_get_field_content(0, "ProgressDrugs", temp), PI[playerid][pProgressDrugs] = strval (temp);
	    cache_get_field_content(0, "ProgressCarGrabber", temp), PI[playerid][pProgressCarGrabber] = strval (temp);
	    cache_get_field_content(0, "CaptureManager", temp), PI[playerid][pCaptureManager] = strval (temp);
	    cache_get_field_content(0, "ProgressSellGun", temp), PI[playerid][pProgressSellGun] = strval (temp);
        cache_get_field_content(0, "ProgressCapture", temp), PI[playerid][pProgressCapture] = strval (temp);
		cache_get_field_content(0, "CarGift", temp), PI[playerid][pCarGift] = strval (temp);

		IsPlayerLogged{playerid} = true;

		if(PI[playerid][pAdmin] >= 1)  
		{
			if(PI[playerid][pAdminNumber] == 0) 
			{
				PI[playerid][pAdminNumber] = random(9999);
				UpdatePlayerDataInt(playerid, "AdminNumber", PI[playerid][pAdminNumber]);
			}
			Iter_Add(Admin, playerid);
			SendAdminsMessagef(COLOR_ADMINCHAT, "[%s #%d] %s[%d] вошел на сервер", AdminName[PI[playerid][pAdmin]], PI[playerid][pAdminNumber], PI[playerid][pName], playerid);
		}
		else if(PI[playerid][pModer] >= 1)
		{
			Iter_Add(Moder, playerid);
			SendAdminsMessagef(COLOR_ADMINCHAT, "[%s] %s[%d] вошел на сервер", ModerName[PI[playerid][pModer]], PI[playerid][pName], playerid);
		}
		if(PI[playerid][pMember] == 5 || PI[playerid][pMember] == 6 || PI[playerid][pMember] == 7) 
		{
			CheckGangWar(playerid);
			for(new g; g <= totalgz; g++) GangZoneShowForPlayer(playerid, g, GetGZFrac(g));
		}

		if(PI[playerid][pSkin] == 0) return PI[playerid][pSkin] = 23;

		SCM(playerid, COLOR_BLACKBLUE, !"Добро пожаловать на Рассвет!");
		SCM(playerid, COLOR_LIGHTYELLOW, !"Загружаем данные сессии. Пожалуйства подождите...");
		SCM(playerid, COLOR_LIGHTYELLOW, "Меню помощи - /help, стандартное управление голосовым чатом: X (англ) - говорить");
		SendPlayerWelcomeNotify(playerid, "ДОБРО ПОЖАЛОВАТЬ", "РАДЫ ВИДЕТЬ ВАС НА НАШЕМ СЕРВЕРЕ!", 8);

		if(PI[playerid][pVmuteTime] > 0)
		{
			SendPlayerHudNotify(playerid, 20, "mute", "Блокировка голосового чата", PI[playerid][pVmuteTime]);
		}
		if(PI[playerid][pMuteTime] > 0)
		{
			SendPlayerHudNotify(playerid, 21, "mute", "Блокировка текстового чата", PI[playerid][pMuteTime]);
		}

		mysql_queryf(mysql, "SELECT `Name` FROM `accounts` WHERE `Referal` = '%e' LIMIT 10", true, getName(playerid));
		if(cache_num_rows() > 0) SCM(playerid, COLOR_HINT, !"[Подсказка] {FFFFFF}Для просмотра приглашённых игроков воспользуйтесь: {FFFF33}/ref");
		else SCM(playerid, COLOR_HINT, !"[Подсказка] {FFFFFF}Приглашайте своих друзей на сервер и зарабатывайте деньги с помощью нашей реферальной системы {FFFF33}(/ref){FFFFFF}!");
		mysql_queryf(mysql, "UPDATE `accounts` SET `LoginDate` = CURRENT_TIMESTAMP WHERE `Name` = '%e'", false, getName(playerid));
	
		if(!IsPlayerOPG(playerid)) 
		{
			if(PI[playerid][pMember] == 7) if(m_kavkaz != 0) SCM(playerid, COLOR_TOMATO, "[!!!] {FFFF99}Стрела в Вашей ОПГ заморожена! Подробнее в {ff6633}/ginfo");
			if(PI[playerid][pMember] == 6) if(m_gopota != 0) SCM(playerid, COLOR_TOMATO, "[!!!] {FFFF99}Стрела в Вашей ОПГ заморожена! Подробнее в {ff6633}/ginfo");
			if(PI[playerid][pMember] == 5) if(m_skinhead != 0) SCM(playerid, COLOR_TOMATO, "[!!!] {FFFF99}Стрела в Вашей ОПГ заморожена! Подробнее в {ff6633}/ginfo");
		}
		if(PI[playerid][pVmute] != 0) SvMutePlayerEnable(playerid);
     	if(PI[playerid][pMember] != 0) SetPlayerTeam(playerid, PI[playerid][pMember]);
        if(PI[playerid][pAdmin] != 0) PI[playerid][pVIP] = 1;

		SetPlayerScore(playerid, PI[playerid][pLevel]);
		UpdatePlayerMoney(playerid, PI[playerid][pMoney]);
		UpdatePlayerDataInt(playerid, "Online", 1);

		cef_emit_event(playerid, "cef:hud:active", CEFINT(1));

		if(RegisterNow[playerid] == true) PlayerSpawn(playerid);
		else PlayerSpawn(playerid);
	}
	else 
	{
        if(GetPVarInt(playerid, "WrongPassword") >= 3) return Kick(playerid);
        SetPVarInt(playerid, "WrongPassword", GetPVarInt ( playerid, "WrongPassword") + 1);
		SCMf(playerid, 0xFF6347FF, "[Внимание]: {FFFFFF}Пароль неверный. Использовано попыток: {FF6347}%d из 3",GetPVarInt(playerid,"WrongPassword"));
		PlayerLogin(playerid);
	}
	mysql_string[0] = EOS, mf(mysql, mysql_string, 45, "SELECT * FROM `group` WHERE `id` = '%d'", PI[playerid][pGroupID]);
	mysql_function_query(mysql, mysql_string, true, "PlayerGroup", "d", playerid);
	return 1;
}
callback: PlayerUpdate(playerid) 
{
    if(IsPlayerAdmin(playerid)) return Ban(playerid);
	if(!IsPlayerLogged{playerid}) return 1;

	PI[playerid][data_3SECOND]++;
	PI[playerid][data_MINUTE]++;

    new hour, minute, second;
	gettime(hour, minute, second);

  	if(PI[playerid][pJailTime] > 0) 
	{
		PI[playerid][pJailTime]--;
		if(PI[playerid][pDemorganTime] <= 0) PlayerSpawn(playerid);
	}
	if(PI[playerid][pDemorganTime] > 0) 
	{
		PI[playerid][pDemorganTime]--;
		if(PI[playerid][pDemorganTime] <= 0) PlayerSpawn(playerid);
	}
	if(PI[playerid][pVmuteTime] > 0 && PI[playerid][pVmute] == 1) 
	{
		PI[playerid][pVmuteTime]--;
		if(PI[playerid][pVmuteTime] <= 0) 
		{
			PI[playerid][pVmute] = 0;
			SCM(playerid, COLOR_LIGHTGREY, !"Голосовой чат был разблокирован, больше не нарушайте!");
			SvMutePlayerDisable(playerid);
		}
	}
	if(PI[playerid][pMuteTime] > 0 && PI[playerid][pMute] == 1) 
	{
		PI[playerid][pMuteTime]--;
		if(PI[playerid][pMuteTime] <= 0)
		{
			PI[playerid][pMute] = 0;
			SCM(playerid, COLOR_LIGHTGREY, !"Ваш чат был разблокирован, больше не нарушайте!");
		}
	}
 	if(GetPVarInt(playerid,"ac_timer") > 0) SetPVarInt(playerid, "ac_timer",GetPVarInt(playerid,"ac_timer")-1);
	if(GetPlayerMoney(playerid) != PI[playerid][pMoney]) UpdatePlayerMoney(playerid,PI[playerid][pMoney]);
	if(GetPlayerState(playerid) == 2) 
	{
		new carid = GetPlayerVehicleID(playerid);
	    new Float:hpveh; GetVehicleHealth(carid, hpveh);
		if(hpveh < 350) SetVehicleHealth(carid, 351.0);
	}
	if(PI[playerid][data_MINUTE] == 60) 
	{
	    PI[playerid][data_MINUTE] = 0;
        if(PI[playerid][pAFK] < 1) PI[playerid][data_TIME]++;
	    if(GetPVarInt(playerid, "ac_fly") >= 3) DeletePVar(playerid, "ac_fly");
		for(new i = 0; i < 13; i++)
	    if(PI[playerid][pWarn] != 0) 
		{
	        if(PI[playerid][pWarnTime] >= 1) PI[playerid][pWarnTime]--;
	        else 
			{
	            PI[playerid][pWarnTime] = 0;
	            PI[playerid][pWarn] = 0;
	            SCM(playerid, COLOR_LIGHTGREY, !"Все предупреждения были сняты, больше не нарушайте!");
	        }
	    }
	}
 	if(PI[playerid][pJail] != 0 && PI[playerid][pJailTime] <= 0) 
	{
		switch(PI[playerid][pJail]) 
		{
			case 1: 
			{
				SetPlayerPosAC(playerid, -298.9116,-1547.7133,41.0897);
				SetPlayerVirtualWorld(playerid,0);
				SetPlayerInterior(playerid,0);
				SetPlayerFacingAngle(playerid, 61.5454);
				SetCameraBehindPlayer(playerid);
			}
		}
		PI[playerid][pJailTime] = 0;
		PI[playerid][pJail] = 0;

		PlayerSpawn(playerid);
		SCM(playerid, COLOR_LIGHTGREY, !"Вы отсидели положенный срок. Больше не нарушайте!");
	}
	if(minute == 0 && payday[playerid] == false) {
		payday[playerid] = true;
		PayDay(playerid);	
	}
	if(minute > 1) payday[playerid] = false;
 	if(PI[playerid][pDemorgan] != 0 && PI[playerid][pDemorganTime] <= 0) 
	{
		PI[playerid][pDemorganTime] = 0;
		PI[playerid][pDemorgan] = 0;
		PlayerSpawn(playerid);
		SCM(playerid, COLOR_LIGHTGREY, !"Вы вышли из деморгана. Больше не нарушайте!");
	}
	if(PI[playerid][data_CALL] != -1) 
	{
		if(!IsPlayerConnected(PI[playerid][data_CALL])) 
		{
			if(!IsPlayerInAnyVehicle(playerid)) SetPlayerSpecialAction(playerid, SPECIAL_ACTION_STOPUSECELLPHONE);
			PI[playerid][data_CALL] = -1;
			SetPVarInt(playerid,"call_m",0);
			SCM(playerid, COLOR_LIGHTGREY, !"Ваш собеседник вышел с сервера");
		}
		if(GetPVarInt(playerid,"call_m") == 1) 
		{
	   		PI[playerid][pNumberMoney]--;
			if(PI[playerid][pNumberMoney] <= 0) 
			{
	    		new id = PI[playerid][data_CALL];
				if(!IsPlayerInAnyVehicle(playerid)) SetPlayerSpecialAction(playerid, SPECIAL_ACTION_STOPUSECELLPHONE);
				if(!IsPlayerInAnyVehicle(id)) SetPlayerSpecialAction(id, SPECIAL_ACTION_STOPUSECELLPHONE);
				PI[id][data_CALL] = -1;
				SetPVarInt(id,"call_m",0);
				PI[playerid][data_CALL] = -1;
				SetPVarInt(playerid,"call_m",0);
				SCM(playerid, COLOR_LIGHTGREY, !"У Вас закончились деньги на счете");
				SCM(id, COLOR_LIGHTGREY, !"У вашего собеседника закончились деньги на счете");
			}
		}
	}
	if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT && PI[playerid][pAFK] <= 1) 
	{
 		new Float: Health,Float: Armour;
	  	new Float:Distance = GetPlayerDistanceFromPoint(playerid, oldposX[playerid], oldposY[playerid], oldposZ[playerid]);
		GetPlayerHealth(playerid, Health);
		if(PI[playerid][pHealthPoints] < Health) SetPlayerHealthAC(playerid, PI[playerid][pHealthPoints]);
		else PI[playerid][pHealthPoints] = Health;
		GetPlayerArmour(playerid, Armour);
		if(PI[playerid][pArmour] < Armour) SetPlayerArmourAC(playerid, PI[playerid][pArmour]);
		else PI[playerid][pArmour] = Armour;

		new datagunid, dataammo;
		for(new slotgunid = 0; slotgunid < 13; slotgunid++) 
		{
	 		GetPlayerWeaponData(playerid, slotgunid, datagunid, dataammo);
			if(dataammo > PI[playerid][data_AMMO][slotgunid]) 
			{
			    ac_gun[playerid][slotgunid]++;
				if(ac_gun[playerid][slotgunid] == 3) printf("[ac_gun] playerid: %s, i: %d, datagunid: %d, dataammo: %d | ammo: %d",PI[playerid][pName], slotgunid, datagunid, dataammo,PI[playerid][data_AMMO][slotgunid]);
			}
			else if(dataammo < PI[playerid][data_AMMO][slotgunid] && ac_gun[playerid][slotgunid] == 0) PI[playerid][data_AMMO][slotgunid] = dataammo;
		}
        new carid = GetPlayerSurfingVehicleID(playerid);
		if(Distance > 45 && carid == INVALID_VEHICLE_ID) 
		{
  			SetPVarInt(playerid, "ac_fly",GetPVarInt(playerid, "ac_fly")+1);
			if(GetPVarInt(playerid, "ac_fly") == 3) printf("[ac_fly] playerid: %s, distance: %d",PI[playerid][pName], Distance);
		}

		GetPlayerPos(playerid, oldposX[playerid], oldposY[playerid], oldposZ[playerid]);
	}
	PI[playerid][pAFK]++;
	if(PI[playerid][pAFK] > 1 && PI[playerid][pAFK] < 60) 
	{
		new str[20];
		format(str, sizeof(str), "На паузе: %d сек", PI[playerid][pAFK]);
		SetPlayerChatBubble(playerid, str, COLOR_TOMATO, 20.0, 1100);
	}
	else if(PI[playerid][pAFK] >= 60) 
	{
		new str[20];
		format(str, sizeof(str), "На паузе: %d мин", PI[playerid][pAFK]/60);
		SetPlayerChatBubble(playerid, str, COLOR_TOMATO, 20.0, 1100);
	}
	if(PI[playerid][pAFK] == 600 && PI[playerid][pAdmin] >= 1) SendAdminsMessagef(COLOR_GREY, "<Info> Игровой мастер %s в AFK {ff6633}(10+ минут)", getName(playerid));
/*	if(PI[playerid][pAFK] > 1800) 
	{
		if(PI[playerid][pAdmin] >= 1) return 1;
		SCM(playerid, COLOR_GREY,"Превышено максимальное время паузы (30 минут)");
		SavePlayerData(playerid);
		TogglePlayerSpectating(playerid, false);
		Kick(playerid);
		return 1;
	}
*/
	if(PI[playerid][data_3SECOND] == 3) 
	{
	    PI[playerid][data_3SECOND] = 0;
	    if(PI[playerid][pHospital] == 1 && GetPlayerSpecialAction(playerid) != PLAYER_STATE_WASTED && GetPlayerSpecialAction(playerid) != PLAYER_STATE_SPAWNED) 
		{
			if(PlayerToPoint(100.0, playerid, 2105.4143,1459.2950,-47.5200)) 
			{
				new Float:Health;
				GetPlayerHealth(playerid, Health);
				SetPlayerHealthAC(playerid, Health + 10);

				if(PI[playerid][pHealthPoints] >= 100.0) 
				{
					PI[playerid][pHospital] = 0;
					PI[playerid][pHealthPoints] = Health;

					SCM(playerid, COLOR_WHITE, !"Курс лечения пройден, Вы можете покинуть палату");
					SCM(playerid, COLOR_WHITE, !"Если Вас не устраивает состояние здоровья, обратитесь к дежурному врачу");

					UpdatePlayerDataInt(playerid, "hospital", PI[playerid][pHospital]);
				}
			}
		}
	}
	return 1;
}
callback: CheckNameDonate(playerid, inputtext[]) 
{
    new rows, fields;
    cache_get_data(rows, fields);
    if(rows) return SCM(playerid, COLOR_GREY, !"Данный ник уже занят на сервере");
	else 
	{
		new sql[256];
		mf(mysql, sql, sizeof(sql), "INSERT INTO `nickname_history` ( `nh_owner`, `nh_oldname`, `nh_newname`, `nh_date`) VALUES ( '%d','%s' ,'%s', NOW())", PI[playerid][pID], PI[playerid][pName], CHANGE_NAME[playerid]);
		mysql_function_query(mysql, sql, false, "", "");

		SetPVarInt(playerid, "change_name_status", 0);

		mysql_queryf(mysql, "UPDATE `accounts` SET `Name` = '%e' WHERE `Name` = '%e'", false, CHANGE_NAME[playerid], PI[playerid][pName]);
		mysql_queryf(mysql, "UPDATE `punishment` SET `name` = '%e' WHERE `name` = '%e'", false, CHANGE_NAME[playerid], PI[playerid][pName]);
		mysql_queryf(mysql, "UPDATE `fractions_blacklist` SET `bl_name2` = '%e' WHERE `bl_name` = '%e'", false, CHANGE_NAME[playerid], PI[playerid][pName]);
		mysql_queryf(mysql, "UPDATE `ownable` SET `Owner` = '%e' WHERE `Owner` = '%e'", false, CHANGE_NAME[playerid], PI[playerid][pName]);

		strmid(CarInfo[PI[playerid][pLoadVehicleID]][cOwner], CHANGE_NAME[playerid], 0, strlen(CHANGE_NAME[playerid]), MAX_PLAYER_NAME);
		strmid(PI[playerid][pName], CHANGE_NAME[playerid], 0, strlen(CHANGE_NAME[playerid]), MAX_PLAYER_NAME);

		SetPlayerName(playerid, PI[playerid][pName]);

		PI[playerid][pDonate] -= 50;
		UpdatePlayerDataInt(playerid, "Donate", PI[playerid][pDonate]);
		SCM(playerid, 0x33ccffFF, !"Вы успешно изменили никнейм за 50 донат-поинтов.");

		if(PI[playerid][pHouse] != INVALID_HOUSE_ID) 
		{
			new h = PI[playerid][pHouse];
			strmid(HOUSE_DATA[h][data_OWNER], PI[playerid][pName], 0, strlen(PI[playerid][pName]), MAX_PLAYER_NAME);
            UpdateHouseData(h);
            SaveHouseData(h);
		}
		if(PI[playerid][pBusiness] != INVALID_BUSINESS_ID) 
		{
			new b = GetBusinessIndexByID(PI[playerid][pBusiness]);
			strmid(BizInfo[b][bOwner], PI[playerid][pName], 0, strlen(PI[playerid][pName]), MAX_PLAYER_NAME);
			UpdateBusinessData(b);
			SaveBusinessData(b);
		}
		if(PI[playerid][pFloat] != INVALID_KV_ID) 
		{
			new kv = PI[playerid][data_PADIK];
			new k = PI[playerid][pFloat];
			switch(k) 
			{
				case 0: strmid(kvData[kv][kvOwner_1], PI[playerid][pName], 0, strlen(PI[playerid][pName]), MAX_PLAYER_NAME);
				case 1: strmid(kvData[kv][kvOwner_2], PI[playerid][pName], 0, strlen(PI[playerid][pName]), MAX_PLAYER_NAME);
				case 2: strmid(kvData[kv][kvOwner_3], PI[playerid][pName], 0, strlen(PI[playerid][pName]), MAX_PLAYER_NAME);
				case 3: strmid(kvData[kv][kvOwner_4], PI[playerid][pName], 0, strlen(PI[playerid][pName]), MAX_PLAYER_NAME);
				case 4: strmid(kvData[kv][kvOwner_5], PI[playerid][pName], 0, strlen(PI[playerid][pName]), MAX_PLAYER_NAME);
				case 5: strmid(kvData[kv][kvOwner_6], PI[playerid][pName], 0, strlen(PI[playerid][pName]), MAX_PLAYER_NAME);
			}
			UpdateKVData(kv, k);
			SaveKVData(kv);
		}
		SavePlayerData(playerid);
    }
    return 1;
}
callback: CheckName(playerid, inputtext[]) 
{
    new rows, fields;
    cache_get_data(rows, fields);
    if(rows) SCM(playerid, COLOR_GREY, "Случайный никнейм уже занят другим игроком!");
	else 
	{
		if(PI[playerid][pAdmin] == 0)
		{
			mysql_string[0] = EOS, mf(mysql, mysql_string, 106, "UPDATE `punishment` SET `name` = '%e' WHERE `name` = '%e'", CHANGE_NAME[playerid], PI[playerid][pName]);
			mysql_function_query(mysql, mysql_string, false, "", "");
		}
		else SendAdminsMessagef(COLOR_GREY, "<Random Name> Игрок %s[%d] сменил ник на %s",PI[playerid][pName], playerid, CHANGE_NAME[playerid]);

		mysql_string[0] = EOS, mf(mysql, mysql_string, 200, "INSERT INTO `nickname_history` ( `nh_owner`, `nh_oldname`, `nh_newname`, `nh_date`) VALUES ( '%d','%s' ,'%s', NOW())", PI[playerid][pID], PI[playerid][pName], CHANGE_NAME[playerid]);
		mysql_function_query(mysql, mysql_string, false, "", "");
		
		SetPVarInt(playerid,"change_name_status", 0);
		
		mysql_queryf(mysql, "UPDATE `accounts` SET `Name` = '%e' WHERE `Name` = '%e'", false, CHANGE_NAME[playerid], PI[playerid][pName]);
		mysql_queryf(mysql, "UPDATE `punishment` SET `name` = '%e' WHERE `name` = '%e'", false, CHANGE_NAME[playerid], PI[playerid][pName]);
		mysql_queryf(mysql, "UPDATE `fractions_blacklist` SET `bl_name2` = '%e' WHERE `bl_name` = '%e'", false, CHANGE_NAME[playerid], PI[playerid][pName]);
		mysql_queryf(mysql, "UPDATE `ownable` SET `Owner` = '%e' WHERE `Owner` = '%e'", false, CHANGE_NAME[playerid], PI[playerid][pName]);

		strmid(CarInfo[PI[playerid][pLoadVehicleID]][cOwner], CHANGE_NAME[playerid], 0, strlen(CHANGE_NAME[playerid]), MAX_PLAYER_NAME);
		strmid(PI[playerid][pName], CHANGE_NAME[playerid], 0, strlen(CHANGE_NAME[playerid]), MAX_PLAYER_NAME);
		SetPlayerName(playerid, PI[playerid][pName]);

		if(PI[playerid][pHouse] != INVALID_HOUSE_ID) 
		{
			new h = PI[playerid][pHouse];
			strmid(HOUSE_DATA[h][data_OWNER], PI[playerid][pName], 0, strlen(PI[playerid][pName]), MAX_PLAYER_NAME);
            UpdateHouseData(h);
            SaveHouseData(h);
		}
		if(PI[playerid][pBusiness] != INVALID_BUSINESS_ID) 
		{
			new b = GetBusinessIndexByID(PI[playerid][pBusiness]);
			strmid(BizInfo[b][bOwner], PI[playerid][pName], 0, strlen(PI[playerid][pName]), MAX_PLAYER_NAME);
			UpdateBusinessData(b);
			SaveBusinessData(b);
		}
		if(PI[playerid][pFloat] != INVALID_KV_ID) 
		{
			new kv = PI[playerid][data_PADIK];
			new k = PI[playerid][pFloat];
			switch(k) 
			{
				case 0: strmid(kvData[kv][kvOwner_1], PI[playerid][pName], 0, strlen(PI[playerid][pName]), MAX_PLAYER_NAME);
				case 1: strmid(kvData[kv][kvOwner_2], PI[playerid][pName], 0, strlen(PI[playerid][pName]), MAX_PLAYER_NAME);
				case 2: strmid(kvData[kv][kvOwner_3], PI[playerid][pName], 0, strlen(PI[playerid][pName]), MAX_PLAYER_NAME);
				case 3: strmid(kvData[kv][kvOwner_4], PI[playerid][pName], 0, strlen(PI[playerid][pName]), MAX_PLAYER_NAME);
				case 4: strmid(kvData[kv][kvOwner_5], PI[playerid][pName], 0, strlen(PI[playerid][pName]), MAX_PLAYER_NAME);
				case 5: strmid(kvData[kv][kvOwner_6], PI[playerid][pName], 0, strlen(PI[playerid][pName]), MAX_PLAYER_NAME);
			}
			UpdateKVData(kv, k);
			SaveKVData(kv);
		}
		SavePlayerData(playerid);
    }
    return 1;
}
callback: OffLeader(playerid,name[]) 
{
    new rows, fields, rankk, temp[10];
    cache_get_data(rows, fields);
    if(rows) 
	{
	    for(new i = 0; i < MAX_PLAYERS; i++) 
		{
	        if(!IsPlayerConnected(i)) continue;
	        if(strcmp(PI[i][pName], name, true, 24) == 0) 
			{
	            SCM(i, COLOR_GREY, !"Вы были сняты с должности лидера");
				PI[i][pLeader] = 0;
				PI[i][pMember] = 0;
				SetPlayerSkinAC(i,PI[i][pSkin]);
				SetPlayerColorEx(i);
	        }
	    }
		for(new i = 0; i < rows; i++) 
		{
			cache_get_field_content(i, "rank", temp), rankk = strval(temp);
			if(rankk != 10) 
			{
				mysql_string[0] = EOS, mf(mysql, mysql_string, 110, "UPDATE `accounts` SET `leader` = '0', `member` = '0', `rank` = '0' WHERE `Name` = '%e'", name);
				mysql_function_query(mysql, mysql_string, false, "", "");
				SendAdminsMessagef(COLOR_ADMINCHAT, "[%s #%d] %s[%d] снял с лидерства оффлайн %s", AdminName[PI[playerid][pAdmin]], PI[playerid][pAdminNumber], PI[playerid][pName],playerid,name);
			}
			SCM(playerid, COLOR_GREY, !"Данный игрок не лидер");
		}
	}
	else SCM(playerid, COLOR_GREY, !"Данный аккаунт не найден в базе данных");
	return 1;
}
callback: LoadAllLeaders(playerid) 
{
    new rows, fields, leader,name[MAX_PLAYER_NAME],temp[20],string[625], string1[625], bugfix, login[30];
    cache_get_data(rows, fields);
    for(new i = 0; i < rows; i++) 
	{
		cache_get_field_content(i, "Name", name, mysql, MAX_PLAYER_NAME);
		cache_get_field_content(i, "Leader", temp), leader = strval (temp);
		cache_get_field_content(i, "LoginDate", login, mysql, 30);
		new ltext[64];
		switch(leader) 
		{
			case 1: ltext = "Правительство";
			case 2: ltext = "Войсковая часть";
			case 3: ltext = "Полиция";
   			case 4: ltext = "БЦРБ";
			case 5: ltext = "Скинхеды";
			case 6: ltext = "Гопота";
			case 7: ltext = "Кавказцы";
  		}
    	format(string,sizeof(string),"%s%s\t%s\t%s\n",string,ltext,name, login);
    	format(string1,sizeof(string1),"Организация\tИмя\tПоследний вход\n%s",string);
    	bugfix = 1;
	}
	if(bugfix == 1) return ShowPlayerDialog(playerid,0, DIALOG_STYLE_TABLIST_HEADERS, "{ee3366}Список лидеров", string1, "Закрыть", "");
  	return ShowPlayerDialog(playerid,0, DIALOG_STYLE_MSGBOX, !"{ee3366}Список лидеров", "{FFFFFF}В данный момент лидеров нет", "Закрыть", "");
}
callback: AnimationOff(playerid) 
{
    PI[playerid][data_ANIM] = false;
	return ApplyAnimation(playerid, "CARRY", "crry_prtial", 4.0, 0, 0, 0, 0, 0, 0);
}
callback: UnfreezePlayer(playerid) 
{
    TogglePlayerControllable(playerid, true);
    return SetPVarInt(playerid,"freeze",0);
}
callback: ChangePassword(playerid) {
    new rows, fields;
    cache_get_data(rows, fields);
    if(rows) ShowPlayerDialog(playerid, dialog_SETTING_2, DIALOG_STYLE_INPUT, !"{ee3366}Изменение пароля","Введите в поле ниже новый пароль от аккаунта\n{FFFF99}Пример: 12345qwe", "Далее", "Назад");
    else SCM(playerid, COLOR_GREY, !"Пароль который Вы ввели не принадлежит данному аккаунту, повторите попытку"),ShowPlayerDialog(playerid, dialog_SETTING_1, DIALOG_STYLE_INPUT, !"{ee3366}Изменение пароля","Введите в поле ниже свой нынешний пароль\n{FFFF99}Пример: 123qwe", "Далее", "Назад");
    return 1;
}
callback: SecondTimer() 
{
	global_minute++;
  	new hour_time,minuite_time, second_time, Year, Month, Day,month[10];
  	gettime(hour_time,minuite_time, second_time);
	getdate(Year, Month, Day);
	switch(Month) 
	{
		case 1: month = "01";
		case 2: month = "02";
		case 3: month = "03";
		case 4: month = "04";
		case 5: month = "05";
		case 6: month = "06";
		case 7: month = "07";
		case 8: month = "08";
		case 9: month = "09";
		case 10: month = "10";
		case 11: month = "11";
		case 12: month = "12";
	}
	capture_SecondTimer();
	if(global_minute == 60) 
	{
	    new hour, minute, second;
	    gettime(hour, minute, second);
	    switch(minute) 
		{
		    case 2: 
			{
				for(new b = 0; b < TotalBusiness; b++) 
				{
					if(BizInfo[b][bOwned] == 0) continue;
					if(BizInfo[b][bDays] == 0) continue;
					BizInfo[b][bProduct]--;
					UpdateBusinessData(b);
					SaveBusinessData(b);
				}
			}
			case 35: 
			{
			    SendClientMessageToAll(COLOR_MALINOVKA, !"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
			    SendClientMessageToAll(COLOR_WHITE, "Для посещения игрового магазина посетите форум {ee3366}"SITE"");
				SendClientMessageToAll(COLOR_WHITE, "Общение игроков и тороговая площадка - ждём тебя! {ee3366}vk.com/"FREE"");
			    SendClientMessageToAll(COLOR_WHITE, "В нашей игре действует реферальная система. Подробности на {ee3366}vk.com/"VK"");
			    SendClientMessageToAll(COLOR_WHITE, "При возникновении вопросов по игре, обращяйтесь в тех. поддержку: {ee3366}vk.me/"VK"");
			    SendClientMessageToAll(COLOR_MALINOVKA, !"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
			    new time = GetTickCount();
			    for(new k = 0; k < TotalKV; k++) SaveKVData(k);
			    for(new h = 0; h < TotalHouses; h++) SaveHouseData(h);
			    for(new b = 0; b < TotalBusiness; b++) SaveBusinessData(b);
			    SaveWarehouse();
			    printf("[server_log] save all. Time: %d ms.",GetTickCount()-time );
			}
			case 0: 
			{
				if(hour == 0) 
				{
					mysql_tqueryf(mysql, "UPDATE vk_bot SET yesterday_online=%d WHERE id=1", vMaxOnline);
				}
				if(hour == 9) SendClientMessageToAll(COLOR_GREY, !"Внимание! Через 3 минуты произойдёт плановый перезапуск сервера");
			}
            case 3: 
			{
                if(hour == 9 && restartserver == 0) 
				{
				    restartserver = 1;
					RestartCFG();
				}
            }
			case 59: 
			{
                if(hour == 23 && BusinessUpdate == 0) 
				{
				    BusinessUpdate = 1;
					SetBusinessUpdate();
				}
            }
		}
  		global_minute = 0;
		for(new carid; carid < MAX_VEHICLES; carid++) 
		{
			if(!IsAVelik(carid)) 
			{
				if(CarInfo[carid][cEngineStatus] == 1) 
				{
			  		if(CarInfo[carid][cFuel] <= 0) 
					{
			    		GetVehicleParamsEx(carid,engine,lights_text,alarm,doors_text,bonnet,boot,objective);
						SetVehicleParamsEx(carid,false,lights_text,alarm,doors_text,bonnet,boot,objective);
						CarInfo[carid][cEngineStatus] = 0;
						CarInfo[carid][cFuel] = 0;
						return 1;
			    	}
			    	CarInfo[carid][cFuel] -= 1;
			   	}
			}
		}
	}
	return 1;
}
callback: LoadBans() 
{
    new rows, fields, temp[60],time = GetTickCount(),banac;
    cache_get_data(rows, fields);
    if(rows) 
	{
		mysql_string[0] = EOS;
    	for(new b = 0; b < rows; b++) 
		{
         	cache_get_field_content(b, "id", temp), BansData[b][pID] = strval (temp);
         	cache_get_field_content(b, "day", temp), BansData[b][pDay] = strval (temp);
			TotalBans++;
   			if(BansData[b][pDay] <= 0) 
			{
			    mf(mysql, mysql_string, 45, "DELETE FROM `banlist` WHERE `id` = '%d'", BansData[b][pID]);
	    		mysql_function_query(mysql, mysql_string, false, "", "");
	    		banac++;
			}
			else 
			{
       			BansData[b][pDay]--;
				mf(mysql, mysql_string, 55, "UPDATE `banlist` SET `day` = '%d' WHERE `id` = '%d'", BansData[b][pDay], BansData[b][pID]);
			    mysql_function_query(mysql, mysql_string, false, "", "");
			}
		}
		printf("[INFO]  Load bans accounts. Load: %d. Unban: %d. Ex unban: %d. Time: %d ms.",TotalBans,banac,TotalBans-banac, GetTickCount()-time);
  	}
    return 1;
}
callback: LoadAllMembers(playerid) 
{
    new rows, fields,temp[10];
    new name[MAX_PLAYER_NAME], rank, LoginDate[30], str_1[256*4];
    cache_get_data(rows, fields);
    for(new i = 0; i < rows; i++) 
	{
		cache_get_field_content(i, "Name", name, mysql, MAX_PLAYER_NAME);
		cache_get_field_content(i, "LoginDate", LoginDate, mysql, 30);
		cache_get_field_content(i, "rank", temp), rank = strval (temp);
		format(str_1,sizeof(str_1),"%s%s\t%d\t%s\n", str_1, name, rank, LoginDate);
	}
	ShowPlayerDialogf(playerid,0, DIALOG_STYLE_TABLIST_HEADERS, "{ee3366}Список участников организации", "Закрыть", "", "Имя\tРанг\tПоследний вход\n%s",str_1);
	return 1;
}
public OnPlayerClickTextDraw(playerid, Text:clickedid) 
{
    if(clickedid == Text:INVALID_TEXT_DRAW && PI[playerid][data_CLICKTD] == true) 
	{
  		if(PI[playerid][data_CLOTHESMENU] == true) 
		{
			TextDrawHideForPlayer(playerid, buy_clothes[0]);
		  	TextDrawHideForPlayer(playerid, buy_clothes[1]);
		  	TextDrawHideForPlayer(playerid, buy_clothes[2]);
		  	TextDrawHideForPlayer(playerid, buy_clothes[3]);
		  	TextDrawHideForPlayer(playerid, buy_clothes[4]);
		  	TextDrawHideForPlayer(playerid, buy_clothes[5]);
		  	PlayerTextDrawHide(playerid, buy_clothes_m[playerid]);
 			PI[playerid][data_CLICKTD] = false;
 			PI[playerid][data_CLOTHESMENU] = false;
 			SetPlayerSkinAC(playerid,PI[playerid][pSkin]);
 			new b = GetPVarInt(playerid,"Clothes_biz");
 			SetPlayerPosAC(playerid,BizInfo[b][data_EXITX],BizInfo[b][data_EXITY],BizInfo[b][data_EXITZ]);
    		SetPlayerInterior(playerid,BizInfo[b][data_INT]);
    		SetPlayerVirtualWorld(playerid,BizInfo[b][data_VW]);
    		FreezePlayer(playerid);
			SetTimerEx("UnfreezePlayer", 4000, false, "d", playerid);
			SetCameraBehindPlayer(playerid);
 			CancelSelectTextDraw(playerid);
			return 1;
		}
  		if(PI[playerid][pInAutoSalon] == true) 
		{
  			DestroyVehicle(PI[playerid][pAutoSalonCar]);
  			PI[playerid][pAutoSalonCar] = INVALID_VEHICLE_ID;
			HideAutoSalonMenu(playerid);
			SetPlayerInterior(playerid,0);
			SetPlayerVirtualWorld(playerid,0);
			SetPlayerPosAC(playerid,2315.6946,-1792.2155,21.9700);
			SetPlayerFacingAngle(playerid, 88.9423);
			SetCameraBehindPlayer(playerid);
			return 1;
		}
	}
	else 
	{
	    if(clickedid == AutoSalon_ButtonColor[0]) SetPVarInt(playerid,"as_color",0);
	    if(clickedid == AutoSalon_ButtonColor[1]) SetPVarInt(playerid,"as_color",1);
	    if(clickedid == AutoSalon_Button[0]) 
		{ 
			new Cache: result, query[140];

			mf(mysql, query, sizeof query, "SELECT * FROM ownable WHERE Owner='%e'", getName(playerid));
			result = mysql_query(mysql, query, true);

			if(cache_num_rows() >= 10)
			{	
				SendClientMessagef(playerid, COLOR_GREY, "У Вас нет свободных парковочный мест (занято: %d / 10)", cache_num_rows());
			}
			cache_delete(result);

			ShowPlayerDialog(playerid, 9230, DIALOG_STYLE_LIST, "{ee3366}Выбор метода оплаты","\
																			1. Купить за донат-поинты\n\
																			2. Купить за наличные", "Выбрать", "Отмена");
			return 1;
		}
		if(clickedid == AutoSalon_Button[1]) 
		{
	        PI[playerid][pChangerAutoSalon]--;
			if(PI[playerid][pChangerAutoSalon] <= -1) PI[playerid][pChangerAutoSalon] = sizeof(DealershipCars)-1;
			DestroyVehicle(PI[playerid][pAutoSalonCar]);
		    PI[playerid][pAutoSalonCar] = CreateVehicle(DealershipCars[PI[playerid][pChangerAutoSalon]][asModel], 294.8927,1720.3408,11.8301,22.2060, 0, 0, 36000);
			TextDrawShowForPlayer(playerid,AutoSalon_Stats[0]);
	    	SetVehicleVirtualWorld(PI[playerid][pAutoSalonCar], playerid);
	    	return 1;
		}
	    if(clickedid == AutoSalon_Button[2]) 
		{
	        PI[playerid][pChangerAutoSalon]++;
			if(PI[playerid][pChangerAutoSalon] >= sizeof(DealershipCars)) PI[playerid][pChangerAutoSalon] = 0;
			DestroyVehicle(PI[playerid][pAutoSalonCar]);
		    PI[playerid][pAutoSalonCar] = CreateVehicle(DealershipCars[PI[playerid][pChangerAutoSalon]][asModel], 294.8927,1720.3408,11.8301,22.2060, 0, 0, 36000);
	    	SetVehicleVirtualWorld(PI[playerid][pAutoSalonCar], playerid);
	    	return 1;
		}
		if(clickedid == AutoSalon_Stats[0]) 
		{
			new modelid = GetVehicleModel(PI[playerid][pAutoSalonCar]);

		    new BufferCar[144];
			if(modelid == 560) format(BufferCar, sizeof(BufferCar), "Электрический");
			else format(BufferCar, sizeof(BufferCar), "Бензиновый");
			
		    ShowPlayerDialogf(playerid, 0, DIALOG_STYLE_MSGBOX, !"{ee3366}Информация о транспорте", "Закрыть", "", "\
			{FFFFFF}Название:\t\t\t{3366cc}%s\n\
			{FFFFFF}Цена:\t\t\t\t{FFFF99}%d руб / %d дп\n\
			{FFFFFF}Тип двигателя:\t\t\t{FFFF99}%s\n\
			{FFFFFF}Максимальная скорость:\t{FFFF99}%d км/ч\n\
			{FFFFFF}Класс автомобиля:\t\t{FFFF99}%s", VehicleNames[modelid-400], DealershipCars[PI[playerid][pChangerAutoSalon]][asDonate]*3000, DealershipCars[PI[playerid][pChangerAutoSalon]][asDonate], BufferCar, DealershipCars[PI[playerid][pChangerAutoSalon]][asSpeed],DealershipCars[PI[playerid][pChangerAutoSalon]][asClass]);
		}
		if(PI[playerid][data_CLOTHESMENU] == true) 
		{
		    if(clickedid == buy_clothes[4]) 
			{
				if(PI[playerid][pSex] == 1) 
				{
				    PI[playerid][pChangeSkin]--;
	       			if(PI[playerid][pChangeSkin] <= -1) PI[playerid][pChangeSkin] = 99;
	              	SetPlayerSkinAC(playerid,SkinMale[PI[playerid][pChangeSkin]][0]);
					new str_1[30];
	   				format(str_1,sizeof(str_1),"%d",SkinMale[PI[playerid][pChangeSkin]][1]);
	    			PlayerTextDrawSetString(playerid,  buy_clothes_m[playerid], str_1);
				}
				else
				{
				    PI[playerid][pChangeSkin]--;
	       			if(PI[playerid][pChangeSkin] <= -1) PI[playerid][pChangeSkin] = 17;
	              	SetPlayerSkinAC(playerid,SkinFeMale[PI[playerid][pChangeSkin]][0]);
					new str_1[30];
	   				format(str_1,sizeof(str_1),"%d",SkinFeMale[PI[playerid][pChangeSkin]][1]);
		    		PlayerTextDrawSetString(playerid,  buy_clothes_m[playerid], str_1);
				}
			}
			if(clickedid == buy_clothes[5]) 
			{
				if(PI[playerid][pSex] == 1) 
				{
				    PI[playerid][pChangeSkin]++;
	       			if(PI[playerid][pChangeSkin] >= 100) PI[playerid][pChangeSkin] = 0;
	              	SetPlayerSkinAC(playerid,SkinMale[PI[playerid][pChangeSkin]][0]);
					new str_1[30];
	   				format(str_1,sizeof(str_1),"%d",SkinMale[PI[playerid][pChangeSkin]][1]);
	    			PlayerTextDrawSetString(playerid,  buy_clothes_m[playerid], str_1);
				}
				else 
				{
				    PI[playerid][pChangeSkin]++;
	       			if(PI[playerid][pChangeSkin] >= 18) PI[playerid][pChangeSkin] = 0;
	              	SetPlayerSkinAC(playerid,SkinFeMale[PI[playerid][pChangeSkin]][0]);
					new str_1[30];
	   				format(str_1,sizeof(str_1),"%d",SkinFeMale[PI[playerid][pChangeSkin]][1]);
		    		PlayerTextDrawSetString(playerid,  buy_clothes_m[playerid], str_1);
				}
			}
			if(clickedid == buy_clothes[3]) 
			{
			    new b = GetPVarInt(playerid,"Clothes_biz");
			    if(BizInfo[b][bProduct] < 100 && BizInfo[b][bOwned] == 1) return SCM(playerid, COLOR_GREY,"В бизнесе недостаточно продуктов");
				if(PI[playerid][pSex] == 1) 
				{
				    new CenaSkin;
			    	CenaSkin = SkinMale[PI[playerid][pChangeSkin]][1];
					if(GetPlayerMoneyID(playerid) < CenaSkin) return SCM(playerid, COLOR_GREY,"У Вас недостаточно денег на руках");
					PI[playerid][pSkin] = GetPlayerSkin(playerid);
					GivePlayerMoneyLog(playerid,-CenaSkin);
					TextDrawHideForPlayer(playerid, buy_clothes[0]);
				    TextDrawHideForPlayer(playerid, buy_clothes[1]);
				    TextDrawHideForPlayer(playerid, buy_clothes[2]);
				    TextDrawHideForPlayer(playerid, buy_clothes[3]);
				    TextDrawHideForPlayer(playerid, buy_clothes[4]);
				    TextDrawHideForPlayer(playerid, buy_clothes[5]);
				    PlayerTextDrawHide(playerid, buy_clothes_m[playerid]);
		          	PI[playerid][data_CLICKTD] = false;
		          	PI[playerid][data_CLOTHESMENU] = false;
		          	SetPlayerSkinAC(playerid,PI[playerid][pSkin]);
		 			SetPlayerPosAC(playerid,BizInfo[b][data_EXITX],BizInfo[b][data_EXITY],BizInfo[b][data_EXITZ]);
		    		SetPlayerInterior(playerid,BizInfo[b][data_INT]);
		    		SetPlayerVirtualWorld(playerid,BizInfo[b][data_VW]);
		    		FreezePlayer(playerid);
					SetTimerEx("UnfreezePlayer", 4000, false, "d", playerid);
		        	SetCameraBehindPlayer(playerid);
		        	CancelSelectTextDraw(playerid);
		        	SCM(playerid, COLOR_YELLOW,"Поздравляем Вас с покупкой новой одежды");
					if(BizInfo[b][bOwned] != 0) 
					{
						BizInfo[b][bProduct] -= 1;
						BizInfo[b][bMoney] += CenaSkin;
						UpdateBusinessData(b);
					}
				}
				else
				{
				    new CenaSkin;
			    	CenaSkin = SkinFeMale[PI[playerid][pChangeSkin]][1];
				    if(GetPlayerMoneyID(playerid) < CenaSkin) return SCM(playerid, COLOR_GREY,"У Вас недостаточно денег на руках");
					PI[playerid][pSkin] = GetPlayerSkin(playerid);
					GivePlayerMoneyLog(playerid,-CenaSkin);
					TextDrawHideForPlayer(playerid, buy_clothes[0]);
				    TextDrawHideForPlayer(playerid, buy_clothes[1]);
				    TextDrawHideForPlayer(playerid, buy_clothes[2]);
				    TextDrawHideForPlayer(playerid, buy_clothes[3]);
				    TextDrawHideForPlayer(playerid, buy_clothes[4]);
				    TextDrawHideForPlayer(playerid, buy_clothes[5]);
				    PlayerTextDrawHide(playerid, buy_clothes_m[playerid]);
		          	PI[playerid][data_CLICKTD] = false;
		          	PI[playerid][data_CLOTHESMENU] = false;
		          	SetPlayerSkinAC(playerid,PI[playerid][pSkin]);
		          	SetPlayerPosAC(playerid,BizInfo[b][data_EXITX],BizInfo[b][data_EXITY],BizInfo[b][data_EXITZ]);
		    		SetPlayerInterior(playerid,BizInfo[b][data_INT]);
		    		SetPlayerVirtualWorld(playerid,BizInfo[b][data_VW]);
		    		FreezePlayer(playerid);
					SetTimerEx("UnfreezePlayer", 4000, false, "d", playerid);
		        	SetCameraBehindPlayer(playerid);
		        	CancelSelectTextDraw(playerid);
		        	SCM(playerid, COLOR_YELLOW,"Поздравляем Вас с покупкой новой одежды");
					if(BizInfo[b][bOwned] != 0) {
						BizInfo[b][bProduct] -= 1;
						BizInfo[b][bMoney] += CenaSkin;
						UpdateBusinessData(b);
					}
				}
				return 1;
			}
		}
	}
	return 1;
}
callback: WalkAnim(playerid)
{
    new keys, updown, leftright;
    GetPlayerKeys(playerid,keys,updown,leftright);
    if (GetPlayerWalkingStyle(playerid) == WALK_NORMAL)
    {
  		if ((keys & KEY_WALK && updown & KEY_UP) || (keys & KEY_WALK && updown & KEY_DOWN) || (keys & KEY_WALK && leftright & KEY_LEFT) || (keys & KEY_WALK && leftright & KEY_RIGHT))
        {
        	KillTimer(PI[playerid][data_WALK_TIMER]);
            ApplyAnimation(playerid,"PED","WALK_player",4.1,1,1,1,1,1);
            PI[playerid][data_WALK_TIMER] = SetTimerEx("WalkAnim",200,0,"d",playerid);
        }
        else ApplyAnimation(playerid,"PED","WALK_player",4.0,0,0,0,0,1), KillTimer(PI[playerid][data_WALK_TIMER]);
    }
    else if (GetPlayerWalkingStyle(playerid) == WALK_PED)
    {
    	if ((keys & KEY_WALK && updown & KEY_UP) || (keys & KEY_WALK && updown & KEY_DOWN) || (keys & KEY_WALK && leftright & KEY_LEFT) || (keys & KEY_WALK && leftright & KEY_RIGHT))
        {
        	KillTimer(PI[playerid][data_WALK_TIMER]);
            ApplyAnimation(playerid,"PED","WALK_civi",4.1,1,1,1,1,1);
            PI[playerid][data_WALK_TIMER] = SetTimerEx("WalkAnim",200,0,"d",playerid);
        }
        else ApplyAnimation(playerid,"PED","WALK_civi",4.0,0,0,0,0,1), KillTimer(PI[playerid][data_WALK_TIMER]);
    }
    else if (GetPlayerWalkingStyle(playerid) == WALK_GANGSTA)
    {
    	if ((keys & KEY_WALK && updown & KEY_UP) || (keys & KEY_WALK && updown & KEY_DOWN) || (keys & KEY_WALK && leftright & KEY_LEFT) || (keys & KEY_WALK && leftright & KEY_RIGHT))
        {
        	KillTimer(PI[playerid][data_WALK_TIMER]);
            ApplyAnimation(playerid,"PED","WALK_gang1",4.1,1,1,1,1,1);
            PI[playerid][data_WALK_TIMER] = SetTimerEx("WalkAnim",200,0,"d",playerid);
        }
        else ApplyAnimation(playerid,"PED","WALK_gang1",4.0,0,0,0,0,1), KillTimer(PI[playerid][data_WALK_TIMER]);
    }
    else if (GetPlayerWalkingStyle(playerid) == WALK_GANGSTA2)
    {
    	if ((keys & KEY_WALK && updown & KEY_UP) || (keys & KEY_WALK && updown & KEY_DOWN) || (keys & KEY_WALK && leftright & KEY_LEFT) || (keys & KEY_WALK && leftright & KEY_RIGHT))
        {
        	KillTimer(PI[playerid][data_WALK_TIMER]);
            ApplyAnimation(playerid,"PED","WALK_gang2",4.1,1,1,1,1,1);
            PI[playerid][data_WALK_TIMER] = SetTimerEx("WalkAnim",200,0,"d",playerid);
        }
        else ApplyAnimation(playerid,"PED","WALK_gang2",4.0,0,0,0,0,1), KillTimer(PI[playerid][data_WALK_TIMER]);
    }
    else if (GetPlayerWalkingStyle(playerid) == WALK_OLD)
    {
    	if ((keys & KEY_WALK && updown & KEY_UP) || (keys & KEY_WALK && updown & KEY_DOWN) || (keys & KEY_WALK && leftright & KEY_LEFT) || (keys & KEY_WALK && leftright & KEY_RIGHT))
        {
        	KillTimer(PI[playerid][data_WALK_TIMER]);
            ApplyAnimation(playerid,"PED","WALK_old",4.1,1,1,1,1,1);
            PI[playerid][data_WALK_TIMER] = SetTimerEx("WalkAnim",200,0,"d",playerid);
        }
        else ApplyAnimation(playerid,"PED","WALK_old",4.0,0,0,0,0,1), KillTimer(PI[playerid][data_WALK_TIMER]);
    }
    else if (GetPlayerWalkingStyle(playerid) == WALK_FAT_OLD)
    {
    	if ((keys & KEY_WALK && updown & KEY_UP) || (keys & KEY_WALK && updown & KEY_DOWN) || (keys & KEY_WALK && leftright & KEY_LEFT) || (keys & KEY_WALK && leftright & KEY_RIGHT))
        {
        	KillTimer(PI[playerid][data_WALK_TIMER]);
            ApplyAnimation(playerid,"PED","WALK_fatold",4.1,1,1,1,1,1);
            PI[playerid][data_WALK_TIMER] = SetTimerEx("WalkAnim",200,0,"d",playerid);
        }
        else ApplyAnimation(playerid,"PED","WALK_fatold",4.0,0,0,0,0,1), KillTimer(PI[playerid][data_WALK_TIMER]);
    }
    else if (GetPlayerWalkingStyle(playerid) == WALK_FAT)
    {
    	if ((keys & KEY_WALK && updown & KEY_UP) || (keys & KEY_WALK && updown & KEY_DOWN) || (keys & KEY_WALK && leftright & KEY_LEFT) || (keys & KEY_WALK && leftright & KEY_RIGHT))
        {
        	KillTimer(PI[playerid][data_WALK_TIMER]);
            ApplyAnimation(playerid,"PED","WALK_fat",4.1,1,1,1,1,1);
            PI[playerid][data_WALK_TIMER] = SetTimerEx("WalkAnim",200,0,"d",playerid);
        }
        else ApplyAnimation(playerid,"PED","WALK_fat",4.0,0,0,0,0,1), KillTimer(PI[playerid][data_WALK_TIMER]);
    }
    else if (GetPlayerWalkingStyle(playerid) == WALK_LADY)
    {
    	if ((keys & KEY_WALK && updown & KEY_UP) || (keys & KEY_WALK && updown & KEY_DOWN) || (keys & KEY_WALK && leftright & KEY_LEFT) || (keys & KEY_WALK && leftright & KEY_RIGHT))
        {
        	KillTimer(PI[playerid][data_WALK_TIMER]);
            ApplyAnimation(playerid,"PED","WOMAN_walknorm",4.1,1,1,1,1,1);
            PI[playerid][data_WALK_TIMER] = SetTimerEx("WalkAnim",200,0,"d",playerid);
        }
        else ApplyAnimation(playerid,"PED","WOMAN_walknorm",4.0,0,0,0,0,1), KillTimer(PI[playerid][data_WALK_TIMER]);
    }
    else if (GetPlayerWalkingStyle(playerid) == WALK_LADY2)
    {
    	if ((keys & KEY_WALK && updown & KEY_UP) || (keys & KEY_WALK && updown & KEY_DOWN) || (keys & KEY_WALK && leftright & KEY_LEFT) || (keys & KEY_WALK && leftright & KEY_RIGHT))
        {
        	KillTimer(PI[playerid][data_WALK_TIMER]);
            ApplyAnimation(playerid,"PED","WOMAN_walkbusy",4.1,1,1,1,1,1);
            PI[playerid][data_WALK_TIMER] = SetTimerEx("WalkAnim",200,0,"d",playerid);
        }
        else ApplyAnimation(playerid,"PED","WOMAN_walkbusy",4.0,0,0,0,0,1), KillTimer(PI[playerid][data_WALK_TIMER]);
    }
    else if (GetPlayerWalkingStyle(playerid) == WALK_WHORE)
    {
    	if ((keys & KEY_WALK && updown & KEY_UP) || (keys & KEY_WALK && updown & KEY_DOWN) || (keys & KEY_WALK && leftright & KEY_LEFT) || (keys & KEY_WALK && leftright & KEY_RIGHT))
        {
        	KillTimer(PI[playerid][data_WALK_TIMER]);
            ApplyAnimation(playerid,"PED","WOMAN_walkpro",4.1,1,1,1,1,1);
            PI[playerid][data_WALK_TIMER] = SetTimerEx("WalkAnim",200,0,"d",playerid);
        }
        else ApplyAnimation(playerid,"PED","WOMAN_walkpro",4.0,0,0,0,0,1), KillTimer(PI[playerid][data_WALK_TIMER]);
    }
    else if (GetPlayerWalkingStyle(playerid) == WALK_WHORE2)
    {
    	if ((keys & KEY_WALK && updown & KEY_UP) || (keys & KEY_WALK && updown & KEY_DOWN) || (keys & KEY_WALK && leftright & KEY_LEFT) || (keys & KEY_WALK && leftright & KEY_RIGHT))
        {
        	KillTimer(PI[playerid][data_WALK_TIMER]);
            ApplyAnimation(playerid,"PED","WOMAN_walksexy",4.1,1,1,1,1,1);
            PI[playerid][data_WALK_TIMER] = SetTimerEx("WalkAnim",200,0,"d",playerid);
        }
        else ApplyAnimation(playerid,"PED","WOMAN_walksexy",4.0,0,0,0,0,1), KillTimer(PI[playerid][data_WALK_TIMER]);
    }
    else if (GetPlayerWalkingStyle(playerid) == WALK_DRUNK)
    {
    	if ((keys & KEY_WALK && updown & KEY_UP) || (keys & KEY_WALK && updown & KEY_DOWN) || (keys & KEY_WALK && leftright & KEY_LEFT) || (keys & KEY_WALK && leftright & KEY_RIGHT))
        {
        	KillTimer(PI[playerid][data_WALK_TIMER]);
            ApplyAnimation(playerid,"PED","WALK_drunk",4.1,1,1,1,1,1);
            PI[playerid][data_WALK_TIMER] = SetTimerEx("WalkAnim",200,0,"d",playerid);
        }
        else ApplyAnimation(playerid,"PED","WALK_drunk",4.0,0,0,0,0,1), KillTimer(PI[playerid][data_WALK_TIMER]);
    }
    else if (GetPlayerWalkingStyle(playerid) == WALK_BLIND)
    {
    	if ((keys & KEY_WALK && updown & KEY_UP) || (keys & KEY_WALK && updown & KEY_DOWN) || (keys & KEY_WALK && leftright & KEY_LEFT) || (keys & KEY_WALK && leftright & KEY_RIGHT))
        {
        	KillTimer(PI[playerid][data_WALK_TIMER]);
            ApplyAnimation(playerid,"PED","Walk_Wuzi",4.1,1,1,1,1,1);
            PI[playerid][data_WALK_TIMER] = SetTimerEx("WalkAnim",200,0,"d",playerid);
        }
        else ApplyAnimation(playerid,"PED","Walk_Wuzi",4.0,0,0,0,0,1), KillTimer(PI[playerid][data_WALK_TIMER]);
    }
	return 1;
}
callback: ClearAnimPlayer(playerid) return ClearAnimations(playerid);
stock NotReklama(playerid, string[]) {
	new i, AR;
	for(i = strlen(string); i != 0; --i)
	switch(string[i]) {
		case '0'..'9': AR++;
	}
	if(AR > 7) {
		SendAdminsMessagef(0x66e0d6FF, "[Ghost-Message] Подозрение на %s[%d] (Сообщение: %s)",PI[playerid][pName],playerid,string);
		return 0;
  	}
	return 1;
}
stock GetPlayerGangZone(playerid) {
	for(new i; i <= totalgz; i++) if(IsPlayerToKvadrat(playerid,gz_info[i][gzminx],gz_info[i][gzminy],gz_info[i][gzmaxx],gz_info[i][gzmaxy])) return i;
	return -1;
}
IsPlayerToKvadrat(playerid,Float:min_x,Float:min_y,Float:max_x,Float:max_y)
{
	new Float:x,Float:y,Float:z;
	GetPlayerPos(playerid, x, y, z);
	if((x <= max_x && x >= min_x) && (y <= max_y && y >= min_y)) return 1;
	return 0;
}
stock ShowAutoSalonMenu(playerid) {
	SetPVarInt(playerid, "asalon", 1);
    PI[playerid][pInAutoSalon] = true;
    PI[playerid][data_CLICKTD] = true;
	for(new i = 0; i < 3; i++) TextDrawShowForPlayer(playerid, AutoSalon_Button[i]);
	TextDrawShowForPlayer(playerid,AutoSalon_Stats[0]);
	SelectTextDraw(playerid,0xddddddff);
	return 1;
}
stock HideAutoSalonMenu(playerid) 
{
	SetPVarInt(playerid, "asalon", 0);
    PI[playerid][pInAutoSalon] = false;
    PI[playerid][data_CLICKTD] = false;
	for(new i = 0; i < 3; i++) TextDrawHideForPlayer(playerid, AutoSalon_Button[i]);
    for(new i = 0; i < 2; i++) TextDrawHideForPlayer(playerid, AutoSalon_ButtonColor[i]);
    for(new i = 0; i < 48; i++) TextDrawHideForPlayer(playerid, AutoSalon_Color[i]);
	TextDrawHideForPlayer(playerid,AutoSalon_Stats[0]);
	CancelSelectTextDraw(playerid);
}
stock ShowClothesMenu(playerid,b) {
	if(PI[playerid][pMember] != 0) return SCM(playerid, COLOR_GREY,"Вы состоите в организации");
 	PI[playerid][data_CLICKTD] = true;
	PI[playerid][data_CLOTHESMENU] = true;
	SelectTextDraw(playerid,0xddddddff);
    SetPVarInt(playerid, "Clothes_biz", b);
	SCM(playerid,COLOR_TOMATO,"Чтобы закрыть донат меню, используйте: 'ESC'");
	PI[playerid][pChangeSkin] = 0;
	if(PI[playerid][pSex] == 1) SetPlayerSkinAC(playerid,SkinMale[PI[playerid][pChangeSkin]][0]);
	else SetPlayerSkinAC(playerid,SkinFeMale[PI[playerid][pChangeSkin]][0]);
	new string[9];
	format(string,sizeof(string),"%d",SkinMale[PI[playerid][pChangeSkin]][1]);
	PlayerTextDrawSetString(playerid,  buy_clothes_m[playerid], string);
	new virtworld = random(687);
	SetPlayerVirtualWorld(playerid,virtworld);
	SetPlayerInterior(playerid,0);
	TogglePlayerControllable(playerid, false);
	SetPlayerPosAC(playerid, -226.2288,487.0842,21.0635);
	SetPlayerFacingAngle(playerid,200.0);
	InterpolateCameraPos(playerid, -222.566482, 485.403137, 22.127206, -222.566482, 485.403137, 22.127206, 1000);
	InterpolateCameraLookAt(playerid, -227.177688, 486.782836, 20.773227, -227.177688, 486.782836, 20.773227, 1000);
	TextDrawShowForPlayer(playerid, buy_clothes[0]);
	TextDrawShowForPlayer(playerid, buy_clothes[1]);
	TextDrawShowForPlayer(playerid, buy_clothes[2]);
	TextDrawShowForPlayer(playerid, buy_clothes[3]);
	TextDrawShowForPlayer(playerid, buy_clothes[4]);
	TextDrawShowForPlayer(playerid, buy_clothes[5]);
	PlayerTextDrawShow(playerid, buy_clothes_m[playerid]);
	return 1;
}
stock ShowBusinessMenu(playerid,b) {
	switch(BizInfo[b][data_TYPE]) {
	    case 2: ShowShopMenu(playerid);
	    case 3: ShowClothesMenu(playerid,b);
		case 4: ShowEatMenu(playerid);
	}
	return 1;
}
stock ShowEatMenu(playerid) return ShowPlayerDialog(playerid, dialog_EAT_MENU, DIALOG_STYLE_LIST, "{ee3366}Закусочная", "Спранк (100 рублей)\nКофе (150 рублей)\nБургер (250 рублей)", "Купить", "Отмена");
stock UpdateHouseData(h) 
{
    DestroyDynamicMapIcon(HOUSE_DATA[h][data_MAPICON]);
    DestroyDynamicPickup(HOUSE_DATA[h][data_PICKUPENTER]);
    if(HOUSE_DATA[h][data_OWNED] == 0) 
	{
	    HOUSE_DATA[h][data_PICKUPENTER] = CreateDynamicPickup(1273, 23, HOUSE_DATA[h][data_ENTERX], HOUSE_DATA[h][data_ENTERY], HOUSE_DATA[h][data_ENTERZ],-1);
	    HOUSE_DATA[h][data_MAPICON] = CreateDynamicMapIcon(HOUSE_DATA[h][data_ENTERX], HOUSE_DATA[h][data_ENTERY], HOUSE_DATA[h][data_ENTERZ], 31, -1, 0, -1, -1, 100.0);
	}
	else {
		HOUSE_DATA[h][data_PICKUPENTER] = CreateDynamicPickup(1272, 23, HOUSE_DATA[h][data_ENTERX], HOUSE_DATA[h][data_ENTERY], HOUSE_DATA[h][data_ENTERZ],-1);
		HOUSE_DATA[h][data_MAPICON] = CreateDynamicMapIcon(HOUSE_DATA[h][data_ENTERX], HOUSE_DATA[h][data_ENTERY], HOUSE_DATA[h][data_ENTERZ], 32, -1, 0, -1, -1, 100.0);
	}
	return 1;
}
stock GetCoordBootVehicle(vehicleid, &Float:x, &Float:y, &Float:z) 
{
	new Float:angle,Float:distance;
	GetVehicleModelInfo(GetVehicleModel(vehicleid), 1, x, distance, z);
	distance = distance/2 + 0.1;
	GetVehiclePos(vehicleid, x, y, z);
	GetVehicleZAngle(vehicleid, angle);
	x += (distance * floatsin(-angle+180, degrees));
	y += (distance * floatcos(-angle+180, degrees));
	return 1;
}
stock RemovePlayerFromVehicleAC(playerid) {
    GetPlayerPos(playerid,oldposX[playerid],oldposY[playerid],oldposZ[playerid]);
	return RemovePlayerFromVehicle(playerid);
}
stock SetPlayerSkinAC(playerid, skinid) {
	ClearAnimations(playerid);
	SetPlayerSkin(playerid, skinid);
	return 1;
}
stock SetPlayerPosAC(playerid,Float:x,Float:y,Float:z) {
	oldposX[playerid] = x;
	oldposY[playerid] = y;
	oldposZ[playerid] = z;
	DeletePVar(playerid, "ac_fly");
	SetPlayerPos(playerid,oldposX[playerid],oldposY[playerid],oldposZ[playerid]);
	return 1;
}
stock PutPlayerInVehicleAC(playerid,car,set) {
    DeletePVar(playerid, "ac_fly");
	PutPlayerInVehicle(playerid,car,set);
	return 1;
}
stock ReportDialog(playerid) {
	if(PI[playerid][pMute] != 0) return SCM(playerid, COLOR_GREY,"У Вас мут");
	if(GetPVarInt(playerid,"Counting_Report") > gettime()) return SCM(playerid, COLOR_GREY,"Эту команду можно использовать 1 раз в 2 минуты");
	SetPVarInt(playerid,"Counting_Report",gettime() + 120);
	return ShowPlayerDialog(playerid,dialog_REPORT,DIALOG_STYLE_LIST,"{ee3366}Выберите тип","1. Вопрос или помощь\n2. Жалоба на игрока","Далее","Назад");
}
stock SendDBMessage(color, text[]) {
 	for(new i = 0; i < MAX_PLAYERS; i++) {
	    if(!IsPlayerConnected(i)) continue;
		if(GetPVarInt(i, "job_db") != 0) SCM(i, color, text);
	}
	return 1;
}
stock SendAdminsMessage(color, text[]) 
{
 	for(new i = 0; i < MAX_PLAYERS; i++) 
	{
	    if(!IsPlayerConnected(i)) continue;
		if(PI[i][pAdminChat] == 0) if(PI[i][pAdmin] >= 1 || PI[i][pModer] >= 1) SCM(i, color, text);
	}
	return 1;
}
stock SendOpgMessage(color, text[]) 
{
 	for(new i = 0; i < MAX_PLAYERS; i++) 
	{
	    if(!IsPlayerConnected(i)) continue;
		if(PI[i][pMember] == 5 || PI[i][pMember] == 6 || PI[i][pMember] == 7) if(PI[i][pAdmin] >= 1) SCM(i, color, text);
	}
	return 1;
}
stock SendVIPMessage(color, text[]) {
 	for(new i = 0; i < MAX_PLAYERS; i++) {
	    if(!IsPlayerConnected(i)) continue;
		if(PI[i][pVIP] >= 1) SCM(i, color, text);
	}
	return 1;
}
SetPlayerWalkingStyle(playerid, style) PI[playerid][data_WALK_STYLE] = style;
stock GetPlayerWalkingStyle(playerid) return PI[playerid][data_WALK_STYLE];
stock ClearAnim(playerid) {
	ApplyAnimation(playerid,"CARRY","crry_prtial",4.0,0,0,0,0,0,1);
	SetPlayerSpecialAction(playerid, 0);
	return 1;
}
stock PreloadAnimLib(playerid, animlib[]) return ApplyAnimation(playerid,animlib,"null",0.0,0,0,0,0,0);
stock FreezePlayer(playerid) 
{
    SetPVarInt(playerid,"freeze",1);
	SendPlayerCenterNotify(playerid, 4, "Пожалуйста, подождите...", 4);
	TogglePlayerControllable(playerid, false);
	return 1;
}
stock PlaySoundForAll(soundid, Float:x, Float:y, Float:z) {
	for (new i = 0; i < MAX_PLAYERS; i++) {
	    if(!IsPlayerConnected(i)) continue;
	    PlayerPlaySound(i, soundid, x, y, z);
	}
}
stock ProxDetector(Float:radi, playerid, string[],col1,col2,col3,col4,col5) {
    if(IsPlayerConnected(playerid)) {
        new Float:posx, Float:posy, Float:posz;
        new Float:oldposx, Float:oldposy, Float:oldposz;
        new Float:tempposx, Float:tempposy, Float:tempposz;
        GetPlayerPos(playerid, oldposx, oldposy, oldposz);
        new vw = GetPlayerVirtualWorld(playerid);
        for(new i = 0; i < MAX_PLAYERS; i++) {
            if(!IsPlayerConnected(i)) continue;
            if(IsPlayerConnected(i) && GetPlayerVirtualWorld(i) == vw) {
                GetPlayerPos(i, posx, posy, posz);
                tempposx = (oldposx -posx);
                tempposy = (oldposy -posy);
                tempposz = (oldposz -posz);
                if (((tempposx < radi/16) && (tempposx > -radi/16)) && ((tempposy < radi/16) && (tempposy > -radi/16)) && ((tempposz < radi/16) && (tempposz > -radi/16))) SCM(i, col1, string);
                else if (((tempposx < radi/8) && (tempposx > -radi/8)) && ((tempposy < radi/8) && (tempposy > -radi/8)) && ((tempposz < radi/8) && (tempposz > -radi/8))) SCM(i, col2, string);
                else if (((tempposx < radi/4) && (tempposx > -radi/4)) && ((tempposy < radi/4) && (tempposy > -radi/4)) && ((tempposz < radi/4) && (tempposz > -radi/4))) SCM(i, col3, string);
                else if (((tempposx < radi/2) && (tempposx > -radi/2)) && ((tempposy < radi/2) && (tempposy > -radi/2)) && ((tempposz < radi/2) && (tempposz > -radi/2))) SCM(i, col4, string);
                else if (((tempposx < radi) && (tempposx > -radi)) && ((tempposy < radi) && (tempposy > -radi)) && ((tempposz < radi) && (tempposz > -radi))) SCM(i, col5, string);
            }
            else {}
        }
    }
    return 1;
}
stock RestartCFG() 
{
	for(new i = 0; i < MAX_PLAYERS; i++) 
	{
		if(!IsPlayerConnected(i)) continue;
		SCM(i, COLOR_TOMATO, "");
		SCM(i, COLOR_TOMATO, "");
		SCM(i, COLOR_TOMATO, "");
		SCM(i, COLOR_TOMATO, "Внимание! Происходит перезапуск сервера");
		SCM(i, COLOR_TOMATO, "Пожалуйста, перезайдите через несколько минут");
		SCM(i, COLOR_TOMATO, "");
		SCM(i, COLOR_TOMATO, "");
		SCM(i, COLOR_TOMATO, "");
		Kick(i);
	}
	for(new h = 0; h < TotalHouses; h++) 
	{
		if(HOUSE_DATA[h][data_OWNED] == 1) 
		{
			if(HOUSE_DATA[h][data_DAY] > 1) HOUSE_DATA[h][data_DAY]--;
			else 
			{
	            mysql_tqueryf(mysql, "UPDATE `accounts` SET `house` = '-1', `salary` = '%d' WHERE `house` = '%d'",HOUSE_DATA[h][data_PRICE]/2, h);
    			strmid(HOUSE_DATA[h][data_OWNER], "none", 0, strlen(HOUSE_DATA[h][data_OWNER]), 24);
    			HOUSE_DATA[h][data_OWNED] = 0;
			}
			SaveHouseData(h);
		}
	}
	for(new kv = 0; kv < TotalKV; kv++)
	{
		for(new k = 0; k < 6; k++) 
		{
  			if(kvData[kv][kvOwned][k] == 1) 
			{
				if(kvData[kv][kvDays][k] > 1) kvData[kv][kvDays][k]--;
				else 
				{
				    switch(k) 
					{
						case 0: strmid(kvData[kv][kvOwner_1], "none", 0, strlen(kvData[kv][kvOwner_1]), MAX_PLAYER_NAME);
						case 1: strmid(kvData[kv][kvOwner_2], "none", 0, strlen(kvData[kv][kvOwner_2]), MAX_PLAYER_NAME);
						case 2: strmid(kvData[kv][kvOwner_3], "none", 0, strlen(kvData[kv][kvOwner_3]), MAX_PLAYER_NAME);
						case 3: strmid(kvData[kv][kvOwner_4], "none", 0, strlen(kvData[kv][kvOwner_4]), MAX_PLAYER_NAME);
						case 4: strmid(kvData[kv][kvOwner_5], "none", 0, strlen(kvData[kv][kvOwner_5]), MAX_PLAYER_NAME);
						case 5: strmid(kvData[kv][kvOwner_6], "none", 0, strlen(kvData[kv][kvOwner_6]), MAX_PLAYER_NAME);
					}
				    mysql_tqueryf(mysql, "UPDATE `accounts` SET `kv` = '-1', `padik` = '-1', `salary` = '%d' WHERE `padik` = '%d' AND `kv` = '%d'", kvData[kv][kvCost]/2, kv, k);
	    			kvData[kv][kvOwned][k] = 0;
				}
			}
		}
		SaveKVData(kv);
	}
	/*for(new b = 0; b < TotalBusiness; b++) 
	{
		if(BizInfo[b][bOwned] == 1) 
		{
			if(BizInfo[b][bDays] > 1) BizInfo[b][bDays]--;
			else 
			{
	            mysql_tqueryf(mysql, "UPDATE `accounts` SET `business` = '-1', `salary` = '%d' WHERE `business` = '%d'",BizInfo[b][bPrice]/2,b);
    			strmid(BizInfo[b][bOwner], "none", 0, strlen(BizInfo[b][bOwner]), 24);
    			BizInfo[b][bOwned] = 0;
			}
			SaveBusinessData(b);
		}
	}*/
 	SaveWarehouse();
	mysql_function_query(mysql, "SELECT * FROM `banlist`",true, "LoadBans", "");
	mysql_function_query(mysql, "SELECT * FROM `fractions_blacklist`",true, "LoadBlackList", "");
	mysql_function_query(mysql, "SELECT * FROM `accounts`",true, "LoadBang", "");
	return 1;
}
stock Player_Speed(playerid) {
    new Float:ST[4];
    if(IsPlayerInAnyVehicle(playerid)) GetVehicleVelocity(GetPlayerVehicleID(playerid),ST[0],ST[1],ST[2]);
   	else GetPlayerVelocity(playerid,ST[0],ST[1],ST[2]);
   	ST[3] = floatsqroot(floatpower(floatabs(ST[0]), 2.0) + floatpower(floatabs(ST[1]), 2.0) + floatpower(floatabs(ST[2]), 2.0)) * 100.3;
    return floatround(ST[3]);
}
stock LoadTextDraws() 
{
    GZ[0] = TextDrawCreate(580.500000, 150.977699, "interface:ZZ");
	TextDrawLetterSize(GZ[0], 0.000000, 0.000000);
	TextDrawTextSize(GZ[0], 70.500000, 50.044433);
	TextDrawAlignment(GZ[0], 1);
	TextDrawColor(GZ[0], 862362111);
	TextDrawSetShadow(GZ[0], 0);
	TextDrawSetOutline(GZ[0], 0);
	TextDrawFont(GZ[0], 4);

	AutoSalon_Stats[0] = TextDrawCreate(293.3334, 371.5334, "Interface:info");
	TextDrawTextSize(AutoSalon_Stats[0], 77.0000, 54.0000);
	TextDrawAlignment(AutoSalon_Stats[0], 1);
	TextDrawColor(AutoSalon_Stats[0], -1);
	TextDrawBackgroundColor(AutoSalon_Stats[0], 255);
	TextDrawFont(AutoSalon_Stats[0], 4);
	TextDrawSetProportional(AutoSalon_Stats[0], 0);
	TextDrawSetShadow(AutoSalon_Stats[0], 0);
	TextDrawSetSelectable(AutoSalon_Stats[0], true);

	AutoSalon_Button[2] = TextDrawCreate(391.3334, 385.2223, "Interface:next");
	TextDrawTextSize(AutoSalon_Button[2], 95.0000, 60.0000);
	TextDrawAlignment(AutoSalon_Button[2], 1);
	TextDrawColor(AutoSalon_Button[2], -1);
	TextDrawBackgroundColor(AutoSalon_Button[2], 255);
	TextDrawFont(AutoSalon_Button[2], 4);
	TextDrawSetProportional(AutoSalon_Button[2], 0);
	TextDrawSetShadow(AutoSalon_Button[2], 0);
	TextDrawSetSelectable(AutoSalon_Button[2], true);

	AutoSalon_Button[1] = TextDrawCreate(193.6665, 385.2223, "Interface:back");
	TextDrawTextSize(AutoSalon_Button[1], 86.0000, 59.0000);
	TextDrawAlignment(AutoSalon_Button[1], 1);
	TextDrawColor(AutoSalon_Button[1], -1);
	TextDrawBackgroundColor(AutoSalon_Button[1], 255);
	TextDrawFont(AutoSalon_Button[1], 4);
	TextDrawSetProportional(AutoSalon_Button[1], 0);
	TextDrawSetShadow(AutoSalon_Button[1], 0);
	TextDrawSetSelectable(AutoSalon_Button[1], true);

	AutoSalon_Button[0] = TextDrawCreate(286.9999, 401.8146, "Interface:choice");
	TextDrawTextSize(AutoSalon_Button[0], 81.0000, 55.0000);
	TextDrawAlignment(AutoSalon_Button[0], 1);
	TextDrawColor(AutoSalon_Button[0], -1);
	TextDrawBackgroundColor(AutoSalon_Button[0], 255);
	TextDrawFont(AutoSalon_Button[0], 4);
	TextDrawSetProportional(AutoSalon_Button[0], 0);
	TextDrawSetShadow(AutoSalon_Button[0], 0);
	TextDrawSetSelectable(AutoSalon_Button[0], true);

	AutoSalon_Color[0] = TextDrawCreate(12.000000, 89.320007, "LD_SPAC:white");
	AutoSalon_Color[1] = TextDrawCreate(35.000000, 89.320007, "LD_SPAC:white");
	AutoSalon_Color[2] = TextDrawCreate(58.000000, 89.320007, "LD_SPAC:white");
	AutoSalon_Color[3] = TextDrawCreate(81.000000, 89.320007, "LD_SPAC:white");
	AutoSalon_Color[4] = TextDrawCreate(104.000000, 89.320007, "LD_SPAC:white");
	AutoSalon_Color[5] = TextDrawCreate(127.000000, 89.320007, "LD_SPAC:white");
	AutoSalon_Color[6] = TextDrawCreate(12.000000, 118.000007, "LD_SPAC:white");
	AutoSalon_Color[7] = TextDrawCreate(35.000000, 118.000007, "LD_SPAC:white");
	AutoSalon_Color[8] = TextDrawCreate(58.000000, 118.000007, "LD_SPAC:white");
	AutoSalon_Color[9] = TextDrawCreate(81.000000, 118.000007, "LD_SPAC:white");
	AutoSalon_Color[10] = TextDrawCreate(104.000000, 118.000007, "LD_SPAC:white");
	AutoSalon_Color[11] = TextDrawCreate(127.000000, 118.000007, "LD_SPAC:white");
	AutoSalon_Color[12] = TextDrawCreate(12.000000, 146.399963, "LD_SPAC:white");
	AutoSalon_Color[13] = TextDrawCreate(35.000000, 146.399963, "LD_SPAC:white");
	AutoSalon_Color[14] = TextDrawCreate(58.000000, 146.399963, "LD_SPAC:white");
	AutoSalon_Color[15] = TextDrawCreate(81.000000, 146.399963, "LD_SPAC:white");
	AutoSalon_Color[16] = TextDrawCreate(104.000000, 146.399963, "LD_SPAC:white");
	AutoSalon_Color[17] = TextDrawCreate(127.000000, 146.399963, "LD_SPAC:white");
	AutoSalon_Color[18] = TextDrawCreate(12.000000, 174.799942, "LD_SPAC:white");
	AutoSalon_Color[19] = TextDrawCreate(35.000000, 174.799942, "LD_SPAC:white");
	AutoSalon_Color[20] = TextDrawCreate(58.000000, 174.799942, "LD_SPAC:white");
	AutoSalon_Color[21] = TextDrawCreate(81.000000, 174.799942, "LD_SPAC:white");
	AutoSalon_Color[22] = TextDrawCreate(104.000000, 174.799942, "LD_SPAC:white");
	AutoSalon_Color[23] = TextDrawCreate(127.000000, 174.799942, "LD_SPAC:white");
	AutoSalon_Color[24] = TextDrawCreate(12.000000, 203.759994, "LD_SPAC:white");
	AutoSalon_Color[25] = TextDrawCreate(35.000000, 203.759994, "LD_SPAC:white");
	AutoSalon_Color[26] = TextDrawCreate(58.000000, 203.759994, "LD_SPAC:white");
	AutoSalon_Color[27] = TextDrawCreate(81.000000, 203.759994, "LD_SPAC:white");
	AutoSalon_Color[28] = TextDrawCreate(104.000000, 203.759994, "LD_SPAC:white");
	AutoSalon_Color[29] = TextDrawCreate(127.000000, 203.759994, "LD_SPAC:white");
	AutoSalon_Color[30] = TextDrawCreate(12.000000, 232.160003, "LD_SPAC:white");
	AutoSalon_Color[31] = TextDrawCreate(35.000000, 232.160003, "LD_SPAC:white");
	AutoSalon_Color[32] = TextDrawCreate(58.000000, 232.160003, "LD_SPAC:white");
	AutoSalon_Color[33] = TextDrawCreate(81.000000, 232.160003, "LD_SPAC:white");
	AutoSalon_Color[34] = TextDrawCreate(104.000000, 232.160003, "LD_SPAC:white");
	AutoSalon_Color[35] = TextDrawCreate(127.000000, 232.160003, "LD_SPAC:white");
	AutoSalon_Color[36] = TextDrawCreate(12.000000, 260.559997, "LD_SPAC:white");
	AutoSalon_Color[37] = TextDrawCreate(35.000000, 260.559997, "LD_SPAC:white");
	AutoSalon_Color[38] = TextDrawCreate(58.000000, 260.559997, "LD_SPAC:white");
	AutoSalon_Color[39] = TextDrawCreate(81.000000, 260.559997, "LD_SPAC:white");
	AutoSalon_Color[40] = TextDrawCreate(104.000000, 260.559997, "LD_SPAC:white");
	AutoSalon_Color[41] = TextDrawCreate(127.000000, 260.559997, "LD_SPAC:white");
	AutoSalon_Color[42] = TextDrawCreate(12.000000, 289.519958, "LD_SPAC:white");
	AutoSalon_Color[43] = TextDrawCreate(35.000000, 289.519958, "LD_SPAC:white");
	AutoSalon_Color[44] = TextDrawCreate(58.000000, 289.519958, "LD_SPAC:white");
	AutoSalon_Color[45] = TextDrawCreate(81.000000, 289.519958, "LD_SPAC:white");
	AutoSalon_Color[46] = TextDrawCreate(104.000000, 289.519958, "LD_SPAC:white");
	AutoSalon_Color[47] = TextDrawCreate(127.000000, 289.519958, "LD_SPAC:white");
	for(new i = 0; i < 48; i++) 
	{
		TextDrawLetterSize(AutoSalon_Color[i], 0.000000, 0.000000);
		TextDrawTextSize(AutoSalon_Color[i], 21.500000, 26.879997);
		TextDrawAlignment(AutoSalon_Color[i], 1);
		TextDrawColor(AutoSalon_Color[i], color_veh[i][ciTD]);
		TextDrawSetShadow(AutoSalon_Color[i], 0);
		TextDrawSetOutline(AutoSalon_Color[i], 0);
		TextDrawFont(AutoSalon_Color[i], 4);
		TextDrawSetSelectable(AutoSalon_Color[i], true);
	}
	buy_clothes[0] = TextDrawCreate(19.000000, 142.488891, "LD_SPAC:white");
	TextDrawLetterSize(buy_clothes[0], 0.000000, 0.000000);
	TextDrawTextSize(buy_clothes[0], 55.000000, 28.622222);
	TextDrawAlignment(buy_clothes[0], 1);
	TextDrawColor(buy_clothes[0], 0x339999FF);
	TextDrawSetShadow(buy_clothes[0], 0);
	TextDrawSetOutline(buy_clothes[0], 0);
	TextDrawFont(buy_clothes[0], 4);
	TextDrawSetSelectable(buy_clothes[0], true);
	buy_clothes[1] = TextDrawCreate(19.000000, 173.355590, "LD_SPAC:white");
	TextDrawLetterSize(buy_clothes[1], 0.000000, 0.000000);
	TextDrawTextSize(buy_clothes[1], 26.500000, 31.733329);
	TextDrawAlignment(buy_clothes[1], 1);
	TextDrawColor(buy_clothes[1], 0x339999FF);
	TextDrawSetShadow(buy_clothes[1], 0);
	TextDrawSetOutline(buy_clothes[1], 0);
	TextDrawFont(buy_clothes[1], 4);
	TextDrawSetSelectable(buy_clothes[1], true);
	buy_clothes[2] = TextDrawCreate(47.500000, 173.111145, "LD_SPAC:white");
	TextDrawLetterSize(buy_clothes[2], 0.000000, 0.000000);
	TextDrawTextSize(buy_clothes[2], 26.500000, 31.733329);
	TextDrawAlignment(buy_clothes[2], 1);
	TextDrawColor(buy_clothes[2], 0x339999FF);
	TextDrawSetShadow(buy_clothes[2], 0);
	TextDrawSetOutline(buy_clothes[2], 0);
	TextDrawFont(buy_clothes[2], 4);
	TextDrawSetSelectable(buy_clothes[2], true);
	buy_clothes[3] = TextDrawCreate(281.6667, 320.5111, "Interface:choice"); // пусто
	TextDrawTextSize(buy_clothes[3], 75.0000, 53.0000);
	TextDrawAlignment(buy_clothes[3], 1);
	TextDrawColor(buy_clothes[3], -1);
	TextDrawBackgroundColor(buy_clothes[3], 255);
	TextDrawFont(buy_clothes[3], 4);
	TextDrawSetProportional(buy_clothes[3], 0);
	TextDrawSetShadow(buy_clothes[3], 0);
	TextDrawSetSelectable(buy_clothes[3], true);
	buy_clothes[4] = TextDrawCreate(393.0000, 315.1186, "Interface:back"); // пусто
	TextDrawTextSize(buy_clothes[4], 82.0000, 64.0000);
	TextDrawAlignment(buy_clothes[4], 1);
	TextDrawColor(buy_clothes[4], -1);
	TextDrawBackgroundColor(buy_clothes[4], 255);
	TextDrawFont(buy_clothes[4], 4);
	TextDrawSetProportional(buy_clothes[4], 0);
	TextDrawSetShadow(buy_clothes[4], 0);
	TextDrawSetSelectable(buy_clothes[4], true);
	buy_clothes[5] = TextDrawCreate(151.6666, 313.0444, "Interface:next"); // пусто
	TextDrawTextSize(buy_clothes[5], 89.0000, 68.0000);
	TextDrawAlignment(buy_clothes[5], 1);
	TextDrawColor(buy_clothes[5], -1);
	TextDrawBackgroundColor(buy_clothes[5], 255);
	TextDrawFont(buy_clothes[5], 4);
	TextDrawSetProportional(buy_clothes[5], 0);
	TextDrawSetShadow(buy_clothes[5], 0);
	TextDrawSetSelectable(buy_clothes[5], true);
    return 1;
}
stock PlayerToKvadrat(playerid, Float:min_x, Float:min_y, Float:max_x, Float:max_y) {
	new Float:xxp,Float:yyp,Float:zzp;
	GetPlayerPos(playerid, xxp, yyp, zzp);
	if((xxp <= max_x && xxp >= min_x) && (yyp <= max_y && yyp >= min_y)) return 1;
	return 0;
}

stock PlayerRegistration(playerid) 
{
    return ShowPlayerDialog(playerid, dialog_REGISTER, DIALOG_STYLE_PASSWORD, !"{ee3366}Регистрация", !"{FFFFFF}Добро пожаловать на {FFA500}"NAMESERVER"{FFFFFF}!\n\nЭтот аккаунт {FFFF99}не зарегистрирован{FFFFFF}на нашем сервере.\nПридумайте пароль, соответствующий следующим критериям:\n\n{FFFF99}Длина пароля: от 6 до 30 символов\n{FFFF99}Пароль должен содержать буквы и цифры\n{FFFF99}Пароль чувствителен к регистру.", !"Далее", !"");
}
stock PlayerLogin(playerid) 
{	
	ShowPlayerDialogf(playerid, dialog_LOGIN, DIALOG_STYLE_PASSWORD, !"{ee3366}Авторизация", !"Войти", !"", "\
	{FFFFFF}Добро пожаловать на {FFA500}"NAMESERVER"{FFFFFF}!\n\n\
	Пройдите авторизацию, чтобы начать играть\n\
	Ваш логин: {FFFF99}%s{FFFFFF}\n\
	Введите свой пароль в поле ниже:\n\n\
	{696969}Примичение: у Вас есть только 3 попытки на ввод пароля", PI[playerid][pName]);

	return SetPlayerVirtualWorld(playerid, playerid);
}
stock ClearCarData(car) 
{
	CarInfo[car][cLock] = 0;
	CarInfo[car][cEngineStatus] = 0;
	CarInfo[car][cLamp] = 0;
	CarInfo[car][cAutoSchool] = INVALID_PLAYER_ID;
	CarInfo[car][cRent] = INVALID_PLAYER_ID;
	CarInfo[car][cLoadValue] = 0;
	CarInfo[car][cLoad] = 0;
	CarInfo[car][cAmmo] = 0;
	CarInfo[car][cMetall] = 0;
	return 1;
}
stock ShowStats(playerid, forid = -1) 
{
    new NextLvl = PI[playerid][pLevel]+1;
	new NextExp = NextLvl*4;

    new RangOrg[60], PlayerHome[60], PlayerBusiness[30], Number[10];

    switch(PI[playerid][pMember]) 
	{
 	    case 0:format(RangOrg,sizeof(RangOrg),"Должность:\t\t\tНет\n");
 	    case 1:format(RangOrg,sizeof(RangOrg),"Должность:\t\t\t%s\n",rang_gov[PI[playerid][pRang]-1][frName]);
		case 2:format(RangOrg,sizeof(RangOrg),"Звание:\t\t\t%s\n",rang_army[PI[playerid][pRang]-1][frName]);
		case 3:format(RangOrg,sizeof(RangOrg),"Звание:\t\t\t%s\n",rang_police[PI[playerid][pRang]-1][frName]);
		case 4:format(RangOrg,sizeof(RangOrg),"Должность:\t\t\t%s\n",rang_hospital[PI[playerid][pRang]-1][frName]);
	    case 5:format(RangOrg,sizeof(RangOrg),"Масть:\t\t\t\t%s\n",rang_skinhead[PI[playerid][pRang]-1][frName]);
	    case 6:format(RangOrg,sizeof(RangOrg),"Масть:\t\t\t\t%s\n",rang_gopota[PI[playerid][pRang]-1][frName]);
	    case 7:format(RangOrg,sizeof(RangOrg),"Масть:\t\t\t\t%s\n",rang_kavkaz[PI[playerid][pRang]-1][frName]);
	}

    if(PI[playerid][pHouse] != INVALID_HOUSE_ID) 
	{
		format(PlayerHome, sizeof(PlayerHome), "Место жительства:\t\t№%d\n",PI[playerid][pHouse]+1);
	}
	else if(PI[playerid][pFloat] != INVALID_KV_ID) 
	{
		format(PlayerHome, sizeof(PlayerHome), "Место жительства:\t\t№%d\n",PI[playerid][pFloat]+1);
	}
    else 
	{
        PlayerHome = "Бездомный";
	}
	switch(PI[playerid][pBusiness]) 
	{
		case INVALID_BUSINESS_ID: PlayerBusiness = "Нет";
		default: format(PlayerBusiness, sizeof(PlayerBusiness), "№%d", PI[playerid][pBusiness]+1);
	}
	f(Number, sizeof(Number), "%d", PI[playerid][pNumber]);


	f(global_str, 1048, "{FFFFFF}Имя:\t\t\t\t{285d9f}%s\n\
						{FFFFFF}Номер персонажа:{FFA500}\t\t%d\n\
                        {FFFFFF}Подписка:\t\t\t{%s}%s\n\
                        {FFFFFF}___________________________________\n\n\
                        Уровень:\t\t\t%d\n\
                        Очки опыта:\t\t\t%d / %d\n\
                        Пол:\t\t\t\t%s\n\
                        Номер телефона:\t\t%s\n\
                        Баланс телефона:\t\t%d руб\n\
                        Законопослушность:\t\t%d\n\
                        Уровень розыска:\t\t%d\n\
                        Вещества:\t\t\t%d / %d\n\
                        Зависимость:\t\t\t%d\n\
                        Металл:\t\t\t%d / %d\n\
                        Патроны:\t\t\t%d / %d\n\
                        Маска:\t\t\t\t%d / 1\n\
                        Аптечки:\t\t\t%d / 3\n\
                        ___________________________________\n\n\
                        Организация:\t\t\t%s\n\
                        %s\n\
                        Место жительства:\t\t%s\n\
                        Бизнес:\t\t\t%s",
                        getName(playerid), 
                        PI[playerid][pID],
                        PI[playerid][pVIP] ? "ffcd00" : "285d9f",
                        PI[playerid][pVIP] ? "Активна" : "Неактивна",
                        PI[playerid][pLevel],
                        PI[playerid][pExp], NextExp,
                        PI[playerid][pSex] ? "Мужской" : "Женский",
                        PI[playerid][pNumber] ? "Нет" : Number,
                        PI[playerid][pNumberMoney],
                        PI[playerid][pRespect],
                        PI[playerid][pWanted],
                        PI[playerid][pDrugs], PI[playerid][pVIP] ? 2000 : 1000,
                        PI[playerid][pUserDrugs],
                        PI[playerid][pMetall], PI[playerid][pVIP] ? 80 : 40,
                        PI[playerid][pAmmo], PI[playerid][pVIP] ? 800 : 400,
                        PI[playerid][pMask],
                        PI[playerid][pHealPack],
                        Fraction_Name[PI[playerid][pMember]],
                        RangOrg,
                        PlayerHome,
                        PlayerBusiness);  


	if(forid == -1) ShowPlayerDialog(playerid, 8009, DIALOG_STYLE_MSGBOX, !"{ee3366}Статистика игрока", global_str, "Закрыть", "Назад");
	else ShowPlayerDialog(forid, 0, DIALOG_STYLE_MSGBOX, !"{ee3366}Статистика игрока", global_str, "Закрыть", "Назад");

	return 1;
}
stock ClearPlayerData(playerid) 
{
	nc_ClearPlayerData(playerid);

	PI[playerid][pTempJob] = 0; 

	PI[playerid][pCinematicMode] = 0;

	PI[playerid][pTempMember] = -1;

	PI[playerid][pRentMoto] = INVALID_VEHICLE_ID;

	PI[playerid][PTempJobValue_1] = 0; 
	PI[playerid][PTempJobValue_2] = 0; 
	PI[playerid][pTempJobMoney] = 0; 

	PI[playerid][pOnCapture] = 0;
	PI[playerid][pCaptureManager] = 0;

	PI[playerid][pFlyMode] = 0;
	PI[playerid][pFlyInt] = 0;
	PI[playerid][pFlyVirtualWorld] = 0;
	PI[playerid][pFlyX] = 0;
	PI[playerid][pFlyY] = 0;
	PI[playerid][pFlyZ] = 0;

    ClearRequest(playerid);

	for(new i = 0; i < 13; i++) {
		PI[playerid][data_GUN][i] = 0;
		PI[playerid][data_AMMO][i] = 0;
	}
    shield[playerid] = false;
    PI[playerid][data_TIME] = 0;
    PI[playerid][data_911_1] = 0;
	PI[playerid][pID] = 0;
	PI[playerid][data_911_2] = 0;
	IsPlayerLogged{playerid} = false;
	PI[playerid][pSex] = 0;
	PI[playerid][pSkin] = 0;
	PI[playerid][pOrgSkin] = 0;
	PI[playerid][pMoney] = 0;
	PI[playerid][pAdmin] = 0;
	PI[playerid][pModer] = 0;

	PI[playerid][pAdminWatherDriver] = 0;
	PI[playerid][pAdminNoReload] = 0;

	PI[playerid][pAdminWarn] = 0;
	PI[playerid][pModerWarn] = 0;
	PI[playerid][pLevel] = 0;
	PI[playerid][pExp] = 0;
	PI[playerid][pMember] = 0;
	PI[playerid][pLeader] = 0;
	PI[playerid][pRang] = 0;
	PI[playerid][data_ANIM] = false;
	PI[playerid][data_3SECOND] = 0;
	PI[playerid][data_MINUTE] = 0;
	PI[playerid][pChangeSkin] = 0;
	PI[playerid][pSelectSkin] = 0;
	PI[playerid][pMute] = 0;
	PI[playerid][pMuteTime] = 0;
	PI[playerid][pWarn] = 0;
	PI[playerid][pWarnTime] = 0;
	PI[playerid][pBank] = 0;
	PI[playerid][data_PUTPATR] = 0;
	PI[playerid][data_PUTMET] = 0;
	PI[playerid][data_EFIR] = false;
	PI[playerid][pPayDayMoney] = 0;
	PI[playerid][pAFK] = -1;
	PI[playerid][pDriveLicense] = 0;
	PI[playerid][pGunLicense] = 0;
	PI[playerid][pAmmo] = 0;
	PI[playerid][pDrugs] = 0;
	PI[playerid][pWanted] = 0;
	PI[playerid][pRespect] = 0;
	PI[playerid][pNumber] = 0;
	PI[playerid][pNumberMoney] = 0;
	PI[playerid][pMetall] = 0;
	PI[playerid][pStartJob] = 0;
	PI[playerid][pJailTime] = 0;
	PI[playerid][pJail] = 0;
	PI[playerid][pVIP] = 0;
	PI[playerid][pDonate] = 0;
	PI[playerid][pPhone] = 0;
	PI[playerid][pPhoneBook] = 0;
	PI[playerid][pSatiety] = 0;
	PI[playerid][pHealthPoints] = 100.0;
	PI[playerid][pArmour] = 100.0;
	PI[playerid][data_MED] = 0;
	PI[playerid][data_SPAWN] = 0;
	PI[playerid][pHospital] = 0;
	PI[playerid][data_JOB] = 0;
	PI[playerid][pHealPack] = 0;
	PI[playerid][pMask] = 0;
	PI[playerid][pMaskWorn] = 0;
	PI[playerid][data_CALL] = -1;
	PI[playerid][data_CLICKTD] = false;
	PI[playerid][data_CLOTHESMENU] = false;
	PI[playerid][pInAutoSalon] = false;
	PI[playerid][pFixPack] = 0;
	PI[playerid][pCanisters] = 0;
	PI[playerid][pSkillPistol] = 0;
	PI[playerid][pSkillSDPistol] = 0;
	PI[playerid][pSkillDeagle] = 0;
	PI[playerid][pSkillShotgun] = 0;
	PI[playerid][pSkillMP5] = 0;
	PI[playerid][pSkillAK47] = 0;
	PI[playerid][pSkillRifle] = 0;
	PI[playerid][pLoadVehicleID] = INVALID_VEHICLE_ID;
	PI[playerid][pHouse] = INVALID_HOUSE_ID;
	PI[playerid][pBusiness] = INVALID_BUSINESS_ID;
	PI[playerid][pFloat] = INVALID_KV_ID;
	PI[playerid][data_PADIK] = INVALID_KV_ID;
	PI[playerid][data_ASH_CAR] = INVALID_VEHICLE_ID;
	PI[playerid][data_CHEK] = 0;
	PI[playerid][data_ASH_TEST] = 0;
	PI[playerid][pAutoSalonCar] = INVALID_VEHICLE_ID;
	PI[playerid][pChangerAutoSalon] = 0;
	PI[playerid][pAutoSalonColor] = 0;
	PI[playerid][pVkontakteID] = 0;
	PI[playerid][pUseAccessory] = 0;
	PI[playerid][pTakeAcs] = 0;
	PI[playerid][pAdminStatus] = 0;
	PI[playerid][pSchoolTestLvl] = 0;
	PI[playerid][pPlayerDetecting] = 0;
	PI[playerid][pOnMP] = 0;
	TimerForPlayer[playerid] = 0;
	FollowBy[playerid] = INVALID_PLAYER_ID;
	PI[playerid][pDeathOnCapture] = 0;

	RegisterNow[playerid] = false;

	SetPVarInt(playerid, "TempFollowBy", -1);
	SetPVarInt(playerid, "anim_load", 1);
	SetPVarInt(playerid, "ChoosingSkin", 0);
}
stock GivePlayerMoneyLog(playerid,amount) 
{
    if(IsPlayerConnected(playerid)) 
	{
	    GivePlayerMoney(playerid,amount);
	    PI[playerid][pMoney] += amount;
        new ctext[20];
	    if(amount < 0) {
	        format(ctext,sizeof(ctext),"%d руб.",amount);
   			SetPlayerChatBubble(playerid, ctext, COLOR_TOMATO, 20.0, 1500);
	    }
	    else {
	        format(ctext,sizeof(ctext),"+%d руб.",amount);
         	SetPlayerChatBubble(playerid, ctext, 0x99ff99FF, 20.0, 1500);
	    }
		UpdatePlayerDataInt(playerid, "Money", PI[playerid][pMoney]);
    }
}
stock RandomEX(min, max) {
	new a = random(max - min) + min;
	return a;
}
stock UpdatePlayerMoney(playerid,amount) 
{
    if(IsPlayerConnected(playerid)) 
	{
	    ResetPlayerMoney(playerid);
	    GivePlayerMoney(playerid,amount);
    }
}

stock GetPlayerMoneyID(playerid) return PI[playerid][pMoney];

stock ResetWeaponAll(playerid) 
{
    ResetPlayerWeapons(playerid);
    for(new s; s != 13; s++) 
	{
        PI[playerid][data_GUN][s] = 0;
        PI[playerid][data_AMMO][s] = 0;
    }
    return 1;
}
stock getWeaponIdSlot(weaponid) {
    switch(weaponid) {
        case 0, 1: return 0;
        case 2..9: return 1;
        case 10..15: return 10;
        case 16..18, 39: return 8;
        case 22..24: return 2;
        case 25..27: return 3;
        case 28, 29, 32: return 4;
        case 30, 31: return 5;
        case 33, 34: return 6;
        case 35..38: return 7;
        case 40: return 12;
        case 41..43: return 9;
        case 44..46: return 11;
    }
    return -1;
}
stock ResetWeaponSlot(playerid, slot) {
    if(!IsPlayerConnected(playerid)) return 0;
    new weapon[13], ammo[13];
    for(new i = 0; i < 13; i++) {
        if(i != slot) {
			weapon[i] = PI[playerid][data_GUN][i];
			ammo[i] = PI[playerid][data_AMMO][i];
		}
    }
    ResetWeaponAll(playerid);
    for(new i = 0; i < 13; i++) if(i != slot) GiveWeapon(playerid, weapon[i], ammo[i]);
    return 1;
}
stock SetWeapon(playerid, gunid, ammo) {
    new slotgunid = getWeaponIdSlot(gunid);
    ResetWeaponSlot(playerid, slotgunid);
    GivePlayerWeapon(playerid, gunid, ammo);
    PI[playerid][data_GUN][slotgunid] = gunid;
    PI[playerid][data_AMMO][slotgunid] = ammo;
    ac_gun[playerid][slotgunid] = 1;
    return 1;
}
stock GiveWeapon(playerid, gunid, ammo) 
{
    new slotgunid = getWeaponIdSlot(gunid);
    GivePlayerWeapon(playerid, gunid, ammo);
    PI[playerid][data_GUN][slotgunid] = gunid;
    PI[playerid][data_AMMO][slotgunid] += ammo;
    ac_gun[playerid][slotgunid] = 1;
    return 1;
}
stock GetPlayerFPS(playerid) 
{
	static 	fps_player_drunk_level[MAX_PLAYERS],
			fps_drunk_level,
			fps_counter;

	if((fps_drunk_level = GetPlayerDrunkLevel(playerid)) < 100) 
	{
		SetPlayerDrunkLevel(playerid, 2000);
	}
	else if(fps_player_drunk_level[playerid] != fps_drunk_level)
	{
		fps_counter = fps_player_drunk_level[playerid] - fps_drunk_level;

		fps_player_drunk_level[playerid] = fps_drunk_level;

		if(0 < fps_counter < 256) 
			return fps_counter - 1;
	}
	return 0;
}
stock SettingSpawn(playerid) 
{	
	TogglePlayerControllable(playerid, true);
	new skin = GetSkinOfPlayer(playerid);

	if(GetPVarInt(playerid, "SpecBool") == 1) 
	{
	    DeletePVar(playerid, "SpecBool");
		SetPlayerPosAC(playerid, GetPVarFloat(playerid,"SpecX"), GetPVarFloat(playerid,"SpecY"), GetPVarFloat(playerid,"SpecZ"));
		SetPlayerFacingAngle(playerid, GetPVarFloat(playerid,"SpecFA"));
		SetPlayerInterior(playerid,GetPVarInt(playerid,"SpecInt"));
		SetPlayerVirtualWorld(playerid,GetPVarInt(playerid,"SpecWorld"));
		SetPlayerVirtualWorld(playerid,0);
		SetPlayerInterior(playerid,0);
		SetSpawnInfoEx(playerid, skin, -256.0461, 469.3669, -29.6109, 180.0);
		return true;
	}
	if(PI[playerid][pDeathOnCapture] == 1)
	{
		if(PI[playerid][pMember] == Command[0]) SetSpawnInfoEx(playerid, skin, 1625.4360,-1214.7052,18.6798,179.2138);
		if(PI[playerid][pMember] == Command[1]) SetSpawnInfoEx(playerid, skin, 1609.8601,-1261.5575,18.6725,359.2748);

		SetPlayerVirtualWorld(playerid, 0);
		SetPlayerInterior(playerid, 0);
		SetPlayerHealthAC(playerid, 176);

		ResetPlayerWeapons(playerid);

		return true;
	}
	if(PI[playerid][pOnMP] == 1)
	{
		printf("%s, %f | %f | %f | %f", getName(playerid), PI[playerid][pHealthPoints], PI[playerid][pOnMPX], PI[playerid][pOnMPY], PI[playerid][pOnMPZ]);
		SetSpawnInfoEx(playerid, skin, PI[playerid][pOnMPX], PI[playerid][pOnMPY], PI[playerid][pOnMPZ], 180.0);
		SetPlayerVirtualWorld(playerid, 0);
		SetPlayerInterior(playerid, 0);
		SetPlayerHealth(playerid, PI[playerid][pHealthPoints]);
		Freeze(playerid);
		return true;
	}
	if(PI[playerid][pJail] > 0) 
	{
		SetSpawnInfoEx(playerid, skin, 147.3188,1889.2491,-31.0747, 180.0);
		SetPlayerVirtualWorld(playerid,1);
		SetPlayerInterior(playerid,1);
		SetPlayerHealth(playerid, 100.00);
		Freeze(playerid);
		return true;
	}
	else if(PI[playerid][pDemorgan] > 0 && PI[playerid][pDemorganTime] > 0)
	{
		SetSpawnInfoEx(playerid, skin, 14.5554,2.1119,1001.2870, 180.0);
		SetPlayerVirtualWorld(playerid,1);
		SetPlayerInterior(playerid,1);
		SetPlayerHealth(playerid, 100.00);
		Freeze(playerid);
		return true;
	}
	if(PI[playerid][pHospital] != 0)
	{
		if(PI[playerid][pHealthPoints] < 5) SetPlayerHealth(playerid, 20), PI[playerid][pHealthPoints] = 20;
		if(PI[playerid][pMember] == 2) 
		{
			SetSpawnInfoEx(playerid, skin, 743.4705,1523.0537,2002.1899, 180.0);
			SetPlayerVirtualWorld(playerid, 5);
			SetPlayerInterior(playerid, 5);
			Freeze(playerid);
		}
		else 
		{
			SetSpawnInfoEx(playerid, skin, 2105.5105, 1456.7489, -47.5200, 359.7946);
			SetPlayerVirtualWorld(playerid, 1);
			SetPlayerInterior(playerid,	RandomEX(1, 4));
			Freeze(playerid);
		}
		return true;
	}
	else
	{
		if(PI[playerid][data_SPAWN] == 0)
		{
			if(PI[playerid][pLevel] >= 1) 
			{
				SetSpawnInfoEx(playerid, skin, 1592.2090,2016.4080,-55.7341,359.1552);
				SetPlayerVirtualWorld(playerid, -1);
				SetPlayerInterior(playerid, -1);
				Freeze(playerid);
				return true;
			}
		}
		if(PI[playerid][data_SPAWN] == 1)
		{
			switch(PI[playerid][pMember])
			{
				case 1:
				{
					SetSpawnInfoEx(playerid, skin, -33.6630,1825.1287,-35.9791, 180.0);
					SetPlayerVirtualWorld(playerid, 1);
					SetPlayerInterior(playerid, 1);
					Freeze(playerid);
					return true;
				}
				case 2:
				{
					SetSpawnInfoEx(playerid, skin, 743.5262,1521.9760,2002.1899, 180.0);
					SetPlayerVirtualWorld(playerid, 1);
					SetPlayerInterior(playerid, 1);
					Freeze(playerid);
					return true;
				}
				case 3:
				{
					SetSpawnInfoEx(playerid, skin, 133.8690,1893.0160,-31.9697, 180.0);
					SetPlayerVirtualWorld(playerid, 1);
					SetPlayerInterior(playerid, 1);
					Freeze(playerid);
					return true;
				}
				case 4:
				{
					SetSpawnInfoEx(playerid, skin, 2072.0264,1508.5125,-47.5053,177.6455);
					SetPlayerVirtualWorld(playerid,1);
					SetPlayerInterior(playerid,1);
					Freeze(playerid);
					return true;
				}
				case 5:
				{
					SetSpawnInfoEx(playerid, skin, -2128.9922,2407.0442,1501.8101, 180.0);
					SetPlayerVirtualWorld(playerid,3);
					SetPlayerInterior(playerid,3);
					Freeze(playerid);
					return true;
				}
				case 6:
				{
					SetSpawnInfoEx(playerid, skin, -2128.9922,2407.0442,1501.8101, 180.0);
					SetPlayerVirtualWorld(playerid,2);
					SetPlayerInterior(playerid,2);
					Freeze(playerid);
					return true;
				}
				case 7:
				{
					SetSpawnInfoEx(playerid, skin, -2128.9922,2407.0442,1501.8101, 180.0);
					SetPlayerVirtualWorld(playerid,1);
					SetPlayerInterior(playerid,1);
					Freeze(playerid);
					return true;
				}
			}
		}
		if(PI[playerid][data_SPAWN] == 2)
		{
			if(PI[playerid][pHouse] == INVALID_HOUSE_ID)
			{
				new kv = PI[playerid][data_PADIK];
				new k = PI[playerid][pFloat];
				SetPVarInt(playerid, "padik",kv);
				SetSpawnInfoEx(playerid, skin, kvData[kv][kvExit_X], kvData[kv][kvExit_Y], kvData[kv][kvExit_Z], kvData[kv][kvExit_A]);
				SetPlayerInterior(playerid,0);
				SetPlayerVirtualWorld(playerid,0);
				Freeze(playerid);
				SCMf(playerid, COLOR_GREEN, "Ваша квартира оплачена на %d дня/дней",kvData[kv][kvDays][k]);
				return true;
			}
			else if(PI[playerid][pFloat] == INVALID_KV_ID)
			{
				new h = PI[playerid][pHouse];
				SetSpawnInfoEx(playerid, skin, HOUSE_DATA[h][data_CARX],HOUSE_DATA[h][data_CARY],HOUSE_DATA[h][data_CARZ], HOUSE_DATA[h][data_CARANGLE]);
				SetPlayerInterior(playerid,0);
				SetPlayerVirtualWorld(playerid,0);
				Freeze(playerid);
				SCMf(playerid, COLOR_GREEN, "Ваш дом оплачен на %d дня/дней",HOUSE_DATA[h][data_DAY]);
				return true;
			}
		}
	}
	for(new i = 0; i < 13; i++) if(PI[playerid][data_GUN][i] != 0 && PI[playerid][data_AMMO][i] != 0) GivePlayerWeapon(playerid, PI[playerid][data_GUN][i], PI[playerid][data_AMMO][i]);
	SetSpawnInfoEx(playerid, skin, 1803.5269,2506.7034,15.8725,308.2673);
	SetPlayerVirtualWorld(playerid, 0);
	SetPlayerInterior(playerid,0);
	//Freeze(playerid);
	return true;
}
stock acc_int_strcat(query[], len, name[], number) {
    new stringer[64];
 	format(stringer, sizeof(stringer), "`%s` = '%d',",name, number);
 	strcat(query, stringer, len);
 	return 1;
}
stock acc_float_strcat(query[], len, name[], Float:number) {
    new stringer[64];
 	format(stringer, sizeof(stringer), "`%s` = '%f',", name, number);
 	strcat(query, stringer, len);
 	return 1;
}
stock acc_str_strcat(query[], len, name[], str[]) {
    new stringer[64];
 	format(stringer, sizeof(stringer), "`%s` = '%e',",name, str);
 	strcat(query, stringer, len);
 	return 1;
}
stock GetFreeSeat(vehicleid) {
	if(!vehicleid) return -1;
	new model = GetVehicleModel(vehicleid);
	new maxs = GetMaxSeat(model) - 1;
	new bool:seat[3],cnt;
	for(new i;i<MAX_PLAYERS;i++) {
		if(!IsPlayerConnected(i) || GetPlayerVehicleID(i) != vehicleid) continue;
		new pseat = GetPlayerVehicleSeat(i);
		if(pseat < 1 || pseat > 3) continue;
		seat[pseat-1] = true;
		cnt++;
		if(cnt >= maxs) return -1;
	}
	for(new i;i<3;i++) if(!seat[i]) return i+1;
	return -1;
}
stock GetMaxSeat(modelid) {
	switch(modelid) {
		case 596..598,427,490: return 4;
		case 599,497,528: return 2;
	}
	return -1;
}
stock SetPlayerSkills(playerid) 
{
	SetPlayerSkillLevel(playerid, WEAPONSKILL_PISTOL, PI[playerid][pSkillPistol]*10);
	SetPlayerSkillLevel(playerid, WEAPONSKILL_PISTOL_SILENCED, PI[playerid][pSkillSDPistol]*10);
	SetPlayerSkillLevel(playerid, WEAPONSKILL_DESERT_EAGLE, PI[playerid][pSkillDeagle]*10);
	SetPlayerSkillLevel(playerid, WEAPONSKILL_SHOTGUN, PI[playerid][pSkillShotgun]*10);
	SetPlayerSkillLevel(playerid, WEAPONSKILL_MP5, PI[playerid][pSkillMP5]*10);
	SetPlayerSkillLevel(playerid, WEAPONSKILL_AK47, PI[playerid][pSkillAK47]*10);
	SetPlayerSkillLevel(playerid, WEAPONSKILL_SNIPERRIFLE, PI[playerid][pSkillRifle]*10);
    return 1;
}
stock AddHouse(playerid) 
{
    new h = TotalHouses;
    new Float:a1 = GetPVarFloat(playerid, "aEnterX");
    new Float:a2 = GetPVarFloat(playerid, "aEnterY");
    new Float:a3 = GetPVarFloat(playerid, "aEnterZ");
    new Float:a4 = GetPVarFloat(playerid, "aExitX");
    new Float:a5 = GetPVarFloat(playerid, "aExitY");
    new Float:a6 = GetPVarFloat(playerid, "aExitZ");
    new a7 = GetPVarInt(playerid, "aInt");
    new a8 = GetPVarInt(playerid, "aClass");
    new a9 = GetPVarInt(playerid, "aPrice");
    new Float:a10 = GetPVarFloat(playerid, "aCarX");
    new Float:a11 = GetPVarFloat(playerid, "aCarY");
    new Float:a12 = GetPVarFloat(playerid, "aCarZ");
    new Float:a13 = GetPVarFloat(playerid, "aCarAngle");
    SetPVarInt(playerid,"addhouse", 0);
    SCM(playerid, COLOR_HINT, !"[Подсказка]: {FFFFFF}Дом был успешно добавлен!");
    HOUSE_DATA[h][data_ENTERX] = a1;
    HOUSE_DATA[h][data_ENTERY] = a2;
    HOUSE_DATA[h][data_ENTERZ] = a3;
    HOUSE_DATA[h][data_EXITX] = a4;
    HOUSE_DATA[h][data_EXITY] = a5;
    HOUSE_DATA[h][data_EXITZ] = a6;
    HOUSE_DATA[h][data_INT] = a7;
    HOUSE_DATA[h][data_CLASS] = a8;
    HOUSE_DATA[h][data_PRICE] = a9;
    HOUSE_DATA[h][data_CARX] = a10;
    HOUSE_DATA[h][data_CARY] = a11;
    HOUSE_DATA[h][data_CARZ] = a12;
    HOUSE_DATA[h][data_CARANGLE] = a13;
    if(HOUSE_DATA[h][data_OWNED] == 0) {
		HOUSE_DATA[h][data_PICKUPENTER] = CreateDynamicPickup(1273, 23, HOUSE_DATA[h][data_ENTERX], HOUSE_DATA[h][data_ENTERY], HOUSE_DATA[h][data_ENTERZ],-1);
		HOUSE_DATA[h][data_MAPICON] = CreateDynamicMapIcon(HOUSE_DATA[h][data_ENTERX], HOUSE_DATA[h][data_ENTERY], HOUSE_DATA[h][data_ENTERZ], 31, -1, 0, -1, -1, 200.0);
	}
	else {
		HOUSE_DATA[h][data_PICKUPENTER] = CreateDynamicPickup(19131, 23, HOUSE_DATA[h][data_ENTERX], HOUSE_DATA[h][data_ENTERY], HOUSE_DATA[h][data_ENTERZ],0);
		HOUSE_DATA[h][data_MAPICON] = CreateDynamicMapIcon(HOUSE_DATA[h][data_ENTERX], HOUSE_DATA[h][data_ENTERY], HOUSE_DATA[h][data_ENTERZ], 32, -1, 0, -1, -1, 200.0);
	}
	TotalHouses++;
   	mysql_string[0] = EOS, mf(mysql, mysql_string, 350, "INSERT INTO `houses` ( `enterx`, `entery`, `enterz`, `exitx`, `exity`, `exitz`, `carx`, `cary`, `carz`, `cara`, `int`, `class`, `price`) VALUES ( '%f', '%f', '%f', '%f', '%f', '%f', '%f', '%f', '%f', '%f', '%d', '%d', '%d')",a1,a2,a3,a4,a5,a6,a10,a11,a12,a13,a7,a8,a9);
    mysql_function_query(mysql, mysql_string, false, "", "");
	return 1;
}
stock IsPlayerCops(playerid) 
{
	switch(PI[playerid][pMember]) 
	{
 		case 3: return 1;
	}
	return 0;
}
stock IsPlayerOPG(playerid) {
	switch(PI[playerid][pMember]) {
	    case 5,6,7: return 1;
	}
	return 0;
}
stock PlayerToPoint(Float:radi, playerid, Float:x, Float:y, Float:z) {
	if(IsPlayerConnected(playerid))
	{
		new Float:oldposx, Float:oldposy, Float:oldposz;
		new Float:tempposx, Float:tempposy, Float:tempposz;
		GetPlayerPos(playerid, oldposx, oldposy, oldposz);
		tempposx = (oldposx -x);
		tempposy = (oldposy -y);
		tempposz = (oldposz -z);
		if (((tempposx < radi) && (tempposx > -radi)) && ((tempposy < radi) && (tempposy > -radi)) && ((tempposz < radi) && (tempposz > -radi))) return 1;
	}
	return 0;
}
stock SendDepMessage(color, text[]) 
{
 	for(new i = 0; i < MAX_PLAYERS; i++) 
	{
	    if(!IsPlayerConnected(i)) continue;
		switch(PI[i][pMember]) {
		    case 1,2,3,4,8,9: SCM(i, color, text);
		}
	}
	return 1;
}
stock SetPlayerColorEx(playerid) 
{
	new M = PI[playerid][pMember];
    SetPlayerColor(playerid, PLAYER_COLOR_TEAM[M]);
	return PLAYER_COLOR_TEAM[M];
}
stock SetPlayerHealthAC(playerid, Float: Health) 
{
    PI[playerid][pHealthPoints] = Health;
    SetPlayerHealth(playerid, Health);
}
stock SetPlayerArmourAC(playerid, Float: Armour) 
{
    PI[playerid][pArmour] = Armour;
    SetPlayerArmour(playerid, Armour);
}
CMD:givemetall(playerid,params[]) 
{
    if(PI[playerid][pLevel] < 2) return SCM(playerid, COLOR_GREY, !"Данную команду можно использовать только со 2 уровня");
	if(sscanf(params, "ud", params[0],params[1])) return SCM(playerid, COLOR_LIGHTGREY, !"Используйте: /givemetall [ID игрока] [кол-во]");
	if(!IsPlayerConnected(params[0])) return SCM(playerid, COLOR_GREY, !"Данного ID нет на сервере");
	if(!IsPlayerLogged{params[0]}) return SCM(playerid, COLOR_GREY, !"Данный игрок не прошел авторизацию");
	if(playerid == params[0]) return SCM(playerid, COLOR_GREY, !"Нельзя передавать самому себе");
	new Float:x,Float:y,Float:z,str[145];
	GetPlayerPos(params[0],x,y,z);
	if(!PlayerToPoint(3.0, playerid, x,y,z)) return SCM(playerid, COLOR_GREY, !"Игрок находится слишком далеко");
	if(params[1] <= 0) return SCM(playerid, COLOR_GREY, !"Недопустимое значение");
	if(params[1] > 80) return SCM(playerid, COLOR_GREY, !"Разрешено передавать не более 80 металла за один раз");
	if(PI[playerid][pMetall] < params[1]) return SCM(playerid, COLOR_GREY, !"У Вас недостаточно металла на руках");

	GivePlayerMetall(playerid, -params[1]);
	GivePlayerMetall(params[0], params[1]);
	
	SCMf(playerid, COLOR_GREEN, "Вы передали %s[%d] %d кг металла", getName(params[0]), params[0], params[1]);
	SCMf(playerid, COLOR_GREEN, "Игрок %s[%d] передал Вам %d кг металла",PI[playerid][pName], playerid, params[1]);
	format(str,sizeof(str),"%s передал(а) металл %s",PI[playerid][pName], getName(params[0]));
    ProxDetector(30.0, playerid, str,0xFF99CCFF,0xFF99CCFF,0xFF99CCFF,0xFF99CCFF,0xFF99CCFF);
    SetPlayerChatBubble(playerid, "Передал(а) металл", 0xFF99CCFF, 20.0, 4000);
	return 1;
}
alias::report("rep");
alias:menu("mm", "mn", "mainmenu");
CMD:report(playerid) return ReportDialog(playerid);
CMD:menu(playerid) return ShowMainMenu(playerid);
cmd:info(playerid) return ShowDialogResurs(playerid);

CMD:hi(playerid,params[]) 
{
    if(sscanf(params,"u",params[0])) return SCM(playerid, COLOR_LIGHTGREY, !"Используйте: /hi [ID игрока]");
	if(!IsPlayerConnected(params[0]))return SCM(playerid, COLOR_GREY, !"Игрок не в сети");
	if(!IsPlayerLogged{params[0]})return SCM(playerid, COLOR_GREY, !"Игрок не авторизован");
	if(playerid == params[0]) return 1;
	if(!ProxDetectorS(3.0, playerid, params[0])) return SCM(playerid, COLOR_GREY, !"Данный игрок слишком далеко от Вас");
	return SendRequestForPlayer(playerid, params[0], 0);
}
CMD:s(playerid, params[]) // +
{
    if(PI[playerid][pMute] == 1) return SCM(playerid, COLOR_GREY, !"Ваш чат временно заблокирован");
	if(sscanf(params,"s[80]",params[0])) return SCM(playerid, COLOR_LIGHTGREY, !"Используйте: /s [текст]");
    NotReklama(playerid, params[0]);
    global_str[0] = EOS; f(global_str, 150, "%s[%d] крикнул: %s",getName(playerid),playerid,params[0]);
	ProxDetector(50.0, playerid, global_str, -1, -1, -1, -1, -1);
	SetPlayerChatBubblef(playerid, -1, 20.0, 4000, "%s", params[0]);
	if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT) ApplyAnimation(playerid,"ON_LOOKERS","shout_01",1000.0,0,0,0,0,0,1);
	return 1;
}
CMD:me(playerid,params[]) // +
{
    if(PI[playerid][pMute] == 1) return SCM(playerid, COLOR_GREY, !"Ваш чат временно заблокирован");
	if(sscanf(params,"s[80]",params[0])) return SCM(playerid, COLOR_LIGHTGREY, !"Используйте: /me [текст]");
    NotReklama(playerid, params[0]);
	global_str[0] = EOS, f(global_str, 150, "%s %s",getName(playerid), params[0]);
	ProxDetector(30.0, playerid, global_str, 0xFF99CCFF, 0xFF99CCFF, 0xFF99CCFF, 0xFF99CCFF, 0xFF99CCFF);
	SetPlayerChatBubblef(playerid, 0xFF99CCFF, 20.0, 4000, "%s %s", getName(playerid), params[0]);
	return 1;
}
CMD:todo(playerid, params[]) // +
{
    new text[40], text2[40];
    if(PI[playerid][pMute] == 1) return SCM(playerid, COLOR_GREY, !"Ваш чат временно заблокирован");
    if(sscanf(params,"s[80]",params[0])) return SCM(playerid, COLOR_LIGHTGREY, !"/todo [Сообщение]*[Действие]");
	f(text2, sizeof(text2), "\"%s\", - сказал %s,{FF99FF} %s.",text, getName(playerid), text2);
    return ProxDetector(30.0, playerid, text2, 0xFF99CCFF, 0xFF99CCFF, 0xFF99CCFF, 0xFF99CCFF, 0xFF99CCFF);
}
CMD:do(playerid,params[]) // +
{
    if(PI[playerid][pMute] == 1) return SCM(playerid, COLOR_GREY, !"Ваш чат временно заблокирован");
	if(sscanf(params,"s[80]",params[0])) return SCM(playerid, COLOR_LIGHTGREY, !"Используйте: /do [текст]");
    NotReklama(playerid, params[0]);
    format(global_str, 140, "%s (%s)",params[0], getName(playerid));
	ProxDetector(30.0, playerid, global_str, 0xFF99CCFF, 0xFF99CCFF, 0xFF99CCFF, 0xFF99CCFF, 0xFF99CCFF);
	return SetPlayerChatBubble(playerid, params, 0xFF99CCFF, 20.0, 5000);
}
CMD:b(playerid,params[]) // +
{
    if(PI[playerid][pMute] == 1) return SCM(playerid, COLOR_GREY, !"Ваш чат временно заблокирован");
	if(sscanf(params,"s[80]",params[0])) return SCM(playerid, COLOR_LIGHTGREY, !"Используйте: /b [OOC (nonRP) сообщение]");
    NotReklama(playerid, params[0]);
    format(global_str, 140, "(( %s[%d]: %s ))", getName(playerid),playerid,params[0]);
	ProxDetector(30.0, playerid, global_str, 0xAFAFAFAA, 0xAFAFAFAA, 0xAFAFAFAA, 0xAFAFAFAA, 0xAFAFAFAA);
	return SetPlayerChatBubble(playerid, params, 0xAFAFAFAA, 35.0, 4000);
}
alias:b("n");
CMD:try(playerid,params[]) // +
{
    if(PI[playerid][pMute] == 1) return SCM(playerid, COLOR_GREY, !"Ваш чат временно заблокирован");
	if(sscanf(params,"s[80]",params[0])) return SCM(playerid, COLOR_LIGHTGREY, !"Используйте: /try [текст]");
    NotReklama(playerid, params[0]);

	switch random(10) do
	{
		case 0..4: f(global_str, 150, "%s %s {26A65B}(удачно)", getName(playerid), params[0]);
    	case 5..9: f(global_str, 150, "%s %s {EF4836}(неудачно)", getName(playerid), params[0]);
	}

	ProxDetector(30.0, playerid, global_str, 0xFF99CCFF, 0xFF99CCFF, 0xFF99CCFF, 0xFF99CCFF, 0xFF99CCFF);
	return SetPlayerChatBubble(playerid, params, 0xFF99CCFF, 20.0, 5000);
}
CMD:pay(playerid,params[]) 
{
	if(PI[playerid][pLevel] < 2) return SCM(playerid, COLOR_GREY, !"Данную команду можно использовать со 2 уровня");
	if(sscanf(params, "ud", params[0],params[1])) return SCM(playerid, COLOR_LIGHTGREY, !"Используйте: /pay [ID игрока] [кол-во]");
	if(!IsPlayerConnected(params[0])) return SCM(playerid, COLOR_GREY, !"Игрок не в сети");
	if(!IsPlayerLogged{params[0]}) return SCM(playerid, COLOR_GREY, !"Игрок не авторизован");
	if(playerid == params[0]) return SCM(playerid, COLOR_GREY, !"Нельзя передать деньги самому себе");
    if(GetPVarInt(playerid,"Counting_pay") > gettime()) return SCM(playerid, COLOR_GREY, !"Команду можно использовать раз в 15 секунд");
    SetPVarInt(playerid,"Counting_pay",gettime() + 15);
	if(!ProxDetectorS(3.0, playerid, params[0])) return SCM(playerid, COLOR_GREY, !"Данный игрок от Вас");
	if(params[1] <= 0) return SCM(playerid, COLOR_GREY, !"Недопустимое значение");
	if(params[1] > 3000) return SCM(playerid, COLOR_GREY, !"Разрешено передавать не более 3000 рублей за один раз");
	if(GetPlayerMoneyID(playerid) < params[1]) return SCM(playerid, COLOR_GREY, !"У Вас недостаточно денег на руках");
	GivePlayerMoneyLog(playerid,-params[1]);
	GivePlayerMoneyLog(params[0],params[1]);
	new str2[70],str1[70],pay[20],pay1[20];
	format(str2,sizeof(str2),"Передача денег %s[%d]",getName(params[0]),params[0]);
	format(str1,sizeof(str1),"Получено денег от %s[%d]",getName(playerid),playerid);
	format(pay,sizeof(pay),"-%dР",params[1]);
	format(pay1,sizeof(pay1),"+%dР",params[1]);
	cef_emit_event(playerid, "show-notify-no-img", CEFSTR(str2), CEFSTR("fb4949"), CEFSTR(pay));
	cef_emit_event(params[0], "show-notify-no-img", CEFSTR(str1), CEFSTR("418055"), CEFSTR(pay1));
	return 1;
}
CMD:eject(playerid,params[]) 
{
	if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER) return SCM(playerid, COLOR_GREY, !"Вы не за рулем");
	if(sscanf(params,"d",params[0])) return SCM(playerid, COLOR_LIGHTGREY, !"Используйте: /eject [ID игрока]");
	if(!IsPlayerConnected(params[0]))return  SCM(playerid, COLOR_GREY, !"Игрок не в сети");
	if(!IsPlayerLogged{params[0]})return  SCM(playerid, COLOR_GREY, !"Игрок не авторизован");
	if(params[0] == playerid) return SCM(playerid, COLOR_GREY, !"Вы не можете выкинуть из машины самого себя");
    new car = GetPlayerVehicleID(playerid);
	new idcar = GetPlayerVehicleID(params[0]);
	if(!IsPlayerInVehicle(playerid,car)) return 1;
	if(car != idcar) return SCM(playerid, COLOR_GREY, !"Данный игрок не находиться в Вашей машине");
	RemovePlayerFromVehicleAC(params[0]);
	SCMf(playerid,0xFF9999FF, "%s был выброшен из автомобиля",getName(params[0]));
	HidePlayerSpeedometer(params[0]);
	return SCM(params[0],0xFF9999FF,"Вас выбросили из автомобиля");
}
CMD:card(playerid,params[]) 
{
    if(PI[playerid][pMedCard] == 0) return SCM(playerid, COLOR_GREY, !"У Вас нет медицинской карты, получить её можно в здании БЦРБ.");
    if(sscanf(params, "u", params[0])) 
	{
		return ShowPlayerDialogf(playerid, 0, DIALOG_STYLE_LIST, !"{ee3366}Лицензии", "Закрыть", "", "\
		{FFFFFF}ЦРБ птг. Батырево: \t\tДокумент №%d\n\
		{FFFFFF}Гражданин РФ\t\t\t{3377cc}%s\n\
		{FFFFFF}Анализы\t\t\tПройдены\n\
		{FFFFFF}Физическое состояние\tНормальное\n\
		{FFFFFF}Зависимость\t\t\tНет", PI[playerid][data_MEDNUM], getName(playerid));
	}
	if(!IsPlayerConnected(params[0])) return SCM(playerid, COLOR_LIGHTGREY, !"Используйте: /card [ид игрока]");
	if(!IsPlayerLogged{params[0]}) return SCM(playerid, COLOR_GREY, !"Игрок не авторизован");
	if(!ProxDetectorS(10.0, playerid, params[0])) return SCM(playerid, COLOR_GREY, !"Игрок слишком далеко от Вас");
	return SendRequestForPlayer(playerid, params[0], 5);
}
CMD:vb(playerid,params[]) 
{
	if(sscanf(params, "u", params[0])) 
	{
		return ShowPlayerDialogf(playerid, 0, DIALOG_STYLE_MSGBOX, !"{ee3366}Военный билет", !"Закрыть", !"", \
		"{FFFFFF}Войсковая часть г. Батырево\n\
		Гражданин РФ: {3377cc}%s\n\
		{FFFFFF}Военный билет: %s", getName(playerid), (PI[playerid][pMilitaryID]) ? ("есть") : ("нету"));
	}
	if(!IsPlayerConnected(params[0])) return SCM(playerid, COLOR_LIGHTGREY, !"Используйте: /vb [ид игрока]");
	if(!IsPlayerLogged{params[0]}) return SCM(playerid, COLOR_GREY, !"Игрок не авторизован");
	if(!ProxDetectorS(10.0, playerid, params[0])) return SCM(playerid, COLOR_GREY, !"Игрок слишком далеко от Вас");
	return SendRequestForPlayer(playerid, params[0], 6);
}
CMD:lic(playerid,params[]) 
{
    if(sscanf(params, "u", params[0])) 
	{
		return ShowPlayerDialogf(playerid, 0, DIALOG_STYLE_LIST, "{ee3366}Лицензии", "Закрыть", "", "\
		Автошкола птг. Батырево: \tДокумент №%d\n\
		Гражданин РФ\t\t\t{3377cc}%s\n\
		{FFFFFF}Водительские права: \t\t\t%s\n\
		{FFFFFF}Лицензия на оружие: \t\t\t%s", 
			PI[playerid][pLicNumber], 
			getName(playerid), 
			PI[playerid][pDriveLicense] ? "{FF6347}-" : "{24ff78}+", 
			PI[playerid][pGunLicense] ? "{FF6347}-" : "{24ff78}+");
	}
	if(!IsPlayerConnected(params[0])) return SCM(playerid, COLOR_LIGHTGREY, !"Используйте: /lic [ид игрока]");
	if(!IsPlayerLogged{params[0]}) return SCM(playerid, COLOR_GREY, !"Игрок не авторизован");
	if(!ProxDetectorS(10.0, playerid, params[0])) return SCM(playerid, COLOR_GREY, !"Игрок слишком далеко от Вас");
	return SendRequestForPlayer(playerid, params[0], 4);
}
CMD:dice(playerid,params[]) 
{
    if(sscanf(params, "ud", params[0],params[1])) return SCM(playerid, COLOR_LIGHTGREY, !"Используйте: /dice [ID игрока] [сумма]");
    if(params[0] == playerid) return SCM(playerid, COLOR_GREY, !"Нельзя использовать на самом себе");
	if(!IsPlayerConnected(params[0])) return SCM(playerid, COLOR_GREY, !"Игрок не в сети");
	if(!IsPlayerLogged{params[0]}) return SCM(playerid, COLOR_GREY, !"Игрок не авторизован");
	if(params[1] < 1000 || params[1] > 100000000) return SCM(playerid, COLOR_GREY, !"Сумма ставки должна быть от 1000 до 100000000 рублей");
	if(GetPlayerMoneyID(playerid) < params[1]) return SCM(playerid, COLOR_GREY, !"У Вас недостаточно денег на руках");
    if(GetPlayerMoneyID(params[0]) < params[1]) return SCM(playerid, COLOR_GREY, !"У игрока недостаточно денег на руках");
	new Float:x, Float:y, Float:z;
	GetPlayerPos(params[0], x, y, z);
	if(!ProxDetectorS(10.0, playerid, params[0])) return SCM(playerid, COLOR_GREY, !"Игрок находится слишком далеко");
    if(!PlayerToPoint(30.0, playerid, 597.6772, -118.6722, 728.1455)) return SCM(playerid, COLOR_GREY, !"Нужно находиться в казино");
	return SendRequestForPlayer(playerid, params[0], 11, params[1]);
}
CMD:pass(playerid,params[]) 
{
    if(sscanf(params, "u", params[0])) return SCM(playerid, COLOR_LIGHTGREY, !"Используйте: /pass [ID игрока]");
	if(!IsPlayerConnected(params[0])) return SCM(playerid, COLOR_GREY, !"Игрок не в сети");
	if(!IsPlayerLogged{params[0]}) return SCM(playerid, COLOR_GREY, !"Игрок не авторизован");
	new Float:x, Float:y, Float:z;
	GetPlayerPos(params[0], x, y, z);
	if(!ProxDetectorS(10.0, playerid, params[0])) return SCM(playerid, COLOR_GREY, !"Игрок находится слишком далеко");
	return SendRequestForPlayer(playerid, params[0], 3);
}
CMD:skill(playerid,params[]) 
{
    if(sscanf(params, "u", params[0])) 
	{
		ShowPlayerDialogf(playerid, 0, DIALOG_STYLE_LIST, !"{ee3366}Навыки владения оружием", !"Закрыть", !"",\
			"1. ТТ:\t\t\t%d %%\n\
			2. Тайзер:\t\t%d %%\n\
			3. ПЛ-15:\t\t%d %%\n\
			4. Дробовик:\t\t%d %%\n\
			5. MP5:\t\t\t%d %%\n\
			6. AK-47:\t\t%d %%",
				PI[playerid][pSkillPistol],
				PI[playerid][pSkillSDPistol],
				PI[playerid][pSkillDeagle],
				PI[playerid][pSkillShotgun],
				PI[playerid][pSkillMP5],
				PI[playerid][pSkillAK47]);
  		return SetPlayerChatBubble(playerid, "просматривает навыки владения оружием", 0xFF99CCFF, 20.0, 4000);
	}
	if(!IsPlayerConnected(params[0])) return SCM(playerid, COLOR_GREY, !"Игрок не в сети");
	if(!IsPlayerLogged{params[0]}) return SCM(playerid, COLOR_GREY, !"Игрок не авторизован");
	new Float:x,Float:y,Float:z;
	GetPlayerPos(params[0],x,y,z);
	if(!PlayerToPoint(10.0, playerid, x,y,z)) return SCM(playerid, COLOR_GREY, !"Игрок находится слишком далеко");
	return SendRequestForPlayer(playerid, params[0], 7);
}
CMD:invite(playerid,params[]) 
{
	if(PI[playerid][pRang] < 9) return SCM(playerid, COLOR_GREY, !"Данная команда Вам недоступна");
	if(sscanf(params,"u",params[0])) return SCM(playerid, COLOR_LIGHTGREY, !"Используйте: /invite [ID игрока]");

	SetPVarInt(playerid, "Invite", params[0]);
	
	mysql_string[0] = EOS, f(mysql_string, 110, "SELECT * FROM `fractions_blacklist` WHERE bl_name = '%e' AND bl_fraction = '%d'", getName(params[0]), PI[playerid][pMember]);
	mysql_tquery(mysql, mysql_string, "CheckBlackListInvite", "d", playerid);
	return 1;
}
CMD:leave(playerid,params[]) 
{
    if(PI[playerid][pVIP] < 1) return SCM(playerid, COLOR_GREY, !"Данная функция доступна только VIP игрокам");
	if(PI[playerid][pMember] == 0) return SCM(playerid, COLOR_GREY, !"Вы не состоите в организации");
	if(PI[playerid][pLeader] != 0) return SCM(playerid, COLOR_GREY, !"Для снятия с должности лидера по собственному желанию обратитесь к следящим");
	ShowPlayerDialog(playerid, 7214, DIALOG_STYLE_MSGBOX, !"{ee3366}Увольнение", "Вы действительно хотите уволиться из организации по собственному желанию?\n{696969}Обратите внимание: информация о Вашем уходе будет видна в чате организации", "Да", "Нет");
	return 1;
}
CMD:setskin(playerid,params[]) 
{
	if(PI[playerid][pRang] < 9) return SCM(playerid, COLOR_GREY, !"Данная команда Вам недоступна");
	if(sscanf(params,"u",params[0])) return SCM(playerid, COLOR_LIGHTGREY, !"Используйте: /setskin [ID игрока]");
	if(!IsPlayerConnected(params[0]))return  SCM(playerid, COLOR_GREY, !"Игрок не в сети");
	if(!IsPlayerLogged{params[0]}) return SCM(playerid, COLOR_GREY, !"Игрок не авторизован");
	if(PI[params[0]][pMember] == 0) return SCM(playerid, COLOR_GREY, !"Данный игрок не состоит в Вашей организации");
	if(PI[playerid][pMember] != PI[params[0]][pMember]) return SCM(playerid, COLOR_GREY, !"Данный игрок не состоит в Вашей организации");
	if(PI[params[0]][pLeader] != 0) return SCM(playerid, COLOR_GREY, !"Нельзя применить к лидеру");
	SetPVarInt(playerid,"gPLAYER",params[0]);
	if(PI[playerid][pSex] == 1) 
	{
		switch(PI[playerid][pMember]) 
		{
			case 1: ShowPlayerDialog(playerid, dialog_SETSKIN, DIALOG_STYLE_TABLIST_HEADERS, "{ee3366}Выберете форму одежды", "Номер\t\tID Скина\n1\t\t\t156\n2\t\t154\n3\t\t208\n4\t\t155\n5\t\t147\n6\t\t187", "Выбрать", "Отмена");
			case 2: ShowPlayerDialog(playerid, dialog_SETSKIN, DIALOG_STYLE_TABLIST_HEADERS, "{ee3366}Выберете форму одежды", "Номер\t\tID Скина\n1\t\t\t179\n2\t\t262\n3\t\t253\n4\t\t283\n5\t\t167\n6\t\t277\n7\t\t278\n8\t\t279\n9\t\t188\n10\t\t222\n11\t\t255\n\t\t84", "Выбрать", "Отмена");
			case 3: 
			{
				ShowPlayerDialog(playerid, dialog_SETSKIN, DIALOG_STYLE_TABLIST_HEADERS, 
				!"{ee3366}Выберете форму одежды", 
				!"Номер\t\tID Скина\n\
				1\t\t\t280\n\
				2\t\t281\n\
				3\t\t282\n\
				4\t\t285\n\
				5\t\t286\n\
				6\t\t288\n\
				7\t\t220\n\
				8\t\t284", "Выбрать", "Отмена");
			}
			case 4: ShowPlayerDialog(playerid, dialog_SETSKIN, DIALOG_STYLE_TABLIST_HEADERS, "{ee3366}Выберете форму одежды", "Номер\t\tID Скина\n1\t\t\t276\n2\t\t71\n3\t\t275\n4\t\t70", "Выбрать", "Отмена");
			case 5: ShowPlayerDialog(playerid, dialog_SETSKIN, DIALOG_STYLE_TABLIST_HEADERS, "{ee3366}Выберете форму одежды", "Группа и Номер\t\tID Скина\n[1-4 ранг]\t\t\t8\n[5-7 ранг]\t\t17\n[Стрелковый состав 1-7 ранг]\t\t28\n[8-9 ранг]\t\t126\n[10 ранг]\t\t117", "Выбрать", "Отмена");
			case 6: ShowPlayerDialog(playerid, dialog_SETSKIN, DIALOG_STYLE_TABLIST_HEADERS, "{ee3366}Выберете форму одежды", "Группа и Номер\t\tID Скина\n[1-4 ранг]\t\t\t115\n[5-7 ранг]\t\t116\n[Стрелковый состав 1-7 ранг]\t\t114\n[8-9 ранг]\t\t111\n[10 ранг]\t\t236", "Выбрать", "Отмена");
			case 7: ShowPlayerDialog(playerid, dialog_SETSKIN, DIALOG_STYLE_TABLIST_HEADERS, "{ee3366}Выберете форму одежды", "Группа и Номер\t\tID Скина\n[1-4 ранг]\t\t\t123\n[5-7 ранг]\t\t122\n[Стрелковый состав 1-7 ранг]\t\t109\n[8-9 ранг]\t\t108\n[10 ранг]\t\t118", "Выбрать", "Отмена");
			case 8: ShowPlayerDialog(playerid, dialog_SETSKIN, DIALOG_STYLE_TABLIST_HEADERS, "{ee3366}Выберете форму одежды", "Номер\t\tID Скина\n1\t\t\t15\n2\t\t17\n3\t\t23", "Выбрать", "Отмена");
		}
	}
	if(PI[playerid][pSex] == 2) 
	{
		switch(PI[playerid][pMember]) 
		{
			case 1: ShowPlayerDialog(playerid, dialog_SETSKINDEV, DIALOG_STYLE_TABLIST_HEADERS, "{ee3366}Выберете форму одежды", "Номер\t\tID Скина\n1\t\t\t216", "Выбрать", "Отмена");
			case 2: ShowPlayerDialog(playerid, dialog_SETSKINDEV, DIALOG_STYLE_TABLIST_HEADERS, "{ee3366}Выберете форму одежды", "Номер\t\tID Скина\n1\t\t\t191", "Выбрать", "Отмена");
			case 3:ShowPlayerDialog(playerid, dialog_SETSKINDEV, DIALOG_STYLE_TABLIST_HEADERS, "{ee3366}Выберете форму одежды", "Номер\t\tID Скина\n1\t\t\t141", "Выбрать", "Отмена");
			case 4: ShowPlayerDialog(playerid, dialog_SETSKINDEV, DIALOG_STYLE_TABLIST_HEADERS, "{ee3366}Выберете форму одежды", "Номер\t\tID Скина\n1\t\t\t194", "Выбрать", "Отмена");
			case 5: ShowPlayerDialog(playerid, dialog_SETSKINDEV, DIALOG_STYLE_TABLIST_HEADERS, "{ee3366}Выберете форму одежды", "Номер\t\tID Скина\n1\t\t\t13", "Выбрать", "Отмена");
			case 6: ShowPlayerDialog(playerid, dialog_SETSKINDEV, DIALOG_STYLE_TABLIST_HEADERS, "{ee3366}Выберете форму одежды", "Номер\t\tID Скина\n1\t\t\t13", "Выбрать", "Отмена");
			case 7: ShowPlayerDialog(playerid, dialog_SETSKINDEV, DIALOG_STYLE_TABLIST_HEADERS, "{ee3366}Выберете форму одежды", "Номер\t\tID Скина\n1\t\t\t13", "Выбрать", "Отмена");
			case 8: ShowPlayerDialog(playerid, dialog_SETSKINDEV, DIALOG_STYLE_TABLIST_HEADERS, "{ee3366}Выберете форму одежды", "Номер\t\tID Скина\n1\t\t\t12", "Выбрать", "Отмена");
		}
	}
	return 1;
}
stock open_gov(playerid) 
{
	return ShowPlayerDialog(playerid, 7515, DIALOG_STYLE_LIST, !"{ee3366}Государственная волна", !"{FFFF99}1. Запланировать за 30 минут\n\
	{FFFF99}2. Запланировать за 15 минут\n\
	{FFFF99}3. Запланировать за 5 минут\n\
 	{FFFF99}4. Начать собеседование/призыв\n\
	{FFFF99}5. Продолжить собеседование/призыв\n\
	{FFFF99}6. Закончить собеседование/призыв\n\
	{FFFF99}7. Отменить собеседование/призыв", !"Выбрать", !"Отмена");
}
stock open_govvh(playerid) 
{
	return ShowPlayerDialog(playerid, 7788, DIALOG_STYLE_LIST, !"{ee3366}Государственная волна", !"{FFFF99}1. Запланировать за 30 минут\n\
	{FFFF99}2. Запланировать за 15 минут\n\
	{FFFF99}3. Запланировать за 5 минут\n\
 	{FFFF99}4. Начать собеседование/призыв\n\
	{FFFF99}5. Продолжить призыв\n\
	{FFFF99}6. Закончить призыв\n\
	{FFFF99}7. Отменить призыв", !"Выбрать", !"Отмена");
}
cmd:gov(playerid) 
{
    if(PI[playerid][pMute] == 1) return SCM(playerid, COLOR_GREY, !"Ваш чат временно заблокирован");
	if(PI[playerid][pRang] < 9) return SCM(playerid, COLOR_GREY, !"Данная команда Вам недоступна");
	if(PI[playerid][pMember] == 5 || PI[playerid][pMember] == 6 || PI[playerid][pMember] == 7) return SCM(playerid, COLOR_GREY, !"Данная команда Вам недоступна");
    if(PI[playerid][pMember] == 1) open_gov(playerid);
    if(PI[playerid][pMember] == 2) open_govvh(playerid);
    if(PI[playerid][pMember] == 3) open_gov(playerid);
    if(PI[playerid][pMember] == 4) open_gov(playerid);
    return 1;
}

CMD:dd(playerid,params[])
{
	if(PI[playerid][pMember] == 5 || PI[playerid][pMember] == 6 || PI[playerid][pMember] == 7 || PI[playerid][pMember] == 0) return  SCM(playerid, COLOR_GREY, !"Вы не состоите во организации");
    if(PI[playerid][pMute] == 1) return SCM(playerid, COLOR_GREY, !"Ваш чат временно заблокирован");
	if(sscanf(params,"s[32]",params[0])) return SCM(playerid, COLOR_LIGHTGREY, !"Используйте: /dd [текст]");
    NotReklama(playerid, params[0]);
    SendDepMessagef(0xFF8282FF, "(( [D | %s] %s %s[%d]: %s ))", PI[playerid][pGroupName], NameRang(playerid), getName(playerid),playerid,params[0]);
    return 1;
}
CMD:r(playerid,params[])
{
    if(PI[playerid][pMute] == 1) return SCM(playerid, COLOR_GREY, !"Ваш чат временно заблокирован");
	if(PI[playerid][pMember] == 0) return SCM(playerid, COLOR_GREY, !"Данная команда Вам недоступна");
	if(sscanf(params,"s[100]",params[0])) return SCM(playerid, COLOR_LIGHTGREY, !"Используйте: /r [текст]");
	NotReklama(playerid, params[0]);
	if(PI[playerid][pGroupID] != -1) SendFractionMessagef(PI[playerid][pMember], 0x69b867FF, "[R | %s] %s %s[%d]: %s", PI[playerid][pGroupName], NameRang(playerid), getName(playerid), playerid, params[0]);
	else  SendFractionMessagef(PI[playerid][pMember], 0x69b867FF, "[R] %s %s[%d]: %s", NameRang(playerid), getName(playerid), playerid, params[0]);
	SetPlayerChatBubble(playerid, !"сообщил нечто в рацию", 0xcd7a7aFF, 20.0, 4000);
	return 1;
}
CMD:rr(playerid,params[])
{
    if(PI[playerid][pMute] == 1) return SCM(playerid, COLOR_GREY, !"Ваш чат временно заблокирован");
	if(PI[playerid][pMember] == 0) return SCM(playerid, COLOR_GREY, !"Данная команда Вам недоступна");
	if(sscanf(params,"s[100]",params[0])) return SCM(playerid, COLOR_LIGHTGREY, !"Используйте: /rr [текст]");
	NotReklama(playerid, params[0]);
	if(PI[playerid][pGroupID] != -1) SendFractionMessagef(PI[playerid][pMember], 0x69b867FF, "(( [R | %s] %s %s[%d]: %s ))", PI[playerid][pGroupName], NameRang(playerid), getName(playerid), playerid, params[0]);
	else SendFractionMessagef(PI[playerid][pMember], 0x69b867FF, "(( [R] %s %s[%d]: %s ))", NameRang(playerid), getName(playerid), playerid, params[0]);
	SetPlayerChatBubble(playerid, !"сообщил нечто в рацию", 0xcd7a7aFF, 20.0, 4000);
	return 1;
}
CMD:d(playerid,params[]) 
{
	if(PI[playerid][pMember] == 5 || PI[playerid][pMember] == 6 || PI[playerid][pMember] == 7 || PI[playerid][pMember] == 0) return  SCM(playerid, COLOR_GREY, !"Вы не состоите во организации");
    if(PI[playerid][pMute] == 1) return SCM(playerid, COLOR_GREY, !"Ваш чат временно заблокирован");
    if(sscanf(params,"s[100]",params[0])) return SCM(playerid, COLOR_LIGHTGREY, !"Используйте: /d [текст]");
    NotReklama(playerid, params[0]);
	SendDepMessagef(0xFF8282FF, "[D | %s] %s %s[%d]: %s", PI[playerid][pGroupName], NameRang(playerid), getName(playerid), playerid, params[0]);
	return SetPlayerChatBubble(playerid, !"сообщил нечто в департамент", 0xcd7a7aFF, 20.0, 4000);
}
callback: LoadMembers(playerid) 
{
    new rows, fields, online_count = 0;
    cache_get_data(rows, fields);

    global_str[0] = EOS;
    new afk_status[32], warn_status[32], str_group[30];

    for (new i = 0; i < MAX_PLAYERS; i++) 
    {
        if (!IsPlayerConnected(i)) continue;

        if (PI[i][pMember] == PI[playerid][pMember]) 
        {
            online_count++;

            if (PI[i][pAFK] > 2) 
                format(afk_status, sizeof(afk_status), "{FF6347}[AFK](%d/3)", PI[i][pAFK]);
            else 
                afk_status[0] = EOS;

            if (PI[i][pTwarn] != 0) 
                format(warn_status, sizeof(warn_status), "{FF8000}(%d/3)", PI[i][pTwarn]);
            else 
                format(warn_status, sizeof(warn_status), "{33d267}(0/3)");

			if(PI[i][pGroupID] == -1)
				format(str_group, sizeof(str_group), "нет");
			else 
				format(str_group, sizeof(str_group), "%s", PI[i][pGroupName]);

            format(global_str, sizeof(global_str), "%s%s[%d]%s%s\t%d\t%s\t%d\n", 
                   global_str, PI[i][pName], i, afk_status, warn_status, 
                   PI[i][pRang], str_group, PI[i][pNumber]);
        }
    }
    SCMf(playerid, 0x3366ccFF, "Участников организации: %d чел, онлайн: %d чел", rows, online_count);

    new str_1[1048*2];
    format(str_1, sizeof(str_1), "Имя и выговоры\tРанг\tГруппа\tТелефон\n%s", global_str);
    CEF_ShowPlayerDialog(playerid, 0, DIALOG_STYLE_TABLIST_HEADERS, "{ee3366}Члены организации онлайн", str_1, "Закрыть", "");

    return 1;
}
CMD:members(playerid) 
{
    if(PI[playerid][pMember] == 0) return  SCM(playerid, COLOR_GREY, !"Вы не состоите во организации");
	mysql_string[0] = EOS, mf(mysql, mysql_string, 49, "SELECT * FROM `accounts` WHERE `member` = '%d'",PI[playerid][pMember]);
	mysql_function_query(mysql, mysql_string, true, "LoadMembers", "d", playerid);
	return 1;
}
CMD:allmembers(playerid) 
{
    if(PI[playerid][pLeader] == 0) return SCM(playerid, COLOR_GREY, !"Данная команда Вам недоступна");
	mysql_string[0] = EOS, mf(mysql, mysql_string, 49, "SELECT * FROM `accounts` WHERE `member` = '%d'",PI[playerid][pMember]);
	mysql_function_query(mysql, mysql_string, true, "LoadAllMembers", "d", playerid);
	return 1;
}
cmd:free(playerid, params[]) 
{
    if(PI[playerid][pMember] == 1 && PI[playerid][pRang] == 5) 
	{
    	if(sscanf(params, "u",params[0])) return SCM(playerid, COLOR_LIGHTGREY, !"Используйте: /free [ID игрока]");
    	if(!IsPlayerConnected(params[0]))return  SCM(playerid, COLOR_GREY, !"Игрок не в сети");
		if(!IsPlayerLogged{params[0]}) return  SCM(playerid, COLOR_GREY, !"Игрок не авторизован");

		new Float:x,Float:y,Float:z;
		GetPlayerPos(params[0],x,y,z);

		if(!PlayerToPoint(10.0, playerid, x,y,z)) return SCM(playerid, COLOR_GREY, !"Вы находитесь далеко от данного игрока");
		if(PI[params[0]][pJail] == 0) return SCM(playerid, COLOR_GREY, !"Данный игрок не находится в тюрьме");
		switch(PI[params[0]][pJailTime]) 
		{
			case 0..600: SetPVarInt(params[0], "FreeMoney",1000);
			case 601..1200: SetPVarInt(params[0], "FreeMoney",2500);
			case 1201..1800: SetPVarInt(params[0], "FreeMoney",5000);
			case 1801..3600: SetPVarInt(params[0], "FreeMoney",10000);
		}
		SendRequestForPlayer(playerid, params[0], 12, GetPVarInt(params[0], "FreeMoney"));
    }
    else SCM(playerid, COLOR_GREY, !"Данная команда Вам недоступна");
	return 1;
}
CMD:givelic(playerid,params[]) 
{
    if(PI[playerid][pMember] == 1 && PI[playerid][pRang] == 4) 
	{
		if(sscanf(params, "ud", params[0],params[1])) return SCM(playerid, COLOR_LIGHTGREY, !"Используйте: /givelic [ID игрока] [1 - водительские права, 2 - лицензия на оружие]");
		if(!IsPlayerConnected(params[0])) return SCM(playerid, COLOR_GREY, !"Игрок не в сети");
		if(!IsPlayerLogged{params[0]}) return SCM(playerid, COLOR_GREY, !"Игрок не авторизован");
		if(params[1] < 1 || params[1] > 2) return SCM(playerid, COLOR_LIGHTGREY, !"Используйте: /givelic [ID игрока] [1 - водительские права, 2 - лицензия на оружие]");
		new Float:x,Float:y,Float:z;
		GetPlayerPos(params[0],x,y,z);
		if(!PlayerToPoint(10.0, playerid, x,y,z)) return SCM(playerid, COLOR_GREY, !"Игрок находится слишком далеко");
		if(params[1] == 1) 
		{
			if(PI[params[0]][pDriveLicense] == 1) return SCM(playerid, COLOR_GREY, !"У игрока уже есть водительские права");
			SendRequestForPlayer(playerid, params[0], 13);
		}
		else 
		{
		    if(PI[params[0]][pGunLicense] == 1) return SCM(playerid, COLOR_GREY, !"У игрока уже есть лицензия на оружие");
		    SendRequestForPlayer(playerid, params[0], 14);
		}
	}
	else SCM(playerid, COLOR_GREY, !"Данная команда Вам недоступна");
	return 1;
}
CMD:healme(playerid,params[]) 
{
    if (PI[playerid][pHealPack] == 0) 
        return SCM(playerid, COLOR_GREY, !"У Вас нет медицинской аптечки");

    new 
        currentTime = gettime(),
        healCooldown = GetPVarInt(playerid, "Coolldown_HealOnWar"),
        healMeCooldown = GetPVarInt(playerid, "healmekd"),
        Float:hp,
        maxHP;

    if (healCooldown > currentTime)
        return SCMf(playerid, COLOR_GREY, !"Вы получили урон в бою, использовать аптечку можно будет через %d сек", healCooldown - currentTime);

    if (healMeCooldown > currentTime)
        return SCM(playerid, COLOR_GREY, !"Команду можно использовать раз в 3 секунд");

    GetPlayerHealth(playerid, hp);

    maxHP = PI[playerid][pVIP] ? 176 : 100;
    
    if (hp >= maxHP)
        return SCM(playerid, COLOR_GREY, !"Вы не нуждаетесь в лечении");

    SetPlayerHealthAC(playerid, (hp + 30.0 > float(maxHP)) ? float(maxHP) : hp + 30.0);

    SetPVarInt(playerid, "healmekd", currentTime + 3);
    PI[playerid][pHealPack]--;

	SendPlayerRadarNotify(playerid, 99, "green", "Использована аптечка", "+30 HP", 5);

    if (!IsPlayerInAnyVehicle(playerid)) 
        ApplyAnimation(playerid, "PED", "GUM_EAT", 4.0, 0, 0, 0, 0, 0, 1);

    SetPlayerChatBubble(playerid, "+30 HP", 0x008000FF, 20.0, 4000);

    new string[145];
    format(string, sizeof(string), "%s использовал аптечку", getName(playerid));
    ProxDetector(30.0, playerid, string, 0xFF99CCFF, 0xFF99CCFF, 0xFF99CCFF, 0xFF99CCFF, 0xFF99CCFF);

    return SetPlayerChatBubble(playerid, "использовал аптечку", 0xFF99CCFF, 20.0, 4000);
}
CMD:mask(playerid,params[]) 
{
    if(PI[playerid][pMask] == 0) return SCM(playerid, COLOR_GREY, !"У Вас нет маски");
    if(PI[playerid][pMaskWorn] != 0) return SCM(playerid, COLOR_GREY, !"Вы уже надели маску");
	if(GangWarStatus != 0) 
	{
		if(PI[playerid][pMember] != Command[0] && PI[playerid][pMember] != Command[1]) 
		{
			return SCM(playerid, COLOR_GREY, !"В момент захвата территории нельзя использовать маску");
		}
	}
	new string[145];
    PI[playerid][pMask]--;
    PI[playerid][pMaskWorn] = 1;
	foreach(new i:Player) SetPlayerColor(playerid, 0x33333300);
    format(string, sizeof(string), "%s натянул маску на лицо",getName(playerid));
	ProxDetector(30.0, playerid, string, 0xFF99CCFF, 0xFF99CCFF, 0xFF99CCFF, 0xFF99CCFF, 0xFF99CCFF);
	SetPlayerChatBubble(playerid, "натянул маску на лицо", 0xFF99CCFF, 20.0, 4000);
	SCM(playerid, COLOR_BLACK, !"Вы надели маску. Теперь Вас не будет видно на мини-карте");
	SCM(playerid, COLOR_BLACK, !"Чтобы снять маску используйте {ff6633}/maskoff");
	SendPlayerCenterNotify(playerid, 1, "Маска надета", 5);
	if(!IsPlayerInAnyVehicle(playerid)) ClearAnimations(playerid), ApplyAnimation(playerid, !"SHOP", !"ROB_SHIFTY", 4.1, 0, 0, 0, 0, 0, 1);
	MaskEnabled(playerid);
	return 1;
}
CMD:maskoff(playerid,params[]) 
{
    if(PI[playerid][pMaskWorn] == 0) return SCM(playerid, COLOR_GREY, !"На Вас нет маски");
	new string[145];
   	SetPlayerColorEx(playerid);
   	PI[playerid][pMaskWorn] = 0;
    format(string, sizeof(string), "%s снял маску",getName(playerid));
	ProxDetector(30.0, playerid, string, 0xFF99CCFF, 0xFF99CCFF, 0xFF99CCFF, 0xFF99CCFF, 0xFF99CCFF);
	SetPlayerChatBubble(playerid, "снял маску", 0xFF99CCFF, 20.0, 4000);
	MaskDisable(playerid);
	return SendPlayerCenterNotify(playerid, 3, "Маска снята", 5);
}
CMD:heal(playerid,params[]) 
{
    if(PI[playerid][pMember] != 4) return SCM(playerid,  COLOR_GREY, !"Данная команда для Вас недоступна");
	if(sscanf(params, "u", params[0])) return SCM(playerid, COLOR_LIGHTGREY, !"Используйте: /heal [ID игрока]");
	if(!IsPlayerConnected(params[0])) return SCM(playerid, COLOR_GREY, !"Игрок не в сети");
	if(!IsPlayerLogged{params[0]}) return SCM(playerid, COLOR_GREY, !"Игрок не авторизован");
	if(playerid == params[0]) return SCM(playerid, COLOR_GREY, !"Вы не можете вылечить себя");
	if(PI[params[0]][pMoney] == 750) return SCM(playerid, COLOR_GREY, !"Игрок не авторизован");
	new Float:x,Float:y,Float:z;
	GetPlayerPos(params[0],x,y,z);
	if(!PlayerToPoint(10.0, playerid, x,y,z)) return SCM(playerid, COLOR_GREY, !"Игрок находится слишком далеко");
	return SendRequestForPlayer(playerid, params[0], 10);
}
CMD:call(playerid,params[]) 
{
	if(PI[playerid][pPhone] == 0) return SCM(playerid, COLOR_GREY, !"У Вас нет телефона");
	if(PI[playerid][pNumber] == 0) return SCM(playerid, COLOR_GREY, !"У Вас нет SIM карты");
    if(sscanf(params, "d", params[0])) return SCM(playerid, COLOR_LIGHTGREY, !"Используйте: /call [номер]");
    if(PI[playerid][pNumber] == params[0]) return SCM(playerid, COLOR_GREY, !"Нельзя позвонить самому себе");
    if(params[0] == 102) {
        if(PI[playerid][data_911_1] > 0) return SCM(playerid, COLOR_GREY, !"Нельзя вызывать полицию слишком часто");
        new string[144];
	    format(string, sizeof(string), "%s достал bPhone XX из кармана",getName(playerid));
		ProxDetector(30.0, playerid, string, 0xFF99CCAA, 0xFF99CCAA, 0xFF99CCAA, 0xFF99CCAA, 0xFF99CCAA);
		return ShowPlayerDialog(playerid, 9111, DIALOG_STYLE_INPUT, "{ee3366}Вызов полиции", "Вы позвонили на гарячую линию вызова полции.\nПожалуйста, оставайтесь на месте и опишите Ваше местоположение:", "Вызов", "Отмена");
    }
    if(params[0] == 103) {
        if(PI[playerid][data_911_2] > 0) return SCM(playerid, COLOR_GREY, !"Нельзя вызывать скорую помощь слишком часто");
        new string[144];
	    format(string, sizeof(string), "%s достал bPhone XX из кармана",getName(playerid));
		ProxDetector(30.0, playerid, string, 0xFF99CCAA, 0xFF99CCAA, 0xFF99CCAA, 0xFF99CCAA, 0xFF99CCAA);
		return ShowPlayerDialog(playerid, 9112, DIALOG_STYLE_INPUT, "{ee3366}Вызов скорой помощи", "Вы позвонили на гарячую линию вызова скорой помощи.\nПожалуйста, оставайтесь на месте и опишите Ваше местоположение:", "Вызов", "Отмена");
    }
	for(new i = 0; i < MAX_PLAYERS; i++) {
	    if(!IsPlayerConnected(i)) continue;
		if(PI[i][pNumber] == params[0]) {
   			if(PI[playerid][pNumberMoney] <= 0) return SCM(playerid, COLOR_GREY, !"У Вас недостаточно денег на телефоне");
      		if(PI[i][data_CALL] != -1) return SCM(playerid, COLOR_GREY, !"Данный игрок разговаривает по телефону");
			PI[playerid][data_CALL] = i;
			new stringtext[144];
	    	format(stringtext, sizeof(stringtext), "%s достал bPhone XX из кармана",getName(playerid));
			ProxDetector(30.0, playerid, stringtext, 0xFF99CCAA, 0xFF99CCAA, 0xFF99CCAA, 0xFF99CCAA, 0xFF99CCAA);
			SCMf(i, 0x42d272FF, "[Входящий вызов] т. %d. Ожидание ответа...", PI[playerid][pNumber]);
			SCM(i, -1, !"Введите {42d272}/p {FFFFFF}чтобы ответить или {FF6347}/h {FFFFFF}чтобы отклонить вызов");
      		PlayerPlaySound(i, 20600, 0.0, 0.0, 0.0);
      		PlayerPlaySound(playerid, 3600, 0.0, 0.0, 0.0);
      		SCM(playerid,0x42d272FF, !"[Исходящий вызов] Ожидание ответа абонента...");
			if(!IsPlayerInAnyVehicle(playerid)) SetPlayerSpecialAction(playerid, SPECIAL_ACTION_USECELLPHONE);
			return 1;
  		}
	}
	return SCM(playerid, COLOR_GREY, !"Аппарат абонента выключен или находится вне зоны действия сети");
}
CMD:p(playerid) 
{
	if(PI[playerid][pPhone] == 0) return SCM(playerid, COLOR_GREY, !"У Вас нет телефона");
	if(PI[playerid][pNumber] == 0) return SCM(playerid, COLOR_GREY, !"В Вашем телефоне нет SIM-карты");
	for(new i = 0; i < MAX_PLAYERS; i++) {
	    if(!IsPlayerConnected(i)) continue;
	    if(PI[i][data_CALL] == playerid) {
    		PI[playerid][data_CALL] = i;
    		SetPVarInt(i,"call_m", 1);
			SCMf(playerid, 0xFF99CCFF, "Вы приняли вызов от %s", PI[i][pName]);
			SCMf(playerid, 0xFF99CCFF, "%s принял Ваш вызов", getName(playerid));
			SendAdminsMessagef(COLOR_YELLOW, "[CALL] %s[%d] > %s[%d]: {42d272}звонок начался", PI[i][pName], i, getName(playerid), playerid);
			if(!IsPlayerInAnyVehicle(playerid)) SetPlayerSpecialAction(playerid, SPECIAL_ACTION_USECELLPHONE);
			return 1;
		}
	}
	return SCM(playerid, COLOR_GREY, !"У Вас нет входящих вызовов");
}
CMD:h(playerid) 
{
	if(PI[playerid][pPhone] == 0) return SCM(playerid, COLOR_GREY, !"У Вас нет телефона");
	if(PI[playerid][pNumber] == 0) return SCM(playerid, COLOR_GREY, !"В Вашем телефоне нет SIM-карты");
	if(PI[playerid][data_CALL] == -1) return SCM(playerid, COLOR_GREY, !"В данный момент Вы не разговариваете по телефону");
	new id = PI[playerid][data_CALL];
	if(!IsPlayerInAnyVehicle(playerid)) SetPlayerSpecialAction(playerid, SPECIAL_ACTION_STOPUSECELLPHONE);
	if(PI[id][data_CALL] == playerid) {
    	if(!IsPlayerInAnyVehicle(id)) SetPlayerSpecialAction(id, SPECIAL_ACTION_STOPUSECELLPHONE);
 	}
	SCM(playerid, COLOR_GREY, !"Вы завершили звонок");
	SCMf(id, COLOR_GREY, "%s завершил звонок", PI[id][pName]);
	SendAdminsMessagef(COLOR_YELLOW, "[CALL] %s[%d] > %s[%d]: {FF6347}звонок завершился", PI[id][pName], id, getName(playerid), playerid);
	PI[id][data_CALL] = -1;
 	PI[playerid][data_CALL] = -1;
	SetPVarInt(id,"call_m",0);
	return SetPVarInt(playerid,"call_m",0);
}
CMD:sms(playerid,params[]) 
{
    if(PI[playerid][pMute] == 1) return SCM(playerid, COLOR_GREY, !"Ваш чат временно заблокирован");
	if(sscanf(params, "ds[84]", params[0],params[1])) return SCM(playerid, COLOR_LIGHTGREY, !"Используйте: /sms [номер] [текст]");
    if(PI[playerid][pPhone] == 0) return SCM(playerid, COLOR_GREY, !"У Вас нет телефона");
	if(PI[playerid][pNumber] == 0) return SCM(playerid, COLOR_GREY, !"У Вас нет SIM карты");
    if(PI[playerid][pNumber] == params[0]) return SCM(playerid, COLOR_GREY, !"Нельзя отправить SMS самому себе");
    if(PI[playerid][pVIP] < 1) if(PI[playerid][pNumberMoney] != 100) return SCM(playerid, COLOR_GREY, !"У Вас недостаточно денег на счёт телефона");
    else if(PI[playerid][pNumberMoney] != 50) return SCM(playerid, COLOR_GREY, !"У Вас недостаточно денег на счёт телефона");
	for(new i = 0; i < MAX_PLAYERS; i++) {
	    if(!IsPlayerConnected(i)) continue;
		if(PI[i][pNumber] == params[0]) {
   			if(PI[playerid][pNumberMoney] <= 0) return SCM(playerid, COLOR_GREY, !"На Вашем счете недостаточно средств");
			SCMf(i, COLOR_YELLOW, "[SMS | т. %d] %s: %s",PI[playerid][pNumber], getName(playerid), params[1]);
			SCMf(playerid, COLOR_YELLOW, "[SMS | т. %d] %s: %s",params[0], PI[i][pName],params[1]);
			SendAdminsMessagef(COLOR_YELLOW, "[SMS] %s[%d] > %s[%d]: %s", getName(playerid),playerid, PI[i][pName],i, params[1]);
			PI[playerid][pNumberMoney]--;
			return PlayerPlaySound(i, 40407, 0.0, 0.0, 0.0);
  		}
	}
	return SCM(playerid, COLOR_GREY, !"Аппарат абонента выключен или находится вне зоны действия сети");
}
CMD:gps(playerid) return ShowGPS(playerid);
CMD:accept(playerid, params[])
{
    new targetid;
    if (sscanf(params, "u", targetid)) return SCM(playerid, COLOR_LIGHTGREY, !"Используйте: /accept [ID игрока]");
    if (!IsPlayerConnected(targetid)) return SCM(playerid, COLOR_GREY, !"Игрок не в сети");
    if (!IsPlayerLogged{targetid}) return SCM(playerid, COLOR_GREY, !"Игрок не авторизован");

    new Float:x, Float:y, Float:z;
    GetPlayerPos(targetid, x, y, z);

    switch (PI[playerid][pMember])
    {
        case 3: // Полицейский
        {
            if (PI[targetid][data_911_1] != 1) return SCM(playerid, COLOR_GREY, !"Игрок не вызывал полицию");

            SetPVarFloat(playerid, "gps_pos_x", x);
            SetPVarFloat(playerid, "gps_pos_y", y);
            SetPVarFloat(playerid, "gps_pos_z", z);
            DisablePlayerCheckpoint(playerid);
            SetPlayerCheckpoint(playerid, x, y, z, 5.0);

            PI[targetid][data_911_1] = 0;
            SCMf(targetid, 0x658bcdFF, "Сотрудник полиции %s[%d] принял Ваш вызов, не покидайте место вызова", getName(playerid), playerid);
        }
        case 4: // Медик
        {
            if (PI[targetid][data_911_2] != 1) return SCM(playerid, COLOR_GREY, !"Игрок не вызывал скорую помощь");

            SetPVarFloat(playerid, "gps_pos_x", x);
            SetPVarFloat(playerid, "gps_pos_y", y);
            SetPVarFloat(playerid, "gps_pos_z", z);
            DisablePlayerCheckpoint(playerid);
            SetPlayerCheckpoint(playerid, x, y, z, 5.0);

            PI[targetid][data_911_2] = 0;
            SCMf(targetid, 0x658bcdFF, "Сотрудник скорой помощи %s[%d] принял Ваш вызов, не покидайте место вызова", getName(playerid), playerid);
        }
        default:
        {
            return SCM(playerid, COLOR_GREY, !"Данная команда Вам недоступна");
        }
    }
    return 1;
}
CMD:ginfo(playerid)
{
	if(!IsPlayerOPG(playerid)) return SCM(playerid, COLOR_GREY, !"Вы не состоите в ОПГ");
	mysql_string[0] = EOS, mf(mysql, mysql_string, 49, "SELECT * FROM `gangzone` WHERE `gzid` != '101'");
 	mysql_function_query(mysql, mysql_string, true, "GzInfo", "i", playerid);
    return true;
}
stock SaveGangZone(gzopg1, gz) 
{
	return mysql_tqueryf(mysql,"UPDATE `gangzone` SET `gzopg` = '%d' WHERE `gzid` = '%d'", gzopg1, gz_info[gz][gzid]);
}
CMD:makegun(playerid) 
{
    if(PI[playerid][pWeaponLock] > 0) return SCM(playerid, COLOR_GREY, !"У Вас блокировка оружия");
	if(PI[playerid][pMember] == 5 || PI[playerid][pMember] == 6|| PI[playerid][pMember] == 7) ShowPlayerDialog(playerid, dialog_MAKEGUN, DIALOG_STYLE_TABLIST_HEADERS, "{ee3366}Выберите оружие", "ID и название\t\t\tКол-во металла\n1. Бейсбольная бита\t\t1\n2. ТТ \t\t5\n3. Тайзер\t\t3\n4. ПЛ-15\t\t\t6\n5. Дробовик\t8\n6. Обрез\t7\n7. Автоматический дробовик\t9\n8. MP40\t\t\t7\n9. AKC-74Y\t\t\t8\n10. AK-47\t9\n11. AK-104\t\t\t9\n12. Tec-9\t\t\t7\n13. Country Rifle\t\t\t10", "Далее", "Отмена");
	else SCM(playerid, COLOR_GREY, !"Данная команда Вам недоступна");
	return 1;
}
CMD:put(playerid,params[]) 
{
    if(PI[playerid][pMember] == 2) 
	{
	    if(PI[playerid][data_PUTPATR] == 0 && PI[playerid][data_PUTMET] == 0) return SCM(playerid, COLOR_GREY,"У Вас нет в руках ящика");
		for(new c = 0; c < MAX_VEHICLES; c++) 
		{
			new model = GetVehicleModel(c);
			new Float:x,Float:y,Float:z;
			GetCoordBootVehicle(c, x, y, z);
			if(PlayerToPoint(2.0, playerid, x, y, z)) 
			{
				if(model != 578) return SCM(playerid, COLOR_GREY, !"Это не специальный грузовик");
				if(PI[playerid][data_PUTPATR] != 0) 
				{
					if(CarInfo[c][cAmmo] >= 6000) return SCM(playerid, COLOR_GREY, !"В грузовике недостаточно места");
	                CarInfo[c][cAmmo] += 1000;
	                PI[playerid][data_PUTPATR] = 0;
	                if(IsPlayerAttachedObjectSlotUsed(playerid, 3)) RemovePlayerAttachedObject(playerid, 3);
	                SetPlayerSpecialAction(playerid,0);
					global_str[0] = EOS, f(global_str, 107, "{3366FF}МЗКТ\n{FFFFFF}Патроны: {FF6600}%d/6000 шт.\n{FFFFFF}Металл: {FF6600}%d/12000 шт.",CarInfo[c][cAmmo], CarInfo[c][cMetall]);
	                UpdateDynamic3DTextLabelText(vehicletext, -1, global_str);
	                return 1;
                }
                else if(PI[playerid][data_PUTMET] != 0) 
				{
					if(CarInfo[c][cMetall] >= 12000) return SCM(playerid, COLOR_GREY, !"В грузовике недостаточно места");
	                CarInfo[c][cMetall] += 1000;
	                PI[playerid][data_PUTMET] = 0;
	                if(IsPlayerAttachedObjectSlotUsed(playerid, 3)) RemovePlayerAttachedObject(playerid, 3);
	                SetPlayerSpecialAction(playerid,0);
					global_str[0] = EOS, f(global_str, 107, "{3366FF}МЗКТ\n{FFFFFF}Патроны: {FF6600}%d/6000 шт.\n{FFFFFF}Металл: {FF6600}%d/12000 шт.",CarInfo[c][cAmmo], CarInfo[c][cMetall]);
	                UpdateDynamic3DTextLabelText(vehicletext, -1, global_str);
	                return 1;
                }
			}
		}
		PI[playerid][data_PUTPATR] = 0;
		PI[playerid][data_PUTMET] = 0;
		SendPlayerCenterNotify(playerid, 2, "Вы бросили ящик", 5);
		if(IsPlayerAttachedObjectSlotUsed(playerid, 3)) RemovePlayerAttachedObject(playerid, 3);
		SetPlayerSpecialAction(playerid,0);
	}
	else SCM(playerid, COLOR_GREY, !"Данная команда Вам недоступна");
	return 1;
}
CMD:putammo(playerid,params[]) 
{
    if(PI[playerid][pMember] == 2) 
	{
	    new car = GetPlayerVehicleID(playerid);
	    new model = GetVehicleModel(car);
	    new materials = CarInfo[car][cAmmo];
		new metals = CarInfo[car][cMetall];
	    if(model != 578) return SCM(playerid, COLOR_GREY, !"Нужно находиться в специальном грузовике");
		if(PlayerToPoint(30.0, playerid, -2569.5925,450.9106,10.9316) && PI[playerid][pMember] == 2) 
		{
	        if(car == army_car[0]) 
			{
	            if(CarInfo[car][cAmmo] != 0 || CarInfo[car][cMetall] != 0) 
				{
					army_wh[1] += materials;
					CarInfo[car][cAmmo] = 0;
					army_wh[0] += metals;
					CarInfo[car][cMetall] = 0;
					SendFractionMessagef(PI[playerid][pMember],0x69b867FF, "[R] %s[%d] разгрузил грузовик с боеприпасами. (+%d патронов)",getName(playerid),playerid, materials, metals);
					global_str[0] = EOS, f(global_str, 130, "{3366FF}Склад армии\n{FFFFFF}Металла на складе: {FF6600}%d шт.\n{FFFFFF}Патронов на складе: {FF6600}%d шт.",army_wh[0],army_wh[1]);
       				UpdateDynamic3DTextLabelText(army_sklad_text, -1, global_str);
					global_str[0] = EOS, f(global_str, 115, "{3366FF}МЗКТ\n{FFFFFF}Патроны: {FF6600}%d/6000 шт.\n{FFFFFF}Металл: {FF6600}%d/12000 шт.", CarInfo[car][cAmmo], CarInfo[car][cMetall]);
	                UpdateDynamic3DTextLabelText(vehicletext, -1, global_str);
					return 1;
				}
                SCM(playerid, COLOR_GREY, !"Грузовик пуст");
			}
			else SCM(playerid, COLOR_GREY, !"Нужно находиться в специальном грузовике");
		}
	}
	else SCM(playerid, COLOR_GREY, !"Данная команда Вам недоступна");
	return 1;
}
CMD:lock(playerid) 
{
	for(new c = 0; c < MAX_VEHICLES; c++) 
	{
		if(c == PI[playerid][pLoadVehicleID]) 
		{
			new Float:x,Float:y,Float:z;
		    GetVehiclePos(c,x,y,z);
			if(!PlayerToPoint(5.0, playerid, x,y,z)) return SCM(playerid, COLOR_GREY, !"Вы находитесь далеко от личного транспорта");
			switch(CarInfo[c][cLock]) 
			{
				case 0: 
				{
				    //PlayerPlaySound(playerid, 25800, 0.0, 0.0, 0.0);
					GetVehicleParamsEx(c,engine,lights_text,alarm,doors_text,bonnet,boot,objective);
					SetVehicleParamsEx(c,engine,lights_text,alarm,true,bonnet,boot,objective);
					CarInfo[c][cLock] = 1;
					SendPlayerRadarNotify(playerid, 4, "lock-red", "Личный транспорт закрыт", "", 5);
					if(IsPlayerInAnyVehicle(playerid)) cef_emit_event(playerid, "update-speed-icon", CEFINT(2), CEFINT(1));
				}
				case 1: 
				{
				    //PlayerPlaySound(playerid, 25800, 0.0, 0.0, 0.0);
					GetVehicleParamsEx(c,engine,lights_text,alarm,doors_text,bonnet,boot,objective);
					SetVehicleParamsEx(c,engine,lights_text,alarm,false,bonnet,boot,objective);
					CarInfo[c][cLock] = 0;
					SendPlayerRadarNotify(playerid, 3, "lock-green", "Личный транспорт открыт", "", 5);
					if(IsPlayerInAnyVehicle(playerid)) cef_emit_event(playerid, "update-speed-icon", CEFINT(2), CEFINT(0));
				}
			}
		}
	}
	return 1;
}
callback: CheckCarHealth() 
{
	for(new c; c < MAX_VEHICLES; c++) 
	{
	    new Float:health;
	    GetVehicleHealth(c,health);
	    if(health <= 350) 
		{
			SetVehicleHealth(c, 350);
			GetVehicleParamsEx(c,engine,lights_text,alarm,doors_text,bonnet,boot,objective);
			SetVehicleParamsEx(c,false,lights_text,alarm,doors_text,bonnet,boot,objective);
		}
	}
}
stock GetGZFrac(gznum){
	new cvet;
	switch(gz_info[gznum][gzopg]) {
	    case 0: cvet = 0xFF000055;
	    case 5: cvet = 0x663399BB;
	    case 6: cvet = 0x66CCFFBB;
		case 7: cvet = 0x339933AA;
	}
	return cvet;
}

stock UpdatePlayerDataIntName(const playerid, const field[], data) 
{
	mysql_tqueryf(mysql, "UPDATE `accounts` SET `%e` = '%i' WHERE `Name` = '%e' LIMIT 1", field, data, getName(playerid));
}
stock UpdatePlayerDataInt(const playerid, const field[], data) 
{
	if(PI[playerid][pID] == -1) 
	{
		mysql_tqueryf(mysql, "UPDATE `accounts` SET `%s` = '%i' WHERE `Name` = '%e' LIMIT 1", field, data, getName(playerid));
	}
	else 
	{
		mysql_tqueryf(mysql, "UPDATE `accounts` SET `%e` = '%i' WHERE `id` = '%i' LIMIT 1", field, data, PI[playerid][pID]);
	}
}
stock UpdatePlayerDataIntNoLog(playerid, field[], data[]) 
{
	new strup[256];
	format(strup, sizeof(strup), "UPDATE `accounts` SET %s = '%i' WHERE id = '%i' LIMIT 1", field, data, PI[playerid][pID]);
	return mysql_function_query(mysql, strup, false, "", "");
}
stock MysqlUpdatePlayerStr(const playerid, const field[], data[]) 
{
	mysql_tqueryf(mysql, "UPDATE `accounts` SET `%s` = '%e' WHERE `id` = '%i' LIMIT 1", field, data, PI[playerid][pID]);
	return 1;
}
CMD:twarn(playerid, params[])
{
    if (PI[playerid][pRang] < 9) return 1;

    new targetID, reason[128];
    if (sscanf(params, "us", targetID, reason)) return SCM(playerid, COLOR_LIGHTGREY, !"Используйте: /twarn [ID игрока] [причина]");
    if (!IsPlayerConnected(targetID)) return SCM(playerid, COLOR_GREY, !"Игрок не в сети");
    if (!IsPlayerLogged{targetID}) return SCM(playerid, COLOR_GREY, !"Игрок не авторизован");

    if (PI[targetID][pMember] != PI[playerid][pMember]) return SCM(playerid, COLOR_GREY, !"Этот игрок не состоит в вашей организации");
    if (targetID == playerid) return SCM(playerid, COLOR_GREY, !"Вы не можете выдать выговор себе");
    if (PI[targetID][pRang] == 10 && PI[playerid][pRang] == 9) return SCM(playerid, COLOR_GREY, !"Вы не можете выдать выговор лидеру");
    if (PI[targetID][pRang] == PI[playerid][pRang]) return SCM(playerid, COLOR_GREY, !"Вы не можете выдать выговор человеку, чей ранг схож с вашим");

    if (PI[targetID][pTwarn] < 3) 
    {
        PI[targetID][pTwarn]++;
        SendFractionMessagef(PI[playerid][pMember], COLOR_TOMATO, "%s %s[%d] выдал выговор %s %s[%d] [%d|3]. Причина: %s", NameRang(playerid), getName(playerid), playerid, NameRang(targetID), getName(targetID), targetID, PI[targetID][pTwarn], reason);
    }
    else if (PI[targetID][pTwarn] <= 2) 
    {
        PI[targetID][pTwarn] = 0;
        new year, month, day;
        getdate(year, month, day);
        mysql_string[0] = EOS, mf(mysql, mysql_string, 340, "INSERT INTO `wbook`(`w_player`,`w_fraction`,`w_name`,`w_reason`,`w_rank`,`w_day`,`w_mes`,`w_year`,`w_dal`,`w_reas`,`w_dalrank`) VALUES ('%d','%d','%s','Увольнение','%d','%d','%d','%d','%s','%s','%s')", PI[targetID][pID], PI[targetID][pMember], getName(targetID), PI[targetID][pRang], day, month, year, PI[playerid][pRang], reason, NameRang(playerid));
        mysql_function_query(mysql, mysql_string, false, "", "");

        SendFractionMessagef(PI[playerid][pMember], COLOR_TOMATO, "%s %s[%d] выдал выговор %s %s[%d] [3|3]. Причина: %s", NameRang(playerid), getName(playerid), playerid, NameRang(targetID), getName(targetID), targetID, reason);
        SendFractionMessagef(PI[playerid][pMember], COLOR_TOMATO, "%s %s[%d] уволил %s %s[%d] из организации [3|3]", NameRang(playerid), getName(playerid), playerid, NameRang(targetID), getName(targetID), targetID);

        PI[targetID][pMember] = 0;
        PI[targetID][pRang] = 0;
        PI[targetID][pLeader] = 0;
        ClearGroup(targetID);
        SetPlayerSkinAC(targetID, PI[targetID][pSkin]);
        SetPlayerColorEx(targetID);
        PI[targetID][pMedCard] = 0;
    }

    return 1;
}

CMD:untwarn(playerid, params[])
{
    if (PI[playerid][pRang] < 9) return 1;

    new targetID, reason[128];
    if (sscanf(params, "us", targetID, reason)) 
        return SCM(playerid, COLOR_LIGHTGREY, !"Используйте: /untwarn [ID игрока] [причина]");
    
    if (!IsPlayerConnected(targetID)) 
        return SCM(playerid, COLOR_GREY, !"Игрок не в сети");

    if (!IsPlayerLogged{targetID}) 
        return SCM(playerid, COLOR_GREY, !"Игрок не авторизован");

    if (PI[targetID][pMember] != PI[playerid][pMember]) 
        return SCM(playerid, COLOR_GREY, !"Этот игрок не состоит в вашей организации");
    
    if (targetID == playerid) 
        return SCM(playerid, COLOR_GREY, !"Вы не можете снять выговор себе");
    
    if (PI[targetID][pRang] == 10 && PI[playerid][pRang] == 9) 
        return SCM(playerid, COLOR_GREY, !"Вы не можете снять выговор лидеру");
    
    if (PI[targetID][pRang] == PI[playerid][pRang]) 
        return SCM(playerid, COLOR_GREY, !"Вы не можете снять выговор человеку, чей ранг схож с вашим");
    
    if (PI[targetID][pTwarn] == 0) 
        return SCM(playerid, COLOR_GREY, !"Игрок не имеет выговоров");
    
    PI[targetID][pTwarn]--;
    
    SendFractionMessagef(PI[playerid][pMember], 0x6699cc3FF, "%s %s[%d] снял выговор с %s %s[%d]",\
        NameRang(playerid), getName(playerid), playerid,\
        NameRang(targetID), getName(targetID), targetID);
    
    SCMf(targetID, 0x6699cc3FF, "%s %s[%d] снял с Вас выговор", 
        NameRang(playerid), getName(playerid), playerid);
    
    return 1;
}

CMD:offtwarn(playerid, params[])
{
    if (PI[playerid][pRang] < 9) return 1;

    new name[MAX_PLAYER_NAME];
    if (sscanf(params, "s[144]", name)) 
        return SCM(playerid, COLOR_LIGHTGREY, !"Используйте: /offtwarn [имя]");
    
    if (strcmp(name, getName(playerid)) == 0) 
        return SCM(playerid, COLOR_GREY, !"Вы не можете снять выговор себе");
    
    mysql_string[0] = EOS, mf(mysql, mysql_string, 69, "SELECT * FROM `accounts` WHERE `Name` = '%e'", name);
    mysql_function_query(mysql, mysql_string, true, "OffTwarn", "i", playerid);
    
    return 1;
}

callback: OffTwarn(playerid)
{
    new rows, fields, temp[80];
    cache_get_data(rows, fields);
    
    if (rows)
    {
        new names[24], twarn, members, ranks, leaders, groupid;
        cache_get_field_content(0, "Name", names, sizeof(names));
        cache_get_field_content(0, "twarn", temp), twarn = strval(temp);
        cache_get_field_content(0, "member", temp), members = strval(temp);
        cache_get_field_content(0, "rank", temp), ranks = strval(temp);
        cache_get_field_content(0, "GroupID", temp), groupid = strval(temp);
        
        if (ranks == 10 && PI[playerid][pRang] == 9) 
            return SCM(playerid, COLOR_GREY, !"Вы не можете снять выговор лидеру");
        
        if (ranks == PI[playerid][pRang]) 
            return SCM(playerid, COLOR_GREY, !"Вы не можете снять выговор человеку, чей ранг схож с вашим");
        
        if (PI[playerid][pMember] != members) 
            return SCM(playerid, COLOR_GREY, !"Игрок должен состоять в Вашей организации");
        
        if (twarn < 3) 
        {
            twarn++;
            SendFractionMessagef(PI[playerid][pMember], COLOR_TOMATO, "(( %s %s[%d] выдал выговор оффлайн %s [%d/3] ))",\
                NameRang(playerid), getName(playerid), playerid, names, twarn);
        }
        else if (twarn == 3) 
        {
            twarn = 0;
            SendFractionMessagef(PI[playerid][pMember], COLOR_TOMATO, "(( %s %s[%d] уволил оффлайн %s [3/3] ))",\
                NameRang(playerid), getName(playerid), playerid, names);
            
            members = 0;
            ranks = 0;
            leaders = 0;
            groupid = 0;
            
            new res[144];
            format(res, sizeof(res), "Получение 3 выговоров");
            SetPVarString(playerid, "text_wbook", res);
            
            mysql_string[0] = EOS, mf(mysql, mysql_string, 69, "SELECT * FROM `accounts` WHERE name = '%e'", names);
            mysql_function_query(mysql, mysql_string, true, "WbookOff", "is", playerid, names);
        }
        
        mysql_string[0] = EOS, mf(mysql, mysql_string, 240, "UPDATE `accounts` SET `member` = '%d', `rank` = '%d', `leader` = '%d', `twarn` = '%d', `GroupID` = '%d' WHERE `Name` = '%e'",
            members, ranks, leaders, twarn, groupid, names);
        mysql_function_query(mysql, mysql_string, false, "", "");
    }
    else SCM(playerid, COLOR_GREY, !"Игрок не найден");
    
    return 1;
}
stock SendFractionMessage(fraction,color, text[]) {
	for(new i = 0; i < MAX_PLAYERS; i++) {
	    if(!IsPlayerConnected(i)) continue;
		if(PI[i][pMember] == fraction) SCM(i, color, text);
	}
}
CMD:storage(playerid) 
{
    if(PI[playerid][pMember] != 5 && PI[playerid][pRang] < 9 ||
	PI[playerid][pMember] != 6 && PI[playerid][pRang] < 9 ||
	PI[playerid][pMember] != 7 && PI[playerid][pRang] < 9) return SCM(playerid, COLOR_GREY, !"Данная команда Вам недоступна");
	if(PI[playerid][pMember] == 5) 
	{
		switch(skinhead_wh[3]) 
		{
		    case 0: 
			{
		        skinhead_wh[3] = 1;

				SendPlayerRadarNotify(playerid, 100, "lock-red", "Склад ОПГ закрыт", "", 5);

        		foreach(new i:Player) 
				{
				    if(PI[i][pMember] == PI[playerid][pMember]) 
					{
                        global_str[0] = EOS, format(global_str, 225, "Склад {ff6633}(закрыт)\n{cc6666}Скинхеды\n\
						{FFFFFF}Металл: {e6d455}%d / 6000 шт.\n\
						{FFFFFF}Патроны: {e6d455}%d / 50000 шт.\n\
						{FFFFFF}Вещества: {e6d455}%d / 12000 шт.", skinhead_wh[0], skinhead_wh[1], skinhead_wh[2]);
						UpdateDynamic3DTextLabelText(skinhead_sklad_text, -1, global_str);
				    }
				}
		    }
		    case 1: 
			{
		        skinhead_wh[3] = 0;

				SendPlayerRadarNotify(playerid, 101, "lock-green", "Склад ОПГ открыт", "", 5);

        		foreach(new i:Player) 
				{
				    if(PI[i][pMember] == PI[playerid][pMember]) 
					{
				        global_str[0] = EOS, format(global_str, 225, "Склад\n{cc6666}Скинхеды\n\
						{FFFFFF}Металл: {e6d455}%d / 6000 шт.\n\
						{FFFFFF}Патроны: {e6d455}%d / 50000 шт.\n\
						{FFFFFF}Вещества: {e6d455}%d / 12000 шт.",skinhead_wh[0], skinhead_wh[1], skinhead_wh[2]);
						UpdateDynamic3DTextLabelText(skinhead_sklad_text, -1, global_str);
					}
				}
		    }
		}
	}
	if(PI[playerid][pMember] == 6) 
	{
		switch(gopota_wh[3]) 
		{
		    case 0: 
			{
		        gopota_wh[3] = 1;
				SendPlayerRadarNotify(playerid, 100, "lock-red", "Склад ОПГ закрыт", "", 5);
        		foreach(new i:Player) 
				{
				    if(PI[i][pMember] == PI[playerid][pMember]) 
					{
				        global_str[0] = EOS, format(global_str, 225, "Склад {ff6633}(закрыт)\n{cc6666}Гопота\n\
						{FFFFFF}Металл: {e6d455}%d / 6000 шт.\n\
						{FFFFFF}Патроны: {e6d455}%d / 50000 шт.\n\
						{FFFFFF}Вещества: {e6d455}%d / 12000 шт.", gopota_wh[0], gopota_wh[1], gopota_wh[2]);
						UpdateDynamic3DTextLabelText(gopota_sklad_text, -1, global_str);
				    }
				}
		    }
		    case 1: 
			{
		        gopota_wh[3] = 0;
				SendPlayerRadarNotify(playerid, 101, "lock-green", "Склад ОПГ открыт", "", 5);
        		foreach(new i:Player) 
				{
				    if(PI[i][pMember] == PI[playerid][pMember]) 
					{
				        global_str[0] = EOS, format(global_str, 225, "Склад\n{cc6666}Гопота\n\
						{FFFFFF}Металл: {e6d455}%d / 6000 шт.\n\
						{FFFFFF}Патроны: {e6d455}%d / 50000 шт.\n\
						{FFFFFF}Вещества: {e6d455}%d / 12000 шт.", gopota_wh[0], gopota_wh[1], gopota_wh[2]);
						UpdateDynamic3DTextLabelText(gopota_sklad_text, -1, global_str);
					}
				}
		    }
		}
	}
	if(PI[playerid][pMember] == 7)
	{
		switch(kavkaz_wh[3]) 
		{
		    case 0: 
			{
		        kavkaz_wh[3] = 1;
				SendPlayerRadarNotify(playerid, 100, "lock-red", "Склад ОПГ закрыт", "", 5);
        		foreach(new i:Player) 
				{
				    if(PI[i][pMember] == PI[playerid][pMember]) 
					{
                        global_str[0] = EOS, format(global_str, 225, "Склад {ff6633}(закрыт)\n{cc6666}Кавказцы\n\
						{FFFFFF}Металл: {ffcc33}%d / 6000 шт.\n\
						{FFFFFF}Патроны: {ffcc33}%d / 50000 шт.\n\
						{FFFFFF}Вещества: {ffcc33}%d / 12000 шт.", kavkaz_wh[0], kavkaz_wh[1], kavkaz_wh[2]);
						UpdateDynamic3DTextLabelText(kavkaz_sklad_text, -1, global_str);
					}
				}
		    }
		    case 1: 
			{
		        kavkaz_wh[3] = 0;
				SendPlayerRadarNotify(playerid, 101, "lock-green", "Склад ОПГ открыт", "", 5);
        		foreach(new i:Player) 
				{
				    if(PI[i][pMember] == PI[playerid][pMember]) 
					{
                        global_str[0] = EOS, format(global_str, 225, "Склад\n{cc6666}Кавказцы\n\
						{FFFFFF}Металл: {ffcc33}%d / 6000 шт.\n\
						{FFFFFF}Патроны: {ffcc33}%d / 50000 шт.\n\
						{FFFFFF}Вещества: {ffcc33}%d / 12000 шт.", kavkaz_wh[0], kavkaz_wh[1], kavkaz_wh[2]);
						UpdateDynamic3DTextLabelText(kavkaz_sklad_text, -1, global_str);
					}
				}
		    }
		}
	}
	return 1;
}
stock SetPlayerToFacePlayer(playerid, targetid) 
{
    new Float:PlayerX, Float:PlayerY, Float:PlayerZ, Float:X, Float:Y, Float:Z, Float:ang;
    if(!IsPlayerConnected(playerid) || !IsPlayerConnected(targetid)) return 0;
    GetPlayerPos(targetid, X, Y, Z);
    GetPlayerPos(playerid, PlayerX, PlayerY, PlayerZ);
    if( Y > PlayerY ) ang = (-acos((X - PlayerX) / floatsqroot((X - PlayerX)*(X - PlayerX) + (Y - PlayerY)*(Y - PlayerY))) - 90.0);
    else if( Y < PlayerY && X < PlayerX ) ang = (acos((X - PlayerX) / floatsqroot((X - PlayerX)*(X - PlayerX) + (Y - PlayerY)*(Y - PlayerY))) - 450.0);
    else if( Y < PlayerY ) ang = (acos((X - PlayerX) / floatsqroot((X - PlayerX)*(X - PlayerX) + (Y - PlayerY)*(Y - PlayerY))) - 90.0);
    if(X > PlayerX) ang = (floatabs(floatabs(ang) + 180.0));
    else ang = (floatabs(ang) - 180.0);
    SetPlayerFacingAngle(playerid, ang);
    return 0;
}
callback: GetPunishment(playerid) {
	new rows, fields, type, name[MAX_PLAYER_NAME], reason[144], temp[20], string[625], string1[625], bugfix,logd1,logd2,logd3, support;
    cache_get_data(rows, fields);
    for(new i = 0; i < rows; i++) {
		cache_get_field_content(i, "player", name, mysql, MAX_PLAYER_NAME);
		cache_get_field_content(i, "reason", reason, mysql, 144);
		cache_get_field_content(i, "type", temp), type = strval (temp);
		cache_get_field_content(i, "support", temp), support = strval (temp);
		cache_get_field_content(i, "day", temp), logd1 = strval (temp);
		cache_get_field_content(i, "mounth", temp), logd2 = strval (temp);
		cache_get_field_content(i, "year", temp), logd3 = strval (temp);
		new ltext[64];
		switch(type) {
			case 1: ltext = "Блокировка аккаунта";
			case 2: ltext = "Игровое предупреждение";
		}
    	format(string,sizeof(string),"%s{FFFFFF}%s\t%s\t#%d\t%d.%d.%d\t%s\n",string, name, ltext, support, logd1, logd2, logd3, reason);
    	format(string1,sizeof(string1),"Никнейм\tТип\tИгровой мастер \tДата\tПричина\n%s",string);
    	bugfix = 1;
	}
	if(bugfix == 1) return ShowPlayerDialog(playerid,0, DIALOG_STYLE_TABLIST_HEADERS, "{ee3366}Список наказаний", string1, "Закрыть", "");
  	ShowPlayerDialog(playerid, 0, DIALOG_STYLE_MSGBOX, !"{ee3366}Список наказаний", "{FFFFFF}В данный момент наказаний игрока нет", "Закрыть", "");
	return 1;
}
CMD:givechest(playerid,params[]) 
{
    if(sscanf(params,"iii", params[0])) return SCM(playerid, COLOR_LIGHTGREY, !"Используйте: /givechest [ID игрока]");
	if(playerid == params[0]) return SCM(playerid, COLOR_GREY, !"Нельзя передать аптечку самому себе");
	if(PI[playerid][pHealPack] == 0) return SCM(playerid, COLOR_GREY, !"У вас нет набор аптечек");
	if(PI[params[0]][pHealPack] >= 3) return SCM(playerid, COLOR_GREY, !"У игрока уже есть 3 набора аптечек");
	if(!IsPlayerLogged{params[0]}) return SCM(playerid, COLOR_GREY, !"Игрок не авторизован");
	new Float:x,Float:y,Float:z;
	GetPlayerPos(params[0],x,y,z);
	if(!PlayerToPoint(10.0, playerid, x,y,z)) return SCM(playerid, COLOR_GREY, !"Игрок слишком далеко от Вас");
	return SendRequestForPlayer(playerid, params[0], 2);
}	
stock ShowDialogRule(playerid) 
{
    ShowPlayerDialog(playerid, 0, DIALOG_STYLE_MSGBOX, !"{ee3366}Общие правила", !"\
	{FFFFFF}Правила игры расположены на форуме.\n\
	Ссылка на форум: {FFFF99}"FORUM"", !"Закрыть", !"");
	return 1;
}
stock ShowDialogResurs(playerid) 
{
	ShowPlayerDialog(playerid, 0, DIALOG_STYLE_LIST, !"{ee3366}Ресурсы игры","\
	{FFFFFF}Сайт\t\t\t\t\t{FFFF99}"SITE"\n\
	{FFFFFF}Форум\t\t\t\t\t{FFFF99}"FORUM"\n\
	{FFFFFF}Тех.Поддержка\t\t\t{FFFF99}vk.com/"VK"\n\
	{FFFFFF}Сообщество ВКонтакте\t\t{FFFF99}vk.com/"VK"", !"Закрыть", !"");
	return 1;
}
CMD:givemask(playerid,params[]) 
{
    if(sscanf(params,"iii", params[0])) return SCM(playerid, COLOR_LIGHTGREY, !"Используйте: /givemask [ID игрока]");
	if(playerid == params[0]) return SCM(playerid, COLOR_GREY, !"Нельзя передать маску самому себе");
	if(PI[playerid][pMask] == 0) return SCM(playerid, COLOR_GREY, !"У вас нет маски");
	if(PI[params[0]][pMask] >= 1) return SCM(playerid, COLOR_GREY, !"У игрока уже есть маска");
	if(!IsPlayerLogged{params[0]}) return SCM(playerid, COLOR_GREY, !"Игрок не авторизован");
	new Float:x,Float:y,Float:z;
	GetPlayerPos(params[0],x,y,z);
	if(!PlayerToPoint(10.0, playerid, x,y,z)) return SCM(playerid, COLOR_GREY, !"Игрок слишком далеко от Вас");
	SendRequestForPlayer(playerid, params[0], 8);
	return 1;
}
stock LMenuGovernment(playerid) 
{
	return ShowPlayerDialog(playerid, 7500, DIALOG_STYLE_LIST, !"{ee3366}Меню лидера", !"{e6e69c}1. Управление группами\n\
	{e6e69c}2. Заявки на перевод\n\
	{e6e69c}3. Список всех участников организации\n\
	{e6e69c}4. Чёрный список\n\
	{e6e69c}5. Автопарк организации\n\
	{3CB371}6. Принять в организацию\n\
	{3CB371}7. Уволить из организации\n\
	{3CB371}8. Уволить из огранизации оффлайн\n\
	{3CB371}9. Выдать выговор\n\
	{3CB371}10. Выдать выговор оффлайн\n\
	{3CB371}11. Снять выговор\n\
	{3CB371}12. Снять выговор оффлайн\n\
	{3CB371}13. Изменить ранг\n\
	{3CB371}14. Изменить внешность\n\
	{3CB371}15. Изменить группу\n\
	{6dbdd8}16. Расформировать организацию\n\
	{6dbdd8}16. Меню Собеседований", !"Выбрать", !"Отмена");
}
alias:lmenu("lm", "leadersmenu", "leadersm");
cmd:lmenu(playerid) 
{
    if(PI[playerid][pRang] < 9) return SCM(playerid, COLOR_GREY, !"Данная команда доступна лидерам организаций и их заместителям");

    if(PI[playerid][pMember] == 1 || PI[playerid][pMember] == 2 || PI[playerid][pMember] == 3 || PI[playerid][pMember] == 4) return LMenuGovernment(playerid);
    if(PI[playerid][pMember] == 5 || PI[playerid][pMember] == 6 || PI[playerid][pMember] == 7) return LMenuIllegal(playerid);
	return 1;
}
cmd:transfer(playerid) 
{
	if(PI[playerid][pMember] == 5 || PI[playerid][pMember] == 6 || PI[playerid][pMember] == 7) return SCM(playerid, COLOR_GREY, !"Переводы доступны только в Государственых Организациях");
    if(PI[playerid][pRang] > 9) return SCM(playerid, COLOR_GREY, !"Вы не можете перевестить в другую организацию");
    if(PI[playerid][pMember] < 3) return SCM(playerid, COLOR_GREY, !"Переводы доступны c третего ранга");
    ShowPlayerDialog(playerid, 7600, DIALOG_STYLE_LIST, "{ee3366}Переводы", "1. БЦРБ\n2. Полиция\n3. Правительство\n4. Воинская Часть", "Выбрать", "Отмена");
	return 1;
}
CMD:transfers(playerid) 
{
	new string[256+144] = "ID\tИмя\tРанг\tОрганизация\n", bool: bugfix ;
	for(new i = 0; i < MAX_PLAYERS; i++) {
    	if(!IsPlayerConnected(i)) continue;
		if(PI[i][data_TRANSFER_FRAC] == PI[playerid][pMember]) {
			format(string, sizeof(string), "%s%d\t%s\t%d ранг\t%d\n", string, i,PI[i][pName],PI[i][pRang], PI[i][pMember]);
			bugfix = true;
		}
	}
	return ShowPlayerDialog(playerid, (bugfix) ? (7890) : (0), DIALOG_STYLE_TABLIST_HEADERS, "{ee3366}Меню Переводов", (bugfix) ? (string) : ("В данный момент нет заявок на перевод"), "Одобрить", "");
}
callback: CheckWbook(playerid) {
	new rows, fields;
    cache_get_data(rows, fields);
    if(rows) 
	{
		mysql_string[0] = EOS, mf(mysql, mysql_string, 70, "SELECT * FROM `wbook` WHERE `w_name` = '%e'",getName(playerid));
		mysql_function_query(mysql, mysql_string, true, "WorkBook", "i", playerid, getName(playerid));
	}
	else SCM(playerid, COLOR_GREY, !"У вас нет истории в трудовой книге.");
	return 1;
}
CMD:wbook(playerid, params[]) 
{
    new targetPlayer;
    
    // Если параметр пуст, то выполняем запрос для текущего игрока
    if(sscanf(params, "u", targetPlayer)) 
    {
        targetPlayer = playerid;
    }
    
    if(!IsPlayerConnected(targetPlayer)) 
        return SCM(playerid, COLOR_GREY, "Игрок не в сети");

    if(!IsPlayerLogged{targetPlayer}) return SCM(playerid, COLOR_GREY, "Игрок не авторизован");

    new Float:x, Float:y, Float:z;
    GetPlayerPos(targetPlayer, x, y, z);

    if(!PlayerToPoint(10.0, playerid, x, y, z)) 
        return SCM(playerid, COLOR_GREY, "Игрок находится слишком далеко");

    mysql_string[0] = EOS, mf(mysql, mysql_string, 70, "SELECT * FROM `wbook` WHERE `w_name` = '%e'", getName(targetPlayer));
    mysql_function_query(mysql, mysql_string, true, "WorkBook", "dd", playerid, targetPlayer);

    return 1;
}

callback: WorkBook(playerid, id) 
{
    new rows, fields;
    cache_get_data(rows, fields);

    if (rows == 0) 
        return ShowPlayerDialog(id, 0, DIALOG_STYLE_MSGBOX, "{ee3366}Трудовая книга", "Нет данных", "Закрыть", "");

    new str_3[512*2] = "", str[64], reas[60], temp[30];
	new w_d, w_m, w_y, fracname5, rank;

    for (new i = 0; i < rows; i++) 
    {
		reas[0] = EOS, temp[0] = EOS, str[0] = EOS;

        cache_get_field_content(i, "w_day", temp), w_d = strval(temp);
        cache_get_field_content(i, "w_mes", temp), w_m = strval(temp);
        cache_get_field_content(i, "w_year", temp), w_y = strval(temp);
        cache_get_field_content(i, "w_fraction", temp), fracname5 = strval(temp);
        cache_get_field_content(i, "w_rank", temp), rank = strval(temp);
        cache_get_field_content(i, "w_reason", reas, sizeof(reas), mysql);

		switch(fracname5)
	 	{
	 	    case 1: f(str,sizeof(str),"%s",rang_gov[rank-1][frName]);
			case 2: f(str,sizeof(str),"%s",rang_army[rank-1][frName]);
			case 3: f(str,sizeof(str),"%s",rang_police[rank-1][frName]);
			case 4: f(str,sizeof(str),"%s",rang_hospital[rank-1][frName]);
		    case 5: f(str,sizeof(str),"%s",rang_skinhead[rank-1][frName]);
		    case 6: f(str,sizeof(str),"%s",rang_gopota[rank-1][frName]);
		    case 7: f(str,sizeof(str),"%s",rang_kavkaz[rank-1][frName]);
		}

        f(str_3, sizeof(str_3), "%s%d %s %d г.{FFFFFF}\t%s - %s[%d]\t%s\n", 
               str_3, w_d, monthNames[w_m - 1], w_y, 
               Fraction_Name[fracname5], str, rank, reas);
    }

    global_str[0] = EOS;
    f(global_str, 1256, "Уход из организации\tОрганизация - ранг\tПричина ухода\n%s", str_3);

    return ShowPlayerDialog(id, 0, DIALOG_STYLE_TABLIST_HEADERS, "{ee3366}Трудовая книга", global_str, "Закрыть", "");
}

CMD:anim(playerid)
{
	if(GetPVarInt(playerid, "anim_load") != 1)
	{
		PreloadAnimLib(playerid,"SMOKING");
		PreloadAnimLib(playerid,"BD_FIRE");
		PreloadAnimLib(playerid,"BEACH");
		PreloadAnimLib(playerid,"RAPPING");
		PreloadAnimLib(playerid,"BOMBER");
		PreloadAnimLib(playerid,"BSKTBALL");
		PreloadAnimLib(playerid,"COP_AMBIENT");
		PreloadAnimLib(playerid,"GRAVEYARD");
		PreloadAnimLib(playerid,"RYDER");
		PreloadAnimLib(playerid,"MISC");
		PreloadAnimLib(playerid,"ON_LOOKERS");
		PreloadAnimLib(playerid,"RIOT");
		PreloadAnimLib(playerid,"PARK");
		PreloadAnimLib(playerid,"CRACK");
		PreloadAnimLib(playerid,"INT_HOUSE");
		PreloadAnimLib(playerid,"SWAT");
		PreloadAnimLib(playerid,"GFUNK");

		SetPVarInt(playerid, "anim_load",1);
		return true;
	}
	if(GetPlayerState(playerid) != PLAYER_STATE_ONFOOT) return SCM(playerid, COLOR_GREY, !"Нельзя использовать в транспорте!");
	ShowPlayerDialog(playerid,dialog_ANIM,DIALOG_STYLE_LIST, !"{ee3366}Список анимаций:", 
	!"1. Поднять руки вверх\n\
	2. Курить\n\
	3. Мыть руки\n\
	4. Сесть на землю\n\
	5. Лечь на спину\n\
	6. Лечь и приподнять ногу\n\
	7. Читать рэп \n\
	8. Прилечь\n\
	9. Установить бомбу\n\
	10. Поза вратаря\n\
	11. Сложить руки\n\
	12. Плакать (девушка)\n\
	13. Пьяная походка\n\
	14. Голосовать\n\
	15. Поднять руку\n\
	16. Поднять руки\n\
	17. Облокотиться\n\
	18. Смотреть на небо\n\
	19. Махать рукой\n\
	20. Болельщик\n\
	21. Медитация\n\
	22. Facepalm\n\
	23. Заложник\n\
	24. Справить нужду", "Выбрать","Отмена");
	return true;
}
CMD:givegun(playerid, params[]) 
{
	if(!IsPlayerOPG(playerid))  return SCM(playerid, COLOR_GREY,"Вы не состоите в ОПГ");
 	if(sscanf(params, "ud", params[0], params[1])) return SCM(playerid, COLOR_LIGHTGREY, !"Используйте: /givegun [ID игрока] [кол-во]");
    if(PI[params[0]][pWeaponLock] > 0) return SCM(playerid, COLOR_GREY,"У данного игрока блокировка оружия");
	if(playerid == params[0]) return SCM(playerid, COLOR_GREY,"Нельзя передавать самому себе");
    if(!IsPlayerConnected(params[0]))return  SCM(playerid, COLOR_GREY,"Данного ID нет на сервере");
	if(PI[params[0]][pMember] != PI[playerid][pMember]) return SCM(playerid, COLOR_GREY,"Данный игрок не состоит в вашей организации");
	if(!IsPlayerLogged{params[0]}) return SCM(playerid, COLOR_GREY,"Данный игрок не прошел авторизацию");
	if(params[1] < 1) return SCM(playerid, COLOR_GREY,"Минимальное значение патрон 1");
	if(PI[params[0]][pLevel] < 2) return SCM(playerid, COLOR_GREY,"У игрока нет 2-го уровня");
	new Float:x,Float:y,Float:z;
	GetPlayerPos(playerid, x,y,z);
    if(!PlayerToPoint(5.0, params[0], x,y,z)) return SCM(playerid, COLOR_GREY,"Нужно находиться возле игрока");
	new gun = GetPlayerWeapon(playerid);
	new gunslot = getWeaponIdSlot(gun);
	if(gun == 38 && gun == 34 && gun == 35 && gun == 36 && gun == 37 && gun == 39 && gun == 40) return SCM(playerid, COLOR_GREY,"Нельзя передать данное оружие");
	if(params[1] < 1) return SCM(playerid, COLOR_GREY,"Недопустимое значение");
	if(PI[playerid][data_GUN][gunslot] == 0 || gunslot == 0) return SCM(playerid, COLOR_GREY,"Чтобы передать оружие, нужно взять его в руки");
	if(PI[playerid][data_AMMO][gunslot] < params[1]) return SCM(playerid, COLOR_GREY, "У Вас нет такого количества патронов");
	return SendRequestForPlayer(playerid, params[0], 15, params[1]);
}
stock PlayerGetsChatBan(playerid, text[]) 
{
	new g = random(777);
	return SendAdminsMessagef(0xa0bbbbFF, "[Варнинг] <#%d> %s[%i] отправил сообщение: %s",g, getName(playerid), playerid, text);
}
stock CheckString(string[]) 
{
    static const WebSites[][] = {
		"NEW IP","Заходите на лучший сервер",".com","46","176 46","точка ру",".su",".info",
		"Переезд","Новый сервер","NEW IP","ну что го сливать админку","ну что го сливать лидерку",
		"Переехали","переезжаем","дам админку","переехали",". ru","нубо сервер","нубомод","дносервер","нубосервер",""
	};
	for(new i = 0; i < sizeof(WebSites); i++) if(strfind(string, WebSites[i], true) != -1) return 1;
	return 0;
}
CMD:phone(playerid) 
{
	if(PI[playerid][pPhone] == 0) return SCM(playerid, COLOR_GREY,"У вас нет телефона");
	if(PI[playerid][pPhoneStatus] == 1) 
	{
		ShowPlayerDialog(playerid, 7220, DIALOG_STYLE_LIST, "{ee3366}Телефон", "\
		1. Информация\n\
		2. Позвонить\n\
		3. Отправить SMS\n\
		4. Мобильный банк\n\
		5. Телефонная книга\n\
		6. Телефонные услуги\n\
		{f8f897}7. Выключить телефон", "Выбрать", "Отмена");
		return 1;
	}
	else return ShowPlayerDialog(playerid, 7210, DIALOG_STYLE_LIST, "{ee3366}Телефон", "1. Информация\n{f8f897}2. Включить телефон", "Выбрать", "Отмена");
}
stock IsAtBankomat(playerid, Float:distance) 
{
    for(new i = 0;i < sizeof(Bankomats); i ++) 
	{
		if(IsPlayerInRangeOfPoint(playerid, distance, Bankomats[i][0], Bankomats[i][1], Bankomats[i][2])) return 1;
	}
	return 0;
}
CMD:time(playerid)
{
	if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT) ApplyAnimation(playerid, "COP_AMBIENT", "Coplook_watch", 4.1, 0, 0, 0, 0, 0);
  	new hour, minuite, Year, Month, Day, month[10];
  	gettime(hour,minuite);
	getdate(Year, Month, Day);
	switch(Month)
	{
		case 1: month = "01";
		case 2: month = "02";
		case 3: month = "03";
		case 4: month = "04";
		case 5: month = "05";
		case 6: month = "06";
		case 7: month = "07";
		case 8: month = "08";
		case 9: month = "09";
		case 10: month = "10";
		case 11: month = "11";
		case 12: month = "12";
	}
	GameTextForPlayerf(playerid, 5000, 1, "~g~%d.%s.%d~y~ %02d:%02d~n~~w~В игре ~b~%d мин~n~~w~Сервер ~b~1", Day, month,Year, hour,minuite, PI[playerid][data_TIME]);
    SetPlayerChatBubble(playerid, "Cмотрит на часы", 0xFF99CCFF, 20.0, 4000);
	return true;
}
callback: WbookOff(playerid, name[]) 
{
    new rows, fields,temp[256],w_player, w_rank;
    cache_get_data(rows, fields);
    if(rows) 
	{
		cache_get_field_content(0, "id", temp), w_player = strval(temp);
		cache_get_field_content(0, "rank", temp), w_rank = strval(temp);

		new text[24];
		GetPVarString(playerid,"text_wbook", text, sizeof(text));
		FixSVarString(text);

		new year, month, day ;
		getdate(year, month, day);

		mysql_string[0] = EOS, mf(mysql, mysql_string, 250, "INSERT INTO `wbook`(`w_player`,`w_fraction`,`w_name`,`w_reason`,`w_rank`,`w_day`,`w_mes`,`w_year`) VALUES ('%d','%d','%s','%s','%d','%d','%d','%d')", w_player, PI[playerid][pMember], name, text, w_rank, day, month, year);
		mysql_function_query(mysql, mysql_string, false, "", "");
	}
	return 1;
}
callback: PhoneBook(playerid) 
{
    new rows, fields, temp[144], p_number, p_name[32];
    cache_get_data(rows, fields);
	new str_1[185];
	new str_3[185];
    for(new i = 0; i < rows; i++) 
	{
		cache_get_field_content(i, "number", temp), p_number = strval(temp);
		cache_get_field_content(i, "name", p_name, mysql, 32);
		format(str_3,sizeof(str_3),"%s{FFFFFF}%s\t\tт. %d\n", str_3, p_name, p_number);
	}
	format(str_1,sizeof(str_1), "{FFFF99}Добавить контакт{FFFFFF}\n%s",str_3);
	ShowPlayerDialog(playerid, 7229, DIALOG_STYLE_TABLIST, "{ee3366}Телефонная книга", str_1, "Далее", "Назад");
	return 1;
}
callback: PhoneBookAddCheck(playerid, name[]) 
{
	new rows, fields;
    cache_get_data(rows, fields);
    if(rows) SCM(playerid, COLOR_GREY, !"Данное имя контакта уже используйется");
	else 
	{
	    new text[24];
		GetPVarString(playerid,"name_pb", text, sizeof(text));
		FixSVarString(text);
		mysql_string[0] = EOS, mf(mysql, mysql_string, 70, "SELECT * FROM `accounts` WHERE `Name` = '%e'", text);
	    mysql_function_query(mysql, mysql_string, true, "PhoneBookAdd", "ds", playerid, text);
	}
	return 1;
}
callback: PhoneBookAdd(playerid, name[]) 
{
    new rows, fields;
    cache_get_data(rows, fields);
    if(rows) 
	{
		new text[24];
		GetPVarString(playerid,"name_pb", text, sizeof(text));
		FixSVarString(text);
		new year,month,day;
		getdate(year, month, day);

		mysql_string[0] = EOS, mf(mysql, mysql_string, 260, "INSERT INTO `phonebook`(`name`,`number`,`name_add`,`day`,`mounth`,`year`,`data`) VALUES ('%s','%d','%s','%d','%d','%d',NOW())",text,GetPVarInt(playerid, "number_pb"),getName(playerid),getName(playerid),day,month,year);
		mysql_function_query(mysql, mysql_string, false, "", "");

		SCMf(playerid, 0x3399ffFF, "Вы добавили {ffff33}т. %d{3399ff} в свою телефонную книгу (имя: {ffff33}'%s'{3399ff})", GetPVarInt(playerid, "number_pb"), text);
		DeletePVar(playerid, "name_pb");
	}
	return 1;
}
callback: InfoPhoneBook(playerid) 
{
	new rows, fields,temp[256],string[256],p_number, p_name[32],p_data[20];
    cache_get_data(rows, fields);
    for(new i = 0; i < rows; i++) 
	{
		cache_get_field_content(i, "number", temp), p_number = strval(temp);
		cache_get_field_content(i, "name", p_name, mysql, 32);
		cache_get_field_content(i, "data", p_data, mysql, 20 );
		format(string,sizeof(string),"%s{FFFFFF}Имя контакта: {3377cc}%s\n{FFFFFF}Номер телефона: {3377cc}%d\n{FFFFFF}Время добавления: {3377cc}%s", string, p_name, p_number, p_data);
	}
	return ShowPlayerDialog(playerid,0, DIALOG_STYLE_MSGBOX, !"{ee3366}Информация о контакте", string, "Закрыть", "");
}
callback: CallPhoneBook(playerid) 
{
	new rows, fields,temp[64],p_number;
    cache_get_data(rows, fields);
    for(new i = 0; i < rows; i++) 
	{
		cache_get_field_content(i, "number", temp), p_number = strval(temp); 
		{
			new str_1[12];
			format(str_1, sizeof(str_1), "%d", p_number);
			callcmd::call(playerid, str_1);
		}
	}
	return 1;
}
callback: SmsPhoneBook(playerid) {
	new rows, fields,temp[64],p_number;
    cache_get_data(rows, fields);
    for(new i = 0; i < rows; i++) {
		cache_get_field_content(i, "number", temp), p_number = strval(temp); {
			new text[144];
			GetPVarString(playerid,"sms_pb", text, sizeof(text));
			FixSVarString(text);
			new str_1[256];
			format(str_1, sizeof(str_1),"%d %s",p_number,text);
			callcmd::sms(playerid,str_1);
		}
	}
	return 1;
}
callback: ChangeNumberPhoneBook(playerid) 
{
	new name[24];
	GetPVarString(playerid,"pb_namecont", name, sizeof(name));
	FixSVarString(name);

	mysql_string[0] = EOS, mf(mysql, mysql_string, 160, "UPDATE `phonebook` SET `number` = '%d' WHERE `name` = '%e' AND `name_add` = '%e'", GetPVarInt(playerid, "number_pb"), name, getName(playerid));
	mysql_function_query(mysql, mysql_string, false, "", "");

	SCMf(playerid, 0x3399ffFF, "Номер кантакта изменён на {ffff33}%d", GetPVarInt(playerid, "number_pb"));
	DeletePVar(playerid, "pb_namecont");
	DeletePVar(playerid, "number_pb");
	return 1;
}
callback: ChangeNamePhoneBook(playerid) {
	new name[24];
	GetPVarString(playerid,"pb_namecont", name, sizeof(name));
	FixSVarString(name);
	new text[24];
	GetPVarString(playerid,"c_name", text, sizeof(text));
	FixSVarString(text);

	mysql_string[0] = EOS, mf(mysql, mysql_string, 155, "UPDATE `phonebook` SET `name` = '%e' WHERE `name` = '%e' AND `name_add` = '%e'", text, name, getName(playerid));
	mysql_function_query(mysql, mysql_string, false, "", "");

	SCMf(playerid, 0x3399ffFF, "Имя контакта изменено на {ffff33}'%s'", text);
	DeletePVar(playerid, "pb_namecont");
	DeletePVar(playerid, "name_pb");
	return 1;
}
callback: DeletePhoneBook(playerid) 
{
	new name[24];
	GetPVarString(playerid,"pb_namecont", name, sizeof(name));
	FixSVarString(name);

	mysql_string[0] = EOS, mf(mysql, mysql_string, 113, "DELETE FROM `phonebook` WHERE `name` = '%e' AND `name_add` = '%e'", name, getName(playerid));
	mysql_function_query(mysql, mysql_string, false, "", "");

	SCM(playerid, COLOR_TOMATO, "Вы удалили контакт из телефонной книги");
	DeletePVar(playerid, "pb_namecont");
	DeletePVar(playerid, "name_pb");
	return 1;
}
stock GetNearestVehicle(playerid) 
{
    for(new i=1,Float:x,Float:y,Float:z; i<MAX_VEHICLES; ++i) 
	{
        if(IsVehicleStreamedIn(i, playerid)) 
		{
            GetVehiclePos(i, x, y, z);
            if(IsPlayerInRangeOfPoint(playerid, 5.0, x, y, z)) return i;
        }
    }
    return 0;
}
callback: LoadBang() 
{
    new rows, fields, temp[60], time = GetTickCount(),gunb;
    cache_get_data(rows, fields);
    if(rows) 
	{
		mysql_string[0] = EOS;

    	for(new g = 0; g < rows; g++) 
		{
         	cache_get_field_content(g, "id", temp), BanGun[g][pID] = strval (temp);
         	cache_get_field_content(g, "bangun", temp), BanGun[g][pDay] = strval (temp);
			TotalG++;
   			if(BanGun[g][pDay] >= 1) 
			{
				BanGun[g][pDay]--;
			    mf(mysql, mysql_string, 62, "UPDATE `accounts` SET `bangun` = '%d' WHERE `id` = '%d'",BanGun[g][pDay], BanGun[g][pID]);
			    mysql_function_query(mysql, mysql_string, false, "", "");
			}
			else 
			{
			    mf(mysql, mysql_string, 60, "UPDATE `accounts` SET `bangun` = '0' WHERE `id` = '%d'",BanGun[g][pID]);
	    		mysql_function_query(mysql, mysql_string, false, "", "");
	    		gunb++;
			}
		}
		printf("[INFO]  Load gun ban accounts. Load: %d. Unbang: %d. Ex unbang: %d. Time: %d ms.",TotalG,gunb,TotalG-gunb, GetTickCount()-time);
  	}
    return 1;
}
stock NameRang(id) 
{
	new name[24];
	switch(PI[id][pMember]) 
	{
	    case 1:format(name,sizeof(name),"%s", rang_gov[PI[id][pRang]-1][frName]);
	    case 2:format(name,sizeof(name),"%s", rang_army[PI[id][pRang]-1][frName]);
	    case 3:format(name,sizeof(name),"%s", rang_police[PI[id][pRang]-1][frName]);
	    case 4:format(name,sizeof(name),"%s", rang_hospital[PI[id][pRang]-1][frName]);
     	case 5:format(name,sizeof(name),"%s", rang_skinhead[PI[id][pRang]-1][frName]);
   		case 6:format(name,sizeof(name),"%s", rang_gopota[PI[id][pRang]-1][frName]);
	    case 7:format(name,sizeof(name),"%s", rang_kavkaz[PI[id][pRang]-1][frName]);
	}
    return name;
}
CMD:plus(playerid) 
{
    ShowPlayerDialog(playerid, dialog_DONATE_VIP, DIALOG_STYLE_MSGBOX, !"{ee3366}Приобретение '"NAMEVIP"'", "\
		{FFFFFF}Примущества, которые даёт подписка {FFA500}"NAMEVIP"\n\n\
		{3366cc}1. Уникальная личность\n\
		{FFFFFF}Ваш никнейм в чате будет выделен постфиксом: Ivan_Ivanov {FFA500}["VIP_TAG"]{FFFFFF}\n\
		{3366cc}2. Топливная карта\n\
		{FFFFFF}Скидка при заправке на АЗС (15%%)\n\
		{3366cc}3. Почётный гражданин\n\
		{FFFFFF}Скидка при оплате квартплаты дома и квартиры (30%%)\n\
		{3366cc}4. Знай меру\n\
		{FFFFFF}Полное отсутствие эффекта зависимости\n\
		{3366cc}5. Меценат\n\
		{FFFFFF}Кол-во донат-поинтов при пополнении увеличивается на 5%%\n\
		{3366cc}6. Рабочий класс\n\
		{FFFFFF}Бесплатный инвентарь на временных работах (для 1 и 2 уровней)\n\
		{3366cc}7. Большие карманы\n\
		{FFFFFF}Вместимость инвентаря увеличивается в 2 раза\n\
		{3366cc}8. Карьерист\n\
		{FFFFFF}Возможность покинуть организацию в любой момент (/leave)\n\
		{3366cc}9. Выгодный тариф\n\
		{FFFFFF}Цены на звонки, SMS и телефонные учлуги снижены\n\
		{3366cc}10. Олды на месте\n\
		{FFFFFF}Вы получите в два раза больше очков опыта за каждый PayDay", "Купить", "Отмена");
    return 1;
}
stock IsPlayerGreenZone(playerid) 
{
	if(IsPlayerInRangeOfPoint(playerid, 100.0, 2085.7090,1819.6904,12.1208) && GetPlayerVirtualWorld(playerid) == 0 || // БЦРБ
	PlayerToKvadrat(playerid, 1784, 2060.5, 1878, 2132.5) && GetPlayerVirtualWorld(playerid) == 0 || // Правительство
	PlayerToKvadrat(playerid, 1765, 2476.5, 1846, 2536.5) && GetPlayerVirtualWorld(playerid) == 0 || // рудник
	PlayerToKvadrat(playerid, 1851, 1837.5, 1918, 1906.5) && GetPlayerVirtualWorld(playerid) == 0 || // казино
	PlayerToKvadrat(playerid, 1851, 1837.5, 1918, 1906.5) && GetPlayerVirtualWorld(playerid) == 0 || // спавн новичков 1
	PlayerToKvadrat(playerid, 1771.5, 1418.1666259765625, 1871.5, 1518.1666259765625) && GetPlayerVirtualWorld(playerid) == 0) return true; // автошкола
	return 0;
}
callback: PayDay(playerid)
{
	if(IsPlayerLogged{playerid}) 
	{
		switch(random(1)) 
		{
			case 0: SetWeather(1);
			case 1: SetWeather(1);
		}
		new hour, minute, second;
		gettime(hour, minute, second);
		SetWorldTime(hour);

		if(hour == 0 && minute == 0) 
		{
			PI[playerid][data_TIME] = 0;
			PI[playerid][pHealthPackKD] = 0;
			mysql_query(mysql, "UPDATE `accounts` SET time = '0' WHERE time != '0'");
			mysql_query(mysql, "UPDATE `accounts` SET reports = '0' WHERE reports != '0'");
			mysql_query(mysql, "UPDATE `accounts` SET HEALPACKSKLAD = '0'");
		}

		SCMf(playerid, -1, "Московское время {3377CC}%02d:%02d", hour, minute);
		SCM(playerid, -1, !"Клиент банка пгт. Батырево:");
		SCM(playerid, -1, !"____________________________");
		if(PI[playerid][pAFK] > 5) 
		{
			SCM(playerid, COLOR_GREY, !"Для получения PayDay необходимо не находиться на паузе");
			SCM(playerid, -1, "____________________________");
			return 1;
		}
		if(PI[playerid][data_TIME] < 20) 
		{
			SCM(playerid, COLOR_GREY, !"Для получения PayDay необходимо отыграть минимум 20 минут");
			SCM(playerid, -1, "____________________________");
			return 1;
		}
		switch(PI[playerid][pMember]) 
		{
			case 1..4: PI[playerid][pPayDayMoney] = 3000+(750*PI[playerid][pRang]);
			case 5,6,7:
			{
				if(PI[playerid][pRang] < 9) PI[playerid][pPayDayMoney] = 15000+PI[playerid][pPayDayMoney];
				else PI[playerid][pPayDayMoney] = 5000+PI[playerid][pPayDayMoney];
			}
		}

		PI[playerid][pExp]++;
		if(PI[playerid][pRespect] < 100) PI[playerid][pRespect]++;
		if(PI[playerid][pWanted] > 0) 
		{
			PI[playerid][pWanted]--;
			SetPlayerWantedLevel(playerid, PI[playerid][pWanted]);
		}

		new AdminPayDay = 15000*PI[playerid][pAdmin];

		PI[playerid][pBank] += PI[playerid][pPayDayMoney];
		SCMf(playerid, -1, "Зарплата: {ee3366}%d руб", PI[playerid][pPayDayMoney]);
		if(PI[playerid][pAdmin] != 0) SCMf(playerid, -1, "Зарплата игрового мастера: {ee3366}%d руб", AdminPayDay);
		SCMf(playerid, -1, "Текущий баланс зарплатного счёта: {ee3366}%d руб", PI[playerid][pBank]);

		if(PI[playerid][pPayDayMoney] > 0)
		{
			transfer_log[0] = EOS, f(transfer_log, 26, "+ Зарплата %d руб", PI[playerid][pPayDayMoney]);
			TransferBank_log(playerid, PI[playerid][pPayDayMoney], transfer_log);
		}

		PI[playerid][pPayDayMoney] = 0;
		CheckNextLevel(playerid);

		SCM(playerid, -1, !"____________________________");

		SavePlayerData(playerid);
	}
	else return SCM(playerid, COLOR_GREY, !"Вы не авторизированы для получения зарплаты");

	return 1;
}
CMD:lname(playerid, params[]) 
{
    if(PI[playerid][pRang] < 10) return 1;
	if(sscanf(params, "s[30]", params[0]))return SCM(playerid, COLOR_LIGHTGREY, !"Используйте: /lname [имя]");
	mysql_string[0] = EOS, mf(mysql, mysql_string, 79, "SELECT `id` FROM `accounts` WHERE `Name` = '%e' LIMIT 1", params[0]);
	mysql_tquery(mysql, mysql_string, "nameleader_check", "i", playerid);
	return 1 ;
}
callback:nameleader_check(playerid) {
	new rows, fields ;
	cache_get_data(rows, fields);
	if (!rows) return SCM(playerid, COLOR_GREY,"Не удалось найти игроков с указанным никнеймом");
	new db_increment = cache_get_field_content_int(0, "id", mysql);
	mysql_string[0] = EOS, mf(mysql, mysql_string, 79, "SELECT * FROM `nickname_history` WHERE `nh_owner` = '%d'", db_increment);
	mysql_tquery(mysql, mysql_string, "sql_lname", "i", playerid);
	return 1 ;
}
callback:sql_lname(playerid) 
{
	new rows, fields;
	cache_get_data(rows, fields);
	if(!rows) return SCM(playerid, COLOR_GREY,"Игрок не менял имена");
	new str_1[256];
	strcat(str_1, "Старый никнейм - Новый никнейм - Дата изменения\n\n");
	for(new j = 0; j < rows; j ++ ) 
	{
		new _nh_oldname[MAX_PLAYER_NAME ],_nh_newname[MAX_PLAYER_NAME ],_nh_date[20],line_string[68];
		cache_get_field_content(j, "nh_oldname", _nh_oldname, mysql, MAX_PLAYER_NAME);
		cache_get_field_content(j, "nh_newname", _nh_newname, mysql, MAX_PLAYER_NAME);
		cache_get_field_content(j, "nh_date", _nh_date, mysql, 20 );
		format(line_string, sizeof (line_string), "%s - %s - %s\n", _nh_oldname, _nh_newname, _nh_date);
		strcat(str_1, line_string);
	}
	return ShowPlayerDialog(playerid, 0, DIALOG_STYLE_MSGBOX, "История никнеймов", str_1, "Закрыть", "");
}
callback: ChangeServer0() 
{
	SendRconCommand("hostname "NAMESERVER" | Обновление");
	SetTimer("ChangeServer1", 3000, false);
}
callback: ChangeServer1() 
{
	SendRconCommand("hostname "NAMESERVER" | Первый сервер");
	SetTimer("ChangeServer1", 3000, false);
}
stock ClearGroup(playerid) {
	PI[playerid][pGroupID] = -1;
	UpdatePlayerDataInt(playerid, "GroupID", PI[playerid][pGroupID]);
}
public OnPlayerLeaveDynamicArea(playerid, areaid) 
{
	if(areaid == ArmyStorageZone) 
	{
		KillTimer(TimetTheftCartridges[playerid]);
		DisablePlayerCheckpoint(playerid);
	}
	if(areaid == WarZoneCube)
	{
		if(PI[playerid][pOnCapture] == 1 && GangWarStatus >= 1)
		{
			AutoKickCapture(playerid);
			CheckCount(playerid);
		}
	}
	/*if(areaid == capturezonespawn) 
	{
		if(GangWarStatus > 0) 
		{
			if(IsPlayerToKvadrat(playerid, 1449.5,-1355, 1591.5, -1133)) 
			{
				if(PI[playerid][pMember] != Command[0] && PI[playerid][pMember] != Command[1] )
				if(PI[playerid][pAntiCLMenu] != 1 )
				{
					SetPlayerPosAC(playerid, 1428.1783,-1150.3796,11.7327);
					SCM(playerid, COLOR_LIGHTBLUE, "Вы попали в зону стрелы и были возвращены за eё пределы");
				}
				else 
				{
					if(PI[playerid][pMaskWorn] == 1) 
					{
						SetPlayerColorEx(playerid);
   						PI[playerid][pMaskWorn] = 0;
						SCM(playerid, COLOR_LIGHTBLUE, "В данный момент идёт захват территории с вас автоматический была снята маска");
					}
				}
				else 
				{
				        if(PI[playerid][pAntiCLMenu] == 1) 
						{
						SCM(playerid, COLOR_LIGHTBLUE, "У вас имеется запрет на проведенние стрелы");
						SetPlayerPosAC(playerid, 1428.1783,-1150.3796,11.7327);
					}
				}
				return 1;
		    }
	    }
	}*/
	return 1;
}
callback: setleaderskin(playerid) {
    new rows, fields,temp[10];
    new idg,skin_m,skin_g,gname[32];
    cache_get_data(rows, fields);
    for(new i = 0; i < rows; i++) {
		cache_get_field_content(i, "id", temp), idg = strval (temp);
		cache_get_field_content(i, "skin_m", temp), skin_m = strval(temp);
		cache_get_field_content(i, "skin_g", temp), skin_g = strval(temp);
		cache_get_field_content(i, "group_name", gname, mysql, 32);
		strmid(PI[playerid][pGroupName], gname, 0, strlen(gname), 25);
		PI[playerid][pGroupID] = idg;
		UpdatePlayerDataInt(playerid, "GroupID", PI[playerid][pGroupID]);
		if(PI[playerid][pSex] == 1)
		{
			PI[playerid][pOrgSkin] = skin_m;
			SetPlayerSkinAC(playerid,PI[playerid][pOrgSkin]);
			UpdatePlayerDataInt(playerid, "skinm", PI[playerid][pOrgSkin]);
		}
		if(PI[playerid][pSex] == 2)
		{
			PI[playerid][pOrgSkin] = skin_g;
			SetPlayerSkinAC(playerid,PI[playerid][pOrgSkin]);
			UpdatePlayerDataInt(playerid, "skinm", PI[playerid][pOrgSkin]);
		}
	}
	return 1;
}
stock CarInformation(playerid) 
{
	ShowPlayerDialog(playerid, 0, DIALOG_STYLE_MSGBOX, !"{ee3366}Руководство по эксплуатации", "\
	{FFFFFF}Этот гайд поможем Вам изучить управление новым транспортом.\n\
	{FFFFFF}Меню личного транспорта - команда {3366cc}/car\n\n\
	{3366cc}1. Загрузка:\n\
	{FFFFFF}Чтобы загрузить транспорт выйдите из автосалона на парковку, затем введите {3366cc}/car{FFFFFF},\n\
	{FFFFFF}найдите в списке {3366cc}'%s'{FFFFFF} и нажмите 'Загрузить'. Транспорт повявится на парковке.\n\n\
	{3366cc}2. Выгрузка:\n\
	{FFFFFF}Чтобы выгрузить транспорт введите {3366cc}/car{FFFFFF} и выберите пункт 'Выгрузить'.\n\
	{FFFFFF}Транспорт будет автоматически выгружен в случае выхода из игры.\n\n\
	{3366cc}3. Ключ зажигания:\n\
	{FFFFFF}Вставив ключ зажигания {3366cc}(команда /key){FFFFFF}, Вы сможете завести двигатель.\n\
	{FFFFFF}Обратите внимание, что если Ваш  транспорт будет открыт, его сможет угнать другой игрок!\n\n\
	{3366cc}4. Центральный замок:\n\
	{FFFFFF}Открытие и закрытие дверей осуществляется {3366cc}командой /lock{FFFFFF}.\n\
	{FFFFFF}Для управления центральным замком необходимо находиться рядом с транспортом\n\n\
	{3366cc}5. Парковка:\n\
	{FFFFFF}Вы можете припарковать Ваш транспорт командой {3366cc}/park{FFFFFF} практически везде.\n\
	{FFFFFF}После парковки транспорт будет загружаться на новой позиции (например, около дома).\n\n\
	{FFA53366cc00}Удачи на дороне, соблюдайте Правила Дорожного Движения!", "Закрыть", "");
	return 1;
}
CMD:settings(playerid) return ShowSettings(playerid);
stock ShowSettings(playerid) 
{
	return ShowPlayerDialog(playerid, 3950, DIALOG_STYLE_LIST, "{ee3366}Настройки аккаунта", "\
	1. Изменить пароль\t\t\t{FFFF99}...\n\
	2. Изменить стиль боя\t\t\t{FFFF99}...\n\
	3. Изменить стиль походки\t\t{FFFF99}...\n\
	4. Кинематографический режим\t{FFFF99}...\n\
	5. Управление аксессуарами\t\t{FFFF99}...", "Изменить", "Назад");
}
cmd:i(playerid) 
{
	return ShowPlayerDialog(playerid, 0, DIALOG_STYLE_LIST, "{ee3366}Получение предметов инвентаря", "\
	1. Получить скин\n\
	2. Получить игровую валюту\n\
	3. Получить транспортное средство\n\
	4. Получить донат-рубли\n\
	5. Активировать бустер", "Далее", "Закрыть");
}
stock GenerateBanCode(size)
{
    static bigletters[26][] = {"A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"},
        numbers[10][] = {"0", "1", "2", "3", "4", "5", "6", "7", "8", "9"},
        code[7];
	code[0] = EOS;
    if(size > sizeof(code)) size = sizeof(code);
    for(new i = 0; i < size; i ++) {
        switch(random(2)) {
            case 0: strcat(code, bigletters[random(sizeof(bigletters))]);
            case 1: strcat(code, numbers[random(sizeof(numbers))]);
        }
    }
    return code;
}
stock SetString(param_1[], const param_2[], size = 300) return strmid(param_1, param_2, 0, strlen(param_2), size);
callback: CheckBan(playerid) 
{
    new rows, fields,temp[174];
    cache_get_data(rows, fields);

    if(rows) 
	{
 	    new day, text[50], id;
        cache_get_field_content(0, "id",temp), id = strval (temp);
        cache_get_field_content(0, "day",temp), day = strval (temp);
		cache_get_field_content(0, "text", text, mysql);
		ShowPlayerDialogf(playerid, dialog_BAN, DIALOG_STYLE_MSGBOX, !"{ee3366}Аккаунт заблокирован", "Закрыть", "", "{ffffff}Никнейм: {396cac}%s\n\
		{FFFFFF}ID аккаунта: {396cac}%s\n\
		{ffffff}Причина блокировки: {FFFFFF}%s\n\
		{ffffff}Срок блокировки: {FFFFFF}%d дня/дней\n\
		{d6d886}Советуем сделать скриншот (клавиша F8), чтобы иметь\n\
		{d6d886}возможность обжаловать бан на форуме", getName(playerid),id,text,day);
	 	Kick(playerid);
	 	return 1;
  	}
	if(!rows) 
	{
		if(PI[playerid][pID] != -1) PlayerLogin(playerid);
		else PlayerRegistration(playerid);
	}
    return 1;
}
callback: MinutTimer() 
{
    if (m_kavkaz > 0 || m_gopota > 0 || m_skinhead > 0) SaveWarehouse();

    if (m_kavkaz > 0) m_kavkaz--;
    if (m_gopota > 0) m_gopota--;
    if (m_skinhead > 0) m_skinhead--;

    return 1;
}

callback: GzInfo(playerid) 
{
    new rows, fields, GzS, GzG, GzO;
    cache_get_data(rows, fields);
    for(new i = 0; i < rows; i++) 
	{
	   	if(gz_info[i][gzopg] == 5) GzS++;
        if(gz_info[i][gzopg] == 6) GzG++;
        if(gz_info[i][gzopg] == 7) GzO++;
    }
	
	static time[15],time1[15],time2[15];
	if(m_kavkaz > 60) time = "час(ов)";
	else time = "минут(а)";
	if(m_skinhead > 60) time1 = "час(ов)";
	else time1 = "минут(а)";
	if(m_gopota > 60) time2 = "час(ов)";
	else time2 = "минут(а)";
	new gz[40],gz1[40],gz2[40];

	switch(m_kavkaz) 
	{
	    case 0: format(gz, sizeof gz, "-");
		case 1..3000: 
		{
			new t;
			if(m_kavkaz > 60) t = m_kavkaz/60;
			else t = m_kavkaz;
			format(gz, sizeof gz, "%d %s", t, time);
		}
	}
	switch(m_skinhead) {
	    case 0: format(gz1, sizeof gz1, "-");
		case 1..3000: {
			new t;
			if(m_skinhead > 60) t = m_skinhead/60;
			else t = m_skinhead;
			format(gz1, sizeof gz1, "%d %s", t, time1);		
		}
	}
	switch(m_gopota) {
	    case 0: format(gz2, sizeof gz2, "-");
		case 1..3000: {
			new t;
			if(m_gopota > 60) t = m_gopota/60;
			else t = m_gopota;
			format(gz2, sizeof gz2, "%d %s", t, time2);
		}
	}	
	new str_3[365];
    format(str_3, sizeof(str_3), "\
	{663399}Скинхеды {FFFFFF}(кол-во территорий: {4086ff}%d{FFFFFF})\nЗаморозка стрелы: %s\n\n\
	{66CCFF}Гопота {FFFFFF}(кол-во территорий: {4086ff}%d{FFFFFF})\nЗаморозка стрелы: %s\n\n\
	{339933}Кавказцы {FFFFFF}(кол-во территорий: {4086ff}%d{FFFFFF})\nЗаморозка стрелы: %s", GzS,gz1, GzG,gz2, GzO,gz);
    return ShowPlayerDialog(playerid,0, DIALOG_STYLE_MSGBOX, !"{ee3366}Информация об ОПГ", str_3, "Закрыть", "");
}
CMD:mp(playerid,params[])
{
	if(MPStatus == false) return SCM(playerid, COLOR_GREY, !"Игровой мастер не создал точку телепорта");
	if(PI[playerid][pJail] != 0) return SCM(playerid, COLOR_GREY, !"Нельзя телепортироваться на мероприятие в КПЗ");
	if(PI[playerid][pDemorgan] != 0) return SCM(playerid, COLOR_GREY, !"Нельзя телепортироваться на мероприятие в деморгане");
	if(PI[playerid][pOnMP] != 0) return SCM(playerid, COLOR_GREY, !"Вы уже находитесь на мероприятии");
	if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER) return SCM(playerid, COLOR_GREY, !"Нельзя телепортироваться на мероприятие в машине");
	if(GetPlayerInterior(playerid) != 0) return SCM(playerid, COLOR_GREY, !"Попасть на мероприятие можно только на улице");
	return ShowPlayerDialog(playerid, 1231, DIALOG_STYLE_MSGBOX, !"{ee3366}Телепортация на мероприятие", !"{FFFFFF}Вы действительно хотите телепортитоватся на мероприятие?\n{FFFF99}Если Вы захотите покинуть мероприятие досрочно, используйте /back", !"Да", !"Нет");
}
CMD:back(playerid) 
{
	if(PI[playerid][pOnMP] != 1) return SCM(playerid, COLOR_GREY, !"Вы не участвуете в мероприятии");
	return ShowPlayerDialog(playerid, 1232, DIALOG_STYLE_MSGBOX, !"{ee3366}Покинуть мероприятие", !"{FFFFFF}Вы действительно хотите покинуть мероприятие?", !"Да", !"Нет");
}
stock ChangeNameMenu(playerid) return ShowPlayerDialog(playerid, dialog_CHANGE_NAME, DIALOG_STYLE_LIST, "{ee3366}Выбор типа", "1. Изменить на случайный никнейм\t\t{FFFF99}Бесплатно\n2. Изменить на свой никнейм\t\t{3366cc}Платно", "Выбор", "Закрыть");
stock RandomName(playerid) 
{
	new rand = random(sizeof(nname));
	SetPVarString(playerid, "randomame", nname[rand]);
	mysql_string[0] = EOS, mf(mysql, mysql_string, 70, "SELECT * FROM `accounts` WHERE `Name` = '%e'", nname[rand]);
	mysql_function_query(mysql, mysql_string, true, "NameCallback", "d", playerid);
}
callback: NameCallback(playerid)
{
    new rows, fields;
    cache_get_data(rows, fields);
    if(rows) SCM(playerid, COLOR_GREY, "Случайный никнейм уже занят другим игроком!"), DeletePVar(playerid, "randomame");
    else 
	{
		new name[24];
		GetPVarString(playerid,"randomame", name, sizeof(name));
		FixSVarString(name);
		ShowPlayerDialogf(playerid, dialog_SETNAME, DIALOG_STYLE_MSGBOX, !"{ee3366}Случайное изменение никнейма", "Да", "Нет", "{FFFFFF}Вы хотите изменить никнейм своего персонажа на {3366cc}'%s'{FFFFFF}?\n\n\
		{FFA500}Обратите внимание, что если Вы измените никнейм во время\n\
		проверки на Вас жалобы, Вы будете заблокированы на 7 дней.", name);
	}
	return true;
}
CMD:j(playerid,params[])
{
    if(PI[playerid][pMute] == 1) return SCM(playerid, COLOR_GREY, !"Ваш чат временно заблокирован");
	if(PI[playerid][pStartJob] < 1) return SCM(playerid, COLOR_GREY, !"Данная команда Вам недоступна");
	if(sscanf(params,"s[100]",params[0])) return SCM(playerid, COLOR_LIGHTGREY, !"Используйте: /j [текст]");
	NotReklama(playerid, params[0]);

	foreach(new i:Player)
	{
		if(PI[i][pStartJob] == PI[playerid][pStartJob]) 
		{
			SCMf(i, 0x69b867FF, "[J | %s] %s[%d]: %s", NameJob(playerid), getName(playerid), playerid, params[0]);
		}
	}

	SetPlayerChatBubble(playerid, "сообщил нечто в рацию", 0xcd7a7aFF, 20.0, 4000);
	return 1;
}
stock NameJob(id)
{
	new nameJob[25];
    switch (PI[id][pStartJob])
    {
        case 9: format(nameJob, 25, "Дальнобойщик");
        case 1: format(nameJob, 25, "Таксист");
        default: format(nameJob, 25, "Неизвестная работа");
    }
	return nameJob;
}
stock SetAccessory(playerid) 
{
	if(PI[playerid][pUseAccessory] == 1) { // Рога
		SetPlayerAttachedObject(playerid, 0, 19314, 2, 0.1180, -0.0050, -0.0040, 0.0000, 0.0000, -83.2000, 0.7080, 0.6020, 0.3050);
	}
	if(PI[playerid][pUseAccessory] == 2) {
		SetPlayerAttachedObject(playerid, 0, 3003, 2, 0.0959, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000, 5.8989, 3.9599, 5.0000, -65536, 0);
		SetPlayerAttachedObject(playerid, 1, 1238, 2, 0.1289, 0.0699, 0.0599, 109.0000, -6.3999, 0.0000, 0.2930, 0.2500, 0.2000, -16777216, 0);
		SetPlayerAttachedObject(playerid, 2, 1238, 2, 0.1319, 0.0769, -0.0480, 81.7000, -7.3999, 1.2999, 0.2930, 0.2500, 0.2000, -16777216, 0);
		SetPlayerAttachedObject(playerid, 3, 3003, 2, 0.1299, 0.1269, 0.0829, 20.9000, 0.0000, 0.0000, 0.4999, 0.3540, 1.0000, 0, 0);
		SetPlayerAttachedObject(playerid, 4, 3003, 2, 0.1319, 0.1369, -0.0529, -6.0999, 0.0000, 0.0000, 0.4999, 0.3540, 1.0000, 0, 0);
	}
	if(PI[playerid][pUseAccessory] == 3) {
		SetPlayerAttachedObject(playerid, 0, 3003, 2, 0.0849, 0.0070, 0.0000, 0.0000, 0.0000, 0.0000, 4.9599, 4.3289, 4.9109, -16777216, 0);
		SetPlayerAttachedObject(playerid, 1, 3003, 2, 0.2689, 0.0070, -0.1919, 0.0000, 0.0000, 0.0000, 3.0499, 0.8379, 2.9219, -16777216, 0);
		SetPlayerAttachedObject(playerid, 2, 3003, 2, 0.2749, 0.0070, 0.1619, 0.0000, 0.0000, 0.0000, 3.0499, 0.8379, 2.9219, -16777216, 0);
		SetPlayerAttachedObject(playerid, 3, 3003, 2, 0.0369, 0.0820, 0.0000, 0.0000, 0.0000, 0.0000, 2.0929, 2.8459, 3.6489, 0, 0);
		SetPlayerAttachedObject(playerid, 4, 3003, 2, 0.1269, 0.0970, 0.0000, 90.0000, 0.0000, 0.0000, 3.0319, 3.3610, 2.3429, 0, 0);
		SetPlayerAttachedObject(playerid, 5, 3003, 2, 0.1329, 0.1539, -0.0539, 65.7000, 0.0000, 0.0000, 1.6439, 1.0110, 0.7239, -16777216, 0);
		SetPlayerAttachedObject(playerid, 6, 3003, 2, 0.1329, 0.1569, 0.0439, 105.4999, 0.0000, 0.0000, 1.6439, 1.0110, 0.7239, -16777216, 0);
		SetPlayerAttachedObject(playerid, 7, 3003, 2, 0.0479, 0.1559, 0.0000, 0.0000, 0.0000, 0.0000, 0.8759, 0.8870, 1.2749, -16777216, 0);
	}
	if(PI[playerid][pUseAccessory] == 4) {
		SetPlayerAttachedObject(playerid, 0, 19352, 2, 0.1169, 0.0040, 0.0000, 0.0000, 90.0000, 90.0000, 1.0000, 1.0000, 1.0000, 0, 0); 
		SetPlayerAttachedObject(playerid, 1, 19469, 1, -0.1630, 0.1909, -0.0080, 3.6000, 54.1000, -14.2999, 5.0589, 3.8849, 7.5640, -65536, 0); 
		SetPlayerAttachedObject(playerid, 2, 1247, 1, 0.0699, 0.2450, 0.1030, 0.0000, 0.0000, -9.0999, 0.5000, 0.5000, 0.5000, -255, 0); 
		SetPlayerAttachedObject(playerid, 3, 19339, 1, 0.4909, -0.1940, -0.4259, 0.0000, 90.0000, 90.0000, 0.5000, 0.5000, 0.5000, 0, 0);
	}
	if(PI[playerid][pUseAccessory] == 5) { //огнемёт
		SetPlayerAttachedObject(playerid, 5, 361, 1,  0.543999, -0.155999, -0.103000,  -177.300079, 176.400054, 0.000000,  0.768000, 0.706000, 0.748999);
	}
	if(PI[playerid][pUseAccessory] == 6) { // красный чемодан
		SetPlayerAttachedObject(playerid,7,19921,5,0.114000,0.040999,-0.044999,93.100112,-12.099985,-75.899986,0.871000,0.899000,0.601999);
	}
	if(PI[playerid][pUseAccessory] == 7) // ЕЛКА НА ПЛЕЧЁ
	{
		new skinid;
		if(PI[playerid][pMember] == 0) skinid = PI[playerid][pSkin];
		else skinid = PI[playerid][pOrgSkin];
		switch (skinid)
		{
			case 1..18: SetPlayerAttachedObject(playerid, 4, 19076, 1, 0.2730, -0.0090, 0.1310, 0.0000, 88.4000, 0.0000, 0.0240, 0.0260, 0.0230, -1, -1);
			case 19..100: SetPlayerAttachedObject(playerid, 4, 19076, 1, 0.2720, 0.0060, 0.1570, 0.0000, 88.4000, 0.0000, 0.0200, 0.0260, 0.0190, -1, -1);
			case 101..103: SetPlayerAttachedObject(playerid, 4, 19076, 1, 0.3150, -0.0270, 0.1420, 0.0000, 88.4000, 0.0000, 0.0200, 0.0260, 0.0190, -1, -1);
			case 104..108: SetPlayerAttachedObject(playerid, 42, 19076, 1, 0.2770, -0.0120, 0.1450, 0.0000, 88.4000, 0.0000, 0.0200, 0.0260, 0.0190, -1, -1);
			case 109: SetPlayerAttachedObject(playerid, 4, 19076, 1, 0.2950, -0.0120, 0.1360, 0.0000, 88.4000, 0.0000, 0.0200, 0.0260, 0.0190, -1, -1);
			case 110..119: SetPlayerAttachedObject(playerid, 4, 19076, 1, 0.2950, -0.0120, 0.1360, 0.0000, 88.4000, 0.0000, 0.0200, 0.0260, 0.0190, -1, -1);
			case 120,122: SetPlayerAttachedObject(playerid, 4, 19076, 1, 0.2810, -0.0120, 0.1580, 0.0000, 88.4000, 0.0000, 0.0200, 0.0260, 0.0190, -1, -1);
			case 123..136: SetPlayerAttachedObject(playerid, 4, 19076, 1, 0.2830, -0.0070, 0.1560, 0.0000, 88.4000, 0.0000, 0.0200, 0.0260, 0.0190, -1, -1);
			case 137..146: SetPlayerAttachedObject(playerid, 4, 19076, 1, 0.2790, -0.0070, 0.1190, 0.0000, 88.4000, 0.0000, 0.0200, 0.0260, 0.0190, -1, -1);
			case 147..154: SetPlayerAttachedObject(playerid, 4, 19076, 1, 0.2940, -0.0070, 0.1400, 0.0000, 88.4000, 0.0000, 0.0200, 0.0260, 0.0190, -1, -1);
			case 155..157: SetPlayerAttachedObject(playerid, 4, 19076, 1, 0.2920, -0.0070, 0.1430, 0.0000, 88.4000, 0.0000, 0.0200, 0.0260, 0.0190, -1, -1);
			case 158..172: SetPlayerAttachedObject(playerid, 4, 19076, 1, 0.2860, -0.0070, 0.1360, 0.0000, 88.4000, 0.0000, 0.0200, 0.0260, 0.0190, -1, -1);
			case 173..187: SetPlayerAttachedObject(playerid, 4, 19076, 1, 0.2990, -0.0070, 0.1170, 0.0000, 88.4000, 0.0000, 0.0200, 0.0260, 0.0190, -1, -1);
			case 188..222: SetPlayerAttachedObject(playerid, 4, 19076, 1, 0.2840, -0.0070, 0.1510, 0.0000, 88.4000, 0.0000, 0.0200, 0.0260, 0.0190, -1, -1);
			case 223..270: SetPlayerAttachedObject(playerid, 4, 19076, 1, 0.2810, -0.0070, 0.1410, 0.0000, 88.4000, 0.0000, 0.0200, 0.0260, 0.0190, -1, -1);
			case 271..279: SetPlayerAttachedObject(playerid, 4, 19076, 1, 0.2950, -0.0190, 0.1540, 0.0000, 88.4000, 0.0000, 0.0200, 0.0260, 0.0190, -1, -1);
			case 280..311: SetPlayerAttachedObject(playerid, 4, 19076, 1, 0.2930, -0.0110, 0.1510, 0.0000, 88.4000, 0.0000, 0.0200, 0.0260, 0.0190, -1, -1);
			default: SCM(playerid, 0xAFAFAFFF, !"Аксессуар елка на плечо, не будет отображаться на этом скине!");
		}
	}
	if(PI[playerid][pUseAccessory] == 8) // Ангельское кольцо
	{
		SetPlayerAttachedObject(playerid, 0, 19197, 2, 0.2100, 0.0000, 0.0000, 0.0000, 84.5000, 0.0000, 0.2660, 0.2730, 0.0000, -1, -1);
	}
	if(PI[playerid][pUseAccessory] == 9) // дигл на спину
	{
		SetPlayerAttachedObject(playerid,5,348,1,-0.343000,-0.159999,0.040999,2.500000,26.900005,-2.100000,2.619001,1.913999,2.307999);
	}
	if(PI[playerid][pUseAccessory] == 10) // шляпа фермера
	{
		SetPlayerAttachedObject(playerid,0,19553,2,0.165999,-0.010000,0.000000,-1.299999,-9.400000,-12.900001,1.086999,1.206000,1.074999);
	}
}
callback: DeathMute(playerid) return SvMutePlayerDisable(playerid);
stock ShowTakeAks(playerid) 
{
	ShowPlayerDialogf(playerid, dialog_TAKE, DIALOG_STYLE_LIST, !"{ee3366}Получение бесплатного акессуара", !"Получить", !"Отмена""\
	1. Рога\t\t\t\t{FFFF99}%s (цена: 35 дп)\n\
	2. Костюм гробовщик\t\t{FFFF99}%s (цена: 35 дп)\n\
	3. Голова Микки-Мауса\t{FFFF99}%s (цена: 35 дп)\n\
	4. Голова Дед-Пула\t\t\t{FFFF99}%s (цена: 25 дп)\n\
	5. Огнемёт\t\t\t{FFFF99}%s (цена: 25 дп)\n\
	6. Красный чемодан\t\t{FFFF99}%s (цена: 10 дп)\n\
	7. Ёлка на плечо\t\t{FFFF99}%s (цена: 25 дп)\n\
	8. Ангельское кольцо \t\t{FFFF99}%s (цена: 40 дп)\n\
	9. Дигл на спину\t\t{FFFF99}%s (цена: 25 дп)\n\
	10. Шляпа фермера\t\t{FFFF99}%s (цена: 15 дп)", 
	(PI[playerid][pAccessory_1]) ? ("(куплен)") : ("(не куплен)"),
	(PI[playerid][pAccessory_2]) ? ("(куплен)") : ("(не куплен)"),
	(PI[playerid][pAccessory_3]) ? ("(куплен)") : ("(не куплен)"),
	(PI[playerid][pAccessory_4]) ? ("(куплен)") : ("(не куплен)"),
	(PI[playerid][pAccessory_5]) ? ("(куплен)") : ("(не куплен)"),
	(PI[playerid][pAccessory_6]) ? ("(куплен)") : ("(не куплен)"),
	(PI[playerid][pAccessory_7]) ? ("(куплен)") : ("(не куплен)"),
	(PI[playerid][pAccessory_8]) ? ("(куплен)") : ("(не куплен)"),
	(PI[playerid][pAccessory_9]) ? ("(куплен)") : ("(не куплен)"),
	(PI[playerid][pAccessory_10]) ? ("(куплен)") : ("(не куплен)"));
}
stock Bomb(Float:x,Float:y,Float:z) 
{
	CreateExplosion(x, y, z, 7, 10.0);
    CreateExplosion(x, y+4.0, z, 7, 10.0);
    CreateExplosion(x, y-4.0, z, 7, 10.0);
    CreateExplosion(x+4.0, y, z, 7, 10.0);
    CreateExplosion(x-4.0, y, z, 7, 10.0);
}
callback: SetRang(tablename[], name[], rank, namegive[], text[]) 
{
	new hour,minute,second,timestr[64];
	gettime(hour,minute,second);
	format(timestr,sizeof(timestr),"%02d:%02d:%02d",hour,minute,second);
	mysql_tqueryf(mysql, "INSERT INTO `%s` (`name`,`name_give`, `rank`, `reason`) VALUES ('%s', '%s', '%d', '%s')", tablename, name, namegive, rank, text);
	return 1;
}
CMD:vc(playerid, params[])
{
    if(PI[playerid][pMute] == 1) return SCM(playerid, COLOR_GREY, !"Ваш чат временно заблокирован");
	if(PI[playerid][pVIP] == 0) return SCM(playerid, COLOR_GREY, !"Данная команда Вам недоступна");
	if(GetPVarInt(playerid, "vrchat") > gettime())return SCM(playerid, COLOR_GREY, !"Отправлять сообщения в этот чат, можно раз в 1 секунду");
    static text[86];
    if(sscanf(params, "s[86]", text)) return SCM(playerid, COLOR_LIGHTGREY, !"Используйте: /vc [текст]");

	new str_vip[144];
	if(PI[playerid][pAdmin] >= 1) format(str_vip, sizeof(str_vip), "{FFA500}[VIP (Игровой Мастер #%d)]{FFFFFF}: %s", PI[playerid][pAdminNumber], text);
	else format(str_vip, sizeof(str_vip), "{FFA500}[VIP] {FFFFFF}%s[%i]: %s", PI[playerid][pName], playerid, text);

    SendVIPMessage(-1, str_vip);
    SetPVarInt(playerid, "vrchat",gettime()+1);
    return 1;
}
public void:OnPlayerKeyDown(player, key) 
{
	if(key == 114)
	{
		if(PI[player][pAdmin] >= 2) 
		{
			ShowPlayerDialogf(player, 7213, DIALOG_STYLE_LIST, "{ee3366}Настройки игрового мастера", "Изменить", "Закрыть", "\
			{FFFFFF}1. Скрытие никнейма \t\t%s\n\
			2. Установить никнейм\t\t\t{FFFFFF}Вручную\n\
			3. Сгенерировать никнейм\t\t{FFFFFF}Автоматически\n\
			4. Установить невидимый скин\t{FFFFFF}...\n\
			5. Выдать себе JetPack\t\t{FFFFFF}...\n\
			{FFFFFF}6. Скрытие админ уведомлений \t\t%s\n\
			{FFFFFF}7. Езда по воде \t\t\t%s\n\
			{FFFFFF}8. Стрельба без перезарядки \t\t%s", 
			PI[player][pAdminStatus] ? ("{4eaa77}Включен{FFFFFF}") : ("{ce6c4f}Отключено{FFFFFF}"),
			PI[player][pAdminChat] ? ("{4eaa77}Включено{FFFFFF}") : ("{ce6c4f}Отключено{FFFFFF}"),
			PI[player][pAdminWatherDriver] ? ("{4eaa77}Включена{FFFFFF}") : ("{ce6c4f}Отключена{FFFFFF}"),
			PI[player][pAdminNoReload] ? ("{4eaa77}Включена{FFFFFF}") : ("{ce6c4f}Отключена{FFFFFF}"));
		}
	}
	if(key == 74) if(PI[player][pRang] > 8) callcmd::lmenu(player);
    if(key == 66) 
	{
		for(new g = 0; g < TotalBusiness; g++) if(IsPlayerInRangeOfPoint(player, 1.3, BizInfo[g][data_BUYX], BizInfo[g][data_BUYY], BizInfo[g][data_BUYZ])) ShowBusinessMenu(player, g);
		if(IsPlayerInRangeOfPoint(player, 25.0, 1565.9385, 1810.2889, 15.5197)) 
		{
			if(army_wh[2] == 0) SendPlayerCenterNotify(player, 2, "Склад закрыт", 5);
			else 
			{
				switch(PI[player][pMember]) 
				{
					case 2,5,6,7: 
					{
						if(IsPlayerInRangeOfPoint(player, 1.0, 1565.9385, 1810.2889, 15.5197)) 
						{
							ApplyAnimation(player,"ON_LOOKERS","POINTUP_IN", 4.1, 0, 0, 0, 0, 0 ,1);
							MoveObject(VchSkladGate, 1568.7144, 1809.5629, 19.4385, 1.9, 0.0000, 0.0000, 90.1401);
							ArmyStorageDoorTimer = SetTimer("CloseArmyStorageDoor", 7000, 0);
						}
						else if(IsPlayerInRangeOfPoint(player, 1.0, 1571.5328, 1809.0415, 15.3236)) 
						{
							ApplyAnimation(player,"ON_LOOKERS","POINTUP_IN", 4.1, 0, 0, 0, 0, 0 ,1);
							MoveObject(VchSkladGate, 1568.7144, 1809.5629, 19.4385, 1.9, 0.0000, 0.0000, 90.1401);
							ArmyStorageDoorTimer = SetTimer("CloseArmyStorageDoor", 7000, 0);
						}
					}
				}
			}
		}
		else if(PlayerToPoint(1.0, player, 1534.6836,1820.4808,578.6213) || PlayerToPoint(1.0, player, 1537.8619,1820.2335,578.6213) || PlayerToPoint(1.0, player, 1540.8298,1820.5121,578.6213)) 
		{
			ShowPlayerDialogf(player, 7999, DIALOG_STYLE_LIST, "{ee3366}Банк", !"Далее", !"Закрыть", "\
				1. Банковская карта {FFFF99}(№ %d)\n\
				{FFFFFF}2. Оплата имущества\n\
				3. Медицинские услуги", PI[player][pID]);
		}
	}
	if(key == 16) 
	{
		if(GetPVarInt(player, "AnimOn") != 0) 
		{
			cef_emit_event(player, "hide-button");
			ClearAnimations(player);
			SetPVarInt(player, "AnimOn", 0);
			SetPVarInt(player,"UseAnim", 0);
			SetPlayerSpecialAction(player, SPECIAL_ACTION_NONE);
		}
		else if(GetPVarInt(player, "SpecBool") == 1) 
		{
			TogglePlayerSpectating(player, false);
		}
	}
	if(key == 17) 
	{
		if(GetPVarInt(player, "SpecBool") == 1 && GetPVarInt(player, "specid") != INVALID_PLAYER_ID)  
		{
			if(IsPlayerInAnyVehicle(GetPVarInt(player, "specid"))) 
			{
				new carid = GetPlayerVehicleID(GetPVarInt(player, "specid"));
				PlayerSpectateVehicle(player, carid);
			}
			else PlayerSpectatePlayer(player,GetPVarInt(player, "specid"));
		}
	}
	if(key == 20) 
	{
		if(GetPVarInt(player, "SpecBool") == 1 && GetPVarInt(player, "specid") != INVALID_PLAYER_ID) 
		{
			callcmd::checkoff(player, PI[GetPVarInt(player, "specid")][pName]);
		}
	}
	if(key == 17)
	{
		if(IsPlayerInAnyVehicle(player) && GetPlayerState(player) == PLAYER_STATE_DRIVER) 
		{
			callcmd::engine(player);
		}
	}
	if(key == 75)
	{
		new carid = GetPlayerVehicleID(player);
		for(new b = 0; b < TotalBusiness; b++)
		{
			if(PlayerToPoint(10.0, player, BizInfo[b][data_BUYX],BizInfo[b][data_BUYY], BizInfo[b][data_BUYZ])) 
			{
				if(BizInfo[b][data_TYPE] == 1) 
				{
					if(IsPlayerInAnyVehicle(player) && GetPlayerState(player) == PLAYER_STATE_DRIVER) 
					{
						new buyvalue = 0, car = GetPlayerVehicleID(player);
						if(CarInfo[car][cFuel] >= 50) SCM(player, COLOR_GREY, !"У Вас уже полный бак (50 литров)");
						else 
						{
							if(PI[player][pMoney] != 0 && PI[player][pMoney] >= BizInfo[b][data_CENA])
							{
								buyvalue = PI[player][pMoney]/BizInfo[b][data_CENA];
								if(buyvalue > 50-CarInfo[car][cFuel]) buyvalue = 50-CarInfo[car][cFuel];
							}
							ShowPlayerDialogf(player, 6751, DIALOG_STYLE_INPUT, "{ee3366}Покупка топлива", "Купить", "Отмена", "\
							{FFFFFF}Стоимость бензина: {FFFF99}%d рублей за 1 литр\n\
							{FFFFFF}Для полного бака вам понадобится: {FFFF99}%d литр(-ов) бензина\n\
							{FFFFFF}На вашем счету хватит на: {FFFF99}%d литров бензина\n\
							{FFFFFF}Введите количество литров бензина, которое хотите приобрести:", BizInfo[b][data_CENA], 50-CarInfo[car][cFuel], buyvalue);
						}
					}
					else
					{
						ShowPlayerDialogf(player, 6752, DIALOG_STYLE_MSGBOX, !"{ee3366}Покупка канистры", "Купить", "Отмена", "\
						{FFFFFF}Вы желаете купить канисту с бензином?\n\
						Стоимость: {FFFF99}%d рублей за 10 литров", BizInfo[b][data_CENA]*20);
					}
					SetPVarInt(player, "business",b);
				}
			}
		}
		if(carid == PI[player][pLoadVehicleID]) callcmd::key(player);
	}
}
public void:OnPlayerKeyUp(player, key) 
{
	if(key == 77) callcmd::menu(player);
	if(key == 80) 
	{
		if(PI[player][pPhone] != 0) callcmd::phone(player);
		else SCM(player, COLOR_GREY, !"У Вас нет телефона, купить его можно в любом Мазагине 24/7");
	}
	if(key == 76) callcmd::lock(player);
	if(key == 113) callcmd::tp(player);
	if(key == 89) 
	{
		if(PI[player][pRequest] == 1) CheckRequest(player);// Y
	}
	if(key == 78 && IsPlayerLogged{player}) 
	{
		if(PI[player][pRequest] == 1) CancelRequest(player); // N
	}
}
CMD:sellgun(playerid, params[]) 
{
	if(!IsPlayerOPG(playerid)) 
		return SCM(playerid, COLOR_GREY, !"Вы не состоите в ОПГ");
 	if(sscanf(params, "udd", params[0], params[1], params[2])) 
		return SCM(playerid, COLOR_LIGHTGREY, !"Используйте: /givegun [ID игрока] [количество] [цена]");
	if(150 < params[2] > 200 ) 
		return SCM(playerid, COLOR_LIGHTGREY, !"Используйте: /givegun [ID игрока] [количество] [цена (от 150 до 200 руб)]");
    if(PI[params[0]][pWeaponLock] > 0) 
		return SCM(playerid, COLOR_GREY, !"У данного игрока блокировка оружия");
	if(playerid == params[0]) 
		return SCM(playerid, COLOR_GREY, !"Нельзя передавать самому себе");

	new Float:x,Float:y,Float:z;
	GetPlayerPos(playerid, x,y,z);
	if(!PlayerToPoint(5.0, params[0], x,y,z)) return SCM(playerid, COLOR_GREY, !"Нужно находиться возле игрока");

	if(!IsPlayerLogged{params[0]}) 
		return SCM(playerid, COLOR_GREY, !"Данный игрок не прошел авторизацию");
	if(PI[params[0]][pLevel] < 2) 
		return SCM(playerid, COLOR_GREY, !"У игрока нет 2-го уровня");

	new gun = GetPlayerWeapon(playerid), gunslot = getWeaponIdSlot(gun);

	if(gun == 38 && gun == 34 && gun == 35 && gun == 36 && gun == 37 && gun == 39 && gun == 40) 
		return SCM(playerid, COLOR_GREY, !"Нельзя передать данное оружие");
	if(params[1] < 1) return SCM(playerid, COLOR_GREY, !"Недопустимое значение");
	if(PI[playerid][data_GUN][gunslot] == 0 || gunslot == 0) 
		return SCM(playerid, COLOR_GREY, !"Чтобы передать оружие, нужно взять его в руки");
	if(PI[playerid][data_AMMO][gunslot] < params[1]) 

		return SCM(playerid, COLOR_GREY, !"У Вас нет такого количества патронов");
	SetPVarInt(playerid, "pt", params[1]);
	SetPVarInt(playerid, "cena", params[2]);
	return SendR(playerid);//SendRequestForPlayer(playerid, params[0], 15, params[1]);
}
stock DialogTimerSellGun(playerid) 
{
	new str_3[256];

	new pt = GetPVarInt(playerid, "pt");
	if(pt != 0)
	{
		new cena = GetPVarInt(playerid, "cena")/GetPVarInt(playerid, "pt");
		new gun = GetPlayerWeapon(GetPVarInt(playerid, "from_player"));

		format(str_3,sizeof(str_3),"\
		Продавец: %s[%d]\n\
		Оружие: %s (%d пт)\n\
		Стоимость: %d руб (%d за 1 пт)\n\n\
		Вы действительно хотите принять это предложение", 
			PI[GetPVarInt(playerid, "from_player")][pName],
			GetPVarInt(playerid, "from_player"),weapon_names[gun],
			GetPVarInt(playerid, "value_1"),
			GetPVarInt(playerid, "cena"),
			cena);

		ShowPlayerDialog(playerid, 8791, DIALOG_STYLE_MSGBOX, !"{ee3366}Покупка оружия", str_3, "Купить", "Нет");
	}
	else 
	{
		return SendClientMessagef(playerid, COLOR_GREY, "Количество патрон не может быть равно 0");
	}
	return 1;
}
CMD:help(playerid)
{
    ShowPlayerDialog(playerid, dialog_COMMAND, DIALOG_STYLE_LIST, "{ee3366}Команды сервера", "\
	1. Общие команды\n\
	2. Недвижимость\n\
	3. Бизнес\n\
	4. Транспорт\n\
	5. Работа\n\
	6. Команды организации\n\
	7. Команды лидера/заместителя", "Выбрать", "Закрыть");
    return true;
}
stock MaskEnabled(playerid)
{
    return DisableRemoteVehicleCollisions(playerid, true);
}
stock MaskDisable(playerid)
{
    return DisableRemoteVehicleCollisions(playerid, false);
}
stock CheckAccess(playerid, adminLvl = 1, modLvl = 0)
{
    if (modLvl >= 1 && PI[playerid][pModer] >= modLvl) return 0;
    if (PI[playerid][pAdmin] < adminLvl) 
    {
        return SendClientMessage(playerid, COLOR_LIGHTGREY, !"У Вас нет доступа к этой команде");
    }
    return 0;
}
alias:promocode("promo", "supercode", "code");
CMD:promocode(playerid)
{
	ShowPlayerDialog(playerid, 5050, DIALOG_STYLE_LIST, !"{ee3366}Промокоды", "\
	1. Использовать промокод", "Далее", "Закрыть");
	return 1;
}
callback: MysqlReferalCheck(playerid, referal[])
{
	if(!cache_num_rows()) 
	{ 
		SCM(playerid, COLOR_GREY, !"Игрок не найден.");
		return ShowPlayerDialog(playerid, dialog_REFERAL, DIALOG_STYLE_INPUT, !"{ee3366}Реферальная система", !"\
			{FFFFFF}Если Вы узнали о нашем сервере от своего друга\n\
			то можете ввести его ник в нижнем окошке\n\n\
			{FFFF99}При достижении 3-го уровня Вы получите призы!", "Далее", "Пропустить");
	}
	SCMf(playerid, COLOR_HINT, "[Информация]: {FFFFFF}Вы указали игрока {6699ff}%s{FFFFFF} в качестве пригласившего Вас игрока.", referal);
	strmid(PI[playerid][pReferal], referal, 0, strlen(referal), 24);

	SetPVarInt(playerid, "ChoosingSkin", 1);
	SetSpawnInfo(playerid, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
	return SpawnPlayer(playerid);
}
callback: MysqlReferal(playerid)
{
	if(!cache_num_rows()) return 1;
	static Referal[24];
	cache_get_row(0, 0, Referal, mysql);
	if(GetString(Referal, "No Referal"))
	{
		new refid = GetNameID(Referal);
		if(IsPlayerConnected(refid))
		{
			SCMf(playerid, COLOR_YELLOW, "Вы указали при регистрации {3366cc}%s{FFFF00} вашим рефералом, за это Вы получили {3366cc}250.000 рублей", PI[refid][pName]);
			SCMf(refid, COLOR_YELLOW, "%s указал Вас при регистрации как пригласившего игрока, за это Вы получили {3366cc}150.000 рублей", PI[playerid][pReferal]);
			GivePlayerMoneyLog(playerid, 250000);
			GivePlayerMoneyLog(refid, 150000);
		}
		else 
		{
			SCMf(playerid, COLOR_YELLOW, "Вы указали при регистрации {3366cc}%s{FFFF00} вашим рефералом, за это Вы получили {3366cc}250.000 рублей", PI[playerid][pReferal]);
			GivePlayerMoneyLog(playerid, 250000);

			mysql_queryf(mysql, "UPDATE `accounts` SET `Money`=`Money`+%d WHERE `Name`='%e'", false, 150000, Referal);
		}
	}
	return 1;
}
callback: MysqlPromoCheck(playerid)
{
    if(!cache_num_rows()) 
	{ 
		SCM(playerid, COLOR_GREY, !"Промо-код не найден, проверьте правильность ввода");
		return PromoCodeUse(playerid);
	}

    new money = cache_get_field_content_int(0, "money");
	new donate_points = cache_get_field_content_int(0, "donate");
	new exp = cache_get_field_content_int(0, "exp");

    ShowPlayerDialogf(playerid, 0, 0, !"{ee3366}Успешно", !"Спасибо", !"", "\
	{FFFFFF}Вы успешно активировали {FFFF99}промо-код\n\n\
	{FFFFFF}Вам выдано: {FFFF99}%d рублей\n\
	{FFFFFF}Вам выдано: {FFFF99}%d Донат-поинтов\n\
	{FFFFFF}Вам выдано: {FFFF99}%d EXP", money, donate_points, exp);

	PI[playerid][pDonate] += donate_points;
	UpdatePlayerDataInt(playerid, "Donate", PI[playerid][pDonate]);
	PI[playerid][pExp] += exp;
	UpdatePlayerDataInt(playerid, "exp", PI[playerid][pExp]);

	PI[playerid][pPromoCodeUse] = 1;
	UpdatePlayerDataInt(playerid, "exp", PI[playerid][pPromoCodeUse]);

	GivePlayerMoneyLog(playerid, money);
	CheckNextLevel(playerid);
	return 1;
}
stock PromoCodeUse(playerid)
{
	if(PI[playerid][pPromoCodeUse] == 1) return SCM(playerid, COLOR_GREY, !"Вы уже использовали промокод!");
	ShowPlayerDialog(playerid, 5051, DIALOG_STYLE_INPUT, !"{ee3366}Промокоды", !"\
	{3366cc}Где можно получить промокод?\n\
	{FFFFFF}— Самый простой способ получения промокода, это от ютубера.\n\
	{FFFFFF}— Также можно узнать промокод посмотрев топ-промокодов на сервере.\n\n\
	{3366cc}Как создать свой личный промокод?\n\
	{FFFFFF}— Мы создаём промокоды всем нашим официальным ютуберам.\n\
	{FFFFFF}— Создать промокод также можно на 5-том уровне персонажа за 1 миллион.\n\n\
	{3366cc}Введите промокод в поле ниже:", !"Далее", !"Закрыть");
	return 1;
}
/*stock PromoCodeCreate(playerid)
{
	if(PI[playerid][pPromoCode] == 1) return SCM(playerid, COLOR_GREY, !"Вы уже создали промокод!");
	ShowPlayerDialog(playerid, 5052, DIALOG_STYLE_INPUT, !"{ee3366}Создание промокода", "\
	— После создания Вам будет доступна подробная статистика Вашего промокода.\n\
	— После создания название промокода нельзя будет изменить.\n\
	— Вы сможете его удалить при желании.\n\
	— Цена создания 1.000.000 рублей\n\
	{FFFF99}Вы действительно хотите создать промокод? Если да,\n\
	{FFFF99}введите название промокода в поле ниже:", "Далее", "Закрыть");
	return 1;
}
stock TopPromoCodes(playerid)
{
	SCM(playerid, -1, "soon..");
	return 1;
}*/
stock CheckNextLevel(playerid)
{
	new expamount = (PI[playerid][pLevel] + 1)*4;
	if(PI[playerid][pExp] >= expamount)
	{
		for(new i = expamount; i <= PI[playerid][pExp]; i++)
		{
			PI[playerid][pLevel]++;
			PI[playerid][pExp] -= expamount;
			if(PI[playerid][pLevel] == 3)
			{
				static str[85];
			    format(str, sizeof(str), "SELECT `Referal` FROM `accounts` WHERE `Name` = '%e'", getName(playerid));
			    mysql_tquery(mysql, str, "MysqlReferal", "d", false, playerid);
			}
		}
		SetPlayerScore(playerid, PI[playerid][pLevel]);
		SCMf(playerid, COLOR_LIGHTBLUE_2, "Поздравляю! Вы достигли %d-го уровня!", PI[playerid][pLevel]);
		UpdatePlayerDataInt(playerid, "exp", PI[playerid][pExp]);
		return 1;
	}
	return 0;
}
stock GetNameID(const name[])
{
	extract name -> new player: PLAYER_ID;
	if(IsPlayerConnected(PLAYER_ID)) return PLAYER_ID;
	return INVALID_PLAYER_ID;
}
alias:referal("ref");
CMD:referal(playerid)
{
	static Referal[24];

	mysql_queryf(mysql, "SELECT * FROM `accounts` WHERE `Name` = '%e' LIMIT 1", true, PI[playerid][pName]);
	if(cache_num_rows() > 0) cache_get_field_content(0, "Referal", Referal, mysql);

	ShowPlayerDialogf(playerid, 5060, DIALOG_STYLE_LIST, !"{ee3366}Реферальная система", "Далее", "Закрыть", "1. Ваш реферал: {FFFF99}%s\n{FFFFFF}2. Посмотреть Ваших рефералов", Referal);
	return 1;
}
stock ShowMySQLReferals(playerid)
{
	new Ref3LVL, Ref1LVL, Level, accounts;
	static Name[24], string2[1048], str2[50], str[70];
	mysql_queryf(mysql, "SELECT `Name`, `Level` FROM `accounts` WHERE `Referal` = '%e' LIMIT 10", true, getName(playerid));
	accounts = cache_get_row_count(mysql);
	if(!accounts) return SCM(playerid, COLOR_GREY, !"Больше вас никто не указывал как реферала");
    format(string2, 36, "{FFFFFF}Имя	{FFFFFF}Уровень\n");
	for(new i; i < accounts; i ++)
	{
		cache_get_row(i, 0, Name, mysql);
		Level = cache_get_row_int(i, 1, mysql);
		if(Level >= 3)
		{
			format(str2, sizeof(str2), "%s\t{FFFF99}%d{FFFFFF}\n", Name, Level);
			Ref3LVL++;
		}
		else
		{
			format(str2, sizeof(str2), "%s\t{CCCCCC}%d{FFFFFF}\n", Name, Level);
			Ref1LVL++;
		}
		strcat(string2, str2);
	}
	format(str, sizeof(str), "{ee3366}Мои рефералы  {FFFFFF}({FFFF99}%d{FFFFFF} / {FF6347}%d{CCCCCC})", Ref3LVL, Ref1LVL);
	ShowPlayerDialog(playerid, 0, DIALOG_STYLE_TABLIST_HEADERS, str, string2, !"Ок", !"");
	return true;
}
stock PlayerHideTextDraws(playerid)
{
	if(PI[playerid][data_CLOTHESMENU] == true) 
	{
		TextDrawHideForPlayer(playerid, buy_clothes[0]);
		TextDrawHideForPlayer(playerid, buy_clothes[1]);
		TextDrawHideForPlayer(playerid, buy_clothes[2]);
		TextDrawHideForPlayer(playerid, buy_clothes[3]);
		TextDrawHideForPlayer(playerid, buy_clothes[4]);
		TextDrawHideForPlayer(playerid, buy_clothes[5]);
		PlayerTextDrawHide(playerid, buy_clothes_m[playerid]);
 		CancelSelectTextDraw(playerid);
 		PI[playerid][data_CLICKTD] = false;
		PI[playerid][data_CLOTHESMENU] = false;
	}
    if(PI[playerid][pInAutoSalon] == true) 
	{
		PI[playerid][pAutoSalonCar] = INVALID_VEHICLE_ID;
 		DestroyVehicle(PI[playerid][pAutoSalonCar]);
		HideAutoSalonMenu(playerid);
	}
}
stock GetSkinOfPlayer(playerid)
{
	new skin, org = PI[playerid][pMember];//, rank = PI[playerid][pRang];
	if(!org) skin = PI[playerid][pSkin];
	else
	{
	    skin = PI[playerid][pOrgSkin];
	}
	return skin;
}
stock SetSpawnInfoEx(playerid, skin, Float:x, Float:y, Float:z, Float:a)
{
    SetSpawnInfo(playerid, 255, skin, x, y, z-0.2, a, 0, 0, 0, 0, 0, 0);
    TogglePlayerControllable(playerid, false);
    return true;
}
callback: PlayerSpawn(playerid)
{
    if(IsPlayerInAnyVehicle(playerid))
	{
	    new Float:X, Float:Y, Float:Z;
	    GetPlayerPos(playerid, X, Y, Z);
		SetPlayerPos(playerid, X ,Y, Z);
	    SetTimerEx("PlayerSpawn", 50, false, "i", playerid);
	    return 1;
	}
 	SettingSpawn(playerid);
	SpawnPlayer(playerid);
	return 1;

}
public OnPlayerDialogShow(playerid, dialogid, style, caption[], info[], button1[], button2[])
{
    ShowPlayerDialog(playerid, dialogid, style, caption, info, button1, button2);
    return 1;
}
stock SaveServer()
{
	new currenttime = GetTickCount();
    foreach(new i: Player) SavePlayerData(i);
    printf("SavePlayer сохранился за %i ms", GetTickCount() - currenttime);

	currenttime = GetTickCount();
    SaveWarehouse();
    printf("SaveWarehouse сохранился за %i ms", GetTickCount() - currenttime);

	currenttime = GetTickCount();
 	for(new i; i < LoadedHouse; i++) SaveHouseData(i);
	printf("SaveHouseData сохранился за %i ms", GetTickCount() - currenttime);
	
	currenttime = GetTickCount();
 	for(new i; i < LoadedKV; i++) SaveKVData(i);
	printf("SaveKVData сохранился за %i ms", GetTickCount() - currenttime);

	currenttime = GetTickCount();
	for(new i ;i < LoadedBiz; i++) SaveBusinessData(i);
	printf("SaveBusinessData сохранился за %i ms", GetTickCount() - currenttime);

	return 1;
}
//
stock PlayerHospital(playerid, skip = 0)
{
	PI[playerid][pHospital] = 1;
	UpdatePlayerDataInt(playerid, "hospital", PI[playerid][pHospital]);
    PI[playerid][pHealthPoints] = 5;
    UpdatePlayerDataInt(playerid, "HealthPoints", 5);

	if(!skip) PlayerSpawn(playerid);
	return 1;
}
stock IsAVelik(carid) 
{
	new model = GetVehicleModel(carid);
	if(model == 481 || model == 510 || model == 509 || model == 484 || model == 454) return 1;
	return 0;
}
stock IsAPlane(carid) 
{
	new model = GetVehicleModel(carid);
	if(model == 417 || model == 425 || model == 447 || model == 460 || model == 469 || model == 476 || model == 487 || model == 488 || model == 497 || model == 511 || model == 512 || model == 513 || 
		model == 519 || model == 520 || model == 548 || model == 553 || model == 563 || model == 577 || model == 592 || model == 593 || model == 441 || model == 464 || model == 465 || model == 501 || model == 564) return 1;
	return 0;
}
CMD:drugs(playerid, params[])
{
	if(PI[playerid][pDrugs] < 1) return SCM(playerid, COLOR_GREY, !"У вас нет наркотиков");

	if(sscanf(params, "d", params[0])) return SCM(playerid, COLOR_LIGHTGREY, !"Используйте: /drugs [1-10]");
    if(params[0] <= 0 || params[0] > 10) return SCM(playerid, COLOR_GREY, !"Введите значение от 1 до 10");
    if(PI[playerid][pDrugs] < params[0]) return SCM(playerid, COLOR_GREY, !"У Вас недостаточно наркотиков");

	if(GetPVarInt(playerid,"Coolldown_HealOnWar") > gettime()) return SCMf(playerid, COLOR_GREY, "Вы получили урон в бою, использовать наркотики можно будет через %d", GetPVarInt(playerid,"Coolldown_HealOnWar")-gettime());
    if(GetPVarInt(playerid,"PlayerCuffed")) return SCM(playerid, COLOR_GREY, !"Вы скованы и не можете двигаться");
    if(GetPVarInt(playerid,"Counting_drugs") > gettime()) return SCM(playerid, COLOR_GREY, !"Команду можно использовать раз в 10 секунд");
    
	new Float:Health;
    GetPlayerHealth(playerid,Health);
	Health += 3*params[0];
	if(Health > 176) Health = 176;
    SetPlayerHealthAC(playerid,Health);

    if(IsPlayerInAnyVehicle(playerid)) ApplyAnimation(playerid,"FOOD","EAT_Burger",4.1,0,0,0,0,0,1);
	
	PI[playerid][pDrugs] -= params[0];
	PI[playerid][pUserDrugs] += params[0];

	SetPlayerDrunkLevel(playerid, 3900);

	new str_2[61+25], hptext[25];
	format(str_2,sizeof(str_2)," %s принимает дозу наркотиков", getName(playerid));
	ProxDetector(30,playerid,str_2,0xFF99CCAA, 0xFF99CCAA, 0xFF99CCAA, 0xFF99CCAA, 0xFF99CCAA);

	SetPVarInt(playerid,"Counting_drugs",gettime() + 10);

	format(hptext, sizeof hptext, "+%d HP", params[0]);

	if(!IsPlayerInAnyVehicle(playerid)) ApplyAnimation(playerid,"SMOKING","M_smk_drag",4.1,0,0,0,0,0,1);
	return 1;
}
stock ClearChatForPlayer(playerid)
{
	for(new i; i < 20; i ++) SCM(playerid, -1, !" ");
	return 1;
}
CMD:fix(playerid, params[]) 
{
	new vehicle = GetNearestVehicle(playerid);
	if(vehicle) 
	{
		if(IsPlayerInAnyVehicle(playerid)) return SCM(playerid, COLOR_GREY, !"Вы не должны находиться в транспорте");
		if(PI[playerid][pFixPack] == 0) return SCM(playerid, COLOR_GREY, !"У Вас нет ремонтных комплектов.");
	    PI[playerid][pFixPack]--;
	    SCMf(playerid, 0x69b867FF, "Для починки был использован Ремотный набор #1 (Общий) (осталось: %d шт)", PI[playerid][pFixPack]);
		if(vehicle) RepairVehicle(vehicle);
		else SCM(playerid, COLOR_GREY, !"Рядом с Вами нет транспорта");
	}
	else SCM(playerid, COLOR_GREY, !"Рядом с Вами нет транспорта");
	return 1;
}
CMD:fuel(playerid, params[]) 
{
    if(PI[playerid][pCanisters] == 0) return SCM(playerid, COLOR_GREY, !"У Вас нет канистры. Купить ее можно на любом АЗС.");
	new carid = GetPlayerVehicleID(playerid);
	if(carid == INVALID_VEHICLE_ID) return SCM(playerid, COLOR_GREY, !"Нужно находиться в автомобиле");
	if(CarInfo[carid][cFuel] == 50) return SCM(playerid, COLOR_GREY, !"Бак автомобиля полн");
	if(CarInfo[carid][cFuel] < 50 && CarInfo[carid][cFuel] >= 40) CarInfo[carid][cFuel] = 50;
	else CarInfo[carid][cFuel] += 10;
	SCM(playerid, 0x69b867FF, !"Вы заправили автомобиль.");
	return PI[playerid][pCanisters] = 0;
}
CMD:park(playerid)
{
	new carid = GetPlayerVehicleID(playerid);

	if(GetPlayerState(playerid) != 2) return SCM(playerid, COLOR_GREY, !"Вы должны быть за рулём cвоего авто!");
	if(carid != PI[playerid][pLoadVehicleID]) return SCM(playerid, COLOR_GREY, !"Это не ваша машина!");
	if(!IsPlayerGreenZone(playerid)) return SendClientMessage(playerid, COLOR_GREY, !"Нельзя припарковать личный транспорт в Зеленой Зона");

	new Float: car_x, Float: car_y, Float: car_z;
	GetVehiclePos(carid, car_x, car_y, car_z);

	CarInfo[carid][cPos_X] = car_x;
	CarInfo[carid][cPos_Y] = car_y;
	CarInfo[carid][cPos_Z] = car_z + 0.8;
	GetVehicleZAngle(carid, CarInfo[carid][cPos_A]);
	
	CarInfo[carid][cNoPark] = 0;

	SaveOwnableCar(carid);

	SendClientMessage(playerid, 0x0088ffFF, !"Транспорт был припаркован, теперь при его доставке он будет появляться здесь");
	return 1;
}
stock SaveOwnableCar(number)
{
    mysql_queryf(mysql, "UPDATE `ownable` SET \
	`Model` = '%d', `Key` = '%d', `Pos_X` = '%.4f', `Pos_Y` = '%.4f', `Pos_Z` = '%.4f', `Pos_A` = '%.4f',`Color_1` = '%d', \
	`Color_2` = '%d', `Owner` = '%e', `Cost` = '%d', `Lock` = '%d', `Fuel` = '%d', `NoPark` = '%i' WHERE `ID` = '%i'", false,\
   	CarInfo[number][cModel],\
	CarInfo[number][cKey],\
	CarInfo[number][cPos_X],\
	CarInfo[number][cPos_Y],\
	CarInfo[number][cPos_Z],\
	CarInfo[number][cPos_A],\
	CarInfo[number][cColor_1],\
	CarInfo[number][cColor_2],\
	CarInfo[number][cOwner],\
	CarInfo[number][cCost],\
	CarInfo[number][cLock],\
	CarInfo[number][cFuel],\
	CarInfo[number][cNoPark],\
	CarInfo[number][cID]);
}
alias:carpass("cp", "passcar");
CMD:carpass(playerid,params[]) 
{
	if(PI[playerid][pLoadVehicleID] == INVALID_VEHICLE_ID) return SCM(playerid, COLOR_GREY, !"У Вас нет загруженого транспорта");

	extract params -> new player:target; else return SCM(playerid, COLOR_LIGHTGREY, !"Используйте: /carpass [ID игрока]");

	if(target == INVALID_PLAYER_ID) return 0;

    if(!ProxDetectorS(5.0, playerid, target)) return SCM(playerid, COLOR_GREY, !"Вы далеко от игрока!");

	new str_1[29 + MAX_PLAYER_NAME*2];
    format(str_1, sizeof(str_1), "%s показывает тех. паспорт %s", getName(playerid), getName(target));
	ProxDetector(25.0, playerid, str_1, 0xC2A2DAFF, 0xC2A2DAFF, 0xC2A2DAFF, 0xC2A2DAFF, 0xC2A2DAFF);

	CarPass(playerid, target);

	return 1;
}
stock CarPass(ownerid, forplaeyer) 
{
 	if(PI[ownerid][pLoadVehicleID] == INVALID_VEHICLE_ID) return SCM(ownerid, COLOR_GREY, !"У Вас нет загруженого транспорта");

	new colorCode[7];
	new str_3[256*2], carid = GetVehicleModel(PI[ownerid][pLoadVehicleID]);

	for(new i = 0; i < sizeof(colorVeh); i++) 
	{
		if(colorVeh[i][colorCar] == CarInfo[PI[ownerid][pLoadVehicleID]][cColor_1]) 
		{
			colorCode = colorVeh[i][hexColor];
		}
	}

	for(new i = 0; i < sizeof(DealershipCars); i++) 
	{
		if(DealershipCars[i][asModel] == carid) 
		{
			format(str_3,sizeof(str_3),"\
			{FFFFFF}Название: \t\t\t{ee3366}%s (#%d)\n\
			{FFFFFF}Владелец: \t\t\t{FFFF99}%s\n\
			{FFFFFF}Номер: \t\t\t{FFFF99}----\n\
			{FFFFFF}Тип: \t\t\t\t%s\n\
			{FFFFFF}Пробег: \t\t\t{FFFF99}0000000 км\n\
			{FFFFFF}Вместимость бака: \t\t{FFFF99}50.0 л.\n\
			{FFFFFF}Государственная стоимость: \t{FFFF99}%d руб\n\
			{FFFFFF}Цвет кузова: \t\t\t{FFFF99}{%s}|||",
				VehicleNames[carid-400],
				CarInfo[PI[ownerid][pLoadVehicleID]][cID],
				getName(ownerid),
				CarInfo[PI[ownerid][pLoadVehicleID]][cPremium] ? ("{FFFF99}Премиум{FFFFFF}") : ("Обычный"),
				DealershipCars[i][asDonate]*3000,
				colorCode);

			return ShowPlayerDialog(forplaeyer, 0, DIALOG_STYLE_MSGBOX, !"{ee3366}Документы", str_3, "Закрыть", "");
		}
	}
	return 1;
}
stock ProxDetectorS(Float:radi, playerid, targetid, spec = 0)
{
    new Float:p[3];
    if(!IsPlayerConnected(playerid)) return 0;
    if(!IsPlayerConnected(targetid)) return 0;
    if(!spec)
    {
	    if(GetPlayerState(playerid) == 9) return 0;
	    if(GetPlayerState(targetid) == 9) return 0;
    }
    if(!GetPlayerPos(targetid, p[0], p[1], p[2])) return 0;
	if(!IsPlayerInRangeOfPoint(playerid, radi, p[0], p[1], p[2])) return 0;
	return 1;
}
CMD:key(playerid)
{
	new carid = GetPlayerVehicleID(playerid);
	
	if(GetPlayerState(playerid) != 2) return SCM(playerid, COLOR_GREY, !"Вы должны быть за рулём cвоего авто!");
	if(carid != PI[playerid][pLoadVehicleID]) return SCM(playerid, COLOR_GREY, !"Это не ваша машина!");

	if(CarInfo[carid][cKey] == 1)
	{
		new str_1[29 + MAX_PLAYER_NAME];
		format(str_1, sizeof(str_1), "%s вытянул ключ из транспорта", getName(playerid));
		ProxDetector(25.0, playerid, str_1, 0xC2A2DAFF, 0xC2A2DAFF, 0xC2A2DAFF, 0xC2A2DAFF, 0xC2A2DAFF);

		CarInfo[carid][cKey] = 0;

		cef_emit_event(playerid, "cef:speed:icon", CEFINT(4), CEFINT(0));

		GetVehicleParamsEx(PI[playerid][pLoadVehicleID], engine,lights_text,alarm,doors_text,bonnet,boot,objective);
		SetVehicleParamsEx(PI[playerid][pLoadVehicleID], false,lights_text,alarm,doors_text,bonnet,boot,objective);

		cef_emit_event(playerid, "show-notify", CEFINT(6), CEFSTR("Вы вытянули ключ из транспорта"), CEFSTR("c13537"));
	}
	else 
	{
		new str_1[29 + MAX_PLAYER_NAME];
		format(str_1, sizeof(str_1), "%s вставил ключ в транспорт", getName(playerid));
		ProxDetector(25.0, playerid, str_1, 0xC2A2DAFF, 0xC2A2DAFF, 0xC2A2DAFF, 0xC2A2DAFF, 0xC2A2DAFF);

		CarInfo[carid][cKey] = 1;
		cef_emit_event(playerid, "cef:speed:icon", CEFINT(4), CEFINT(1));
		cef_emit_event(playerid, "show-notify", CEFINT(5), CEFSTR("Вы вставили ключ в транспорт"));
	}
	SaveOwnableCar(carid);
	return true;
}
CMD:engine(playerid)
{
	new carid = GetPlayerVehicleID(playerid);

	if(IsAVelik(carid)) return 0;

	new Float:health;
	GetVehicleHealth(carid, health);
	if(health <= 351) return SendPlayerCenterNotify(playerid, 2, "Двигатель сломан", 5);

	if(CarInfo[carid][cID] != 0 && CarInfo[carid][cKey] == 0) return SCM(playerid, COLOR_LIGHTGREY, !"Ключ зажигания не вставлен.");
	if(CarInfo[carid][cFuel] <= 0) return SCM(playerid, COLOR_LIGHTGREY, !"В машине нет топлива, купите канистру в ближайшей АЗС");

	switch(CarInfo[carid][cEngineStatus]) 
	{
		case 0: 
		{
			GetVehicleParamsEx(carid,engine,lights_text,alarm,doors_text,bonnet,boot,objective);
			SetVehicleParamsEx(carid,true,lights_text,alarm,doors_text,bonnet,boot,objective);
			CarInfo[carid][cEngineStatus] = 1;
		}
		case 1: 
		{
			GetVehicleParamsEx(carid,engine,lights_text,alarm,doors_text,bonnet,boot,objective);
			SetVehicleParamsEx(carid,false,lights_text,alarm,doors_text,bonnet,boot,objective);
			CarInfo[carid][cEngineStatus] = 0;
		}
	}
	UpdateSpeedometer(playerid);
	return 1;
}
//
alias:cars("car", "v", "mycars");
CMD:cars(playerid)
{
	if(PI[playerid][pLoadVehicleID] == INVALID_VEHICLE_ID) 
	{			
		mysql_string[0] = EOS, mf(mysql, mysql_string, 80, "SELECT * FROM `ownable` WHERE `Owner` = '%e'", getName(playerid));
		mysql_tquery(mysql, mysql_string, "LoadOwnableCars", "i", playerid);
	}
	else 
	{
		ShowPlayerDialog(playerid, 401, DIALOG_STYLE_LIST, "{ee3366}Личный транспорт", "\
		1. Паспорт транспортного средства\n\
		2. Руководство по эксплуатации\n\
		3. Открыть транспорт\n\
		4. Вытащить ключи\n\
		5. Управление капотом / багажником\n\
		6. Отбуксировать транспорт\n\
		7. Поставить GPS метку на мини-карте\n\
		8. Припарковать транспорт\n\
		9. Продать транспорт\n\
		{FFFF99}10. Выгрузить транспорт", "Далее", "Закрыть");
	}
	return 1;
}
callback: LoadOwnableCars(playerid)
{
	new rows;
	rows = cache_num_rows();

	if(!rows) return SendClientMessage(playerid, COLOR_GREY, !"У вас нет личного транспорта, Вы можете преобрести его в Автосалоне");

	else 
	{
		new str_1[1048+144*2], str_2[1048+144*2], str_3[1048+256*3];

		new ID, NoPark, Model_ID, Premium, cars, cars_np, Temp, NoAccess;

		static Package[90*2]; Package[0] = EOS;
		static Status[90*2]; Status[0] = EOS;
		static Access[130]; Access[0] = EOS;

		for(new i = 0; i < rows; i ++)
		{

			ID = cache_get_field_content_int(i, "ID");
			Model_ID = cache_get_field_content_int(i, "Model");
			NoPark = cache_get_field_content_int(i, "NoPark");
			Premium = cache_get_field_content_int(i, "Premium");
			Temp = cache_get_field_content_int(i, "Temp");

			if(Temp != -1)
			{
				//SendClientMessagef(playerid, COLOR_HINT, "[Подсказка]: {FFFFFF}У Вас есть временная машина %s.", VehicleNames[Model_ID-400]);
				if(Temp <= gettime()) 
				{
					SendClientMessagef(playerid, COLOR_LIGHTORANGE, "[!!!] {FFFF99}Ваш временный автомобиль %s был удален.", VehicleNames[Model_ID-400]);
					SendAdminsMessagef(COLOR_GREY, "<TempCar> Игроку %s[%d] был удалён временный автомобиль %s.", getName(playerid), VehicleNames[Model_ID-400]);
					DeleteOwnable(ID);
				}
			}

			if(PI[playerid][pHouse] == INVALID_HOUSE_ID && PI[playerid][pFloat] == INVALID_KV_ID) NoAccess = 1;
							

			ShowCar[playerid][cars] = ID;

			if(NoPark == 1) Package = "Автосалон";
			else Package = "Припаркован";

			if(Premium == 1) 
			{
				Status = "{FFFF99}Премиум{FFFFFF}";
				Access = "Да";
			}
			else 
			{
				Status = "Обычный";
				if(NoAccess == 1 || cars_np > 2) 
				{
					Access = "Нет";
					AccessCar[playerid][cars] = 1;
				}
				else Access = "Да";
			}
			

			format(str_1, sizeof(str_1), "{FFFFFF}%s\t%s\t%s\t%s\n", VehicleNames[Model_ID-400], Package, Status, Access);
			strcat(str_2, str_1);

			cars ++; 
			cars_np++;
		}
		format(str_3, sizeof(str_3), "Название\tМестоположения\tТип\tДоступ\n%s", str_2);

		if(!cars) return SCM(playerid, COLOR_LIGHTGREY, !"У вас нет личного транспорта, Вы можете преобрести его в Автосалоне");
		return ShowPlayerDialog(playerid, 398, DIALOG_STYLE_TABLIST_HEADERS, !"{ee3366}Список личного транспорта", str_3, !"Далее", !"Закрыть");
	}
}
stock ClearVehicleData(number)
{
	CarInfo[number][cID] = 0;
	CarInfo[number][cModel] = 0;
	CarInfo[number][cColor_1] = 0;
	CarInfo[number][cColor_2] = 0;
	CarInfo[number][cLock] = 0;
	CarInfo[number][cCost] = 0;
	CarInfo[number][cNoPark] = 1;
	CarInfo[number][cFuel] = 0;
	CarInfo[number][cPremium] = 0;
	CarInfo[number][cTemp] = -1;
	CarInfo[number][cKey] = 0;

	CarInfo[number][cOwner] = EOS;
}
CMD:sellcar(playerid) 
{
	if(PI[playerid][pLoadVehicleID] == INVALID_VEHICLE_ID) return SCM(playerid, COLOR_GREY, !"У Вас нет загруженно машины для продажи");
	if(CarInfo[PI[playerid][pLoadVehicleID]][cTemp] != -1) return SCM(playerid, COLOR_GREY, !"Вы не можете продать временный автомобиль");

	ShowPlayerDialog(playerid, 9228, DIALOG_STYLE_LIST, "{ee3366}Продажа личного трансопрта", "1. Продать транспорт государству\n2. Продать транспорт другому игроку", "Выбрать", "Отмена");
	return 1;
}
stock SetPlayerOwnable(playerid, model, cost, fuel, color_1, color_2, premium)
{
	mysql_string[0] = EOS, mf(mysql, mysql_string, 240, "\
	INSERT INTO `ownable` (`ID`, `Owner`, `Model`, `Cost`, `Fuel`, `Color_1`, `Color_2`, `Premium`, `Temp`) VALUES ('', '%e', '%d', '%d', '%d', '%d', '%d', '%d', '-1')",
					PI[playerid][pName],
					model,
					cost,
					fuel,
					color_1,
					color_2,
					premium);
    mysql_function_query(mysql, mysql_string, false, "", "");
	return 1;
}
stock GivePlayerOwnable(playerid, model, cost, fuel, color_1, color_2, premium, temp = -1)
{
	mysql_string[0] = EOS, mf(mysql, mysql_string, 250, "\
	INSERT INTO `ownable` (`ID`, `Owner`, `Model`, `Cost`, `Fuel`, `Color_1`, `Color_2`, `Premium`, `Temp`) VALUES ('', '%e', '%d', '%d', '%d', '%d', '%d', '%d', '%d')",
					PI[playerid][pName],
					model,
					cost,
					fuel,
					color_1,
					color_2,
					premium,
					gettime()+temp*3600);
    mysql_function_query(mysql, mysql_string, false, "", "");
	return 1;
}
stock DeleteOwnable(id)
{
	mysql_string[0] = EOS, mf(mysql, mysql_string, 44, "DELETE FROM `ownable` WHERE `ID` = '%d'", id);
    mysql_function_query(mysql, mysql_string, false, "", "");
	return 1;
}
stock CreatePunishment(playerid, player, type, reason[])
{
	mysql_string[0] = EOS, mf(mysql, mysql_string, 180, "INSERT INTO `punishment` ( `name`, `type`, `admin`, `reason`) VALUES ( '%s', '2', '%d', '%s')", getName(player), type, getName(playerid), reason);
	mysql_function_query(mysql, mysql_string, false, "", "");
}
stock ShowSellCar(playerid)
{
	if(CarInfo[PI[playerid][pLoadVehicleID]][cPremium] == 1) 
	{
		ShowPlayerDialogf(playerid, 9226, DIALOG_STYLE_INPUT, !"{ee3366}Продажа транспорта игроку", !"Продать", !"Закрыть",\
		"{FFFFFF}Введите ID игрока и стоимость через запятую.\n\
		{FFFF99}Например: 150, 100000\n\n\
		{FFFFFF}Государственная стоимость: {3366cc}%d руб\n\
		{FFFFFF}Доступная стоимость продали: {3366cc}от %d до %d руб\n\n\
		{696969}Обратите внимание: при продаже премиум-трансопрта покупатель\n\
		выплачивает обязательный единоразовый налог государству.\n\n\
		{FFFFFF}На Ваш транспорт он составит {3366cc}20%%{FFFFFF} от гос. стоимости транспорта.\n\
		{FFFFFF}Помимо стоимоти покупки, игрок дополнительно заплатит {3366cc}%d руб", 
		CarInfo[PI[playerid][pLoadVehicleID]][cCost], // Госска
		CarInfo[PI[playerid][pLoadVehicleID]][cCost]/100*15, // От
		CarInfo[PI[playerid][pLoadVehicleID]][cCost]/100*90+CarInfo[PI[playerid][pLoadVehicleID]][cCost], // До
		CarInfo[PI[playerid][pLoadVehicleID]][cCost]/100*20); // Налог 20%
	}
	else 
	{
		ShowPlayerDialogf(playerid, 9226, DIALOG_STYLE_INPUT, !"{ee3366}Продажа транспорта игроку", !"Продать", !"Закрыть",\
		"{FFFFFF}Введите ID игрока и стоимость через запятую.\n\
		{FFFF99}Например: 150, 100000\n\n\
		{FFFFFF}Государственная стоимость: {3366cc}%d руб\n\
		{FFFFFF}Доступная стоимость продали: {3366cc}от %d до %d руб", 
		CarInfo[PI[playerid][pLoadVehicleID]][cCost], // Госска
		CarInfo[PI[playerid][pLoadVehicleID]][cCost]/100*15, // От
		(CarInfo[PI[playerid][pLoadVehicleID]][cCost]/100*90)+CarInfo[PI[playerid][pLoadVehicleID]][cCost]); // До
	}
	return 1;
}
CMD:id(playerid, params[]) 
{
    if(sscanf(params, "s[24]", params[0])) return SCM(playerid, COLOR_LIGHTGREY, !"Используйте: /id [Имя игрока или часть имени / ID игрока]");

	new count;

    for(new i = 0; i < MAX_PLAYERS; i++) 
	{
        if(!IsPlayerConnected(i)) continue;
        if(strfind(PI[i][pName], params[0], true) != -1) 
		{
        	SCMf(playerid, -1, "%s[%d]",PI[i][pName], i);
        	count++;
			if(count == 10) return SCM(playerid, COLOR_GREY, !"Первые 10 игроков с похожим ником");
        }
    }
    if(count == 0) return SCM(playerid, COLOR_GREY, !"Совпадений не найдено");
    return 1;
}
CMD:gift(playerid)
{
	if(PI[playerid][pCarGift] == 1) return SCM(playerid, COLOR_GREY, !"Вы уже получали временный автомобиль");
	
	new const RadnomGift[4] = {405, 579, 560, 540};
	new gift_car = RandomEX(1, 4);

	GivePlayerOwnable(playerid, RadnomGift[gift_car], 0, 50, 137, 137, 1, 336);


	PI[playerid][pCarGift] = 1;
	UpdatePlayerDataInt(playerid, "CarGift", PI[playerid][pCarGift]);

	SCMf(playerid, COLOR_YELLOW, "Вы получили автомобиль {3366cc}'%s'{FFFF33} на 14 дней", VehicleNames[RadnomGift[gift_car]-400]);
	return SendClientMessageToAllf(COLOR_HINT, "[Подарок]:{FFFFFF} Игрок {FFFF33}%s[%d]{FFFFFF} получил автомобиль {FFFF33}'%s'{FFFFFF} в на 14 дней", PI[playerid][pName], playerid, VehicleNames[RadnomGift[gift_car]-400]);
}
stock ShowGPS(playerid)
{
	ShowPlayerDialog(playerid, 4500, DIALOG_STYLE_LIST, !"{ee3366}Навигатор", !"\
	{FFFF99}Информация\n\
	{FFFFFF}1. Важные места\n\
	2. Временные работы\n\
	3. Основные работы\n\
	4. Государственные организации\n\
	5. Нелегальные организации\n\
	6. Развлечения\n\
	7. Бизнесы\n\
	{66cc99}8. Найти АЗС\n\
	{66cc99}9. Найти банкомат\n\
	{888888}10. Отключить навигатор", "Выбрать", "Отмена");
	return 1;
}
stock ShowHotKeys(playerid)
{
	ShowPlayerDialog(playerid, 0, DIALOG_STYLE_TABLIST_HEADERS, !"{ee3366}Горячие клавиши", !"\
	Клавиша\tТип\tОписание\n\
	J\t{FFFF99}Любой\t{FFFFFF}Открыть меню лидера\n\
	L\t{FFFF99}Любой\t{FFFFFF}Открыть / закрыть транспорт\n\
	M\t{FFFF99}Любой\t{FFFFFF}Открыть меню игрока\n\
	P\t{FFFF99}Любой\t{FFFFFF}Открыть меню телефона\n\
	O\t{FFFF99}Любой\t{FFFFFF}Настройки голосового чата\n\
	X\t{FFFF99}Любой\t{FFFFFF}Голосовой чат\n\
	B\t{ff9933}Пешеход\tОткрыть меню в бизнесе\n\
	B\t{ff9933}Пешеход\tНажать кнопку (открыть ворота, дверь)\n\
	H\t{66cc66}Водитель\tОткрыть ворота\n\
	K\t{66cc66}Водитель\tВставить / вытащить ключ\n\
	Левый ALT\t{66cc66}Водитель\tВключить / выключить фары\n\
	Левый CTRL\t{66cc66}Водитель\tВключить / выключить двигатель", !"Закрыть", !"");
	return 1;
}
stock ShowMainMenu(playerid) 
{
	return ShowPlayerDialog(playerid, 101, DIALOG_STYLE_LIST, !"{ee3366}Меню игрока", 
	!"{FFFFFF}1. Статистика\n\
	{FFFFFF}2. Команды сервера\n\
	{FFFFFF}3. Горячие клавиши\n\
	{FFFFFF}4. Помощь / жалоба\n\
	{FFFFFF}5. Настройки аккаунта\n\
	{FFFFFF}6. Общие правила\n\
	{FFFFFF}7. Ресурсы игры\n\
	{FFFFFF}8. Изменить никнейм\n\
	{FFFFFF}9. Чёрный список организаций\n\
	{5fc2f1}10. Дополнительные услуги", !"Выбрать", !"Отмена");
}
public OnPlayerStreamIn(playerid, forplayerid) 
{
	if(PI[forplayerid][pAdminStatus] == 1) return ShowPlayerNameTagForPlayer(playerid, forplayerid, false);
	return 1;
}
callback: ClearData(playerid)
{
	TextReset[playerid] = 0;
	return 1;
}
public OnPlayerCommandPerformed(playerid, cmd[], params[], result, flags)
{
    if(!IsPlayerLogged{playerid}) return 0;
    return 1;
}
public OnPlayerCommandReceived(playerid, cmd[], params[], flags)
{
    if(!IsPlayerLogged{playerid}) return 0;
	return 1;
}
public OnPlayerPickUpPickup(playerid, pickupid)
{
	if(GetPVarInt(playerid, "PickUPKD") > gettime())  return 1;

    mineOnPlayerPickUpDynamicPickup(playerid, pickupid);
	capture_OnPlayerPickUpPickup(playerid, pickupid);

	if(pickupid == PointCapture)
    {
		if(PI[playerid][pOnCapture] == 1) return SendClientMessage(playerid, COLOR_LIGHTGREY, !"Вы уже зарегистрированы на участие в стреле");
		if(GangWarStatus == 0) return SendClientMessage(playerid, COLOR_LIGHTGREY, !"В данный момент не проходит захват территории");
        if(PI[playerid][pMember] == Command[0] || PI[playerid][pMember] == Command[1])
        {
			CEF_ShowPlayerDialogNew(playerid, 4901, "Стрела",\
				"Вы действительно хотите участвовать в битве за территорию?\n\n",\
				"Вы будете исключены из списка участников,\nесли покините зону стрелы,\
				пробудете в AFK\nболее 1 минуты или выйдите из игры", "Вступить", "Отмена");
        }
    }
	SetPVarInt(playerid,"PickUPKD",gettime() + 7);
    return 1;
}
stock SetDefaultSkin(org, id)
{
	if(PI[id][pSex] == 1) 
	{
		switch(org) 
		{
			case 1: PI[id][pOrgSkin] = 156;
			case 2: PI[id][pOrgSkin] = 179;
			case 3: PI[id][pOrgSkin] = 280;
			case 4: PI[id][pOrgSkin] = 276;
			case 5: PI[id][pOrgSkin] = 8;
			case 6: PI[id][pOrgSkin] = 115;
			case 7: PI[id][pOrgSkin] = 123;
			case 8: PI[id][pOrgSkin] = 15;
		}
	}
	if(PI[id][pSex] == 2) 
	{
		switch(org) 
		{
			case 1: PI[id][pOrgSkin] = 216;
			case 2: PI[id][pOrgSkin] = 191;
			case 3: PI[id][pOrgSkin] = 141;
			case 4: PI[id][pOrgSkin] = 194;
			case 5: PI[id][pOrgSkin] = 13;
			case 6: PI[id][pOrgSkin] = 13;
			case 7: PI[id][pOrgSkin] = 13;
			case 8: PI[id][pOrgSkin] = 12;
		}
	}
	UpdatePlayerDataInt(id, "skinm", PI[id][pOrgSkin]);
	SetPlayerSkinAC(id, PI[id][pOrgSkin]);
	SetPlayerTeam(id, org);
}
stock CheckGangWar(playerid)
{
	if(GangWarStatus >= 1) 
	{
		if(PI[playerid][pMember] == Command[0] || PI[playerid][pMember] == Command[1]) 
		{
			cef_emit_event(playerid, "cef:capture:visible", CEFINT(true));
			cef_emit_event(playerid, "cef:capture:gang:name", CEFINT(1), CEFSTR(Fraction_Name[Command[0]]));
			cef_emit_event(playerid, "cef:capture:gang:name", CEFINT(2), CEFSTR(Fraction_Name[Command[1]]));
			cef_emit_event(playerid, "cef:capture:gang:score", CEFINT(1), CEFINT(CommandRounds[0]));
			cef_emit_event(playerid, "cef:capture:gang:score", CEFINT(2), CEFINT(CommandRounds[1]));
			cef_emit_event(playerid, "cef:capture:start", CEFSTR(NameCapture()), CEFINT(WarTime));

			GangZoneFlashForPlayer(playerid, WarZone, 0xFF000055);
		}
	}
}
stock NameCapture()
{
	new CaptureStatus[30];

	if(GangWarStatus == 1) CaptureStatus = "подготовка к битве";
	if(GangWarStatus == 2) CaptureStatus = "начало раунда";
	if(GangWarStatus == 3) CaptureStatus = "раунд 1";
	if(GangWarStatus == 4) CaptureStatus = "завершение раунда";
	if(GangWarStatus == 5) CaptureStatus = "начало раунда";
	if(GangWarStatus == 6) CaptureStatus = "раунд 2";
	if(GangWarStatus == 7) CaptureStatus = "завершение раунда";
	if(GangWarStatus == 8) CaptureStatus = "начало раунда";
	if(GangWarStatus == 9) CaptureStatus = "раунд 3";
	if(GangWarStatus == 10) CaptureStatus = "завершение раунда";
	if(GangWarStatus == 11) CaptureStatus = "начало раунда";
	if(GangWarStatus == 12) CaptureStatus = "раунд 4";
	if(GangWarStatus == 13) CaptureStatus = "завершение раунда";
	if(GangWarStatus == 14) CaptureStatus = "начало раунда";
	if(GangWarStatus == 15) CaptureStatus = "раунд 5";
	if(GangWarStatus == 16) CaptureStatus = "завершение захвата";

	return CaptureStatus;
}
stock SaveBusinessData(b) 
{
    mysql_string[0] = EOS;
    
    format(mysql_string, 512, "\
		UPDATE `business` SET `owner` = '%e', `owned` = %d, `name` = '%e', `prod` = %d, `DayRent` = %d, `clients` = %d, `lock` = %d,\
		`cena` = %d, `price_prod` = %d, `bank` = %d, `SealedDays` = %d WHERE `id` = %d LIMIT 1",
        BizInfo[b][bOwner],
        BizInfo[b][bOwned],
        BizInfo[b][bName],
        BizInfo[b][bProduct],
        BizInfo[b][bDays],
        BizInfo[b][bClient],
        BizInfo[b][data_LOCK],
        BizInfo[b][data_CENA],
        BizInfo[b][bPriceProduct],
        BizInfo[b][bMoney],
        BizInfo[b][bSealedDays],
        BizInfo[b][bID]
    );

	mysql_pquery(mysql, mysql_string);
    
    return 1;
}
callback: SaveWarehouse()
{
	mysql_string[0] = EOS;

	format(mysql_string, 500, "\
		UPDATE warehouse SET rostov_metal=%d, rostov_patr=%d, rostov_narko=%d, rostov_storage=%d,\
		gopota_metal=%d, gopota_patr=%d, gopota_narko=%d, gopota_storage=%d,\
		kavkaz_metal=%d, kavkaz_patr=%d, kavkaz_narko=%d, kavkaz_storage=%d,\
		army_metal=%d, armystorage=%d, army_patr=%d,\
		smi_money=%d,\
		moroz_kavkaz=%d, moroz_gopota=%d, moroz_skinhead=%d,\
		metall=%d, coal=%d WHERE id=1",
		skinhead_wh[0], skinhead_wh[1], skinhead_wh[2], skinhead_wh[3],
		gopota_wh[0], gopota_wh[1], gopota_wh[2], gopota_wh[3],
		kavkaz_wh[0], kavkaz_wh[1], kavkaz_wh[2], kavkaz_wh[3],
		army_wh[0], army_wh[2], army_wh[1],
		smi_money,
		m_kavkaz, m_gopota, m_skinhead, MineOreStock, MineCoalStock);

	mysql_pquery(mysql, mysql_string);
}
callback: SaveHouseData(h)
{
	mysql_string[0] = EOS;

	format(mysql_string, 140, "UPDATE houses SET `owner`='%s', `owned`='%d', `lock`='%d', `day`='%d' WHERE `id`='%d'",
		HOUSE_DATA[h][data_OWNER],
		HOUSE_DATA[h][data_OWNED],
		HOUSE_DATA[h][data_LOCK],
		HOUSE_DATA[h][data_DAY],
		HOUSE_DATA[h][data_ID]);

	print(mysql_string);

	mysql_pquery(mysql, mysql_string);
}
callback: SavePlayerData(playerid)
{
	if(IsPlayerLogged{playerid} && IsPlayerConnected(playerid))
	{
		//printf("Player %s saved", getName(playerid));

		GetPlayerHealth(playerid, PI[playerid][pHealthPoints]);
		GetPlayerArmour(playerid, PI[playerid][pArmour]);

		mysql_string[0] = EOS;

		format(mysql_string, sizeof(mysql_string), "\
			UPDATE accounts SET AdminEvents=%d, AdminReports=%d, skin=%d, Money=%d, VKNotif=%d, bangun=%d, Level=%d, skinm=%d,\
			member=%d, Leader=%d, transfer=%d, transfer_rang=%d, transfer_frac=%d, rank=%d, Admin=%d,\
			AdminStatus=%d, CaptureKills=%d, CaptureValue=%d, LoginIP='%s', mute=%d, mutetime=%d,\
			vmute=%d, vmutetime=%d, warn=%d, warntime=%d, salary=%d, bank=%d, licb=%d, licg=%d, business=%d,\
			house=%d, time=%d, military=%d, medcard=%d, vip=%d, patr=%d, drugs=%d, usedrugs=%d,\
			mednum=%d, licnum=%d, met=%d, wanted=%d, Respect=%d, number=%d, number_m=%d, pstatus=%d, jail=%d,\
			jailtime=%d, Donate=%d, phone=%d, phonebook=%d, Satiety=%d, HealthPoints=%f, arm=%f, med=%d,\
			spawn=%d, hospital=%d, pistol_skill=%d, sdpistol_skill=%d, deagle_skill=%d, shotgun_skill=%d, mp5_skill=%d,\
			ak47_skill=%d, rifle_skill=%d, job=%d, house=%d, business=%d, kv=%d, padik=%d, gun0=%d, gun1=%d, gun2=%d, gun3=%d,\
			gun4=%d, gun5=%d, gun6=%d, gun7=%d, gun8=%d, gun9=%d, gun10=%d, gun11=%d, gun12=%d, ammo0=%d, ammo1=%d, ammo2=%d,\
			ammo3=%d, ammo4=%d, ammo5=%d, ammo6=%d, ammo7=%d, ammo8=%d, ammo9=%d, ammo10=%d, ammo11=%d, ammo12=%d, demorgan=%d,\
			demorgan_time=%d, twarn=%d, healthchest=%d, HEALPACKSKLAD=%d, Сanister=%d, mask=%d, fixnabor=%d,\
			ProgressAmmo=%d, ProgressMetall=%d, PromoCodeUse=%d, ProgressDrugs=%d, ProgressCarGrabber=%d,\
			CaptureManager=%d, ProgressSellGun=%d, ProgressCapture=%d, Moder=%d, AdminNumber=%d, LeavePosX=%f, LeavePosY=%f, LeavePosZ=%f WHERE id=%d",
			PI[playerid][pAdminEvents],
			PI[playerid][pAdminReports],
			PI[playerid][pSkin],
			PI[playerid][pMoney],
			PI[playerid][pVKNotif],
			PI[playerid][pWeaponLock],
			PI[playerid][pLevel],
			PI[playerid][pOrgSkin],
			PI[playerid][pMember],
			PI[playerid][pLeader],
			PI[playerid][data_TRANSFER],
			PI[playerid][data_TRANSFER_RANG],
			PI[playerid][data_TRANSFER_FRAC],
			PI[playerid][pRang],
			PI[playerid][pAdmin],
			PI[playerid][pAdminStatus],
			PI[playerid][pCaptureKills],
			PI[playerid][pCaptureValue],
			PI[playerid][pLoginIP],
			PI[playerid][pMute],
			PI[playerid][pMuteTime],
			PI[playerid][pVmute],
			PI[playerid][pVmuteTime],
			PI[playerid][pWarn],
			PI[playerid][pWarnTime],
			PI[playerid][pPayDayMoney],
			PI[playerid][pBank],
			PI[playerid][pDriveLicense],
			PI[playerid][pGunLicense],
			PI[playerid][pBusiness],
			PI[playerid][pHouse],
			PI[playerid][data_TIME],
			PI[playerid][pMilitaryID],
			PI[playerid][pMedCard],
			PI[playerid][pVIP],
			PI[playerid][pAmmo],
			PI[playerid][pDrugs],
			PI[playerid][pUserDrugs],
			PI[playerid][data_MEDNUM],
			PI[playerid][pLicNumber],
			PI[playerid][pMetall],
			PI[playerid][pWanted],
			PI[playerid][pRespect],
			PI[playerid][pNumber],
			PI[playerid][pNumberMoney],
			PI[playerid][pPhoneStatus],
			PI[playerid][pJail],
			PI[playerid][pJailTime],
			PI[playerid][pDonate],
			PI[playerid][pPhone],
			PI[playerid][pPhoneBook],
			PI[playerid][pSatiety],
			PI[playerid][pHealthPoints],
			PI[playerid][pArmour],
			PI[playerid][data_MED],
			PI[playerid][data_SPAWN],
			PI[playerid][pHospital],
			PI[playerid][pSkillPistol],
			PI[playerid][pSkillSDPistol],
			PI[playerid][pSkillDeagle],
			PI[playerid][pSkillShotgun],
			PI[playerid][pSkillMP5],
			PI[playerid][pSkillAK47],
			PI[playerid][pSkillRifle],
			PI[playerid][data_JOB],
			PI[playerid][pHouse],
			PI[playerid][pBusiness],
			PI[playerid][pFloat],
			PI[playerid][data_PADIK],
			PI[playerid][data_GUN][0],
			PI[playerid][data_GUN][1],
			PI[playerid][data_GUN][2],
			PI[playerid][data_GUN][3],
			PI[playerid][data_GUN][4],
			PI[playerid][data_GUN][5],
			PI[playerid][data_GUN][6],
			PI[playerid][data_GUN][7],
			PI[playerid][data_GUN][8],
			PI[playerid][data_GUN][9],
			PI[playerid][data_GUN][10],
			PI[playerid][data_GUN][11],
			PI[playerid][data_GUN][12],
			PI[playerid][data_GUN][0],
			PI[playerid][data_GUN][1],
			PI[playerid][data_GUN][2],
			PI[playerid][data_GUN][3],
			PI[playerid][data_GUN][4],
			PI[playerid][data_GUN][5],
			PI[playerid][data_GUN][6],
			PI[playerid][data_GUN][7],
			PI[playerid][data_GUN][8],
			PI[playerid][data_GUN][9],
			PI[playerid][data_GUN][10],
			PI[playerid][data_GUN][11],
			PI[playerid][data_GUN][12],
			PI[playerid][pDemorgan],
			PI[playerid][pDemorganTime],
			PI[playerid][pTwarn],
			PI[playerid][pHealPack],
			PI[playerid][pHealthPackKD],
			PI[playerid][pCanisters],
			PI[playerid][pMask],
			PI[playerid][pFixPack],
			PI[playerid][pProgressAmmo],
			PI[playerid][pProgressMetall],
			PI[playerid][pPromoCodeUse],
			PI[playerid][pProgressDrugs],
			PI[playerid][pProgressCarGrabber], 
			PI[playerid][pCaptureManager], 
			PI[playerid][pProgressSellGun], 
			PI[playerid][pProgressCapture], 
			PI[playerid][pModer],
			PI[playerid][pAdminNumber],
			PI[playerid][pLeavePosX],
			PI[playerid][pLeavePosY],
			PI[playerid][pLeavePosZ],
			PI[playerid][pID]
		);
		mysql_pquery(mysql, mysql_string);
	}
	return 1;
}
CMD:leaders(playerid, params[]) 
{
    new query[85];
    format(query, sizeof(query), "SELECT * FROM `accounts` WHERE `rank` >= 9 ORDER BY `member` ASC, `rank` DESC;");
    mysql_tquery(mysql, query, "ShowLeaders", "i", playerid);
    return 1;
}

callback: ShowLeaders(playerid)
{
    new rows, fields;
    cache_get_data(rows, fields);

    if (!rows) 
    {
        return ShowPlayerDialog(playerid, 0, DIALOG_STYLE_MSGBOX, 
            "{ee3366}Лидеры и заместители", 
            "{FFFFFF}В данный момент лидеров нет", 
            "Закрыть", "");
    }
    
    new string[1048 + 256], line[256], NamePlayer[24];
    new getRang, getMember, Number, StatusOnline;
    new Org[17], Rang[12], Status[25];
    
    for (new i = 0; i < rows; i++) 
    {
        cache_get_field_content(i, "Name", NamePlayer, sizeof(NamePlayer));
        cache_get_field_content(i, "member", line), getMember = strval(line);
        cache_get_field_content(i, "rank", line), getRang = strval(line);
        cache_get_field_content(i, "number", line), Number = strval(line);

        StatusOnline = 0;
        new szName[64];
        foreach(Player, id) 
        {
            if (IsPlayerConnected(id)) 
            {
                GetPlayerName(id, szName, sizeof(szName));
                if (strcmp(NamePlayer, szName, false) == 0) 
                {
                    StatusOnline = 1;
                    format(NamePlayer, sizeof(NamePlayer), "%s[%d]", NamePlayer, id);
                }
            }
        }

		switch(getMember) 
		{
			case 1: Org = "Правительство";
			case 2: Org = "Войсковая часть";
			case 3: Org = "Полиция";
			case 4: Org = "БЦРБ";
			case 5: Org = "Скинхеды";
			case 6: Org = "Гопота";
			case 7: Org = "Кавказцы";
		}
		switch(getRang) 
		{
			case 9: Rang = "Заместитель";
			case 10: Rang = "Лидер";
		}
		switch(StatusOnline) 
		{
			case 1: Status = "{5ac375}В сети";
			case 0: Status = "{ff6633}Не в сети";
		}

        format(line, sizeof(line), "%s\t%s\t%s\t%d\t%s\n", Org, Rang, NamePlayer, Number, Status);
        strcat(string, line, sizeof(string));
    }

    global_str[0] = EOS, f(global_str, 2048, "Организация\tДолжность\tИмя\tТелефон\tСостояние\n%s", string);
    CEF_ShowPlayerDialog(playerid, 0, DIALOG_STYLE_TABLIST_HEADERS, 
        "{ee3366}Лидеры и заместители", 
        global_str, 
        "Закрыть", "");

    return 1;
}
stock Freeze(playerid) 
{
	TogglePlayerControllable(playerid, 0);
	SendPlayerCenterNotify(playerid, 4, "Пожалуйста, подождите...", 4);
	return SetTimerEx("unFreeze", 3500,0, "%d", playerid);
}
callback: unFreeze(playerid) TogglePlayerControllable(playerid, 1);
stock ShowTargetMenu(playerid)
{
	targplayer[playerid] = GetPlayerTargetPlayer(playerid);
	return ShowPlayerDialog(playerid, 3298, DIALOG_STYLE_LIST, !"{ee3366}Взаимодействие с игроком", !"\
	1. Пожать руку\n\
	2. Передать аптечку\n\
	3. Показать паспорт\n\
	4. Показать лицензии\n\
	5. Показать мед. карту\n\
	6. Показать навыки владения оружием\n\
	7. Передать маску", !"Далее", !"Закрыть");
}
stock LMenuIllegal(playerid) 
{
	return ShowPlayerDialog(playerid, 7501, DIALOG_STYLE_LIST, !"{ee3366}Меню лидера", !"{e6e69c}1. Управление группами\n\
	{e6e69c}2. Список всех участников организации\n\
	{e6e69c}3. Чёрный список\n\
	{e6e69c}4. Автопарк организации\n\
	{3CB371}5. Принять в организацию\n\
	{3CB371}6. Уволить из организации\n\
	{3CB371}7. Уволить из огранизации оффлайн\n\
	{3CB371}8. Выдать выговор\n\
	{3CB371}9. Выдать выговор оффлайн\n\
	{3CB371}10. Снять выговор\n\
	{3CB371}11. Снять выговор оффлайн\n\
	{3CB371}12. Изменить внешность\n\
	{3CB371}13. Изменить группу\n\
	{6dbdd8}14. Расформировать организацию", !"Выбрать", !"Отмена");
}
callback: DelayedKick(playerid)
{
    Kick(playerid);
}
callback: CEF_SelectClothes(playerid, const argument[]) 
{
	new eventId;
	sscanf(argument, "ii", eventId);
	switch(eventId)
	{
	    case 1:
		{
            if(PI[playerid][pSex] == 1) 
			{
				PI[playerid][pSelectSkin]--;
				if(PI[playerid][pSelectSkin] <= -1) PI[playerid][pSelectSkin] = 4;
				SetPlayerSkinAC(playerid, SelectSkinM[PI[playerid][pSelectSkin]][0]);
			}
			else
			{
				PI[playerid][pSelectSkin]--;
				if(PI[playerid][pSelectSkin] <= -1) PI[playerid][pSelectSkin] = 2;
				SetPlayerSkinAC(playerid, SelectSkinF[PI[playerid][pSelectSkin]][0]);
			}
		}
		case 2:
		{
			if(PI[playerid][pSex] == 1) PI[playerid][pSkin] = SelectSkinM[PI[playerid][pSelectSkin]][0];
			else PI[playerid][pSkin] = SelectSkinF[PI[playerid][pSelectSkin]][0];

			AccountCreate(playerid);
		}
	    case 3:
		{
            if(PI[playerid][pSex] == 1) 
			{
				PI[playerid][pSelectSkin]++;
				if(PI[playerid][pSelectSkin] >= 4) PI[playerid][pSelectSkin] = 0;
				SetPlayerSkinAC(playerid, SelectSkinM[PI[playerid][pSelectSkin]][0]);
			}
			else
			{
				PI[playerid][pSelectSkin]++;
				if(PI[playerid][pSelectSkin] >= 2) PI[playerid][pSelectSkin] = 0;
				SetPlayerSkinAC(playerid, SelectSkinF[PI[playerid][pSelectSkin]][0]);
			}
		}
		case 4:
		{
			if(PI[playerid][pSex] == 1) 
			{
				switch(random(4)) 
				{
					case 0: PI[playerid][pSkin] = 134;
					case 1: PI[playerid][pSkin] = 135;
					case 2: PI[playerid][pSkin] = 137;
					case 3: PI[playerid][pSkin] = 230;
				}
			}
			else if(PI[playerid][pSex] == 2) 
			{
				switch(random(3)) 
				{
					case 0: PI[playerid][pSkin] = 196;
					case 1: PI[playerid][pSkin] = 197;
					case 2: PI[playerid][pSkin] = 199;
				}
			}
			AccountCreate(playerid);
		}
	}
	return 1;
}
stock ChoosingSkin(playerid)
{
	if(GetPVarInt(playerid, "ChoosingSkin") == 0) return Kick(playerid);

	SetPlayerWeather(playerid, 2);
	SetPlayerTime(playerid, 12, 0);

	SetPlayerVirtualWorld(playerid, 3+playerid);
	TogglePlayerControllable(playerid, false);

	SetPlayerPosAC(playerid, 1800.5647,808.7733,16.0300);
	SetPlayerFacingAngle(playerid, 276.4264);

	InterpolateCameraPos(playerid, 1803.8046, 809.0544, 16.6323, 1803.8046, 809.0544, 16.6323, 1000);
	InterpolateCameraLookAt(playerid, 1802.8134, 808.9332, 16.4473, 1802.8134, 808.9332, 16.4473, 1000);

	PI[playerid][pSelectSkin] = 0;
	if(PI[playerid][pSex] == 1) SetPlayerSkinAC(playerid, SelectSkinM[PI[playerid][pSelectSkin]][0]);
	else SetPlayerSkinAC(playerid, SelectSkinF[PI[playerid][pSelectSkin]][0]);

	cef_emit_event(playerid, "cef:select:clothes:show");
	cef_focus_browser(playerid, MAIN_CEF, true);
	return 1;
}
stock AccountCreate(playerid)
{
	if(GetPVarInt(playerid, "ChoosingSkin") == 0) return Kick(playerid);

	new hour, minute, second;
	gettime(hour, minute, second);
	SetPlayerWeather(playerid, WeatherServer);
	SetPlayerTime(playerid, hour, 0);

	cef_emit_event(playerid, "cef:select:clothes:hide");
	cef_focus_browser(playerid, MAIN_CEF, false);

	SetPlayerSkinAC(playerid, PI[playerid][pSkin]);

    PI[playerid][pDemorgan] = 0;
	PI[playerid][pHospital] = 0;

	RegisterNow[playerid] = true;

	mysql_string[0] = EOS, mf(mysql, mysql_string, 440, "\
	INSERT INTO `accounts` (`id`,`Name`, `licb`, `licg`, `Respect`, `CarThiefLvl`, `HealthPoints`, `Money`, `Password`, `Email`, `RegIP`, `Referal`, `sex`, `skin`, `Level`) VALUES ('','%e', '1', '1', '1', '1', '160', '5000', md5('%e'), '%e', '%s', '%s', '%d', '%d', '1')",
		PI[playerid][pName],
		PI[playerid][pPassword],
		PI[playerid][pEmail],
		PI[playerid][pRegIP],
		PI[playerid][pReferal],
		PI[playerid][pSex],
		PI[playerid][pSkin]);
    mysql_function_query(mysql, mysql_string, false, "", "");

	mysql_string[0] = EOS, mf(mysql, mysql_string, 160, "SELECT * FROM `accounts` WHERE `Name` = '%e' AND `Password` = md5('%s')", PI[playerid][pName], PI[playerid][pPassword]);
	mysql_function_query(mysql, mysql_string, true, "LoadPlayerData", "d", playerid);

	SendAdminsMessagef(COLOR_GREY, "[NewPlayer] %s[%d] только что создал аккаунт | {ff6633}RegIP: %s", getName(playerid), playerid, PI[playerid][pRegIP]);

	DeletePVar(playerid, "ChoosingSkin");
	return 1;
}
public OnQueryError(errorid, error[], callback[], query[], connectionHandle)
{
	switch(errorid)
	{
		case ER_SYNTAX_ERROR:
		{
			printf("Something is wrong in your syntax, query: %s", query);
		}
		default: print(error);
	}
	return 1;
}
CMD:setspawn(playerid) 
{
    if(!IsPlayerLogged{playerid}) return 1;
    return ShowPlayerDialog(playerid, 3513, DIALOG_STYLE_LIST, 
				!"{f00e5d}Выберете место появления", 
				!"1. База организации\n\
				2. Автомобильный / железнодорожный вокзал\n\
				3. Дом / квартира", 
				"Выбрать", "Закрыть"
			);
}
stock SetVehicleSpeed(vehid, Float:speed)
{
    new Float:x1, Float:y1, Float:z1, Float:x2, Float:y2, Float:z2, Float:a;
    GetVehicleVelocity(vehid,x1,y1,z1);
    GetVehiclePos(vehid,x2,y2,z2);
    GetVehicleZAngle(vehid,a); a=360-a;
    x1=(floatsin(a,degrees)*(speed/100))+x1;
    y1=(floatcos(a,degrees)*(speed/100))+y1;
    SetVehicleVelocity(vehid,x1,y1,z1);
}
stock ShowPoliceStorage(playerid)
{
	ShowPlayerDialog(playerid, 5980, DIALOG_STYLE_TABLIST_HEADERS, !"{ee3366}Оружейный склад", "\
	Оружие\tНужный ранг\tПатроны\n\
	{FFFFFF}Полицейская дубинка\t\t1+\t\t1\n\
	Полицейский жезл\t\t1+\t\t1\n\
	Бронежилет\t2+\t\t-\n\
	Балончик с краской\t\t2+\t\t500\n\
	ПЛ-15\t\t2+\t\t70\n\
	Тайзер\t\t7+\t\t70\n\
	АКС-74У\t\t3+\t\t180\n\
	АК-47\t\t5+\t\t180\n\
	Снайперская винтовка\t5+\t\t20", !"Взять", !"Закрыть");
}