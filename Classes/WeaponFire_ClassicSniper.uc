class WeaponFire_ClassicSniper extends ClassicSniperFire;
#exec AUDIO IMPORT FILE=Sounds\ClassicSniper.wav GROUP=Sounds
event ModeDoFire()
{
    Misc_PRI(xPawn(Weapon.Owner).PlayerReplicationInfo).ClassicSniper.Fired += load;
    Super.ModeDoFire();
}

defaultproperties
{
     DamageMin=70
     DamageMax=70
     FireRate=1.600000
     HeadShotDamageMult=2.000000
     DamageTypeHeadShot=Class'3SPNCv42109.DamType_ClassicHeadshot'
     DamageType=Class'UTClassic.DamTypeClassicSniper'
     FireSound=Sound'ClassicSniper'
}
