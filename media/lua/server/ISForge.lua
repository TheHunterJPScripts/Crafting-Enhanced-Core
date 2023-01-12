ISForge = ISBuildingObject:derive("ISBuildingObject");

function ISForge:create(x, y, z, north, sprite)
	local cell = getWorld():getCell();
	self.sq = cell:getGridSquare(x, y, z);
	self.javaObject = IsoThumpable.new(cell, self.sq, sprite, north, self);
	buildUtil.setInfo(self.javaObject, self);
	buildUtil.consumeMaterial(self);
	self.javaObject:setName("Forge")
	self.javaObject:setMaxHealth(self:getHealth());
	self.javaObject:setHealth(self.javaObject:getMaxHealth());
	self.javaObject:setBreakSound("BreakObject");
	self.sq:AddSpecialObject(self.javaObject);

	self.javaObject:transmitCompleteItemToServer();
end

function ISForge:removeFromGround(square)
	for i = 0, square:getSpecialObjects():size() do
		local thump = square:getSpecialObjects():get(i);
		print("SPECIAL OBJECT: " + thump.name)
		if instanceof(thump, "Forge") then
			square:transmitRemoveItemFromSquare(thump);
			square:getObjects():remove(thump);
			square:getSpecialObjects():remove(thump);
		end
	end
end

function ISForge:new(sprite)
	local o = {};
	setmetatable(o, self);
	self.__index = self;
	o:init();
	o:setSouthSprite(sprite);
	-- o:setNorthSprite(northSprite1);
	-- o:setEastSprite(sprite2)
	-- o:setSprite(northSprite2)
	o.completionSound = "BuildWoodenStructureLarge";
	o.maxTime = 200;

	-- recipe
	-- o.modData["need:Base.Plank"] = CraftingTableBuildMenu.recipeRequirements.PLANK_REQ;
	-- o.modData["need:Base.Screws"] = CraftingTableBuildMenu.recipeRequirements.SCREW_REQ;
	-- o.modData["need:Base.ScrapMetal"] = CraftingTableBuildMenu.recipeRequirements.SCRAP_REQ;

	-- properties
	o.blockAllTheSquare = true;
	o.name = "Forge";
	-- o.dismantable = false;
	-- o.canBeAlwaysPlaced = true;
	-- o.isContainer = true;
	-- o.containerType = "crate";
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
