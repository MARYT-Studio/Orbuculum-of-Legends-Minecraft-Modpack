// This script will PREVENT all DannysExpansion mobs from spawning in the 1st Dimension.
import crafttweaker.api.events.CTEventManager;
import crafttweaker.api.event.entity.MCEntityJoinWorldEvent;

CTEventManager.register<crafttweaker.api.event.entity.MCEntityJoinWorldEvent>((event) => {
 var dimension as string = event.entity.world.dimension;
 var entityName = event.entity.type.registryName;
 if(("dannys_expansion" in entityName.namespace) && dimension == "minecraft:overworld") {
     event.cancel();
 }
 });