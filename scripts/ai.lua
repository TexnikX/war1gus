--       _________ __                 __                               
--      /   _____//  |_____________ _/  |______     ____  __ __  ______
--      \_____  \\   __\_  __ \__  \\   __\__  \   / ___\|  |  \/  ___/
--      /        \|  |  |  | \// __ \|  |  / __ \_/ /_/  >  |  /\___ \ 
--     /_______  /|__|  |__|  (____  /__| (____  /\___  /|____//____  >
--             \/                  \/          \//_____/            \/ 
--  ______________________                           ______________________
--                        T H E   W A R   B E G I N S
--         Stratagus - A free fantasy real time strategy game engine
--
--      ai.lua - Define the AI.
--
--      (c) Copyright 2000-2004 by Lutz Sammer and Jimmy Salmon
--
--      This program is free software; you can redistribute it and/or modify
--      it under the terms of the GNU General Public License as published by
--      the Free Software Foundation; either version 2 of the License, or
--      (at your option) any later version.
--  
--      This program is distributed in the hope that it will be useful,
--      but WITHOUT ANY WARRANTY; without even the implied warranty of
--      MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
--      GNU General Public License for more details.
--  
--      You should have received a copy of the GNU General Public License
--      along with this program; if not, write to the Free Software
--      Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
--
--      $Id$


--(define (ai:sleep) () #t)

race1 = "human"
race2 = "orc"

--=============================================================================
--
--  AI helper table, the AI must know where to build units,
--  where to research spells, where to upgrade units.
--  If this is allowed and which dependencies exists, isn't
--  handled here. (see upgrade.lua)
--
--  NOTE: perhaps this could later be used to build the buttons?
--
--  DefineAiHelper(list)
--

--;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
--  * Race human.
--;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


DefineAiHelper(
  --
  -- Unit can build which buildings.
  --
  {"build", "unit-peasant",
  "unit-human-farm", "unit-human-barracks", "unit-human-town-hall", "unit-human-lumber-mill",
  "unit-human-blacksmith"},
  --
  -- Building can train which units.
  --
  {"train", "unit-human-town-hall", "unit-peasant"},
  {"train", "unit-human-barracks",
  "unit-footman", "unit-archer"},
  --
  -- Building can upgrade which upgrades.
  --
  --
  -- Building can research which spells or upgrades.
  --
  --
  -- Unit can repair which units.
  --
  {"repair", "unit-peasant",
  "unit-human-farm", "unit-human-barracks", "unit-human-town-hall",
  "unit-human-lumber-mill", "unit-human-blacksmith"},
  --
  -- Reduce unit limits.
  --
  {"unit-limit", "unit-human-farm", "food"}
  --
  -- Equivalence of units for the resource manager.
  --
)

--;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
--  * Race orc.
--;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

DefineAiHelper(
  --
  -- Unit can build which buildings.
  --
  {"build", "unit-peon",
  "unit-orc-farm", "unit-orc-barracks", "unit-orc-town-hall",
  "unit-orc-lumber-mill", "unit-orc-blacksmith"},
  --
  -- Building can train which units.
  --
  {"train", "unit-orc-town-hall", "unit-peon"},
  {"train", "unit-orc-barracks",
  "unit-grunt", "unit-spearman"},
  --
  -- Building can upgrade which upgrades.
  --
  --
  -- Building can research which spells or upgrades.
  --
  --
  -- Unit can build which units.
  --
  {"repair", "unit-peon",
  "unit-orc-farm", "unit-orc-barracks", "unit-orc-town-hall",
  "unit-orc-lumber-mill", "unit-orc-blacksmith"},
  --
  -- Reduce unit limits.
  --
  {"unit-limit", "unit-orc-farm", "food"}
  --
  -- Equivalence of units for the resource manager.
  --
)

--
--  City-center of the current race.
--
function AiCityCenter()
  if (AiGetRace() == race1) then
    return "unit-human-town-hall"
  else
    return "unit-orc-town-hall"
  end
end

--
--  Worker of the current race.
--
function AiWorker()
  if (AiGetRace() == race1) then
    return "unit-peasant"
  else
    return "unit-peon"
  end
end

--
--  Lumber mill of the current race.
--
function AiLumberMill()
  if (AiGetRace() == race1) then
    return "unit-human-lumber-mill"
  else
    return "unit-orc-lumber-mill"
  end
end

--
--  Blacksmith of the current race.
--
function AiBlacksmith()
  if (AiGetRace() == race1) then
    return "unit-human-blacksmith"
  else
    return "unit-orc-blacksmith"
  end
end

--
--  Upgrade armor 1 of the current race.
--
function AiUpgradeArmor1()
  if (AiGetRace() == race1) then
    return "upgrade-human-shield1"
  else
    return "upgrade-orc-shield1"
  end
end

--
--  Upgrade armor 2 of the current race.
--
function AiUpgradeArmor2()
  if (AiGetRace() == race1) then
    return "upgrade-human-shield2"
  else
    return "upgrade-orc-shield2"
  end
end

--
--  Upgrade weapon 1 of the current race.
--
function AiUpgradeWeapon1()
  if (AiGetRace() == race1) then
    return "upgrade-sword1"
  else
    return "upgrade-battle-axe1"
  end
end

--
--  Upgrade weapon 2 of the current race.
--
function AiUpgradeWeapon2()
  if (AiGetRace() == race1) then
    return "upgrade-sword2"
  else
    return "upgrade-battle-axe2"
  end
end

--
--  Upgrade missile 1 of the current race.
--
function AiUpgradeMissile1()
  if (AiGetRace() == race1) then
    return "upgrade-arrow1"
  else
    return "upgrade-throwing-axe1"
  end
end

--
--  Upgrade missile 2 of the current race.
--
function AiUpgradeMissile2()
  if (AiGetRace() == race1) then
    return "upgrade-arrow2"
  else
    return "upgrade-throwing-axe2"
  end
end

--
--  Upgrade catapult 1 of the current race.
--
function AiUpgradeCatapult1()
  if (AiGetRace() == race1) then
    return "upgrade-ballista1"
  else
    return "upgrade-catapult1"
  end
end

--
--  Upgrade catapult 2 of the current race.
--
function AiUpgradeCatapult2()
  if (AiGetRace() == race1) then
    return "upgrade-ballista2"
  else
    return "upgrade-catapult2"
  end
end

--
--  Research of the current race.
--
function AiScientific()
  if (AiGetRace() == race1) then
    return "unit-inventor"
  else
    return "unit-alchemist"
  end
end

--
--  Stables of the current race.
--
function AiStables()
  if (AiGetRace() == race1) then
    return "unit-stables"
  else
    return "unit-ogre-mound"
  end
end

--
--  Temple of the current race.
--
function AiTemple()
  if (AiGetRace() == race1) then
    return "unit-church"
  else
    return "unit-altar-of-storms"
  end
end

--
--  Mage tower of the current race.
--
function AiMageTower()
  if (AiGetRace() == race1) then
    return "unit-mage-tower"
  else
    return "unit-temple-of-the-damned"
  end
end

--
--  Airport of the current race.
--
function AiAirport()
  if (AiGetRace() == race1) then
    return "unit-gryphon-aviary"
  else
    return "unit-dragon-roost"
  end
end

--
--  Barracks of the current race.
--
function AiBarracks()
  if (AiGetRace() == race1) then
    return "unit-human-barracks"
  else
    return "unit-orc-barracks"
  end
end

--
--  Soldier of the current race.
--
function AiSoldier()
  if (AiGetRace() == race1) then
    return "unit-footman"
  else
    return "unit-grunt"
  end
end

--
--  Shooter of the current race.
--
function AiShooter()
  if (AiGetRace() == race1) then
    return "unit-archer"
  else
    return "unit-axethrower"
  end
end

--
--  Elite Shooter of the current race.
--
function AiEliteShooter()
  if (AiGetRace() == race1) then
    return "unit-ranger"
  else
    return "unit-berserker"
  end
end

--
--  Cavalry of the current race.
--
function AiCavalry()
  if (AiGetRace() == race1) then
    return "unit-knight"
  else
    return "unit-ogre"
  end
end

--
--  Cavalry mages of the current race.
--
function AiCavalryMage()
  if (AiGetRace() == race1) then
    return "unit-paladin"
  else
    return "unit-ogre-mage"
  end
end

--
--  Mage of the current race.
--
function AiMage()
  if (AiGetRace() == race1) then
    return "unit-mage"
  else
    return "unit-death-knight"
  end
end

--
--  Catapult of the current race.
--
function AiCatapult()
  if (AiGetRace() == race1) then
    return "unit-ballista"
  else
    return "unit-catapult"
  end
end

--
--  Scout of the current race.
--
function AiScout()
  if (AiGetRace() == race1) then
    return "unit-balloon"
  else
    return "unit-zeppelin"
  end
end

--
--  Flyer of the current race.
--
function AiFlyer()
  if (AiGetRace() == race1) then
    return "unit-gryphon-rider"
  else
    return "unit-dragon"
  end
end

--
--  Tower of the current race.
--
function AiTower()
  if (AiGetRace() == race1) then
    return "unit-human-watch-tower"
  else
    return "unit-orc-watch-tower"
  end
end

--
--  Guard-Tower of the current race.
--
function AiGuardTower()
  if (AiGetRace() == race1) then
    return "unit-human-guard-tower"
  else
    return "unit-orc-guard-tower"
  end
end

--
--  Cannon-Tower of the current race.
--
function AiCannonTower()
  if (AiGetRace() == race1) then
    return "unit-human-cannon-tower"
  else
    return "unit-orc-cannon-tower"
  end
end

--
--  Harbor of the current race.
--
function AiHarbor()
  if (AiGetRace() == race1) then
    return "unit-human-shipyard"
  else
    return "unit-orc-shipyard"
  end
end

--
--  Refinery of the current race.
--
function AiRefinery()
  if (AiGetRace() == race1) then
    return "unit-human-refinery"
  else
    return "unit-orc-refinery"
  end
end

--
--  Foundry of the current race.
--
function AiFoundry()
  if (AiGetRace() == race1) then
    return "unit-human-foundry"
  else
    return "unit-orc-foundry"
  end
end

--
--  Ship armor 1 of the current race.
--
function AiUpgradeShipArmor1()
  if (AiGetRace() == race1) then
    return "upgrade-human-ship-armor1"
  else
    return "upgrade-orc-ship-armor1"
  end
end

--
--  Ship armor 2 of the current race.
--
function AiUpgradeShipArmor2()
  if (AiGetRace() == race1) then
    return "upgrade-human-ship-armor2"
  else
    return "upgrade-orc-ship-armor2"
  end
end

--
--  Ship weapon 1 of the current race.
--
function AiUpgradeShipCannon1()
  if (AiGetRace() == race1) then
    return "upgrade-human-ship-cannon1"
  else
    return "upgrade-orc-ship-cannon1"
  end
end

--
--  Ship weapon 2 of the current race.
--
function AiUpgradeShipCannon2()
  if (AiGetRace() == race1) then
    return "upgrade-human-ship-cannon2"
  else
    return "upgrade-orc-ship-cannon2"
  end
end

--
--  Platform of the current race.
--
function AiPlatform()
  if (AiGetRace() == race1) then
    return "unit-human-oil-platform"
  else
    return "unit-orc-oil-platform"
  end
end

--
--  Tanker of the current race.
--
function AiTanker()
  if (AiGetRace() == race1) then
    return "unit-human-oil-tanker"
  else
    return "unit-orc-oil-tanker"
  end
end

--
--  Submarine of the current race.
--
function AiSubmarine()
  if (AiGetRace() == race1) then
    return "unit-human-submarine"
  else
    return "unit-orc-submarine"
  end
end

--
--  Destroyer of the current race.
--
function AiDestroyer()
  if (AiGetRace() == race1) then
    return "unit-human-destroyer"
  else
    return "unit-orc-destroyer"
  end
end

--
--  Battleship of the current race.
--
function AiBattleship()
  if (AiGetRace() == race1) then
    return "unit-battleship"
  else
    return "unit-ogre-juggernaught"
  end
end

--
--  Transporter of the current race.
--
function AiTransporter()
  if (AiGetRace() == race1) then
    return "unit-human-transport"
  else
    return "unit-orc-transport"
  end
end

--
--  1st Elite Shooter of the current race.
--
function AiUpgradeEliteShooter()
  if (AiGetRace() == race1) then
    return "upgrade-ranger"
  else
    return "upgrade-berserker"
  end
end

--
--  1st Upgrade of elite Shooter of the current race.
--
function AiUpgradeEliteShooter1()
  if (AiGetRace() == race1) then
    return "upgrade-ranger-scouting"
  else
    return "upgrade-berserker-scouting"
  end
end

--
--  2nd Upgrade of elite Shooter of the current race.
--
function AiUpgradeEliteShooter2()
  if (AiGetRace() == race1) then
    return "upgrade-longbow"
  else
    return "upgrade-light-axes"
  end
end

--
--  3th Upgrade of elite Shooter of the current race.
--
function AiUpgradeEliteShooter3()
  if (AiGetRace() == race1) then
    return "upgrade-ranger-marksmanship"
  else
    return "upgrade-berserker-regeneration"
  end
end

--
--  Upgrade cavalry to cavalry mages of the current race.
--
function AiUpgradeCavalryMage()
  if (AiGetRace() == race1) then
    return "upgrade-paladin"
  else
    return "upgrade-ogre-mage"
  end
end

--
--  1st spell of the cavalry mages of the current race.
--
function AiCavalryMageSpell1()
  if (AiGetRace() == race1) then
    return "upgrade-healing"
  else
    return "upgrade-bloodlust"
  end
end

--
--  2nd spell of the cavalry mages of the current race.
--
function AiCavalryMageSpell2()
  if (AiGetRace() == race1) then
    return "upgrade-exorcism"
  else
    return "upgrade-runes"
  end
end

--
--  1st spell of the mages of the current race.
--
function AiMageSpell1()
  if (AiGetRace() == race1) then
    return "upgrade-slow"
  else
    return "upgrade-haste"
  end
end

--
--  2nd spell of the mages of the current race.
--
function AiMageSpell2()
  if (AiGetRace() == race1) then
    return "upgrade-flame-shield"
  else
    return "upgrade-raise-dead"
  end
end

--
--  3th spell of the mages of the current race.
--
function AiMageSpell3()
  if (AiGetRace() == race1) then
    return "upgrade-invisibility"
  else
    return "upgrade-whirlwind"
  end
end

--
--  5th spell of the mages of the current race.
--
function AiMageSpell5()
  if (AiGetRace() == race1) then
    return "upgrade-blizzard"
  else
    return "upgrade-death-and-decay"
  end
end


--
--  Load the actual individual scripts.
--
Load("scripts/ai/passive.lua")
Load("scripts/ai/air_attack.lua")
Load("scripts/ai/land_attack.lua")
Load("scripts/ai/sea_attack.lua")
Load("scripts/ai/campaign.lua")

