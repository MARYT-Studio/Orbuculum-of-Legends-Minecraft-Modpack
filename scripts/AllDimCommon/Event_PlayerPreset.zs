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
            player.sendMessage("... \u8FD9\u91CC\u662F\uFF0C\u662F\u6211\u7684\u6C34\u6676\u7403\u5417\uFF1F\n\u6211\u597D\u50CF\uFF0C\u771F\u7684\u88AB\u88C5\u8FDB\u6765\u4E86...\n\u6211\u8BE5\u600E\u4E48\u529E\uFF1F\n\u4E0D\u7BA1\u600E\u6837\uFF0C\u6211\u5F97\u60F3\u529E\u6CD5\u79BB\u5F00\u8FD9\u91CC\u3002\n...\n\u00A77...\n\u00A78...");
            player.sendMessage("\u00A77\u00A7o\u6211\u4EEC\u4F1A\u4E00\u8D77\u5E2E\u52A9\u4F60\u51FA\u53BB\u3002");
        }
    }
});