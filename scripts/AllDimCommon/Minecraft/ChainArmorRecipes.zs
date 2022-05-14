var h = <item:minecraft:chainmail_helmet>;
var c = <item:minecraft:chainmail_chestplate>;
var l = <item:minecraft:chainmail_leggings>;
var b = <item:minecraft:chainmail_boots>;

var lf = <item:minecraft:leather>|<item:contenttweaker:hemp_fabric>;
var cha = <item:minecraft:chain>;
var nil = <item:minecraft:air>;

craftingTable.addShaped("chain_helmet", h,
[
    [cha,lf,cha],
    [cha,nil,cha]
],
null);

craftingTable.addShaped("chain_chest", c,
[
    [lf,nil,lf],
    [cha,lf,cha],
    [cha,cha,cha]
],
null);

craftingTable.addShaped("chain_leg", l,
[
    [lf,lf,lf],
    [cha,nil,cha],
    [cha,nil,cha]
],
null);

craftingTable.addShaped("chain_boot", b,
[
    [lf,nil,lf],
    [cha,nil,cha]
],
null);