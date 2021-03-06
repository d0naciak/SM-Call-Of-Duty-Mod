/* Plugin Template generated by Pawn Studio */

#include <sourcemod>
#include <CodD0_engine>
#include <CodD0/skills/CodD0_skill_bouncingShield>

public Plugin myinfo =  {
	name = "CodD0 Perk: Mirror armor",
	author = "d0naciak",
	description =  "Mirror armor",
	version = "1.0",
	url = "d0naciak.pl"
}

int g_perkID;
bool g_hasPerk[MAXPLAYERS + 1];

public void OnPluginStart() {
	g_perkID = CodD0_RegisterPerk("Lustrzana zbroja", "Użyj, a przez 6 sec. LW% otrzymanych obrażeń będzie się odbijała w stronę wroga", 15, 45);
}

public void OnPluginEnd() {
	CodD0_UnregisterPerk(g_perkID);
}

public Action CodD0_PerkChanged(int client, int perkID, int perkValue) {
	if(g_perkID != perkID && g_hasPerk[client]) {
		CodD0_SetClientBouncingShield(client, CodD0_SkillSlot_Perk, 0.0, 0, 0.0);
		g_hasPerk[client] = false;
	}
	
	return Plugin_Continue;
}

public void CodD0_PerkChanged_Post(int client, int perkID, int perkValue) {
	if(g_perkID == perkID) {
		CodD0_SetClientBouncingShield(client, CodD0_SkillSlot_Perk, float(perkValue) * 0.01, 1, 6.0);
		g_hasPerk[client] = true;
	}
}

public void CodD0_PerkUsed(int client, int perkID) {
	if(g_perkID == perkID) {
		CodD0_UseBouncingShield(client, CodD0_SkillSlot_Perk);
	}
}