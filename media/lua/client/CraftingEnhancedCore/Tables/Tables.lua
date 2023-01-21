if not getModInstance then
  require('CraftingEnhancedCore/TableBuildMenu')
end

CraftingEnhancedCore = getModInstance()

CraftingEnhancedCore.tables = {
  {
    nameID = "Laboratory table",
    displayName = getText("ContextMenu_LaboratoryTable"),
    tooltipTitle = getText("UI_LaboratoryTable_Title"),
    tooltipDescription = getText("UI_LaboratoryTable_Description"),
    tooltipTexture = "furniture_seating_indoor_03_32",
    icon = "",
    size = 2,
    sprites = {
      north = {
        "furniture_seating_indoor_03_38", "furniture_seating_indoor_03_39"
      },
      south = {
        "furniture_seating_indoor_03_34", "furniture_seating_indoor_03_35"
      },
      west = {
        "furniture_seating_indoor_03_32", "furniture_seating_indoor_03_33"
      },
      east = {
        "furniture_seating_indoor_03_37", "furniture_seating_indoor_03_36"
      }
    },
    requireTool = "Screwdriver",
    recipe = {
      {
        type = "Base.Plank",
        amount = 4,
      },
      {
        type = "Base.Screws",
        amount = 10,
      },
      {
        type = "Base.ScrapMetal",
        amount = 10,
      }
    }
  },
  {
    nameID = "Laboratory table 2",
    displayName = getText("ContextMenu_LaboratoryTable"),
    tooltipTitle = getText("UI_LaboratoryTable_Title"),
    tooltipDescription = getText("UI_LaboratoryTable_Description"),
    tooltipTexture = "furniture_seating_indoor_03_32",
    icon = "",
    size = 2,
    sprites = {
      north = {
        "furniture_seating_indoor_03_38", "furniture_seating_indoor_03_39"
      },
      south = {
        "furniture_seating_indoor_03_34", "furniture_seating_indoor_03_35"
      },
      west = {
        "furniture_seating_indoor_03_32", "furniture_seating_indoor_03_33"
      },
      east = {
        "furniture_seating_indoor_03_37", "furniture_seating_indoor_03_36"
      }
    },
    requireTool = "Screwdriver",
    recipe = {
      {
        type = "Base.Plank",
        amount = 4,
      },
      {
        type = "Base.Screws",
        amount = 10,
      },
      {
        type = "Base.ScrapMetal",
        amount = 10,
      }
    }
  },
}
