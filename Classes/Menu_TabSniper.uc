class Menu_TabSniper extends UT2k3TabPanel;

var automated moComboBox SniperSelect;

function bool AllowOpen(string MenuClass)
{
	if(PlayerOwner()==None || PlayerOwner().PlayerReplicationInfo==None)
		return false;
	return true;
}

event Opened(GUIComponent Sender)
{
	local bool OldDirty;
	OldDirty = class'Menu_Menu3SPN'.default.SettingsDirty;
	super.Opened(Sender);
	class'Menu_Menu3SPN'.default.SettingsDirty = OldDirty;	
}

function InitComponent(GUIController MyController, GUIComponent MyOwner)
{
	local int i;
	local bool OldDirty;

	Super.InitComponent(myController,MyOwner);	 
	 
	OldDirty = class'Menu_Menu3SPN'.default.SettingsDirty;

	SniperSelect.AddItem("Lightning Gun");
	SniperSelect.AddItem("NEW ClassicSniper");
	SniperSelect.ReadOnly(True);
	//SniperSelect.SetIndex(class'TAM_Mutator'.default.SniperType - 1);

	class'Menu_Menu3SPN'.default.SettingsDirty = OldDirty;
}

function InternalOnChange( GUIComponent C )
{
    Switch(C)
    {	
		case SniperSelect:
			//class'TAM_Mutator'.default.SniperType = SniperSelect.GetIndex() + 1;
			break;
    }
	
    Misc_Player(PlayerOwner()).ReloadDefaults();
    class'Misc_Player'.Static.StaticSaveConfig();	
	class'Menu_Menu3SPN'.default.SettingsDirty = true;
}

defaultproperties
{
	Begin Object Class=moComboBox Name=ComboSniperType
         Caption="Sniper Selection:"
         OnCreateComponent=ComboDamageIndicatorType.InternalOnCreateComponent
         WinTop=0.350000
		 WinLeft=0.100000
         WinWidth=0.600000
		 OnChange=Menu_TabSniper.InternalOnChange
     End Object
     SniperSelect=moComboBox'3SPNCv42102.Menu_TabSniper.ComboSniperType'
}