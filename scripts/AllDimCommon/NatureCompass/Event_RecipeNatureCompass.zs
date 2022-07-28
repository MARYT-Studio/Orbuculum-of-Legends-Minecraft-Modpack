import crafttweaker.api.events.CTEventManager;
import crafttweaker.api.event.entity.player.interact.MCRightClickItemEvent;
import crafttweaker.api.util.MCHand;

CTEventManager.register<MCRightClickItemEvent>(event => {
    var item = event.itemStack;
    var itemDefaultInstance = item.definition.defaultInstance;
    var player = event.player;
    var world = event.player.world;
    var hand = event.hand;
    if(!world.remote && <item:minecraft:compass>.matches(itemDefaultInstance)) {
            var offhandItem = player.getHeldItem(MCHand.OFF_HAND);
            if(<tag:items:minecraft:saplings>.contains(offhandItem)) {
                offhandItem.mutable().shrink();
                item.mutable().shrink();
                player.give(<item:naturescompass:naturescompass>);
                world.asServerWorld().server.executeCommand("execute at " + player.name as string + " run playsound minecraft:entity.player.levelup player " + player.name as string, true);
                player.sendMessage("\u6211\u547C\u5524\u9690\u533F\u5728\u539F\u91CE\u4E2D\u7684\u7CBE\u7075\uFF1B\n\u8BF7\u8BC9\u8BF4\u8FD9\u7247\u571F\u5730\u7684\u6545\u4E8B\uFF0C\u6211\u5FC5\u503E\u542C\u3002\n\u6307\u7ED9\u6211\u90A3\u7247\u6211\u671F\u76FC\u7684\u571F\u5730\uFF0C\n\u8D60\u4E88\u6211\u4E00\u573A\u524D\u5F80\u5E78\u798F\u7684\u65C5\u884C\u3002");
            }
        }
});