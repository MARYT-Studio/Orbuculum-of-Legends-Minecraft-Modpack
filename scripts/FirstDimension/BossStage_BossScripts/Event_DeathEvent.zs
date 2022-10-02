import crafttweaker.api.events.CTEventManager;

import crafttweaker.api.event.entity.living.MCLivingDeathEvent;
import crafttweaker.api.event.entity.living.MCLivingDropsEvent;

import crafttweaker.api.entity.MCEntity;
import crafttweaker.api.player.MCPlayerEntity;
import crafttweaker.api.entity.MCLivingEntity;

import crafttweaker.api.data.MapData;
import crafttweaker.api.data.IData;
import crafttweaker.api.data.ListData;
import crafttweaker.api.data.StringData;

import stdlib.List;

// Remove Bosses when summoner dies
CTEventManager.register<MCLivingDeathEvent>(event => {
    var entity = event.entityLiving;
    if (entity is MCPlayerEntity) {
        var player as MCPlayerEntity = entity as MCPlayerEntity;
        var playerPersist as MapData = player.getPersistentData();
        if (playerPersist.contains("BossStageOne")) {
            var uuidListData as IData? = playerPersist.getData<MapData>("BossStageOne").getAt("BossEntitiesUUID");
            if (uuidListData != null) {
                var uuidList as List<IData> = ((uuidListData as IData) as ListData) as List<IData>;
                for uuid in uuidList {
                    player.world.asServerWorld().server.executeCommand("kill " + uuid.getString(), true);
                }

                // Change summoner out of Boss-combat mode
                player.updatePersistentData({"BeingInBossStage": false});
                
                // clear boss mobs uuid
                var emptyListData as ListData = new ListData();
                player.updatePersistentData(
                    {
                        "BossStageOne": {
                            "BossEntitiesUUID": emptyListData
                        }
                    }
                );
                player.sendMessage("\u00A7l[\u00A76\u00A7l\u9B45\u00A7f\u00A7l]\u00A7r: \u91CD\u65B0\u53EC\u5524\u6211\u5427\uFF0C\u6211\u4F1A\u518D\u7ED9\u4F60\u673A\u4F1A\u3002");
            }
        }
    }
});

// Reward summoner when Boss dies
CTEventManager.register<MCLivingDeathEvent>(event => {
    var entity = event.entityLiving;
    var data = entity.data;
    if (!(entity is MCPlayerEntity) && data.contains("ForgeData") && data.getData<MapData>("ForgeData").contains("BossMob")) {
    var entityNameArray as string[] = entity.type.translationKey.split(".");
        if ("minecraft" in entityNameArray && "wither_skeleton" in entityNameArray) {
            var source as MCEntity? = event.source.trueSource;
            if (source != null) {
                var nonnullSource as MCEntity = source as MCEntity;
                if (nonnullSource is MCPlayerEntity) {
                    var player as MCPlayerEntity = nonnullSource as MCPlayerEntity;
                    var uuid as IData? = data.getData<MapData>("ForgeData").getAt("SummonerUUID");
                    if (uuid != null && player.getUUID() == uuid.getString()) {
                        // Change summoner out of Boss-combat mode
                        player.updatePersistentData({"BeingInBossStage": false});
                        
                        // clear boss mobs uuid
                        var emptyListData as ListData = new ListData();
                        player.updatePersistentData(
                            {
                                "BossStageOne": {
                                    "BossEntitiesUUID": emptyListData
                                }
                            }
                        );

                        // Success Flag
                        player.updatePersistentData({"SucceedInStageOne": true});

                        player.sendMessage("\u00A7l[\u00A76\u00A7l\u9B45\u00A7f\u00A7l]\u00A7r: \u4F60\u7EC8\u4E8E\u8FD8\u662F\u7A81\u7834\u4E86\u7B2C\u4E00\u9053\u5C01\u5370\u3002\u4E0D\u8981\u592A\u5F97\u610F\u4E86\uFF0C\u524D\u9762\u8FD8\u6709\u66F4\u5F3A\u5927\u7684\u5C01\u5370\u5B88\u536B\u8005\u5728\u7B49\u5F85\u4F60\u5462\u3002");

                        // TODO: Teleport to Stage 2
                    }
                }
            }
        }
    }
    return;
});

// Remove all drops from *ALL* Bosses
CTEventManager.register<MCLivingDropsEvent>(event => {
    var entity = event.entityLiving;
    var data = entity.data;
    if (data.contains("ForgeData") &&
        (
            data.getData<MapData>("ForgeData").contains("BossMob") ||
            data.getData<MapData>("ForgeData").contains("BossFollower")
        )
    ) {event.cancel();}
});