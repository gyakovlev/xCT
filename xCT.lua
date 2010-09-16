--[[

xCT by affli @ RU-Howling Fjord
All rights reserved.
Thanks ALZA and Shestak for making this mod possible.

]]--

-- config starts --
local configmode=false -- set to true to move and resize text frames.
local damagestyle=true -- set to true to change default damage/healing font above mobs/player heads. you need to restart WoW to see changes!
local ctfont,ctfontsize,ctfontstyle="Interface\\Addons\\xCT\\HOOGE.TTF",12,"OUTLINE" -- "Fonts\\ARIALN.ttf" is default WoW font.
local damagefont="Interface\\Addons\\xCT\\HOOGE.TTF"  -- "Fonts\\FRIZQT__.ttf" is default WoW damage font.
-- config ends   --



--do not edit below unless you know what you are doing--
-- code starts --
local ct={}
-- detect vechile --
local function SetUnit()
	if(UnitHasVehicleUI("player"))then
		ct.unit="vehicle"
	else
		ct.unit="player"
	end
end
-- msg flow direction
local function ScrollDirection()
	if (COMBAT_TEXT_FLOAT_MODE=="2") then
		ct.mode="TOP"
	else
		ct.mode="BOTTOM"
	end
	for i=1,3 do
		frames[i]:Clear()
		frames[i]:SetInsertMode(ct.mode)
	end
