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
                player.sendMessage("我呼唤潜伏在地下的精灵；\n请诉说这片土地的故事，我必倾听。\n请为我打开矿藏的宝库，\n并转达我对大地的感激之情。");
                world.asServerWorld().server.executeCommand("execute at " + player.name as string + " run playsound minecraft:item.totem.use player " + player.name as string, true);
            } else if (<item:druidcraft:amber>.contains(offhandItem)) {
                offhandItem.mutable().shrink();
                item.mutable().shrink();
                player.give(<item:adfinders:metal_finder>);
                player.sendMessage("我呼唤潜伏在地下的精灵；\n请诉说这片土地的故事，我必倾听。\n请为我揭示埋藏的金属，\n并转达我对大地的感激之情。");
                world.asServerWorld().server.executeCommand("execute at " + player.name as string + " run playsound minecraft:item.totem.use player " + player.name as string, true);
            }
        }
});