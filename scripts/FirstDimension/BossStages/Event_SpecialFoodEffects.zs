import crafttweaker.api.events.CTEventManager;
import crafttweaker.api.event.entity.living.MCLivingEntityUseItemFinishEvent;
import crafttweaker.api.player.MCPlayerEntity;
import crafttweaker.api.item.IItemStack;

val specialFoods as IItemStack[] = [
    // This food is High-Heal-High-CD.
    // Bone Stew heals 4 hearts at normal, now we add addtional 3 hearts.
    <item:crockpot:bone_stew>,
    // This food is Instant-Heal.
    // Mixed Salad heals 1 heart at normal, now we add addtional 3 hearts.
    <item:farmersdelight:mixed_salad>
];

val hearts as float = 2.0f;

CTEventManager.register<MCLivingEntityUseItemFinishEvent>(event => {
    var entity = event.entityLiving;
    if (!entity.world.remote && entity is MCPlayerEntity) {
        var player = entity as MCPlayerEntity;
        if (specialFoods[0].matches(event.item)) {
            player.heal(3 * hearts);
            player.world.asServerWorld().server.executeCommand("execute at " + player.name as string + " run playsound minecraft:entity.player.levelup player " + player.name as string, true);
        } else if (specialFoods[1].matches(event.item)) {
            player.heal(3 * hearts);
        }
    }
});