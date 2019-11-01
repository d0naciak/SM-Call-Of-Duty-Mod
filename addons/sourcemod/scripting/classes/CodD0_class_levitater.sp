/* Plugin Template generated by Pawn Studio */

#include <sourcemod>
#include <CodD0_engine>
#include <CodD0/skills/CodD0_skill_multiJump>
#include <CodD0/skills/CodD0_skill_longJump>
#include <CodD0/skills/CodD0_skill_noFallDamage>
#include <CodD0/skills/CodD0_skill_gravity>

public Plugin myinfo =  {
	name = "CodD0 Class: Levitater",
	author = "d0naciak",
	description =  "Levitater",
	version = "1.0",
	url = "d0naciak.pl"
}

int g_classID;
bool g_hasClass[MAXPLAYERS + 1];
float g_roundStartTime;

public void OnPluginStart() {
	g_classID = CodD0_RegisterClass("Lewiter", "Podwójny skok, użyj aby wykonać LongJump (moc +int), zmniejszona grawitacja, odporny na upadki", {10, 10, 25, 60}, { CSWeapon_MP5NAVY, CSWeapon_FIVESEVEN, CSWeapon_DECOY }, 3);

	HookEvent("round_start", ev_RoundStart_Post);
}

public void OnPluginEnd() {
	CodD0_UnregisterClass(g_classID);
}

public Action CodD0_ClassChanged(int client, int classID) {
	if(g_classID != classID && g_hasClass[client]) {
		CodD0_SetClientMultiJumps(client, CodD0_SkillSlot_Class, 0);
		CodD0_SetClientLongJumps(client, CodD0_SkillSlot_Class, 0, 0, 0.0);
		CodD0_SetClientGravity(client, CodD0_SkillSlot_Class, 0.0);
		CodD0_SetClientNoFallDamage(client, CodD0_SkillSlot_Class, false);
		g_hasClass[client] = false;
	}

	return Plugin_Continue;
}

public void CodD0_ClassChanged_Post(int client, int classID) {
	if(g_classID == classID) {
		CodD0_SetClientMultiJumps(client, CodD0_SkillSlot_Class, 2);
		CodD0_SetClientLongJumps(client, CodD0_SkillSlot_Class, 99, 500, 3.125);
		CodD0_SetClientGravity(client, CodD0_SkillSlot_Class, 0.6);
		CodD0_SetClientNoFallDamage(client, CodD0_SkillSlot_Class, true);
		g_hasClass[client] = true;

		float gameTime = GetGameTime(), skillGotReadyTime = g_roundStartTime + 10.0;
		if(skillGotReadyTime > gameTime) {
			CodD0_ClientClassSkillGotReady(client, skillGotReadyTime - gameTime);
		}
	}
}

public void CodD0_ClassSkillUsed(int client, int classID) {
	if(!g_hasClass[client]) {
		return;
	}

	if(CodD0_UseClientLongJump(client, CodD0_SkillSlot_Class) == CodD0_SkillPrep_Available) {
		CodD0_ClientClassSkillGotReady(client, 14.0);
	}
}

public ev_RoundStart_Post(Handle event, const char[] name, bool dontBroadcast) {
	g_roundStartTime = GetGameTime();

	for(int i = 1; i <= MaxClients; i++) {
		if (g_hasClass[i]) {
			CodD0_ClientClassSkillGotReady(i, 10.0);
		}
	}
}