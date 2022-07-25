import mods.jei.JEI;
import crafttweaker.api.item.IItemStack;
import crafttweaker.api.util.text.MCTextComponent;

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
<item:contenttweaker:fire_spear>.anyDamage().addTooltip("\u00A76\u00A7l\u201c\u9b45\u201d\u548c\u5b83\u7684\u5206\u8eab\u5bf9\u5176\u4e2d\u8574\u542b\u7684\u4e09\u6627\u771f\u706b\u683c\u5916\u6050\u60e7\u3002");

// Kaleido
// Original text:
// 左键点击方块，使其改变形状。
<item:kaleido:chisel>.anyDamage().addTooltip("\u5de6\u952e\u70b9\u51fb\u65b9\u5757\uff0c\u4f7f\u5176\u6539\u53d8\u5f62\u72b6\u3002");
// 右键点击方块，使其旋转方向。
<item:kaleido:mallet>.anyDamage().addTooltip("\u53f3\u952e\u70b9\u51fb\u65b9\u5757\uff0c\u4f7f\u5176\u65cb\u8f6c\u65b9\u5411\u3002");

// BossStage Special Foods
// TITLE
// Original text: §8§l[§6§lBOSS战特殊食物§8§l]
val title as string = "\u00A77\u00A7l[\u00A76\u00A7lBOSS\u6218\u7279\u6b8a\u98df\u7269\u00A77\u00A7l]";
// Original text: §8§l[§6§lBOSS战特殊食物,按住SHIFT查看详情§8§l]
val showTitle as string = "\u00A77\u00A7l[\u00A76\u00A7lBOSS\u6218\u7279\u6b8a\u98df\u7269,\u6309\u4f4f\u0053\u0048\u0049\u0046\u0054\u67e5\u770b\u8be6\u60c5\u00A77\u00A7l]";
// Original text: §8§l[§e适用世界§8§l]: §r
val effectiveWorld as string = "\u00A77\u00A7l[\u00A7e\u9002\u7528\u4e16\u754c\u00A77\u00A7l]: \u00A7f";
// Original text: 第一层 - 第七层
val worldNames as string[] = [
    "\u7b2c\u4e00\u5c42",
    "\u7b2c\u4e8c\u5c42",
    "\u7b2c\u4e09\u5c42",
    "\u7b2c\u56db\u5c42",
    "\u7b2c\u4e94\u5c42",
    "\u7b2c\u516d\u5c42",
    "\u7b2c\u4e03\u5c42"
];
// Original text: §8§l[§e效果§8§l]: §r
val effect as string = "\u00A77\u00A7l[\u00A7e\u6548\u679c\u00A77\u00A7l]: \u00A7r";
// Stage One
val stageOneFoods as string[IItemStack] = {
    // Original text:
    // 立即回复9颗心
    // 增加75秒饥饿V，立即回复4颗心，缓慢回复生命20秒钟
    // 增加45秒饥饿VI，45秒跳跃提升III，45秒速度I
    // 急迫6分钟效果，10秒力量I，45秒跳跃提升VI，1分钟速度I，1分钟夜视
    // 注视BOSS吃下它，可以使BOSS发光25秒钟，法术范围25格
    <item:crockpot:bone_stew>: "\u7acb\u5373\u56de\u590d9\u9897\u5fc3",
    <item:farmersdelight:mixed_salad>: "\u589e\u52a075\u79d2\u9965\u997fV\uff0c\u7acb\u5373\u56de\u590d4\u9897\u5fc3\uff0c\u7f13\u6162\u56de\u590d\u751f\u547d20\u79d2\u949f",
    <item:farmersdelight:cabbage_rolls>: "\u589e\u52a045\u79d2\u9965\u997fVI\uff0c45\u79d2\u8df3\u8dc3\u63d0\u5347III\uff0c45\u79d2\u901f\u5ea6I",
    <item:crockpot:salsa>: "\u6025\u8feb6\u5206\u949f\u6548\u679c\uff0c10\u79d2\u529b\u91cfI\uff0c45\u79d2\u8df3\u8dc3\u63d0\u5347VI\uff0c1\u5206\u949f\u901f\u5ea6I\uff0c1\u5206\u949f\u591c\u89c6",
    <item:minecraft:golden_carrot>: "\u6ce8\u89c6BOSS\u5403\u4e0b\u5b83\uff0c\u53ef\u4ee5\u4f7fBOSS\u53d1\u514925\u79d2\u949f\uff0c\u6cd5\u672f\u8303\u56f425\u683c"
};

for key, value in stageOneFoods {
    (key as IItemStack).addShiftTooltip(
        MCTextComponent.createStringTextComponent(title + "\n" + effectiveWorld + worldNames[0] + "\n" + effect + value),
        MCTextComponent.createStringTextComponent(showTitle)
    );
}

val milkRelatedItems as IItemStack[] = [
    <item:vanillafoodpantry:bowl_milk>,
    <item:vanillafoodpantry:bowl_honeymilk>,
    <item:vanillafoodpantry:milkdrink_plain>,
    <item:vanillafoodpantry:milkdrink_cocoa>,
    <item:vanillafoodpantry:milkdrink_sweet>,
    <item:vanillafoodpantry:milkdrink_pumpkin>,
    <item:vanillafoodpantry:milkdrink_klingon>,
    <item:vanillafoodpantry:milkdrink_apple>,
    <item:vanillafoodpantry:milkdrink_muscle_mix>,
    <item:vanillafoodpantry:milkdrink_blueberry>,
    <item:vanillafoodpantry:milkdrink_berry_mix>,
    <item:vanillafoodpantry:creamsoup_cactus>,
    <item:vanillafoodpantry:creamsoup_pumpkin>,
    <item:vanillafoodpantry:creamsoup_beet>,
    <item:vanillafoodpantry:creamsoup_mushroom>,
    <item:vanillafoodpantry:creamsoup_cheese>,
    <item:vanillafoodpantry:creamsoup_potato>,
    <item:vanillafoodpantry:creamsoup_carrot>,
    <item:vanillafoodpantry:creamsoup_tomato>,
    <item:vanillafoodpantry:portion_milk>
];

for milk in milkRelatedItems {
    // Original text: 你需要掌握游牧人的知识，才能使用这个物品。
    milk.addTooltip("\u4f60\u9700\u8981\u638c\u63e1\u6e38\u7267\u4eba\u7684\u77e5\u8bc6\uff0c\u624d\u80fd\u4f7f\u7528\u8fd9\u4e2a\u7269\u54c1\u3002");
}