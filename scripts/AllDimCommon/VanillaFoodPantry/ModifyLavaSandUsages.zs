// Now lava sand is only used as fuel
craftingTable.removeRecipeByInput(<item:vanillafoodpantry:lava_sand>);
craftingTable.addShapeless("lava_sand_4_in_1", <item:vanillafoodpantry:pack_lava_sand>, [
    <item:vanillafoodpantry:lava_sand>,<item:vanillafoodpantry:lava_sand>,<item:vanillafoodpantry:lava_sand>, <item:vanillafoodpantry:lava_sand>
]);

// Make 1 lava bucket equals to 10 lava sands
val items = 200;
<item:vanillafoodpantry:lava_sand>.burnTime = 10 * items;
<item:vanillafoodpantry:pack_lava_sand>.burnTime = 40 * items;
<item:vanillafoodpantry:lava_sand_block>.burnTime = 360 * items;

craftingTable.removeByName("vanillafoodpantry:lava/lava_sand");
craftingTable.addShapeless("lava_sand", <item:vanillafoodpantry:lava_sand> * 10, [
    <tag:items:minecraft:sand>, <tag:items:minecraft:sand>,
    <item:minecraft:lava_bucket>, <item:vanillafoodpantry:bit_pipette>.reuse()
]);