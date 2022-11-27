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
    ["\u6811\u82D7", "\u6307\u5357\u9488"],
    ["\u5CA9\u5316\u6839", "\u65F6\u949F"],
    ["\u7425\u73C0", "\u65F6\u949F"]
];

var index as int = 0;
for finder in finders {
    finder.addTooltip("\u00A7e\u7CBE\u7075\u7684\u793C\u7269\u3002");
    finder.addShiftTooltip(
        "\u4EE5\u00A76" + tooltip_parts[index][0] + "\u00A7r\u4E3A\u4FE1\u7269\u53EC\u5524\u7CBE\u7075\uFF0C" +
        "\u7B49\u5F85\u5B83\u5C06\u9B54\u529B\u6CE8\u5165\u4F60\u624B\u4E2D\u7684\u00A76"+ tooltip_parts[index][1] +"\u00A7r\u5427\u3002",
        "\u00A77\u6309 [SHIFT] \u67E5\u770B\u66F4\u591A"
    );
    JEI.addInfo(finder, 
        [
            "\u7CBE\u7075\u7684\u793C\u7269\u3002",
            "\u7528\u4F60\u7684\u526F\u624B\u63E1\u6301\u4FE1\u7269\uFF0C",
            "\u4E3B\u624B\u6367\u8D77\u8981\u795D\u798F\u7684\u7269\u54C1\uFF0C",
            "\u7136\u540E\u70B9\u51FB\u53F3\u952E\u3002",
            "\u5927\u58F0\u547C\u558A\u6211\u6559\u7ED9\u4F60\u7684\u5492\u8BED\uFF0C",
            "\u7B49\u5F85\u7CBE\u7075\u5C06\u9B54\u529B\u6CE8\u5165\u5B83\u5427\u3002"
        ]);
    index = index + 1;
}
JEI.addInfo(<item:minecraft:compass>, [
    "\u5728\u53EC\u5524\u7CBE\u7075\u7684\u4EEA\u5F0F\u4E2D\uFF0C",
    "\u7528\u4F60\u7684\u526F\u624B\u63E1\u6301\u4FE1\u7269\uFF0C",
    "\u4E3B\u624B\u6367\u8D77\u8FD9\u6837\u4E1C\u897F\uFF0C",
    "\u7136\u540E\u70B9\u51FB\u53F3\u952E\uFF0C",
    "\u7CBE\u7075\u5C31\u4F1A\u5C06\u9B54\u529B\u6CE8\u5165\u5B83\u3002",
    "\u7528\u4EFB\u610F\u6811\u82D7\u4F5C\u4E3A\u4FE1\u7269\uFF0C",
    "\u53EF\u4EE5\u5C06\u5B83\u53D8\u4E3A\u5BFB\u627E\u7FA4\u7CFB\u7684\u5DE5\u5177\u3002"
]);
JEI.addInfo(<item:minecraft:clock>, [
    "\u5728\u53EC\u5524\u7CBE\u7075\u7684\u4EEA\u5F0F\u4E2D\uFF0C",
    "\u7528\u4F60\u7684\u526F\u624B\u63E1\u6301\u4FE1\u7269\uFF0C",
    "\u4E3B\u624B\u6367\u8D77\u8FD9\u6837\u4E1C\u897F\uFF0C",
    "\u7136\u540E\u70B9\u51FB\u53F3\u952E\uFF0C",
    "\u7CBE\u7075\u5C31\u4F1A\u5C06\u9B54\u529B\u6CE8\u5165\u5B83\u3002",
    "\u7425\u73C0\u4F5C\u4E3A\u4FE1\u7269\u4F1A\u4F7F\u5B83\u53D8\u4E3A\u91D1\u5C5E\u63A2\u6D4B\u5668\uFF0C",
    "\u800C\u5CA9\u5316\u6839\u5219\u4F1A\u4F7F\u5B83\u53D8\u4E3A\u975E\u91D1\u5C5E\u7684\u77FF\u7269\u63A2\u6D4B\u5668\u3002"
]);

