// Item Tags
<tag:items:forge:crops/tea>.add([<item:tea_kettle:tea_leaf>]);

// Green Tea Bag for SimplyTea
craftingTable.removeRecipe(<item:simplytea:teabag_green>);
craftingTable.addShapeless("green_tea_bag", <item:simplytea:teabag_green>, [<item:simplytea:teabag>, <tag:items:forge:crops/tea>, <tag:items:forge:crops/tea>], null);

// Black Tea Bag for SimplyTea
val blackTeaLeaf = <item:simplytea:black_tea>|<item:tea_kettle:black_tea_leaf>;
craftingTable.removeRecipe(<item:simplytea:teabag_black>);
craftingTable.addShapeless("black_tea_bag", <item:simplytea:teabag_black>, [<item:simplytea:teabag>, blackTeaLeaf, blackTeaLeaf], null);

// Green Tea Compat
recipes.removeRecipe(<item:tea_kettle:green_tea>);
recipes.addJSONRecipe("teakettle_green_tea", {
    type: "tea_kettle:cup_drink",
	catalyst: <tag:items:tea_kettle:boiling_kettles>,
	ingredients: [<tag:items:forge:crops/tea>],
	result: "tea_kettle:green_tea"
 });

// Black Tea Compat
recipes.removeRecipe(<item:tea_kettle:black_tea>);
recipes.addJSONRecipe("teakettle_black_tea", {
    type: "tea_kettle:cup_drink",
	catalyst: <tag:items:tea_kettle:boiling_kettles>,
	ingredients: [blackTeaLeaf],
	result: "tea_kettle:black_tea"
 });