-- ****************************************************************************
-- **
-- **  File     :  /cdimage/units/UAA0102/UAA0102_script.lua
-- **  Author(s):  John Comes, David Tomandl, Jessica St. Croix
-- **
-- **  Summary  :  Aeon Interceptor Script
-- **
-- **  Copyright � 2005 Gas Powered Games, Inc.  All rights reserved.
-- ****************************************************************************
local AAirUnit = import('/lua/aeonunits.lua').AAirUnit
local aWeapons = import('/lua/aeonweapons.lua')
local AAASonicPulseBatteryWeapon = aWeapons.AAASonicPulseBatteryWeapon

BROAT1FIG = Class(AAirUnit){
    Weapons = {
        SonicPulseBattery1 = Class(AAASonicPulseBatteryWeapon){
            FxMuzzleFlash = { '/effects/emitters/sonic_pulse_muzzle_flash_02_emit.bp' },
        },
        SonicPulseBattery2 = Class(AAASonicPulseBatteryWeapon){
            FxMuzzleFlash = { '/effects/emitters/sonic_pulse_muzzle_flash_02_emit.bp' },
        },
        SonicPulseBattery3 = Class(AAASonicPulseBatteryWeapon){
            FxMuzzleFlash = { '/effects/emitters/sonic_pulse_muzzle_flash_02_emit.bp' },
        },
        SonicPulseBattery4 = Class(AAASonicPulseBatteryWeapon){
            FxMuzzleFlash = { '/effects/emitters/sonic_pulse_muzzle_flash_02_emit.bp' },
        },
        aircraft = Class(AAASonicPulseBatteryWeapon){ FxMuzzleFlashScale = 0 },
    },
}

TypeClass = BROAT1FIG
