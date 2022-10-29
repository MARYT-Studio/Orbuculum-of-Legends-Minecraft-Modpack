import crafttweaker.api.events.CTEventManager;
import crafttweaker.api.event.entity.MCEntityTravelToDimensionEvent;

import crafttweaker.api.player.MCPlayerEntity;

val enable = false;

if (enable) {
    CTEventManager.register<MCEntityTravelToDimensionEvent>(event => {
    var entity = event.entity;
        if (event.dimension.toString() != "orbuculum_of_legends:fake_overworld" && entity is MCPlayerEntity) {
            var player as MCPlayerEntity = entity as MCPlayerEntity;
            player.sendMessage("\u4F60\u5C1A\u672A\u6EE1\u8DB3\u524D\u5F80\u4E0B\u4E00\u5C42\u4E16\u754C\u7684\u6761\u4EF6\uFF0C\u8BF7\u4E4B\u540E\u518D\u6765\u5427\uFF01");
            event.cancel();
        }
    });
}