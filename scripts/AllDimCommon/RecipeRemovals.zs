import crafttweaker.api.item.IItemStack;

val unused_items as IItemStack[] = [
    // From DruidCraft
    <item:druidcraft:debug>,
    <item:druidcraft:knife>,
    // From DannysExpansion
    <item:dannys_expansion:workbench>
];

val wip_items as IItemStack[] = [
    // From DruidCraft
    <item:druidcraft:crushed_fiery_glass>,
    <item:druidcraft:tempered_fiery_glass>,
    <item:druidcraft:brightstone>,
    <item:druidcraft:blazing_steel>,
    <item:druidcraft:heart_of_blaze>,
    <item:druidcraft:nether_fiery_glass_ore>,
    <item:druidcraft:brightstone_ore>,
    <item:druidcraft:hellkiln>,
    <item:druidcraft:hellkiln_igniter>,
    // From DannysExpansion
    <item:dannys_expansion:blue_slime>,
    <item:dannys_expansion:ice_arrow>,
    <item:dannys_expansion:shotgun_shell>,
    <item:dannys_expansion:large_bullet>,
    <item:dannys_expansion:short_bullet>,
    <item:dannys_expansion:high_velocity_shotgun_shell>,
    <item:dannys_expansion:high_velocity_large_bullet>,
    <item:dannys_expansion:high_velocity_short_bullet>,
    <item:dannys_expansion:handgun>,
    <item:dannys_expansion:heavy_handgun>,
    <item:dannys_expansion:shotgun>,
    <item:dannys_expansion:aquatic_shotgun_shell>,
    <item:dannys_expansion:aquatic_short_bullet>,
    <item:dannys_expansion:aquatic_large_bullet>,
    <item:dannys_expansion:test_dummy>,
    <item:dannys_expansion:plant_matter>
];

val finders as IItemStack[] = [
    // Nature Compass is also a "finder"
    <item:naturescompass:naturescompass>,

    <item:adfinders:gem_finder>,
    <item:adfinders:mineral_finder>,
    <item:adfinders:metal_finder>
];

// Disallow crops to make dryers
furnace.removeRecipe(<item:vanillafoodpantry:drying_agent>);
val unused_dryers as IItemStack[] = [
    <item:vanillafoodpantry:drying_agent_unprocessed>,
    <item:vanillafoodpantry:drying_agent_unprocessed_ball>
];

for item in unused_items {
    craftingTable.removeRecipe(item);
    mods.jei.JEI.hideItem(item);
}

for item in wip_items {
    craftingTable.removeRecipe(item);
    mods.jei.JEI.hideItem(item);
}

for item in finders {
    craftingTable.removeRecipe(item);
}

for item in unused_dryers {
    craftingTable.removeRecipe(item);
    mods.jei.JEI.hideItem(item);
}

for item in loadedMods.getMod("kaleido").items {
    if (!((<item:kaleido:chisel>|<item:kaleido:mallet>).contains(item))) {
        craftingTable.removeRecipe(item);
        mods.jei.JEI.hideItem(item);
    }
}

// This item consume hungers for healing, which breaks the game balance.
// So we remove it here.
craftingTable.removeRecipe(<item:vanillafoodpantry:undead_wotsit>);
mods.jei.JEI.hideItem(<item:vanillafoodpantry:undead_wotsit>);
