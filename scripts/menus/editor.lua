local function HackEditorUI()
  LoadUI("orc", Video.Width, Video.Height)
  DefinePlayerColors(wc1.HumanMultiColors)
   -- hack the coordinates for editor tools
   local btny = UI.InfoPanel.Y + 4 + 10 + 38 + 20 + 18 + 4 + 24
   UI.ButtonPanel.Y = UI.ButtonPanel.Y + 24
   UI.ButtonPanel.Buttons:clear()
   AddButtonPanelButton(0, btny + 47 * 0)
   AddButtonPanelButton(60, btny + 47 * 0)
   AddButtonPanelButton(120, btny + 47 * 0)
   if (Video.Height >= 600) then
      -- let's add another row of units
      UI.ButtonPanel.Y = UI.ButtonPanel.Y + 47
      AddButtonPanelButton(0, btny + 47 * 1)
      AddButtonPanelButton(60, btny + 47 * 1)
      AddButtonPanelButton(120, btny + 47 * 1)
   end
   if (Video.Height >= 768) then
      -- let's add another row of units
      UI.ButtonPanel.Y = UI.ButtonPanel.Y + 47
      AddButtonPanelButton(0, btny + 47 * 2)
      AddButtonPanelButton(60, btny + 47 * 2)
      AddButtonPanelButton(120, btny + 47 * 2)
   end
   -- end of hack
end

--  Menu for new map to edit
local function RunEditorNewMapMenu()
  local menu = WarMenu()
  local offx = (Video.Width - 640) / 2
  local offy = (Video.Height - 480) / 2
  local tilesets = { "forest", "swamp", "dungeon" }
  local mapSizes = {"32", "64", "96", "128", "256"}

  menu:addLabel("Map description :", offx + 208, offy + 104 + 32 * 0, Fonts["game"], false)
  local mapDescription = menu:addTextInputField("", offx + 208, offy + 104 + 32 * 1, 200)
  menu:addLabel("TileSet : ", offx + 208, offy + 104 + 32 * 2, Fonts["game"], false)
  local dropDownTileset = menu:addDropDown(tilesets, offx + 208 + 60, offy + 104 + 32 * 2, function() end)

  menu:addLabel("Size :", offx + 208, offy + 104 + 32 * 3, Fonts["game"], false)
  local mapSizex = menu:addDropDown(mapSizes, offx + 208 + 50, offy + 104 + 32 * 3, function() end)
  mapSizex:setWidth(50)
  menu:addLabel("x", offx + 208 + 110, offy + 104 + 32 * 3, Fonts["game"], false)
  local mapSizey = menu:addDropDown(mapSizes, offx + 208 + 125, offy + 104 + 32 * 3, function() end)
  mapSizey:setWidth(50)

  menu:addFullButton("~!New map", "n", offx + 193, offy + 104 + 36 * 5,
    function()
      -- TODO : check value
      Map.Info.Description = mapDescription:getText()
      Map.Info.MapWidth = mapSizes[1 + mapSizex:getSelected()]
      Map.Info.MapHeight = mapSizes[1 + mapSizey:getSelected()]
      LoadTileModels("scripts/tilesets/" .. tilesets[1 + dropDownTileset:getSelected()] .. ".lua")
--	  Load("scripts/tilesets/" .. tilesets[1 + dropDownTileset:getSelected()] .. ".lua")
      menu:stop()
      HackEditorUI()
      StartEditor(nil)
    end)
  menu:addFullButton("~!Cancel", "c", offx + 193, offy + 104 + 36 * 6, function() menu:stop(1) end)
  return menu:run()
end

