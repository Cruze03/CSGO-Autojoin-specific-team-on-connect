#include <sourcemod>
#include <cstrike>
#include <sdktools>

new Handle: Team
new Handle: OneTeam

public Plugin:myinfo = {
	name = "Auto Join Specific Team On Connect",
	author = "Divin! and Cr[U]zE",
	description = "Make Player on your server autojoin a specific team.",
	version = "1.0",
	url = ""
}

public OnPluginStart( ) {
	Team = CreateConVar( "sm_join_team", "1", "Enable or Disable Plugin." )
	OneTeam = CreateConVar( "sm_one_team", "3", "2 = T, 3 = CT" )
	
	HookEvent( "player_connect_full", Event_OnFullConnect, EventHookMode_Post )
}

public Event_OnFullConnect( Handle:event, const String:name[ ], bool:dontBroadcast ) {
	new client = GetClientOfUserId( GetEventInt( event, "userid" ) )
	
	if(client != 0 && IsClientInGame( client ) && !IsFakeClient( client ) ) 
	{
		CreateTimer( 0.5, AssignTeam, client )
	}
}

public Action: AssignTeam(Handle: timer, any: client) 
{
	if(IsClientInGame(client)) 
	{
		int iCvar = GetConVarInt(Team)
		int iCvar2 = GetConVarInt(OneTeam)
		
		if(iCvar != 1) 
		{
			return Plugin_Handled
		}
		ChangeClientTeam(client, iCvar2)
		CS_RespawnPlayer(client);

	}
	return Plugin_Continue
}