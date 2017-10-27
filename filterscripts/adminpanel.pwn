//===================================================================================================================================================//
//=====================||||||||||||====||||||||||====|===========||||||||||=====|============|======|||||||||||=====|================================//
//=====================|===============|========|====|===========|========|=====|=\==========|======|===============|================================//
//=====================|===============|========|====|===========|========|=====|===\========|======|===============|================================//
//=====================|===============|========|====|===========|========|=====|====\=======|======|===============|================================//
//=====================|===============|========|====|===========|========|=====|=====\======|======|===============|================================//
//=====================|===============|========|====|===========|========|=====|=====\======|======|||||||||||=====|================================//
//=====================|===============|========|====|===========|========|=====|======\=====|======|===============|================================//
//=====================|===============|========|====|===========|========|=====|=======\====|======|===============|================================//
//=====================|===============|========|====|===========|========|=====|=======\====|======|===============|================================//
//=====================|===============|========|====|===========|========|=====|========\===|======|===============|================================//
//=====================||||||||||||====||||||||||====|||||||||===||||||||||=====|==========\=|======|||||||||||=====||||||||=========================//
//===================================================================================================================================================//
//===================================================================================================================================================//


//=============================include=====================================//
#include <a_samp>
#include <a_mysql>
#include <zcmd>
#pragma tabsize 0

//==============================define=======================================//
#define MAX_PLAYERS 150

#define level1  "Agent-Moderator"
#define level2 "Training-Administrator"
#define level3 "Agent-Administrator"
#define level4 "Senior-Agent-Administrator"
#define level5 "Master-Administrator"
#define gods "Lord Colonel"

// Define strcpy and key
#pragma unused ret_memcpy
#define strcpy(%0,%1) \
    strcat((%0[0] = '\0', %0), %1)
#define HOLDING(%0) \
	((newkeys & (%0)) == (%0))
#define PRESSING(%0,%1) \
	(%0 & (%1))
#define PRESSED(%0) \
	(((newkeys & (%0)) == (%0)) && ((oldkeys & (%0)) != (%0)))
// RELEASED(keys)
#define RELEASED(%0) \
	(((newkeys & (%0)) != (%0)) && ((oldkeys & (%0)) == (%0)))
	
//===========================Define Color ===========================//
#define COLOR_LIGHTBLUE 0x33CCFFAA
#define COLOR_GREY 0xAFAFAFAA
#define COLOR_YELLOW 0xFFFF00AA
#define COLOR_PINK 0xFF66FFAA
#define COLOR_BLUE 0x0000BBAA
#define COLOR_WHITE 0xFFFFFFAA
#define COLOR_DARKRED 0x660000AA
#define COLOR_ORANGE 0xFF9900AA
#define COLOR_BRIGHTRED 0xFF0000AA
#define COLOR_INDIGO 0x4B00B0AA
#define COLOR_VIOLET 0x9955DEEE
#define COLOR_LIGHTRED 0xFF99AADD
#define COLOR_SEAGREEN 0x00EEADDF
#define COLOR_GRAYWHITE 0xEEEEFFC4
#define COLOR_LIGHTNEUTRALBLUE 0xabcdef66
#define COLOR_GREENISHGOLD 0xCCFFDD56
#define COLOR_LIGHTBLUEGREEN 0x0FFDD349
#define COLOR_NEUTRALBLUE 0xABCDEF01
#define COLOR_LIGHTCYAN 0xAAFFCC33
#define COLOR_LEMON 0xDDDD2357
#define COLOR_MEDIUMBLUE 0x63AFF00A
#define COLOR_NEUTRAL 0xABCDEF97
#define COLOR_BLACK 0x00000000
#define COLOR_NEUTRALGREEN 0x81CFAB00
#define COLOR_DARKGREEN 0x12900BBF
#define COLOR_LIGHTGREEN 0x24FF0AB9
#define COLOR_DARKBLUE 0x300FFAAB
#define COLOR_BLUEGREEN 0x46BBAA00
#define COLOR_PINK 0xFF66FFAA
#define COLOR_LIGHTBLUE 0x33CCFFAA
#define COLOR_DARKRED 0x660000AA
#define COLOR_ORANGE 0xFF9900AA
#define COLOR_PURPLE 0x800080AA
#define COLOR_GRAD1 0xB4B5B7FF
#define COLOR_GRAD2 0xBFC0C2FF
#define COLOR_RED1 0xFF0000AA
#define COLOR_GREY 0xAFAFAFAA
#define COLOR_GREEN 0x33AA33AA
#define COLOR_RED 0xAA3333AA
#define COLOR_YELLOW 0xFFFF00AA
#define COLOR_WHITE 0xFFFFFFAA
#define COLOR_BROWN 0x993300AA
#define COLOR_CYAN 0x99FFFFAA
#define COLOR_TAN 0xFFFFCCAA
#define COLOR_PINK 0xFF66FFAA
#define COLOR_KHAKI 0x999900AA
#define COLOR_LIME 0x99FF00AA
#define COLOR_SYSTEM 0xEFEFF7AA
#define COLOR_GRAD2 0xBFC0C2FF
#define COLOR_GRAD4 0xD8D8D8FF
#define COLOR_GRAD6 0xF0F0F0FF
#define COLOR_GRAD2 0xBFC0C2FF
#define COLOR_GRAD3 0xCBCCCEFF
#define COLOR_GRAD5 0xE3E3E3FF
#define COLOR_GRAD1 0xB4B5B7FF
#define l_red 0xFF0000AA
#define l_green 0x33FF33AA
//===========================Define Color ===========================//

