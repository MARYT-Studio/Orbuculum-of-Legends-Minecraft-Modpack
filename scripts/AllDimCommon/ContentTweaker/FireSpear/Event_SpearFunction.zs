import crafttweaker.api.events.CTEventManager;
import crafttweaker.api.event.entity.living.MCLivingHurtEvent;
import crafttweaker.api.player.MCPlayerEntity;
import crafttweaker.api.entity.MCLivingEntity;
import crafttweaker.api.entity.MCEntity;
import crafttweaker.api.util.MCHand;
import crafttweaker.api.data.MapData;
import crafttweaker.api.util.DamageSourceHelper;
import crafttweaker.api.util.text.MCTextComponent;

val seconds as int = 20;
val bossDamageBonus as float = 6.0;
val bossFollowerDamageBonus as float = 8.0;

CTEventManager.register<MCLivingHurtEvent>(event => {
     var source as MCEntity? = event.source.trueSource;
     if (source != null && source is MCLivingEntity) {
          // Data Type Magic
          var entity = event.entityLiving;
          var sourceNonNull as MCEntity = source as MCEntity;
          var trueSource as MCLivingEntity = sourceNonNull as MCLivingEntity;
          if (<item:contenttweaker:fire_spear>.matches(trueSource.getHeldItem(MCHand.MAIN_HAND).definition.defaultInstance)) {
               var data = entity.data;
               if (data.contains("ForgeData")) {
                    var entityNameArray as string[] = entity.type.translationKey.split(".");
                    if ("minecraft" in entityNameArray && "wither_skeleton" in entityNameArray) {     
                         var health as float = entity.getHealth();
                         if ((data.getData<MapData>("ForgeData") as MapData).contains("BossMob")) {
                              if (health >= bossDamageBonus + 1.0) {entity.setHealth(health - bossDamageBonus);}
                              (trueSource as MCPlayerEntity).sendMessage("\u00A77\u00A7o\u8FD9\u662F... \u4E09\u6627\u771F\u706B\u5417\uFF01");
                              return;
                         } else if ((data.getData<MapData>("ForgeData") as MapData).contains("BossFollower")) {
                              if (health >= bossFollowerDamageBonus + 1.0) {entity.setHealth(health - bossFollowerDamageBonus);}
                              (trueSource as MCPlayerEntity).sendMessage("\u00A77\u00A7o\u8FD9\u662F... \u4E09\u6627\u771F\u706B\u5417\uFF01");
                              return;
                         } 
                    } 
               } 
               if (!entity.isImmuneToFire() && entity.world.random.nextBoolean()) {entity.forceFireTicks(5 * seconds);}
          }
     }
});