// Fabric part
<item:contenttweaker:hemp_fabric>.addTooltip("a lightweight, experimental clothes-making materials for Minecraft.");
<item:contenttweaker:hemp_fabric>.addShiftTooltip(
    "\u539F\u53E5\u51FA\u5904\u81EA\u5BFB\u3002",
    "\u00A77\u6309 [SHIFT] \u67E5\u770B\u66F4\u591A"
);

// Moss clump part
<item:contenttweaker:moss_clump>.addTooltip("\u53EF\u4EE5\u6577\u5728\u4F24\u53E3\u4E0A\u7597\u4F24\uFF0C\u4F46\u6548\u679C\u4E0D\u7A33\u5B9A\u3002");

// Crude Plaster part
<item:contenttweaker:crude_plaster>.addTooltip("\u6BD4\u76F4\u63A5\u7528\u82D4\u85D3\u8981\u597D\u3002");

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
        scythe.addTooltip("\u63E1\u6301\u5728\u4E3B\u624B\u65F6\uFF0C\u81EA\u52A8\u62FE\u53D6\u534A\u5F84" + radius + "\u683C\u5185\u6240\u6709\u7684\u519C\u4F5C\u7269\u548C\u91CE\u751F\u690D\u7269\u6389\u843D\u7269\u3002");
        scythe.addTooltip("\u6309\u4F4F[SHIFT]\u53EF\u4EE5\u6682\u65F6\u5173\u95ED\u81EA\u52A8\u62FE\u53D6\u529F\u80FD\u3002");
        JEI.addInfo(scythe, 
        [
            "\u5177\u6709\u7075\u6027\u7684\u519C\u5177\u3002",
            "\u5F53\u4F60\u7684\u4E3B\u624B\u63E1\u7740\u5B83\u65F6\uFF0C",
            "\u5B83\u80FD\u81EA\u52A8\u62FE\u53D6\u9644\u8FD1\u7684\u519C\u4F5C\u7269\u4E0E\u91CE\u751F\u690D\u7269\u7684\u6389\u843D\u7269\uFF0C\u653E\u5165\u4F60\u7684\u80CC\u5305\u3002",
            "\u666E\u901A\u7684\u9570\u5200\u62FE\u53D6\u7684\u8303\u56F4\u7A0D\u5C0F\u4E9B\uFF0C",
            "\u82E5\u662F\u94BB\u77F3\u6216\u6708\u957F\u77F3\u6253\u9020\u7684\u9570\u5200\uFF0C",
            "\u5219\u53EF\u4EE5\u62FE\u53D6\u76F8\u5F53\u5927\u8303\u56F4\u5185\u7684\u7269\u54C1\u3002"
        ]);
    }
}

<item:contenttweaker:fire_spear>.anyDamage().addTooltip("\u6734\u5B9E\u5374\u795E\u79D8\u7684\u706B\u5668\uFF0C");
<item:contenttweaker:fire_spear>.anyDamage().addTooltip("\u6709\u65F6\u80FD\u70B9\u71C3\u654C\u4EBA\u3002");
<item:contenttweaker:fire_spear>.anyDamage().addTooltip("\u00A76\u00A7l\u201C\u9B45\u201D\u548C\u5B83\u7684\u5206\u8EAB\u5BF9\u5176\u4E2D\u8574\u542B\u7684\u4E09\u6627\u771F\u706B\u683C\u5916\u6050\u60E7\u3002");

// Kaleido
<item:kaleido:chisel>.anyDamage().addTooltip("\u5DE6\u952E\u70B9\u51FB\u65B9\u5757\uFF0C\u4F7F\u5176\u6539\u53D8\u5F62\u72B6\u3002");
<item:kaleido:mallet>.anyDamage().addTooltip("\u53F3\u952E\u70B9\u51FB\u65B9\u5757\uFF0C\u4F7F\u5176\u65CB\u8F6C\u65B9\u5411\u3002");

