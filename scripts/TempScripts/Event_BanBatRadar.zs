import crafttweaker.api.events.CTEventManager;
import crafttweaker.api.event.entity.player.interact.MCRightClickItemEvent;

val enable = true;

if (enable) {
    CTEventManager.register<MCRightClickItemEvent>(event => {
        var item = event.itemStack.definition.defaultInstance;
        var world = event.player.world;
        if(!world.remote && <item:vanillafoodpantry:bat_sonar_sac>.matches(item)) {
            event.cancel();
        }
    });
}