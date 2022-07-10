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
                // Original text: §l[§6§l魅§f§l]§r: 重新召唤我吧，我会再给你机会。
                player.sendMessage("\u00A7l[\u00A76\u00A7l\u9b45\u00A7f\u00A7l]\u00A7r: \u91cd\u65b0\u53ec\u5524\u6211\u5427\uff0c\u6211\u4f1a\u518d\u7ed9\u4f60\u673a\u4f1a\u3002");
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

                        // Original text: §l[§6§l魅§f§l]§r: 你终于还是突破了第一道封印。不要太得意了，前面还有更强大的封印守卫者在等待你呢。
                        player.sendMessage("\u00A7l[\u00A76\u00A7l\u9b45\u00A7f\u00A7l]\u00A7r: \u4f60\u7ec8\u4e8e\u8fd8\u662f\u7a81\u7834\u4e86\u7b2c\u4e00\u9053\u5c01\u5370\u3002\u4e0d\u8981\u592a\u5f97\u610f\u4e86\uff0c\u524d\u9762\u8fd8\u6709\u66f4\u5f3a\u5927\u7684\u5c01\u5370\u5b88\u536b\u8005\u5728\u7b49\u5f85\u4f60\u5462\u3002");

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