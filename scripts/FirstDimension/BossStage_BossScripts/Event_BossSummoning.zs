import crafttweaker.api.events.CTEventManager;
import crafttweaker.api.event.entity.player.interact.MCRightClickItemEvent;

import crafttweaker.api.entity.MCItemEntity;
import crafttweaker.api.item.IItemStack;

import crafttweaker.api.player.MCPlayerEntity;

import crafttweaker.api.util.BlockPos;

import stdlib.List;

import crafttweaker.api.potion.MCPotion;
import crafttweaker.api.potion.MCPotionEffect;
import crafttweaker.api.potion.MCPotionEffectInstance;

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
            player.teleportKeepLoaded(player.position.x, 160, player.position.z);
            player.addPotionEffect(<effect:minecraft:slow_falling>.newInstance(20 * seconds, 1 + levels));
            player.sendMessage("§c§l*-----------------*");
            player.sendMessage("§c§l|-(守关凶兽已释放)-|");
            player.sendMessage("§c§l*-----------------*");
            player.updatePersistentData({"BeingInBossStage": true});
        }
    }
});