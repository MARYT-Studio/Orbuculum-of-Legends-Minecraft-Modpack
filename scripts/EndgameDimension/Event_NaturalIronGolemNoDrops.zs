import crafttweaker.api.events.CTEventManager;
import crafttweaker.api.event.entity.living.MCLivingDropsEvent;

import crafttweaker.api.data.IData;

// Disallow Non-player-generated Iron Golems outside the endgame world to drop items
CTEventManager.register<MCLivingDropsEvent>((event) => {
    var entity = event.entityLiving;
    var world = entity.world;
    if (world.remote) return;
    var entityCommandString = entity.type.commandString;
    if (entityCommandString.indexOf("iron_golem") != null) {
        var playerCreated as IData? = entity.data.getAt("PlayerCreated");
        if (playerCreated == null && world.dimension != "minecraft:overworld") {event.cancel(); return;}
        var playerCreateBoolean as bool = playerCreated.asBoolean();
        if (!playerCreateBoolean && world.dimension != "minecraft:overworld") {event.cancel(); return;}
    }
});
