/* Plugin Template generated by Pawn Studio */

#include <sourcemod>
#include <CodD0_engine>
#include <CodD0/skills/CodD0_skill_damage>

public Plugin myinfo =  {
	name = "CodD0 Perk: Commando's knife",
	author = "d0naciak",
	description =  "Commando's knife",
	version = "1.0",
	url = "d0naciak.pl"
}

int g_perkID;
bool g_hasPerk[MAXPLAYERS + 1];

public void OnPluginStart() {
	g_perkID = CodD0_RegisterPerk("Nóż Komandosa", "Natychmiastowe zabicie z noza (PPM)");
}

public void OnPluginEnd() {
	CodD0_UnregisterPerk(g_perkID);
}

public Action CodD0_PerkChanged(int client, int perkID, int perkValue) {
	if(g_perkID != perkID && g_hasPerk[client]) {
		CodD0_SetClientChanceToKillByKnife(client, CodD0_SkillSlot_Perk, 0, false);
		g_hasPerk[client] = false;
	}
	
	return Plugin_Continue;
}

public void CodD0_PerkChanged_Post(int client, int perkID, int perkValue) {
	if (perkID == g_perkID && !g_hasPerk[client]) {
		CodD0_SetClientChanceToKillByKnife(client, CodD0_SkillSlot_Perk, 1, true);
		g_hasPerk[client] = true;
	}
}