end
-- partial resists styler --
local part="-%s (%s %s)"
--[[ message tosser --
local function AddMSG(frame,r,g,b,prefix,ispartial, ...)
	local msg=prefix..arg2
		frames[frame]:AddMessage(msg,r,g,b)
end]]
-- the function, handles everything --
local function OnEvent(self,event,subevent,...)
if(event=="COMBAT_TEXT_UPDATE")then
	if (SHOW_COMBAT_TEXT=="0")then
		return
	else
	if subevent=="DAMAGE"then
		xCT1:AddMessage("-"..arg2,.75,.1,.1)
	elseif subevent=="DAMAGE_CRIT"then
		xCT1:AddMessage("c-"..arg2,1,.1,.1)
	elseif subevent=="SPELL_DAMAGE"then
		xCT1:AddMessage("-"..arg2,.75,.3,.85)
	elseif subevent=="SPELL_DAMAGE_CRIT"then
		xCT1:AddMessage("c-"..arg2,1,.3,.5)

	elseif subevent=="HEAL"then
		xCT2:AddMessage("+"..arg3,.1,.75,.1)
	elseif subevent=="HEAL_CRIT"then
		xCT2:AddMessage("c+"..arg3,.1,1,.1)
	elseif subevent=="PERIODIC_HEAL"then
		xCT2:AddMessage("+"..arg3,.1,.5,.1)

	elseif subevent=="SPELL_CAST"then
		xCT3:AddMessage(arg2,1,.82,0)

	
	elseif subevent=="MISS"and(COMBAT_TEXT_SHOW_DODGE_PARRY_MISS=="1")then
		xCT1:AddMessage(MISS,.5,.5,.5)
	elseif subevent=="DODGE"and(COMBAT_TEXT_SHOW_DODGE_PARRY_MISS=="1")then
		xCT1:AddMessage(DODGE,.5,.5,.5)
	elseif subevent=="PARRY"and(COMBAT_TEXT_SHOW_DODGE_PARRY_MISS=="1")then
		xCT1:AddMessage(PARRY,.5,.5,.5)
	elseif subevent=="EVADE"and(COMBAT_TEXT_SHOW_DODGE_PARRY_MISS=="1")then
		xCT1:AddMessage(EVADE,.5,.5,.5)
	elseif subevent=="IMMUNE"and(COMBAT_TEXT_SHOW_DODGE_PARRY_MISS=="1")then
		xCT1:AddMessage(IMMUNE,.5,.5,.5)
	elseif subevent=="DEFLECT"and(COMBAT_TEXT_SHOW_DODGE_PARRY_MISS=="1")then
		xCT1:AddMessage(DEFLECT,.5,.5,.5)
	elseif subevent=="REFLECT"and(COMBAT_TEXT_SHOW_DODGE_PARRY_MISS=="1")then
		xCT1:AddMessage(REFLECT,.5,.5,.5)
	elseif subevent=="SPELL_MISS"and(COMBAT_TEXT_SHOW_DODGE_PARRY_MISS=="1")then
		xCT1:AddMessage(MISS,.5,.5,.5)
	elseif subevent=="SPELL_DODGE"and(COMBAT_TEXT_SHOW_DODGE_PARRY_MISS=="1")then
		xCT1:AddMessage(DODGE,.5,.5,.5)
	elseif subevent=="SPELL_PARRY"and(COMBAT_TEXT_SHOW_DODGE_PARRY_MISS=="1")then
		xCT1:AddMessage(PARRY,.5,.5,.5)
	elseif subevent=="SPELL_EVADE"and(COMBAT_TEXT_SHOW_DODGE_PARRY_MISS=="1")then
		xCT1:AddMessage(EVADE,.5,.5,.5)
	elseif subevent=="SPELL_IMMUNE"and(COMBAT_TEXT_SHOW_DODGE_PARRY_MISS=="1")then
		xCT1:AddMessage(IMMUNE,.5,.5,.5)
	elseif subevent=="SPELL_DEFLECT"and(COMBAT_TEXT_SHOW_DODGE_PARRY_MISS=="1")then
		xCT1:AddMessage(DEFLECT,.5,.5,.5)
	elseif subevent=="SPELL_REFLECT"and(COMBAT_TEXT_SHOW_DODGE_PARRY_MISS=="1")then
		xCT1:AddMessage(REFLECT,.5,.5,.5)

	elseif subevent=="RESIST"and(COMBAT_TEXT_SHOW_RESISTANCES=="1")then
		if(arg3)then
			xCT1:AddMessage(part:format(arg2,RESIST,arg3),.75,.5,.5)
		else
			xCT1:AddMessage(RESIST,.5,.5,.5)
		end
	elseif subevent=="BLOCK"and(COMBAT_TEXT_SHOW_RESISTANCES=="1")then
		if(arg3)then
			xCT1:AddMessage(part:format(arg2,BLOCK,arg3),.75,.5,.5)
		else
			xCT1:AddMessage(BLOCK,.5,.5,.5)
		end
	elseif subevent=="ABSORB"and(COMBAT_TEXT_SHOW_RESISTANCES=="1")then
		if(arg3)then
			xCT1:AddMessage(part:format(arg2,ABSORB,arg3),.75,.5,.5)
		else
			xCT1:AddMessage(ABSORB,.5,.5,.5)
		end
	elseif subevent=="SPELL_RESIST"and(COMBAT_TEXT_SHOW_RESISTANCES=="1")then
		if(arg3)then
			xCT1:AddMessage(part:format(arg2,RESIST,arg3),.75,.5,.5)
		else
			xCT1:AddMessage(RESIST,.5,.5,.5)
		end
	elseif subevent=="SPELL_BLOCK"and(COMBAT_TEXT_SHOW_RESISTANCES=="1")then
		if (arg3)then
			xCT1:AddMessage(part:format(arg2,BLOCK,arg3),.75,.5,.5)
		else
			xCT1:AddMessage(BLOCK,.5,.5,.5)
		end
	elseif subevent=="SPELL_ABSORB"and(COMBAT_TEXT_SHOW_RESISTANCES=="1")then
		if(arg3)then
			xCT1:AddMessage(part:format(arg2,ABSORB,arg3),.75,.5,.5)
		else
			xCT1:AddMessage(ABSORB,.5,.5,.5)
		end

	elseif subevent=="ENERGIZE"and(COMBAT_TEXT_SHOW_ENERGIZE=="1")then
		xCT3:AddMessage("+"..arg2,.1,.1,1)
	--	AddMSG(3,.1,.1,1,"+",msg)

	elseif subevent=="PERIODIC_ENERGIZE"and(COMBAT_TEXT_SHOW_PERIODIC_ENERGIZE=="1")then
		xCT3:AddMessage("+"..arg2,.1,.1,.75)

	elseif subevent=="SPELL_AURA_START"and(COMBAT_TEXT_SHOW_AURAS=="1")then
		xCT3:AddMessage("+"..arg2,1,.5,.5)
	elseif subevent=="SPELL_AURA_END"and(COMBAT_TEXT_SHOW_AURAS=="1")then
		xCT3:AddMessage("-"..arg2,.5,.5,.5)
	elseif subevent=="SPELL_AURA_START_HARMFUL"and(COMBAT_TEXT_SHOW_AURAS=="1")then
		xCT3:AddMessage("+"..arg2,1,.1,.1)
	elseif subevent=="SPELL_AURA_END_HARMFUL"and(COMBAT_TEXT_SHOW_AURAS=="1")then
		xCT3:AddMessage("-"..arg2,.1,1,.1)

	elseif subevent=="HONOR_GAINED"and(COMBAT_TEXT_SHOW_HONOR_GAINED=="1")then
		xCT3:AddMessage(HONOR.." +"..arg2,.1,.1,1)

	elseif subevent=="FACTION"and(COMBAT_TEXT_SHOW_REPUTATION=="1")then
		xCT3:AddMessage(arg2.." +"..arg3,.1,.1,1)

	elseif subevent=="SPELL_ACTIVE"and(COMBAT_TEXT_SHOW_REACTIVES=="1")then
		xCT3:AddMessage(arg2,1,.82,0)
	end
