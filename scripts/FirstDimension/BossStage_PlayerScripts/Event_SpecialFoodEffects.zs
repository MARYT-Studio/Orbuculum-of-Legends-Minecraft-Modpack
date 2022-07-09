import crafttweaker.api.events.CTEventManager;
import crafttweaker.api.event.entity.living.MCLivingEntityUseItemFinishEvent;
import crafttweaker.api.player.MCPlayerEntity;
import crafttweaker.api.item.IItemStack;

import crafttweaker.api.potion.MCPotion;
import crafttweaker.api.potion.MCPotionEffect;
import crafttweaker.api.potion.MCPotionEffectInstance;

import crafttweaker.api.data.IData;
import crafttweaker.api.data.MapData;

val specialFoods as IItemStack[] = [
    <item:crockpot:bone_stew>,
    <item:farmersdelight:mixed_salad>,
    <item:farmersdelight:cabbage_rolls>,
    <item:crockpot:salsa>
];

val hearts as float = 2.0f;
val seconds as int = 20;
val levels as int = -1;

CTEventManager.register<MCLivingEntityUseItemFinishEvent>(event => {
    var entity = event.entityLiving;
    if (!entity.world.remote && entity is MCPlayerEntity) {
        var player = entity as MCPlayerEntity;
        var bossStage as IData? = player.data.getData<MapData>("ForgeData").getData<MapData>("PlayerPersisted").getAt("BeingInBossStage");
        if (bossStage != null && bossStage.asBoolean()) {
            if (specialFoods[0].matches(event.item)) {
                player.heal(5 * hearts);
                player.world.asServerWorld().server.executeCommand("execute at " + player.name as string + " run playsound minecraft:entity.player.levelup player " + player.name as string, true);
            } else if (specialFoods[1].matches(event.item)) {
                player.heal(3 * hearts);
                player.addPotionEffect(<effect:minecraft:regeneration>.newInstance(20 * seconds, 1 + levels));
                player.addPotionEffect(<effect:minecraft:hunger>.newInstance(75 * seconds, 5 + levels));
            } else if (specialFoods[2].matches(event.item)) {
                player.addPotionEffect(<effect:minecraft:speed>.newInstance(45 * seconds, 1 + levels));
                player.addPotionEffect(<effect:minecraft:jump_boost>.newInstance(45 * seconds, 3 + levels));
                player.addPotionEffect(<effect:minecraft:hunger>.newInstance(45 * seconds, 6 + levels));
            } else if (specialFoods[3].matches(event.item)) {
                player.addPotionEffect(<effect:minecraft:speed>.newInstance(60 * seconds, 1 + levels));
                player.addPotionEffect(<effect:minecraft:night_vision>.newInstance(60 * seconds, 1 + levels));
                player.addPotionEffect(<effect:minecraft:jump_boost>.newInstance(45 * seconds, 6 + levels));
                player.addPotionEffect(<effect:minecraft:strength>.newInstance(10 * seconds, 1 + levels));
            }
        }
    }
});