import crafttweaker.api.events.CTEventManager;
import crafttweaker.api.event.entity.player.interact.MCEntityInteractEvent;
import crafttweaker.api.data.IData;

val targets as string[] = [
    "minecraft:zombie_villager",
    "minecraft:villager",
    "minecraft:wandering_trader"
];

CTEventManager.register<MCEntityInteractEvent>((event) => {
    var player = event.player;
    var world = event.player.world;
    if (!world.remote) {
        var targetID as string = event.target.type.registryName.toString();
        if (targetID in targets) {
            var hasSucceededStageSeven as IData? = player.getPersistentData().getAt("SucceedInStageSeven");
            if (world.dimension != "minecraft:overworld" || hasSucceededStageSeven == null || hasSucceededStageSeven.asBoolean() == false) {
                if (world.random.nextBoolean() && world.random.nextBoolean()) {
                    if (targetID == "minecraft:zombie_villager") {
                        player.sendMessage("\u5B83\u4E0D\u5E94\u8BE5\u5728\u8FD9\u4E2A\u5730\u65B9\u5F97\u5230\u6551\u8D4E\u3002");
                    } else {
                        player.sendMessage("\u6211\u4EEC\u4E0D\u5C5E\u4E8E\u8FD9\u91CC... \u6211\u4EEC\u8981\u5148\u4ECE\u8FD9\u91CC\u9003\u8131\u3002");
                    }
                }
                event.cancel();
            }
        }
    }    
});