-- Menu for loading map to edit
local function RunEditorLoadMapMenu()
  local menu = WarMenu()
  local offx = (Video.Width - 640) / 2
  local offy = (Video.Height - 480) / 2
  local labelMapName
  local labelDescription
  local labelNbPlayer
  local labelMapSize

  -- update label content
  local function MapChanged()
    labelMapName:setCaption("File      : " .. string.sub(mapname, 6))
    labelMapName:adjustSize()

    labelNbPlayer:setCaption("Players  : " .. mapinfo.nplayers)
    labelNbPlayer:adjustSize()

    labelDescription:setCaption("Scenario : " .. mapinfo.description)
    labelDescription:adjustSize()

    labelMapSize:setCaption("Size      : " .. mapinfo.w .. " x " .. mapinfo.h)
    labelMapSize:adjustSize()
  end

  labelMapName = menu:addLabel("", offx + 208, offy + 104 + 36 * 0, Fonts["game"], false)
  labelDescription = menu:addLabel("", offx + 208, offy + 104 + 32 * 1, Fonts["game"], false)
  labelNbPlayer = menu:addLabel("", offx + 208, offy + 104 + 32 * 2, Fonts["game"], false)
  labelMapSize = menu:addLabel("", offx + 208, offy + 104 + 32 * 3, Fonts["game"], false)

  menu:addFullButton("~!Select map", "s", offx + 193, offy + 104 + 36 * 4,
    function()
      local oldmapname = mapname
      RunSelectScenarioMenu()
      if (mapname ~= oldmapname) then
        GetMapInfo(mapname)
        MapChanged()
      end
    end)

  menu:addFullButton("~!Edit map", "e", offx + 193, offy + 104 + 36 * 5, function() menu:stop(); HackEditorUI(); StartEditor(mapname);  end)
  menu:addFullButton("~!Cancel", "c", offx + 193, offy + 104 + 36 * 6, function() menu:stop(1) end)

  GetMapInfo(mapname)
  MapChanged()
  return menu:run()
end

-- root of the editor menu
function RunEditorMenu()
  local menu = WarMenu()
  local offx = (Video.Width - 640) / 2
  local offy = (Video.Height - 480) / 2

  local buttonNewMap =
  menu:addFullButton("~!New map", "n", offx + 193, offy + 104 + 36*3, function() RunEditorNewMapMenu(); menu:stop() end)
  menu:addFullButton("~!Load map", "l", offx + 193, offy + 104 + 36*4, function() RunEditorLoadMapMenu(); menu:stop() end)
  menu:addFullButton("~!Cancel", "c", offx + 193, offy + 104 + 36*5, function() menu:stop() end)
  return menu:run()
end

--
--  Save map from the editor
--
function RunEditorSaveMenu()
  local menu = WarGameMenu(panel(3))

  menu:resize(384, 256)

  menu:addLabel("Save Game", 384 / 2, 11)

  local t = menu:addTextInputField("game.smp",
    (384 - 300 - 18) / 2, 11 + 36, 318)

  local browser = menu:addBrowser("maps", ".smp.gz$",
    (384 - 300 - 18) / 2, 11 + 36 + 22, 318, 126)
  local function cb(s)
    t:setText(browser:getSelectedItem())
  end
  browser:setActionCallback(cb)

  menu:addHalfButton("~!Save", "s", 1 * (384 / 3) - 121 - 10, 256 - 16 - 27,
    -- FIXME: use a confirm menu if the file exists already
    function()
      local name = t:getText()
      -- check for an empty string
      if (string.len(name) == 0) then
        return
      end
      -- strip .gz
	  local gz_stripped = false
      if (string.find(name, ".gz$") ~= nil) then
        name = string.sub(name, 1, string.len(name) - 3)
		gz_stripped = true
      end
      -- append .smp
      if (string.find(name, ".smp$") == nil) then
        name = name .. ".smp"
      end
	  if (gz_stripped) then
		name = name .. ".gz"
	  end
      -- replace invalid chars with underscore
      local t = {"\\", "/", ":", "*", "?", "\"", "<", ">", "|"}
      table.foreachi(t, function(k,v) name = string.gsub(name, v, "_") end)

      --SaveGame(name)
      EditorSaveMap(browser.path .. name)
      UI.StatusLine:Set("Saved game to: " .. browser.path .. name)
      menu:stop()
    end)

  menu:addHalfButton("~!Cancel", "c", 3 * (384 / 3) - 121 - 10, 256 - 16 - 27,
    function() menu:stop() end)

  menu:run(false)
end

--
--  Load a other map to edit.
--
function RunEditorLoadMenu()
-- TODO : fill this function correctly
--[[
--  RunSelectScenarioMenu()
--  if (buttonStatut == 1) then
--    EditorLoadMap(mapname)
--    StartEditor(mapname)
--  end
--]]
end

