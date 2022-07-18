import crafttweaker.api.events.CTEventManager;
import crafttweaker.api.event.entity.player.MCPlayerLoggedInEvent;

import crafttweaker.api.event.entity.player.interact.MCRightClickItemEvent;
import crafttweaker.api.event.entity.living.MCLivingEntityUseItemStartEvent;

import crafttweaker.api.player.MCPlayerEntity;
import crafttweaker.api.data.IData;

val avaliable = true;

if (avaliable) {
    CTEventManager.register<MCRightClickItemEvent>(event => {
        var nullablePlayer as MCPlayerEntity? = event.player;
        if (nullablePlayer != null && !nullablePlayer.world.remote) {
            if (<item:druidcraft:travel_pack>.matches(event.itemStack.definition.defaultInstance)) {
                var player as MCPlayerEntity = nullablePlayer as MCPlayerEntity;
                if (player.getPersistentData().getAt("SucceedInStageFour") == null || player.getPersistentData().getAt("SucceedInStageFour").asBoolean()) {
                    // Original text: §c§l你尚未掌握游牧人的知识，无法使用这个物品
                    player.sendMessage("\u00A7c\u00A7l\u4f60\u5c1a\u672a\u638c\u63e1\u6e38\u7267\u4eba\u7684\u77e5\u8bc6\uff0c\u65e0\u6cd5\u4f7f\u7528\u8fd9\u4e2a\u7269\u54c1");
                    event.itemStack.shrink();
                    event.cancel();
                }
            }
        }
    });

    CTEventManager.register<MCLivingEntityUseItemStartEvent>(event => {
        var entity = event.entityLiving;
        if (entity is MCPlayerEntity && !entity.world.remote) {
            if (<item:druidcraft:travel_pack>.matches(event.item.definition.defaultInstance)) {
                var player as MCPlayerEntity = entity as MCPlayerEntity;
                if (player.getPersistentData().getAt("SucceedInStageFour") == null || player.getPersistentData().getAt("SucceedInStageFour").asBoolean()) {
                    event.item.shrink();
                    event.cancel();
                }
            }
        }
    });
}