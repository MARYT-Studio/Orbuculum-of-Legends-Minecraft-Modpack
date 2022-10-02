#loader crafttweaker
import crafttweaker.api.util.ActionResultType;
import crafttweaker.api.item.UseAction;
import crafttweaker.api.player.MCPlayerEntity;

import mods.contenttweaker.item.advance.CoTItemAdvanced;

import crafttweaker.api.util.Random;

// 1 second = 20 ticks
val second as int = 20;

val medics as CoTItemAdvanced[] = [
    <advanceditem:moss_clump>,
    <advanceditem:crude_plaster>
];

// Each array element has four float elements:
// index 0: maximum heal amount.
// index 1: max-heal probability.
// index 2: minimum heal amount.
// index 3: min-heal probability.
// We will roll a random number between 0 and 1.
// If it is less than index 1, then heal the player with index 0.
// If it is greater than index 1, but less than index1 + index 3, then heal the player with index 2.
// Otherwise, heal the player with 0 heart.
val heals as float[][] = [
    [4.0, 0.1, 2.0, 0.3],
    [3.0, 0.3, 1.0, 0.6]
];

var index as int = 0;

for medic in medics{
    medic.setItemUseAction((stack) => {
        return UseAction.CROSSBOW;
    }).setOnItemRightClick((item, playerEntity, world, hand) => {
        var rand = world.random;
        if(rand.nextBoolean() && rand.nextBoolean()) {
            playerEntity.sendMessage("\u8FD9\u4E2A\u4E1C\u897F\u53EF\u4EE5\u7528\u4E8E\u7597\u4F24\u3002");
        }
        return ActionResultType.SUCCESS;
    }).setOnItemUseFinish((stack, worldIn, entityLiving) => {
        if(!(entityLiving is MCPlayerEntity)) {
            return stack;
        }
        var player as MCPlayerEntity = entityLiving as MCPlayerEntity;
        var roll as float = player.world.random.nextFloat();
        if (!(roll > heals[index][1])) {
            // We heal in hearts, not in points, so we double the points to get hearts. 
            player.heal(2.0 * heals[index][0]);
            player.world.asServerWorld().server.executeCommand("execute at " + player.name as string + " run playsound minecraft:entity.player.levelup player " + player.name as string, true);
            player.sendMessage("\u55EF\uFF0C\u6548\u679C\u4E0D\u9519\u3002");
        } else {
            if (!(roll > (heals[index][1] + heals[index][3]))) {
                // We heal in hearts, not in points, so we double the points to get hearts.
                player.heal(2.0 * heals[index][2]);
                player.world.asServerWorld().server.executeCommand("execute at " + player.name as string + " run playsound minecraft:block.wool.place block " + player.name as string, true);
                player.sendMessage("\u5636... \u597D\u50CF\u597D\u4E9B\u4E86\u3002");
            }
        }        
        return stack.mutable().shrink();
    });
}