--
--  Change player properties from the editor
--
function RunEditorPlayerProperties()
-- TODO : manage edition.
-- TODO : find a correct backgroung menu

  print("RunEditorPlayerProperties")

  local menu = WarGameMenu(nil)
  local sizeX = 500
  local sizeY = 480

  menu:resize(sizeX, sizeY)
  menu:addLabel("Players properties", sizeX / 2, 11)

  local offxPlayer = 15
  local offxType = 70
  local offxRace = 170
  local offxAI = 285
  local offxGold = 375
  local offxLumber = 425

  local types = {"neutral", "nobody", "computer", "person", "rescue-passive", "rescue-active"}
  local racenames = {"human", "orc"}
  local ais = {"wc1-land-attack", "wc1-passive"} -- todo add ai

  menu:addLabel("#", 15, 36)
  menu:addLabel("Type", offxType, 36)
  menu:addLabel("Race", offxRace, 36)
  menu:addLabel("AI", offxAI, 36)
  menu:addLabel("Gold", offxGold, 36)
  menu:addLabel("Lumber", offxLumber, 36)

  local playersProp = {nil, nil, nil, nil, nil,
                       nil, nil, nil, nil, nil,
                       nil, nil, nil, nil, nil}
  for i = 0, 14 do
    local playerLine = {
      type = nil,
      race = nil,
      ai = nil,
      gold = nil,
      lumber = nil,
    }
    local offy_i = 36 + 25 * (i + 1)
    local index = i -- use for local function

    local function updateProp(ind)
      local b = (playersProp[1 + ind].type:getSelected() ~= 1) -- != nobody
      playersProp[1 + ind].race:setVisible(b)
      playersProp[1 + ind].ai:setVisible(b)
      playersProp[1 + ind].gold:setVisible(b)
      playersProp[1 + ind].lumber:setVisible(b)
    end

    playersProp[1 + i] = playerLine

    menu:addLabel("p" .. (i + 1), offxPlayer, offy_i)

    playersProp[1 + i].type = menu:addDropDown(types, offxType - 40, offy_i, function() updateProp(index) end)
    playersProp[1 + i].type:setSelected(Map.Info.PlayerType[i] - 2)
    playersProp[1 + i].type:setWidth(115)

    playersProp[1 + i].race = menu:addDropDown(racenames, offxRace - 20, offy_i, function() end)
    playersProp[1 + i].race:setSelected(Players[i].Race)
    playersProp[1 + i].race:setWidth(65)

    playersProp[1 + i].ai = menu:addDropDown(ais, offxAI - 65, offy_i, function() end)
    for j = 0,3 do
      if (ais[1 + j] == Players[i].AiName) then playersProp[1 + i].ai:setSelected(j) end
    end
    playersProp[1 + i].ai:setWidth(130)

    playersProp[1 + i].gold = menu:addTextInputField(Players[i].Resources[1], offxGold - 20, offy_i, 40)
    playersProp[1 + i].lumber = menu:addTextInputField(Players[i].Resources[2], offxLumber - 20, offy_i, 40)
    updateProp(i)
  end

  menu:addHalfButton("~!Ok", "o", 1 * (sizeX / 4) - 121 - 10, sizeY - 16 - 27,
    function()
      for i = 0, 14 do
        Map.Info.PlayerType[i] = playersProp[1 + i].type:getSelected() + 2
		Players[i].Type = playersProp[1 + i].type:getSelected() + 2
        Players[i].Race = playersProp[1 + i].race:getSelected()
        Players[i].AiName = ais[1 + playersProp[1 + i].ai:getSelected()]
        Players[i].Resources[1] = playersProp[1 + i].gold:getText()
        Players[i].Resources[2] = playersProp[1 + i].lumber:getText()
      end
      menu:stop()
    end)

  menu:addHalfButton("~!Cancel", "c", 3 * (sizeX / 4) - 121 - 10, sizeY - 16 - 27, function() menu:stop() end)

  menu:run(false)
end

--
--  Change player properties from the editor
--
function RunEditorMapProperties()
print("RunEditorMapProperties")
-- TODO : manage edition of all properties.
  local menu = WarGameMenu(--[[panel(3)]])

  local sizeX = 384
  local sizeY = 256

  menu:resize(sizeX, sizeY)
  menu:addLabel("Map properties", sizeX / 2, 11)

  menu:addLabel("Map descritption : ", 45, 11 + 36, nil, false)
  local desc = menu:addTextInputField(Map.Info.Description, 15, 36 * 2, 350)

  menu:addLabel("Size    : " .. Map.Info.MapWidth .. " x " .. Map.Info.MapHeight, 45, 36 * 3, nil, false)
