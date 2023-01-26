if not getModInstance then
    require('CraftingEnhancedCore/TableBuildMenu')
end

CraftingEnhancedCore = getModInstance()

CraftingEnhancedCore.tables["armoryTable"] = {
    nameID = "Armory Table",
    displayName = getText("ContextMenu_ArmoryTable"),
    tooltipTitle = getText("ContextMenu_ArmoryTable"),
    tooltipDescription = getText("Tooltip_ArmoryTable_Description"),
    tooltipTexture = "core_workbenches_24",
    icon = "",
    size = 2,
    anim = "VehicleTrailer",
    craftingSound = "RepairWithWrench",
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
}
