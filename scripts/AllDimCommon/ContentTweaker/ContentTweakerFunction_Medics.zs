#loader crafttweaker
import crafttweaker.api.util.ActionResultType;
import crafttweaker.api.item.UseAction;
import crafttweaker.api.player.MCPlayerEntity;

val second as int = 20;
// <advanceditem:moss_clump>
// <advanceditem:crude_plaster>

<advanceditem:moss_clump>.setItemUseAction((stack) => {
        return UseAction.CROSSBOW;
    }).setOnItemRightClick((item, playerEntity, world, hand) => {
        var rand = world.random;
        if(rand.nextBoolean() && rand.nextBoolean()) {
            playerEntity.sendMessage("这个东西可以用于疗伤。");
        }
        return ActionResultType.SUCCESS;
    }).setUsingTick((stack, player, count) => {
        if(count == 3 * second) {return;}
    }).setOnItemUseFinish((stack, worldIn, entityLiving) => {
        if(!(entityLiving is MCPlayerEntity)) {
            return stack;
        }
        var player as MCPlayerEntity = entityLiving as MCPlayerEntity;
        if(!player.world.remote) {player.sendMessage("嘶... 好像好些了。");}
        return stack.mutable().shrink();
    });
