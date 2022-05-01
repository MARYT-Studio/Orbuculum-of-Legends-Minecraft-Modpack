var h = <tag:items:forge:crops/hemp>;
var m = <item:contenttweaker:moss_clump>;
var f = <item:contenttweaker:hemp_fabric>;
var c = <item:contenttweaker:crude_plaster>;
var nil = <item:minecraft:air>;

craftingTable.addShaped("fabric", f,
[
    [h,h],
    [h,h]
],
null);
craftingTable.addShaped("crude_plaster", c,
[
    [nil,nil,f],
    [nil,m,nil],
    [f,nil,nil]
],
null);