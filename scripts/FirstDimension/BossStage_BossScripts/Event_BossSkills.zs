import crafttweaker.api.events.CTEventManager;
import crafttweaker.api.event.entity.living.MCLivingHurtEvent;
import crafttweaker.api.event.entity.living.MCLivingAttackEvent;

import crafttweaker.api.player.MCPlayerEntity;
import crafttweaker.api.entity.MCLivingEntity;
import crafttweaker.api.entity.MCEntity;

import crafttweaker.api.util.BlockPos;

import crafttweaker.api.data.MapData;
import crafttweaker.api.data.IData;
import crafttweaker.api.data.ListData;
import crafttweaker.api.data.StringData;

import crafttweaker.api.entity.AttributeInstance;
import crafttweaker.api.entity.AttributeModifier;
import crafttweaker.api.entity.AttributeOperation;

import stdlib.List;
import math.Functions;

val maxAllowedFollowersAmount = 3;
val summonProb as float = 0.5f;
val attackedInvisiblilityProb as float = 0.3f;
val seconds as int = 20;
val levels as int = -1;
val skillOneSpeaking as string[] = [
    // Original text:
    // §l[§6§l魅§f§l]§r: 不要在没有光的地方寻找影子。
    // §l[§6§l魅§f§l]§r: 我是光的反面，与光相伴而生。
    "\u00A7l[\u00A76\u00A7l\u9b45\u00A7f\u00A7l]\u00A7r: \u4e0d\u8981\u5728\u6ca1\u6709\u5149\u7684\u5730\u65b9\u5bfb\u627e\u5f71\u5b50\u3002",
    "\u00A7l[\u00A76\u00A7l\u9b45\u00A7f\u00A7l]\u00A7r: \u6211\u662f\u5149\u7684\u53cd\u9762\uff0c\u4e0e\u5149\u76f8\u4f34\u800c\u751f\u3002"
];
val skillTwoSpeaking as string[] = [
    // Original text:
    // §l[§6§l魅§f§l]§r: 不要试图追逐我的踪迹。
    // §l[§6§l魅§f§l]§r: 你抓不住我的，但我可以抓住你。
    "\u00A7l[\u00A76\u00A7l\u9b45\u00A7f\u00A7l]\u00A7r: \u4e0d\u8981\u8bd5\u56fe\u8ffd\u9010\u6211\u7684\u8e2a\u8ff9\u3002",
    "\u00A7l[\u00A76\u00A7l\u9b45\u00A7f\u00A7l]\u00A7r: \u4f60\u6293\u4e0d\u4f4f\u6211\u7684\uff0c\u4f46\u6211\u53ef\u4ee5\u6293\u4f4f\u4f60\u3002"
];

