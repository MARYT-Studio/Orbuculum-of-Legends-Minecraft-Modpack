// Conditions Builder
import crafttweaker.api.loot.conditions.LootConditionBuilder;
import crafttweaker.api.loot.conditions.vanilla.LootTableId;
import crafttweaker.api.loot.conditions.crafttweaker.Or;
import crafttweaker.api.loot.conditions.crafttweaker.Not;
import crafttweaker.api.loot.conditions.vanilla.LocationCheck;
// Modifier
import crafttweaker.api.loot.modifiers.CommonLootModifiers;
// Datatypes for magic
import crafttweaker.api.loot.LootContext;
import stdlib.List;
import crafttweaker.api.item.IItemStack;

// Remove these two loot tables below for any dimensions other than the 4th
// minecraft:gameplay/fishing/junk
// minecraft:gameplay/fishing/treasure

var fishingLootCondition = LootConditionBuilder.createInAnd(and => {
        and.add<Not>(not => {
            not.withCondition<LocationCheck>(condition => {
                condition.withLocationPredicate(predicate => {
                    predicate.withDimension(<resource:minecraft:overworld>);
                });
            });
        }).add<Or>(or => {
            or.add<LootTableId>(condition => {
                condition.withTableId(<resource:minecraft:gameplay/fishing/junk>);
            }).add<LootTableId>(condition => {
                condition.withTableId(<resource:minecraft:gameplay/fishing/treasure>);
            });
        });
    });

loot.modifiers.register("fishing_dimension_check", fishingLootCondition, CommonLootModifiers.clearLoot());
