--[[

xCT by affli @ RU-Howling Fjord
All rights reserved.
Thanks ALZA and Shestak for making this mod possible. Thanks Tukz for his wonderful style of coding. Thanks Rostok for some fixes and healing code.

]]--

local myname, _ = UnitName("player")
local version, build, date = GetBuildInfo()
local release = tonumber(string.sub(version,0,1))

local ct={

	["myclass"] = select(2,UnitClass("player")),
	["myname"] = myname,
---------------------------------------------------------------------------------
-- config
-- options
	["damage"] = true,		-- show outgoing damage in it's own frame
	["healing"] = true,		-- show outgoing healing in it's own frame
	["damagecolor"] = true,		-- display damage numbers depending on school of magic, see http://www.wowwiki.com/API_COMBAT_LOG_EVENT
	["critprefix"] = "*",		-- symbol that will be added before amount, if you deal critical strike/heal. leave "" for empty.
	["critpostfix"] = "*",		-- postfix symbol, "" for empty.
	["icons"] = true,		-- show outgoing damage icons
	["iconsize"] = 27,		-- icon size of spells in outgoing damage frame, also has effect on dmg font size.
	["damagestyle"] = true,		-- change default damage/healing font above mobs/player heads. you need to restart WoW to see changes!
	["treshold"] = 1,		-- minimum damage to show in damage frame
	["healtreshold"] = 1,		-- minimum healing to show in incoming/outgoing healing messages.
	["scrollable"] = false,		-- allows you to scroll frame lines with mousewheel.
	["maxlines"] = 64,		-- max lines to keep in scrollable mode. more lines=more memory. nom nom nom.

-- appearence
	["font"] = "Interface\\Addons\\xCT\\HOOGE.TTF",	-- "Fonts\\ARIALN.ttf" is default WoW font.
	["fontsize"] = 12,
	["fontstyle"] = "OUTLINE",	-- valid options are "OUTLINE", "MONOCHROME", "THICKOUTLINE", "OUTLINE,MONOCHROME", "THICKOUTLINE,MONOCHROME"
	["damagefont"] = "Interface\\Addons\\xCT\\HOOGE.TTF",	 -- "Fonts\\FRIZQT__.ttf" is default WoW damage font
	["timevisible"] = 3, 		-- time (seconds) a single message will be visible. 3 is a good value.

-- class modules and goodies
	["stopvespam"] = false,		-- automaticly turns off healing spam for priests in shadowform. HIDE THOSE GREEN NUMBERS PLX!
	["dkrunes"] = true,		-- show deatchknight rune recharge
	["stopfaspam"] = false,		-- do not show Fel Armor healing ticks, useful for warlocks.
}

---------------------------------------------------------------------------------
-- class config, overrides general
if ct.myclass == "WARLOCK" then
	ct["stopfaspam"] = true
end
---------------------------------------------------------------------------------
-- character config, overrides general and class
if ct.myname == "Affli" then
	ct["treshold"] = 500
end
---------------------------------------------------------------------------------

