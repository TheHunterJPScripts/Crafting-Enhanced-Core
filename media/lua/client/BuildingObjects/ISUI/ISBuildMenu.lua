-- require "BuildingObjects/ISBuildingObject"

-- ISMyBuildMenu = derive("ISBuildMenu")

-- local original_menu = ISBuildMenu.doBuildMenu

-- function ISBuildMenu:doBuildMenu(player, context, worldobjects, test)

--     -- Call original menu
--     original_menu(player, context, worldobjects, test)

--     -- Sanity checks
--     if test and ISWorldObjectContextMenu.Test then return true end

--     if getCore():getGameMode() == "LastStand" then
--         return;
--     end

--     local playerObj = getSpecificPlayer(player)
--     local playerInv = playerObj:getInventory()

--     -- Prevent opening the menu on a car.
--     if playerObj:getVehicle() then return; end

--     ISBuildMenu.woodWorkXp = playerObj:getPerkLevel(Perks.Woodwork);

--     local square = nil;

--     -- we get the thumpable item (like wall/door/furniture etc.) if exist on the tile we right clicked
--     local thump = nil;
--     for i, v in ipairs(worldobjects) do
--         square = v:getSquare();
--         if instanceof(v, "IsoThumpable") and not v:isDoor() then
--             if not MultiStageBuilding.getStages(playerObj, v, ISBuildMenu.cheat):isEmpty() then
--                 thump = v
--             end
--         end
--     end

--     -- If we have any thing to build in our inventory
--     if ISBuildMenu.haveSomethingtoBuild(player) then

--         -- Sanity check
--         if test then return ISWorldObjectContextMenu.setTest() end

--         -- Add submenu
--         local buildOption = context:addOption(getText("ContextMenu_Workbench_Menu"), worldobjects, nil);
--         local subMenu = ISContextMenu:getNew(context);
--         context:addSubMenu(buildOption, subMenu);

--         -- Add Forge to the submenu
--         ISBuildMenu.onForgeMenu(subMenu, worldobjects, player)

--     end

-- end

-- ISBuildMenu.onForgeMenu = function(subMenu, worldobjects, player)

--     -- Add option to the menu
--     local ForgeOption = subMenu:addOption(getText("ContextMenu_Forge_Name"), worldobjects,
--         ISBuildMenu.onForgeOption, square, player);

--     -- Tooltip
--     local tooltip = ISBuildMenu.canBuild(0, 0, 0, 0, 0, 0, ForgeOption, player);
--     tooltip:setName(getText("ContextMenu_Forge_Name"));
--     tooltip.description = getText("Tooltip_Forge") .. tooltip.description;
--     tooltip:setTexture("Chemical_Toilet");
--     ISBuildMenu.requireHammer(ForgeOption)

--     -- Display tooltip red if not enought materials
--     local Scrap = getSpecificPlayer(player):getInventory():getItemCount("Base.ScrapMetal", true);
--     if Scrap < 10 and not ISBuildMenu.cheat then
--         tooltip.description = tooltip.description ..
--             " <RGB:1,0,0>" .. getItemText("ScrapMetal") .. " " .. Scrap .. "/10 " .. "\n";
--         ForgeOption.onSelect = nil;
--         ForgeOption.notAvailable = true;
--     else
--         tooltip.description = tooltip.description .. " <RGB:1,1,1>" .. getItemText("ScrapMetal") .. " 10/10 " .. "\n";
--     end

--     --ForgeOption.toolTip = tooltip
-- end

-- ISBuildMenu.onForgeOption = function(worldobjects, square, player)
--     local furniture = ISBlastFurnace:new("Forge", getSpecificPlayer(player), "carpentry_02_68",
--         "carpentry_02_69");
--     furniture.modData["need:Base.ScrapMetal"] = "10";
--     furniture.player = player;
--     furniture.blockAllTheSquare = true;
--     furniture.completionSound = "BuildWoodenStructureLarge";
--     furniture.maxTime = 250;
--     getCell():setDrag(furniture, player);
-- end
