import crafttweaker.api.events.CTEventManager;
import crafttweaker.api.event.entity.living.MCLivingAttackEvent;
import crafttweaker.api.entity.MCEntity;
import crafttweaker.api.player.MCPlayerEntity;
import crafttweaker.api.util.MCHand;
import crafttweaker.api.data.IData;

CTEventManager.register<MCLivingAttackEvent>((event) => {
    var source as MCEntity? = event.source.trueSource;
    if (source != null) {
        var trueSource = source as MCEntity;
        if (trueSource is MCPlayerEntity) {
            var player as MCPlayerEntity = trueSource as MCPlayerEntity;
            var entity = event.entityLiving;
            var entityNameArray as string[] = entity.type.translationKey.split(".");
            if ("tropicraft" in entityNameArray && "ashen" in entityNameArray) {
                var actionState as IData? = entity.data.getAt("ActionState");
                if (actionState == null) return;
                var state = actionState.asNumber().getInt();
                if (state == 2) return;
                if (!entity.world.remote) {
                    player.sendMessage("\u4ED6\u5DF2\u7ECF\u88AB\u6253\u9192\u4E86\uFF0C\u6211\u70B9\u5230\u4E3A\u6B62\u5427\u3002\n\u6211\u5F97\u8D76\u5FEB\u628A\u4ED6\u7684\u9762\u5177\u6361\u8D70\uFF0C\u514D\u5F97\u4ED6\u53C8\u5F00\u59CB\u653B\u51FB\u5176\u4ED6\u4EBA\u3002");
                }
                event.cancel();
            }
        }
    }
});

CTEventManager.register<MCLivingAttackEvent>((event) => {
    var source as MCEntity? = event.source.trueSource;
    if (source != null) {
        var trueSource = source as MCEntity;
        var sourceNameArray as string[] = trueSource.type.translationKey.split(".");
        if ("tropicraft" in sourceNameArray && "ashen" in sourceNameArray) {
            var entity = event.entityLiving;
            if (entity is MCPlayerEntity) {
                var actionState as IData? = trueSource.data.getAt("ActionState");
                if (actionState == null) return;
                var state = actionState.asNumber().getInt();
                if (state == 2) return;
                event.cancel();
            }
        }
    }
});