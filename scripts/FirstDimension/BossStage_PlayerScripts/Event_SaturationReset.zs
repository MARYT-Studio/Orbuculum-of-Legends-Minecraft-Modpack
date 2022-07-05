import crafttweaker.api.events.CTEventManager;
import crafttweaker.api.event.entity.living.MCLivingHurtEvent;
import crafttweaker.api.player.MCPlayerEntity;
import crafttweaker.api.util.MCHand;

val seconds as int = 20;

// Every 2 points of Saturation equals to 1 golden drumsticks.
// So does the Food Level.
val maxSaturationCost as int = 6;

CTEventManager.register<MCLivingHurtEvent>(event => {
     if (event.entityLiving is MCPlayerEntity) {
        var player = event.entityLiving as MCPlayerEntity;
        if (true) { // TODO: BossStage NBT here
            if (player.world.random.nextFloat() >= 0.33f) {
                var saturationCost as int = (event.amount > 3.0f) ? (maxSaturationCost - 2) : maxSaturationCost;
                for i in 0 .. player.world.random.nextInt(1, saturationCost) {
                    player.addExhaustion(4.0f);
                    if (player.saturationLevel == 0.0f) {break;}
                }
            }
        }
     }
});