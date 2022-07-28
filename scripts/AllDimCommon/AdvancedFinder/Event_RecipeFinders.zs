import crafttweaker.api.events.CTEventManager;
import crafttweaker.api.event.entity.player.interact.MCRightClickItemEvent;
import crafttweaker.api.util.MCHand;

CTEventManager.register<MCRightClickItemEvent>(event => {
    var item = event.itemStack;
    var itemDefaultInstance = item.definition.defaultInstance;
    var player = event.player;
    var world = event.player.world;
    if(!world.remote && <item:minecraft:clock>.matches(itemDefaultInstance)) {
            var offhandItem = player.getHeldItem(MCHand.OFF_HAND);
            if(<item:druidcraft:rockroot>.contains(offhandItem)) {
                offhandItem.mutable().shrink();
                item.mutable().shrink();
                player.give(<item:adfinders:mineral_finder>);
                player.sendMessage("\u6211\u547C\u5524\u6F5C\u4F0F\u5728\u5730\u4E0B\u7684\u7CBE\u7075\uFF1B\n\u8BF7\u8BC9\u8BF4\u8FD9\u7247\u571F\u5730\u7684\u6545\u4E8B\uFF0C\u6211\u5FC5\u503E\u542C\u3002\n\u8BF7\u4E3A\u6211\u6253\u5F00\u77FF\u85CF\u7684\u5B9D\u5E93\uFF0C\n\u5E76\u8F6C\u8FBE\u6211\u5BF9\u5927\u5730\u7684\u611F\u6FC0\u4E4B\u60C5\u3002");
                world.asServerWorld().server.executeCommand("execute at " + player.name as string + " run playsound minecraft:item.totem.use player " + player.name as string, true);
            } else if (<item:druidcraft:amber>.contains(offhandItem)) {
                offhandItem.mutable().shrink();
                item.mutable().shrink();
                player.give(<item:adfinders:metal_finder>);
                player.sendMessage("\u6211\u547C\u5524\u6F5C\u4F0F\u5728\u5730\u4E0B\u7684\u7CBE\u7075\uFF1B\n\u8BF7\u8BC9\u8BF4\u8FD9\u7247\u571F\u5730\u7684\u6545\u4E8B\uFF0C\u6211\u5FC5\u503E\u542C\u3002\n\u8BF7\u4E3A\u6211\u63ED\u793A\u57CB\u85CF\u7684\u91D1\u5C5E\uFF0C\n\u5E76\u8F6C\u8FBE\u6211\u5BF9\u5927\u5730\u7684\u611F\u6FC0\u4E4B\u60C5\u3002");
                world.asServerWorld().server.executeCommand("execute at " + player.name as string + " run playsound minecraft:item.totem.use player " + player.name as string, true);
            }
        }
});