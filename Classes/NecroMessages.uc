class NecroMessages extends LocalMessage;

var() localized string PlayerRevived_part1;
var() localized string ComboCancelled;
var() localized string PlayerRevivedFreon_part1;
var() localized string ComboCancelledFreon;
var() localized string ComboCancelledEnd;


static function string GetString(optional int Switch,optional PlayerReplicationInfo RelatedPRI_1,
	optional PlayerReplicationInfo RelatedPRI_2,
	optional Object OptionalObject
	)
{
    if(Switch == 0)
    {
       return RelatedPRI_2.PlayerName@default.PlayerRevived_part1$" (Haidresser: "$RelatedPRI_1.PlayerName$")";
    }
    else if(Switch == 1)
    {
       return default.ComboCancelled;
    }
    else if(Switch==2)
    {
       return RelatedPRI_2.PlayerName@default.PlayerRevivedFreon_part1$" (Thawer: "$RelatedPRI_1.PlayerName$")";
    }   
    else if(Switch==3)
    {
       return default.ComboCancelledFreon;
    }
	else if(Switch == 4)
    {
       return default.ComboCancelledEnd;
    }
}

defaultproperties
{
     PlayerRevived_part1="'s hair is alive again"
     ComboCancelled="TEAM IS ALIVE"
     PlayerRevivedFreon_part1="was thawed instantly!"
     ComboCancelledFreon="No one is frozen!"
     ComboCancelledEnd="It,s round end you cunt"
     bIsUnique=True
     bIsPartiallyUnique=True
     bFadeMessage=True
     Lifetime=10
     DrawColor=(G=48,R=155)
     PosY=0.150000
}
