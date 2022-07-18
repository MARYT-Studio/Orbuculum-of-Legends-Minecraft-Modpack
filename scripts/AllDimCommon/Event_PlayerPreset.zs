import crafttweaker.api.events.CTEventManager;
import crafttweaker.api.event.entity.player.MCPlayerLoggedInEvent;
import crafttweaker.api.player.MCPlayerEntity;
import crafttweaker.api.data.IData;

CTEventManager.register<MCPlayerLoggedInEvent>(event => {
    var nullablePlayer as MCPlayerEntity? = event.player;
    if (nullablePlayer != null) {
        var player as MCPlayerEntity = nullablePlayer as MCPlayerEntity;
        
        var hasLoggedIn as IData? = player.getPersistentData().getAt("hasLoggedIn");
        if (hasLoggedIn == null) {
            // Default: player is not in Boss Combat mode
            player.updatePersistentData({"BeingInBossStage": false});

            // player has not conquered any of bosses.
            if (player.getPersistentData().getAt("SucceedInStageOne") == null) {player.updatePersistentData({"SucceedInStageOne": false});}
            if (player.getPersistentData().getAt("SucceedInStageTwo") == null) {player.updatePersistentData({"SucceedInStageTwo": false});}
            if (player.getPersistentData().getAt("SucceedInStageThree") == null) {player.updatePersistentData({"SucceedInStageThree": false});}
            if (player.getPersistentData().getAt("SucceedInStageFour") == null) {player.updatePersistentData({"SucceedInStageFour": false});}
            if (player.getPersistentData().getAt("SucceedInStageFive") == null) {player.updatePersistentData({"SucceedInStageFive": false});}
            if (player.getPersistentData().getAt("SucceedInStageSix") == null) {player.updatePersistentData({"SucceedInStageSix": false});}
            if (player.getPersistentData().getAt("SucceedInStageSeven") == null) {player.updatePersistentData({"SucceedInStageSeven": false});}

            // Mark the player has logged in
            player.updatePersistentData({"hasLoggedIn": true});

            // Original text:
            // ... 这里是，是我的水晶球吗？
            // 我好像，真的被装进来了...
            // 我该怎么办？
            // 不管怎样，我得想办法离开这里。
            // ...
            // §7...
            // §8...
            player.sendMessage("... \u8fd9\u91cc\u662f\uff0c\u662f\u6211\u7684\u6c34\u6676\u7403\u5417\uff1f\n\u6211\u597d\u50cf\uff0c\u771f\u7684\u88ab\u88c5\u8fdb\u6765\u4e86...\n\u6211\u8be5\u600e\u4e48\u529e\uff1f\n\u4e0d\u7ba1\u600e\u6837\uff0c\u6211\u5f97\u60f3\u529e\u6cd5\u79bb\u5f00\u8fd9\u91cc\u3002\n...\n\u00A77...\n\u00A78...");
            // Original text: §7§i我们会一起帮助你出去。
            player.sendMessage("\u00A77\u00A7o\u6211\u4eec\u4f1a\u4e00\u8d77\u5e2e\u52a9\u4f60\u51fa\u53bb\u3002");
        }
    }
});