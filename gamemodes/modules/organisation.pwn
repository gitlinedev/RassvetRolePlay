CMD:setrang(playerid, params[])
{
	if(PI[playerid][pMember] <=0 ) return 0;
    if(PI[playerid][pRang] < 9) return SCM(playerid, COLOR_GREY, !"�������� � �������!");
	extract params -> new player:id, rank; else return SCM(playerid, COLOR_LIGHTGREY, !"�����������: /setrang [ID ������] [+/-]");

    if(PI[id][pRankUPTime] > gettime()) return SendClientMessage(playerid, COLOR_GREY, !"�������� ������ ����� ��� � 24 ����");
    if(PI[id][pRang] == 10) return SCM(playerid, COLOR_GREY, !"�� �� ������ �������� ���� ������");
    if(PI[playerid][pRang] == 9) 
    {
        if(rank == 43) if(PI[id][pRang]+1 > 8) return SCM(playerid, COLOR_GREY, !"�� �� ������ ������ ���� ������ 8");
    }
    if(PI[playerid][pRang] <= PI[id][pRang]) return SCM(playerid, COLOR_GREY, !"�� �� ������ ��������� ������ ������ ������ � ����");
    if(PI[id][pMember] != PI[playerid][pMember]) return SCM(playerid, COLOR_GREY, !"����� ���������� � ������ �����������!");
    if(!IsPlayerConnected(id)) return SCM(playerid, COLOR_GREY, !"����� �� ������");
	
    static name[24], nametwo[24];
	SetString(nametwo, NameRang(playerid));
	nametwo = NameRang(playerid);

	SetString(name, NameRang(id));
	name = NameRang(id);

    new oldrang = PI[id][pRang];

    if(rank == 43) // ��������
    {
        if(PI[id][pRang]+1 > 9) return SendClientMessagef(playerid, COLOR_LIGHTGREY, !"�� �� ������ �������� ����� ������, ��� ��� ��� ���� ����� 9 ��� ������");
        PI[id][pRang]++;
        SetRang("log_setrang", getName(playerid), PI[id][pRang], getName(id), "�������");
    }
    else if(rank == 45) // ��������
    {
        if(PI[id][pRang]-1 < 1) return SendClientMessagef(playerid, COLOR_LIGHTGREY, !"�� �� ������ �������� ����� ������, ��� ��� ��� ���� ����� 1");
        PI[id][pRang]--;
        SetRang("log_setrang", getName(playerid), PI[id][pRang], getName(id), "�������");
    }
	SCMf(id, 0x9eceffFF, "%s %s[%d] %s ��� ���� �� %s", nametwo, getName(playerid), playerid, oldrang < PI[id][pRang] ? ("�������"):("�������"), name);
	SCMf(playerid, 0x9eceffFF, "�� %s ���� %s[%d] �� %s", oldrang > PI[id][pRang] ? ("��������"):("��������"), getName(id), id, name);
	PI[id][pRang] = rank;
	UpdatePlayerDataInt(id, "rank", rank, 23215);
	UpdatePlayerDataInt(id, "RankUPTime", gettime()+86400, 23215);
	SavePlayerData(id);
	return 1;
}