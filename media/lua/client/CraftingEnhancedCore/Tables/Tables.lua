if not getModInstance then
  require('CraftingEnhancedCore/TableBuildMenu')
end

CraftingEnhancedCore = getModInstance()

CraftingEnhancedCore.tables = {
  {
    nameID = "Laboratory Table",
    displayName = getText("ContextMenu_LaboratoryTable"),
    tooltipTitle = getText("UI_LaboratoryTable_Title"),
    tooltipDescription = getText("UI_LaboratoryTable_Description"),
    tooltipTexture = "core_workbenches_1",
    icon = "",
    size = 2,
    sprites = {
      north = {
        "core_workbenches_2", "core_workbenches_3"
      },
      south = {
        "core_workbenches_6", "core_workbenches_7"
      },
      west = {
        "core_workbenches_0", "core_workbenches_1"
      },
      east = {
        "core_workbenches_4", "core_workbenches_5"
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
    },
    completionSound = "BuildWoodenStructureLarge",
    maxTime = 200,
    container = {
      type = "crate",
      capacity = 5,
      positions = {
        west = 1,
        east = 1,
        north = 2,
        south = 2,
      }
    }
  },
  {
    nameID = "Tailoring Table",
    displayName = getText("ContextMenu_LaboratoryTable"),
    tooltipTitle = getText("UI_LaboratoryTable_Title"),
    tooltipDescription = getText("UI_LaboratoryTable_Description"),
    tooltipTexture = "core_workbenches_8",
    icon = "",
    size = 1,
    sprites = {
      north = {
        "core_workbenches_9"
      },
      south = {
        "core_workbenches_11"
      },
      west = {
        "core_workbenches_8"
      },
      east = {
        "core_workbenches_10"
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
    },
    completionSound = "BuildWoodenStructureLarge",
    maxTime = 200,
    container = {
      type = "crate",
      capacity = 5,
    }
  },
  {
    nameID = "Mechanic Table",
    displayName = getText("ContextMenu_LaboratoryTable"),
    tooltipTitle = getText("UI_LaboratoryTable_Title"),
    tooltipDescription = getText("UI_LaboratoryTable_Description"),
    tooltipTexture = "core_workbenches_12",
    icon = "",
    size = 1,
    sprites = {
      north = {
        "core_workbenches_13"
      },
      south = {
        "core_workbenches_15"
      },
      west = {
        "core_workbenches_12"
      },
      east = {
        "core_workbenches_14"
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
    },
    completionSound = "BuildWoodenStructureLarge",
    maxTime = 200,
    container = {
      type = "crate",
      capacity = 5,
    }
  },
  {
    nameID = "Forge Table",
    displayName = getText("ContextMenu_LaboratoryTable"),
    tooltipTitle = getText("UI_LaboratoryTable_Title"),
    tooltipDescription = getText("UI_LaboratoryTable_Description"),
    tooltipTexture = "core_workbenches_16",
    icon = "",
    size = 2,
    sprites = {
      north = {
        "core_workbenches_18", "core_workbenches_19"
      },
      south = {
        "core_workbenches_22", "core_workbenches_23"
      },
      west = {
        "core_workbenches_16", "core_workbenches_17"
      },
      east = {
        "core_workbenches_20", "core_workbenches_21"
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
    },
    completionSound = "BuildWoodenStructureLarge",
    maxTime = 200,
    container = {
      type = "crate",
      capacity = 5,
      positions = {
        west = 1,
        east = 1,
        north = 2,
        south = 2,
      }
    }
  },
  {
    nameID = "Armory table",
    displayName = getText("ContextMenu_LaboratoryTable"),
    tooltipTitle = getText("UI_LaboratoryTable_Title"),
    tooltipDescription = getText("UI_LaboratoryTable_Description"),
    tooltipTexture = "core_workbenches_24",
    icon = "",
    size = 2,
    sprites = {
      north = {
        "core_workbenches_26", "core_workbenches_27"
      },
      south = {
        "core_workbenches_30", "core_workbenches_31"
      },
      west = {
        "core_workbenches_24", "core_workbenches_25"
      },
      east = {
        "core_workbenches_28", "core_workbenches_29"
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
    },
    completionSound = "BuildWoodenStructureLarge",
    maxTime = 200,
    container = {
      type = "crate",
      capacity = 5,
      positions = {
        west = 1,
        east = 2,
        north = 2,
        south = 1,
      }
    }
  },
}
