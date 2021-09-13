class DamType_FlakChunk extends DamTypeFlakChunk;
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
     DeathString="%o was shredded by %k's flak cannon."
     FemaleSuicide="%o was perforated by her own flak."
     MaleSuicide="%o was perforated by his own flak."
     bDelayedDamage=True
     bBulletHit=True
     VehicleMomentumScaling=0.500000
}
