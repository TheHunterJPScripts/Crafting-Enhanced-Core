if not getModInstance then
  require('CraftingEnhancedCore/TableBuildMenu')
end

CraftingEnhancedCore = getModInstance()

CraftingEnhancedCore.tables = {
  {
    nameID = "Laboratory Table",
    displayName = getText("ContextMenu_LaboratoryTable"),
    tooltipTitle = getText("ContextMenu_LaboratoryTable"),
    tooltipDescription = getText("Tooltip_LaboratoryTable_Description"),
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
        amount = 8,
      }
    },
    completionSound = "BuildWoodenStructureLarge",
    maxTime = 200,
    container = {
      type = "crate",
      capacity = 5,
      positions = {
        west = 0,
        east = 0,
        north = 0,
        south = 0,
      }
    }
  },
  {
    nameID = "Tailoring Table",
    displayName = getText("ContextMenu_TailoringTable"),
    tooltipTitle = getText("ContextMenu_TailoringTable"),
    tooltipDescription = getText("Tooltip_TailoringTable_Description"),
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
        amount = 2,
      },
      {
        type = "Base.WoodenStick",
        amount = 4,
      },
      {
        type = "Base.Screws",
        amount = 6,
      },
      {
        type = "Base.ScrapMetal",
        amount = 5,
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
    displayName = getText("ContextMenu_MechanicTable"),
    tooltipTitle = getText("ContextMenu_MechanicTable"),
    tooltipDescription = getText("Tooltip_MechanicTable_Description"),
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
        type = "Base.SheetMetal",
        amount = 2,
      },
      {
        type = "Base.SmallSheetMetal",
        amount = 2,
      },
      {
        type = "Base.Screws",
        amount = 20,
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
      capacity = 10,
    }
  },
  {
    nameID = "Forge Table",
    displayName = getText("ContextMenu_ForgeTable"),
    tooltipTitle = getText("ContextMenu_ForgeTable"),
    tooltipDescription = getText("Tooltip_ForgeTable_Description"),
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
    requireTool = "Hammer",
    recipe = {
      {
        type = "Base.Stone",
        amount = 8,
      },
      {
        type = "Base.Log",
        amount = 1,
      },
      {
        type = "Base.ScrapMetal",
        amount = 10,
      },
      {
        type = "Base.UnusableMetal",
        amount = 15,
      }
    },
    completionSound = "BuildWoodenStructureLarge",
    maxTime = 200,
    container = {
      type = "crate",
      capacity = 4,
      positions = {
        west = 2,
        east = 2,
        north = 1,
        south = 1,
      }
    }
  },
  {
    nameID = "Armory table",
    displayName = getText("ContextMenu_ArmoryTable"),
    tooltipTitle = getText("ContextMenu_ArmoryTable"),
    tooltipDescription = getText("Tooltip_ArmoryTable_Description"),
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
        amount = 30,
      },
      {
        type = "Base.MetalBar",
        amount = 5,
      }
    },
    completionSound = "BuildWoodenStructureLarge",
    maxTime = 200,
    container = {
      type = "crate",
      capacity = 5,
      positions = {
        west = 0,
        east = 0,
        north = 0,
        south = 0,
      }
    }
  },
}
