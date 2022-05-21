import crafttweaker.api.events.CTEventManager;
import crafttweaker.api.event.block.MCBlockBreakEvent;
import crafttweaker.api.util.MCHand;

import crafttweaker.api.player.MCPlayerEntity;
import crafttweaker.api.entity.MCLivingEntity;
import crafttweaker.api.entity.MCItemEntity;

import crafttweaker.api.item.IItemStack;
import crafttweaker.api.util.BlockPos;

import stdlib.List;

val scythes as IItemStack[][] = [
    // Tier 1 scythes
    [
        <item:druidcraft:bone_sickle>,
        <item:druidcraft:wooden_sickle>,
        <item:druidcraft:stone_sickle>,
        <item:druidcraft:iron_sickle>,
        <item:druidcraft:gold_sickle>
    ],
    // Tier 2 scythes
    [
        <item:druidcraft:moonstone_sickle>,
        <item:druidcraft:diamond_sickle>
    ]
];

val plantDrops = <tag:items:minecraft:saplings>|
<item:crockpot:asparagus_seeds>|
<item:minecraft:beetroot_seeds>|
<item:farmersdelight:cabbage>|
<item:farmersdelight:cabbage_seeds>|
<item:crockpot:corn_seeds>|
<item:crockpot:eggplant_seeds>|
<item:druidcraft:hemp_seeds>|
<item:minecraft:kelp>|
<item:minecraft:melon_seeds>|
<item:contenttweaker:moss_clump>|
<item:farmersdelight:onion>|
<item:crockpot:onion_seeds>|
<item:crockpot:pepper_seeds>|
<item:minecraft:pumpkin_seeds>|
<item:farmersdelight:rice>|
<item:farmersdelight:rice_panicle>|
<item:minecraft:stick>|
<item:minecraft:sugar_cane>|
<item:farmersdelight:tomato>|
<item:crockpot:tomato_seeds>|
<item:farmersdelight:tomato_seeds>|
<item:crockpot:unknown_seeds>|
<item:minecraft:wheat_seeds>;

CTEventManager.register<MCBlockBreakEvent>(event => {
    var mainhandItem = event.player.getHeldItem(MCHand.MAIN_HAND).definition.defaultInstance;
    if(mainhandItem in scythes[0]) {
        var player = event.player;
        var pos = player.position;
        var pos1 = pos.add(new BlockPos(-3, -1, -3));
        var pos2 = pos.add(new BlockPos(3, 1, 3));
        var targetList as List<MCItemEntity> = event.world.getEntitiesInAreaExcluding(
            player, 
            (entityIn) => (entityIn is MCItemEntity && plantDrops.contains((entityIn as MCItemEntity).item)),
            pos1,
            pos2
        );
        // Original text: 你挥舞镰刀，收获了3步之内的作物。
        player.sendMessage("\u4f60\u6325\u821e\u9570\u5200\uff0c\u6536\u83b7\u4e863\u6b65\u4e4b\u5185\u7684\u4f5c\u7269\u3002");
        // Original text: 它们分别是：
        var message = "\u5b83\u4eec\u5206\u522b\u662f\uff1a";
        for target in targetList {
            var item = target.item;
            var amount = "" + item.amount;
            var dispName = item.displayName;
            // Original text: amount 个 dispName, 
            message += (amount + "\u4e2a" + dispName + ", ");
            target.remove();
            player.give(item);
        }
        player.sendMessage(message[0 .. (message.length - 2)]);
    } else if(mainhandItem in scythes[1]) {
        var player = event.player;
        var pos = player.position;
        var pos1 = pos.add(new BlockPos(-7, -1, -7));
        var pos2 = pos.add(new BlockPos(7, 1, 7));
        var targetList as List<MCItemEntity> = event.world.getEntitiesInAreaExcluding(
            player, 
            (entityIn) => (entityIn is MCItemEntity && plantDrops.contains((entityIn as MCItemEntity).item)),
            pos1,
            pos2
        );
        // Original text: 你挥舞镰刀，收获了7步之内的作物。
        event.player.sendMessage("\u4f60\u6325\u821e\u9570\u5200\uff0c\u6536\u83b7\u4e867\u6b65\u4e4b\u5185\u7684\u4f5c\u7269\u3002");
        // Original text: 它们分别是：
        var message = "\u5b83\u4eec\u5206\u522b\u662f\uff1a";
        for target in targetList {
            var item = target.item;
            var amount = "" + item.amount;
            var dispName = item.displayName;
            // Original text: amount 个 dispName, 
            message += (amount + "\u4e2a" + dispName + ", ");
            target.remove();
            player.give(item);
        }
        player.sendMessage(message[0 .. (message.length - 2)]);
    }
});