----------------------------------------------------------------------------
--
--  File     :  /cdimage/units/UEL0201/UEL0201_script.lua
--  Author(s):  John Comes, David Tomandl, Jessica St. Croix
--
--  Summary  :  BRN Tiger Light Tank
--
--  Copyright � 2005 Gas Powered Games, Inc.  All rights reserved.
----------------------------------------------------------------------------

local TLandUnit = import('/lua/terranunits.lua').TLandUnit
local aWeapons = import('/lua/aeonweapons.lua')
local TMEffectTemplate = import('/mods/fa-total-mayhem/lua/TMEffectTemplates.lua')
local AAASonicPulseBatteryWeapon = aWeapons.AAASonicPulseBatteryWeapon
local WeaponsFileAutoAttack = import('/lua/terranweapons.lua')
local AutoAttackWeapon = WeaponsFileAutoAttack.TDFLandGaussCannonWeapon

BROT2MT = Class(TLandUnit){
    Weapons = {
        autoattack = Class(AutoAttackWeapon){ FxMuzzleFlashScale = 0.0 },
        MainGun = Class(AAASonicPulseBatteryWeapon){
            FxMuzzleFlashScale = 0.35,
            FxMuzzleFlash = { '/effects/emitters/sonic_pulse_muzzle_flash_02_emit.bp' },
        },
    },
    OnStopBeingBuilt = function(self, builder, layer)
        TLandUnit.OnStopBeingBuilt(self, builder, layer)
        self.SetAIAutoattackWeapon(self)
    end,
    OnDetachedFromTransport = function(self, transport, bone)
        TLandUnit.OnDetachedFromTransport(self, transport, bone)
        self.SetAIAutoattackWeapon(self)
    end,
    SetAIAutoattackWeapon = function(self)
        if self:GetAIBrain().BrainType == 'Human' and IsUnit(self) then
            self:SetWeaponEnabledByLabel('autoattack', false)
        else
            self:SetWeaponEnabledByLabel('autoattack', true)
        end
    end,
    OnKilled = function(self, instigator, damagetype, overkillRatio)
        TLandUnit.OnKilled(self, instigator, damagetype, overkillRatio)
        self:CreatTheEffectsDeath()
    end,
    CreatTheEffectsDeath = function(self)
        local army = self:GetArmy()
        for k, v in TMEffectTemplate['AeonUnitDeathRing02'] do
            self.Trash:Add(CreateAttachedEmitter(self, 'BROT2MT', army, v):ScaleEmitter(0.40))
        end
    end,
}

TypeClass = BROT2MT
