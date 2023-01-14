-- TODO : Comment everything propperly
-- TODO : Allow crafts when close to the table
-- TODO : Test multiblock placement

CraftingTableBuildMenu = CraftingTableBuildMenu or {}

local function requireTool(player, option, tool)
    CraftingTableBuildMenu.hasScrewdriver = player:containsTagEvalRecurse(tool, predicateNotBroken)

    if not CraftingTableBuildMenu.hasScrewdriver and not ISBuildMenu.cheat then
        option.notAvailable = true
        option.onSelect = nil
    end

end

local function requireMaterials(player, option, obj)
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

function buildMenu(option, worldobjects, player, obj)
    local name = getText(obj.NameID)
    local menuOption = option:addOption(name, worldobjects, obj.onBuild, player)

    -- Tooltip
    local tooltip = ISBuildMenu.canBuild(0, 0, 0, 0, 0, 0, menuOption, player);
    local tooltipDescription = obj.tooltip.desctiption
    tooltip:setName(name);
    tooltip.description = tooltipDescription .. tooltip.description;
    tooltip:setTexture(obj.sprites.west[0], obj.sprites.west[1]);
    requireTool(player, menuOption, obj.requiredTool)
    requireMaterials(player, obj)

end

function CraftingTableBuildMenu.doBuildMenu(player, context, worldobjects, test)

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
        LaboratoryTableMenu.onBuild(subMenu, worldobjects, player)
    end

end

CraftingTableBuildMenu.onForgeMenu = function(subMenu, worldobjects, player)

    -- Add option to the menu
    local ForgeOption = subMenu:addOption(getText("ContextMenu_Forge_Name"), worldobjects,
        CraftingTableBuildMenu.onForgeOption, square, player);

    -- Tooltip
    local tooltip = ISBuildMenu.canBuild(0, 0, 0, 0, 0, 0, ForgeOption, player);
    tooltip:setName(getText("ContextMenu_Forge_Name"));
    tooltip.description = getText("Tooltip_Forge") .. tooltip.description;
    tooltip:setTexture("crafting_tables_01_43");
    ISBuildMenu.requireHammer(ForgeOption)

    -- Display tooltip red if not enought materials
    local planks = ISBuildMenu.countMaterial(player, "Base.Plank");
    if planks < CraftingTableBuildMenu.recipeRequirements.PLANK_REQ and not ISBuildMenu.cheat then
        tooltip.description =
        tooltip.description ..
            " <RGB:1,0,0>" ..
            getItemNameFromFullType("Base.Plank") ..
            " " .. planks .. "/" .. CraftingTableBuildMenu.recipeRequirements.PLANK_REQ .. " <LINE>";
        ForgeOption.onSelect = nil;
        ForgeOption.notAvailable = true;
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
    if screws < CraftingTableBuildMenu.recipeRequirements.SCREW_REQ and not ISBuildMenu.cheat then
        tooltip.description =
        tooltip.description ..
            " <RGB:1,0,0>" ..
            getItemNameFromFullType("Base.Screws") ..
            " " .. screws .. "/" .. CraftingTableBuildMenu.recipeRequirements.SCREW_REQ .. " <LINE>";
        ForgeOption.onSelect = nil;
        ForgeOption.notAvailable = true;
    else
        tooltip.description =
        tooltip.description ..
            " <RGB:1,1,1>" ..
            getItemNameFromFullType("Base.Screws") ..
            " " ..
            CraftingTableBuildMenu.recipeRequirements.SCREW_REQ ..
            "/" .. CraftingTableBuildMenu.recipeRequirements.SCREW_REQ .. " <LINE>";
    end

    local scrap = ISBuildMenu.countMaterial(player, "Base.ScrapMetal");
    if scrap < CraftingTableBuildMenu.recipeRequirements.SCRAP_REQ and not ISBuildMenu.cheat then
        tooltip.description = tooltip.description ..
            " <RGB:1,0,0>" ..
            getItemNameFromFullType("Base.ScrapMetal") ..
            " " .. Scrap .. "/ " .. CraftingTableBuildMenu.recipeRequirements.SCRAP_REQ .. " <LINE>";
        ForgeOption.onSelect = nil;
        ForgeOption.notAvailable = true;
    else
        tooltip.description = tooltip.description ..
            " <RGB:1,1,1>" ..
            getItemNameFromFullType("Base.ScrapMetal") ..
            " " ..
            CraftingTableBuildMenu.recipeRequirements.SCRAP_REQ ..
            "/" .. CraftingTableBuildMenu.recipeRequirements.SCRAP_REQ .. " <LINE>";
    end
end

CraftingTableBuildMenu.onForgeOption = function(worldobjects, square, player)
    local forge = ISForge:new("crafting_tables_01_43");
    forge.modData["need:Base.Plank"] = CraftingTableBuildMenu.recipeRequirements.PLANK_REQ;
    forge.modData["need:Base.Screws"] = CraftingTableBuildMenu.recipeRequirements.SCREW_REQ;
    forge.modData["need:Base.ScrapMetal"] = CraftingTableBuildMenu.recipeRequirements.SCRAP_REQ;
    forge.player = player;
    forge.blockAllTheSquare = false;
    forge.isContainer = true;
    forge.containerType = "crate";
    forge.completionSound = "BuildWoodenStructureLarge";
    forge.maxTime = 200;
    getCell():setDrag(forge, player);
end
