new Float: Stamina[MAX_PLAYERS];
new Float: MaximalStamina[MAX_PLAYERS];


callback: StaminaUpdate()
{
    new al[32];
    new an[32];
    for(new i=0; i< MAX_PLAYERS; i++)
    {
        if(!IsPlayerConnected(i)) continue;
        
        cef_emit_event(i, "cef:hud:run", CEFINT(Stamina[i]));

        if(!GetPlayerSpeed(i) && MaximalStamina[i] > Stamina[i]) Stamina[i] += 0.01;
        if(GetPVarInt(i,"Ustal"))
        {
            if(Stamina[i] >= 10)
            {
                TogglePlayerControllable(i,1);
                ClearAnimations(i);
                SetPVarInt(i,"Ustal",0);
            }
            else continue;
        }
        if(!strcmp(al,"PED") && !strcmp(an,"RUN_PLAYER") && GetPlayerState(i) == PLAYER_STATE_ONFOOT)
        {
            if(GetPlayerSpeed(i) > 130)
            {
                if(Stamina[i] < 0.05)
                {
                    TogglePlayerControllable(i,0);
                    SetPVarInt(i,"Ustal",1);
                    ApplyAnimation(i,"FAT","IDLE_tired",4.0,1,0,0,0,0,1);
                }
                Stamina[i] -= 0.05;
                MaximalStamina[i] += 0.005;
                continue;
            }
            else if(GetPlayerSpeed(i) > 50)
            {
                if(Stamina[i] < 0.02)
                {
                    TogglePlayerControllable(i,0);
                    SetPVarInt(i,"Ustal",1);
                    ApplyAnimation(i,"FAT","IDLE_tired",4.0,1,0,0,0,0,1);
                }
                Stamina[i] -= 0.02;
                MaximalStamina[i] += 0.002;
                continue;
            }
            else if(GetPlayerSpeed(i) > 0)
            {
                if(Stamina[i] < 0.005)
                {
                    TogglePlayerControllable(i,0);
                    SetPVarInt(i,"Ustal",1);
                    ApplyAnimation(i,"FAT","IDLE_tired",4.0,1,0,0,0,0,1);
                }
                Stamina[i] -= 0.005;
                MaximalStamina[i] += 0.0005;
                continue;
            }
        }
    }
    return 1;
}
stock stamina_OnGameModeInit()
{
    SetTimer("StaminaUpdate", 10, 1);
}
stock GetPlayerSpeed(playerid)
{
    new Float: SpeedPlayer[4];
    GetPlayerVelocity(playerid,SpeedPlayer[0], SpeedPlayer[1], SpeedPlayer[2]);
    SpeedPlayer[3] = floatsqroot(floatpower(floatabs(SpeedPlayer[0]), 2.0) + floatpower(floatabs(SpeedPlayer[1]), 2.0) + floatpower(floatabs(SpeedPlayer[2]), 2.0)) * 1000;
    return floatround(SpeedPlayer[3]);
}