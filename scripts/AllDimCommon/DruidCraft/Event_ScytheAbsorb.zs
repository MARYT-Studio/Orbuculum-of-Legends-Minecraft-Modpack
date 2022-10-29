import crafttweaker.api.events.CTEventManager;
import crafttweaker.api.event.entity.player.MCItemPickupEvent;
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
<item:minecraft:wheat_seeds>|
<item:minecraft:carrot>|
<item:minecraft:potato>|
<item:minecraft:poisonous_potato>|
<item:minecraft:beetroot>|
<item:minecraft:wheat>|
<item:minecraft:sugar_cane>|
<item:druidcraft:hemp>;

CTEventManager.register<MCItemPickupEvent>(event => {
    if(event.player != null && !event.player.sneaking && plantDrops.contains(event.stack)) {
        var mainhandItem = event.player.getHeldItem(MCHand.MAIN_HAND).definition.defaultInstance;
        if(mainhandItem in scythes[0]) {
            var player as MCPlayerEntity = event.player;
            var pos = player.position;
            var pos1 = pos.add(new BlockPos(-3, -1, -3));
            var pos2 = pos.add(new BlockPos(3, 1, 3));
            var targetList as List<MCItemEntity> = player.world.getEntitiesInAreaExcluding(
                player, 
                (entityIn) => (entityIn is MCItemEntity && plantDrops.contains((entityIn as MCItemEntity).item)),
                pos1,
                pos2
            );
            var message = "\u5B83\u4EEC\u5206\u522B\u662F\uFF1A";
            message += ("" + event.stack.amount + "\u4E2A" + event.stack.displayName + ", ");
            for target in targetList {
                var item = target.item;
                var amount = "" + item.amount;
                var dispName = item.displayName;
                message += (amount + "\u4E2A" + dispName + ", ");
                target.remove();
                player.give(item);
            }
            player.sendMessage("\u4F60\u6325\u821E\u9570\u5200\uFF0C\u6536\u83B7\u4E863\u6B65\u4E4B\u5185\u7684\u4F5C\u7269\u3002");
            player.sendMessage(message[0 .. (message.length - 2)]);
        }
        else if(mainhandItem in scythes[1]) {
            var player as MCPlayerEntity = event.player;
            var pos = player.position;
            var pos1 = pos.add(new BlockPos(-7, -1, -7));
            var pos2 = pos.add(new BlockPos(7, 1, 7));
            var targetList as List<MCItemEntity> = player.world.getEntitiesInAreaExcluding(
                player, 
                (entityIn) => (entityIn is MCItemEntity && plantDrops.contains((entityIn as MCItemEntity).item)),
                pos1,
                pos2
            );
            var message = "\u5B83\u4EEC\u5206\u522B\u662F\uFF1A";
            message += ("" + event.stack.amount + "\u4E2A" + event.stack.displayName + ", ");
            for target in targetList {
                var item = target.item;
                var amount = "" + item.amount;
                var dispName = item.displayName;
                message += (amount + "\u4E2A" + dispName + ", ");
                target.remove();
                player.give(item);
            }
            event.player.sendMessage("\u4F60\u6325\u821E\u9570\u5200\uFF0C\u6536\u83B7\u4E867\u6B65\u4E4B\u5185\u7684\u4F5C\u7269\u3002");
            player.sendMessage(message[0 .. (message.length - 2)]);
        }
    }
});