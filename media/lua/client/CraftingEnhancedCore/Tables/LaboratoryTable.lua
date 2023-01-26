if not getModInstance then
    require('CraftingEnhancedCore/TableBuildMenu')
end

CraftingEnhancedCore = getModInstance()

CraftingEnhancedCore.tables["laboratoryTable"] = {
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
}
