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
local WeaponsFile = import('/lua/terranweapons.lua')
local aWeapons = import('/lua/aeonweapons.lua')
local AAASonicPulseBatteryWeapon = aWeapons.AAASonicPulseBatteryWeapon
local TDFGaussCannonWeapon = WeaponsFile.TDFLandGaussCannonWeapon

BROAT2FIBO = Class(AAirUnit){
    Weapons = {
        SonicPulseBattery1 = Class(AAASonicPulseBatteryWeapon){
            FxMuzzleFlash = { '/effects/emitters/sonic_pulse_muzzle_flash_02_emit.bp' },
        },
        aircraft = Class(AAASonicPulseBatteryWeapon){ FxMuzzleFlashScale = 0 },
        rocket1 = Class(TDFGaussCannonWeapon){ FxMuzzleFlashScale = 0.1 },
    },
}

TypeClass = BROAT2FIBO
