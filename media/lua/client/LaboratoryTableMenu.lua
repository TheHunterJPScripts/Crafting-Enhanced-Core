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
    "furniture_tables_high_01_24",
    "furniture_tables_high_01_25"
  },
  west = {
    "furniture_tables_high_01_24",
    "furniture_tables_high_01_25"
  },
  north = {
    "furniture_tables_high_01_24",
    "furniture_tables_high_01_25"
  },
  east = {
    "furniture_tables_high_01_24",
    "furniture_tables_high_01_25"
  }
}
LaboratoryTableMenu.tooltip = {
  description = getText("Laboratory_Table_Tooltip")
}

LaboratoryTableMenu.onBuildMenu = function(option, worldobjects, player)
  getModInstance().buildMenu(option, worldobjects, player)
end

LaboratoryTableMenu.onBuild = function(sprite, player, name)
  local _table = ISDoubleTileFurniture:new("Pepe", 'furniture_tables_high_01_1', 'furniture_tables_high_01_0',
    'furniture_tables_high_01_2', 'furniture_tables_high_01_3')

  _table.player = player
  _table.name = "Pepe"

  _table.modData['need:Base.Plank'] = 6
  _table.modData['need:Base.Nails'] = 4
  _table.modData['xp:Woodwork'] = 5

  getCell():setDrag(_table, player)
end
