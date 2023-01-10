local recipeRequirements = {
    PLANK_REQ = 3;
    SCREW_REQ = 5;
    SCRAP_REQ = 10;
}

-- Returns true if the player has an usable shovel, false otherwise.
local function predicateDigGrave(item)
    return not item:isBroken() and item:hasTag("DigGrave");
end

-- Returns true if the player has an usable hammer, false otherwise.
local function predicateHammer(item)
    return not item:isBroken() and item:hasTag("Hammer");
end

-- The player should only be able to build a well if he has a usable hammer and shovel and he has read the magazine
local function CanPlaceWell(playerInv, playerObj)
    local recipeName = "build well";
    if ISBuildMenu.cheat == true or
        (playerInv:getFirstEvalRecurse(predicateHammer) and
            playerInv:getFirstEvalRecurse(predicateDigGrave) and
            playerObj:isRecipeKnown(recipeName)) then
        return true;
    else
        return false;
    end
end

-- Add build option to world context menu
local function onFillWorldObjectContextMenu(player, context, worldobjects, test)
    local playerObj = getSpecificPlayer(player);
    local playerInv = playerObj:getInventory();


    if CanPlaceWell(playerInv, playerObj) then
        -- Define the well placement function


        local buildWellOption =
        context:insertOptionAfter(getText("ContextMenu_Build"), getText("ContextMenu_BuildWell"), worldobjects,
            doBuildWell, square, player);

        local tooltip = ISBuildMenu.canBuild(PLANK_REQ, NAILS_REQ, 0, 0, 0, CARPENTRY_REQ, buildWellOption, player);
        tooltip.description = getText("ContextMenu_BuildWellTooltipShortDesc") .. " <LINE><LINE>";

        -- Setup build requirements on tooltip
        local planks = ISBuildMenu.countMaterial(player, "Base.Plank");
        if planks < PLANK_REQ then
            tooltip.description =
            tooltip.description ..
                " <RGB:1,0,0>" .. getItemNameFromFullType("Base.Plank") .. " " .. planks .. "/" .. PLANK_REQ .. " <LINE>";
            if not ISBuildMenu.cheat then
                buildWellOption.onSelect = nil;
                buildWellOption.notAvailable = true;
            end
        else
            tooltip.description =
            tooltip.description ..
                " <RGB:1,1,1>" .. getItemNameFromFullType("Base.Plank") .. " " .. planks .. "/" .. PLANK_REQ .. " <LINE>";
        end

        local nails = ISBuildMenu.countMaterial(player, "Base.Nails");
        if nails < NAILS_REQ then
            tooltip.description =
            tooltip.description ..
                " <RGB:1,0,0>" .. getItemNameFromFullType("Base.Nails") .. " " .. nails .. "/" .. NAILS_REQ .. " <LINE>";
            if not ISBuildMenu.cheat then
                buildWellOption.onSelect = nil;
                buildWellOption.notAvailable = true;
            end
        else
            tooltip.description =
            tooltip.description ..
                " <RGB:1,1,1>" .. getItemNameFromFullType("Base.Nails") .. " " .. nails .. "/" .. NAILS_REQ .. " <LINE>";
        end

        local stones = ISBuildMenu.countMaterial(player, "Base.Stone");
        if stones < STONE_REQ then
            tooltip.description =
            tooltip.description ..
                " <RGB:1,0,0>" .. getItemNameFromFullType("Base.Stone") .. " " .. stones .. "/" .. STONE_REQ .. " <LINE>";
            if not ISBuildMenu.cheat then
                buildWellOption.onSelect = nil;
                buildWellOption.notAvailable = true;
            end
        else
            tooltip.description =
            tooltip.description ..
                " <RGB:1,1,1>" .. getItemNameFromFullType("Base.Stone") .. " " .. stones .. "/" .. STONE_REQ .. " <LINE>";
        end

        local metalPipes = ISBuildMenu.countMaterial(player, "Base.MetalPipe");
        if metalPipes < METAL_PIPE_REQ then
            tooltip.description =
            tooltip.description ..
                " <RGB:1,0,0>" ..
                getItemNameFromFullType("Base.MetalPipe") .. " " .. metalPipes .. "/" .. METAL_PIPE_REQ .. " <LINE>";
            if not ISBuildMenu.cheat then
                buildWellOption.onSelect = nil;
                buildWellOption.notAvailable = true;
            end
        else
            tooltip.description =
            tooltip.description ..
                " <RGB:1,1,1>" ..
                getItemNameFromFullType("Base.MetalPipe") .. " " .. metalPipes .. "/" .. METAL_PIPE_REQ .. " <LINE>";
        end

        local rope = ISBuildMenu.countMaterial(player, "Base.Rope");
        if rope < ROPE_REQ then
            tooltip.description =
            tooltip.description ..
                " <RGB:1,0,0>" .. getItemNameFromFullType("Base.Rope") .. " " .. rope .. "/" .. ROPE_REQ .. " <LINE>";
            if not ISBuildMenu.cheat then
                buildWellOption.onSelect = nil;
                buildWellOption.notAvailable = true;
            end
        else
            tooltip.description =
            tooltip.description ..
                " <RGB:1,1,1>" .. getItemNameFromFullType("Base.Rope") .. " " .. rope .. "/" .. ROPE_REQ .. " <LINE>";
        end

        tooltip:setTexture("camping_01_16");
        tooltip:setName(getText("ContextMenu_BuildWellTooltipName"));
        ISBuildMenu.requireHammer(buildWellOption);
    end
end

Events.OnFillWorldObjectContextMenu.Add(onFillWorldObjectContextMenu);
