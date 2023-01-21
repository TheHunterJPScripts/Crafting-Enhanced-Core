CraftingEnhancedCore = {}

CraftingEnhancedCore.NAME = 'Crafting Enhanced Core'
CraftingEnhancedCore.AUTHOR = 'TheHunterJP'
CraftingEnhancedCore.VERSION = '0.1'

print('Mod Loaded: ' .. MoreBuild.NAME .. ' by ' .. MoreBuild.AUTHOR .. ' (v' .. MoreBuild.VERSION .. ')')

CraftingEnhancedCore.tables = {}


MoreBuild.textTooltipHeader = ' <RGB:2,2,2> <LINE> <LINE>' .. getText('Tooltip_craft_Needs') .. ' : <LINE> '
MoreBuild.textCanRotate = '<LINE> <RGB:1,1,1>' ..
    getText('Tooltip_craft_pressToRotate', Keyboard.getKeyName(getCore():getKey('Rotate building')))
MoreBuild.textPlasterRed = '<RGB:1,0,0> <LINE> <LINE>' .. getText('Tooltip_PlasterRed_Description')
MoreBuild.textPlasterGreen = '<RGB:1,1,1> <LINE> <LINE>' .. getText('Tooltip_PlasterGreen_Description')
MoreBuild.textPlasterNever = '<RGB:1,0,0> <LINE> <LINE>' .. getText('Tooltip_PlasterNever_Description')



CraftingEnhancedCore.OnFillWorldObjectContextMenu = function(player, context, worldobjects, test)
  if getCore():getGameMode() == 'LastStand' then
    return
  end

  if test and ISWorldObjectContextMenu.Test then
    return true
  end

  local playerObj = getSpecificPlayer(player)
  if playerObj:getVehicle() then
    return
  end

  if CraftingEnhancedCore.checkPermission(playerObj) then return end

  local inv = playerObj:getInventory()

  -- TODO Get carptentry menu

  for _, value in ipairs(CraftingEnhancedCore.tables) do
    if not CraftingEnhancedCore.hasRequiredTool(inv, value.requireTool) then goto continue end

    CraftingEnhancedCore.TableMenuBuilder(subMenu, player, context, value)

    ::continue::
  end
end

CraftingEnhancedCore.getAvailableTools = function(inv, tool)
  return inv:getFirstTypeEval(tool, predicateNotBroken)
end

CraftingEnhancedCore.canBuildObject = function(_tooltip, player, table)

  local inv = getSpecificPlayer(player):getInventory()

  for _, material in pairs(table.recipe) do
    local invItemCount = inv:getItemCountFromTypeRecurse(material.type)

    if invItemCount >= material.amount or ISBuildMenu.cheat then
      _tooltip.description = _tooltip.description ..
          ' <RGB:1,1,1>' ..
          getItemNameFromFullType(material.type) .. ' ' .. material.amount .. '/' .. material.amount .. ' <LINE>'
    else
      _tooltip.description = _tooltip.description ..
          ' <RGB:1,0,0>' ..
          getItemNameFromFullType(material.type) .. ' ' .. invItemCount .. '/' .. material.amount .. ' <LINE>'
    end
  end
end
CraftingEnhancedCore.TableMenuBuilder = function(subMenu, player, context, table)

  local _option

  if table.size == 2 then
    _option = subMenu:addOption(table.displayName, nil, CraftingEnhancedCore.onBuildDoubleTiled, table, player)
  end

  if table.size == 1 then
    _option = subMenu:addOption(table.displayName, nil, CraftingEnhancedCore.onBuildSingleTiled, table, player)
  end

  CraftingEnhancedCore.AddTooltip(_option, player, table)
end

CraftingEnhancedCore.AddTooltip = function(context, player, table)
  local _tooltip = ISToolTip:new()
  _tooltip:initialise()
  _tooltip:setVisible(false)
  context.toolTip = _tooltip

  _tooltip.setName(table.tooltipTitle)
  _tooltip.description = table.tooltipDescription .. _tooltip.description
  _tooltip.setTexture(table.tooltipTexture)

  CraftingEnhancedCore.canBuildObject(_tooltip, player, table)
end

CraftingEnhancedCore.onBuildDoubleTiled = function(ignoreThisArgument, table, player)
  local _table = ISDoubleTileFurniture:new(table.nameID, table.sprites)

  _table.player = player
  _table.name = table.nameID

  for _, material in ipairs(_table.recipe) do
    _table.modData['need:' + material.type] = material.amount
  end

  getCell():setDrag(_table, player)
end

function getModInstance()
  return CraftingEnhancedCore
end

Events.OnFillWorldObjectContextMenu.Add(CraftingEnhancedCore.OnFillWorldObjectContextMenu)
