CraftingTableBuildMenu = CraftingTableBuildMenu or {}

CraftingTableBuildMenu.recipeRequirements = {
    PLANK_REQ = 3;
    SCREW_REQ = 5;
    SCRAP_REQ = 10;
}


function CraftingTableBuildMenu:doBuildMenu(player, context, worldobjects, test)

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
        CraftingTableBuildMenu.onForgeMenu(subMenu, worldobjects, player)
    end

end

CraftingTableBuildMenu.onForgeMenu = function(subMenu, worldobjects, player)

    -- Add option to the menu
    local ForgeOption = subMenu:addOption(getText("ContextMenu_Forge_Name"), worldobjects,
        ISBuildMenu.onForgeOption, square, player);

    -- Tooltip
    local tooltip = ISBuildMenu.canBuild(0, 0, 0, 0, 0, 0, ForgeOption, player);
    tooltip:setName(getText("ContextMenu_Forge_Name"));
    tooltip.description = getText("Tooltip_Forge") .. tooltip.description;
    tooltip:setTexture("Chemical_Toilet");
    ISBuildMenu.requireHammer(ForgeOption)

    -- Display tooltip red if not enought materials
    local planks = ISBuildMenu.countMaterial(player, "Base.Plank");
    if planks < CraftingTableBuildMenu.recipeRequirements.PLANK_REQ then
        tooltip.description =
        tooltip.description ..
            " <RGB:1,0,0>" ..
            getItemNameFromFullType("Base.Plank") ..
            " " .. planks .. "/" .. CraftingTableBuildMenu.recipeRequirements.PLANK_REQ .. " <LINE>";
        if not ISBuildMenu.cheat then
            buildWellOption.onSelect = nil;
            buildWellOption.notAvailable = true;
        end
    else
        tooltip.description =
        tooltip.description ..
            " <RGB:1,1,1>" ..
            getItemNameFromFullType("Base.Plank") ..
            " " ..
            CraftingTableBuildMenu.recipeRequirements.PLANK_REQ ..
            "/" .. CraftingTableBuildMenu.recipeRequirements.PLANK_REQ .. " <LINE>";
    end

    local screws = ISBuildMenu.countMaterial(player, "Base.Screws");
    if screws < CraftingTableBuildMenu.recipeRequirements.SCREW_REQ then
        tooltip.description =
        tooltip.description ..
            " <RGB:1,0,0>" ..
            getItemNameFromFullType("Base.Screws") ..
            " " .. screws .. "/" .. CraftingTableBuildMenu.recipeRequirements.SCREW_REQ .. " <LINE>";
        if not ISBuildMenu.cheat then
            buildWellOption.onSelect = nil;
            buildWellOption.notAvailable = true;
        end
    else
        tooltip.description =
        tooltip.description ..
            " <RGB:1,1,1>" ..
            getItemNameFromFullType("Base.Screws") ..
            " " ..
            CraftingTableBuildMenu.recipeRequirements.SCREW_REQ ..
            "/" .. CraftingTableBuildMenu.recipeRequirements.SCREW_REQ .. " <LINE>";
    end
    local Scrap = getSpecificPlayer(player):getInventory():getItemCount("Base.ScrapMetal", true);
    if Scrap < CraftingTableBuildMenu.recipeRequirements.SCRAP_REQ and not ISBuildMenu.cheat then
        tooltip.description = tooltip.description ..
            " <RGB:1,0,0>" ..
            getItemText("ScrapMetal") ..
            " " .. Scrap .. "/ " .. CraftingTableBuildMenu.recipeRequirements.SCRAP_REQ .. "\n";
        ForgeOption.onSelect = nil;
        ForgeOption.notAvailable = true;
    else
        tooltip.description = tooltip.description ..
            " <RGB:1,1,1>" ..
            getItemText("ScrapMetal") ..
            CraftingTableBuildMenu.recipeRequirements.SCRAP_REQ ..
            "/" .. CraftingTableBuildMenu.recipeRequirements.SCRAP_REQ .. "\n";
    end
end

CraftingTableBuildMenu.onForgeOption = function(worldobjects, square, player)
    local furniture = ISForge:new("Forge", "camping_01_16", "camping_01_15");
    furniture.modData["need:Base.Plank"] = recipeRequirements.PLANK_REQ;
    furniture.modData["need:Base.Screws"] = recipeRequirements.SCREW_REQ;
    furniture.modData["need:Base.ScrapMetal"] = recipeRequirements.SCRAP_REQ;
    furniture.player = player;
    furniture.blockAllTheSquare = true;
    furniture.completionSound = "BuildWoodenStructureLarge";
    furniture.maxTime = 200;
    getCell():setDrag(furniture, player);
end

Events.OnFillWorldObjectContextMenu.Add(CraftingTableBuildMenu.doBuildMenu);
