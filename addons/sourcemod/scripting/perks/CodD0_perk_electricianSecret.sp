/* Plugin Template generated by Pawn Studio */

#include <sourcemod>
#include <CodD0_engine>
#include <CodD0/skills/CodD0_skill_thunderBolt>

public Plugin myinfo =  {
	name = "CodD0 Perk: Electrician secret",
	author = "d0naciak",
	description = "Electrician secret",
	version = "1.0",
	url = "d0naciak.pl"
}

int g_perkID;
float g_roundStartTime;

bool g_hasPerk[MAXPLAYERS + 1];

public void OnPluginStart() {
	g_perkID = CodD0_RegisterPerk("Tajemnica Elektryka", "Dostajesz LW błyskawic(e)", 2, 4);
}

public void OnPluginEnd() {
	CodD0_UnregisterPerk(g_perkID);
}

public Action CodD0_PerkChanged(int client, int perkID, int perkValue) {
	if(g_perkID != perkID && g_hasPerk[client]) {
		CodD0_SetClientThunderBolt(client, CodD0_SkillSlot_Perk, 0, 0.0, 0.0);
		g_hasPerk[client] = false;
	}
	
	return Plugin_Continue;
}

public void CodD0_PerkChanged_Post(int client, int perkID, int perkValue) {
	if (perkID == g_perkID) {
		CodD0_SetClientThunderBolt(client, CodD0_SkillSlot_Perk, perkValue, 50.0, 0.625);
		g_hasPerk[client] = true;

		float gameTime = GetGameTime(), skillGotReadyTime = g_roundStartTime + 10.0;
		if(skillGotReadyTime > gameTime) {
			CodD0_ClientPerkGotReady(client, skillGotReadyTime - gameTime);
		}
	}
}

public void CodD0_PerkUsed(int client, int perkID) {
	if (!g_hasPerk[client]) {
		return;
	}

	if(CodD0_UseThunderBolt(client, CodD0_SkillSlot_Perk) == CodD0_SkillPrep_Available) {
		CodD0_ClientPerkGotReady(client, 4.0);
	}
}


public void ev_RoundStart_Post(Handle event, const char[] name, bool dontBroadcast) {
	g_roundStartTime = GetGameTime();

	for (int i = 1; i <= MaxClients; i++) {
		if (g_hasPerk[i]) {
			CodD0_ClientPerkGotReady(i, 10.0);
		}
	}
}