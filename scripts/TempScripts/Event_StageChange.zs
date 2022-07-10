import crafttweaker.api.events.CTEventManager;
import crafttweaker.api.event.entity.MCEntityTravelToDimensionEvent;

import crafttweaker.api.player.MCPlayerEntity;

CTEventManager.register<MCEntityTravelToDimensionEvent>(event => {
    var entity = event.entity;
    if (event.dimension.toString() != "orbuculum_of_legends:fake_overworld" && entity is MCPlayerEntity) {
        var player as MCPlayerEntity = entity as MCPlayerEntity;
        player.sendMessage("你尚未满足前往下一层世界的条件，请之后再来吧！");
        event.cancel();
    }
});