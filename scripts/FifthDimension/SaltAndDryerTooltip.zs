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
    salt.addTooltip("\u7528\u4E8E\u814C\u6E0D\u730E\u7269\u7684\u76D0\u548C\u78B1\u53EA\u5B58\u5728\u7B2C\u4E94\u5C42\u4E16\u754C\u4E2D\uFF0C\u5230\u90A3\u91CC\u53BB\u5BFB\u627E\u5427\u3002");
}