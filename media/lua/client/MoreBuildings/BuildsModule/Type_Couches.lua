local CraftingEnhancedCore = getModInstance()

CraftingEnhancedCore.tables["laboratoryTable"] = {
  nameID = "Laboratory table",
  displayName = getText("ContextMenu_LaboratoryTable"),
  tooltipTitle = getText("UI_LaboratoryTable_Title"),
  tooltipDescription = getText("UI_LaboratoryTable_Description"),
  tooltipTexture = "",
  icon = "",
  size = 2,
  sprites = {
    north = {
      "", ""
    },
    south = {
      "", ""
    },
    west = {
      "", ""
    },
    east = {
      "", ""
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
      type = "Base.MetalScrap",
      amount = 10,
    }
  },
}
