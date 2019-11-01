/* Plugin Template generated by Pawn Studio */

#include <sourcemod>
#include <CodD0_engine>
#include <CodD0/skills/CodD0_skill_thunderBolt>

public Plugin myinfo =  {
	name = "CodD0 Class: Electrician",
	author = "d0naciak",
	description =  "Electrician",
	version = "1.0",
	url = "d0naciak.pl"
}

int g_classID;
bool g_hasClass[MAXPLAYERS + 1];
float g_roundStartTime;

public void OnPluginStart() {
	g_classID = CodD0_RegisterClass("Elektryk", "Użyj, aby wystrzelić piorun (3 na rundę)", {10, 15, 5, 15}, { CSWeapon_FAMAS, CSWeapon_USP_SILENCER, CSWeapon_FLASHBANG }, 3);

	HookEvent("round_start", ev_RoundStart_Post);
}

public void OnPluginEnd() {
	CodD0_UnregisterClass(g_classID);
}

public Action CodD0_ClassChanged(int client, int classID) {
	if(g_classID != classID && g_hasClass[client]) {
		CodD0_SetClientThunderBolt(client, CodD0_SkillSlot_Class, 0, 0.0, 0.0);
		g_hasClass[client] = false;
	}

	return Plugin_Continue;
}

public void CodD0_ClassChanged_Post(int client, int classID) {
	if(g_classID == classID) {
		CodD0_SetClientThunderBolt(client, CodD0_SkillSlot_Class, 3, 50.0, 0.625);
		g_hasClass[client] = true;

		float gameTime = GetGameTime(), skillGotReadyTime = g_roundStartTime + 10.0;
		if(skillGotReadyTime > gameTime) {
			CodD0_ClientClassSkillGotReady(client, skillGotReadyTime - gameTime);
		}
	}
}

public void CodD0_ClassSkillUsed(int client, int classID) {
	if(g_classID != classID) {
		return;
	}

	if(CodD0_UseThunderBolt(client, CodD0_SkillSlot_Class) == CodD0_SkillPrep_Available) {
		CodD0_ClientClassSkillGotReady(client, 4.0);
	}
}


public ev_RoundStart_Post(Handle event, const char[] name, bool dontBroadcast) {
	g_roundStartTime = GetGameTime();

	for(int i = 1; i <= MaxClients; i++) {
		if (CodD0_GetClientClass(i) == g_classID) {
			CodD0_ClientClassSkillGotReady(i, 10.0);
		}
	}
}