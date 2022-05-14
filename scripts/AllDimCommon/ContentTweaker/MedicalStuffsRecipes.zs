// Materials
var h = <tag:items:forge:crops/hemp>;
var f = <item:contenttweaker:hemp_fabric>;
var m = <item:contenttweaker:moss_clump>;
var c = <item:contenttweaker:crude_plaster>;
// Air
var nil = <item:minecraft:air>;

craftingTable.addShaped("fabric", f * 4,
[
    [h,h],
    [h,h]
],
null);
craftingTable.addShaped("crude_plaster", c * 4,
[
    [nil,nil,f],
    [nil,m,nil],
    [f,nil,nil]
],
null);