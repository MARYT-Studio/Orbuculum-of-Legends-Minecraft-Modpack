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

import crafttweaker.api.util.MCHand;

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
                        // Original Text: §8§l阴影中的封印守卫者 - §6§l魅
                        "CustomName": "\"\u00a7\u0038\u00a7\u006c\u9634\u5f71\u4e2d\u7684\u5c01\u5370\u5b88\u536b\u8005\u0020\u002d\u0020\u00a7\u0036\u00a7\u006c\u9b45\"",
                        "pehkui:scale_data_types": {
                            "pehkui:width": {
                                "initial":2.2,
                                "scale":2.2,
                                "target":2.2
                            },
                            "pehkui:height": {
                                "initial":2.2,
                                "scale":2.2,
                                "target":2.2
                            },
                            "pehkui:motion": {
                                "initial":3.0,
                                "scale":3.0,
                                "target":3.0
                            }
                        },
                        "ForgeData": {
                            "BossMob": true,
                            "SummonerName": player.name as string,
                            "SummonerUUID": player.getUUID()
                        }                                       
                    }
                );
                firstStageBossMob.setHeldItem(MCHand.MAIN_HAND, <item:minecraft:bow>);
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
                    player.sendMessage("§c§l*-----------------*");
                    player.sendMessage("§c§l|-(守关凶兽已释放)-|");
                    player.sendMessage("§c§l*-----------------*");
                    world.asServerWorld().server.executeCommand("execute at " + player.name as string + " run playsound minecraft:item.totem.use player " + player.name as string, true);
                    
                    // Original text: §l[§6§l魅§f§l]§r: 我是魅，阴影中的封印守卫者，守卫第一道封印。请在无尽的幻影之中找出我并击败我吧。
                    player.sendMessage("\u00A7l[\u00A76\u00A7l\u9b45\u00A7f\u00A7l]\u00A7r: \u6211\u662f\u9b45\uff0c\u9634\u5f71\u4e2d\u7684\u5c01\u5370\u5b88\u536b\u8005\uff0c\u5b88\u536b\u7b2c\u4e00\u9053\u5c01\u5370\u3002\u8bf7\u5728\u65e0\u5c3d\u7684\u5e7b\u5f71\u4e4b\u4e2d\u627e\u51fa\u6211\u5e76\u51fb\u8d25\u6211\u5427\u3002");

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
            // Original text: §c§l你尚未结束与守关凶兽的战斗，此时无法进行召唤仪式
            player.sendMessage("\u00A7c\u00A7l\u4f60\u5c1a\u672a\u7ed3\u675f\u4e0e\u5b88\u5173\u51f6\u517d\u7684\u6218\u6597\uff0c\u6b64\u65f6\u65e0\u6cd5\u8fdb\u884c\u53ec\u5524\u4eea\u5f0f");
        }
    }
});