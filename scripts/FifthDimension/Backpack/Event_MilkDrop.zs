import crafttweaker.api.events.CTEventManager;
import crafttweaker.api.event.entity.player.MCPlayerLoggedInEvent;

import crafttweaker.api.event.entity.player.interact.MCRightClickItemEvent;
import crafttweaker.api.event.entity.living.MCLivingEntityUseItemStartEvent;

import crafttweaker.api.player.MCPlayerEntity;
import crafttweaker.api.data.IData;

CTEventManager.register<MCRightClickItemEvent>(event => {
    var nullablePlayer as MCPlayerEntity? = event.player;
    if (nullablePlayer != null) {
        if (<item:vanillafoodpantry:portion_milk>.matches(event.itemStack.definition.defaultInstance)) {
            var player as MCPlayerEntity = nullablePlayer as MCPlayerEntity;
            if (player.world.isRemote()) {
                return;
            }
            if (player.getPersistentData().getAt("SucceedInStageFour") == null || player.getPersistentData().getAt("SucceedInStageFour").asBoolean()) {
                // Original text: §c§l你尚未掌握游牧人的知识，无法使用这个物品
                player.sendMessage("\u00A7c\u00A7l\u4f60\u5c1a\u672a\u638c\u63e1\u6e38\u7267\u4eba\u7684\u77e5\u8bc6\uff0c\u65e0\u6cd5\u4f7f\u7528\u8fd9\u4e2a\u7269\u54c1");
                event.cancel();
            }
        }
    }
});

CTEventManager.register<MCLivingEntityUseItemStartEvent>(event => {
    var entity = event.entityLiving;
    if (entity is MCPlayerEntity) {
        if (<item:vanillafoodpantry:portion_milk>.matches(event.item.definition.defaultInstance)) {
            var player as MCPlayerEntity = entity as MCPlayerEntity;
            if (player.world.isRemote()) {
                return;
            }
            if (player.getPersistentData().getAt("SucceedInStageFour") == null || player.getPersistentData().getAt("SucceedInStageFour").asBoolean()) {
                event.cancel();
            }
        }
    }
});