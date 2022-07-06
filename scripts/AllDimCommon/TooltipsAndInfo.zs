import mods.jei.JEI;
import crafttweaker.api.item.IItemStack;

// Finders part
val finders as IItemStack[] = [
    // Nature Compass is also a "finder"
    <item:naturescompass:naturescompass>,
    // Gem finder does not have a recipe currently
    <item:adfinders:mineral_finder>,
    <item:adfinders:metal_finder>
];

val tooltip_parts as string[][] = [
    // Original Texts
    // ["树苗", "指南针"],
    // ["岩化根", "时钟"],
    // ["琥珀", "时钟"]
    ["\u6811\u82d7", "\u6307\u5357\u9488"],
    ["\u5ca9\u5316\u6839", "\u65f6\u949f"],
    ["\u7425\u73c0", "\u65f6\u949f"]
];

var index as int = 0;
for finder in finders {
    // Original text: §e精灵的礼物。
    finder.addTooltip("\u00a7e\u7cbe\u7075\u7684\u793c\u7269\u3002");
    // Original text for first param: 以()为信物召唤精灵，\n等待它将魔力注入你手中的()吧。
    // Original text for second param: §8按SHIFT查看更多
    finder.addShiftTooltip(
        "\u4ee5\u00a76" + tooltip_parts[index][0] + "\u00a7r\u4e3a\u4fe1\u7269\u53ec\u5524\u7cbe\u7075\uff0c" +
        "\u7b49\u5f85\u5b83\u5c06\u9b54\u529b\u6ce8\u5165\u4f60\u624b\u4e2d\u7684\u00a76"+ tooltip_parts[index][1] +"\u00a7r\u5427\u3002",
        "\u00a77\u6309 [SHIFT] \u67e5\u770b\u66f4\u591a"
    );
    // Original text: "精灵的礼物。", "用你的副手握持信物，", "主手捧起要祝福的物品，", "然后点击右键。", "大声呼喊我教给你的咒语，", "等待精灵将魔力注入它吧。"
    JEI.addInfo(finder, 
        [
            "\u7cbe\u7075\u7684\u793c\u7269\u3002",
            "\u7528\u4f60\u7684\u526f\u624b\u63e1\u6301\u4fe1\u7269\uff0c",
            "\u4e3b\u624b\u6367\u8d77\u8981\u795d\u798f\u7684\u7269\u54c1\uff0c",
            "\u7136\u540e\u70b9\u51fb\u53f3\u952e\u3002",
            "\u5927\u58f0\u547c\u558a\u6211\u6559\u7ed9\u4f60\u7684\u5492\u8bed\uff0c",
            "\u7b49\u5f85\u7cbe\u7075\u5c06\u9b54\u529b\u6ce8\u5165\u5b83\u5427\u3002"
        ]);
    index = index + 1;
}

// Original text: "在召唤精灵的仪式中，", "用你的副手握持信物，", "主手捧起这样东西，", "然后点击右键，", "精灵就会将魔力注入它。", "用任意树苗作为信物", "可以将它变为寻找群系的工具"。
JEI.addInfo(<item:minecraft:compass>, [
    "\u5728\u53ec\u5524\u7cbe\u7075\u7684\u4eea\u5f0f\u4e2d\uff0c",
    "\u7528\u4f60\u7684\u526f\u624b\u63e1\u6301\u4fe1\u7269\uff0c",
    "\u4e3b\u624b\u6367\u8d77\u8fd9\u6837\u4e1c\u897f\uff0c",
    "\u7136\u540e\u70b9\u51fb\u53f3\u952e\uff0c",
    "\u7cbe\u7075\u5c31\u4f1a\u5c06\u9b54\u529b\u6ce8\u5165\u5b83\u3002",
    "\u7528\u4efb\u610f\u6811\u82d7\u4f5c\u4e3a\u4fe1\u7269\uff0c",
    "\u53ef\u4ee5\u5c06\u5b83\u53d8\u4e3a\u5bfb\u627e\u7fa4\u7cfb\u7684\u5de5\u5177\u3002"
]);
// Original text: "在召唤精灵的仪式中，", "用你的副手握持信物，", "主手捧起这样东西，", "然后点击右键，", "精灵就会将魔力注入它。", "琥珀作为信物会使它变为金属探测器，", "而岩化根则会使它变为非金属的矿物探测器。"。
JEI.addInfo(<item:minecraft:clock>, [
    "\u5728\u53ec\u5524\u7cbe\u7075\u7684\u4eea\u5f0f\u4e2d\uff0c",
    "\u7528\u4f60\u7684\u526f\u624b\u63e1\u6301\u4fe1\u7269\uff0c",
    "\u4e3b\u624b\u6367\u8d77\u8fd9\u6837\u4e1c\u897f\uff0c",
    "\u7136\u540e\u70b9\u51fb\u53f3\u952e\uff0c",
    "\u7cbe\u7075\u5c31\u4f1a\u5c06\u9b54\u529b\u6ce8\u5165\u5b83\u3002",
    "\u7425\u73c0\u4f5c\u4e3a\u4fe1\u7269\u4f1a\u4f7f\u5b83\u53d8\u4e3a\u91d1\u5c5e\u63a2\u6d4b\u5668\uff0c",
    "\u800c\u5ca9\u5316\u6839\u5219\u4f1a\u4f7f\u5b83\u53d8\u4e3a\u975e\u91d1\u5c5e\u7684\u77ff\u7269\u63a2\u6d4b\u5668\u3002"
]);

