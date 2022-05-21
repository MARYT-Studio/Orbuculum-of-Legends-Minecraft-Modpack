import crafttweaker.api.item.IIngredient;
val allSalt as IIngredient[] = [
    // Salts
    <item:vanillafoodpantry:rock_salt_crystals>,
    <item:vanillafoodpantry:rock_salt_ingot>,
    <item:vanillafoodpantry:rock_salt_ore>,
    <item:vanillafoodpantry:rock_salt_ore_nether>,
    <item:vanillafoodpantry:salt>,
    <item:vanillafoodpantry:portion_salt>,
    <item:vanillafoodpantry:salt_pantry_block>,
    
    // Natrons
    <item:vanillafoodpantry:natron_crystals>,
    <item:vanillafoodpantry:natron_ingot>,
    <item:vanillafoodpantry:natron_ore>,

    // Drying Agents
    <item:vanillafoodpantry:drying_agent>,
    <item:vanillafoodpantry:drying_agent_ball>,
    <item:vanillafoodpantry:drying_agent_pantry_block>
];

for salt in allSalt {
    // Original text：用于腌渍猎物的盐和碱只存在第五层世界中，到那里去寻找吧。
    salt.addTooltip("\u7528\u4e8e\u814c\u6e0d\u730e\u7269\u7684\u76d0\u548c\u78b1\u53ea\u5b58\u5728\u7b2c\u4e94\u5c42\u4e16\u754c\u4e2d\uff0c\u5230\u90a3\u91cc\u53bb\u5bfb\u627e\u5427\u3002");
}