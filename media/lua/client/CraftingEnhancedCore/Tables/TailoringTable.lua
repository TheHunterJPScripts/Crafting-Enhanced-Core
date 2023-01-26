if not getModInstance then
    require('CraftingEnhancedCore/TableBuildMenu')
end

CraftingEnhancedCore = getModInstance()

CraftingEnhancedCore.tables["tailoringTable"] = {
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
}