// Boss Attack Player Skill, or Skill 1 in PlanAndProgress.md
CTEventManager.register<MCLivingHurtEvent>(event => {
     var source as MCEntity? = event.source.trueSource;
     if (source != null && event.entityLiving is MCPlayerEntity) {
        var player as MCPlayerEntity = event.entityLiving as MCPlayerEntity;

        // Data Type Magic
        var nonnullSource as MCEntity = source as MCEntity;
        if (nonnullSource is MCLivingEntity) {
            var entity as MCLivingEntity = nonnullSource as MCLivingEntity;
            var data = entity.data;
            if (data.contains("ForgeData") && data.getData<MapData>("ForgeData").contains("BossMob")) {
                var entityNameArray as string[] = entity.type.translationKey.split(".");
                if ("minecraft" in entityNameArray && "wither_skeleton" in entityNameArray) {     
                    var world = entity.world;
                    var random = world.random;
                    if (!(random.nextFloat() > summonProb)) {
                        var pos = entity.position;
                        var pos1 = pos.add(new BlockPos(-5, -5, -5));
                        var pos2 = pos.add(new BlockPos(5, 5, 5));
                        var followerList as List<MCLivingEntity> = world.getEntitiesInAreaExcluding(
                            entity, 
                            (entityIn) => (
                                entityIn is MCLivingEntity &&
                                (entityIn.data.contains("ForgeData") && entityIn.data.getData<MapData>("ForgeData").contains("BossFollower"))
                            ),
                            pos1,
                            pos2
                        );
                        if (!(followerList.length as int > maxAllowedFollowersAmount)) {
                            var summon = random.nextFloat();
                            var summonAmount = 0;
                            if (summon > 0.6f) {summonAmount = 1;}
                            else if (summon > 0.3f) {summonAmount = 2;}
                            else if (summon > 0.1f) {summonAmount = 3;}
                            else {summonAmount = 4;}
                            var followerHealth as double = (entity.getHealth() >= 60.0f) ? (36/summonAmount) * 1.0d : (24/summonAmount) * 1.0d;
                            
                            // Summon
                            var bossFollower as MCLivingEntity = <entitytype:minecraft:wither_skeleton>.create(world) as MCLivingEntity;
                            bossFollower.updateData(
                                {
                                    // Original Text: §8§l阴影守卫的分身
                                    "CustomName": "\"\u00A78\u00A7l\u9634\u5f71\u5b88\u536b\u7684\u5206\u8eab\"",
                                    "pehkui:scale_data_types": {
                                        "pehkui:width": {
                                            "initial":1.3,
                                            "scale":1.3,
                                            "target":1.3
                                        },
                                        "pehkui:height": {
                                            "initial":1.3,
                                            "scale":1.3,
                                            "target":1.3
                                        },
                                        "pehkui:motion": {
                                            "initial":3.0,
                                            "scale":3.0,
                                            "target":3.0
                                        }
                                    },
                                    "ForgeData": {
                                        "BossFollower": true,
                                        "SummonerName": player.name as string,
                                        "SummonerUUID": player.getUUID()
                                    }                                      
                                }
                            );
                            bossFollower.setRevengeTarget(player);
                            
                            // Attribute
                            // Max Health
                            var healthAttribute as AttributeInstance? = bossFollower.getAttribute(<attribute:minecraft:generic.max_health>);
                            if (healthAttribute != null) {
                                var nonnullHealthAttribute as AttributeInstance = healthAttribute as AttributeInstance;
                                nonnullHealthAttribute.applyPersistentModifier(
                                    AttributeModifier.create(
                                        "BossFollower Health Modifier",
                                        (followerHealth - nonnullHealthAttribute.baseValue),
                                        AttributeOperation.ADDITION
                                    )
                                );
                            }

                            // Set health to full
                            bossFollower.setHealth(bossFollower.getMaxHealth());

                            var summonSuccessFlag = false;

                            for i in 0 .. summonAmount {
                                bossFollower.setPositionAndUpdate(
                                    (world.random.nextInt(9) - 4 + entity.position.x),
                                    entity.position.y, 
                                    (world.random.nextInt(9) - 4 + entity.position.z)
                                );
                                
                                // Summon followers
                                var summonResult = world.addEntity(bossFollower);
                                if (summonResult) {
                                    // Storage followers uuid                                    
                                    var uuidData as StringData = new StringData(bossFollower.uuid);
                                    var uuidListData as IData? = player.getPersistentData().getData<MapData>("BossStageOne").getAt("BossEntitiesUUID");
                                    if (uuidListData != null) {
                                        var nonnullUUIDListData as IData = uuidListData as IData;
                                        if (nonnullUUIDListData is ListData) {
                                            var uuidList as ListData = nonnullUUIDListData as ListData;
                                            uuidList.add(uuidData);
                                            player.updatePersistentData(
                                                {
                                                    "BossStageOne": {
                                                        "BossEntitiesUUID": uuidList
                                                    }
                                                }
                                            );
                                        }
                                    }
                                }
                                summonSuccessFlag = summonSuccessFlag || summonResult;
                            }

                            // Potion Effect and Speaking
                            if (summonSuccessFlag) {
                                var time = (entity.getHealth() >= 60.0f) ? (10 * summonAmount - 5) : (8 * summonAmount - 4);
                                entity.addPotionEffect(<effect:minecraft:invisibility>.newInstance(time * seconds, 1 + levels));
                                player.sendMessage(skillOneSpeaking[(world.random.nextInt(2) as usize)]);
                            }
                        }
                    }
                } 
            }
        }
     }
});

