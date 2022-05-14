#priority 9000
#loader contenttweaker
import mods.contenttweaker.item.ItemBuilder;
import mods.contenttweaker.item.advance.ItemBuilderAdvanced;
import crafttweaker.api.item.ItemGroup;
import crafttweaker.api.BracketHandlers;

// Basic medics: moss-related items
var medics_group = ItemGroup.create("ool_medics", () => BracketHandlers.getItem("contenttweaker:crude_plaster"));

// Simple materials
new ItemBuilder().withItemGroup(medics_group).build("hemp_fabric");

// Functional Items
new ItemBuilder().withItemGroup(medics_group).withType<ItemBuilderAdvanced>().build("moss_clump");
new ItemBuilder().withItemGroup(medics_group).withType<ItemBuilderAdvanced>().build("crude_plaster");

