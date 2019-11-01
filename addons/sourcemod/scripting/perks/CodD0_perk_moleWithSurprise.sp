/* Plugin Template generated by Pawn Studio */

#include <sourcemod>
#include <CodD0_engine>
#include <CodD0/skills/CodD0_skill_exploding>

public Plugin myinfo =  {
	name = "CodD0 Perk: Mole with surprise",
	author = "d0naciak",
	description =  "Mole with surprise",
	version = "1.0",
	url = "d0naciak.pl"
}

int g_perkID;
bool g_hasPerk[MAXPLAYERS + 1];
float g_roundStartTime;

public void OnPluginStart() {
	g_perkID = CodD0_RegisterPerk("Kret z niespodzianką", "Użyj, a w miejscu w które celujesz dojdzie do eksplozji. LW na rundę", 1, 2);

	HookEvent("round_start", ev_RoundStart_Post);
}

public void OnPluginEnd() {
	CodD0_UnregisterPerk(g_perkID);
}

public Action CodD0_PerkChanged(int client, int perkID, int perkValue) {
	if(g_perkID != perkID && g_hasPerk[client]) {
		CodD0_SetClientExplodes(client, CodD0_SkillSlot_Perk, 0, 0.0, 0.0, 0);
		g_hasPerk[client] = false;
	}
	
	return Plugin_Continue;
}

public void CodD0_PerkChanged_Post(int client, int perkID, int perkValue) {
	if(g_perkID == perkID) {
		CodD0_SetClientExplodes(client, CodD0_SkillSlot_Perk, perkValue, 60.0, 0.5, EXPLO_AIM);

		float gameTime = GetGameTime(), skillGotReadyTime = g_roundStartTime + 10.0;
		if(skillGotReadyTime > gameTime) {
			CodD0_ClientPerkGotReady(client, skillGotReadyTime - gameTime);
		}

		g_hasPerk[client] = true;
	}
}

public void CodD0_PerkUsed(int client, int perkID) {
	if(!g_hasPerk[client]) {
		return;
	}

	if(CodD0_UseExplode(client, CodD0_SkillSlot_Perk) == CodD0_SkillPrep_Available) {
		CodD0_ClientPerkGotReady(client, 4.0);
	}
}

public ev_RoundStart_Post(Handle event, const char[] name, bool dontBroadcast) {
	g_roundStartTime = GetGameTime();

	for  (int i = 1; i <= MaxClients; i++) {
		if (g_hasPerk[i]) {
			CodD0_ClientPerkGotReady(i, 10.0);
		}
	}
}