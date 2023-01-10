local original_menu = ISBuildMenu.doBuildMenu

function ISBuildMenu.doBuildMenu(player, context, worldobjects, test)
    print("HELLOOOPEPEP")
    original_menu(player, context, worldobjects, test)
end
