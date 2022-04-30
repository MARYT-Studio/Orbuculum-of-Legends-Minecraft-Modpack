#priority 9000
#loader contenttweaker
import mods.contenttweaker.item.ItemBuilder;
import crafttweaker.api.item.ItemGroup;
import crafttweaker.api.BracketHandlers;

// Basic medics: moss-related items
var medics_group = ItemGroup.create("ool_medics", () => BracketHandlers.getItem("contenttweaker:crude_plaster"));
new ItemBuilder().withItemGroup(medics_group).build("moss_clump");
new ItemBuilder().withItemGroup(medics_group).build("crude_plaster");
