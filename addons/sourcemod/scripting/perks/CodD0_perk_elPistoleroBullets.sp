/* Plugin Template generated by Pawn Studio */

#include <sourcemod>
#include <CodD0_engine>
#include <CodD0/skills/CodD0_skill_damage>

public Plugin myinfo =  {
	name = "CodD0 Perk: El Pistolero's bullets",
	author = "d0naciak",
	description =  "El Pistolero's bullets",
	version = "1.0",
	url = "d0naciak.pl"
}

int g_perkID;
bool g_hasPerk[MAXPLAYERS + 1];

public void OnPluginStart() {
	g_perkID = CodD0_RegisterPerk("Naboje El Pistolero", "1/LW szans na natychmistowe zabicie z pistoleta z HeadShota", 2, 4);
}

public void OnPluginEnd() {
	CodD0_UnregisterPerk(g_perkID);
}

public Action CodD0_PerkChanged(int client, int perkID, int perkValue) {
	if(g_perkID != perkID && g_hasPerk[client]) {
		CodD0_SetClientChanceToKillByHS(client, CodD0_SkillSlot_Perk, CSWeapon_P228, 0);
		CodD0_SetClientChanceToKillByHS(client, CodD0_SkillSlot_Perk, CSWeapon_GLOCK, 0);
		CodD0_SetClientChanceToKillByHS(client, CodD0_SkillSlot_Perk, CSWeapon_ELITE, 0);
		CodD0_SetClientChanceToKillByHS(client, CodD0_SkillSlot_Perk, CSWeapon_FIVESEVEN, 0);
		CodD0_SetClientChanceToKillByHS(client, CodD0_SkillSlot_Perk, CSWeapon_USP, 0);
		CodD0_SetClientChanceToKillByHS(client, CodD0_SkillSlot_Perk, CSWeapon_TEC9, 0);
		CodD0_SetClientChanceToKillByHS(client, CodD0_SkillSlot_Perk, CSWeapon_HKP2000, 0);
		CodD0_SetClientChanceToKillByHS(client, CodD0_SkillSlot_Perk, CSWeapon_P250, 0);
		CodD0_SetClientChanceToKillByHS(client, CodD0_SkillSlot_Perk, CSWeapon_USP_SILENCER, 0);
		CodD0_SetClientChanceToKillByHS(client, CodD0_SkillSlot_Perk, CSWeapon_CZ75A, 0);

		g_hasPerk[client] = false;
	}
	
	return Plugin_Continue;
}

public void CodD0_PerkChanged_Post(int client, int perkID, int perkValue) {
	if (perkID == g_perkID) {
		CodD0_SetClientChanceToKillByHS(client, CodD0_SkillSlot_Perk, CSWeapon_P228, perkValue);
		CodD0_SetClientChanceToKillByHS(client, CodD0_SkillSlot_Perk, CSWeapon_GLOCK, perkValue);
		CodD0_SetClientChanceToKillByHS(client, CodD0_SkillSlot_Perk, CSWeapon_ELITE, perkValue);
		CodD0_SetClientChanceToKillByHS(client, CodD0_SkillSlot_Perk, CSWeapon_FIVESEVEN, perkValue);
		CodD0_SetClientChanceToKillByHS(client, CodD0_SkillSlot_Perk, CSWeapon_USP, perkValue);
		CodD0_SetClientChanceToKillByHS(client, CodD0_SkillSlot_Perk, CSWeapon_TEC9, perkValue);
		CodD0_SetClientChanceToKillByHS(client, CodD0_SkillSlot_Perk, CSWeapon_HKP2000, perkValue);
		CodD0_SetClientChanceToKillByHS(client, CodD0_SkillSlot_Perk, CSWeapon_P250, perkValue);
		CodD0_SetClientChanceToKillByHS(client, CodD0_SkillSlot_Perk, CSWeapon_USP_SILENCER, perkValue);
		CodD0_SetClientChanceToKillByHS(client, CodD0_SkillSlot_Perk, CSWeapon_CZ75A, perkValue);

		g_hasPerk[client] = true;
	}
}