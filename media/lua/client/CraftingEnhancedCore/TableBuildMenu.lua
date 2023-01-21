CraftingEnhancedCore = {}

CraftingEnhancedCore.NAME = 'Crafting Enhanced Core'
CraftingEnhancedCore.AUTHOR = 'TheHunterJP'
CraftingEnhancedCore.VERSION = '0.1'

print('Mod Loaded: ' ..
  CraftingEnhancedCore.NAME .. ' by ' .. CraftingEnhancedCore.AUTHOR .. ' (v' .. CraftingEnhancedCore.VERSION .. ')')

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

  local inv = playerObj:getInventory()

  local carpentryMenu = nil;

  for _, value in ipairs(context.options) do
    if value.name == getText("ContextMenu_Build") then
      local buildOption = value;
      -- Retrieve the sub menu in case it is found.
      carpentryMenu = context:getSubMenu(buildOption.subOption);
    end
  end

  local newCarpentryOption = carpentryMenu:addOption(getText('ContextMenu_Tables'))
  local subMenu = ISContextMenu:getNew(carpentryMenu)
  carpentryMenu:addSubMenu(newCarpentryOption, subMenu)

  if subMenu then
    for _, value in pairs(CraftingEnhancedCore.tables) do
      CraftingEnhancedCore.TableMenuBuilder(subMenu, player, value)
    end
  end
end

CraftingEnhancedCore.getAvailableTools = function(inv, tool)
  return inv:getFirstTypeEval(tool, predicateNotBroken)
end

CraftingEnhancedCore.canBuildObject = function(_tooltip, player, table)

  local inv = getSpecificPlayer(player):getInventory()

  if not CraftingEnhancedCore.getAvailableTools(inv, table.requireTool) then
    _tooltip.description = _tooltip.description .. ' <RGB:1,0,0>' ..
        'Require tool' .. table.requireTool .. ' <LINE>'
  end

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

CraftingEnhancedCore.TableMenuBuilder = function(subMenu, player, table)

  local _option

  if table.size == 2 then
    _option = subMenu:addOption(table.displayName, nil, CraftingEnhancedCore.onBuildDoubleTiled, table, player)
  end

  if table.size == 1 then
    _option = subMenu:addOption(table.displayName, nil, CraftingEnhancedCore.onBuildSingleTiled, table, player)
  end

  CraftingEnhancedCore.AddTooltip(_option, player, table)
end

CraftingEnhancedCore.AddTooltip = function(option, player, table)
  local tooltip = ISBuildMenu.canBuild(0, 0, 0, 0, 0, 0, option, player);

  tooltip:setName(table.tooltipTitle);
  tooltip.description = tooltip.description .. table.tooltipDescription;
  tooltip:setTexture(table.tooltipTexture);

  CraftingEnhancedCore.canBuildObject(tooltip, player, table)
end

CraftingEnhancedCore.onBuildDoubleTiled = function(ignoreThisArgument, table, player)
  local _table = ISDoubleTileTable:new(table.nameID,
    table.sprites.west[1],
    table.sprites.west[2],
    table.sprites.north[1],
    table.sprites.north[2],
    table.sprites.east[1],
    table.sprites.east[2],
    table.sprites.south[1],
    table.sprites.south[2])

  _table.player = player
  _table.name = table.nameID

  for _, material in pairs(table.recipe) do
    _table.modData['need:' .. material.type] = material.amount
  end

  getCell():setDrag(_table, player)
end

CraftingEnhancedCore.onBuildSingleTiled = function(ignoreThisArgument, table, player)
  local _table = ISSimpleFurniture:new(table.nameID,
    table.sprites.west[1],
    table.sprites.north[1],
    table.sprites.east[1],
    table.sprites.south[1])

  _table.player = player
  _table.name = table.nameID

  _table:setEastSprite(table.sprites.east[1])
  _table:setSouthSprite(table.sprites.south[1])

  for _, material in pairs(table.recipe) do
    _table.modData['need:' .. material.type] = material.amount
  end

  getCell():setDrag(_table, player)
end

function getModInstance()
  return CraftingEnhancedCore
end

Events.OnFillWorldObjectContextMenu.Add(CraftingEnhancedCore.OnFillWorldObjectContextMenu)
