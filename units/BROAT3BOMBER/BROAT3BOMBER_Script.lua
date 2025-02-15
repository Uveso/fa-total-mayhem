-- ****************************************************************************
-- **
-- **  File     :  /cdimage/units/UEA0304/UEA0304_script.lua
-- **  Author(s):  John Comes, David Tomandl, Jessica St. Croix
-- **
-- **  Summary  :  UEF Strategic Bomber Script
-- **
-- **  Copyright � 2005 Gas Powered Games, Inc.  All rights reserved.
-- ****************************************************************************

local TAirUnit = import('/lua/terranunits.lua').TAirUnit
local TIFSmallYieldNuclearBombWeapon = import('/lua/terranweapons.lua').TIFSmallYieldNuclearBombWeapon
local TMEffectTemplate = import('/mods/fa-total-mayhem/lua/TMEffectTemplates.lua')
local util = import('/lua/utilities.lua')
local fxutil = import('/lua/effectutilities.lua')

BROAT3BOMBER = Class(TAirUnit){
    Weapons = { Bomb = Class(TIFSmallYieldNuclearBombWeapon){} },
    MovementAmbientExhaustBones = { 'ex01', 'ex02', 'ex03', 'ex04' },
    DestructionPartsChassisToss = { 'BROAT3BOMBER' },
    DestroyNoFallRandomChance = 1.1,
    OnMotionHorzEventChange = function(self, new, old)
        TAirUnit.OnMotionHorzEventChange(self, new, old)

        if self.ThrustExhaustTT1 == nil then
            if self.MovementAmbientExhaustEffectsBag then
                fxutil.CleanupEffectBag(self, 'MovementAmbientExhaustEffectsBag')
            else
                self.MovementAmbientExhaustEffectsBag = {}
            end
            self.ThrustExhaustTT1 = self:ForkThread(self.MovementAmbientExhaustThread)
        end

        if new == 'Stopped' and self.ThrustExhaustTT1 ~= nil then
            KillThread(self.ThrustExhaustTT1)
            fxutil.CleanupEffectBag(self, 'MovementAmbientExhaustEffectsBag')
            self.ThrustExhaustTT1 = nil
        end
    end,
    MovementAmbientExhaustThread = function(self)
        while not self.Dead do
            local ExhaustEffects =
                { '/effects/emitters/dirty_exhaust_smoke_01_emit.bp', '/effects/emitters/dirty_exhaust_sparks_01_emit.bp' }
            local ExhaustBeam = '/effects/emitters/missile_exhaust_fire_beam_03_emit.bp'
            local army = self:GetArmy()

            for kE, vE in ExhaustEffects do
                for kB, vB in self.MovementAmbientExhaustBones do
                    table.insert(self.MovementAmbientExhaustEffectsBag, CreateAttachedEmitter(self, vB, army, vE))
                    table.insert(self.MovementAmbientExhaustEffectsBag, CreateBeamEmitterOnEntity(self, vB, army, ExhaustBeam))
                end
            end

            WaitSeconds(2)
            fxutil.CleanupEffectBag(self, 'MovementAmbientExhaustEffectsBag')

            WaitSeconds(util.GetRandomFloat(1, 7))
        end
    end,
    OnKilled = function(self, instigator, damagetype, overkillRatio)
        TAirUnit.OnKilled(self, instigator, damagetype, overkillRatio)
        self:CreatTheEffectsDeath()
    end,
    CreatTheEffectsDeath = function(self)
        local army = self:GetArmy()
        for k, v in TMEffectTemplate['UEFDeath02'] do
            self.Trash:Add(CreateAttachedEmitter(self, 'BROAT3BOMBER', army, v):ScaleEmitter(1.25))
        end
    end,
}

TypeClass = BROAT3BOMBER
