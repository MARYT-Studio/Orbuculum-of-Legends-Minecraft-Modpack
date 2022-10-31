import crafttweaker.api.events.CTEventManager;
import crafttweaker.api.event.entity.player.interact.MCRightClickItemEvent;

import crafttweaker.api.entity.MCItemEntity;
import crafttweaker.api.item.IItemStack;

import crafttweaker.api.entity.MCLivingEntity;
import crafttweaker.api.player.MCPlayerEntity;

import crafttweaker.api.util.BlockPos;

import stdlib.List;

import crafttweaker.api.potion.MCPotion;
import crafttweaker.api.potion.MCPotionEffect;
import crafttweaker.api.potion.MCPotionEffectInstance;

import crafttweaker.api.entity.AttributeInstance;
import crafttweaker.api.entity.AttributeModifier;
import crafttweaker.api.entity.AttributeOperation;

import crafttweaker.api.util.MCEquipmentSlotType;

import crafttweaker.api.data.IData;
import crafttweaker.api.data.ListData;
import crafttweaker.api.data.StringData;

val radius as int = 5;
val seconds as int = 20;
val levels as int = -1;

val offerings = <item:crockpot:taffy>|<item:farmersdelight:sweet_berry_cheesecake>|<item:crockpot:pow_cake>;

