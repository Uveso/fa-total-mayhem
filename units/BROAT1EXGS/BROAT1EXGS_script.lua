-- ****************************************************************************
-- **
-- **  File     :  /cdimage/units/UAA0203/UAA0203_script.lua
-- **  Author(s):  John Comes, David Tomandl, Jessica St. Croix
-- **
-- **  Summary  :  Aeon Gunship Script
-- **
-- **  Copyright � 2005 Gas Powered Games, Inc.  All rights reserved.
-- ****************************************************************************

local AAirUnit = import('/lua/aeonunits.lua').AAirUnit
local WeaponsFile = import('/lua/terranweapons.lua')
local AeonWeapons = import('/lua/aeonweapons.lua')
local TDFGaussCannonWeapon = WeaponsFile.TDFLandGaussCannonWeapon
local EffectTemplate = import('/lua/EffectTemplates.lua')
local AAAZealotMissileWeapon = AeonWeapons.AAAZealotMissileWeapon
local TMEffectTemplate = import('/mods/fa-total-mayhem/lua/TMEffectTemplates.lua')

BROAT1EXGS = Class(AAirUnit){
    Weapons = {
        autoattack = Class(TDFGaussCannonWeapon){ FxMuzzleFlashScale = 0.0 },
        rocket1 = Class(TDFGaussCannonWeapon){ FxMuzzleFlashScale = 0.1 },
        rocket2 = Class(TDFGaussCannonWeapon){ FxMuzzleFlashScale = 0.1 },
        rocket3 = Class(TDFGaussCannonWeapon){ FxMuzzleFlashScale = 0.1 },
        rocket4 = Class(TDFGaussCannonWeapon){ FxMuzzleFlashScale = 0.1 },
        AntiAirMissiles01 = Class(AAAZealotMissileWeapon){},
        MainGun = Class(TDFGaussCannonWeapon){
            FxMuzzleFlash = {
                '/effects/emitters/oblivion_cannon_flash_04_emit.bp',
                '/effects/emitters/oblivion_cannon_flash_05_emit.bp',
                '/effects/emitters/oblivion_cannon_flash_06_emit.bp',
            },
        },
    },
    OnStopBeingBuilt = function(self, builder, layer)
        AAirUnit.OnStopBeingBuilt(self, builder, layer)

        self:CreatTheEffects()

        if self:GetAIBrain().BrainType == 'Human' and IsUnit(self) then
            self:SetWeaponEnabledByLabel('autoattack', false)
        else
            self:SetWeaponEnabledByLabel('autoattack', true)
        end
    end,
    CreatTheEffects = function(self)
        local army = self:GetArmy()
        for k, v in EffectTemplate['AResourceGenAmbient'] do
            self.Trash:Add(CreateAttachedEmitter(self, 'BROAT1EXGS', army, v):ScaleEmitter(0.5))
        end
        for k, v in EffectTemplate['AResourceGenAmbient'] do
            self.Trash:Add(CreateAttachedEmitter(self, 'Dummy04', army, v):ScaleEmitter(0.3))
        end
        for k, v in EffectTemplate['AResourceGenAmbient'] do
            self.Trash:Add(CreateAttachedEmitter(self, 'Dummy05', army, v):ScaleEmitter(0.3))
        end
    end,
    OnKilled = function(self, instigator, damagetype, overkillRatio)
        AAirUnit.OnKilled(self, instigator, damagetype, overkillRatio)
        self:CreatTheEffectsDeath()
    end,
    CreatTheEffectsDeath = function(self)
        local army = self:GetArmy()
        for k, v in TMEffectTemplate['AeonBattleShipHit01'] do
            self.Trash:Add(CreateAttachedEmitter(self, 'BROAT1EXGS', army, v):ScaleEmitter(1.65))
        end
    end,
}

TypeClass = BROAT1EXGS
