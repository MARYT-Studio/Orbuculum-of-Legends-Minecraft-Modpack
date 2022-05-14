var l = <item:minecraft:leather>;
var ca = <item:minecraft:brown_carpet>;
var cha = <item:minecraft:chain>;
var s = <item:minecraft:saddle>;

var nil = <item:minecraft:air>;

craftingTable.addShaped("saddle", s,
[
    [nil,ca,nil],
    [l,l,l],
    [nil,cha,nil]
],
null);