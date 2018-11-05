#include <sourcemod>
#include <sdktools>
#include <sdkhooks>

public Plugin:myinfo = 
{
	name = "[INS] Drop Items",
	author = "Neko-",
	description = "Drop the weapon or item you are holding",
	version = "1.0.0",
}

new const String:BlacklistWeaponNames[][] =
{
	"weapon_kabar",
	"weapon_gurkha",
	"weapon_knife",
	"weapon_kukri",
	"weapon_katana",
	"weapon_defib"
}

public OnPluginStart()
{
	RegConsoleCmd("drop", Drop_Stuff, "Drop the item in your hand");
}

public Action:Drop_Stuff(client,args)
{
	new health = GetClientHealth(client);
	
	if (health > 0)
	{
		new CurrentUserWeapon = GetEntPropEnt(client, Prop_Send, "m_hActiveWeapon");
		if (CurrentUserWeapon < 0) {
			return Plugin_Continue;
		}
		
		decl String:User_Weapon[32];
		GetEdictClassname(CurrentUserWeapon, User_Weapon, sizeof(User_Weapon));
		
		for (new count=0; count<6; count++)
		{
			//prevent user from dropping knife
			if (StrEqual(User_Weapon, BlacklistWeaponNames[count]))
			{
				return Plugin_Continue;
			}
		}
		SDKHooks_DropWeapon(client, CurrentUserWeapon, NULL_VECTOR, NULL_VECTOR);
	}
	
	return Plugin_Handled;
}