// BossStage Special Foods
// TITLE
val title as string = "\u00A77\u00A7l[\u00A76\u00A7lBOSS\u6218\u7279\u6B8A\u98DF\u7269\u00A77\u00A7l]";
val showTitle as string = "\u00A77\u00A7l[\u00A76\u00A7lBOSS\u6218\u7279\u6B8A\u98DF\u7269,\u6309\u4F4FSHIFT\u67E5\u770B\u8BE6\u60C5\u00A77\u00A7l]";
val effectiveWorld as string = "\u00A77\u00A7l[\u00A7e\u9002\u7528\u4E16\u754C\u00A77\u00A7l]: \u00A7f";
val worldNames as string[] = [
    "\u7B2C\u4E00\u5C42",
    "\u7B2C\u4E8C\u5C42",
    "\u7B2C\u4E09\u5C42",
    "\u7B2C\u56DB\u5C42",
    "\u7B2C\u4E94\u5C42",
    "\u7B2C\u516D\u5C42",
    "\u7B2C\u4E03\u5C42"
];
val effect as string = "\u00A77\u00A7l[\u00A7e\u6548\u679C\u00A77\u00A7l]: \u00A7r";
// Stage One
val stageOneFoods as string[IItemStack] = {
    <item:crockpot:bone_stew>: "\u7ACB\u5373\u56DE\u590D9\u9897\u5FC3",
    <item:farmersdelight:mixed_salad>: "\u589E\u52A075\u79D2\u9965\u997FV\uFF0C\u7ACB\u5373\u56DE\u590D4\u9897\u5FC3\uFF0C\u7F13\u6162\u56DE\u590D\u751F\u547D20\u79D2\u949F",
    <item:farmersdelight:cabbage_rolls>: "\u589E\u52A045\u79D2\u9965\u997FVI\uFF0C45\u79D2\u8DF3\u8DC3\u63D0\u5347III\uFF0C45\u79D2\u901F\u5EA6I",
    <item:crockpot:salsa>: "\u6025\u8FEB6\u5206\u949F\u6548\u679C\uFF0C10\u79D2\u529B\u91CFI\uFF0C45\u79D2\u8DF3\u8DC3\u63D0\u5347VI\uFF0C1\u5206\u949F\u901F\u5EA6I\uFF0C1\u5206\u949F\u591C\u89C6",
    <item:minecraft:golden_carrot>: "\u6CE8\u89C6BOSS\u5403\u4E0B\u5B83\uFF0C\u53EF\u4EE5\u4F7FBOSS\u53D1\u514925\u79D2\u949F\uFF0C\u6CD5\u672F\u8303\u56F425\u683C"
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
    milk.addTooltip("\u4F60\u9700\u8981\u638C\u63E1\u6E38\u7267\u4EBA\u7684\u77E5\u8BC6\uFF0C\u624D\u80FD\u4F7F\u7528\u8FD9\u4E2A\u7269\u54C1\u3002");
}

// Functional Items Part
JEI.addInfo(<item:contenttweaker:feadog>,[
    "\u201C\u00A7o\u54E8\u7B1B\u88AB\u8D4B\u4E88\u4E86\u4E00\u9879\u672F\u5F0F\uFF1A",
    "\u00A7o\u5B83\u662F\u6307\u5411\u6211\u8EAB\u8FB9\u4E00\u5C0F\u5757\u7A7A\u95F4\u7684\u6307\u9488\uFF0C",
    "\u00A7o\u53EA\u8981\u5439\u54CD\u5B83\uFF0C",
    "\u00A7o\u5B83\u4FBF\u4F20\u9001\u4F60\u4E22\u5728\u9644\u8FD1\u7684\u7269\u54C1\u5230\u6211\u8FD9\u91CC\u3002",
    "\u00A7o\u5982\u82E5\u4E0D\u614E\u4E22\u5931\uFF0C\u53EF\u4EE5\u518D\u627E\u6211\u62FF\u53D6\uFF0C",
    "\u00A7o\u4E0D\u8FC7\u5411\u4F60\u4F20\u9001\u7269\u54C1\u540C\u6837\u6D88\u8017\u6211\u7684\u6CD5\u529B\uFF0C",
    "\u00A7o\u8FD8\u8BF7\u4F60\u591A\u52A0\u7231\u60DC\u624D\u662F\u3002\u201C",
    "\u2014\u2014 \u9CD5\u9C7C"
]);
<item:contenttweaker:feadog>.addTooltip("\u4E0A\u9762\u7CBE\u81F4\u5730\u523B\u7740\u4E24\u884C\u6930\u672F\u5492\u6587\u7684\u5C0F\u5B57");
<item:contenttweaker:feadog>.addTooltip("Item* feadog;");
<item:contenttweaker:feadog>.addTooltip("feadog = (Item*)malloc(sizeof(Item));");

