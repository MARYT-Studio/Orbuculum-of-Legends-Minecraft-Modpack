import crafttweaker.api.events.CTEventManager;
import crafttweaker.api.event.entity.living.MCLivingHurtEvent;
import crafttweaker.api.player.MCPlayerEntity;
import crafttweaker.api.util.MCHand;
import crafttweaker.api.data.MapData;
import crafttweaker.api.data.IData;
import crafttweaker.api.data.BoolData;

// Every 2 points of Saturation equals to 1 golden drumsticks.
// So does the Food Level.
val maxSaturationCost as int = 8;

CTEventManager.register<MCLivingHurtEvent>(event => {
     if (event.entityLiving is MCPlayerEntity) {
        var player = event.entityLiving as MCPlayerEntity;
        if (player.data.contains("ForgeData") &&
            player.data.getData<MapData>("ForgeData").contains("PlayerPersisted") &&
            player.data.getData<MapData>("ForgeData").getData<MapData>("PlayerPersisted").contains("BeingInBossStage")) {
            var bossStage as IData? = player.data.getData<MapData>("ForgeData").getData<MapData>("PlayerPersisted").getAt("BeingInBossStage");
            if (bossStage != null && bossStage.asBoolean()) {
                if (player.world.random.nextFloat() >= 0.7f) {
                    var saturationCost as int = (event.amount > 3.0f) ? (maxSaturationCost - 3) : maxSaturationCost;
                    for i in 0 .. player.world.random.nextInt(1, saturationCost) {
                        player.addExhaustion(4.0f);
                        if (player.saturationLevel == 0.0f) {break;}
                    }
                }
            }
        }
     }
});
