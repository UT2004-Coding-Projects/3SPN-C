class Menu_Menu3SPN extends UT2k3GUIPage;

var GUITabControl TabC;
var Menu_TabBrightskins BSTab;
var Menu_TabMisc MiscTab;
var UT2k3TabPanel AdminTab;
var Menu_TabNews NewsTab;
var Menu_TabColoredName ColorNameTab;

function InitComponent(GUIController MyController, GUIComponent MyOwner)
{
    Super.InitComponent(MyController, MyOwner);

    GUITitleBar(Controls[1]).Caption = class'GUIComponent'.static.StripColorCodes(PlayerOwner().Level.GRI.ServerName);

    TabC = GUITabControl(Controls[2]);

    if (class'Menu_TabNews'.default.Text.Length == 0)
        MiscTab = Menu_TabMisc(TabC.AddTab("Player settings", "3SPNv3177AT.Menu_TabMisc",, "Player settings", true));
    else
    {
        NewsTab = Menu_TabNews(TabC.AddTab("News", "3SPNv3177AT.Menu_TabNews",, "News", true));
        MiscTab = Menu_TabMisc(TabC.AddTab("Player settings", "3SPNv3177AT.Menu_TabMisc",, "Player settings", false));
    }
    BSTab = Menu_TabBrightskins(TabC.AddTab("Brightskins & Models", "3SPNv3177AT.Menu_TabBrightskins",, "Brightskins/Models settings", false));
    ColorNameTab = Menu_TabColoredName(TabC.AddTab("Colored Name", "3SPNv3177AT.Menu_TabColoredName",, "Colored Name", false));

    if(PlayerOwner().Level.GRI.GameClass ~= "3SPNv3177AT.TeamArenaMaster")
        AdminTab = Menu_TabTAMAdmin(TabC.AddTab("Admin", "3SPNv3177AT.Menu_TabTAMAdmin",, "Admin/Server configuration", false));
    else
        AdminTab = Menu_TabAMAdmin(TabC.AddTab("Admin", "3SPNv3177AT.Menu_TabAMAdmin",, "Admin/Server configuration", false));
}

function InternalOnClose(optional bool bCanceled)
{
    if(BSTab.RedSpinnyDude != None)
    {
        BSTab.RedSpinnyDude.Destroy();
        BSTab.RedSpinnyDude = None;
    }

    if(BSTab.BlueSpinnyDude != None)
    {
        BSTab.BlueSpinnyDude.Destroy();
        BSTab.BlueSpinnyDude = None;
    }
}

defaultproperties
{
     bRenderWorld=True
     bRequire640x480=False
     bAllowedAsLast=True
     OnClose=Menu_Menu3SPN.InternalOnClose
     Begin Object Class=GUIImage Name=MenuBack
         Image=Texture'2K4Menus.NewControls.Display98'
         ImageColor=(B=50,G=64,R=100,A=160)
         ImageStyle=ISTY_Stretched
         ImageRenderStyle=MSTY_Normal
         WinTop=0.100000
         WinLeft=0.100000
         WinWidth=0.800000
         WinHeight=0.800000
         RenderWeight=0.000003
     End Object
     Controls(0)=GUIImage'3SPNv3177AT.Menu_Menu3SPN.MenuBack'

     Begin Object Class=GUITitleBar Name=MenuTitle
         Effect=FinalBlend'InterfaceContent.Menu.CO_Final'
         Caption="AM/TAM Configuration"
         StyleName="Header"
         WinHeight=0.075000
         bBoundToParent=True
         bScaleToParent=True
     End Object
     Controls(1)=GUITitleBar'3SPNv3177AT.Menu_Menu3SPN.MenuTitle'

     Begin Object Class=GUITabControl Name=Tabs
         bDockPanels=True
         TabHeight=0.037500
         WinTop=0.060000
         WinLeft=0.015000
         WinWidth=0.970000
         WinHeight=1.000000
         bBoundToParent=True
         bScaleToParent=True
         bAcceptsInput=True
         OnActivate=Tabs.InternalOnActivate
     End Object
     Controls(2)=GUITabControl'3SPNv3177AT.Menu_Menu3SPN.Tabs'

     WinTop=0.089000
     WinLeft=0.100000
     WinWidth=0.800000
     WinHeight=0.775000
}
