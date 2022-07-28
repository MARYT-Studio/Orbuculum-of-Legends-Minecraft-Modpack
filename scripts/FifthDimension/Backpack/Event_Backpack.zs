import crafttweaker.api.events.CTEventManager;

import crafttweaker.api.event.entity.player.interact.MCRightClickItemEvent;

import crafttweaker.api.player.MCPlayerEntity;
import crafttweaker.api.data.IData;

CTEventManager.register<MCRightClickItemEvent>(event => {
    var nullablePlayer as MCPlayerEntity? = event.player;
    if (nullablePlayer != null) {
        var player as MCPlayerEntity = nullablePlayer as MCPlayerEntity;
        if (!player.world.remote) { // Take the server thread
            // Succeeded in Four means Player is currently in Five or higher
            var hasSucceededStageFour as IData? = player.getPersistentData().getAt("SucceedInStageFour");
            if (hasSucceededStageFour == null || hasSucceededStageFour.asBoolean() == false) {
                if (<item:druidcraft:travel_pack>.matches(event.itemStack.definition.defaultInstance)) {
                    player.sendMessage("\u00A7c\u00A7l\u4F60\u5C1A\u672A\u638C\u63E1\u6E38\u7267\u4EBA\u7684\u77E5\u8BC6\uFF0C\u65E0\u6CD5\u4F7F\u7528\u8FD9\u4E2A\u7269\u54C1");
                    event.cancel();
                }
            }
        }
    }
});