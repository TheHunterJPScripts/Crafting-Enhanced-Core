-- require "BuildingObjects/ISBuildingObject"

-- -- The forge will derive from buildable objects
-- ISForge = ISBuildingObject.derive("ISForge")

-- function ISForge:create(x, y, z, north, sprite)
--     -- Get position for object plaCement
--     local worldCell = getWorld():getCell();
--     local square = cell:getSquare(x, y, z)

--     -- Create object
--     local obj = IsoThumpable.new(cell, square, sprite, north, self)
--     obj:setName("Forge")
--     buildUtil.consumeMaterial(self)

--     -- Instance object
--     square:AddSpecialObject(obj)
--     self.javaObject = obj
--     self.javaObject:transmitCompleteItemToServer()
-- end

-- function ISForge:render(x, y, z, square)
--     ISBuildingObject.render(self, x, y, z, square)
-- end

-- function ISForge:removeFromGround(square)
--     for i = 0, square:getSpecialObjects():size() do
--         local thump = square:getSpecialObjects():get(i);
--         if instanceof(thump, "ISForge") then
--             square:transmitRemoveItemFromSquare(thump);
--             square:getObjects():remove(thump);
--             square:getSpecialObjects():remove(thump);
--         end
--     end
-- end

-- function ISForge:new(name, character, sprite, northSprite)
--     local o = {};
--     setmetatable(o, self);
--     self.__index = self;
--     o:init();
--     o:setSprite(sprite);
--     o.character = character;
--     o:setNorthSprite(northSprite);
--     o.noNeedHammer = true;
--     o.name = name;
--     o.blockAllTheSquare = true;
--     o.canBeAlwaysPlaced = true;
--     return o;
-- end

-- function ISForge:isValid(square)
--     if not ISBuildingObject.isValid(self, square) then return false; end

--     if self.needToBeAgainstWall then
--         for i = 0, square:getObjects():size() - 1 do
--             local obj = square:getObjects():get(i);
--             if (self.north and obj:getProperties():Is("WallN")) or (not self.north and obj:getProperties():Is("WallW")) then
--                 return true;
--             end
--         end
--         return false;
--     else
--         if buildUtil.stairIsBlockingPlacement(square, true) then return false; end
--     end
--     return true;
-- end
