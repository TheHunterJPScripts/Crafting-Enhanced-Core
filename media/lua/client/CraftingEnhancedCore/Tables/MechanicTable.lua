if not getModInstance then
    require('CraftingEnhancedCore/TableBuildMenu')
end

CraftingEnhancedCore = getModInstance()

CraftingEnhancedCore.tables["mechanicTable"] = {
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
}
