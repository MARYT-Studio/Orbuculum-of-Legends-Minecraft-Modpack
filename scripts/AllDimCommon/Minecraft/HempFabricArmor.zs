import crafttweaker.api.data.IData;

var f = <item:contenttweaker:hemp_fabric>;
var data as IData = {
        display: {
            Lore:[
                '[{"text":"§r和皮的一样好。","italic":false, "color": "white"}]'
            ]
        }
    };

var h = <item:minecraft:leather_helmet>.withTag(data);
var c = <item:minecraft:leather_chestplate>.withTag(data);
var l = <item:minecraft:leather_leggings>.withTag(data);
var b = <item:minecraft:leather_boots>.withTag(data);

var nil = <item:minecraft:air>;

craftingTable.addShaped("fabric_helmet", h,
[
    [f,f,f],
    [f,nil,f]
],
null);

craftingTable.addShaped("fabric_chest", c,
[
    [f,nil,f],
    [f,f,f],
    [f,f,f]
],
null);

craftingTable.addShaped("fabric_leg", l,
[
    [f,f,f],
    [f,nil,f],
    [f,nil,f]
],
null);

craftingTable.addShaped("fabric_boot", b,
[
    [f,nil,f],
    [f,nil,f]
],
null);
