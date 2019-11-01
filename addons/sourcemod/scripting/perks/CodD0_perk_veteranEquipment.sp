/* Plugin Template generated by Pawn Studio */

#include <sourcemod>
#include <CodD0_engine>
#include <CodD0/skills/CodD0_skill_damage>

public Plugin myinfo =  {
	name = "CodD0 Perk: Veteran Equipment",
	author = "d0naciak",
	description = "Veteran Equipment",
	version = "1.0",
	url = "d0naciak.pl"
}

int g_perkID;
bool g_hasPerk[MAXPLAYERS + 1];

public void OnPluginStart() {
	g_perkID = CodD0_RegisterPerk("Wyposażenie Weterana", "-40 do prędkości, +60 do zdrowia, +10 do obrażeń");
}

public void OnPluginEnd() {
	CodD0_UnregisterPerk(g_perkID);
}

public Action CodD0_PerkChanged(int client, int perkID, int perkValue) {
	if (perkID != g_perkID && g_hasPerk[client]) {
		CodD0_SetClientBonusStatsPoints(client, SPEED_PTS, CodD0_GetClientBonusStatsPoints(client, SPEED_PTS) + 40);
		CodD0_SetClientBonusStatsPoints(client, HEALTH_PTS, CodD0_GetClientBonusStatsPoints(client, HEALTH_PTS) - 60);
		CodD0_SetClientDmgBonus(client, CodD0_SkillSlot_Perk, CSWeapon_NONE, 0);

		g_hasPerk[client] = false;
	}

	return Plugin_Continue;
}

public void CodD0_PerkChanged_Post(int client, int perkID, int perkValue) {
	if (perkID == g_perkID && !g_hasPerk[client]) {
		CodD0_SetClientBonusStatsPoints(client, SPEED_PTS, CodD0_GetClientBonusStatsPoints(client, SPEED_PTS) - 40);
		CodD0_SetClientBonusStatsPoints(client, HEALTH_PTS, CodD0_GetClientBonusStatsPoints(client, HEALTH_PTS) + 60);
		CodD0_SetClientDmgBonus(client, CodD0_SkillSlot_Perk, CSWeapon_NONE, 10);

		g_hasPerk[client] = true;
	}
}