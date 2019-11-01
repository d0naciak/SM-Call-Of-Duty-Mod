/* Plugin Template generated by Pawn Studio */

#include <sourcemod>
#include <CodD0_engine>
#include <CodD0/skills/CodD0_skill_recoil>

public Plugin myinfo =  {
	name = "CodD0 Perk: No recoil",
	author = "d0naciak",
	description =  "No recoil",
	version = "1.0",
	url = "d0naciak.pl"
}

int g_perkID;
bool g_hasPerk[MAXPLAYERS + 1];

public void OnPluginStart() {
	g_perkID = CodD0_RegisterPerk("Eliminator rozrzutu", "Brak rozrzutu podczas strzelania");
}

public void OnPluginEnd() {
	CodD0_UnregisterPerk(g_perkID);
}

public Action CodD0_PerkChanged(int client, int perkID, int perkValue) {
	if(g_perkID != perkID && g_hasPerk[client]) {
		CodD0_SetClientRecoil(client, CodD0_SkillSlot_Perk, 1.0);
		g_hasPerk[client] = false;
	}
	
	return Plugin_Continue;
}

public void CodD0_PerkChanged_Post(int client, int perkID, int perkValue) {
	if(g_perkID == perkID && !g_hasPerk[client]) {
		CodD0_SetClientRecoil(client, CodD0_SkillSlot_Perk, 0.0);
		g_hasPerk[client] = true;
	}
}