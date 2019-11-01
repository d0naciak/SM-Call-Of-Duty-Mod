/* Plugin Template generated by Pawn Studio */

#include <sourcemod>
#include <CodD0_engine>
#include <CodD0/skills/CodD0_skill_mine>

public Plugin myinfo =  {
	name = "CodD0 Perk: Sapper's mines",
	author = "d0naciak",
	description =  "Sapper's mines",
	version = "1.0",
	url = "d0naciak.pl"
}

int g_perkID;
bool g_hasPerk[MAXPLAYERS + 1];

public void OnPluginStart() {
	g_perkID = CodD0_RegisterPerk("Miny Sapera", "Dostajesz LW min, ktore zadają 150 obrażeń (+int)", 2, 4);
	
}

public void OnPluginEnd() {
	CodD0_UnregisterPerk(g_perkID);
}

public Action CodD0_PerkChanged(int client, int perkID, int perkValue) {
	if(g_perkID != perkID && g_hasPerk[client]) {
		CodD0_SetClientMines(client, CodD0_SkillSlot_Perk, 0, 0.0, 0.0);
		g_hasPerk[client] = false;
	}
	
	return Plugin_Continue;
}

public void CodD0_PerkChanged_Post(int client, int perkID, int perkValue) {
	if(g_perkID == perkID) {
		CodD0_SetClientMines(client, CodD0_SkillSlot_Perk, perkValue, 120.0, 0.5);
		g_hasPerk[client] = true;
	}
}

public void CodD0_PerkUsed(int client, int perkID) {
	if(g_hasPerk[client]) {
		CodD0_PlantMine(client, CodD0_SkillSlot_Perk);
	}
}