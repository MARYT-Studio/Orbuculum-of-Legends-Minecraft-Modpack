var r = <item:druidcraft:rockroot>;
var a = <item:druidcraft:amber>;
var i = <item:minecraft:iron_ingot>;
craftingTable.removeRecipe(<item:minecraft:compass>);
craftingTable.removeRecipe(<item:minecraft:clock>);
craftingTable.addShaped("compass", <item:minecraft:compass>,
[
    [r,a,r],
    [a,i,a],
    [r,a,r]
],
null);
craftingTable.addShaped("clock", <item:minecraft:clock>,
[
    [a,r,a],
    [r,i,r],
    [a,r,a]
],
null);