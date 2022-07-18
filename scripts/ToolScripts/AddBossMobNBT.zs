import crafttweaker.api.events.CTEventManager;
import crafttweaker.api.event.entity.living.MCLivingHurtEvent;
import crafttweaker.api.entity.MCEntity;
import crafttweaker.api.player.MCPlayerEntity;
import crafttweaker.api.util.MCHand;
import crafttweaker.api.data.MapData;

val enable = false;

if (enable) {
CTEventManager.register<crafttweaker.api.event.entity.living.MCLivingHurtEvent>((event) => {
    var source as MCEntity? = event.source.trueSource;
    if (source != null) {
        var trueSource = source as MCEntity;
        if (trueSource is MCPlayerEntity) {
            var player as MCPlayerEntity = trueSource as MCPlayerEntity;
            var mainhandItem = player.getHeldItem(MCHand.MAIN_HAND);
            if(<item:minecraft:stick>.matches(mainhandItem)) {
                var entity = event.entityLiving;
                entity.updatePersistentData({BossMob: true as bool});
                var dataText = entity.data.asFormattedText(" ", 1);
                player.sendMessage(dataText);
            } else if (<item:minecraft:bamboo>.matches(mainhandItem)) {
                var entity = event.entityLiving;
                entity.updatePersistentData({BossFollower: true as bool});
                var dataText = entity.data.asFormattedText(" ", 1);
                player.sendMessage(dataText);
            }
        }
    }
});}