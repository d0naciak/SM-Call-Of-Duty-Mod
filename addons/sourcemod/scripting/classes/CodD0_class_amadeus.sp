/* Plugin Template generated by Pawn Studio */

#include <sourcemod>
#include <CodD0_engine>
#include <CodD0/skills/CodD0_skill_damage>

public Plugin myinfo =  {
	name = "CodD0 Class: Amadeus",
	author = "d0naciak",
	description =  "Amadeus",
	version = "1.0",
	url = "d0naciak.pl"
}

int g_classID;
bool g_hasClass[MAXPLAYERS + 1];

public void OnPluginStart() {
	g_classID = CodD0_RegisterClass("Amadeusz", "+10 obrażeń (+int) z MP5", {0, 20, 25, 30}, { CSWeapon_MP5NAVY, CSWeapon_GLOCK }, 2);
}

public void OnPluginEnd() {
	CodD0_UnregisterClass(g_classID);
}

public Action CodD0_ClassChanged(int client, int classID) {
	if(g_classID != classID && g_hasClass[client]) {
		CodD0_SetClientDmgBonus(client, CodD0_SkillSlot_Class, CSWeapon_MP5NAVY, 0);
		CodD0_SetClientIntDmgMultiplier(client, CodD0_SkillSlot_Class, CSWeapon_MP5NAVY, 0.00); 
		g_hasClass[client] = false;
	}

	return Plugin_Continue;
}

public void CodD0_ClassChanged_Post(int client, int classID) {
	if(g_classID == classID) {
		CodD0_SetClientDmgBonus(client, CodD0_SkillSlot_Class, CSWeapon_MP5NAVY, 10);
		CodD0_SetClientIntDmgMultiplier(client, CodD0_SkillSlot_Class, CSWeapon_MP5NAVY, 0.045); 
		g_hasClass[client] = true;
	}
}