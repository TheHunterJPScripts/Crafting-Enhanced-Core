CraftingEnhancedCore = {}

CraftingEnhancedCore.NAME = "Crafting Enhanced Core"
CraftingEnhancedCore.AUTHOR = "TheHunterJP"
CraftingEnhancedCore.VERSION = "0.1"

print('Mod Loaded: ' ..
    CraftingEnhancedCore.NAME .. ' by ' .. CraftingEnhancedCore.AUTHOR .. ' (v' .. CraftingEnhancedCore.VERSION .. ')')

function getModInstance()
    return CraftingEnhancedCore;
end

CraftingEnhancedCore.OnFillWorldObjectContextMenu = function(player, context, worldobjects, test)
    -- Sanity checks
    if test and ISWorldObjectContextMenu.Test then return true end

    if getCore():getGameMode() == "LastStand" then
        return;
    end

    local playerObj = getSpecificPlayer(player)

    -- Prevent opening the menu on a car.
    if playerObj:getVehicle() then return; end

    -- General menu
    local subMenu = nil;
    local buildOption = nil;

    -- Check the current open menus and search for the building menu.
    for _, value in ipairs(context.options) do
        if value.name == getText("ContextMenu_Build") then
            print(value.name)
            buildOption = value;
            -- Retrieve the sub menu in case it is found.
            subMenu = context:getSubMenu(buildOption.subOption);
        end
    end
    if subMenu then
        LaboratoryTableMenu.onBuildMenu(subMenu, worldobjects, player)
    end
end

CraftingEnhancedCore.buildMenu = function(option, worldobjects, player, obj)
    print("ADDDDDDDDD")
    local name = getText(obj.NameID)
    local menuOption = option:addOption(name, worldobjects, obj.onBuild, player)

    -- Tooltip
    local tooltip = ISBuildMenu.canBuild(0, 0, 0, 0, 0, 0, menuOption, player);
    tooltip:setName(name);
    print(obj.sprites.west[1])
    tooltip:setTexture(obj.sprites.west[1]);
    local tooltipDescription = obj.tooltip.description
    tooltip.description = tooltipDescription .. tooltip.description;
    -- CraftingEnhancedCore.requireTool(player, menuOption, obj.requiredTool)
    -- CraftingEnhancedCore.requireMaterials(player, menuOption, obj)

end

CraftingEnhancedCore.requireTool = function(player, option, tool)
    local hasTool = getSpecificPlayer(player):getInventory():containsTagEvalRecurse(tool, predicateNotBroken)

    if not hasTool and not ISBuildMenu.cheat then
        option.notAvailable = true
        option.onSelect = nil
    end
end

CraftingEnhancedCore.requireMaterials = function(player, option, obj)
    local tooltip = option.toolTip

    for i, requiredMaterial in ipairs(obj.recipe) do
        local currentMaterialCount = ISBuildMenu.countMaterial(player, requiredMaterial.Material);

        if currentMaterialCount < requiredMaterial.Amount and not ISBuildMenu.cheat then
            tooltip.description =
            tooltip.description ..
                " <RGB:1,0,0>" ..
                getItemNameFromFullType(requiredMaterial.Material) ..
                " " .. currentMaterialCount .. "/" .. requiredMaterial.Amount .. " <LINE>";

            option.onSelect = nil;
            option.notAvailable = true;
        else
            tooltip.description =
            tooltip.description ..
                " <RGB:1,1,1>" ..
                getItemNameFromFullType(requiredMaterial.Material) ..
                " " ..
                requiredMaterial.Amount ..
                "/" .. requiredMaterial.Amount .. " <LINE>";
        end
    end

    return true
end

Events.OnFillWorldObjectContextMenu.Add(CraftingEnhancedCore.OnFillWorldObjectContextMenu)
