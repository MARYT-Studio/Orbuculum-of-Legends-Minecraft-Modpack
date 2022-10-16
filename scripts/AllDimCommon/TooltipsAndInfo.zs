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
    ["树苗", "指南针"],
    ["岩化根", "时钟"],
    ["琥珀", "时钟"]
];

var index as int = 0;
for finder in finders {
    finder.addTooltip("§e精灵的礼物。");
    finder.addShiftTooltip(
        "以§6" + tooltip_parts[index][0] + "§r为信物召唤精灵，" +
        "等待它将魔力注入你手中的§6"+ tooltip_parts[index][1] +"§r吧。",
        "§7按 [SHIFT] 查看更多"
    );
    JEI.addInfo(finder, 
        [
            "精灵的礼物。",
            "用你的副手握持信物，",
            "主手捧起要祝福的物品，",
            "然后点击右键。",
            "大声呼喊我教给你的咒语，",
            "等待精灵将魔力注入它吧。"
        ]);
    index = index + 1;
}
JEI.addInfo(<item:minecraft:compass>, [
    "在召唤精灵的仪式中，",
    "用你的副手握持信物，",
    "主手捧起这样东西，",
    "然后点击右键，",
    "精灵就会将魔力注入它。",
    "用任意树苗作为信物，",
    "可以将它变为寻找群系的工具。"
]);
JEI.addInfo(<item:minecraft:clock>, [
    "在召唤精灵的仪式中，",
    "用你的副手握持信物，",
    "主手捧起这样东西，",
    "然后点击右键，",
    "精灵就会将魔力注入它。",
    "琥珀作为信物会使它变为金属探测器，",
    "而岩化根则会使它变为非金属的矿物探测器。"
]);

// Fabric part
<item:contenttweaker:hemp_fabric>.addTooltip("a lightweight, experimental clothes-making materials for Minecraft.");
<item:contenttweaker:hemp_fabric>.addShiftTooltip(
    "原句出处自寻。",
    "§7按 [SHIFT] 查看更多"
);

// Moss clump part
<item:contenttweaker:moss_clump>.addTooltip("可以敷在伤口上疗伤，但效果不稳定。");

// Crude Plaster part
<item:contenttweaker:crude_plaster>.addTooltip("比直接用苔藓要好。");

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
        scythe.addTooltip("握持在主手时，自动拾取半径" + radius + "格内所有的农作物和野生植物掉落物。");
        scythe.addTooltip("按住[SHIFT]可以暂时关闭自动拾取功能。");
        JEI.addInfo(scythe, 
        [
            "具有灵性的农具。",
            "当你的主手握着它时，",
            "它能自动拾取附近的农作物与野生植物的掉落物，放入你的背包。",
            "普通的镰刀拾取的范围稍小些，",
            "若是钻石或月长石打造的镰刀，",
            "则可以拾取相当大范围内的物品。"
        ]);
    }
}

<item:contenttweaker:fire_spear>.anyDamage().addTooltip("朴实却神秘的火器，");
<item:contenttweaker:fire_spear>.anyDamage().addTooltip("有时能点燃敌人。");
<item:contenttweaker:fire_spear>.anyDamage().addTooltip("§6§l“魅”和它的分身对其中蕴含的三昧真火格外恐惧。");

// Kaleido
<item:kaleido:chisel>.anyDamage().addTooltip("左键点击方块，使其改变形状。");
<item:kaleido:mallet>.anyDamage().addTooltip("右键点击方块，使其旋转方向。");

// BossStage Special Foods
// TITLE
val title as string = "§7§l[§6§lBOSS战特殊食物§7§l]";
val showTitle as string = "§7§l[§6§lBOSS战特殊食物,按住SHIFT查看详情§7§l]";
val effectiveWorld as string = "§7§l[§e适用世界§7§l]: §f";
val worldNames as string[] = [
    "第一层",
    "第二层",
    "第三层",
    "第四层",
    "第五层",
    "第六层",
    "第七层"
];
val effect as string = "§7§l[§e效果§7§l]: §r";
// Stage One
val stageOneFoods as string[IItemStack] = {
    <item:crockpot:bone_stew>: "立即回复9颗心",
    <item:farmersdelight:mixed_salad>: "增加75秒饥饿V，立即回复4颗心，缓慢回复生命20秒钟",
    <item:farmersdelight:cabbage_rolls>: "增加45秒饥饿VI，45秒跳跃提升III，45秒速度I",
    <item:crockpot:salsa>: "急迫6分钟效果，10秒力量I，45秒跳跃提升VI，1分钟速度I，1分钟夜视",
    <item:minecraft:golden_carrot>: "注视BOSS吃下它，可以使BOSS发光25秒钟，法术范围25格"
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
    milk.addTooltip("你需要掌握游牧人的知识，才能使用这个物品。");
}

// Functional Items Part
JEI.addInfo(<item:contenttweaker:feadog>,[
    "“§o哨笛被赋予了一项术式：",
    "§o它是指向我身边一小块空间的指针，",
    "§o只要吹响它，",
    "§o它便传送你丢在附近的物品到我这里。",
    "§o如若不慎丢失，可以再找我拿取，",
    "§o不过向你传送物品同样消耗我的法力，",
    "§o还请你多加爱惜才是。“",
    "—— 鳕鱼"
]);
<item:contenttweaker:feadog>.addTooltip("上面精致地刻着两行椰术咒文的小字");
<item:contenttweaker:feadog>.addTooltip("Item* feadog;");
<item:contenttweaker:feadog>.addTooltip("feadog = (Item*)malloc(sizeof(Item));");