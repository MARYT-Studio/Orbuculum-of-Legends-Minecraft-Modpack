import crafttweaker.api.item.IItemStack;

val sifterProducts as IItemStack[] = [
    <item:tropicraft:black_pearl>,
    <item:tropicraft:frox_conch>,
    <item:tropicraft:love_tropics_shell>,
    <item:tropicraft:pab_shell>,
    <item:tropicraft:rube_nautilus>,
    <item:tropicraft:solonox_shell>,
    <item:tropicraft:white_pearl>
]; 
val notonlyProducedBySifter as IItemStack[] = [
    <item:tropicraft:turtle_shell>,
    <item:tropicraft:starfish>
];

var i as int = 0;
for product in sifterProducts {
    craftingTable.addShapeless("sifter_products_recycle" + i, <item:minecraft:bone_meal> * 3, [product], null);
    i += 1;
}

i = 0;
for product in notonlyProducedBySifter {
    craftingTable.addShapeless("not_only_sifter_products_recycle" + i, <item:minecraft:bone_meal>, [product], null);
    i += 1;
}
