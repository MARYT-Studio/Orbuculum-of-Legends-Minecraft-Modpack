import crafttweaker.api.item.IItemStack;

val portables as IItemStack[] = [
    <item:portablecraft:anvil1>,
    <item:portablecraft:blast_furnace1>,
    <item:portablecraft:brewing_stand1>,
    <item:portablecraft:chest1>,
    <item:portablecraft:craft1>,
    <item:portablecraft:enchantment_edit>,
    <item:portablecraft:enchantment_table1>,
    <item:portablecraft:ender_chest1>,
    <item:portablecraft:furnace1>,
    <item:portablecraft:portable>,
    <item:portablecraft:smithing_table1>,
    <item:portablecraft:smoker1>,
    <item:portablecraft:stone_cutter1>
];
val used_portables as IItemStack[] = [
    <item:portablecraft:craft1>,
    <item:portablecraft:ender_chest1>
];

for item in portables {
    craftingTable.removeRecipe(item);
    if(!(item in used_portables)) {
        mods.jei.JEI.hideItem(item);
    }
}

craftingTable.addShapedMirrored("portable_crafting_table", <item:portablecraft:craft1>,
[
    [<item:minecraft:air>, <item:minecraft:crafting_table>],
    [<tag:items:forge:rods/wooden>,<item:minecraft:air>]
],
null);

// TODO: Portable Enderchest recipe