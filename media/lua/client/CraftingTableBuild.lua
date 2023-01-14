local CraftingEnhancedCore = {}

CraftingEnhancedCore.NAME = "Crafting Enhanced Core"
CraftingEnhancedCore.AUTHOR = "TheHunterJP"
CraftingEnhancedCore.VERSION = "0.1"

print('Mod Loaded: ' ..
    CraftingEnhancedCore.NAME .. ' by ' .. CraftingEnhancedCore.AUTHOR .. ' (v' .. CraftingEnhancedCore.VERSION .. ')')

function getModInstance()
    return CraftingEnhancedCore;
end

local function requireScrewdriver(player, option)
    if ISBuildMenu.cheat then return end

    local playerObj = getSpecificPlayer(player)
    local playerInv = playerObj:getInventory()
    local hasScrewdriver = player:containsTagEvalRecurse("Screwdriver", predicateNotBroken)

    if not hasScrewdriver then
        option.notAvailable = true
        option.onSelect = nil
    end
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

    local square = nil;

    -- General menu
    local subMenu = nil;
    local buildOption = nil;
    -- Check the current open menus and search for the building menu.

    for _, value in ipairs(context.options) do
        if value.name == getText("ContextMenu_Build") then
            buildOption = value;
            -- Retrieve the sub menu in case it is found.
            subMenu = context:getSubMenu(buildOption.subOption);
        end
    end
    if subMenu then
        LaboratoryTableMenu.onMenu(subMenu, worldobjects, player)
    end





end

Events.OnFillWorldObjectContextMenu.Add(CraftingEnhancedCore.OnFillWorldObjectContextMenu)
