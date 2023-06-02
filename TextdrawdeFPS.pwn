#include    "a_samp.inc"

new Cronometro_FPS[MAX_PLAYERS];
new Text:FpsJogador[MAX_PLAYERS];

public OnPlayerConnect(playerid)
{
    FpsJogador[playerid] = TextDrawCreate(1.000000, 137.000000, "FPS: 000");
    TextDrawBackgroundColor(FpsJogador[playerid], 255);
    TextDrawFont(FpsJogador[playerid], 1);
    TextDrawLetterSize(FpsJogador[playerid], 0.140000, 0.799998);
    TextDrawColor(FpsJogador[playerid], 0xB4B5B7FF);
    TextDrawSetOutline(FpsJogador[playerid], 0);
    TextDrawSetProportional(FpsJogador[playerid], 1);
    TextDrawSetShadow(FpsJogador[playerid], 1);
    TextDrawUseBox(FpsJogador[playerid], 1);
    TextDrawBoxColor(FpsJogador[playerid], 255);
    TextDrawTextSize(FpsJogador[playerid], 19.000000, -311.000000);
    TextDrawSetSelectable(FpsJogador[playerid], 0);

    Cronometro_FPS[playerid] = SetTimerEx("AttFpsJogador", 1100, true, "i", playerid); // Recomendo que nao mexa no timer //
    return 1;
}
public OnPlayerDisconnect(playerid, reason)
{
    switch(reason)
    {
        case 0..2: KillTimer(Cronometro_FPS[playerid]);
    }
    return 1;
}
public OnPlayerSpawn(playerid)
{
    TextDrawShowForPlayer(playerid, FpsJogador[playerid]);
    return 1;
}
forward AttFpsJogador(playerid);
public AttFpsJogador(playerid)
{
    new string[128];
    format(string, sizeof(string), "FPS: %d", PegarFps_Jogador(playerid));
    TextDrawSetString(FpsJogador[playerid], string);
    return 1;
}

stock PegarFps_Jogador(playerid)
{
    SetPVarInt(playerid, "DrunkL", GetPlayerDrunkLevel(playerid));
    if(GetPVarInt(playerid, "DrunkL") < 100)
    {
        SetPlayerDrunkLevel(playerid, 2000);
    }
    else
    {
        if(GetPVarInt(playerid, "LDrunkL") != GetPVarInt(playerid, "DrunkL"))
        {
            SetPVarInt(playerid, "FPS", (GetPVarInt(playerid, "LDrunkL") - GetPVarInt(playerid, "DrunkL")));
            SetPVarInt(playerid, "LDrunkL", GetPVarInt(playerid, "DrunkL"));
            if((GetPVarInt(playerid, "FPS") > 0) && (GetPVarInt(playerid, "FPS") < 256))
            {
                return GetPVarInt(playerid, "FPS") - 1;
            }
        }
    }
    return 0;
}
