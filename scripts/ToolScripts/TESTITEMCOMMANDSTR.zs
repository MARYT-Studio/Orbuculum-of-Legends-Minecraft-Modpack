import crafttweaker.api.events.CTEventManager;
import crafttweaker.api.event.entity.player.interact.MCRightClickItemEvent;

val enable = false;

if (enable) {
    CTEventManager.register<MCRightClickItemEvent>(event => {
        var splitStr = event.itemStack.definition.defaultInstance.commandString.split(":");
        if(!event.player.world.remote) {
            for part in splitStr {
                event.player.sendMessage(part);
            }
        }
    });
}