end

elseif event=="UNIT_HEALTH"and(COMBAT_TEXT_SHOW_LOW_HEALTH_MANA=="1")then
	if arg1==ct.unit then
		if(UnitHealth(ct.unit)/UnitHealthMax(ct.unit)<=COMBAT_TEXT_LOW_HEALTH_THRESHOLD)then
			if (not lowHealth) then
				xCT3:AddMessage(HEALTH_LOW,1,.1,.1)
				lowHealth=true
			end
		else
			lowHealth=nil
		end
	end

elseif event=="UNIT_MANA"and(COMBAT_TEXT_SHOW_LOW_HEALTH_MANA=="1")then
	if arg1==ct.unit then
		local _,powerToken=UnitPowerType(ct.unit)
		if (powerToken=="MANA"and(UnitPower(ct.unit)/UnitPowerMax(ct.unit))<=COMBAT_TEXT_LOW_MANA_THRESHOLD)then
			if (not lowMana)then
				xCT3:AddMessage(MANA_LOW,1,.1,.1)
				lowMana=true
			end
		else
			lowMana=nil
		end
	end

elseif event=="PLAYER_REGEN_ENABLED"and(COMBAT_TEXT_SHOW_COMBAT_STATE=="1")then
		xCT3:AddMessage("-"..LEAVING_COMBAT,.1,1,.1)

elseif event=="PLAYER_REGEN_DISABLED"and(COMBAT_TEXT_SHOW_COMBAT_STATE=="1")then
		xCT3:AddMessage("+"..ENTERING_COMBAT,1,.1,.1)

elseif event=="UNIT_COMBO_POINTS"and(COMBAT_TEXT_SHOW_COMBO_POINTS=="1")then
	if(arg1==ct.unit)then
		local cp=GetComboPoints(ct.unit,"target")
			if(cp>0)then
				r,g,b=1,.82,.0
				if (cp==MAX_COMBO_POINTS)then
					r,g,b=0,.82,1
				end
				xCT3:AddMessage(format(COMBAT_TEXT_COMBO_POINTS,cp),r,g,b)
			end
	end

elseif event=="RUNE_POWER_UPDATE"then
	if(arg2==true)then
		local rune=GetRuneType(arg1);
		local msg=COMBAT_TEXT_RUNE[rune];
		if(rune==1)then 
			r=.75
			g=0
			b=0
		elseif(rune==2)then
			r=.75
			g=1
			b=0
		elseif(rune==3)then
			r=0
			g=1
			b=1	
		end
		if(rune and rune<4)then
			xCT3:AddMessage("+"..msg,r,g,b)
		end
	end

elseif event=="UNIT_ENTERED_VEHICLE"or event=="UNIT_EXITING_VEHICLE"then
	if(arg1=="player")then
	SetUnit()
	end

elseif event=="PLAYER_ENTERING_WORLD"then
	SetUnit()
	ScrollDirection()
end
end
-- change damage font (if desired)
if(damagestyle)then
	DAMAGE_TEXT_FONT=damagefont
end

