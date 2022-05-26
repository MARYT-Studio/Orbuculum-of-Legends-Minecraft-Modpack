#priority 9000
#loader contenttweaker
import mods.contenttweaker.item.ItemBuilder;
import mods.contenttweaker.item.tool.ItemBuilderTool;
new ItemBuilder()
    .withMaxDamage(200)
    .withItemGroup(<itemGroup:combat>)
    .withType<ItemBuilderTool>()
    .withToolType(<tooltype:club>, -1, 1.0f)
    .withAttackSpeed(-3.0d)
    .withAttackDamage(3.0f)
    .withDurabilityCostAttack(1)
    .withDurabilityCostMining(2)
    .build("fire_spear");
