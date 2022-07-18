val s = <tag:items:forge:cobblestone>|<tag:items:minecraft:stone_tool_materials>;
val n = <item:minecraft:gold_nugget>|<item:minecraft:iron_nugget>|<item:aquaculture:neptunium_nugget>;

craftingTable.removeRecipe(<item:kaleido:mallet>);
craftingTable.addShaped("mallet", <item:kaleido:mallet>, [
    [s,n, s],
    [<item:minecraft:air>, <tag:items:forge:rods/wooden>, <item:minecraft:air>],
    [<item:minecraft:air>, <tag:items:forge:rods/wooden>, <item:minecraft:air>]
]);

craftingTable.removeRecipe(<item:kaleido:chisel>);
craftingTable.addShaped("chisel", <item:kaleido:chisel>, [
    [<item:minecraft:air>, n, <item:minecraft:air>],
    [<item:minecraft:air>, n, <item:minecraft:air>],
    [<item:minecraft:air>, <tag:items:forge:rods/wooden>, <item:minecraft:air>]
]);