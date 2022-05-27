import crafttweaker.api.events.CTEventManager;
import crafttweaker.api.event.entity.living.MCLivingEntityUseItemFinishEvent;
import crafttweaker.api.player.MCPlayerEntity;
import crafttweaker.api.item.IItemStack;

CTEventManager.register<MCLivingEntityUseItemFinishEvent>(event => {
    var entity = event.entityLiving;
    if (!entity.world.remote && entity is MCPlayerEntity) {
        var player = entity as MCPlayerEntity;
        if (<item:farmersdelight:mixed_salad>.matches(event.item)) {
            var bowlsAmount as int = player.inventory.count(<item:minecraft:bowl>) - 1;
            if (bowlsAmount >= 0) {
                player.inventory.remove(<item:minecraft:bowl>);
                while (bowlsAmount > 64) {
                    player.give(<item:minecraft:bowl> * 64);
                    bowlsAmount = bowlsAmount - 64;
                }
                player.give(<item:minecraft:bowl> * bowlsAmount);
            } else {
                event.resultStack.mutable().shrink();
            }
        }
    }
});