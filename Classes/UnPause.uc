/******************************************************************************
* Unreal Tournament 2004 UnPause
*
* Copyright (C) 2006 by Anton 'NakedApe' Emmerfors <nakedape@unrealnorth.com>
*
* This program is free software; you can redistribute and/or modify
* it under the terms of the Open Unreal Mod License version 1.1.
* http://wiki.beyondunreal.com/wiki/OpenUnrealModLicense
******************************************************************************/

class UnPause extends Mutator
  config(System);

#exec OBJ LOAD FILE=MenuSounds.uax
#exec OBJ LOAD FILE=WeaponSounds.uax

var localized string LBLCountDown, LBLLogOutAllPlayers;
var localized string DSCCountDown, DSCLogOutAllPlayers;
var config int CountDown;
var config bool bLogOutAllPlayers;
var float LocalTime, OldLocalTime;
var PlayerController UnPauser;
var sound CountBeep, FailBeep;
var string Version;

function PreBeginPlay() {
  local UnPause up;
  local array<string> mc;
  local int i;

  foreach AllActors(class'UnPause', up) {
    if(up != self && up.bUserAdded ) {
      Destroy();
      return;
    }
  }

  super.PreBeginPlay();

  Split(Level.GetLocalURL(), "?", mc);
  for(i = 0; i < mc.Length; i++) {
    if(Instr(Caps(mc[i]), "MUTATOR") >= 0) {
      break;
    }
  }
  Split(Mid(mc[i], 8), ",", mc);
  for(i = 0; i < mc.Length; i++) {
    if(mc[i] ~= string(Class)) {
      return;
    }
  }

  Level.Game.BaseMutator.AddMutator(self);
  bUserAdded = true;
}

function PostBeginPlay() {

  super.PostBeginPlay();
  Log("Unreal Tournament 2004 UnPauser v" $ Version @ "loaded");
}

function AddMutator(Mutator M) {

  if(M != self) {
    if(M.Class != Class) {
      super.AddMutator(M);
    } else {
      M.LifeSpan = 0.1;
    }
  }
}

function Mutate(string MutateString, PlayerController Sender) {

  super.Mutate(MutateString, Sender);

  if(MutateString ~= "UNPAUSE") {
    if(Level.Game.bPauseable || (Level.Game.bAdminCanPause && (Sender.IsA('Admin') || Sender.PlayerReplicationInfo.bAdmin)) || Level.Netmode==NM_Standalone) {
      if(Level.Pauser != none) {
        UnPauser = Sender;
        OldLocalTime = LocalTime;
        SetTimer(1.0, true);
        CountDown = default.CountDown;
      }
    } else if(!(Sender.IsA('Admin') || Sender.PlayerReplicationInfo.bAdmin)) {
      Sender.ClientMessage("You must be admin to unpause", 'CriticalEvent');
      Sender.ClientPlaySound(FailBeep);
    }
  }
}

function Timer() {
  local Controller c;

  if(CountDown > 0) {
    for(c = Level.ControllerList; c != none; c = c.NextController) {
      if(PlayerController(c) != none) {
        PlayerController(c).ClientMessage(CountDown, 'CriticalEvent');
        PlayerController(c).ClientPlaySound(CountBeep);
      }
    }
  } else if(CountDown == 0){
    for(c = Level.ControllerList; c != none; c = c.NextController) {
      if(PlayerController(c) != none) {
        PlayerController(c).ClientMessage("UNPAUSED --  THE GAME IS LIVE!", 'CriticalEvent');
        PlayerController(c).ClientPlaySound(CountBeep);
      }
    }
    Level.Game.SetPause(false, UnPauser);
    if(bLogOutAllPlayers) {
      for(c = Level.ControllerList; c != none; c = c.NextController) {
        if(PlayerController(c) != none && !c.PlayerReplicationInfo.bOnlySpectator) {
          c.ConsoleCommand("ADMINLOGOUT");
        }
      }
    } else {
      UnPauser.ConsoleCommand("ADMINLOGOUT");
    }
    UnPauser = none;
    SetTimer(0.0, false);
  }
  CountDown--;
}

static event string GetDescriptionText(string PropName) {

  switch(PropName) {
    case "CountDown":           return default.DSCCountDown;
    case "bLogOutAllPlayers":   return default.DSCLogOutAllPlayers;
  }
  return super.GetDescriptionText(PropName);
}

static function FillPlayInfo(PlayInfo PlayInfo) {

  super.FillPlayInfo(PlayInfo);

  PlayInfo.AddSetting("UnPause", "CountDown", default.LBLCountDown, 0, 4, "Text", "2;3:10");
  PlayInfo.AddSetting("UnPause", "bLogOutAllPlayers", default.LBLLogOutAllPlayers, 0, 6, "Check");
}

defaultproperties {
  bAlwaysTick = true
  CountDown = 3
  bLogOutAllPlayers = true
  CountBeep = sound'WeaponSounds.TAGTargetAquired'
  FailBeep = sound'MenuSounds.selectDshort'
  GroupName="UnPause"
  FriendlyName="UnPause"
  Description="Unpause game with countdown"
  LBLCountDown = "CountDown Length"
  LBLLogOutAllPlayers = "Log Out All Players"
  DSCCountDown = "Length of countdown before unpause."
  DSCLogOutAllPlayers = "Log out all admins (not spectators) or just the one unpausing."
  Version = "3SPN 1.2"
}
