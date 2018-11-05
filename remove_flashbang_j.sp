#include <sourcemod>
#include <sdktools>
#include <sdkhooks>

public Plugin:myinfo = {
    name = "Remove flashbang",
    description = "Removes m84 flashbangs from players",
    author = "Neko-",
    version = "1.0.1",
};

public OnClientPutInServer(client) 
{
	if(!IsFakeClient(client))
	{
		SDKHook(client, SDKHook_WeaponSwitch, WeaponSwitchHook); 
	}
}

public Action:WeaponSwitchHook(client, weapon)
{
	decl String:sWeaponClassname[64]; 
	GetEntityClassname(weapon, sWeaponClassname, sizeof(sWeaponClassname));
	
	if(StrEqual(sWeaponClassname, "weapon_m84"))
	{
		RemovePlayerItem(client, weapon);
		RemoveEdict(weapon);
	}
	
	return Plugin_Continue;
}