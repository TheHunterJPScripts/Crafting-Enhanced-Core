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
    "crafting_tables_0",
    "crafting_tables_1"
  },
  west = {
    "crafting_tables_0",
    "crafting_tables_1"
  },
  north = {
    "crafting_tables_0",
    "crafting_tables_1"
  },
  east = {
    "crafting_tables_0",
    "crafting_tables_1"
  }
}
LaboratoryTableMenu.tooltip = {
  description = getText("Laboratory_Table_Tooltip")
}

LaboratoryTableMenu.onBuildMenu = function(option, worldobjects, player)
  getModInstance().buildMenu(option, worldobjects, player, LaboratoryTableMenu)
end

LaboratoryTableMenu.onBuild = function(player)
  local laboratoryTable = ISLaboratoryTable:new();

  for _, recipe in ipairs(LaboratoryTableMenu.recipe) do
    laboratoryTable.modData["need:" .. recipe.Material] = recipe.Amount
  end

  laboratoryTable.player = player;
  laboratoryTable.blockAllTheSquare = false;
  laboratoryTable.isContainer = true;
  laboratoryTable.containerType = "crate";
  laboratoryTable.completionSound = "BuildWoodenStructureLarge";
  laboratoryTable.maxTime = 200;

  getCell():setDrag(laboratoryTable, player);
end
