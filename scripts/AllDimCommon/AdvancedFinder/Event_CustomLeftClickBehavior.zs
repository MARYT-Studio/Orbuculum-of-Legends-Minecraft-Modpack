import crafttweaker.api.events.CTEventManager;
import crafttweaker.api.event.entity.player.interact.MCLeftClickBlockEvent;

CTEventManager.register<MCLeftClickBlockEvent>(event => {
    var item = event.itemStack;
    var itemDefaultInstance = item.definition.defaultInstance;
    var player = event.player;
    var rand = event.player.world.random;
    var yell = "";
    if(
        !event.player.world.remote &&
        itemDefaultInstance.matches(<item:adfinders:gem_finder>) ||
        itemDefaultInstance.matches(<item:adfinders:metal_finder>) ||
        itemDefaultInstance.matches(<item:adfinders:mineral_finder>)
        ) {
            if(rand.nextBoolean() && rand.nextBoolean()) {  // 1/4 noisy
                if(item.damage == 4) {  // if fully broken
                    yell = rand.nextBoolean() ? "呀！摔坏了！" : "已经碎成这样，就别再敲了...";
                } else {
                    yell = rand.nextBoolean() ? "不小心磕到了..." : "要小心了，这个会碰坏的。";
                }
                player.sendMessage(yell);                
            }
        }
});