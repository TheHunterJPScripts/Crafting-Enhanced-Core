ISDoubleTileTable = ISBuildingObject:derive("ISDoubleTileTable");

-- TODO: Prevent building if it clip thought walls and stuff

function ISDoubleTileTable:create(x, y, z, north, sprite)

	local cell = getWorld():getCell();
	self.sq = cell:getGridSquare(x, y, z);
	self:setInfo(self.sq, north, sprite, self);


	local secondarySprite = self.sprite2;
	local secondaryX = x - 1;
	local secondaryY = y;

	if sprite == self.northSprite then
		secondarySprite = self.northSprite2
		secondaryX = x;
		secondaryY = y - 1
	elseif sprite == self.southSprite then
		secondarySprite = self.southSprite2
		secondaryX = x;
		secondaryY = y - 1
	elseif sprite == self.eastSprite then
		secondarySprite = self.eastSprite2
		secondaryX = x - 1
	end

	local secondarySquare = cell:getGridSquare(secondaryX, secondaryY, z);

	local oldModData = self.modData
	self.modData = {}
	self:setInfo(secondarySquare, north, secondarySprite, self);

	self.modData = oldModData
	buildUtil.consumeMaterial(self);
end

function ISDoubleTileTable:walkTo(x, y, z)
	local playerObj = getSpecificPlayer(self.player)
	local square = getCell():getGridSquare(x, y, z)
	local square2 = self:getSquare2(square, self.north)
	if square:DistToProper(playerObj) < square2:DistToProper(playerObj) then
		return luautils.walkAdj(playerObj, square)
	end
	return luautils.walkAdj(playerObj, square2)
end

function ISDoubleTileTable:setInfo(square, north, sprite)
	-- add furniture to our ground
	local thumpable = IsoThumpable.new(getCell(), square, sprite, north, self);
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

function ISDoubleTileTable:removeFromGround(square)
	for i = 0, square:getSpecialObjects():size() do
		local thump = square:getSpecialObjects():get(i);
		if instanceof(thump, "IsoThumpable") then
			square:transmitRemoveItemFromSquare(thump);
			break
		end
	end

	local xa = square:getX();
	local ya = square:getY();

	if self:getNorth() then
		ya = ya - 1;
	else
		xa = xa - 1;
	end

	square = getCell():getGridSquare(xa, ya, square:getZ());
	for i = 0, square:getSpecialObjects():size() do
		local thump = square:getSpecialObjects():get(i);
		if instanceof(thump, "IsoThumpable") then
			square:transmitRemoveItemFromSquare(thump);
			break
		end
	end
end

function ISDoubleTileTable:new(name, sprite1, sprite2, northSprite1, northSprite2, eastSprite1, eastSprite2, southSprite1
                               ,
                               southSprite2)
	local o = {};
	setmetatable(o, self);
	self.__index = self;
	o:init();
	o:setSprite(sprite1);
	o:setNorthSprite(northSprite1);
	o:setEastSprite(eastSprite1)
	o:setSouthSprite(southSprite1)
	o.sprite2 = sprite2;
	o.northSprite2 = northSprite2;
	o.eastSprite2 = eastSprite2
	o.southSprite2 = southSprite2


	o.name = name;
	o.canBarricade = false;
	o.dismantable = true;
	o.blockAllTheSquare = true;
	o.canBeAlwaysPlaced = true;
	o.buildLow = true;
	return o;
end

-- return the health of the new furniture, it's 200 + 100 per carpentry lvl
function ISDoubleTileTable:getHealth()
	return 200 + buildUtil.getWoodHealth(self);
end

function ISDoubleTileTable:render(x, y, z, square)
	-- render the first part
	ISBuildingObject.render(self, x, y, z, square)


	local sprite = self:getSprite()
	local secondarySprite = self.sprite2;
	local secondaryX = x - 1;
	local secondaryY = y;

	if sprite == self.northSprite then
		secondarySprite = self.northSprite2
		secondaryX = x;
		secondaryY = y - 1
	elseif sprite == self.southSprite then
		self.north = true
		secondarySprite = self.southSprite2
		secondaryX = x;
		secondaryY = y - 1
	elseif sprite == self.eastSprite then
		secondarySprite = self.eastSprite2
		secondaryX = x - 1
	end

	local secondarySpriteFree = true;

	local secondarySquare = getCell():getGridSquare(secondaryX, secondaryY, z);

	-- test if the square are free to add our furniture
	if not self.canBeAlwaysPlaced and (not secondarySquare or not secondarySquare:isFreeOrMidair(true)) then
		secondarySpriteFree = false;
	end

	if secondarySquare and secondarySquare:isVehicleIntersecting() then secondarySpriteFree = false end

	-- render our second tile object
	local secondarySpriteObject = IsoSprite.new();
	secondarySpriteObject:LoadFramesNoDirPageSimple(secondarySprite);
	if secondarySpriteFree then
		secondarySpriteObject:RenderGhostTile(secondaryX, secondaryY, z);
	else
		secondarySpriteObject:RenderGhostTileRed(secondaryX, secondaryY, z);
	end
end

function ISDoubleTileTable:isValid(square)
	if not ISBuildingObject.isValid(self, square) then
		return false
	end
	if buildUtil.stairIsBlockingPlacement(square, true) then return false; end
	if square:isVehicleIntersecting() then return false end
	local xa, ya, za = self:getSquare2Pos(square, self.north)
	local squareA = getCell():getGridSquare(xa, ya, za)
	if not squareA or not squareA:isFreeOrMidair(true) or buildUtil.stairIsBlockingPlacement(squareA, true) then
		return false
	end
	if squareA:isVehicleIntersecting() then return false end
	return true
end

function ISDoubleTileTable:getSquare2Pos(square, north)
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

function ISDoubleTileTable:getSquare2(square, north)
	local x, y, z = self:getSquare2Pos(square, north)
	return getCell():getGridSquare(x, y, z)
end