// Tea Compat
val teaTooltips as string[] = [
    "\u4F7F\u7528\u8336\u5305\u6C8F\u7684\u888B\u6CE1\u8336\uFF0C\u53E3\u611F\u4E0A\u4E0E\u6563\u8336\u6C8F\u6210\u7684\u8336\u7565\u6709\u5DEE\u522B\u3002",
    "\u76F4\u63A5\u7528\u6563\u8336\u6C8F\u6210\u7684\u8336\uFF0C\u53E3\u611F\u4E0A\u4E0E\u888B\u6CE1\u8336\u7565\u6709\u5DEE\u522B\u3002"
];
<item:simplytea:cup_tea_black>.addTooltip(teaTooltips[0]);
<item:simplytea:cup_tea_green>.addTooltip(teaTooltips[0]);
<item:tea_kettle:green_tea>.addTooltip(teaTooltips[1]);
<item:tea_kettle:black_tea>.addTooltip(teaTooltips[1]);

// Shaka
val shaka as IItemStack[] = [
    <item:tropicraft:shaka_ore>,
    <item:tropicraft:shaka_ingot>,
    <item:tropicraft:shaka_block>
];
val shakaTooltip as string[] = [
    "\u5B83\u7684\u540D\u5B57Shaka\u610F\u5473\u7740\u5E26\u6765\u597D\u8FD0\u7684\u9B54\u529B\uFF0C",
    "\u90E8\u65CF\u76F8\u4FE1\uFF0C\u501F\u52A9\u8FD9\u79CD\u91D1\u5C5E\u7684\u529B\u91CF\u8FDB\u884C\u9644\u9B54\uFF0C",
    "\u53EF\u4EE5\u4F7F\u5DE5\u5177\u7684\u4F7F\u7528\u8005\u597D\u8FD0\u968F\u8EAB\u3002"
];

for item in shaka {
    for tooltip in shakaTooltip {
        item.addTooltip(tooltip);
    }
}

// Alchohol and Soft Drink marker
val alchohol as string[] = [
    "\u4E0D\u542B\u9152\u7CBE\u7684\u8F6F\u996E\u6599\uFF0C\u8001\u5C11\u7686\u5B9C\u3002",
    "\u8FD9\u662F\u9152\uFF0C\u8BF7\u52FF\u8D2A\u676F\uFF01"
];

<item:tropicraft:limeade>.addTooltip(alchohol[0]);
<item:tropicraft:pina_colada>.addTooltip(alchohol[1]);
<item:tropicraft:caipirinha>.addTooltip(alchohol[1]);
<item:tropicraft:mai_tai>.addTooltip(alchohol[1]);
<item:tropicraft:cocktail>.addTooltip(alchohol[1]);
<item:tropicraft:lemonade>.addTooltip(alchohol[0]);
<item:tropicraft:orangeade>.addTooltip(alchohol[0]);
<item:tropicraft:coconut_water>.addTooltip(alchohol[0]);
<item:tropicraft:black_coffee>.addTooltip(alchohol[0]);

// Love Tropics Shell
<item:tropicraft:love_tropics_shell>.addTooltip("\u5404\u79CD\u989C\u8272\u7684\u7528\u4EBA\u540D\u547D\u540D\u7684\u7EAA\u5FF5\u8D1D\u58F3\uFF0C\u5747\u53EF\u78BE\u788E\u4E3A\u9AA8\u7C89\u3002");
