ISForge = ISBuildingObject:derive("ISBuildingObject");

function ISForge:create(x, y, z, north, sprite)
	local cell = getWorld():getCell();
	self.sq = cell:getGridSquare(x, y, z);
	self.javaObject = IsoThumpable.new(cell, self.sq, sprite, north, self);
	buildUtil.setInfo(self.javaObject, self);
	buildUtil.consumeMaterial(self);
	self.javaObject:setMaxHealth(self:getHealth());
	self.javaObject:setHealth(self.javaObject:getMaxHealth());
	self.javaObject:setBreakSound("BreakObject");
	self.sq:AddSpecialObject(self.javaObject);

	self.javaObject:transmitCompleteItemToServer();
end

function ISForge:removeFromGround(square)
	for i = 0, square:getSpecialObjects():size() do
		local thump = square:getSpecialObjects():get(i);
		if instanceof(thump, "IsoThumpable") then
			square:transmitRemoveItemFromSquare(thump);
		end
	end
end

function ISForge:new(name, sprite, northSprite)
	local o = {};
	setmetatable(o, self);
	self.__index = self;
	o:init();
	o:setSprite(sprite);
	o:setNorthSprite(northSprite);
	o.name = name;
	o.dismantable = false;
	o.blockAllTheSquare = true;
	o.buildLow = true;
	o.canPassThrough = true;
	o.canBarricade = false;
	o.ignoreNorth = false;
	o.canBeAlwaysPlaced = false;
	o.isThumpable = false;
	return o;
end

-- Wells are primarily made of stone and should have plenty of health
function ISForge:getHealth()
	return 10000;
end

function ISForge:isValid(square)
	if not ISBuildingObject.isValid(self, square) then return false; end

	if not square:isFreeOrMidair(false) then return false end

	if buildUtil.stairIsBlockingPlacement(square, true) then return false; end

	if not buildUtil.canBePlace(self, square) then return false; end

	return true;
end

function ISForge:render(x, y, z, square)
	ISBuildingObject.render(self, x, y, z, square)
end
