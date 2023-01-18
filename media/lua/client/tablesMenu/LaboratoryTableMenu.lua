LaboratoryTableMenu = {}

LaboratoryTableMenu.recipe = {
  {
    Material = "Base.Plank",
    Amount = 3
  },
  {
    Material = "Base.ScrapMetal",
    Amount = 3
  }
}

LaboratoryTableMenu.NameID = "ContextMenu_Laboratory_Table"
LaboratoryTableMenu.requiredTool = "Screwdriver"
LaboratoryTableMenu.sprites = {
  south = {
    "core_workbenches_0",
    "core_workbenches_1"
  },
  west = {
    "core_workbenches_0",
    "core_workbenches_1"
  },
  north = {
    "core_workbenches_0",
    "core_workbenches_1"
  },
  east = {
    "core_workbenches_0",
    "core_workbenches_1"
  }
}
LaboratoryTableMenu.tooltip = {
  description = getText("Laboratory_Table_Tooltip")
}

LaboratoryTableMenu.onBuildMenu = function(option, worldobjects, player)
  getModInstance().buildMenu(option, worldobjects, player, LaboratoryTableMenu)
end

LaboratoryTableMenu.onBuild = function(player)
  local laboratoryTable = ISCraftingTableTile:new("Pepe", Direction.North);

  -- for _, recipe in ipairs(LaboratoryTableMenu.recipe) do
  --   laboratoryTable.modData["need:" .. recipe.Material] = recipe.Amount
  -- end

  laboratoryTable.player = player;
  laboratoryTable.blockAllTheSquare = false;
  laboratoryTable.isContainer = true;
  laboratoryTable.containerType = "crate";
  laboratoryTable.completionSound = "BuildWoodenStructureLarge";
  laboratoryTable.maxTime = 200;

  getCell():setDrag(laboratoryTable, player);
end