//=========================Define Error ==============================//
#define PERM_ERR "[SYSTEM][ERROR]: Error You not have Permission to use this Command"
#define printPERROR SendClientMessage(playerid,COLOR_RED1,PERM_ERR)
#define printMERROR SendClientMessage(playerid,COLOR_RED1,"[SYSTEM][ERROR]: You not have enough money to done this");

//==========================Define Commands to show===========================//
#define playerscmds "/ooc ,/b ,/s(hout),/w(hisper),/g(lobal), /me  \n  ,/unuseskin ,/useskin , /saveskin \n , /report , /admins , /animhelp , /chute , /ciggy , /kill  \n , /buylotto ,/giveitem ,/destroyitem ,/inv(entory),/stats ,/mystats "
#define level1cmds "/aduty,/asay,/mute, /unmute , /warn , /spawn ,/repairv , /repair , /fixv \n /addnosv , /addnos , /saveplace , /gotoplace , /goto ,/get ,/destroycars /spawn"
#define level2cmds " /spec ,/specoff ,/clearchat , /kick , /pheal, /acar ,/abike ,/aheli ,/aplane \n  /aboat , /givecar , /heal , /armour , /disarm , /duty , /jail ,/unjail , /freeze \n  /unfreeze , /akill , /slap , /punch , /kickass , /cars , /other ,/bikes ,/public \n  /security , /aircrafts , /boats"
#define level3cmds "/paplane , /announce , /announce2 , /ban ,/healall , /arnourall ,/killall \n /respawnall , /getall , /god , /settime ,/setworld ,/setpweather ,/sethealth \n /setarmour ,/setname , /giveweapon , /setcash ,/setscore ,/givecash ,/givescore  \n /lotto , /lottotickets , /lottoprice ,/lottodraw"
#define level4cmds "/respawncars , /giveallscore , /giveallcash , /giveallweapons ,/setallscore \n /setallcash , /setweather ,/setweatherid "
#define level5cmds "/setkills , /setdeath , /rpk ,/cancelrpk ,/setskin ,/setfaction ,/addfaction ,/saveallstats"
//#define atmcmds "/bankenter ,/bankexit ,/atmwd ,/balance,/withdraw,/deposit"
//#define bankcmds "/addatm ,/addbank ,/removeatm ,/removebank ,/setatmcash ,/setbankcash ,/get(atm/bank)id"
//#define phonehelp "/call[ID] , /answer , /hangup , /ignore \n Phone Price 1$ "
//#define factionhelp "/showfactions,/myfaction,/invite,/quitfaction,/setrank,/kickfromfaction,/factions"
//#define vipcmds "/pm , /spm"

//====================== Player stucture ====================//
enum gPlayerInfo
{
	Name[MAX_PLAYER_NAME],
	Password[256],
	LoggedIn,
	Register,
	Level,
	Muted,
	Kills,
	Death,
	Spawned,
	Hours,
 	Mins,
 	Secs,
 	Warnings,
 	Spec,
 	FailLogin,
	Kicked,
	Banned,
	Password,
	RPK,
	Money,
	Score,
	Skin,
	SkinStatus,
	SavePos,
	Float:PosX,
	Float:PosY,
	Float:PosZ,
	Float:PAngle,
	interior,
	Sex,
	Age,
	Team,
	Jail,
	PmStatus,
 	Hungry,
	Water,
	bddate,
	bdmonth,
	VIPLevel,
	FactionID,
	FactionLevel,
	Reputation,
	Float:Health,
	Float:Armour,
	Weapon1,
	Weapon1a,
	Weapon2,
	Weapon2a,
	Weapon3,
	Weapon3a,
	Weapon4,
	Weapon4a,
	Weapon5,
	Weapon5a,
	Weapon6,
	Weapon6a,
	Weapon7,
	Weapon7a,
	Weapon8,
	Weapon8a,
	Weapon9,
	Weapon9a,
	Weapon10,
	Weapon10a,
	Weapon11,
	Weapon11a,
	Weapon12,
	Weapon12a,
	Email[64],
	Reason[64],
	Banby[64]
};
new PlayerInfo[MAX_PLAYERS][gPlayerInfo];