-- the three frames
frames={}
for i=1,3 do
	local f=CreateFrame("ScrollingMessageFrame","xCT"..i,UIParent)
	f:SetFont(ctfont,ctfontsize,ctfontstyle)
	f:SetShadowColor(0,0,0,0)
	f:SetFadeDuration(0.2)
	f:SetTimeVisible(3)
	f:SetMaxLines(128)
	f:SetSpacing(1)
	f:SetWidth(128)
	f:SetHeight(128)
	f:SetJustifyH"LEFT"
	f:SetPoint("CENTER",0,0)
	f:SetMovable(true)
	f:SetResizable(true)
	f:SetMinResize(128,128)
	f:SetMaxResize(768,768)
	if(i==1)then
		f:SetJustifyH"LEFT"
		f:SetPoint("CENTER",-192,-32)
	elseif(i==2)then
		f:SetJustifyH"RIGHT"
		f:SetPoint("CENTER",192,-32)
	else
		f:SetJustifyH"CENTER"
		f:SetHeight(128)
		f:SetWidth(256)
		f:SetPoint("CENTER",0,192)
	end
	-- awesome config mode =D
	if(configmode)then
	f:SetBackdrop({
		bgFile="Interface/Tooltips/UI-Tooltip-Background",
		edgeFile="Interface/Tooltips/UI-Tooltip-Border",
		tile=false,tileSize=0,edgeSize=2,
		insets={left=0,right=0,top=0,bottom=0}})
	f:SetBackdropColor(.1,.1,.1,.8)
	f:SetBackdropBorderColor(.1,.1,.1,.5)

	f.fs=f:CreateFontString(nil,"OVERLAY")
	f.fs:SetFont(ctfont,ctfontsize,ctfontstyle)
	f.fs:SetPoint("BOTTOM",f,"TOP",0,0)
	if(i==1)then
		f.fs:SetText(DAMAGE.." (drag me)")
		f.fs:SetTextColor(1,.1,.1,.9)
	elseif(i==2)then
		f.fs:SetText(SHOW_COMBAT_HEALING.."(drag me)")
		f.fs:SetTextColor(.1,1,.1,.9)
	else
		f.fs:SetText(COMBATTEXT_LABEL.."(drag me)")
		f.fs:SetTextColor(.1,.1,1,.9)
	end

	f.t=f:CreateTexture"ARTWORK"
	f.t:SetPoint("TOPLEFT",f,"TOPLEFT",1,-1)
	f.t:SetPoint("TOPRIGHT",f,"TOPRIGHT",-1,-19)
	f.t:SetHeight(20)
	f.t:SetTexture(.5,.5,.5)
	f.t:SetAlpha(.3)

	f.d=f:CreateTexture"ARTWORK"
	f.d:SetHeight(16)
	f.d:SetWidth(16)
	f.d:SetPoint("BOTTOMRIGHT",f,"BOTTOMRIGHT",-1,1)
	f.d:SetTexture(.5,.5,.5)
	f.d:SetAlpha(.3)

	f.tr=f:CreateTitleRegion()
	f.tr:SetPoint("TOPLEFT",f,"TOPLEFT",0,0)
	f.tr:SetPoint("TOPRIGHT",f,"TOPRIGHT",0,0)
	f.tr:SetHeight(20)

	f:EnableMouse(true)
	f:RegisterForDrag"LeftButton"
	f:SetScript("OnDragStart",f.StartSizing)
	f:SetScript("OnDragStop",f.StopMovingOrSizing)
	end
	frames[i] = f
end

-- register events
local xCT=CreateFrame"Frame"
xCT:RegisterEvent"COMBAT_TEXT_UPDATE"
xCT:RegisterEvent"UNIT_HEALTH"
xCT:RegisterEvent"UNIT_MANA"
xCT:RegisterEvent"PLAYER_REGEN_DISABLED"
xCT:RegisterEvent"PLAYER_REGEN_ENABLED"
xCT:RegisterEvent"UNIT_COMBO_POINTS"
xCT:RegisterEvent"RUNE_POWER_UPDATE"
xCT:RegisterEvent"UNIT_ENTERED_VEHICLE"
xCT:RegisterEvent"UNIT_EXITING_VEHICLE"
xCT:RegisterEvent"PLAYER_ENTERING_WORLD"
xCT:SetScript("OnEvent",OnEvent)

-- turn off blizz ct
CombatText:UnregisterAllEvents()
CombatText:SetScript("OnLoad",nil)
CombatText:SetScript("OnEvent",nil)
CombatText:SetScript("OnUpdate",nil)

-- steal external messages sent by other addons using CombatText_AddMessage
Blizzard_CombatText_AddMessage=CombatText_AddMessage
function CombatText_AddMessage(message,scrollFunction,r,g,b,displayType,isStaggered)
xCT3:AddMessage(message,r,g,b)
end

-- hide some blizz options
InterfaceOptionsCombatTextPanelFriendlyHealerNames:Hide()
DropDownList1Button3:SetScale(0.05)
DropDownList1Button3:SetAlpha(0)
--hook blizz float mode selector. blizz sucks, because changing  cVar combatTextFloatMode doesn't fire CVAR_UPDATE
hooksecurefunc("InterfaceOptionsCombatTextPanelFCTDropDown_OnClick",ScrollDirection)
