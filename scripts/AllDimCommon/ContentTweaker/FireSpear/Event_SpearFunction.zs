import crafttweaker.api.events.CTEventManager;
import crafttweaker.api.event.entity.living.MCLivingHurtEvent;
import crafttweaker.api.entity.MCLivingEntity;
import crafttweaker.api.entity.MCEntity;
import crafttweaker.api.util.MCHand;

val seconds as int = 20;

CTEventManager.register<MCLivingHurtEvent>(event => {
     if (!event.entityLiving.world.remote) {
          var source as MCEntity? = event.source.trueSource;
          if (source != null && source is MCLivingEntity) {
               // Data Type Magic
               var entity = event.entityLiving;
               var sourceNonNull = source as MCEntity;
               var trueSource = sourceNonNull as MCLivingEntity;

               if (!entity.isImmuneToFire() && <item:contenttweaker:fire_spear>.matches(trueSource.getHeldItem(MCHand.MAIN_HAND).definition.defaultInstance)) {
                    if (entity.world.random.nextBoolean()) {entity.forceFireTicks(5 * seconds);}
               }
          }
     }
});