//Define ======== Boolean
new bool:isGod[MAX_PLAYERS];
new bool:AdminDuty[MAX_PLAYERS];

///================== Function Declaration ==================//
forward bool:isAdmin(playerid,int:levelin);
bool:isAdmin(playerid,int:levelin)
{
	return (PlayerInfo[playerid][Level] >= levelin);
}

//================= Server Enum =======================//

enum ServerData
{

	NameKick,
	PartNameKick,
	ForbiddenWeaps,
	MaxMuteWarnings,
	AntiAds,
	WarStatus,
	Day,
	Month,
	Year,
	Hour,
	Min,
	Sec

};
new SInfo[ServerData];

//====================== Server Timer ===========================//
forward CountServer();
public CountServer()
{
	SInfo[Sec] ++;
	if(SInfo[Sec] == 60)
	{
	    SInfo[Sec] = 0;
	    SInfo[Min]++;
	    if(SInfo[Min] == 60)
	    {
	        SInfo[Min] = 0;
	        SInfo[Hour]++;
	        if(SInfo[Hour] == 24)
	        {
	            SInfo[Hour] = 0;
	            SInfo[Day]++;
	            if(SInfo[Day] == 31)
	            {
	                SInfo[Day] =1;
	                SInfo[Month]++;
	                if(SInfo[Month] == 12)
	                {
	                    SInfo[Month] = 1;
	                    SInfo[Year]++;
	                }
	            }
	        }
	    }
	}
}
forward realtime();
public realtime()
{
    for (new g = 0 ; g < MAX_PLAYERS ; g++)
    {
        if(IsPlayerConnected(g) > 0 )
        {
            for (new a = 0 ; a < MAX_PLAYERS ; a++)
            {
                if(IsPlayerConnected(a))
                {
                    if(PlayerInfo[a][LoggedIn] ==1)
                    {
                        PlayerInfo[a][Secs]++;
                        if(PlayerInfo[a][Secs] == 60)
                        {
                            PlayerInfo[a][Secs] =0;
                            PlayerInfo[a][Mins]++;
                            if(PlayerInfo[a][Mins] == 60)
                            {
                                PlayerInfo[a][Mins] =0;
                                PlayerInfo[a][Hours]++;
                            }
                        }
                    }
                }
            }
        }
        else if(IsPlayerConnected(g) <= 0)
        {
            return 1;
        }
    }
    return 1;
}

forward clearAnim(playerid);
public clearAnim(playerid)
{
    ClearAnimations(playerid);
	return 1;
}
//============================ MYSQL=================================//
//=============================MYSQL DAtabase===============================//
#define MYSQL_HOST "colonel-tech.com"
#define MYSQL_USER "samp"
#define MYSQL_DATABASE "samp"
#define MYSQL_PASSWORD ""
new MySQL:mysql;
new MySQLOpt:options = mysql_init_options();
mysql_set_option(options,AUTO_RECONNECT, true);
# auto_reconnect = true
//========================= FilterScript INIT ============================//
public OnFilterScriptInit()
{
    print("----------------------------------------------------");
	print("-----System Organization Administrator Loading------");
	print("----------------------------------------------------");
	new disb_T[32];
	DisableInteriorEnterExits();
	format(disb_T, sizeof(disb_T), "* Disabling Interior Enter and Exit Status: [%s]","Done" );
	print(disb_T);
	ManualVehicleEngineAndLights();
	print("* Disabling Interior Enter and Exit Status: [Done]");
	print("--------------- Loading User Database --------------");
	mysql_log(LOG_ALL);
	mysql = mysql_connect(MYSQL_HOST, MYSQL_USER,MYSQL_DATABASE,MYSQL_PASSWORD,options);
	if(mysql_errno() != 0)
	{
	    print("============== LOAD ===============");
	    print("============= MY SQL ==============");
	    print("============== FAILD ==============");
	    print("*Shutting Down");
		SendRconCommand("exit");
	}
	else
	{
	    print("============== LOAD ===============");
	    print("============= MY SQL ==============");
	    print("============== Done ==============");
	    print("*Load Database Successful");
	}

}

public OnPlayerConnect()
{
	SetPlayerColor(playerid, COLOR_GREY);
    GetPlayerName(playerid, pname, sizeof(pname));
    format(string, sizeof(string), "Player %s (ID:%d) has Connected To the Server", pname,playerid);
    SendClientMessageToAll(COLOR_LEMON, string);
}

