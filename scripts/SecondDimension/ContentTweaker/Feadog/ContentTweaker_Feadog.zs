#priority 9000
#loader contenttweaker
import mods.contenttweaker.item.ItemBuilder;
import mods.contenttweaker.item.advance.ItemBuilderAdvanced;
import crafttweaker.api.item.ItemGroup;
import crafttweaker.api.BracketHandlers;

// functional item groups
var functional_group = ItemGroup.create("ool_functional", () => BracketHandlers.getItem("contenttweaker:feadog"));

// Simple materials
new ItemBuilder().withItemGroup(functional_group).withType<ItemBuilderAdvanced>().build("feadog");