--  menu:addLabel("Size : ", 15, 36 * 3, nil, false)
--  local sizeX = menu:addTextInputField(Map.Info.MapWidth, 75, 36 * 3, 50)
--  menu:addLabel(" x ", 130, 36 * 3, nil, false)
--  local sizeY = menu:addTextInputField(Map.Info.MapHeight, 160, 36 * 3, 50)

  menu:addLabel("Tileset : ", 45, 36 * 4, nil, false)

  local list = { "Forest", "Swamp", "Dungeon"}
  local dropDownTileset = menu:addDropDown(list, 130, 36 * 4, function() end)
  for i = 0,3 do
    if (list[1 + i] == Map.Tileset.Name) then dropDownTileset:setSelected(i)
    end
  end
  dropDownTileset:setEnabled(false) -- TODO : manage this properties

  menu:addHalfButton("~!Ok", "o", 1 * (sizeX / 3) - 121 - 10, sizeY - 16 - 27,
    function()
      Map.Info.Description = desc:getText()
      -- TODO : Add others properties
      menu:stop()
    end
    )

  menu:addHalfButton("~!Cancel", "c", 3 * (sizeX / 3) - 121 - 10, sizeY - 16 - 27,
    function() menu:stop() end)

  menu:run(false)
end

--
--  Main menu in editor.
--
function RunInEditorMenu()
  local menu = WarGameMenu(panel(1))

  menu:addLabel("Editor Menu", 128, 11)

  menu:addHalfButton("Save (~<F11~>)", "f11", 25, 40, RunEditorSaveMenu)
  local buttonEditorLoad = -- To be removed when enabled.
  menu:addHalfButton("Load (~<F12~>)", "f12", 25 + 127, 40, RunEditorLoadMenu)
  menu:addFullButton("Map Properties (~<F5~>)", "f5", 25, 40 + 36 * 1, RunEditorMapProperties)
  menu:addFullButton("Player Properties (~<F6~>)", "f6", 25, 40 + 36 * 2, RunEditorPlayerProperties)

  buttonEditorLoad:setEnabled(false) -- To be removed when enabled.

  menu:addFullButton(
     "E~!xit to Menu", "x", 25, 40 + 36 * 4,
     function()
	Load("scripts/ui.lua")
	Editor.Running = EditorNotRunning;
	menu:stopAll();
     end
  )
  menu:addFullButton("Return to Editor (~<Esc~>)", "escape", 25, 288 - 60, function() menu:stop() end)

  menu:run(false)
end

--
--  Function to edit unit properties in Editor
--
function EditUnitProperties()

  if (GetUnitUnderCursor() == nil) then
    return;
  end
  local menu = WarGameMenu(panel(1))
  local sizeX = 256
  local sizeY = 200 -- 288
  
  menu:resize(sizeX, sizeY)
  menu:addLabel("Unit properties", sizeX / 2, 11)
  
  if (GetUnitUnderCursor().Type.GivesResource == 0) then
    menu:addLabel("Artificial Intelligence", sizeX / 2, 11 + 36)
    local activeCheckBox = menu:addCheckBox("Active", 15, 11 + 72)
    activeCheckBox:setMarked(GetUnitUnderCursor().Active)

    menu:addHalfButton("~!Ok", "o", 15, sizeY - 40,
      function() GetUnitUnderCursor().Active = activeCheckBox:isMarked();  menu:stop() end)
  else
    local resourceName = {"gold", "lumber"}
    local resource = GetUnitUnderCursor().Type.GivesResource - 1
    menu:addLabel("Amount of " .. resourceName[1 + resource] .. " :", 24, 11 + 36, nil, false)
	local resourceValue = menu:addTextInputField(GetUnitUnderCursor().ResourcesHeld, sizeX / 2 - 30, 11 + 36 * 2, 60)

    menu:addHalfButton("~!Ok", "o", 15, sizeY - 40,
      function() GetUnitUnderCursor().ResourcesHeld = resourceValue:getText();  menu:stop() end)
  end
  menu:addHalfButton("~!Cancel", "c", 125, sizeY - 40,
    function() menu:stop() end)
  menu:run(false)
end
