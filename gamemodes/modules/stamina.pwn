new MaxRun = 120;
new RunTimer;

callback: RunCheck()
{
    new al[32], an[32];
    for(new i = 0; i < MAX_PLAYERS; i++)
    {
        if(!IsPlayerConnected(i)) continue;

        cef_emit_event(i, "cef:hud:run", CEFINT(floatround(PI[i][pRun], floatround_round)));

        if(!GetPlayerSpeed(i) && MaxRun > PI[i][pRun]) PI[i][pRun] += 0.05;

        if(GetPVarInt(i, "Colddown"))
        {
            if(PI[i][pRun] >= 10)
            {
                TogglePlayerControllable(i, 1);
                ClearAnimations(i);
                SetPVarInt(i, "Colddown", 0);
            }
            else continue;
        }

        if(!strcmp(al, "PED") && !strcmp(an, "RUN_PLAYER") && GetPlayerState(i) == PLAYER_STATE_ONFOOT)
        {
            if(GetPlayerSpeed(i) > 130)
            {
                if(PI[i][pRun] < 0.05)
                {
                    TogglePlayerControllable(i, 0);
                    SetPVarInt(i, "Colddown", 1);
                    ApplyAnimation(i, "FAT", "IDLE_tired", 4.0, 1, 0, 0, 0, 0, 1);
                }
                PI[i][pRun] -= 0.03;
                continue;
            }
            else if(GetPlayerSpeed(i) > 50)
            {
                if(PI[i][pRun] < 0.02)
                {
                    TogglePlayerControllable(i, 0);
                    SetPVarInt(i, "Colddown", 1);
                    ApplyAnimation(i, "FAT", "IDLE_tired", 4.0, 1, 0, 0, 0, 0, 1);
                }
                PI[i][pRun] -= 0.01;
                continue;
            }
            else if(GetPlayerSpeed(i) > 0)
            {
                if(PI[i][pRun] < 0.005)
                {
                    TogglePlayerControllable(i, 0);
                    SetPVarInt(i, "Colddown", 1);
                    ApplyAnimation(i, "FAT", "IDLE_tired", 4.0, 1, 0, 0, 0, 0, 1);
                }
                PI[i][pRun] -= 0.003;
                continue;
            }
        }
    }
    return 1;
}
stock GetPlayerSpeed(playerid)
{
    new Float:ST1[4];
    GetPlayerVelocity(playerid, ST1[0],ST1[1],ST1[2]);
    ST1[3] = floatsqroot(floatpower(floatabs(ST1[0]), 2.0) + floatpower(floatabs(ST1[1]), 2.0) + floatpower(floatabs(ST1[2]), 2.0)) * 1000;
    return floatround(ST1[3]);
}