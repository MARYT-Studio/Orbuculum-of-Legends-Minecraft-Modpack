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

// Fabric part
