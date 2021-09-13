class DamType_FlakShell extends DamTypeFlakShell;

var int AwardLevel;

static function IncrementKills(Controller Killer)
{
	local xPlayerReplicationInfo xPRI;

	xPRI = xPlayerReplicationInfo(Killer.PlayerReplicationInfo);
	if ( xPRI != None )
	{
		xPRI.flakcount++;
		if ( (xPRI.flakcount == Default.AwardLevel) && (Misc_Player(Killer) != None) )
			Misc_Player(Killer).BroadcastAnnouncement(Class'Message_FlakMan');
	}
}

defaultproperties
{
     AwardLevel=7
     DeathString="%o was ripped to shreds by %k's shrapnel."
     FemaleSuicide="%o blew herself up with a flak shell."
     MaleSuicide="%o blew himself up with a flak shell."
     bDetonatesGoop=True
     bThrowRagdoll=True
     GibPerterbation=0.250000
}
