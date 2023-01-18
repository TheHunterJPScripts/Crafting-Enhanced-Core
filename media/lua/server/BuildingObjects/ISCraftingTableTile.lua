ISCraftingTableTile = ISBuildingObject:derive("ISCraftingTableTile");

Direction = { North = 1, West = 2, South = 3, East = 4 }

function ISCraftingTableTile:create(x, y, z, north, sprite)
	local cell = getWorld():getCell();
	self.sq = cell:getGridSquare(x, y, z);
	self:setInfo(self.sq, self:getSprite(self.direction), self);

	local xa, ya, za = self:getSecondarySquare(square, self.direction)
	local secondarySquare = getCell():getGridSquare(xa, ya, za);

	local oldModData = self.modData
	self.modData = {}
	self:setInfo(secondarySquare, self:getSprite(self.direction), self);

	self.modData = oldModData
	buildUtil.consumeMaterial(self);
end

function ISCraftingTableTile:walkTo(x, y, z)
	local playerObj = getSpecificPlayer(self.player)
	local square = getCell():getGridSquare(x, y, z)
	local xa, ya, za = self:getSecondarySquare(square, self.direction)
	local secondarySquare = getCell():getGridSquare(xa, ya, za);

	if square:DistToProper(playerObj) < secondarySquare:DistToProper(playerObj) then
		return luautils.walkAdj(playerObj, square)
	end
	return luautils.walkAdj(playerObj, secondarySquare)
end

function ISCraftingTableTile:setInfo(square, spriteName)
	-- add furniture to our ground
	local thumpable = IsoThumpable.new(getCell(), square, spriteName, false, self);
	-- name of the item for the tooltip
	buildUtil.setInfo(thumpable, self);
	-- the furniture have 200 base health + 100 per carpentry lvl
	thumpable:setMaxHealth(self:getHealth());
	thumpable:setHealth(thumpable:getMaxHealth())
	-- the sound that will be played when our furniture will be broken
	thumpable:setBreakSound("BreakObject");
	square:AddSpecialObject(thumpable);
	thumpable:transmitCompleteItemToServer();
end

function ISCraftingTableTile:removeFromGround(square)
	for i = 0, square:getSpecialObjects():size() do
		local thump = square:getSpecialObjects():get(i);
		if instanceof(thump, "IsoThumpable") then
			square:transmitRemoveItemFromSquare(thump);
			break
		end
	end

	local xa, ya, za = self:getSecondarySquare(square, self.direction)
	local secondarySquare = getCell():getGridSquare(xa, ya, za);
	square = getCell():getGridSquare(xa, ya, za);

	for i = 0, secondarySquare:getSpecialObjects():size() do
		local thump = secondarySquare:getSpecialObjects():get(i);
		if instanceof(thump, "IsoThumpable") then
			secondarySquare:transmitRemoveItemFromSquare(thump);
			break
		end
	end
end

function ISCraftingTableTile:new(name, direction)
	local o = {};
	setmetatable(o, self);
	self.__index = self;
	o:init();
	o.direction = direction
	o:setSprite("carpentry_01_02");
	o:setNorthSprite("carpentry_01_02");
	-- o.sprite2 = sprite2;
	-- o.northSprite2 = northSprite2;
	o.name = name;
	o.canBarricade = false;
	o.dismantable = true;
	o.blockAllTheSquare = true;
	o.canBeAlwaysPlaced = true;
	o.buildLow = true;
	return o;
end

function ISCraftingTableTile:getHealth()
	return 200 + buildUtil.getWoodHealth(self);
end

function ISCraftingTableTile:render(x, y, z, square)
	local xa, ya, za = self:getSecondarySquare(square, self.direction)
	local secondarySquare = getCell():getGridSquare(xa, ya, za);
	local secondarySprite = self:getSecondarySprite(self.direction)
	local secondarySquareCanBePlaced = true

	if not self.canBeAlwaysPlaced then secondarySquareCanBePlaced = false end

	if not secondarySquare then secondarySquareCanBePlaced = false end

	if not secondarySquare:isFreeOrMidair(true) then secondarySquareCanBePlaced = false end

	if secondarySquare:isVehicleIntersecting() then secondarySquareCanBePlaced = false end

	-- render secondary sprite
	local isoSecondary = IsoSprite.new();
	isoSecondary:LoadFramesNoDirPageSimple(secondarySprite);
	if secondarySquareCanBePlaced then
		isoSecondary:RenderGhostTile(xa, ya, za);
	else
		isoSecondary:RenderGhostTileRed(xa, ya, za);
	end

	-- render the main part
	ISBuildingObject.render(self, x, y, z, square)
end

function ISCraftingTableTile:isValid(square)
	if not ISBuildingObject.isValid(self, square) then
		return false
	end
	if buildUtil.stairIsBlockingPlacement(square, true) then return false; end
	if square:isVehicleIntersecting() then return false end

	local xa, ya, za = self:getSecondarySquare(square, self.direction)
	local secondarySquare = getCell():getGridSquare(xa, ya, za);
	if not ISBuildingObject.isValid(self, secondarySquare) then
		return false
	end
	if not secondarySquare or not secondarySquare:isFreeOrMidair(true) or
		buildUtil.stairIsBlockingPlacement(secondarySquare, true) then
		return false
	end
	if secondarySquare:isVehicleIntersecting() then return false end
	return true
end

function ISCraftingTableTile:getSquare2Pos(square, north)
	local x = square:getX()
	local y = square:getY()
	local z = square:getZ()
	if north then
		y = y - 1
	else
		x = x - 1
	end
	return x, y, z
end

function ISCraftingTableTile:getSquare2(square, north)
	local x, y, z = self:getSquare2Pos(square, north)
	return getCell():getGridSquare(x, y, z)
end

function ISCraftingTableTile:getSecondarySquare(square, direction)
	local x = square:getX()
	local y = square:getY()
	local z = square:getZ()

	if direction == Direction.North then return x, y, x end
	if direction == Direction.West then return x, y, x end
	if direction == Direction.South then return x, y, x end
	if direction == Direction.East then return x, y, x end
end

function ISCraftingTableTile:getSecondarySprite(direction)
	if direction == Direction.North then return "carpentry_01_02" end
	if direction == Direction.West then return "carpentry_01_02" end
	if direction == Direction.South then return "carpentry_01_02" end
	if direction == Direction.East then return "carpentry_01_02" end
end

function ISCraftingTableTile:getSprite(direction)
	if direction == Direction.North then return "carpentry_01_01" end
	if direction == Direction.West then return "carpentry_01_01" end
	if direction == Direction.South then return "carpentry_01_01" end
	if direction == Direction.East then return "carpentry_01_01" end
end
