if not getModInstance then
    require('CraftingEnhancedCore/TableBuildMenu')
end

CraftingEnhancedCore = getModInstance()

CraftingEnhancedCore.tables["forge"] =
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
}
