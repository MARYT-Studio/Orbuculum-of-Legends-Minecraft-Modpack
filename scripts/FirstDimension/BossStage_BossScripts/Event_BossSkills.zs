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

import crafttweaker.api.util.MCEquipmentSlotType;

import stdlib.List;
import math.Functions;

val maxAllowedFollowersAmount = 4;
val summonProb as float = 0.5f;
val attackedInvisiblilityProb as float = 0.3f;
val seconds as int = 20;
val levels as int = -1;
val skillOneSpeaking as string[] = [
    "\u00A7l[\u00A76\u00A7l\u9B45\u00A7f\u00A7l]\u00A7r: \u4E0D\u8981\u5728\u6CA1\u6709\u5149\u7684\u5730\u65B9\u5BFB\u627E\u5F71\u5B50\u3002",
    "\u00A7l[\u00A76\u00A7l\u9B45\u00A7f\u00A7l]\u00A7r: \u6211\u662F\u5149\u7684\u53CD\u9762\uFF0C\u4E0E\u5149\u76F8\u4F34\u800C\u751F\u3002"
];
val skillTwoSpeaking as string[] = [
    "\u00A7l[\u00A76\u00A7l\u9B45\u00A7f\u00A7l]\u00A7r: \u4E0D\u8981\u8BD5\u56FE\u8FFD\u9010\u6211\u7684\u8E2A\u8FF9\u3002",
    "\u00A7l[\u00A76\u00A7l\u9B45\u00A7f\u00A7l]\u00A7r: \u4F60\u6293\u4E0D\u4F4F\u6211\u7684\uFF0C\u4F46\u6211\u53EF\u4EE5\u6293\u4F4F\u4F60\u3002"
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
                                    "CustomName": "\"\u00A78\u00A7l\u9634\u5F71\u5B88\u536B\u7684\u5206\u8EAB\"",
                                    "pehkui:scale_data_types": {
                                        "pehkui:width": {
                                            "initial":0.9,
                                            "scale":0.9,
                                            "target":0.9
                                        },
                                        "pehkui:height": {
                                            "initial":0.9,
                                            "scale":0.9,
                                            "target":0.9
                                        },
                                        "pehkui:motion": {
                                            "initial":3.2,
                                            "scale":3.2,
                                            "target":3.2
                                        }
                                    },
                                    "ForgeData": {
                                        "BossFollower": true,
                                        "SummonerName": player.name as string,
                                        "SummonerUUID": player.getUUID()
                                    }                                      
                                }
                            );
                            bossFollower.setItemStackToSlot(MCEquipmentSlotType.HEAD, <item:druidcraft:bone_helmet>);
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
                        player.sendMessage("\u00A7l[\u00A76\u00A7l\u9B45\u00A7f\u00A7l]\u00A7r: \u6211\u611F\u5230\u6211\u7684\u529B\u91CF\u6B63\u5728\u88AB\u9A71\u6563...");
                        player.sendMessage("\u00A7l[\u00A76\u00A7l\u963F\u6CE2\u7F57\u00A7f\u00A7l]\u00A7r: \u5B83\u7684\u5206\u8EAB\u6CD5\u672F\u53D8\u5F31\u4E86\uFF0C\u5FEB\u4E58\u80DC\u8FFD\u51FB\uFF01");
                        entity.updatePersistentData({"HintSended": true});
                    }
                }
            }
        }
    }
});