// Fabric part
<item:contenttweaker:hemp_fabric>.addTooltip("a lightweight, experimental clothes-making materials for Minecraft.");
// Original text for first param: 原句出处自寻。
// Original text for second param: §8按SHIFT查看更多
<item:contenttweaker:hemp_fabric>.addShiftTooltip(
    "\u539f\u53e5\u51fa\u5904\u81ea\u5bfb\u3002",
    "\u00a77\u6309 [SHIFT] \u67e5\u770b\u66f4\u591a"
);

// Moss clump part
// Original text: 可以敷在伤口上疗伤，但效果不稳定。
<item:contenttweaker:moss_clump>.addTooltip("\u53ef\u4ee5\u6577\u5728\u4f24\u53e3\u4e0a\u7597\u4f24\uff0c\u4f46\u6548\u679c\u4e0d\u7a33\u5b9a\u3002");

// Crude Plaster part
// Original text: 比直接用苔藓要好。
<item:contenttweaker:crude_plaster>.addTooltip("\u6bd4\u76f4\u63a5\u7528\u82d4\u85d3\u8981\u597d\u3002");

val scythes as IItemStack[][] = [
    // Tier 1 scythes
    [
        <item:druidcraft:bone_sickle>,
        <item:druidcraft:wooden_sickle>,
        <item:druidcraft:stone_sickle>,
        <item:druidcraft:iron_sickle>,
        <item:druidcraft:gold_sickle>
    ],
    // Tier 2 scythes
    [
        <item:druidcraft:moonstone_sickle>,
        <item:druidcraft:diamond_sickle>
    ]
];

for index1 in 0 .. 2 {
    var radius as int = ((index1 == 0) ? 3 : 7);
    for scythe in scythes[index1] {
        // Original text: 握持在主手时，自动拾取半径 radius 格内所有的农作物和野生植物掉落物。
        scythe.addTooltip("\u63e1\u6301\u5728\u4e3b\u624b\u65f6\uff0c\u81ea\u52a8\u62fe\u53d6\u534a\u5f84" + radius + "\u683c\u5185\u6240\u6709\u7684\u519c\u4f5c\u7269\u548c\u91ce\u751f\u690d\u7269\u6389\u843d\u7269\u3002");
        scythe.addTooltip("\u6309\u4f4f[SHIFT]\u53ef\u4ee5\u6682\u65f6\u5173\u95ed\u81ea\u52a8\u62fe\u53d6\u529f\u80fd\u3002");
        JEI.addInfo(scythe, 
        // Original text:
        // 具有灵性的农具。
        // 当你的主手握着它时，
        // 它能自动拾取附近的农作物与野生植物的掉落物，
        // 放入你的背包。
        // 普通的镰刀拾取的范围稍小些，
        // 若是钻石或月长石打造的镰刀，
        // 则可以拾取相当大范围内的物品。
        [
            "\u5177\u6709\u7075\u6027\u7684\u519c\u5177\u3002",
            "\u5f53\u4f60\u7684\u4e3b\u624b\u63e1\u7740\u5b83\u65f6\uff0c",
            "\u5b83\u80fd\u81ea\u52a8\u62fe\u53d6\u9644\u8fd1\u7684\u519c\u4f5c\u7269\u4e0e\u91ce\u751f\u690d\u7269\u7684\u6389\u843d\u7269\uff0c\u653e\u5165\u4f60\u7684\u80cc\u5305\u3002",
            "\u666e\u901a\u7684\u9570\u5200\u62fe\u53d6\u7684\u8303\u56f4\u7a0d\u5c0f\u4e9b\uff0c",
            "\u82e5\u662f\u94bb\u77f3\u6216\u6708\u957f\u77f3\u6253\u9020\u7684\u9570\u5200\uff0c",
            "\u5219\u53ef\u4ee5\u62fe\u53d6\u76f8\u5f53\u5927\u8303\u56f4\u5185\u7684\u7269\u54c1\u3002"
        ]);
    }
}

// Fire Spear
// Original text:
// 朴实却神秘的火器，
// 有时能点燃敌人。

<item:contenttweaker:fire_spear>.anyDamage().addTooltip("\u6734\u5b9e\u5374\u795e\u79d8\u7684\u706b\u5668\uff0c");
<item:contenttweaker:fire_spear>.anyDamage().addTooltip("\u6709\u65f6\u80fd\u70b9\u71c3\u654c\u4eba\u3002");

// Kaleido
// Original text:
// 左键点击方块，使其改变形状。
<item:kaleido:chisel>.anyDamage().addTooltip("\u5de6\u952e\u70b9\u51fb\u65b9\u5757\uff0c\u4f7f\u5176\u6539\u53d8\u5f62\u72b6\u3002");
// 右键点击方块，使其旋转方向。
<item:kaleido:mallet>.anyDamage().addTooltip("\u53f3\u952e\u70b9\u51fb\u65b9\u5757\uff0c\u4f7f\u5176\u65cb\u8f6c\u65b9\u5411\u3002");
