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
--      buttons.lua - Define the general unit-buttons.
--
--      (c) Copyright 2001-2004 by Vladi Belperchinov-Shabanski, Lutz Sammer,
--                                 and Jimmy Salmon
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

-- Load the buttons of all races

Load("scripts/human/buttons.lua")
Load("scripts/orc/buttons.lua")

-- general buttons -----------------------------------------------------------

DefineButton( { Pos = 3, Level = 0, Icon = "icon-road",
  Action = "build", Value = "unit-road",
  Allowed = "check-no-research",
  Key = "r", Hint = "BUILD ~!ROAD",
  ForUnit = {"unit-orc-town-hall", "unit-human-town-hall"} } )

DefineButton( { Pos = 5, Level = 1, Icon = "icon-wall",
  Action = "build", Value = "unit-wall",
  Allowed = "check-network",
  Key = "w", Hint = "BUILD ~!WALL",
  ForUnit = {"unit-peasant", "unit-peon"} } )


------------------------------------------------------------------------------
--  Define unit-button.
--
--  DefineButton( { Pos = n, Level = n, Icon = ident,
--    Action = name, [Value = value,]
--    [Allowed = check, [values,]]
--    Key = key, Hint = hint, ForUnit = units)
--

-- general cancel button ------------------------------------------------------

DefineButton( { Pos = 5, Level = 9, Icon = "icon-cancel",
  Action = "cancel",
  Key = "\27", Hint = "~<ESC~> CANCEL",
  ForUnit = {"*"} } )

DefineButton( { Pos = 5, Level = 0, Icon = "icon-cancel",
  Action = "cancel-upgrade",
  Key = "\27", Hint = "~<ESC~> CANCEL UPGRADE",
  ForUnit = {"cancel-upgrade"} } )

DefineButton( { Pos = 5, Level = 0, Icon = "icon-cancel",
  Action = "cancel-train-unit",
  Key = "\27", Hint = "~<ESC~> CANCEL UNIT TRAINING",
  ForUnit = {"*"} } )

DefineButton( { Pos = 5, Level = 0, Icon = "icon-cancel",
  Action = "cancel-build",
  Key = "\27", Hint = "~<ESC~> CANCEL CONSTRUCTION",
  ForUnit = {"cancel-build"} } )
