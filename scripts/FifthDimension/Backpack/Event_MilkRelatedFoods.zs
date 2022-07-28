import crafttweaker.api.events.CTEventManager;
import crafttweaker.api.event.entity.player.MCPlayerLoggedInEvent;

import crafttweaker.api.event.entity.living.MCLivingEntityUseItemStartEvent;

import crafttweaker.api.item.IItemStack;
import crafttweaker.api.player.MCPlayerEntity;
import crafttweaker.api.data.IData;

val avaliable = true;

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

if (avaliable) {
    CTEventManager.register<MCLivingEntityUseItemStartEvent>(event => {
        var entity = event.entityLiving;
        if (entity is MCPlayerEntity) {
            var player as MCPlayerEntity = entity as MCPlayerEntity;
            if (!player.world.remote) { // Take the server thread
                if (event.item.definition.defaultInstance in milkRelatedItems) {
                    // Succeeded in Four means Player is currently in Five or higher
                    var hasSucceededStageFour as IData? = player.getPersistentData().getAt("SucceedInStageFour");
                    if (hasSucceededStageFour == null || hasSucceededStageFour.asBoolean() == false) {
                        player.sendMessage("\u00A7c\u00A7l\u4F60\u5C1A\u672A\u638C\u63E1\u6E38\u7267\u4EBA\u7684\u77E5\u8BC6\uFF0C\u65E0\u6CD5\u4F7F\u7528\u8FD9\u4E2A\u7269\u54C1");
                        event.cancel();
                    }
                }
            }
        }
    });
}