// Boss Hurt Skill, or Skill 2 in PlanAndProgress.md
// Also limit the max damage here
CTEventManager.register<MCLivingHurtEvent>(event => {
    var source as MCEntity? = event.source.trueSource;
    if (source != null) {
        var nonnullSource as MCEntity = source as MCEntity;
        if (nonnullSource is MCPlayerEntity) {
            var player as MCPlayerEntity = nonnullSource as MCPlayerEntity;
            var entity = event.entityLiving;
            var data = entity.data;
            if (data.contains("ForgeData") && data.getData<MapData>("ForgeData").contains("BossMob")) {
                var entityNameArray as string[] = entity.type.translationKey.split(".");
                if ("minecraft" in entityNameArray && "wither_skeleton" in entityNameArray) {
                    var random = entity.world.random;
                    
                    // Limit the damage
                    event.setAmount(Functions.min(event.amount, 10.0f));
                    
                    if (!(random.nextFloat() > attackedInvisiblilityProb)) {
                        entity.addPotionEffect(<effect:minecraft:invisibility>.newInstance(5 * seconds, 1 + levels));
                        player.sendMessage(skillTwoSpeaking[(random.nextInt(2) as usize)]);
                    }
                }
            }
        }
    }
});

// Boss Only Combat With Summoner Skill, or Skill 3 in PlanAndProgress.md
CTEventManager.register<MCLivingAttackEvent>(event => {
    var source as MCEntity? = event.source.trueSource;
    if (source != null) {
        var nonnullSource as MCEntity = source as MCEntity;
        var sourceData = nonnullSource.data;
        var targetData = event.entityLiving.data;
        if (sourceData.contains("ForgeData") && sourceData.getData<MapData>("ForgeData").contains("BossMob")) {
            var entityNameArray as string[] = nonnullSource.type.translationKey.split(".");
            if ("minecraft" in entityNameArray && "wither_skeleton" in entityNameArray) {
                if (!(event.entityLiving is MCPlayerEntity)) {
                    event.cancel();
                    return;
                }
                var player as MCPlayerEntity = event.entityLiving as MCPlayerEntity;
                var uuid as IData? = sourceData.getData<MapData>("ForgeData").getAt("SummonerUUID");
                if (uuid == null || player.getUUID() != uuid.getString()) {
                    event.cancel();
                    return;
                }
            }
        } else if (targetData.contains("ForgeData") && targetData.getData<MapData>("ForgeData").contains("BossMob")) {
            var entityNameArray as string[] = event.entityLiving.type.translationKey.split(".");
            if ("minecraft" in entityNameArray && "wither_skeleton" in entityNameArray) {
                if (!(nonnullSource is MCPlayerEntity)) {
                    event.cancel();
                    return;
                }
                var player as MCPlayerEntity = nonnullSource as MCPlayerEntity;
                var uuid as IData? = targetData.getData<MapData>("ForgeData").getAt("SummonerUUID");
                if (uuid == null || player.getUUID() != uuid.getString()) {
                    event.cancel();
                    return;
                }
            }
        }
    }
});

// Hint when Boss losing half of health
CTEventManager.register<MCLivingHurtEvent>(event => {
    var entity = event.entityLiving;
    var data = entity.data;
    if (data.contains("ForgeData") && data.getData<MapData>("ForgeData").contains("BossMob")) {
        var entityNameArray as string[] = entity.type.translationKey.split(".");
        if ("minecraft" in entityNameArray && "wither_skeleton" in entityNameArray) {
            var hintSended as IData? = data.getData<MapData>("ForgeData").getAt("HintSended");
            if (!(entity.getHealth() >= 60.0f)) {
                var source as MCEntity? = event.source.trueSource;
                if (source != null) {
                    var nonnullSource as MCEntity = source as MCEntity;
                    if (hintSended == null && nonnullSource is MCPlayerEntity) {
                        var player as MCPlayerEntity = nonnullSource as MCPlayerEntity;
                        // Original text:
                        // §l[§6§l魅§f§l]§r: 我感到我的力量正在被驱散...
                        // §l[§6§l阿波罗§f§l]§r: 它的分身法术变弱了，快乘胜追击！
                        player.sendMessage("\u00A7l[\u00A76\u00A7l\u9b45\u00A7f\u00A7l]\u00A7r: \u6211\u611f\u5230\u6211\u7684\u529b\u91cf\u6b63\u5728\u88ab\u9a71\u6563...");
                        player.sendMessage("\u00A7l[\u00A76\u00A7l\u963f\u6ce2\u7f57\u00A7f\u00A7l]\u00A7r: \u5b83\u7684\u5206\u8eab\u6cd5\u672f\u53d8\u5f31\u4e86\uff0c\u5feb\u4e58\u80dc\u8ffd\u51fb\uff01");
                        entity.updatePersistentData({"HintSended": true});
                    }
                }
            }
        }
    }
});