local name, addon = ...
local pdb, sdb = xCT_Private, xCT_Shared

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

-- create a config frame
local cfg = CreateFrame('Frame', name, InterfaceOptionsFramePanelContainer)
cfg:Hide()
cfg:SetAllPoints()
cfg.name = name
cfg:SetScript("OnEvent", function(self, event, ...)
	BlizzardOptionsPanel_OnEvent(self, event, ...)
	if ( event == "PLAYER_ENTERING_WORLD" ) then
		local control
        -- run the enable FCT button's set func to refresh floating combat text and make sure the addon is loaded
		control = InterfaceOptionsCombatPanelEnableFloatingCombatText
		control.setFunc(GetCVar(control.cvar))
	end
end)

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




--InterfaceOptionsCombatPanelEnableFloatingCombatText:Hide()
--local function mkCheckBox()



local checkButton1 = CreateFrame("CheckButton", name .. "cb1", cfg, "InterfaceOptionsCheckButtonTemplate")
checkButton1:SetPoint("TOPLEFT", subtext, "BOTTOMLEFT", -2, -8)
 _G[checkButton1:GetName().."Text"]:SetText(SHOW_COMBAT_TEXT_TEXT)
checkButton1.tooltipText=SHOW_COMBAT_TEXT_TEXT
checkButton1.type = CONTROLTYPE_CHECKBOX
checkButton1.cvar = "enableFloatingCombatText"
checkButton1.uvar = "SHOW_COMBAT_TEXT"
checkButton1:SetScript("OnLoad", function(self)
    self.setFunc = function (value)
		if ( value == "1" and not IsAddOnLoaded("Blizzard_CombatText") ) then
			UIParentLoadAddOn("Blizzard_CombatText")
		end
		BlizzardOptionsPanel_UpdateCombatText()
	end
    BlizzardOptionsPanel_RegisterControl(self, self:GetParent())
end)
checkButton1:SetScript("OnShow", function(self)
	BlizzardOptionsPanel_CheckButton_Refresh(self)
	if ( self.uvar ) then _G[self.uvar] = self.value end
end)
checkButton1:HookScript("OnClick", function(self)
	if self:GetChecked() then
		BlizzardOptionsPanel_SetCVarSafe(self.cvar, 1)
		self.value = 1
	else
		BlizzardOptionsPanel_SetCVarSafe(self.cvar, 0)
		self.value = 0
	end
	if ( self.uvar ) then _G[self.uvar] = self.value end
end)

local checkButton2 = CreateFrame("CheckButton", name .. "cb2", cfg, "InterfaceOptionsCheckButtonTemplate")
checkButton2:SetPoint("TOPLEFT", checkButton1, "BOTTOMLEFT")
 _G[checkButton2:GetName().."Text"]:SetText("test button")

checkButton2:HookScript("OnClick", function(self, button, action)
  if self:GetChecked() then
    print("Button " .. self:GetName() .. " is checked")
  else
    print("Button " .. self:GetName() .. " is unchecked")
  end
end)



InterfaceOptions_AddCategory(cfg, name)
