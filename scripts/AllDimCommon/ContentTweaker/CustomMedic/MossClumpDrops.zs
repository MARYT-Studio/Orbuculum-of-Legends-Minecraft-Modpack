import crafttweaker.api.loot.conditions.LootConditionBuilder;
import crafttweaker.api.loot.conditions.vanilla.MatchTool;
import crafttweaker.api.loot.conditions.vanilla.WeatherCheck;
import crafttweaker.api.loot.conditions.crafttweaker.Not;
import crafttweaker.api.loot.conditions.vanilla.BlockStateProperty;
import crafttweaker.api.loot.modifiers.CommonLootModifiers;

import crafttweaker.api.blocks.MCBlock;

val grass_types as MCBlock[] = [
    <block:minecraft:grass>,
    <block:minecraft:fern>,
    <block:minecraft:tall_grass>,
    <block:minecraft:large_fern>
];

var index as int = 0;

for grass in grass_types {
    loot.modifiers.register(
        "moss_clump_drops" + index,
        LootConditionBuilder.create()
            .add<BlockStateProperty>(condition => {
                condition.withBlock(grass);
            }),
        CommonLootModifiers.addWithChance(<item:contenttweaker:moss_clump> % 40)
    );
    loot.modifiers.register(
        "moss_clump_drops_rain" + index,
        LootConditionBuilder.create()
            // If it's rainy, mosses grow fastly, and you are more likely to get moss clumps.
            .add<WeatherCheck>(condition => {
                condition.withRain();
            })
            .add<BlockStateProperty>(condition => {
                condition.withBlock(grass);
            }),
        CommonLootModifiers.clearing(CommonLootModifiers.addWithRandomAmount(<item:contenttweaker:moss_clump>, 1, 4))
    );
    index = index + 1;
}
