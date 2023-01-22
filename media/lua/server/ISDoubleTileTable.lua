ISDoubleTileTable = ISDoubleTileFurniture:derive("ISDoubleTileTable");

-- TODO: Prevent building if it clip thought walls and stuff
-- TODO: Secondary sprite not considered present when building over it (Game limitation looks like or maybe debug mode wierd stuff)
-- TODO: Check if out of debug mode the user moves to build the table.

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
