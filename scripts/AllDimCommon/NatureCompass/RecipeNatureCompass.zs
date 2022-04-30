import crafttweaker.api.events.CTEventManager;
import crafttweaker.api.event.entity.player.interact.MCRightClickItemEvent;
import crafttweaker.api.util.MCHand;

CTEventManager.register<MCRightClickItemEvent>(event => {
    var item = event.itemStack;
    var itemDefaultInstance = item.definition.defaultInstance;
    var player = event.player;
    var world = event.player.world;
    var hand = event.hand;
    if(!world.remote && itemDefaultInstance.matches(<item:minecraft:compass>)) {
            if(!(hand == MCHand.OFF_HAND)) {return;}
            var offhandItem = player.getHeldItem(hand);
            if(<tag:items:minecraft:saplings>.contains(offhandItem)) {
                offhandItem.mutable().shrink();
                item.mutable().shrink();
                player.give(<item:naturescompass:naturescompass>);
                world.asServerWorld().server.executeCommand("execute at " + player.name as string + " run playsound minecraft:entity.player.levelup player " + player.name as string, true);
                player.sendMessage("我呼唤隐匿在原野中的精灵；\n请诉说这片土地的故事，我必倾听。\n指给我那片我期盼的土地，\n赠予我一场前往幸福的旅行。");
            }
        }
});