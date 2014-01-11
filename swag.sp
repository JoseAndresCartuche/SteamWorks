/*
    This file is part of SourcePawn SteamWorks.

    SourcePawn SteamWorks is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    SourcePawn SteamWorks is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with SourcePawn SteamWorks.  If not, see <http://www.gnu.org/licenses/>.
	
	Author: Kyle Sanderson (KyleS).
*/

#pragma semicolon 1
#include <sourcemod>
#include <SteamWorks>

public Plugin:myinfo = {
	name = "SteamWorks Additive Glider", /* SWAG */
	author = "Kyle Sanderson",
	description = "Translates SteamTools calls into SteamWorks calls.",
	version = "1.0",
	url = "http://AlliedMods.net"
};

public APLRes:AskPluginLoad2(Handle:myself, bool:late, String:error[], err_max)
{
	CreateNative("Steam_IsVACEnabled", native_IsVACEnabled);
	CreateNative("Steam_GetPublicIP", native_GetPublicIP);
	CreateNative("Steam_SetGameDescription", native_SetGameDescription);
	CreateNative("Steam_IsConnected", native_IsConnected);
	CreateNative("Steam_SetRule", native_SetRule);
	CreateNative("Steam_ClearRules", native_ClearRules);
	CreateNative("Steam_ForceHeartbeat", native_ForceHeartbeat);
	return APLRes_Success;
}

public native_IsVACEnabled(Handle:plugin, numParams)
{
	return SteamWorks_IsVACEnabled();
}

public native_GetPublicIP(Handle:plugin, numParams)
{
	new addr[4];
	SteamWorks_GetPublicIP(addr);
	SetNativeArray(1, addr, sizeof(addr));
	return 1;
}

public native_SetGameDescription(Handle:plugin, numParams)
{
	decl String:sDesc[PLATFORM_MAX_PATH];
	GetNativeString(1, sDesc, sizeof(sDesc));
	return SteamWorks_SetGameDescription(sDesc);
}

public native_IsConnected(Handle:plugin, numParams)
{
	return SteamWorks_IsConnected();
}