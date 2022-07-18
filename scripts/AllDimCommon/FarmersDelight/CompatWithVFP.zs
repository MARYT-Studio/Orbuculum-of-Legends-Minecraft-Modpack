import mods.farmersdelight.CuttingBoard;

// Now FD pumpkin slices cannot turn into seeds
craftingTable.removeByName("farmersdelight:pumpkin_seeds_from_slice");

// 9 FD pumpkin slices for 1 pumpkin
craftingTable.removeByName("farmersdelight:pumpkin_from_slices");
craftingTable.addShaped("pumpkin_slices_9_to_1", <item:minecraft:pumpkin>, [
    [<item:farmersdelight:pumpkin_slice>, <item:farmersdelight:pumpkin_slice>, <item:farmersdelight:pumpkin_slice>],
    [<item:farmersdelight:pumpkin_slice>, <item:farmersdelight:pumpkin_slice>, <item:farmersdelight:pumpkin_slice>],
    [<item:farmersdelight:pumpkin_slice>, <item:farmersdelight:pumpkin_slice>, <item:farmersdelight:pumpkin_slice>]
]);

// 1 pumpkin slice into 9 pieces
<recipetype:farmersdelight:cutting>.removeRecipe(<item:farmersdelight:pumpkin_slice>);
<recipetype:farmersdelight:cutting>.addRecipe("pumpkin_into_slices", <item:minecraft:pumpkin>, [<item:farmersdelight:pumpkin_slice> * 9], <tag:items:farmersdelight:straw_harvesters>, "minecraft:block.pumpkin.carve");