local name, addon = ...

local defaultcfg = {
	["blizzheadnumbers"] = false,	-- use blizzard damage/healing output (above mob/player head)
	["damagestyle"] = true,		-- change default damage/healing font above mobs/player heads. you need to restart WoW to see changes! has no effect if blizzheadnumbers = false
-- xCT outgoing damage/healing options
	["damage"] = true,		-- show outgoing damage in it's own frame
	["healing"] = true,		-- show outgoing healing in it's own frame
	["showhots"] = true,		-- show periodic healing effects in xCT healing frame.
	["damagecolor"] = true,		-- display damage numbers depending on school of magic, see http://www.wowwiki.com/API_COMBAT_LOG_EVENT
	["critprefix"] = "|cffFF0000*|r",	-- symbol that will be added before amount, if you deal critical strike/heal. leave "" for empty. default is red *
	["critpostfix"] = "|cffFF0000*|r",	-- postfix symbol, "" for empty.
	["icons"] = true,		-- show outgoing damage icons
	["iconsize"] = 28,		-- icon size of spells in outgoing damage frame, also has effect on dmg font size if it's set to "auto"
	["petdamage"] = true,		-- show your pet damage.
	["dotdamage"] = true,		-- show damage from your dots. someone asked an option to disable lol.
	["treshold"] = 1,		-- minimum damage to show in outgoing damage frame
	["healtreshold"] = 1,		-- minimum healing to show in incoming/outgoing healing messages.

-- appearence
	["font"] = "Interface\\Addons\\xCT\\HOOGE.TTF",	-- "Fonts\\ARIALN.ttf" is default WoW font.
	["fontsize"] = 12,
	["fontstyle"] = "OUTLINE",	-- valid options are "OUTLINE", "MONOCHROME", "THICKOUTLINE", "OUTLINE,MONOCHROME", "THICKOUTLINE,MONOCHROME"
	["damagefont"] = "Interface\\Addons\\xCT\\HOOGE.TTF",	 -- "Fonts\\FRIZQT__.ttf" is default WoW damage font
	["damagefontsize"] = "auto",	-- size of xCT damage font. use "auto" to set it automatically depending on icon size, or use own value, 16 for example. if it's set to number value icons will change size.
	["timevisible"] = 3, 		-- time (seconds) a single message will be visible. 3 is a good value.
	["scrollable"] = false,		-- allows you to scroll frame lines with mousewheel.
	["maxlines"] = 64,		-- max lines to keep in scrollable mode. more lines=more memory. nom nom nom.

-- justify messages in frames, valid values are "RIGHT" "LEFT" "CENTER"
	["justify_1"] = "LEFT",		-- incoming damage justify
	["justify_2"] = "RIGHT",	-- incoming healing justify
	["justify_3"] = "CENTER",	-- various messages justify (mana, rage, auras, etc)
	["justify_4"] = "RIGHT",	-- outgoing damage/healing justify

-- class modules and goodies
	["stopvespam"] = false,		-- automaticly turns off healing spam for priests in shadowform. HIDE THOSE GREEN NUMBERS PLX!
	["dkrunes"] = true,		-- show deatchknight rune recharge
	["mergeaoespam"] = true,	-- merges multiple aoe spam into single message, can be useful for dots too.
	["mergeaoespamtime"] = 3,	-- time in seconds aoe spell will be merged into single message. minimum is 1.
	["killingblow"] = true,		-- tells you about your killingblows (works only with ["damage"] = true,)
	["dispel"] = true,		-- tells you about your dispels (works only with ["damage"] = true,)
	["interrupt"] = true,		-- tells you about your interrupts (works only with ["damage"] = true,)
}


if not xCT_Private then xCT_Private = {} end
if not xCT_Shared then xCT_Shared = {} end
if not xCT_Private["cfg"] then xCT_Private["cfg"] = {} end
if not xCT_Shared["cfg"] then xCT_Shared["cfg"] = {} end

-- create a config frame
local cfg = CreateFrame('Frame', name, InterfaceOptionsFramePanelContainer)
cfg:Hide()
cfg:SetAllPoints()
cfg.name = name
--cfg:SetScript("OnEvent", function(self, event, ...)
--	BlizzardOptionsPanel_OnEvent(self, event, ...)
--	if ( event == "PLAYER_ENTERING_WORLD" ) then
--		local control
--        -- run the enable FCT button's set func to refresh floating combat text and make sure the addon is loaded
--		control = InterfaceOptionsCombatPanelEnableFloatingCombatText
--		control.setFunc(GetCVar(control.cvar))
--	end
--end)

local title = cfg:CreateFontString(name .. "Title", "ARTWORK", "GameFontNormalLarge")
title:SetPoint("TOPLEFT", 16, -16)
title:SetText("|cffFF0000x|rCT " .. GetAddOnMetadata("xCT", "Version"))
title:SetJustifyH("LEFT")
title:SetJustifyV("TOP")

local subtext = cfg:CreateFontString(name .. "SubText", "ARTWORK", "GameFontHighlightSmall")
subtext:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 8, -8)
subtext:SetPoint("RIGHT", -32, 0)
subtext:SetMaxLines(3)
subtext:SetNonSpaceWrap(true)
subtext:SetText(COMBAT_TEXT_LABEL)
subtext:SetJustifyH("LEFT")
subtext:SetJustifyV("TOP")


InterfaceOptionsCombatPanelEnableFloatingCombatText:Hide()

local checkButton1 = CreateFrame("CheckButton", name .. "cb1", cfg, "InterfaceOptionsCheckButtonTemplate")
checkButton1:SetPoint("TOPLEFT", subtext, "BOTTOMLEFT", -2, -8)
 _G[checkButton1:GetName().."Text"]:SetText(SHOW_COMBAT_TEXT_TEXT)
checkButton1.tooltipText=SHOW_COMBAT_TEXT_TEXT
checkButton1.type = CONTROLTYPE_CHECKBOX
checkButton1.cvar = "enableFloatingCombatText"
checkButton1.uvar = "SHOW_COMBAT_TEXT"
checkButton1:HookScript("OnShow", function(self)
	self:SetChecked(GetCVarBool(self.cvar))
end)
checkButton1:HookScript("OnClick", function(self)
	if self:GetChecked() then
		self.value = 1
	else
		self.value = 0
	end
	SetCVar(self.cvar, self.value , self.cvar)
	if ( self.uvar ) then _G[self.uvar] = self.value; print(self.value,_G[self.uvar]) end
end)

local checkButton2 = CreateFrame("CheckButton", name .. "cb2", cfg, "InterfaceOptionsCheckButtonTemplate")
checkButton2:SetPoint("TOPLEFT", checkButton1, "BOTTOMLEFT")
 _G[checkButton2:GetName().."Text"]:SetText("test button")
checkButton1.tooltipText="tooltip text"
checkButton1:HookScript("OnShow", function(self)
	self:SetChecked(xCT_Shared["cfg"].damagestyle)
end)
checkButton2:HookScript("OnClick", function(self, button, action)
	xCT_Shared["cfg"].damagestyle=self:GetChecked()
end)


InterfaceOptions_AddCategory(cfg, name)