CTEventManager.register<MCRightClickItemEvent>(event => {
    var item = event.itemStack;
    var itemDefaultInstance = item.definition.defaultInstance;
    var player as MCPlayerEntity = event.player as MCPlayerEntity;
    var world = player.world;
    if(!world.remote && event.player != null && world.dimension == "orbuculum_of_legends:fake_overworld" && <item:minecraft:black_dye>.matches(itemDefaultInstance)) {
        var bossStage as IData? = player.getPersistentData().getAt("BeingInBossStage");
        if (world.difficulty != "peaceful") {
            if (bossStage == null || !bossStage.asBoolean()) {
                var pos = player.position;
                var pos1 = pos.add(new BlockPos(-radius, -radius, -radius));
                var pos2 = pos.add(new BlockPos(radius, radius, radius));
                var targetList as List<MCItemEntity> = player.world.getEntitiesInAreaExcluding(
                    player, 
                    (entityIn) => (entityIn is MCItemEntity && offerings.contains((entityIn as MCItemEntity).item.definition.defaultInstance)),
                    pos1,
                    pos2
                );
                var offeringList = new List<IItemStack>();
                for offeringEntity in targetList {
                    offeringList.add(offeringEntity.item.definition.defaultInstance);
                }
                if (<item:crockpot:taffy> in offeringList &&
                    <item:farmersdelight:sweet_berry_cheesecake> in offeringList &&
                    <item:crockpot:pow_cake> in offeringList) {
                    
                    // Sacrifice the offerings
                    for offering in targetList {
                        offering.remove();
                    }
                    item.mutable().shrink();

                    // Ritual itself
                    var firstStageBossMob as MCLivingEntity = <entitytype:minecraft:wither_skeleton>.create(world) as MCLivingEntity;
                    firstStageBossMob.updateData(
                        {
                            "CustomName": "\"\u00A78\u00A7l\u9634\u5F71\u4E2D\u7684\u5C01\u5370\u5B88\u536B\u8005 - \u00A76\u00A7l\u9B45\"",
                            "pehkui:scale_data_types": {
                                "pehkui:width": {
                                    "initial":0.7,
                                    "scale":0.7,
                                    "target":0.7
                                },
                                "pehkui:height": {
                                    "initial":0.7,
                                    "scale":0.7,
                                    "target":0.7
                                },
                                "pehkui:motion": {
                                    "initial":3.3,
                                    "scale":3.3,
                                    "target":3.3
                                }
                            },
                            "ForgeData": {
                                "BossMob": true,
                                "SummonerName": player.name as string,
                                "SummonerUUID": player.getUUID()
                            }                                       
                        }
                    );
                    firstStageBossMob.setItemStackToSlot(MCEquipmentSlotType.MAINHAND, <item:minecraft:bow>);
                    firstStageBossMob.setRevengeTarget(player);
                    
                    // Attribute
                    // Max Health
                    var healthAttribute as AttributeInstance? = firstStageBossMob.getAttribute(<attribute:minecraft:generic.max_health>);
                    if (healthAttribute != null) {
                        var nonnullHealthAttribute as AttributeInstance = healthAttribute as AttributeInstance;
                        nonnullHealthAttribute.applyPersistentModifier(
                            AttributeModifier.create(
                                "BossMob Health Modifier", 100.0 as double, AttributeOperation.ADDITION
                            )
                        );
                    }

                    // Set health to full
                    firstStageBossMob.setHealth(firstStageBossMob.getMaxHealth());

                    firstStageBossMob.setPositionAndUpdate(
                        (world.random.nextInt(11) - 5 + player.position.x),
                        (115 + world.random.nextInt(11)), 
                        (world.random.nextInt(11) - 5 + player.position.z)
                    );
                    if (world.addEntity(firstStageBossMob)) {
                        firstStageBossMob.addPotionEffect(<effect:minecraft:slow_falling>.newInstance(40 * seconds, 1 + levels));

                        player.teleportKeepLoaded(player.position.x, 160, player.position.z);
                        player.addPotionEffect(<effect:minecraft:slow_falling>.newInstance(20 * seconds, 1 + levels));
                        player.sendMessage("\u00A7c\u00A7l*-----------------*");
                        player.sendMessage("\u00A7c\u00A7l|-(\u5B88\u5173\u51F6\u517D\u5DF2\u91CA\u653E)-|");
                        player.sendMessage("\u00A7c\u00A7l*-----------------*");
                        world.asServerWorld().server.executeCommand("execute at " + player.name as string + " run playsound minecraft:item.totem.use player " + player.name as string, true);
                        
                        player.sendMessage("\u00A7l[\u00A76\u00A7l\u9B45\u00A7f\u00A7l]\u00A7r: \u6211\u662F\u9B45\uFF0C\u9634\u5F71\u4E2D\u7684\u5C01\u5370\u5B88\u536B\u8005\uFF0C\u5B88\u536B\u7B2C\u4E00\u9053\u5C01\u5370\u3002\u8BF7\u5728\u65E0\u5C3D\u7684\u5E7B\u5F71\u4E4B\u4E2D\u627E\u51FA\u6211\u5E76\u51FB\u8D25\u6211\u5427\u3002");

                        // Change summoner into Boss-combat mode
                        player.updatePersistentData({"BeingInBossStage": true});
                        
                        // Storage boss mobs uuid
                        var bossEntitiesUUIDList as stdlib.List<StringData> = new List<StringData>();
                        var uuidData as StringData = new StringData(firstStageBossMob.uuid);
                        var bossEntitiesUUIDListData as ListData = new ListData();
                        bossEntitiesUUIDListData.add(uuidData);
                        player.updatePersistentData(
                            {
                                "BossStageOne": {
                                    "BossEntitiesUUID": bossEntitiesUUIDListData
                                }
                            }
                        );
                    }
                }
            } else {
                player.sendMessage("\u00A7c\u00A7l\u4F60\u5C1A\u672A\u7ED3\u675F\u4E0E\u5B88\u5173\u51F6\u517D\u7684\u6218\u6597\uFF0C\u6B64\u65F6\u65E0\u6CD5\u8FDB\u884C\u53EC\u5524\u4EEA\u5F0F");
            }
        } else {
                player.sendMessage("\u00A7c\u00A7l\u4F60\u5904\u5728\u548C\u5E73\u96BE\u5EA6\uFF0C\u6B64\u65F6\u65E0\u6CD5\u8FDB\u884C\u53EC\u5524\u4EEA\u5F0F");
        }
    }
});