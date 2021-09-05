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
        SniperSelect.SetIndex(Misc_PRI(Misc_Player(PlayerOwner()).PlayerReplicationInfo).SniperType);
    class'Menu_Menu3SPN'.default.SettingsDirty = OldDirty;
}

function InternalOnChange( GUIComponent C )
{
    Switch(C)
    {	
            case SniperSelect:
            // client display(menu reopen)
            Misc_PRI(Misc_Player(PlayerOwner()).PlayerReplicationInfo).SniperType = SniperSelect.GetIndex();
            // send choice to server
            Misc_PRI(Misc_Player(PlayerOwner()).PlayerReplicationInfo).SetSniperType(SniperSelect.GetIndex());
            break;
    }
	
    Misc_Player(PlayerOwner()).ReloadDefaults();
    Misc_PRI(Misc_Player(PlayerOwner()).PlayerReplicationInfo).SaveConfig(); 
       class'Misc_Player'.Static.StaticSaveConfig();	
    class'Menu_Menu3SPN'.default.SettingsDirty = true;
}

defaultproperties
{
	Begin Object Class=moComboBox Name=ComboSniperType
         Caption="Sniper Selection:"
         OnCreateComponent=ComboSniperType.InternalOnCreateComponent
         WinTop=0.350000
		 WinLeft=0.100000
         WinWidth=0.600000
		 OnChange=Menu_TabSniper.InternalOnChange
     End Object
     SniperSelect=moComboBox'3SPNCv42109.Menu_TabSniper.ComboSniperType'
}