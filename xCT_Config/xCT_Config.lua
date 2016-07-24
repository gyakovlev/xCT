local name, addon = ...

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
--local checkButton1 = CreateFrame("Button", "tb1", xCT_Options, "InterfaceOptionsCheckButtonTemplate")
local checkButton1 = CreateFrame("CheckButton", name .. "cb1", cfg, "OptionsSmallCheckButtonTemplate")
checkButton1.tooltipText=SHOW_COMBAT_TEXT_TEXT
checkButton1:SetPoint("TOPLEFT", subtext, "BOTTOMLEFT", -2, -8)
 _G[checkButton1:GetName().."Text"]:SetText("test button")
--checkButton1:RegisterForClicks("AnyUp", "AnyDown")
checkButton1:SetScript("OnLoad", function(self)
	self.type = CONTROLTYPE_CHECKBOX
	self.cvar = "enableFloatingCombatText"
	self.uvar = "SHOW_COMBAT_TEXT"
	self.setFunc = function (value)
		if ( value == "1" and not IsAddOnLoaded("Blizzard_CombatText") ) then
			UIParentLoadAddOn("Blizzard_CombatText")
		end
		BlizzardOptionsPanel_UpdateCombatText()
	end
	BlizzardOptionsPanel_RegisterControl(self, self:GetParent())
end)
checkButton1:HookScript("OnClick", function(self)
	print(GetCVar("enableFloatingCombatText"))
	--for i, v in ipairs(self:GetParent().controls) do
	--	print(i, v)
	--end
end)

local checkButton2 = CreateFrame("CheckButton", name .. "cb2", cfg, "OptionsSmallCheckButtonTemplate")
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
