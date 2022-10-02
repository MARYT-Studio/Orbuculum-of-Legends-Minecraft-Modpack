<block:minecraft:ender_chest>.addLootModifier("replace_enderchest_drops", (loots, currentContext) => {
    return (currentContext.tool.getEnchantmentLevel(<enchantment:minecraft:silk_touch>) == 0) ? [<item:minecraft:chest>] : [<item:minecraft:ender_chest>];
});
