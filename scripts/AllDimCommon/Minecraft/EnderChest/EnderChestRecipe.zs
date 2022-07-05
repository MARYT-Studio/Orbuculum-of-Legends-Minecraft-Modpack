val e = <item:minecraft:ender_pearl>;
val c = <item:minecraft:chest>|<item:minecraft:trapped_chest>|<item:endergetic:poise_chest>|<item:endergetic:poise_trapped_chest>;

craftingTable.removeRecipe(<item:minecraft:ender_chest>);
craftingTable.addShaped("ender_chest", <item:minecraft:ender_chest>,
    [
        [e, e, e],
        [e, c, e],
        [e, e, e]
    ]
);