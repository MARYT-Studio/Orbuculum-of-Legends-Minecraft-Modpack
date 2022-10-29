import crafttweaker.api.events.CTEventManager;
import crafttweaker.api.event.entity.player.interact.MCRightClickBlockEvent;
import crafttweaker.api.player.MCPlayerEntity;
import crafttweaker.api.tileentity.MCTileEntity;
import crafttweaker.api.data.IData;
import crafttweaker.api.data.MapData;
import crafttweaker.api.data.ListData;
import stdlib.List;

CTEventManager.register<MCRightClickBlockEvent>((event) => {
    var playerNullable as MCPlayerEntity? = event.player;
    if (playerNullable == null) return;

    var player as MCPlayerEntity = playerNullable;
    var world = player.world;
    if (world.remote) return;

    var pos = event.blockPos;
    var blockState = world.getBlockState(pos);
    if <block:tropicraft:drink_mixer>.matchesBlock(blockState.block) {
        var mixerTileEntityNullable as MCTileEntity? = world.getTileEntity(pos);
        if (mixerTileEntityNullable != null) {
            var data  = mixerTileEntityNullable.data;
            var ingredient0 as IData? = data.getAt("Ingredient0");
            if (ingredient0 == null) return;
            var ingredient1 as IData? = data.getAt("Ingredient1");
            if (ingredient1 == null) return;
            var ingredient2 as IData? = data.getAt("Ingredient2");
            if (ingredient2 == null) return;
            
            var ingredientMap0 as IData[string] = ingredient0.asMap();
            var ingredientMap1 as IData[string] = ingredient1.asMap();
            var ingredientMap2 as IData[string] = ingredient2.asMap();

            var ingrNames = new List<string>();

            ingrNames.add(ingredientMap0["id"].getString());
            ingrNames.add(ingredientMap1["id"].getString());
            ingrNames.add(ingredientMap2["id"].getString());
            
            for ingr in ingrNames {
                player.sendMessage(ingr);
            }
        }
    }
});